require("catppuccin").setup({
	flavor = "catppuccin-mocha",
	transparent_background = false,
	term_colors = false,

	compile = {
		enabled = false,
		path = vim.fn.stdpath("cache") .. "/catppuccin",
	},

	dim_inactive = {
		enabled = true,
		shade = "dark",
		percentage = 0.15,
	},

	styles = {
		comments = { "italic" },
		conditionals = { "italic" },
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
	},

	integrations = {
		treesitter = true,
		gitsigns = true,
		nvimtree = true,
		which_key = true,
    mini = true,
	},

	color_overrides = {},

	highlight_overrides = {},
})
vim.cmd("colorscheme catppuccin")
