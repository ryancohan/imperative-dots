-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--  ◈ WINDOW & LAYER RULES
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

layerrule = {
  {
    name = "lr1",
    rule = {
      ["match:namespace"] = "^(volume_osd)$",
      no_anim = true,
    },
  },
  {
    name = "lr2",
    rule = {
      ["match:namespace"] = "^(brightness_osd)$",
      no_anim = true,
    },
  },
  {
    name = "lr3",
    rule = {
      ["match:namespace"] = "hyprpicker",
      no_anim = true,
    },
  },
  {
    name = "lr4",
    rule = {
      ["match:namespace"] = "qsdock",
      no_anim = true,
    },
  },
  {
    name = "lr5",
    rule = {
      ["match:namespace"] = "ext-session-lock",
      blur = true,
      ignore_alpha = 0.2,
    },
  },
}

-- ─────────────────────────────
-- Window rules
-- ─────────────────────────────

windowrule = {
  -- App Launcher
  {
    name = "app_launcher",
    rule = {
      ["match:title"] = "^(app-launcher)$",
      float = true,
      center = true,
      size = { 1200, 600 },
      animation = "slide",
    },
  },
  -- Master Quickshell Container
  {
    name = "master_rule",
    rule = {
      ["match:title"] = "^(qs-master)$",
      float = true,
      no_shadow = true,
      no_initial_focus = true,
    },
  },
}
