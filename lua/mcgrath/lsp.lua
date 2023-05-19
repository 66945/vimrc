require 'mason' .setup()

local nvim_lsp = require 'lspconfig'
-- Removed jdtls
-- Removed jedi_language_server
local servers = {
	'pyright',
	'clangd',
	'gdscript',
	'tsserver',
	'rust_analyzer',
	'gopls',
	'ols',
	'zls'
}

-- NOTE: This function is copied in ftplugin/java.lua
function on_attach(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local opts = { noremap=true, silent=true }

	buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
	buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
	buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
	buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.format { async = true }<CR>', opts)

	print(client.name)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require 'cmp_nvim_lsp' .default_capabilities(capabilities)

for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup {
		capabilities = capabilities,
		on_attach    = on_attach
	}
end

nvim_lsp.gdscript.setup {
	capabilities = capabilities,
	on_attach    = on_attach,
	cmd          = { 'ncat', 'localhost', '6008' },
	root_dir     = function() return vim.loop.cwd() end
}

nvim_lsp.zls.setup {
	capabilities = capabilities,
	on_attach    = on_attach,
	cmd          = { 'zls.cmd' },
}

-- looks
require 'lsp_lines' .setup()
vim.diagnostic.config {
	virtual_text = false,
}

local signs = { Error = ' ', Warn = ' ', Hint = ' ', Information = ' ' }
for type, icon in pairs(signs) do
	local hl = 'DiagnosticSign' .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

-- autocomplete
local cmp     = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup {
	mapping = {
		['<Tab>'] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end,

		['<S-Tab>'] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end,

		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
	},

	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end
	},

	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	},

	formatting = {
		format = require 'lspkind' .cmp_format()
	},
}

local module = { on_attach = on_attach }
return module
