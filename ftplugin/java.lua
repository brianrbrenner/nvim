require("brian.config.jdtls").setup_jdtls()
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
local springboot = require("springboot-nvim")

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
	{ "<leader>jo", ":lua require('jdtls').organize_imports()<CR>", desc = "Organize Imports" },
	{ "<leader>jt", group = "Test", nowait = true, remap = false },
	{ "<leader>jtc", ":lua require('jdtls').test_class()<CR>", desc = "Class" },
	{ "<leader>jtm", ":lua require('jdtls').test_nearest_method()<CR>", desc = "Nearest Method" },
	{
		"<leader>jrd",
		":lua require('springboot-nvim').boot_run('-Pdev')",
		desc = "Run Dev Profile",
		nowait = true,
		remap = false,
	},
	{ "<leader>jgc", springboot.generate_class, desc = "Generate Class", nowait = true, remap = false },
	{ "<leader>jgi", springboot.generate_interface, desc = "Generate Interface", nowait = true, remap = false },
	{ "<leader>jge", springboot.generate_enum, desc = "Generate Enum", nowait = true, remap = false },
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
