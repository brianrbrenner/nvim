return {
	"akinsho/bufferline.nvim",
	event = { "BufReadPost", "BufNewFile" },
	version = "*",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local bufferline = require("bufferline")
		-- local p = require("base16-colorscheme").colors
		bufferline.setup({
			options = {
				separator_style = { "", "" },
				indicator = {
					icon = " ",
					style = "icon",
				},
				diagnostics = "nvim_lsp",
				offsets = {
					{
						separator = " ",
						highlight = "NvimTreeNormal",
						filetype = "NvimTree",
						text = "",
						text_align = "center",
					},
				},
			},
		})
	end,
}
