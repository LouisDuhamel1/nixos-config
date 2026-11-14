-- ========================
--  WINDOWS AND WORKSPACES
-- ========================
hl.workspace_rule({ workspace = "1", monitor = "eDP-1", persistent = true, default_name = "web" })
hl.workspace_rule({ workspace = "2", monitor = "eDP-1", persistent = true, default_name = "code" })
hl.workspace_rule({ workspace = "3", monitor = "eDP-1", persistent = true, default_name = "chat" })
hl.workspace_rule({ workspace = "4", monitor = "eDP-1", persistent = true, default_name = "game" })
hl.workspace_rule({ workspace = "5", monitor = "eDP-1", persistent = true, default_name = "design" })

hl.window_rule({
    name  = "fix-xwayland-drags",
    match = { class = "", title = "", xwayland = true, float = true, fullscreen = false, pin = false },
    no_focus = true,
})

hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move  = "20 monitor_h-120",
    float = true,
})

hl.window_rule({ match = { class = "firefox", title = ".*Preferences.*" }, float = true })
hl.window_rule({ match = { class = "org.keepassxc.KeePassXC" }, float = true })
hl.window_rule({ match = { class = "discord" }, workspace = 3 })

hl.window_rule({
    match = { class = "dev.noctalia.Noctalia" },
    float = true,
    size = { 1080, 920 },
})

hl.layer_rule({
    name = "noctalia",
    match = {
        namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$",
    },
    no_anim = true,
    ignore_alpha = 0.5,
    blur = true,
    blur_popups = true,
})
