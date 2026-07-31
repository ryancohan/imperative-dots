-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--
--   ██╗██╗  ██╗   ██╗ █████╗ ███╗   ███╗██╗██████╗  ██████╗
--   ██║██║  ╚██╗ ██╔╝██╔══██╗████╗ ████║██║██╔══██╗██╔═══██╗
--   ██║██║   ╚████╔╝ ███████║██╔████╔██║██║██████╔╝██║   ██║
--   ██║██║    ╚██╔╝  ██╔══██║██║╚██╔╝██║██║██╔══██╗██║   ██║
--   ██║███████╗██║   ██║  ██║██║ ╚═╝ ██║██║██║  ██║╚██████╔╝
--   ╚═╝╚══════╝╚═╝   ╚═╝  ╚═╝╚═╝     ╚═╝╚═╝╚═╝  ╚═╝ ╚═════╝
--
--   Created by ilyamiro
--   https://github.com/ilyamiro/imperative-dots
--   Converted to Lua configuration
--
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- Load generated color variables from matugen
dofile(os.getenv("HOME") .. "/.config/hypr/colors.lua")

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--  ◈ MODULAR CONFIGURATION
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- Passthrough mode for Quickshell: Dummy bind to force Hyprland to register the submap in memory.
-- Since you will never press this, all normal keystrokes fall through to Quickshell
submap = "passthru"
bind = {
  { mods = "SUPER SHIFT CTRL ALT", key = "F35", action = "exec", arg = "true" },
}
submap = "reset"

-- Load configuration modules
dofile(os.getenv("HOME") .. "/.config/hypr/config/monitors.lua")
dofile(os.getenv("HOME") .. "/.config/hypr/config/env.lua")
dofile(os.getenv("HOME") .. "/.config/hypr/config/autostart.lua")
dofile(os.getenv("HOME") .. "/.config/hypr/config/variables.lua")
dofile(os.getenv("HOME") .. "/.config/hypr/config/settings.lua")
dofile(os.getenv("HOME") .. "/.config/hypr/config/rules.lua")
dofile(os.getenv("HOME") .. "/.config/hypr/config/keybindings.lua")
