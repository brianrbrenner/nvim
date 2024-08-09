return {
	"numToStr/Comment.nvim",
	dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
	keys = {
		{ "gcc", mode = "n", desc = "Comment toggle current line" },
		{ "gbc", mode = "n", desc = "Comment toggle current block" },
		{ "gco", mode = "n", desc = "Insert comment to the next line and enters INSERT mode" },
		{ "gcO", mode = "n", desc = "Insert comment to the previous line and enters INSERT mode" },
		{ "gcA", mode = "n", desc = "Insert comment to end of the current line and enters INSERT mode" },
		{ "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
		{ "gcl", mode = { "n", "o" }, desc = "Comment toggle linewise" },
		{ "gcv", mode = "x", desc = "Comment toggle linewise (visual)" },
		{ "gbv", mode = "x", desc = "Comment toggle blockwise (visual)" },
	},
	config = function()
    require("Comment").setup({
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    })
	end,
}
