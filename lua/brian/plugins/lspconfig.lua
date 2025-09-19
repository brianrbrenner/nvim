local M = {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{
			"pmizio/typescript-tools.nvim",
			"folke/neodev.nvim",
			"b0o/schemastore.nvim",
			"saghen/blink.cmp",
		},
	},
}

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	local keymap = vim.api.nvim_buf_set_keymap
	keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
end

M.on_attach = function(client, bufnr)
	lsp_keymaps(bufnr)

	if client:supports_method("textDocument/inlayHint") then
		vim.lsp.inlay_hint.enable(true)
	end
end

M.toggle_inlay_hints = function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end

function M.config()
	local wk = require("which-key")
	wk.add({
		{ "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Prev Diagnostic" },
		{ "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "Next Diagnostic" },
		{ "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
		{
			"<leader>lf",
			"<cmd>lua vim.lsp.buf.format({async = true, filter = function(client) return client.name ~= 'typescript-tools' end})<cr>",
			desc = "Format",
		},
		{ "<leader>lh", "<cmd>lua require('brian.plugins.lspconfig').toggle_inlay_hints()<cr>", desc = "Hints" },
		{ "<leader>li", "<cmd>LspInfo<cr>", desc = "Info" },
		{ "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action" },
		{ "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Quickfix" },
		{ "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
	})

	local mason_only = {
		"prettier",
		"sonarlint-language-server",
	}

	local server_mason_pairs = {
		clangd = "clangd",
		lua_ls = "lua-language-server",
		cssls = "css-lsp",
		html = "html-lsp",
		djlsp = "django-template-lsp",
		basedpyright = "basedpyright",
		bashls = "bash-language-server",
		jsonls = "json-lsp",
		yamlls = "yaml-language-server",
		tailwindcdd = "tailwindcss-language-server",
		eslint = "eslint-lsp",
		jdtls = "jdtls",
	}

	local servers = {}
	for k, v in pairs(server_mason_pairs) do
		table.insert(servers, tostring(k))
		table.insert(mason_only, v)
	end

	require("mason-tool-installer").setup({ ensure_installed = mason_only, vim.api.nvim_command("MasonToolsInstall") })

	for _, server in pairs(servers) do
		local opts = {
			on_attach = M.on_attach,
			capabilities = require("blink.cmp").get_lsp_capabilities(),
		}

		local require_ok, settings = pcall(require, "brian.lspsettings." .. server)
		if require_ok then
			opts = vim.tbl_deep_extend("force", settings, opts)
		end

		if server == "eslint" then
			opts.on_attach = function(client, bufnr)
				M.on_attach(client, bufnr)
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					command = "LspEslintFixAll",
				})
			end
		end

		vim.lsp.config(server, opts)
		vim.lsp.enable(server)
	end
end

return M
