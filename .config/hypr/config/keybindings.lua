-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--  ◈ KEYBINDINGS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- Mouse & Gestures
gesture = {
  { fingers = 3, direction = "horizontal", action = "workspace" },
}

bindm = {
  { mods = "$mainMod", key = "mouse:272", action = "movewindow" },
  { mods = "$mainMod", key = "mouse:273", action = "resizewindow" },
}

-- Window Management
bind = {
  { mods = "ALT", key = "F4", action = "exec", arg = "hyprctl dispatch killactive" },
  { mods = "$mainMod&SHIFT_L", key = "F", action = "exec", arg = "hyprctl dispatch togglefloating" },
  { mods = "$mainMod", key = "left", action = "movefocus", arg = "l" },
  { mods = "$mainMod", key = "right", action = "movefocus", arg = "r" },
  { mods = "$mainMod", key = "up", action = "movefocus", arg = "u" },
  { mods = "$mainMod", key = "down", action = "movefocus", arg = "d" },
  { mods = "$mainMod&CTRL", key = "left", action = "movewindow", arg = "l" },
  { mods = "$mainMod&CTRL", key = "right", action = "movewindow", arg = "r" },
  { mods = "$mainMod&CTRL", key = "up", action = "movewindow", arg = "u" },
  { mods = "$mainMod&CTRL", key = "down", action = "movewindow", arg = "d" },

  -- Applications & Launchers
  { mods = "$mainMod", key = "RETURN", action = "exec", arg = "$terminal" },
  { mods = "$mainMod", key = "F", action = "exec", arg = "firefox" },
  { mods = "$mainMod", key = "E", action = "exec", arg = "nautilus" },

  -- Quickshell Controls
  { mods = "$mainMod", key = "R", action = "exec", arg = "bash ~/.config/hypr/scripts/reload.sh" },
  { mods = "$mainMod", key = "C", action = "exec", arg = "~/.config/hypr/scripts/qs_manager.sh toggle clipboard" },
  { mods = "$mainMod", key = "P", action = "exec", arg = "~/.config/hypr/scripts/qs_manager.sh toggle movies" },
  { mods = "$mainMod", key = "D", action = "exec", arg = "bash ~/.config/hypr/scripts/qs_manager.sh toggle applauncher" },
  { mods = "$mainMod&SHIFT_L", key = "S", action = "exec", arg = "bash ~/.config/hypr/scripts/qs_manager.sh toggle settings" },
  { mods = "$mainMod", key = "Q", action = "exec", arg = "bash ~/.config/hypr/scripts/qs_manager.sh toggle music" },
  { mods = "$mainMod", key = "B", action = "exec", arg = "bash ~/.config/hypr/scripts/qs_manager.sh toggle battery" },
  { mods = "$mainMod", key = "W", action = "exec", arg = "bash ~/.config/hypr/scripts/qs_manager.sh toggle wallpaper" },
  { mods = "$mainMod", key = "S", action = "exec", arg = "bash ~/.config/hypr/scripts/qs_manager.sh toggle calendar" },
  { mods = "$mainMod", key = "N", action = "exec", arg = "bash ~/.config/hypr/scripts/qs_manager.sh toggle network" },
  { mods = "$mainMod&SHIFT_L", key = "T", action = "exec", arg = "bash ~/.config/hypr/scripts/qs_manager.sh toggle focustime" },
  { mods = "$mainMod", key = "V", action = "exec", arg = "bash ~/.config/hypr/scripts/qs_manager.sh toggle volume" },
  { mods = "$mainMod", key = "H", action = "exec", arg = "bash ~/.config/hypr/scripts/qs_manager.sh toggle guide" },

  -- Workspaces
  { mods = "$mainMod", key = "1", action = "exec", arg = "~/.config/hypr/scripts/qs_manager.sh 1" },
  { mods = "$mainMod", key = "2", action = "exec", arg = "~/.config/hypr/scripts/qs_manager.sh 2" },
  { mods = "$mainMod", key = "3", action = "exec", arg = "~/.config/hypr/scripts/qs_manager.sh 3" },
  { mods = "$mainMod", key = "4", action = "exec", arg = "~/.config/hypr/scripts/qs_manager.sh 4" },
  { mods = "$mainMod", key = "5", action = "exec", arg = "~/.config/hypr/scripts/qs_manager.sh 5" },
  { mods = "$mainMod", key = "6", action = "exec", arg = "~/.config/hypr/scripts/qs_manager.sh 6" },
  { mods = "$mainMod", key = "7", action = "exec", arg = "~/.config/hypr/scripts/qs_manager.sh 7" },
  { mods = "$mainMod", key = "8", action = "exec", arg = "~/.config/hypr/scripts/qs_manager.sh 8" },
  { mods = "$mainMod", key = "9", action = "exec", arg = "~/.config/hypr/scripts/qs_manager.sh 9" },
  { mods = "$mainMod", key = "0", action = "exec", arg = "~/.config/hypr/scripts/qs_manager.sh 10" },

  { mods = "$mainMod SHIFT", key = "1", action = "exec", arg = "~/.config/hypr/scripts/qs_manager.sh 1 move" },
  { mods = "$mainMod SHIFT", key = "2", action = "exec", arg = "~/.config/hypr/scripts/qs_manager.sh 2 move" },
  { mods = "$mainMod SHIFT", key = "3", action = "exec", arg = "~/.config/hypr/scripts/qs_manager.sh 3 move" },
  { mods = "$mainMod SHIFT", key = "4", action = "exec", arg = "~/.config/hypr/scripts/qs_manager.sh 4 move" },
  { mods = "$mainMod SHIFT", key = "5", action = "exec", arg = "~/.config/hypr/scripts/qs_manager.sh 5 move" },
  { mods = "$mainMod SHIFT", key = "6", action = "exec", arg = "~/.config/hypr/scripts/qs_manager.sh 6 move" },
  { mods = "$mainMod SHIFT", key = "7", action = "exec", arg = "~/.config/hypr/scripts/qs_manager.sh 7 move" },
  { mods = "$mainMod SHIFT", key = "8", action = "exec", arg = "~/.config/hypr/scripts/qs_manager.sh 8 move" },
  { mods = "$mainMod SHIFT", key = "9", action = "exec", arg = "~/.config/hypr/scripts/qs_manager.sh 9 move" },
  { mods = "$mainMod SHIFT", key = "0", action = "exec", arg = "~/.config/hypr/scripts/qs_manager.sh 10 move" },

  { mods = "$mainMod", key = "TAB", action = "exec", arg = "~/.config/hypr/scripts/focus_next_monitor.sh" },
}

