return {
	-- {
	-- 	"mcauley-penney/ice-cave.nvim",
	-- 	config = function()
	-- 		-- vim.cmd.colorscheme("ice-cave")
	-- 	end,
	-- 	priority = 1000,
	-- },
	{
		"aktersnurra/no-clown-fiesta.nvim",
		priority = 1000,
		config = function()
			local plugin = require("no-clown-fiesta")
			plugin.setup({
				styles = {
					type = { bold = true },
					lsp = { underline = false },
					match_paren = { underline = true },
				},
			})

			plugin.load()

			vim.cmd.colorscheme("no-clown-fiesta")
      vim.cmd[[hi LspInlayHint guibg=#151515 guifg=#373737]]
		end,
		lazy = false,
	},
}
-- {
-- "datsfilipe/vesper.nvim",
-- config = function()
-- 	require("vesper").setup({
-- 		transparent = false, -- Boolean: Sets the background to transparent
-- 		italics = {
-- 			comments = true, -- Boolean: Italicizes comments
-- 			keywords = false, -- Boolean: Italicizes keywords
-- 			functions = false, -- Boolean: Italicizes functions
-- 			strings = false, -- Boolean: Italicizes strings
-- 			variables = false, -- Boolean: Italicizes variables
-- 		},
-- 		overrides = {}, -- A dictionary of group names, can be a function returning a dictionary or a table.
-- 		palette_overrides = {},
-- 	})
--
--     vim.cmd.colorscheme("vesper")
--     vim.cmd([[autocmd VimEnter * hi MatchParen guifg=#ed333b]])
-- end,
-- },
-- {
-- 	"wtfox/jellybeans.nvim",
-- 	priority = 1000,
-- 	config = function()
-- 		require("jellybeans").setup()
-- 		-- vim.cmd.colorscheme("jellybeans")
-- 	end,
-- },
-- {
-- 	"brianrbrenner/fluery.nvim",
-- 	priority = 1000,
-- 	config = function()
-- 		-- vim.cmd.colorscheme("fluery")
-- 	end,
-- },
-- {
-- 	"ramojus/mellifluous.nvim",
-- 	priority = 1000,
-- 	config = function()
-- 		require("mellifluous").setup({
-- 			styles = { -- see :h attr-list for options. set {} for NONE, { option = true } for option
-- 				main_keywords = { bold = true },
-- 			},
-- 		})
--      vim.cmd.colorscheme("mellifluous")
-- 	end,
-- },
--   {
--   "timmypidashev/darkbox.nvim",
--   lazy = false,
--   config = function()
--     require("darkbox").load()
--   end
-- }
