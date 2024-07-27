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
		"nvim-lua/plenary.nvim",
		"jay-babu/mason-nvim-dap.nvim",
	},
}

M.execs = {
	"lua_ls",
	"cssls",
	"html",
	"tsserver",
	"astro",
	"pyright",
	"bashls",
	"jsonls",
	"yamlls",
	"marksman",
	"tailwindcss",
	"rust_analyzer",
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
	require("mason-nvim-dap").setup({
    automatic_installation = true,
		ensure_installed = { "java-debug-adapter", "java-test" },
	})
end

return M
