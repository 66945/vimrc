local my_lsp = require 'mcgrath/lsp'
local jdtls = require 'jdtls'

local wpilib_jdk = 'C:\\Users\\Public\\wpilib\\2022\\jdk\\bin\\java'

function get_correct_JDK()
	local paths = vim.api.nvim_list_runtime_paths()
	for _, path in ipairs(paths) do
		print(path)
		if path == '.wpilib' then return wpilib_jdk end
	end

	return 'java'
end

local config = {
-- NOTE: This is using the vscode script to start everything.
-- NOTE: It kind of works, but the actual code is copied and modified
--	cmd = {
--		'python',
--		'C:\\Users\\Owner\\.vscode\\extensions\\redhat.java-1.10.0-win32-x64\\server\\bin\\jdtls.py',
--		'-data', 'C:\\Users\\Owner\\Documents\\GitHub\\2022NoWayHome'
--	},
	cmd = {
		get_correct_JDK(),
		'-Declipse.application=org.eclipse.jdt.ls.core.id1',
		'-Dosgi.bundles.defaultStartLevel=4',
		'-Declipse.product=org.eclipse.jdt.ls.core.product',
		'-Dlog.protocol=true',
		'-Dlog.level=ALL',
		'-Xms1g',
		'--add-modules=ALL-SYSTEM',
		'--add-opens', 'java.base/java.util=ALL-UNNAMED',
		'--add-opens', 'java.base/java.lang=ALL-UNNAMED',

		'-jar', 'C:\\Users\\Owner\\.vscode\\extensions\\redhat.java-1.10.0-win32-x64\\server\\plugins\\org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
		'-configuration', 'C:\\Users\\Owner\\.vscode\\extensions\\redhat.java-1.10.0-win32-x64\\server\\config_win',
		'-data', vim.fn.getcwd()
	},

	root_dir = require 'jdtls.setup' .find_root{'.git', 'mvnw', 'gradlew'},

	settings = {
		java = {}
	}
}

jdtls.start_or_attach(config)
my_lsp.on_attach(0, 0)
