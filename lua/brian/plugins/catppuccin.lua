require("catppuccin").setup({
	flavour = "mocha", -- latte, frappe, macchiato, mocha
	term_colors = true,
	transparent_background = false,
	no_italic = false,
	no_bold = false,
	styles = {
		comments = { "italic" },
		conditionals = {},
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
	},
	color_overrides = {
		mocha = {
			base = "#000000",
			mantle = "#000000",
			crust = "#000000",
		},
	},
	integrations = {
		cmp = false,
		gitsigns = true,
		nvimtree = true,
		telescope = false,
		notify = false,
		mini = true,
	},
	highlight_overrides = {
		mocha = function(C)
			return {
				-- TabLineSel = { bg = C.pink },
				CmpBorder = { fg = C.surface2 },
				Pmenu = { bg = C.none },
				TelescopeBorder = { link = "FloatBorder" },
			}
		end,
	},
})
