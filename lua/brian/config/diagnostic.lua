vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "X ",
			[vim.diagnostic.severity.WARN] = "W ",
			[vim.diagnostic.severity.INFO] = "INFO ",
			[vim.diagnostic.severity.HINT] = "? ",
		},
	},
	float = {
		header = "",
	},
	severity_sort = true,
})
