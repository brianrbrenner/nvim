local M = {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		{
			"williamboman/mason.nvim",
			opts = {},
		},
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"nvim-lua/plenary.nvim",
		"jay-babu/mason-nvim-dap.nvim",
	},
}

M.execs = {
	"clangd",
	"lua_ls",
	"stylua",
	"prettier",
	"cssls",
	"html",
	"djlsp",
	"astro",
	"basedpyright",
	"bashls",
	"jsonls",
	"yamlls",
	"marksman",
	"tailwindcss",
	"ts_ls",
	"eslint",
	"jdtls",
}

function M.config()
	require("mason").setup({
		ui = {
			border = "rounded",
		},
		registries = {
			"github:nvim-java/mason-registry",
			"github:mason-org/mason-registry",
		},
	})
	require("mason-lspconfig").setup({
		ensure_installed = M.execs,
	})
	require("mason-nvim-dap").setup()
	require("mason-tool-installer").setup({
		ensure_installed = {
			"lombok-nightly",
			"java-debug-adapter",
			"java-test",
		},

		-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim/issues/39
		vim.api.nvim_command("MasonToolsInstall"),
	})
end

return M

-- return {
-- 	{
-- 		"williamboman/mason.nvim",
-- 		config = function()
-- 			-- setup mason with default properties
-- 			require("mason").setup({
-- 				ui = {
-- 					border = "rounded",
-- 				},
-- 			})
-- 		end,
-- 		dependencies = { "WhoIsSethDaniel/mason-tool-installer.nvim" },
-- 	},
-- 	{
-- 		"williamboman/mason-lspconfig.nvim",
-- 		config = function()
-- 			-- ensure that we have lua language server, typescript launguage server, java language server, and java test language server are installed
-- 			require("mason-lspconfig").setup({
-- 				ensure_installed = {
-- 					"clangd",
-- 					"lua_ls",
-- 					"stylua",
-- 					"prettier",
-- 					"cssls",
-- 					"html",
-- 					"djlsp",
-- 					"astro",
-- 					"basedpyright",
-- 					"bashls",
-- 					"jsonls",
-- 					"yamlls",
-- 					"marksman",
-- 					"tailwindcss",
-- 					"tsserver",
-- 					"eslint",
-- 					"jdtls",
-- 				},
-- 			})
-- 		end,
-- 	},
-- 	{
-- 		"jay-babu/mason-nvim-dap.nvim",
-- 		config = function()
-- 			-- ensure the java debug adapter is installed
-- 			require("mason-nvim-dap").setup()
-- 		end,
-- 	},
-- 	{
-- 		"WhoIsSethDaniel/mason-tool-installer.nvim",
-- 		config = function()
-- 			require("mason-tool-installer").setup({
-- 				ensure_installed = {
-- 					"lombok-nightly",
-- 					"java-debug-adapter",
-- 					"java-test",
-- 				},
--
-- 				-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim/issues/39
-- 				vim.api.nvim_command("MasonToolsInstall"),
-- 			})
-- 		end,
-- 	},
-- }
