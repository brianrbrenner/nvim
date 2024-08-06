vim.opt.expandtab = false
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- this doesn't work unless I do it again here
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
keymap("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)

require("barbecue.ui").toggle(true)
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client then
			client.server_capabilities.semanticTokensProvider = nil
		end
	end,
})

local mason_registry = require("mason-registry")

local SYSTEM
if vim.fn.has("mac") then
	SYSTEM = "mac"
else
	SYSTEM = "linux"
end

local function get_jdtls()
	local jdtls = mason_registry.get_package("jdtls")
	local lombok = mason_registry.get_package("lombok-nightly")
	local jdtls_path = jdtls:get_install_path()
	local lombok_path = lombok:get_install_path()

	local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

	-- Obtain the path to configuration files for your specific operating system
	local config = jdtls_path .. "/config_" .. SYSTEM
	-- Obtain the path to the Lomboc jar
	local lombok_config = lombok_path .. "/lombok.jar"

	return launcher, config, lombok_config
end

local function get_bundles()
	local java_debug = mason_registry.get_package("java-debug-adapter")
	local java_debug_path = java_debug:get_install_path()

	local bundles = {
		vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", true),
	}
	local java_test = mason_registry.get_package("java-test")
	local java_test_path = java_test:get_install_path()
	vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar", true), "\n"))

	return bundles
end

local function get_workspace()
	-- Get the home directory of your operating system
	local home = os.getenv("HOME")
	-- Declare a directory where you would like to store project information
	local workspace_path = home .. "/code/workspace/"
	-- Determine the project name
	local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
	-- Create the workspace directory by concatenating the designated workspace path and the project name
	local workspace_dir = workspace_path .. project_name
	return workspace_dir
end

-- Get access to the jdtls plugin and all of its functionality
local jdtls = require("jdtls")

-- Get the paths to the jdtls jar, operating specific configuration directory, and lombok jar
local launcher, os_config, lombok = get_jdtls()

-- Get the path you specified to hold project information
local workspace_dir = get_workspace()

-- Get the bundles list with the jars to the debug adapter, and testing adapters
local bundles = get_bundles()

-- Determine the root directory of the project by looking for these specific markers
local root_dir = jdtls.setup.find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" })

-- Tell our JDTLS language features it is capable of
local capabilities = {
	workspace = {
		configuration = true,
	},
	textDocument = {
		completion = {
			snippetSupport = false,
		},
	},
}

local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

for k, v in pairs(lsp_capabilities) do
	capabilities[k] = v
end

-- Get the default extended client capablities of the JDTLS language server
local extendedClientCapabilities = jdtls.extendedClientCapabilities
-- Modify one property called resolveAdditionalTextEditsSupport and set it to true
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

-- Set the command that starts the JDTLS language server jar
local cmd = {
	"java",
	"-Declipse.application=org.eclipse.jdt.ls.core.id1",
	"-Dosgi.bundles.defaultStartLevel=4",
	"-Declipse.product=org.eclipse.jdt.ls.core.product",
	"-Dlog.protocol=true",
	"-Dlog.level=ALL",
	"-Xmx1g",
	"--add-modules=ALL-SYSTEM",
	"--add-opens",
	"java.base/java.util=ALL-UNNAMED",
	"--add-opens",
	"java.base/java.lang=ALL-UNNAMED",
	"-javaagent:" .. lombok,
	"-jar",
	launcher,
	"-configuration",
	os_config,
	"-data",
	workspace_dir,
}

local get_runtimes = function()
	if SYSTEM == "linux" then
		return {
			{
				name = "JavaSE-21",
				path = "/usr/lib/jvm/openjdk21/",
			},
		}
	else
		return {
			{
				name = "JavaSE-21",
				path = "/usr/local/opt/openjdk@21/libexec/openjdk/Contents/Home/",
			},
			{
				name = "JavaSE-17",
				path = "/usr/local/opt/openjdk@17/libexec/openjdk/Contents/Home/",
			},
		}
	end
end

