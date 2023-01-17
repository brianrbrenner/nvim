local null_ls = require("null-ls")

-- Set up null-ls server
-- NOTE: currently mappings for formatting with `vim.lsp.buf.formatting()` and
-- `vim.lsp.buf.range_formatting()` are set up for every buffer in

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
	sources = {
		-- py
		formatting.black,

		-- ts/js
		formatting.prettier.with({
			extra_filetypes = { "toml" },
		}),
    code_actions.eslint_d,
    diagnostics.eslint,

		-- lua
		formatting.stylua,

    -- clangd handles formatting and tidy

    --CMAKE
    formatting.cmake_format
	},
})
