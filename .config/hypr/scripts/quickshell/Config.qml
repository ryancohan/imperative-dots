pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: config

    // =========================================================================
    // Core Paths & Environment
    // =========================================================================
    readonly property string homeDir: Quickshell.env("HOME")
    readonly property string hyprDir: homeDir + "/.config/hypr"
    readonly property string qsScriptsDir: hyprDir + "/scripts/quickshell"
    readonly property string cacheDir: homeDir + "/.cache/quickshell"
    
    readonly property string settingsJsonPath: hyprDir + "/settings.json"
    readonly property string weatherEnvPath: qsScriptsDir + "/calendar/.env"

    // State Tracking
    property bool dataReady: false
    property var rawSettings: ({})
    property var rawEnvs: ({})

    // =========================================================================
    // Generic Utilities (Use these in ANY widget!)
    // =========================================================================

    // Execute a background bash command easily
    function sh(cmd) {
        Quickshell.execDetached(["bash", "-c", cmd]);
    }

    // --- JSON Operations ---
    function getSetting(key, fallbackValue) {
        return rawSettings.hasOwnProperty(key) ? rawSettings[key] : fallbackValue;
    }

    function setSetting(key, value) {
        // 1. Update local cache instantly
        rawSettings[key] = value;
        
        // 2. Format for bash (escape quotes safely)
        let safeValue = typeof value === "string" ? `"${value}"` : value;
        if (typeof value === "object") safeValue = JSON.stringify(value).replace(/'/g, "'\\''");

        // 3. Patch JSON using jq
        let cmd = `mkdir -p "$(dirname '${settingsJsonPath}')" && ` +
                  `[ ! -f '${settingsJsonPath}' ] && echo '{}' > '${settingsJsonPath}'; ` +
                  `jq '. + {"${key}": ${safeValue}}' '${settingsJsonPath}' > '${settingsJsonPath}.tmp' && ` +
                  `mv '${settingsJsonPath}.tmp' '${settingsJsonPath}'`;
        sh(cmd);
    }

    function updateJsonBulk(dataObj) {
        let jsonStr = JSON.stringify(dataObj).replace(/'/g, "'\\''");
        let cmd = `mkdir -p "$(dirname '${settingsJsonPath}')" && ` +
                  `[ ! -f '${settingsJsonPath}' ] && echo '{}' > '${settingsJsonPath}'; ` +
                  `jq '. + ${jsonStr}' '${settingsJsonPath}' > '${settingsJsonPath}.tmp' && ` +
                  `mv '${settingsJsonPath}.tmp' '${settingsJsonPath}'`;
        sh(cmd);
        
        // Update local cache
        for (let key in dataObj) rawSettings[key] = dataObj[key];
    }

    // --- Env Operations ---
    function getEnv(key, fallbackValue) {
        return rawEnvs.hasOwnProperty(key) ? rawEnvs[key] : fallbackValue;
    }

    function setEnv(filePath, key, value) {
        rawEnvs[key] = value;
        let safeVal = value.toString().replace(/'/g, "'\\''");
        let cmd = `mkdir -p "$(dirname '${filePath}')" && touch '${filePath}'; ` +
                  `if grep -q "^${key}=" '${filePath}'; then ` +
                  `sed -i "s|^${key}=.*|${key}='${safeVal}'|" '${filePath}'; ` +
                  `else echo "${key}='${safeVal}'" >> '${filePath}'; fi`;
        sh(cmd);
    }

    function updateEnvBulk(filePath, envDict) {
        let cmds = [`mkdir -p "$(dirname '${filePath}')"`, `touch '${filePath}'`];
        for (let key in envDict) {
            rawEnvs[key] = envDict[key];
            let safeVal = envDict[key].toString().replace(/'/g, "'\\''");
            cmds.push(`if grep -q "^${key}=" '${filePath}'; then ` +
                      `sed -i "s|^${key}=.*|${key}='${safeVal}'|" '${filePath}'; ` +
                      `else echo "${key}='${safeVal}'" >> '${filePath}'; fi`);
        }
        sh(cmds.join(" && "));
    }


    // =========================================================================
    // Legacy Specific Properties (Bound to Settings.qml)
    // =========================================================================
    property real uiScale: 1.0
    property bool openGuideAtStartup: true
    property bool topbarHelpIcon: true
    property int workspaceCount: 8
    property int initialWorkspaceCount: 8
    property string wallpaperDir: Quickshell.env("WALLPAPER_DIR") || (homeDir + "/Pictures/Wallpapers")
    property string language: ""
    property string kbOptions: "grp:alt_shift_toggle"

    property string weatherUnit: "metric"
    property string weatherApiKey: ""
    property string weatherCityId: ""

    property var keybindsData: []
    signal keybindsLoaded()

    property var startupData: []
    signal startupLoaded()

    property var hyprlandSettings: []
    signal hyprlandSettingsLoaded()


    // =========================================================================
    // Legacy Specific Functions (Bound to Settings.qml)
    // =========================================================================
    function saveAppSettings() {
        let configObj = {
            "uiScale": config.uiScale,
            "openGuideAtStartup": config.openGuideAtStartup,
            "topbarHelpIcon": config.topbarHelpIcon,
            "wallpaperDir": config.wallpaperDir,
            "language": config.language,
            "kbOptions": config.kbOptions,
            "workspaceCount": config.workspaceCount
        };

        config.updateJsonBulk(configObj);
        sh("notify-send 'Quickshell' 'Settings Applied Successfully!'");

        let patchCmd = config.openGuideAtStartup
            ? `sed -i 's|^#*[[:space:]]*exec-once = ~/.config/hypr/scripts/qs_manager.sh toggle guide.*|exec-once = ~/.config/hypr/scripts/qs_manager.sh toggle guide \\&|' "${config.hyprDir}/config/autostart.conf"`
            : `sed -i 's|^exec-once = ~/.config/hypr/scripts/qs_manager.sh toggle guide.*|# exec-once = ~/.config/hypr/scripts/qs_manager.sh toggle guide \\&|' "${config.hyprDir}/config/autostart.conf"`;
        sh(patchCmd);

        if (config.workspaceCount !== config.initialWorkspaceCount) {
            sh(`qs -p "${qsScriptsDir}/TopBar.qml" ipc call topbar queueReload`);
            config.initialWorkspaceCount = config.workspaceCount;
        }
    }

    function saveWeatherConfig() {
        let envs = {
            "OPENWEATHER_KEY": config.weatherApiKey,
            "OPENWEATHER_CITY_ID": config.weatherCityId,
            "OPENWEATHER_UNIT": config.weatherUnit
        };
        
        config.updateEnvBulk(config.weatherEnvPath, envs);
        sh(`rm -rf "${cacheDir}/weather"`);
        sh("notify-send 'Weather' 'API configuration saved successfully!'");
    }

    function saveAllKeybinds(bindsArray) {
        config.keybindsData = bindsArray;
        config.setSetting("keybinds", bindsArray);
        sh("notify-send 'Quickshell' 'Keybinds Saved Successfully!'");
    }

    function saveAllStartup(startupArray) {
        config.startupData = startupArray;
        config.setSetting("startup", startupArray);
        sh("notify-send 'Quickshell' 'Startup entries saved!'");
    }

    function saveHyprlandSettings(arr) {
        config.hyprlandSettings = arr;
        config.setSetting("hyprlandSettings", arr);
        sh("notify-send 'Quickshell' 'Hyprland settings saved!'");
    }

    function runAutostartMigrator() {
        autostartMigrator.running = false;
        autostartMigrator.running = true;
    }

    // =========================================================================
    // Boot Initialization (Runs once on start)
    // =========================================================================
    Component.onCompleted: {
        settingsReader.running = true;
        envReader.running = true;
        hyprLangReader.running = true;
    }

    Process {
        id: envReader
        command: ["bash", "-c", `cat "${config.weatherEnvPath}" 2>/dev/null || echo ''`]
        running: false
        stdout: StdioCollector {
            onStreamFinished: {
                let lines = this.text ? this.text.trim().split('\n') : [];
                for (let line of lines) {
                    line = line.trim();
                    let parts = line.split("=");
                    if (parts.length >= 2) {
                        let key = parts[0].trim();
                        let val = parts.slice(1).join("=").replace(/^['"]|['"]$/g, '').trim();
                        config.rawEnvs[key] = val;
                        
                        if (key === "OPENWEATHER_KEY") config.weatherApiKey = val;
                        else if (key === "OPENWEATHER_CITY_ID") config.weatherCityId = val;
                        else if (key === "OPENWEATHER_UNIT") config.weatherUnit = val;
                    }
                }
            }
        }
    }

    Process {
        id: hyprLangReader
        command: ["bash", "-c", `grep -m1 '^ *kb_layout *=' "${config.hyprDir}/hyprland.conf" | cut -d'=' -f2 | tr -d ' '`]
        running: false
        stdout: StdioCollector {
            onStreamFinished: {
                let out = this.text ? this.text.trim() : "";
                if (out.length > 0 && config.language === "") config.language = out;
            }
        }
    }

    Timer {
        id: guideAutostartSyncTimer
        interval: 300
        onTriggered: {
            autostartMigrator.running = false;
            autostartMigrator.running = true;
        }
    }

    Process {
        id: autostartMigrator
        command: ["bash", "-c", `grep -E '^\\s*exec-once\\s*=' "${config.hyprDir}/config/autostart.conf" 2>/dev/null | grep -v 'qs_manager.sh toggle guide' | sed 's/^\\s*exec-once\\s*=\\s*//'`]
        running: false
        stdout: StdioCollector {
            onStreamFinished: {
                let lines = this.text ? this.text.trim().split('\n') : [];
                let tempStartup = [];
                for (let line of lines) {
                    line = line.trim();
                    if (line.length > 0) tempStartup.push({ command: line });
                }
                config.startupData = tempStartup;
                config.saveAllStartup(tempStartup);
            }
        }
    }

    Process {
        id: hyprlandOptionsReader
        command: ["bash", "-c", `
            b=$(hyprctl getoption general:border_size 2>/dev/null | awk '/int:/{print $2}'); b=\${b:-2}
            gi=$(hyprctl getoption general:gaps_in 2>/dev/null | awk '/int:/{print $2}'); gi=\${gi:-4}
            go=$(hyprctl getoption general:gaps_out 2>/dev/null | awk '/int:/{print $2}'); go=\${go:-4}
            r=$(hyprctl getoption decoration:rounding 2>/dev/null | awk '/int:/{print $2}'); r=\${r:-4}
            fg=$(hyprctl getoption general:float_gaps 2>/dev/null | awk '/int:/{print $2}'); fg=\${fg:-6}
            rob=$(hyprctl getoption general:resize_on_border 2>/dev/null | awk '/int:/{print $2}')
            rob=$([ "\${rob:-1}" = "1" ] && echo "true" || echo "false")
            ebga=$(hyprctl getoption general:extend_border_grab_area 2>/dev/null | awk '/int:/{print $2}'); ebga=\${ebga:-30}
            ao=$(hyprctl getoption decoration:active_opacity 2>/dev/null | awk '/float:/{print $2}'); ao=\${ao:-1}
            io=$(hyprctl getoption decoration:inactive_opacity 2>/dev/null | awk '/float:/{print $2}'); io=\${io:-1}
            blur=$(hyprctl getoption decoration:blur:enabled 2>/dev/null | awk '/int:/{print $2}')
            blur=$([ "\${blur:-0}" = "0" ] && echo "false" || echo "true")
            shadow=$(hyprctl getoption decoration:shadow:enabled 2>/dev/null | awk '/int:/{print $2}')
            shadow=$([ "\${shadow:-0}" = "0" ] && echo "false" || echo "true")
            printf '[{"key":"general:border_size","value":%s},{"key":"general:gaps_in","value":%s},{"key":"general:gaps_out","value":%s},{"key":"decoration:rounding","value":%s},{"key":"general:float_gaps","value":%s},{"key":"general:resize_on_border","value":%s},{"key":"general:extend_border_grab_area","value":%s},{"key":"decoration:active_opacity","value":%s},{"key":"decoration:inactive_opacity","value":%s},{"key":"decoration:blur:enabled","value":%s},{"key":"decoration:shadow:enabled","value":%s}]' \
              "$b" "$gi" "$go" "$r" "$fg" "$rob" "$ebga" "$ao" "$io" "$blur" "$shadow"
        `]
        running: false
        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    let parsed = JSON.parse(this.text.trim());
                    if (Array.isArray(parsed) && parsed.length > 0) {
                        config.hyprlandSettings = parsed;
                        config.hyprlandSettingsLoaded();
                    }
                } catch(e) {}
            }
        }
    }

    Process {
        id: settingsReader
        command: ["bash", "-c", `cat "${config.settingsJsonPath}" 2>/dev/null || echo '{}'`]
        running: false
        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    if (this.text && this.text.trim().length > 0 && this.text.trim() !== "{}") {
                        config.rawSettings = JSON.parse(this.text);
                        
                        // Map explicitly defined properties
                        if (config.rawSettings.uiScale !== undefined) config.uiScale = config.rawSettings.uiScale;
                        if (config.rawSettings.openGuideAtStartup !== undefined) config.openGuideAtStartup = config.rawSettings.openGuideAtStartup;
                        if (config.rawSettings.topbarHelpIcon !== undefined) config.topbarHelpIcon = config.rawSettings.topbarHelpIcon;
                        if (config.rawSettings.wallpaperDir !== undefined) config.wallpaperDir = config.rawSettings.wallpaperDir;
                        if (config.rawSettings.language !== undefined && config.rawSettings.language !== "") config.language = config.rawSettings.language;
                        if (config.rawSettings.kbOptions !== undefined) config.kbOptions = config.rawSettings.kbOptions;
                        if (config.rawSettings.workspaceCount !== undefined) {
                            config.workspaceCount = config.rawSettings.workspaceCount;
                            config.initialWorkspaceCount = config.rawSettings.workspaceCount; 
                        }
                        
                        // Map Keybinds
                        if (config.rawSettings.keybinds !== undefined && Array.isArray(config.rawSettings.keybinds)) {
                            let tempBinds = [];
                            for (let k of config.rawSettings.keybinds) {
                                tempBinds.push({
                                    type: k.type || "bind",
                                    mods: k.mods || "",
                                    key: k.key || "",
                                    dispatcher: k.dispatcher || "exec",
                                    command: k.command || "",
                                    isEditing: false
                                });
                            }
                            config.keybindsData = tempBinds;
                        } else {
                            config.keybindsData = [];
                            config.saveAllKeybinds([]);
                        }

                        if (config.rawSettings.startup !== undefined && Array.isArray(config.rawSettings.startup)) {
                            let tempStartup = [];
                            for (let s of config.rawSettings.startup) {
                                tempStartup.push({ command: s.command || "" });
                            }
                            config.startupData = tempStartup;
                        } else {
                            config.startupData = [];
                            autostartMigrator.running = true;
                        }

                        if (config.rawSettings.hyprlandSettings !== undefined && Array.isArray(config.rawSettings.hyprlandSettings)) {
                            config.hyprlandSettings = config.rawSettings.hyprlandSettings;
                        } else {
                            hyprlandOptionsReader.running = true;
                        }
                    } else {
                        config.saveAppSettings();
                        config.keybindsData = [];
                        config.saveAllKeybinds([]);
                        config.startupData = [];
                        autostartMigrator.running = true;
                        hyprlandOptionsReader.running = true;
                    }
                } catch (e) {
                    console.log("Error parsing global settings:", e);
                    config.keybindsData = [];
                    config.startupData = [];
                    autostartMigrator.running = true;
                    hyprlandOptionsReader.running = true;
                }
                config.keybindsLoaded();
                config.startupLoaded();
                config.hyprlandSettingsLoaded();
                config.dataReady = true;
            }
        }
    }
}

