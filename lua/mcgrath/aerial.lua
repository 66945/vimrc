-- local aerial = require 'aerial'

-- local on_attach = function(bufnr)
-- 	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
-- 	local opts = { noremap=true, silent=true }
-- 
-- 	buf_set_keymap('n', '<leader>a', '<cmd>AerialToggle!<CR>', opts)
-- 	buf_set_keymap('n', '{', '<cmd>AerialPrev<CR>', opts)
-- 	buf_set_keymap('n', '}', '<cmd>AerialNext<CR>', opts)
-- end

-- aerial.setup {
-- 	on_attach = on_attach,
-- 	default_direction = 'right',
-- }
