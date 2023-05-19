local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- body
config.use_fancy_tab_bar            = false
config.hide_tab_bar_if_only_one_tab = true

local hotpink = '#ff0088'

config.colors = {
	foreground = '#b4b4b4',
	background = '#000000',

	split = '#ff0088',

	cursor_fg = '#000000',
	cursor_bg = '#ff0088',

	ansi = {
		'#000000', -- black
		'#ff0000', -- red
		'#535353', -- green
		'#ffd700', -- yellow
		'#949494', -- blue
		hotpink,   -- purple
		'#737373', -- aqua
		'#f5f5f5', -- white
	},
	brights = {
		'#000000',
		'#ff0000',
		'#535353',
		'#ffd700',
		'#949494',
		hotpink,
		'#737373',
		'#f5f5f5',
	},

	tab_bar = {
		background = '#000000',
	},
}

config.window_decorations = 'RESIZE'

config.window_padding = {
	left   = 0,
	right  = 0,
	top    = 0,
	bottom = 0,
}

config.font      = wezterm.font 'Iosevka NF'
config.font_size = 12

config.default_prog = { 'bash' } -- TODO: replace with zsh or something

return config
