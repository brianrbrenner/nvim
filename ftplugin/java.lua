require("barbecue.ui").toggle(true)

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client then
			client.server_capabilities.semanticTokensProvider = nil
		end
	end,
})

local wk = require("which-key")

local code_action = function(action)
	return vim.lsp.buf.code_action({
		context = { only = { action } },
		apply = true,
	})
end

wk.add({
	{ "<leader>j", group = "Java", nowait = true, remap = false },
	{
		"<leader>jb",
		":TermExec cmd='mvn clean install -DskipTests'<CR>",
		desc = "Clean Install - no tests",
		nowait = true,
		remap = false,
	},
	{ "<leader>ji", ":TermExec cmd='mvn clean install'<CR>", desc = "Clean Install", nowait = true, remap = false },
	{
		"<leader>jo",
		code_action("source.organizeImports"),
		desc = "Organize Imports",
	},
	{ "<leader>jt", group = "Test", nowait = true, remap = false },
	{ "<leader>jtc", ":JavaTestRunCurrentClass<CR>", desc = "Class" },
	{ "<leader>jtm", ":JavaTestRunCurrentMethod<CR>", desc = "Nearest Method" },
	{ "<leader>jd", group = "Debug", nowait = true, remap = false },
	{ "<leader>jdc", ":JavaTestDebugCurrentClass<CR>", desc = "Class" },
	{ "<leader>jdm", ":JavaTestDebugCurrentMethod<CR>", desc = "Nearest Method" },
	{ "<leader>jr", group = "Run", nowait = true, remap = false },
	{
		"<leader>jrd",
		":lua require('springboot-nvim').boot_run('-Pdev')<CR>",
		desc = "Run Dev Profile",
		nowait = true,
		remap = false,
	},
	{ "<leader>jg", group = "Generate", nowait = true, remap = false },
  -- this hopefully soon
	-- { "<leader>jgc", code_action("source.generate.class"), desc = "Generate Class", nowait = true, remap = false },
-- 	{ "<leader>jgi", springboot.generate_interface, desc = "Generate Interface", nowait = true, remap = false },
-- 	{ "<leader>jge", springboot.generate_enum, desc = "Generate Enum", nowait = true, remap = false },
})

require("nvim-tree").setup({
	view = {
		width = 50,
		centralize_selection = true,
	},
	update_cwd = true,
	update_focused_file = {
		enable = true,
		update_cwd = true,
	},
})
