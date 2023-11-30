require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		-- python = { "isort", "black" },
		-- Use a sub-list to run only the first available formatter
		javascript = { { "prettierd", "prettier" } },
		rust = { "rustfmt" },
		c = { "clang_format" },
    h = { "clang_format" },
    cpp = { "clang_format" },
    hpp = { "clang_format" },
	},
})
