require 'mcgrath/telescope'
require 'mcgrath/lsp'
require 'mcgrath/dap'
require 'mcgrath/treesitter'
require 'mcgrath/aerial'
require 'mcgrath/todocomments'
require 'mcgrath/nvim-tree'

require 'indent_blankline' .setup {}
vim.highlight.create('Comment', {cterm='italic', gui='italic'}, false)
