return {
	"utilyre/barbecue.nvim",
	name = "barbecue",
	version = "*",
	dependencies = {
		"SmiteshP/nvim-navic",
	},
	opts = {},
	config = function()
		require("barbecue").setup({
			show_dirname = false,
		})
		require("barbecue.ui").toggle(false)
	end,
}
