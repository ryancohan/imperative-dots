-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--  ◈ AUTOSTART
--  Note: Startup commands are now managed through settings.json (Config.qml)
--  This file is kept for backward compatibility and manual overrides
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

exec_once = {
  "systemctl --user start hyprpolkitagent",
  "awww-daemon",
  "hypridle",
  "quickshell -p ~/.config/hypr/scripts/quickshell/Main.qml",
  "quickshell -p ~/.config/hypr/scripts/quickshell/TopBar.qml",
  "quickshell -p ~/.config/hypr/scripts/quickshell/Floating.qml",
  "python3 ~/.config/hypr/scripts/quickshell/focustime/focus_daemon.py &",
  "~/.config/hypr/scripts/init.sh",
  "~/.config/hypr/scripts/settings_watcher.sh &",
  "~/.config/hypr/scripts/qs_manager.sh toggle guide &",
  "playerctld",
  "swayosd-server --top-margin 0.9 --style \"$HOME/.config/swayosd/style.css\"",
  "wl-paste --type text --watch cliphist store",
  "wl-paste --type image --watch cliphist store",
  "~/.config/hypr/scripts/volume_listener.sh",
  "~/.config/hypr/scripts/update_notifier.sh",
}
