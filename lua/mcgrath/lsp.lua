local nvim_lsp = require 'lspconfig'
-- local aerial = require 'aerial'
-- Removed jdtls
local servers = { 'jedi_language_server', 'clangd', 'gdscript', 'tsserver', 'rust_analyzer', 'gopls', 'ols' }
local semantic = { ols = nil }

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
	buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

--	if not client == 0 then
--		aerial.on_attach(client, bufnr)
--	end

	print(client.name)
	if semantic[client.name] ~= nil then
		setup_semantics(client, bufnr)
	end
end

-- NOTE: semantic highlighting
local set_hl = vim.api.nvim_set_hl

-- tokens
set_hl(0, "LspParameter", { link = "Identifier" })
-- set_hl(0, "LspType", { fg = "#00ff00" })
-- set_hl(0, "LspParameter", { link = "Parameter" })
set_hl(0, "LspType", { link = "Type" })
-- set_hl(0, "LspClass", { link = "TSStorageClass" })
-- set_hl(0, "LspComment", { link = "Comment" })
-- set_hl(0, "LspDecorator", { link = "TSAnnotation" })
set_hl(0, "LspEnum", { link = "Type" })
set_hl(0, "LspEnumMember", { link = "Include" })
-- set_hl(0, "LspEvent", { link = "TSProperty" })
set_hl(0, "LspFunction", { link = "Function" })
set_hl(0, "LspInterface", { link = "Type" })
set_hl(0, "LspKeyword", { link = "Keyword" })
-- set_hl(0, "LspMacro", { link = "FuncMacro" })
-- set_hl(0, "LspMethod", { link = "TSMethod" })
set_hl(0, "LspModifier", { link = "Typedef" })
-- set_hl(0, "LspNamespace", { link = "Type" })
set_hl(0, "LspNumber", { link = "Number" })
set_hl(0, "LspOperator", { link = "Operator" })
set_hl(0, "LspProperty", { link = "Identifier" })
-- set_hl(0, "LspRegexp", { link = "TSStringRegex" })
set_hl(0, "LspString", { link = "String" })
set_hl(0, "LspStruct", { link = "Type" })
set_hl(0, "LspTypeParameter", { link = "Type" })
-- set_hl(0, "LspVariable", { link = "Constant" })

-- modifier
set_hl(0, "LspDeclaration", { link = "Identifier" })
set_hl(0, "LspDefinition", { fg = "#00ff00" })
set_hl(0, "LspReadonly", { link = "Constant" })
set_hl(0, "LspStatic", { link = "Constant" })
set_hl(0, "LspDeprecated", { link = "Warning" })
--set_hl(0, "LspAbstract", { fg = "#9E6162" })
--set_hl(0, "LspAsync", { fg = "#81A35C" })
--set_hl(0, "LspModification", { fg = "#7E5CA3" })
--set_hl(0, "LspDocumentation", { fg = "#ff0000" })
--set_hl(0, "LspDefaultLibrary", { fg = "#c99dc1" })


function setup_semantics(client, bufnr)
	local caps = client.server_capabilities
	if caps.semanticTokensProvider and caps.semanticTokensProvider.full then
    	local augroup = vim.api.nvim_create_augroup("SemanticTokens", {})
    	vim.api.nvim_create_autocmd("TextChanged", {
    		group = augroup,
    		buffer = bufnr,
			callback = function()
				vim.lsp.buf.semantic_tokens_full()
			end,
		})
    	vim.api.nvim_create_autocmd("BufEnter", {
    		group = augroup,
    		buffer = bufnr,
			callback = function()
				vim.lsp.buf.semantic_tokens_full()
			end,
		})

		vim.lsp.buf.semantic_tokens_full()
	end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require 'cmp_nvim_lsp' .default_capabilities(capabilities)

for _, lsp in ipairs(servers) do
	if lsp == 'gdscript' then
		nvim_lsp.gdscript.setup {
			capabilities = capabilities,
			on_attach = on_attach,
			port = 6008,
			cmd = { 'nc', '127.0.0.1', '6008' },
			root_dir = function() return vim.fn.getcwd() end,
			flags = {
				debounce = 150,
			},
		}
	else
		nvim_lsp[lsp].setup {
			capabilities = capabilities,
			on_attach = on_attach
		}
	end
end

require("lsp_lines").setup()
vim.diagnostic.config {
	virtual_text = false,
}

--	nvim_lsp.gdscript.setup {
-- 	cmd = {
-- 		'powershell',
-- 		'-command',
-- 		'"Test-NetConnection',
-- 		'-Computername',
-- 		'localhost',
-- 		'-Port',
-- 		'6008"'
-- 	},
--	root_dir = function() vim.lsp.buf.list_workspace_folders() end
--	}

local cmp = require 'cmp'
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
