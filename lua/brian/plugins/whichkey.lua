return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local status_ok, which_key = pcall(require, "which-key")
		if not status_ok then
			return
		end

		which_key.setup({
			plugins = {
				marks = true, -- shows a list of your marks on ' and `
				registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
				spelling = {
					enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
					suggestions = 20, -- how many suggestions should be shown in the list?
				},
				presets = {
					operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
					motions = true, -- adds help for motions
					text_objects = true, -- help for text objects triggered after entering an operator					windows = true, -- default bindings on <c-w>
					nav = true, -- misc bindings to work with windows
					z = true, -- bindings for folds, spelling and others prefixed with z
					g = false, -- bindings for prefixed with g
				},
			},
			icons = {
				breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
				separator = "➜", -- symbol used between a key and it's label
				group = "+", -- symbol prepended to a group
			},
			keys = {
				scroll_down = "<c-d>", -- binding to scroll down inside the popup
				scroll_up = "<c-u>", -- binding to scroll up inside the popup
			},
			layout = {
				height = { min = 4, max = 25 }, -- min and max height of the columns
				width = { min = 20, max = 50 }, -- min and max width of the columns
				spacing = 3, -- spacing between columns
				align = "left", -- align columns left, center or right
			},
			show_help = false, -- show help message on the command line when the popup is visible
		})

		which_key.add({
			{ "<leader>S", group = "Search", nowait = true, remap = false },
			{ "<leader>SC", ":lua require('telescope.builtin').commands()<cr>", desc = "Commands", nowait = true, remap = false },
			{ "<leader>SH", ":lua require('telescope.builtin').highlights()<cr>", desc = "Highlights", nowait = true, remap = false },
			{ "<leader>Sb", ":lua require('telescope.builtin').git_branches()<cr>", desc = "Checkout branch", nowait = true, remap = false },
			{ "<leader>Sc", ":lua require('telescope.builtin').colorscheme()<cr>", desc = "Colorscheme", nowait = true, remap = false },
			{ "<leader>Sh", ":lua require('telescope.builtin').help_tags()", desc = "Find Help", nowait = true, remap = false },
			{ "<leader>Sk", ":lua require('telescope.builtin').keymaps()", desc = "Keymaps", nowait = true, remap = false },
			{
				"<leader>b",
				":lua require('telescope.builtin').buffers()<cr>",
				desc = "Buffers",
				nowait = true,
				remap = false,
			},
			{ "<leader>e", ":NvimTreeToggle<CR>", desc = "Explorer", nowait = true, remap = false },
			{ "<leader>f", group = "Files", nowait = true, remap = false },
			{ "<leader>ff", ":lua require('telescope.builtin').find_files()<cr>", desc = "Find files", nowait = true, remap = false },
			{ "<leader>fg", ":lua require('telescope.builtin').live_grep()<cr>", desc = "Find Text", nowait = true, remap = false },
			{ "<leader>fr", ":lua require('telescope.builtin').oldfiles()<cr>", desc = "Find recent files", nowait = true, remap = false },
			{ "<leader>fs", ":lua require('telescope.builtin').lsp_workspace_symbols()<cr>", desc = "Find workspace symbols", nowait = true, remap = false },
			{ "<leader>g", group = "Git", nowait = true, remap = false },
			{
				"<leader>gR",
				":lua require 'gitsigns'.reset_buffer()<cr>",
				desc = "Reset Buffer",
				nowait = true,
				remap = false,
			},
			{ "<leader>gb", ":lua require('telescope.builtin').git_branches()<cr>", desc = "Checkout branch", nowait = true, remap = false },
			{ "<leader>gc", ":lua require('telescope.builtin').git_commits()<cr>", desc = "Checkout commit", nowait = true, remap = false },
			{ "<leader>gd", ":Gitsigns diffthis HEAD<cr>", desc = "Diff", nowait = true, remap = false },
			{ "<leader>gf", ":lua require('telescope.builtin').git_files()<cr>", desc = "Find tracked files", nowait = true, remap = false },
			{ "<leader>gg", ":lua _LAZYGIT_TOGGLE()<cr>", desc = "Lazygit", nowait = true, remap = false },
			{
				"<leader>gj",
				":lua require 'gitsigns'.next_hunk()<cr>",
				desc = "Next Hunk",
				nowait = true,
				remap = false,
			},
			{
				"<leader>gk",
				":lua require 'gitsigns'.prev_hunk()<cr>",
				desc = "Prev Hunk",
				nowait = true,
				remap = false,
			},
			{ "<leader>gl", ":lua require 'gitsigns'.blame_line()<cr>", desc = "Blame", nowait = true, remap = false },
			{ "<leader>go", ":lua require('telescope.builtin').git_status()<cr>", desc = "Git Status", nowait = true, remap = false },
			{
				"<leader>gp",
				":lua require 'gitsigns'.preview_hunk()<cr>",
				desc = "Preview Hunk",
				nowait = true,
				remap = false,
			},
			{
				"<leader>gr",
				":lua require 'gitsigns'.reset_hunk()<cr>",
				desc = "Reset Hunk",
				nowait = true,
				remap = false,
			},
			{
				"<leader>gs",
				":lua require 'gitsigns'.stage_hunk()<cr>",
				desc = "Stage Hunk",
				nowait = true,
				remap = false,
			},
			{
				"<leader>gu",
				":lua require 'gitsigns'.undo_stage_hunk()<cr>",
				desc = "Undo Stage Hunk",
				nowait = true,
				remap = false,
			},
			{ "<leader>l", group = "LSP", nowait = true, remap = false },
			{ "<leader>lR", ":lua require('telescope.builtin').lsp_references()<cr>", desc = "References", nowait = true, remap = false },
			{
				"<leader>lS",
				":lua require('telescope.builtin').lsp_workspace_symbols()<cr>",
				desc = "Workspace Symbols",
				nowait = true,
				remap = false,
			},
			{ "<leader>la", ":lua vim.lsp.buf.code_action()<cr>", desc = "Code Action", nowait = true, remap = false },
			{ "<leader>ld", ":lua require('telescope.builtin').diagnostics()<cr>", desc = "Workspace Diagnostics", nowait = true, remap = false },
			{ "<leader>lf", ":lua require('conform').format()<cr>", desc = "Format", nowait = true, remap = false },
			{ "<leader>li", ":LspInfo<cr>", desc = "Info", nowait = true, remap = false },
			{
				"<leader>lj",
				":lua vim.diagnostic.goto_prev()<cr>",
				desc = "Prev Diagnostic",
				nowait = true,
				remap = false,
			},
			{
				"<leader>lk",
				":lua vim.diagnostic.goto_next()<cr>",
				desc = "Next Diagnostic",
				nowait = true,
				remap = false,
			},
			{ "<leader>lm", ":Mason<cr>", desc = "Mason Installer", nowait = true, remap = false },
			{ "<leader>lq", ":lua require('telescope.builtin').quickfix()<cr>", desc = "Quickfix List", nowait = true, remap = false },
			{ "<leader>lr", ":lua vim.diagnostic.rename<cr>", desc = "Rename", nowait = true, remap = false },
			{
				"<leader>ls",
				":lua require('telescope.builtin').lsp_document_symbols()<cr>",
				desc = "Document Symbols",
				nowait = true,
				remap = false,
			},
			{ "<leader>q", ":qa!<cr>", desc = "Exit", nowait = true, remap = false },
      { "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], desc = "Replace all in file"},
			{ "<leader>t", group = "Terminal", nowait = true, remap = false },
			{ "<leader>tf", ":ToggleTerm direction=float<cr>", desc = "Terminal Float", nowait = true, remap = false },
			{
				"<leader>th",
				":ToggleTerm size=10 direction=horizontal<cr>",
				desc = "Terminal Horizontal",
				nowait = true,
				remap = false,
			},
			{
				"<leader>tv",
				":ToggleTerm size=50 direction=vertical<cr>",
				desc = "Terminal Vertical",
				nowait = true,
				remap = false,
			},
			{ "<leader>y", ":%y+<cr>", desc = "Yank All Text", nowait = true, remap = false },
		})
	end,
}
