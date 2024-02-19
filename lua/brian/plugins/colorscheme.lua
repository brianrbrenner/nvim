return {
	-- rose-pine
	-- "rose-pine/neovim",
	-- lazy = false,
	-- priority = 1000,
	-- name = "rose-pine",
	-- config = function()
	-- 	require("rose-pine").setup({
	-- 		highlight_groups = {
	-- 			TelescopeResultsTitle = { fg = "surface", bg = "surface" },
	-- 			TelescopeBorder = { fg = "surface", bg = "surface" },
	-- 			TelescopeSelection = { fg = "text", bg = "overlay", bold = true },
	-- 			TelescopeSelectionCaret = { fg = "text", bg = "highlight_med" },
	-- 			TelescopeMultiSelection = { fg = "text", bg = "highlight_high" },
	--
	-- 			TelescopeTitle = { fg = "base", bg = "love" },
	-- 			TelescopePromptTitle = { fg = "base", bg = "love" },
	-- 			TelescopePreviewTitle = { fg = "base", bg = "foam" },
	--
	-- 			TelescopePromptNormal = { bg = "overlay" },
	-- 			TelescopePromptBorder = { fg = "overlay", bg = "overlay" },
	-- 			TelescopePromptPrefix = { fg = "love", bg = "overlay" },
	-- 			NvimTreeCursorLine = { bg = "surface" },
	-- 			NvimTreeNormal = { bg = "#161420" },
	-- 			NvimTreeWinSeparator = { bg = "#161420", fg = "#161420" },
	-- 			CmpWinBorder = { fg = "overlay", bg = "base" },
	-- 		},
	-- 	})
	-- 	vim.cmd("colorscheme rose-pine")
	-- end,

	"catppuccin/nvim",
	name = "catppuccin",
	config = function()
		require("catppuccin").setup({
			term_colors = true,
			transparent_background = false,
			styles = {
				comments = {},
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
				telescope = {
					enabled = true,
					style = "nvchad",
				},
				dropbar = {
					enabled = true,
					color_mode = true,
				},
			},
		})

		vim.cmd("colorscheme catppuccin")
	end,
}
