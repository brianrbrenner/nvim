local M = {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
}

function M.config()
	local null_ls = require("null-ls")
	local formatting = null_ls.builtins.formatting

	null_ls.setup({
		debug = true,
		sources = {
			formatting.stylua,
			formatting.prettier,
			require("none-ls.diagnostics.eslint_d"),
		},
	})
end

return M
