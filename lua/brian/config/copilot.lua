-- Keybinding for accepting suggestion
vim.api.nvim_set_keymap("i", "<C-Space>", "copilot#Accept('<CR>')", {
	expr = true,
	silent = true,
})
