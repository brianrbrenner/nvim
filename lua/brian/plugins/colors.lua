return {
	{
		"mcauley-penney/ice-cave.nvim",
		config = function()
			-- vim.cmd.colorscheme("ice-cave")
		end,
		priority = 1000,
	},
	{
		"aktersnurra/no-clown-fiesta.nvim",
		priority = 1000,
		config = function()
			local plugin = require("no-clown-fiesta")
			plugin.setup({
				styles = {
					type = { bold = false },
					lsp = { underline = false },
					match_paren = { underline = true },
				},
			})

			-- plugin.load()
			-- --
			-- vim.cmd.colorscheme("no-clown-fiesta")
			-- vim.cmd[[hi LspInlayHint guibg=#151515 guifg=#373737]]
		end,
		lazy = false,
	},
	-- Using lazy.nvim
	{
		"deparr/tairiki.nvim",
		lazy = false,
		priority = 1000, -- recommended if you use tairiki as your default theme
		opts = {
			diagnostics = {
				darker = false, -- darken diagnostic virtual text
				background = true, -- add background to diagnostic virtual text
				undercurl = false, -- use undercurls for inline diagnostics
			},
			plugins = {
				auto = true, -- auto detect installed plugins, currently lazy.nvim only
				treesitter = true,
				semantic_tokens = true,
			},
		},
		config = function()
			-- require("tairiki").load()
		end,
	},
	{
		"wtfox/jellybeans.nvim",
		priority = 1000,
		config = function()
			-- require("jellybeans").setup()
			-- vim.cmd.colorscheme("jellybeans")
		end,
	},
	{
		"brianrbrenner/fluery.nvim",
		priority = 1000,
		config = function()
			-- vim.cmd.colorscheme("fluery")
		end,
	},
	{
		"ramojus/mellifluous.nvim",
		priority = 1000,
		config = function()
			require("mellifluous").setup({
				styles = { -- see :h attr-list for options. set {} for NONE, { option = true } for option
					main_keywords = { bold = false },
				},
			})
			-- vim.cmd.colorscheme("mellifluous")
		end,
	},
	{
		"timmypidashev/darkbox.nvim",
		lazy = false,
		config = function()
			-- require("darkbox").load()
		end,
	},
	{
		"morhetz/gruvbox",
		lazy = false,
		config = function()
			-- vim.cmd[[let g:gruvbox_contrast_dark = 'hard']]
			-- vim.cmd.colorscheme("gruvbox")
		end,
	},
	{
		"sainnhe/gruvbox-material",
		lazy = false,
		config = function()
			-- vim.cmd.colorscheme("gruvbox-material")
		end,
	},
	{
		"ferdinandrau/carbide.nvim",
		priority = 1000,
		config = function(_, opts)
			-- require("carbide").setup(opts)
			-- require("carbide").apply()
		end,
	},
	{
		"vague2k/vague.nvim",
		config = function()
			require("vague").setup()
      vim.cmd.colorscheme('vague')
		end,
	},
}
