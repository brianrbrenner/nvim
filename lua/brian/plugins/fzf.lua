return {
	{ "ibhagwan/fzf-lua" },
	{ "junegunn/fzf", run = "./install --bin" },
	config = function()
		require("fzf-lua").setup({
			lsp = {
				async_or_timeout = 3000,
			},
		})
	end,
}
