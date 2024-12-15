return {
	-- {
	-- 	"mcauley-penney/ice-cave.nvim",
	-- 	config = function()
	-- 		-- vim.cmd.colorscheme("ice-cave")
	-- 	end,
	-- 	priority = 1000,
	-- },
	{
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
	},
	{
		"wtfox/jellybeans.nvim",
		priority = 1000,
		config = function()
			require("jellybeans").setup()
			-- vim.cmd.colorscheme("jellybeans")
		end,
	},
  {
    "brianrbrenner/fluery.nvim",
    priority= 1000,
    config = function()
      vim.cmd.colorscheme("fluery")
    end,
  }
}
