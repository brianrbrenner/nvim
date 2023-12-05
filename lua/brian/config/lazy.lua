local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.opt.list = true

require("lazy").setup({
	{
		"brianrbrenner/nvim-jellybeans",
		dependencies = "rktjmp/lush.nvim",
		config = function()
			vim.cmd([[colorscheme jellybeans]])
		end,
	},
  {
		"goolord/alpha-nvim",
	},
	-- BUFFERS
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
	},
	-- LUALINE
	{
		"nvim-lualine/lualine.nvim",
	},
	-- COMMENTS
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
		lazy = false,
	},
	-- FLASH
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
		--- stylua: ignore
		keys = {
			{
				"s",
				mode = { "n", "o", "x" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "o", "x" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},
	-- AUTOPAIRS
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},
	-- COLORIZER
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
		lazy = false,
	},
	-- LIB
	{ "nvim-lua/plenary.nvim" },
	-- TERMINAL
	{ "akinsho/toggleterm.nvim" },
	-- GIT
	{ "lewis6991/gitsigns.nvim", lazy = true },
	-- GET ROOT
	{
		"notjedi/nvim-rooter.lua",
		config = function()
			require("nvim-rooter").setup()
		end,
	},
	{ "folke/which-key.nvim", lazy = true },

	-- CMP
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/nvim-cmp" },
	{ "ray-x/lsp_signature.nvim" },
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup()
		end,
	},
	-- SNIPS
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "<CurrentMajor>.*",
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
	},
	{ "saadparwaiz1/cmp_luasnip" },
	{ "rafamadriz/friendly-snippets" },

	-- FZF
	{ "ibhagwan/fzf-lua" },
	{ "junegunn/fzf", run = "./install --bin" },

	--LSP
	{ "williamboman/mason.nvim", lazy = true },
	{ "neovim/nvim-lspconfig" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "folke/neodev.nvim", opts = {} },
	{ "stevearc/conform.nvim", opts = {} },
	-- { "simrat39/rust-tools.nvim" },

	-- Treesitter
	{ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },

	{ "kyazdani42/nvim-tree.lua", lazy = true },

	-- HIGHLIGHT UNDER WORD
	{
		"tzachar/local-highlight.nvim",
		config = function()
			require("local-highlight").setup()
		end,
	},
})
