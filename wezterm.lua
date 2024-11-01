-- Pull in the wezterm API
local wezterm = require 'wezterm'
local mux = wezterm.mux

-- This will hold the configuration.
local config = wezterm.config_builder()

config.color_scheme = 'Catppuccin Mocha'
config.font = 
	wezterm.font('MonacoLigaturized Nerd Font Mono', { weight = 'Bold', italic = true })
config.bold_brightens_ansi_colors = "BrightOnly"
config.font_size = 16
config.adjust_window_size_when_changing_font_size = true
config.font = wezterm.font_with_fallback{
  {
    family = 'MonacoLigaturized Nerd Font Mono'
  },
  {
    family = 'LXGW WenKai Mono'
  }
}


config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.95
config.window_decorations="RESIZE"

config.set_environment_variables = {
  TERMINFO_DIRS = '/home/user/.nix-profile/share/terminfo',
  WSLENV = 'TERMINFO_DIRS',
}
config.term = 'wezterm'




local function get_screen_size()
  local monitor = wezterm.gui.screens().active
  return monitor.width, monitor.height
end

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  local screen_width,screen_height = get_screen_size()
  wezterm.log_info(screen_width)
  wezterm.log_info(screen_height)
  local window_width = math.floor(screen_width * 0.85)
  local window_height = math.floor(screen_height * 0.80)
    -- 计算窗口位置（居中）
  local window_x = math.floor((screen_width - window_width) / 2)
  local window_y = math.floor((screen_height - window_height) / 2)
    -- 设置窗口大小和位置
  local gui_window = window:gui_window()
  gui_window:set_inner_size(window_width, window_height)
  gui_window:set_position(window_x, window_y)
end)

-- and finally, return the configuration to wezterm
return config
