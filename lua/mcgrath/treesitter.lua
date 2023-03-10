require'nvim-treesitter.configs'.setup {
	ensure_installed = { "python", "java", "javascript", "c" },
	sync_install = false,
	auto_install = true,
	
	ignore_install = { 'odin' },
	disable = { 'odin' },
	
	highlight = {
		enable = true,
		disable = {},
		additional_vim_regex_highlighting = false,
	},
}

-- local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
-- parser_config.odin = {
-- 	install_info = {
-- 		url = 'C:\\Users\\Public\\OdinServer\\treesitter\\tree-sitter-odin',
-- 		files = {'src\\parser.c'}
-- 	},
-- 
-- 	filetype = 'odin',
-- }

require 'nvim-treesitter.install'.compilers = { "clang" }
