local custom_gruvbox = require 'lualine.themes.auto'

custom_gruvbox.normal.b.bg  = '#000000'
custom_gruvbox.insert.b.bg  = '#000000'
custom_gruvbox.visual.b.bg  = '#000000'
custom_gruvbox.command.b.bg = '#000000'

custom_gruvbox.normal.b.fg  = 'gray'
custom_gruvbox.insert.b.fg  = 'gray'
custom_gruvbox.visual.b.fg  = 'gray'
custom_gruvbox.command.b.fg = 'gray'

custom_gruvbox.normal.c.bg  = '#000000'
custom_gruvbox.insert.c.bg  = '#000000'
custom_gruvbox.visual.c.bg  = '#000000'
custom_gruvbox.command.c.bg = '#000000'

custom_gruvbox.normal.c.fg  = 'fg'
custom_gruvbox.insert.c.fg  = 'fg'
custom_gruvbox.visual.c.fg  = 'fg'
custom_gruvbox.command.c.fg = 'fg'

-- custom tabline
local devicons = require 'nvim-web-devicons'
local M = {}

M.tabnames = {}

function M.get_tab_names()
	local current = vim.api.nvim_get_current_tabpage()
	local tabs    = vim.api.nvim_list_tabpages()

	local names = {}
	for _, handle in ipairs(tabs) do
		local name = ''

		if M.tabnames[handle] ~= nil then
			name = name .. M.tabnames[handle]
		else
			local win  = vim.api.nvim_tabpage_get_win(handle)
			local buf  = vim.api.nvim_win_get_buf(win)
			local file = vim.api.nvim_buf_get_name(buf)

			for c in string.reverse(file):gmatch '.' do
				if c == '\\' then break end

				name = c .. name
			end
		end

		if handle == current then name = name .. '*' end

		table.insert(names, name)
	end

	return names
end

function name_tab()
	local current = vim.api.nvim_get_current_tabpage()
	M.tabnames[current] = vim.fn.input('tab name: ')
end

function M.render()
	local tabs = M.get_tab_names()

	local rendered = ' '
	for _, mytab in ipairs(tabs) do
		rendered = rendered .. mytab .. ' '
	end

	return rendered
end

-- lualine integration
require 'lualine' .setup {
	options = {
		theme                = custom_gruvbox,
		section_separators   = { left = '', right = '' },
		component_separators = { left = '',  right = '|'}
	},

	sections = {
		lualine_b = { 
			'filename',
		},
		lualine_c = {
			'os.date(\'%a %x %I:%M\')',
		},
		lualine_y = {
			'progress',
			'diagnostics',
		},
	},

--	tabline = {
--		lualine_a = {},
--		lualine_b = { M.render },
--	}
}

local opts = { noremap=true, silent=true }

vim.opt.showtabline = 1

return M
