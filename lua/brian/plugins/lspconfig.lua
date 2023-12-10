require("mason").setup()
local mason_lspconfig = require("mason-lspconfig")

-- Currently used language servers:
-- - clangd for C/C++
-- - lua_ls for Lua
-- - typescript-language-server for Typescript and Javascript
-- - rust_analyzer for.. well yeah Rust
mason_lspconfig.setup({
	ensure_installed = { "lua_ls", "tsserver", "clangd", "rust_analyzer" },
})

local lspconfig = require("lspconfig")

-- Preconfiguration ===========================================================
local function lsp_keymaps(bufnr)
	local opts = { buffer = bufnr, silent = true }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
end

local on_attach_custom = function(client, bufnr)
	local function buf_set_option(name, value)
		vim.api.nvim_buf_set_option(bufnr, name, value)
	end
	client.default_capabilities = require("cmp_nvim_lsp").default_capabilities()
  client.server_capabilities.offsetEncoding = { "utf-8" }

	-- signatures
	require("lsp_signature").on_attach({
		floating_window = true,
		hint_enable = false,
		doc_lines = 0,
		handler_opts = {
			border = "rounded",
		},
	}, bufnr)

	-- Mappings are created globally for simplicity
	lsp_keymaps(bufnr)
	-- Currently all formatting is handled with 'conform' plugin
	if vim.fn.has("nvim-0.8") == 1 then
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	else
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
	end
end

local diagnostic_opts = {
	-- Show gutter sings
	signs = {
		-- With highest priority
		priority = 9999,
		-- Only for warnings and errors
		severity = { min = "WARN", max = "ERROR" },
	},
	-- Show virtual text only for errors
	virtual_text = { severity = { min = "ERROR", max = "ERROR" } },
	-- Don't update diagnostics when typing
	update_in_insert = false,
}

vim.diagnostic.config(diagnostic_opts)
-- server configs with Mason
local lsp_options = { on_attach = on_attach_custom }

require("mason-lspconfig").setup_handlers({
	function(server_name)
		lspconfig[server_name].setup(lsp_options)
	end,

	-- Lua (lua_ls) ==========================================================
	["lua_ls"] = function()
		lspconfig.lua_ls.setup(vim.tbl_deep_extend("force", lsp_options, {
			handlers = {
				-- Don't open quickfix list in case of multiple definitions. At the
				-- moment, this conflicts the `a = function()` code style because
				-- lua_ls treats both `a` and `function()` to be definitions of `a`.
				["textDocument/definition"] = function(_, result, ctx, _)
					-- Adapted from source:
					-- https://github.com/neovim/neovim/blob/master/runtime/lua/vim/lsp/handlers.lua#L341-L366
					if result == nil or vim.tbl_isempty(result) then
						return nil
					end
					local client = vim.lsp.get_client_by_id(ctx.client_id)

					local res = vim.tbl_islist(result) and result[1] or result
					vim.lsp.util.jump_to_location(res, client.offset_encoding)
				end,
			},
			on_attach = function(client, bufnr)
				on_attach_custom(client, bufnr)
				-- Reduce unnecessarily long list of completion triggers for better
				-- `MiniCompletion` experience
				client.server_capabilities.completionProvider.triggerCharacters = { ".", ":" }
			end,
			settings = {
				Lua = {
					diagnostics = {
						-- Get the language server to recognize common globals
						globals = { "vim", "describe", "it", "before_each", "after_each" },
						disable = { "need-check-nil" },
					},
					workspace = {
						-- Don't analyze code from submodules
						ignoreSubmodules = true,
						-- Make the server aware of Neovim runtime files
						-- library = { [vim.fn.expand("$VIMRUNTIME/lua")] = true, [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true },
					},
					-- Do not send telemetry data containing a randomized but unique identifier
					telemetry = {
						enable = false,
					},
				},
			},
		}))
	end,
	-- C/C++ (clangd) =============================================================
	-- Install as system package (`sudo pacman -S llvm clang`)
	-- default capabilities are OK for now
	["clangd"] = function()
		lspconfig.clangd.setup(vim.tbl_deep_extend("force", lsp_options, {}))
	end,
	-- Typescript (tsserver) ======================================================
	["tsserver"] = function()
		lspconfig.tsserver.setup(vim.tbl_deep_extend("force", lsp_options, {}))
	end,
  ["rust_analyzer"] = function ()
    lspconfig.rust_analyzer.setup(vim.tbl_deep_extend("force", lsp_options, {}))
  end
})
