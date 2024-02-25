local opts = { silent = true }
local command_opts = { expr = true }
local fn = vim.fn

local modes = {
	normal_mode = "n",
	insert_mode = "i",
	terminal_mode = "t",
	visual_mode = "v",
	visual_block_mode = "x",
	command_mode = "c",
}

local function forward_search()
	if fn.getcmdtype() == "/" or fn.getcmdtype() == "?" then
		return "<CR>/<C-r>/"
	end
	return "<C-z>"
end

local function backward_search()
	if fn.getcmdtype() == "/" or fn.getcmdtype() == "?" then
		return "<CR>?<C-r>/"
	end
	return "<S-Tab>"
end

local keymaps = {
	normal_mode = {
		-- buffers
		["gB"] = ":BufferLinePick<CR>",
		-- Better window navigation
		["<C-j>"] = "<C-w>j",
		["<C-k>"] = "<C-w>k",
		["<C-h>"] = "<C-w>h",
		["<C-l>"] = "<C-w>l",
		-- Move Next Window
		["<Leader>w"] = "<C-w>w",
		-- Close Window
		["Q"] = ":bp|bd #<CR>",
		-- Center screen on up and down half page
		["<C-u>"] = "<C-u>zz",
		["<C-d>"] = "<C-d>zz",

		-- Resize with arrows
		["<C-Up>"] = ":resize +2<CR>",
		["<C-Down>"] = ":resize -2<CR>",
		["<C-Left>"] = ":vertical resize +2<CR>",
		["<C-Right>"] = ":vertical resize -2<CR>",
		-- Navigate buffers
		["L"] = ":bnext<CR>",
		["H"] = ":bprevious<CR>",
		-- Indent lines
		["<"] = "<<",
		[">"] = ">>",

		-- trim whitespace
	},
	insert_mode = {
		-- exit other mode
		["jk"] = "<Esc>",
		["kj"] = "<Esc>",
	},
	terminal_mode = {},
	visual_mode = {
		-- Better Paste
		["p"] = '"_dP',
		-- exit other modes
		["jk"] = "<Esc>",
		-- Indent lines
		["<"] = "<gv",
		[">"] = ">gv",
		-- Move text up and down
		["<A-J>"] = ":m '>+1<CR>gv=gv",
		["<A-K>"] = ":m '<-2<CR>gv=gv",
	},
	visual_block_mode = {
		-- Move text up and down
		["<leader>p"] = '"_dP',
	},
	command_mode = {
		-- Word Search Increment and Decrement
		["ab>"] = forward_search,
		["<S-Tab>"] = backward_search,
	},
}

for i, k in pairs(keymaps.normal_mode) do
	vim.keymap.set(modes.normal_mode, i, k, opts)
end

for i, k in pairs(keymaps.insert_mode) do
	vim.keymap.set(modes.insert_mode, i, k, opts)
end

for i, k in pairs(keymaps.terminal_mode) do
	vim.keymap.set(modes.terminal_mode, i, k, opts)
end

for i, k in pairs(keymaps.visual_mode) do
	vim.keymap.set(modes.visual_mode, i, k, opts)
end

for i, k in pairs(keymaps.visual_block_mode) do
	vim.keymap.set(modes.visual_block_mode, i, k, opts)
end

for i, k in pairs(keymaps.command_mode) do
	vim.keymap.set(modes.command_mode, i, k, command_opts)
end

-- vim.api.nvim_set_keymap("i", "<CR>", "v:lua._G.cr_action()", { noremap = true, expr = true })

-- tabs complete
vim.api.nvim_set_keymap("i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { noremap = true, expr = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { noremap = true, expr = true })

-- search and replace
vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