-- Configure settings in the JDTLS server
local settings = {
	java = {
		-- Enable code formatting
		format = {
			enabled = true,
		},
		-- Enable downloading archives from eclipse automatically
		eclipse = {
			downloadSource = true,
		},
		-- Enable downloading archives from maven automatically
		maven = {
			downloadSources = true,
		},
		-- Enable method signature help
		signatureHelp = {
			enabled = true,
		},
		-- Use the fernflower decompiler when using the javap command to decompile byte code back to java code
		contentProvider = {
			preferred = "fernflower",
		},
		-- Setup automatical package import oranization on file save
		saveActions = {
			organizeImports = true,
		},
		-- Customize completion options
		completion = {
			-- When using an unimported static method, how should the LSP rank possible places to import the static method from
			favoriteStaticMembers = {
				"org.junit.jupiter.api.Assertions.*",
				"org.mockito.Mockito.*",
			},
			-- Try not to suggest imports from these packages in the code action window
			filteredTypes = {
				"com.sun.*",
				"io.micrometer.shaded.*",
				"java.awt.*",
				"jdk.*",
				"sun.*",
			},
			-- Set the order in which the language server should organize imports
			-- "" is all others, "#" is static imports
			importOrder = {
				"com",
				"lombok",
				"org",
				"jakarta",
				"javax",
				"java",
				"",
				"#",
			},
		},
		sources = {
			-- How many classes from a specific package should be imported before automatic imports combine them all into a single import
			organizeImports = {
				starThreshold = 9999,
				staticThreshold = 9999,
			},
		},
		-- How should different pieces of code be generated?
		codeGeneration = {
			-- When generating toString use a json format
			toString = {
				template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
			},
			-- When generating hashCode and equals methods use the java 7 objects method
			hashCodeEquals = {
				useJava7Objects = true,
			},
			-- When generating code use code blocks
			useBlocks = true,
		},
		-- If changes to the project will require the developer to update the projects configuration advise the developer before accepting the change
		configuration = {
			runtimes = { get_runtimes() },
			updateBuildConfiguration = "interactive",
		},
		-- enable code lens in the lsp
		referencesCodeLens = {
			enabled = true,
		},
		-- enable inlay hints for parameter names,
		inlayHints = {
			parameterNames = {
				enabled = "all",
			},
		},
	},
}

-- Create a table called init_options to pass the bundles with debug and testing jar, along with the extended client capablies to the start or attach function of JDTLS
local init_options = {
	bundles = bundles,
	extendedClientCapabilities = extendedClientCapabilities,
}

-- Function that will be ran once the language server is attached
local on_attach = function(_, bufnr)
	require("jdtls.dap").setup_dap({
		hotcodereplace = "auto",
	})
	-- Find the main method(s) of the application so the debug adapter can successfully start up the application
	-- Sometimes this will randomly fail if language server takes to long to startup for the project, if a ClassDefNotFoundException occurs when running
	-- the debug tool, attempt to run the debug tool while in the main class of the application, or restart the neovim instance
	-- Unfortunately I have not found an elegant way to ensure this works 100%
	require("jdtls.dap").setup_dap_main_class_configs()
	-- Enable jdtls commands to be used in Neovim
	vim.lsp.codelens.refresh()

	-- Setup a function that automatically runs every time a java file is saved to refresh the code lens
	vim.api.nvim_create_autocmd("BufWritePost", {
		pattern = { "*.java" },
		callback = function()
			local _, _ = pcall(vim.lsp.codelens.refresh)
		end,
	})
end

-- Create the configuration table for the start or attach function
local config = {
	cmd = cmd,
	root_dir = root_dir,
	settings = settings,
	capabilities = capabilities,
	init_options = init_options,
	on_attach = on_attach,
}

require("jdtls").start_or_attach(config)

local wk = require("which-key")
local springboot = require("springboot-nvim")

wk.add({
	{ "<leader>j", group = "Java", nowait = true, remap = false },
	{
		"<leader>jb",
		":TermExec cmd='mvn clean install -U -X -DskipTests'<CR>",
		desc = "Clean Install - no tests",
		nowait = true,
		remap = false,
	},
	{
		"<leader>ji",
		":TermExec cmd='mvn clean install -U -X'<CR>",
		desc = "Clean Install",
		nowait = true,
		remap = false,
	},
	{
		"<leader>jo",
		":lua require('jdtls').organize_imports()<CR>",
		desc = "Organize Imports",
	},
	{ "<leader>jt", group = "Test", nowait = true, remap = false },
	{ "<leader>jtc", ":lua require('jdtls').test_class()<CR>", desc = "Class" },
	{ "<leader>jtm", ":lua require('jdtls').test_nearest_method()<CR>", desc = "Nearest Method" },
	{ "<leader>jd", group = "Debug", nowait = true, remap = false },
	{ "<leader>jr", group = "Run", nowait = true, remap = false },
	{
		"<leader>jrd",
		":lua require('springboot-nvim').boot_run('-Pdev')",
		desc = "Run Dev Profile",
		nowait = true,
		remap = false,
	},
	{
		"<leader>jrr",
		springboot.boot_run,
		desc = "Run",
		nowait = true,
		remap = false,
	},
	{ "<leader>jg", group = "Generate", nowait = true, remap = false },
	{ "<leader>jgc", springboot.generate_class, desc = "Generate Class", nowait = true, remap = false },
	{ "<leader>jgi", springboot.generate_interface, desc = "Generate Interface", nowait = true, remap = false },
	{ "<leader>jge", springboot.generate_enum, desc = "Generate Enum", nowait = true, remap = false },
	{ "<leader>jgr", springboot.generate_record, desc = "Generate Record", nowait = true, remap = false },
})

require("nvim-tree").setup({
	view = {
		width = 50,
		centralize_selection = true,
	},
	update_cwd = true,
	update_focused_file = {
		enable = true,
		update_cwd = true,
	},
})
