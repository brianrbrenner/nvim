return {
	"tzachar/local-highlight.nvim",
	config = function()
		require("local-highlight").setup({
			-- OR attach to every filetype except:
			disable_file_types = { "tex" },
			hlgroup = "LocalHighlight",
			cw_hlgroup = nil,
			-- Whether to display highlights in INSERT mode or not
			insert_mode = false,
			min_match_len = 1,
			max_match_len = math.huge,
			highlight_single_match = true,
			animate = {
				enabled = false,
				easing = "linear",
				duration = {
					step = 10, -- ms per step
					total = 100, -- maximum duration
				},
			},
			debounce_timeout = 200,
		})
	end,
}
