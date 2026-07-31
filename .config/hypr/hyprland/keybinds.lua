-- Keybindings
require("hyprland.variables")

-- Window Management
hl.bind("ALT + F4", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.float())
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.resize({ x = -50, y = 0 }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = 50, y = 0 }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.resize({ x = 0, y = -50 }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.resize({ x = 0, y = 50 }), { repeating = true })
hl.bind(mainMod .. " + CTRL + left", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + CTRL + up", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + CTRL + down", hl.dsp.window.move({ direction = "d" }))
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "d" }))

-- Applications & Launchers
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("nautilus"))

-- Quickshell Controls
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("bash ~/.config/hypr/scripts/reload.sh"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("~/.config/hypr/scripts/qs_manager.sh toggle clipboard"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("~/.config/hypr/scripts/qs_manager.sh toggle movies"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("bash ~/.config/hypr/scripts/qs_manager.sh toggle applauncher"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("bash ~/.config/hypr/scripts/qs_manager.sh toggle settings"))
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("bash ~/.config/hypr/scripts/qs_manager.sh toggle music"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("bash ~/.config/hypr/scripts/qs_manager.sh toggle battery"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("bash ~/.config/hypr/scripts/qs_manager.sh toggle wallpaper"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("bash ~/.config/hypr/scripts/qs_manager.sh toggle calendar"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("bash ~/.config/hypr/scripts/qs_manager.sh toggle network"))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("bash ~/.config/hypr/scripts/qs_manager.sh toggle focustime"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("bash ~/.config/hypr/scripts/qs_manager.sh toggle volume"))
hl.bind(mainMod .. " + H", hl.dsp.exec_cmd("bash ~/.config/hypr/scripts/qs_manager.sh toggle guide"))

-- System & Hardware
hl.bind("Caps_Lock", hl.dsp.exec_cmd("sleep 0.1 && swayosd-client --caps-lock"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("swayosd-client --brightness lower"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("swayosd-client --brightness raise"), { locked = true, repeating = true })
hl.bind("Print", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh"), { locked = true })
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh --edit"), { locked = true })
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh --full"), { locked = true })
hl.bind(mainMod .. " + SHIFT + Print", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh --full --edit"), { locked = true })
hl.bind("XF86PowerOff", hl.dsp.exec_cmd("bash ~/.config/hypr/scripts/lock.sh"), { locked = true })
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("bash ~/.config/hypr/scripts/lock.sh"), { locked = true, repeating = true })

-- Media & Audio
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("xf86AudioMicMute", hl.dsp.exec_cmd("swayosd-client --input-volume mute-toggle"), { locked = true })
hl.bind("xf86audiomute", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), { locked = true })
hl.bind("xf86audiolowervolume", hl.dsp.exec_cmd("swayosd-client --output-volume lower"), { locked = true, repeating = true })
hl.bind("xf86audioraisevolume", hl.dsp.exec_cmd("swayosd-client --output-volume raise"), { locked = true, repeating = true })

-- Workspaces
for i = 1, 9 do
  hl.bind(mainMod .. " + " .. i, hl.dsp.exec_cmd("~/.config/hypr/scripts/qs_manager.sh " .. i))
  hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.exec_cmd("~/.config/hypr/scripts/qs_manager.sh " .. i .. " move"))
end
hl.bind(mainMod .. " + 0", hl.dsp.exec_cmd("~/.config/hypr/scripts/qs_manager.sh 10"))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.exec_cmd("~/.config/hypr/scripts/qs_manager.sh 10 move"))

-- Monitor
hl.bind(mainMod .. " + TAB", hl.dsp.exec_cmd("~/.config/hypr/scripts/focus_next_monitor.sh"))
