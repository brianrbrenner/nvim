local M = {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		{
			"williamboman/mason.nvim",
			opts = {
				registries = {
					"github:nvim-java/mason-registry",
					"github:mason-org/mason-registry",
				},
			},
		},
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"nvim-lua/plenary.nvim",
		"jay-babu/mason-nvim-dap.nvim",
	},
}

M.execs = {
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
	"tsserver",
	"eslint",
	"jdtls",
}

function M.config()
	require("mason").setup({
		ui = {
			border = "rounded",
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
