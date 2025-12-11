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
			-- vim.cmd.colorscheme("jellybeans-muted")
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
			-- vim.cmd([[let g:gruvbox_contrast_dark = 'hard']])
			-- vim.cmd.colorscheme("gruvbox")
		end,
	},
	{
		"wincent/base16-nvim",
		lazy = false, -- load at start
		priority = 1000, -- load first
		config = function()
			vim.cmd([[colorscheme gruvbox-dark-hard]])
			vim.o.background = "dark"
			-- Less visible window separator
			vim.api.nvim_set_hl(0, "WinSeparator", { fg = 1250067 })
			-- Make comments more prominent -- they are important.
			local bools = vim.api.nvim_get_hl(0, { name = "Boolean" })
			vim.api.nvim_set_hl(0, "Comment", bools)
			-- Make it clearly visible which argument we're at.
			local marked = vim.api.nvim_get_hl(0, { name = "PMenu" })
			vim.api.nvim_set_hl(
				0,
				"LspSignatureActiveParameter",
				{ fg = marked.fg, bg = marked.bg, ctermfg = marked.ctermfg, ctermbg = marked.ctermbg, bold = true }
			)
			-- XXX
			-- Would be nice to customize the highlighting of warnings and the like to make
			-- them less glaring. But alas
			-- https://github.com/nvim-lua/lsp_extensions.nvim/issues/21
			-- call Base16hi("CocHintSign", g:base16_gui03, "", g:base16_cterm03, "", "", "")
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
