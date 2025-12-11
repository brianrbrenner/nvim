return {
	"folke/trouble.nvim",
	opts = {
		auto_refresh = true,
		modes = {
			diagnostics_buffer = {
				mode = "diagnostics", -- inherit from diagnostics mode
				filter = { buf = 0 }, -- filter diagnostics to the current buffer
			},
			cascade = {
				mode = "diagnostics", -- inherit from diagnostics mode
				filter = function(items)
					local severity = vim.diagnostic.severity.HINT
					for _, item in ipairs(items) do
						severity = math.min(severity, item.severity)
					end
					return vim.tbl_filter(function(item)
						return item.severity == severity
					end, items)
				end,
				preview = {
					type = "split",
					relative = "win",
					position = "right",
					size = 0.3,
				},
			},
		},
	}, -- for default options, refer to the configuration section for custom setup.
	cmd = "Trouble",
	keys = {
		{
			"<leader>xx",
			"<cmd>Trouble cascade<cr>",
			desc = "Diagnostics (Trouble)",
		},
		{
			"<leader>xX",
			"<cmd>Trouble diagnostics_buffer<cr>",
			desc = "Buffer Diagnostics (Trouble)",
		},
		{
			"<leader>cs",
			"<cmd>Trouble symbols toggle focus=false<cr>",
			desc = "Symbols (Trouble)",
		},
		{
			"<leader>cl",
			"<cmd>Trouble lsp toggle focus=false win.position=bottom<cr>",
			desc = "LSP Definitions / references / ... (Trouble)",
		},
		{
			"<leader>xL",
			"<cmd>Trouble loclist toggle<cr>",
			desc = "Location List (Trouble)",
		},
		{
			"<leader>xQ",
			"<cmd>Trouble qflist toggle<cr>",
			desc = "Quickfix List (Trouble)",
		},
	},
}
