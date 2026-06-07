-- WezTerm configuration for Linux
-- Cross-platform alternative to Ghostty

local wezterm = require 'wezterm'

return {
  -- Font settings
  font_size = 14,
  font = wezterm.font 'MesloLGS Nerd Font',

  -- Colors (Catppuccin Mocha theme)
  colors = {
    foreground = '#cdd6f4',
    background = '#1e1e2e',
  },

  -- Window styling
  window_padding = {
    left = '8px',
    right = '8px',
    top = '8px',
    bottom = '8px',
  },

  -- Appearance
  window_decorations = 'INTEGRATED_BUTTONS|RESIZE',
  use_fancy_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,

  -- Mouse
  enable_scroll_wheel = true,
  mouse_wheel_scrolls_tabs = false,

  -- Shell
  default_prog = { '/bin/zsh', '-l' },

  -- Cursor
  cursor_blink_ease_in = 'Constant',
  cursor_blink_ease_out = 'Constant',
  cursor_blink_rate = 0,
  default_cursor_style = 'BlinkingBlock',

  -- Keys
  leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 },

  keys = {
    -- Ctrl+Shift+T for new tab
    { key = 't', mods = 'CTRL|SHIFT', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
    -- Ctrl+Shift+W to close tab
    { key = 'w', mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentTab { confirm = true } },
  },
}
