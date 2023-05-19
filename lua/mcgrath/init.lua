require 'mcgrath/telescope'
require 'mcgrath/lsp'
require 'mcgrath/dap'
require 'mcgrath/treesitter'
require 'mcgrath/todocomments'
require 'mcgrath/twilight'
require 'mcgrath/nvim-tree'
require 'mcgrath/semantic'
require 'mcgrath/lualine'

-- set shell
require 'FTerm' .setup {
	dimensions = {
		height = .8,
		width  = .7,
	},
	cmd    = 'bash',
	border = 'rounded',
}

-- I have no idea why this isn't the default
vim.api.nvim_set_hl(0, '@function', { link = "Function" })
vim.api.nvim_set_hl(0, '@method',   { link = "Function" })

-- TODO: rebuild my custom noirblaze setup in noirbuddy

--[[
require 'noirbuddy' .setup {
	preset = 'minimal',
	styles = {
		italic    = true,
		bold      = true,
		underline = true,
		undercurl = true,
	},
}
]]

require 'indent_blankline' .setup {
	char = '┆',
}

require 'leap'            .add_default_mappings()
require 'symbols-outline' .setup()
-- require 'hologram'        .setup {
-- 	auto_display = true,
-- }
