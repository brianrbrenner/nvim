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

require("lazy").setup({
	-- {
	-- 	"brianrbrenner/nvim-jellybeans",
 --    priority = 1000,
	-- 	dependencies = "rktjmp/lush.nvim",
	-- 	config = function()
	-- 		vim.cmd([[colorscheme jellybeans]])
	-- 	end,
	-- },
  {
    "rose-pine/neovim",
    lazy = false,
    priority = 1000,
    name = "rose-pine"
  },
	{ "typicode/bg.nvim", lazy = false },
	{ "goolord/alpha-nvim" },
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
			require("colorizer").setup({})
		end,
		lazy = false,
	},
	-- LIB
	{ "nvim-lua/plenary.nvim" },
	-- GIT
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
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
	{ "hrsh7th/cmp-nvim-lsp-signature-help" },
	{ "hrsh7th/nvim-cmp" },
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
	-- TODO: if needed, set this up under ftplugin/rust.lua
	-- {
	-- 	"mrcjkb/rustaceanvim",
	-- 	version = "^3", -- Recommended
	-- 	ft = { "rust" },
	-- },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "folke/neodev.nvim", opts = {} },
	{ "stevearc/conform.nvim", opts = {} },

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
