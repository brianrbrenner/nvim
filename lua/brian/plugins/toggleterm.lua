require("toggleterm").setup({
	size = 10,
	on_open = function()
		vim.cmd("startinsert")
	end,
	open_mapping = [[<c-\>]],
	hide_numbers = true,
	shade_terminals = false,
	insert_mappings = true,
	persist_size = true,
	direction = "float",
	close_on_exit = true,
	shell = vim.o.shell,
	autochdir = true, -- when neovim changes it current directory the terminal will change it's own when next it's opened
	highlights = {
		NormalFloat = {
			link = "Normal",
		},
		FloatBorder = {
			link = "FloatBorder",
		},
	},
	float_opts = {
		border = "rounded",
		winblend = 8,
	},
})
local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _LAZYGIT_TOGGLE()
	lazygit:toggle()
end
