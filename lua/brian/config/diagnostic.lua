local config = {
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "X ",
			[vim.diagnostic.severity.WARN] = "W ",
			[vim.diagnostic.severity.HINT] = "H ",
			[vim.diagnostic.severity.INFO] = "i ",
		},
	},
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "single",
		source = "always",
		header = "",
		prefix = "",
		suffix = "",
	},
}

vim.diagnostic.config(config)
