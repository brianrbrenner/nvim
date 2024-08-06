return {
	"nvim-tree/nvim-tree.lua",
	cmd = { "NvimTreeToggle", "NvimTreeFocus" },
	config = function()
		require("nvim-tree").setup({
			view = {
				width = 50,
				centralize_selection = true,
			},
			update_cwd = true,
			update_focused_file = {
				enable = true,
				update_cwd = true,
			},
		})
	end,
}
