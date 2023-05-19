local telescope = require 'telescope'

telescope.setup {
	defaults = {
		prompt_prefix        = "   ",
		file_ignore_patterns = {'.git/', 'node_modules'},
	},
}
