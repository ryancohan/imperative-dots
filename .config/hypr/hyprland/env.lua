-- Environment variables
local home = os.getenv("HOME")

hl.env("NIXOS_OZONE_WL", "1")
hl.env("XDG_PICTURES_DIR", os.getenv("XDG_PICTURES_DIR") or (home .. "/Pictures"))
hl.env("XDG_VIDEOS_DIR", os.getenv("XDG_VIDEOS_DIR") or (home .. "/Videos"))
hl.env("WALLPAPER_DIR", os.getenv("WALLPAPER_DIR") or (home .. "/Pictures/Wallpapers"))
hl.env("SCRIPT_DIR", home .. "/.config/hypr/scripts")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
