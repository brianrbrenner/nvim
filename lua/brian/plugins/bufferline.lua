return {
	"akinsho/bufferline.nvim",
	after = "catppuccin",
	event = { "BufReadPost", "BufNewFile" },
	version = "*",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local bufferline = require("bufferline")
		bufferline.setup({
			-- TODO: Fix background highlights for diagnostics
			highlights = require("catppuccin.groups.integrations.bufferline").get(),
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
