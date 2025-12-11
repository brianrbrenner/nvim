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

	client.server_capabilities.semanticTokensProvider = nil
end

-- fix all on save using 0.11+ lspconfig
local function fix_all(opts)
	opts = opts or {}

	local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()
	vim.validate("bufnr", bufnr, "number")

	local client = opts.client or vim.lsp.get_clients({ bufnr = bufnr, name = "eslint" })[1]

	if not client then
		return
	end

	local request

	if opts.sync then
		request = function(buf, method, params)
			client:request_sync(method, params, nil, buf)
		end
	else
		request = function(buf, method, params)
			client:request(method, params, nil, buf)
		end
	end

	request(bufnr, "workspace/executeCommand", {
		command = "eslint.applyAllFixes",
		arguments = {
			{
				uri = vim.uri_from_bufnr(bufnr),
				version = vim.lsp.util.buf_versions[bufnr],
			},
		},
	})
end

local function eslint_format_on_save(opts)
	opts.on_init = function(client, _)
		vim.api.nvim_create_user_command("EslintFixAll", function()
			fix_all({ client = client, sync = true })
		end, {})

		vim.api.nvim_create_autocmd({ "BufWritePre" }, {
			group = vim.api.nvim_create_augroup("eslint_fix", {}),
			pattern = { "*.js", "*.jsx", "*.ts", "*.tsx" },
			command = "silent! EslintFixAll",
		})
	end
end

local function rust_analyzer_format_on_save(opts)
	opts.on_init = function(client, _)
		local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()
		vim.validate("bufnr", bufnr, "number")

		vim.api.nvim_create_autocmd({ "BufWritePre" }, {
			group = vim.api.nvim_create_augroup("RustFormat", { clear = true }),
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end,
		})
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
		"stylua",
		"lombok-nightly",
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
		rust_analyzer = "rust-analyzer",
	}

	local servers = {}
	for k, v in pairs(server_mason_pairs) do
		table.insert(servers, tostring(k))
		table.insert(mason_only, v)
	end

	require("mason-tool-installer").setup({ ensure_installed = mason_only, vim.api.nvim_command("MasonToolsInstall") })

	for _, server in pairs(servers) do
		local opts = {
			on_init = {},
			on_attach = M.on_attach,
		}

		local require_ok, settings = pcall(require, "brian.lspsettings." .. server)
		if require_ok then
			opts = vim.tbl_deep_extend("force", settings, opts)
		end

		if server == "eslint" then
			eslint_format_on_save(opts)
		end

		if server == "rust_analyzer" then
			rust_analyzer_format_on_save(opts)
		end

		if server ~= "jdtls" then
			vim.lsp.config(server, opts)
			vim.lsp.enable(server)
		end
	end
end

return M
