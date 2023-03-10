local dap = require 'dap'

-- NOTE: c++ configurations:
dap.adapters.cppdbg = {
	id		= 'cppdebug',
	type	= 'executable',
	command	= 'C:\\Users\\Owner\\.vscode\\extensions\\ms-vscode.cpptools-1.13.9-win32-x64\\debugAdapters\\bin\\OpenDebugAD7.exe',
	options	= {
		detached = false
	}
}

dap.adapters.codelldb = {
	type		= 'server',
	port 		= '${port}',
	executable	= {
		command	= 'C:\\Users\\Public\\CppDebug\\codelldb\\extension\\adapter\\codelldb.exe',
		args	= {'--port', '${port}'},
	}
}

dap.configurations.cpp = {
	{
		name = 'Launch file',
		type = 'cppdbg',
		request = 'launch',
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '\\', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = true,
	},
	{
		name = 'Attach to gdbserver :1234',
		type = 'cppdbg',
		request = 'launch',
		MIMode = 'gdb',
		miDebuggerPath = 'C:\\mingw\\bin',
		miDebuggerServerAddress = 'localhost:1234',
		cwd = '${workspaceFolder}',
		program = function()
			return vim.fin.input('Path to executable: ', vim.fn.getcwd() .. '\\', 'file')
		end,
	},
	{
		name = 'codelldb Launch File',
		type = 'codelldb',
		request = 'launch',
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = true,
	},
}

dap.configurations.c = dap.configurations.cpp

-- NOTE: python configurations:
dap.adapters.python = {
	type = 'executable',
	command = 'python',
	args = { '-m', 'debugpy.adapter' },
}

dap.configurations.python = {
	{
		type = 'python',
		request = 'launch',
		name = 'Launch file',

		program = '${file}',
	}
}

-- NOTE: typescript configurations
local dapjs = require 'dap-vscode-js'
local DEBUGGER_PATH = 'C:\\Users\\Owner\\Documents\\vscode-js-debug'

dapjs.setup {
	node_path = 'node',
	debugger_path = DEBUGGER_PATH,
	adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }
}

for _, language in ipairs { 'javascript', 'typescript' } do
	dap.configurations[language] = {
		{
			type = 'pwa-node',
			request = 'launch',
			name = 'Launch file',
			program = '${file}',
			cwd = '${workspaceFolder}'
		},
		{
			type = 'pwa-node',
			request = 'attach',
			name = 'Attach',
			processId = require('dap.utils').pick_process,
			cwd = '${workspaceFolder}',
		},
		{
			type = 'pwa-node',
			request = 'launch',
			name = 'Debug Jest Tests',
			-- trace = true, -- include debugger info
			runtimeExecutable = 'node',
			runtimeArgs = {
				'./node_modules/jest/bin/jest.js',
				'--runInBand',
			},
			rootPath = '${workspaceFolder}',
			cwd = '${workspaceFolder}',
			console = 'integratedTerminal',
			internalConsoleOptions = 'neverOpen',
		},
	}
end

-- NOTE: go configuration
require 'dap-go' .setup()

vim.api.nvim_set_keymap('n', '<leader>b', ':lua require\'dap\'.toggle_breakpoint()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F1>', ':lua require\'dap\'.step_over()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F2>', ':lua require\'dap\'.step_into()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F3>', ':lua require\'dap\'.continue()<CR>', { noremap = true })

local dap_ui = require 'dapui'

dap_ui.setup {}

dap.listeners.after.event_initialized['dapui_config'] = function()
	dap_ui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
	dap_ui.close()
end
dap.listeners.after.event_exited['dapui_config'] = function()
	dap_ui.close()
end
