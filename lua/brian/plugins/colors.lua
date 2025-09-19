return {
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
		opts = {},
		config = function()
			vim.cmd.colorscheme("jellybeans-muted")
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
			-- require("vague").setup()
			--    vim.cmd.colorscheme('vague')
		end,
	},
}
