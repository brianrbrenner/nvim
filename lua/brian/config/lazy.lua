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
	-- the colorscheme should be available when starting Neovim
	{
		"folke/tokyonight.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme tokyonight-night]])
		end,
	},

	-- UTILS
	{ "nvim-lua/plenary.nvim" },
	{ "echasnovski/mini.nvim" },
	{ "kyazdani42/nvim-web-devicons" },
	{ "akinsho/toggleterm.nvim" },
	{ "lewis6991/gitsigns.nvim", lazy = true },
	-- Projects
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({
				show_hidden = true,
			})
		end,
	},
	-- I have a separate config.mappings file where I require which-key.
	-- With lazy the plugin will be automatically loaded when it is required somewhere
	{ "folke/which-key.nvim", lazy = true },

	-- FZF
	{ "ibhagwan/fzf-lua" },
	{ "junegunn/fzf", run = "./install --bin" },

	--LSP Install
	{ "williamboman/mason.nvim", lazy = true },
	{ "neovim/nvim-lspconfig" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "jose-elias-alvarez/null-ls.nvim" },

	-- Treesitter
	{ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },

	{ "kyazdani42/nvim-tree.lua", lazy = true },
})
