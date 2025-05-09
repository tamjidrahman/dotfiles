local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font = wezterm.font("JetBrains Mono")
config.font_size = 12

config.window_decorations = "RESIZE"
config.enable_tab_bar = false
config.window_background_opacity = 0.95
config.macos_window_background_blur = 40

config.color_scheme = "Gruvbox Dark (Gogh)"

return config
