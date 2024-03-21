return {
	"RRethy/base16-nvim",
	config = function()
		require("base16-colorscheme").with_config({
			telescope = true,
			indentblankline = true,
			notify = false,
			ts_rainbow = false,
			cmp = true,
			illuminate = true,
			dapui = false,
		})

    vim.cmd.colorscheme('base16-gruvbox-dark-hard')
	end,
}
