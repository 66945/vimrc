-- vim.api.nvim_set_hl(0, 'Todo', { fg = '#ff0088', bg = '#000000' })

require 'todo-comments' .setup {
	keywords = {
		IMPORTANT = { icon = ' ', color = 'error' },
		MARK      = { icon = ' ',  color = 'mark'  },
	},
	colors = {
		mark = { '#ff0088' },
	},
}

-- IMPORTANT:
-- FIXME:
-- MARK:
-- TODO:
-- NOTE:
-- WARN:
-- HACK:
-- PERF:
-- TEST:
