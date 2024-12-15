return {
	"iguanacucumber/magazine.nvim",
  name = "nvim-cmp", -- Othevent = "InsertEnter",
  enabled = true,
	dependencies = {
		{ "iguanacucumber/mag-nvim-lsp", name = "cmp-nvim-lsp", opts = {} },
    { "iguanacucumber/mag-nvim-lua", name = "cmp-nvim-lua" },
    { "iguanacucumber/mag-buffer", name = "cmp-buffer" },
    { "iguanacucumber/mag-cmdline", name = "cmp-cmdline" },{
			"L3MON4D3/LuaSnip",
			dependencies = {
				"saadparwaiz1/cmp_luasnip",
				"rafamadriz/friendly-snippets",
			},
			version = "2.*",
			build = "make install_jsregexp",
		},
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		require("luasnip.loaders.from_vscode").lazy_load()
		cmp.setup({
			window = {
				completion = cmp.config.window.bordered({
					scrollbar = false,
					winhighlight = "",
				}),
				documentation = cmp.config.window.bordered({
					-- border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
					scrollbar = false,
					winhighlight = "",
				}),
			},
			mapping = {
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-d>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.close(),
				["<Tab>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Insert,
					select = true,
				}),
				["<Down>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif require("luasnip").expand_or_jumpable() then
						vim.fn.feedkeys(
							vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true),
							""
						)
					else
						fallback()
					end
				end, {
					"i",
					"s",
				}),
				["<Up>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif require("luasnip").jumpable(-1) then
						vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
					else
						fallback()
					end
				end, {
					"i",
					"s",
				}),
			},
			completion = {
				completeopt = "menu,menuone",
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			sources = {
				{ name = "nvim_lsp_signature_help" },
				{ name = "nvim_lsp", keyword_length = 1, max_item_count = 10 },
				{ name = "nvim_lua", keyword_length = 1, max_item_count = 5 },
				{ name = "luasnip", keyword_length = 1, max_item_count = 5 },
				{ name = "path" },
				{ name = "buffer", keyword_length = 3 },
			},
		})
	end,
}
