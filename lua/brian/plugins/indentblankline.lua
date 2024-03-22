return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = {},
	config = function()
		require("ibl").setup({
      exclude = {
        filetypes = { 'rust', 'c', 'c++', 'zig' }
      }
    })
	end,
}