-- Repeating binds (binde) for continuous actions
binde = {
  { mods = "$mainMod&SHIFT_L", key = "left", action = "resizeactive", arg = "-50 0" },
  { mods = "$mainMod&SHIFT_L", key = "right", action = "resizeactive", arg = "50 0" },
  { mods = "$mainMod&SHIFT_L", key = "up", action = "resizeactive", arg = "0 -50" },
  { mods = "$mainMod&SHIFT_L", key = "down", action = "resizeactive", arg = "0 50" },
}

-- Lock binds (bindl) - work even when locked
bindl = {
  { mods = "", key = "Caps_Lock", action = "exec", arg = "sleep 0.1 && swayosd-client --caps-lock" },
  { mods = "", key = "XF86MonBrightnessDown", action = "exec", arg = "swayosd-client --brightness lower" },
  { mods = "", key = "XF86MonBrightnessUp", action = "exec", arg = "swayosd-client --brightness raise" },
  { mods = "", key = "Print", action = "exec", arg = "~/.config/hypr/scripts/screenshot.sh" },
  { mods = "SHIFT_L", key = "Print", action = "exec", arg = "~/.config/hypr/scripts/screenshot.sh --edit" },
  { mods = "SUPER", key = "Print", action = "exec", arg = "~/.config/hypr/scripts/screenshot.sh --full" },
  { mods = "SUPER SHIFT_L", key = "Print", action = "exec", arg = "~/.config/hypr/scripts/screenshot.sh --full --edit" },
  { mods = "", key = "XF86PowerOff", action = "exec", arg = "bash ~/.config/hypr/scripts/lock.sh" },
  { mods = "$mainMod", key = "SPACE", action = "exec", arg = "playerctl play-pause" },
  { mods = "", key = "XF86AudioPause", action = "exec", arg = "playerctl play-pause" },
  { mods = "", key = "XF86AudioPlay", action = "exec", arg = "playerctl play-pause" },
  { mods = "", key = "xf86AudioMicMute", action = "exec", arg = "swayosd-client --input-volume mute-toggle" },
  { mods = "", key = "xf86audiomute", action = "exec", arg = "swayosd-client --output-volume mute-toggle" },
}

-- Lock binds with repeat (bindel)
bindel = {
  { mods = "$mainMod", key = "L", action = "exec", arg = "bash ~/.config/hypr/scripts/lock.sh" },
  { mods = "", key = "xf86audiolowervolume", action = "exec", arg = "swayosd-client --output-volume lower" },
  { mods = "", key = "xf86audioraisevolume", action = "exec", arg = "swayosd-client --output-volume raise" },
}
