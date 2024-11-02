local fn = vim.fn

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- General Settings
local general = augroup("General Settings", { clear = true })

-- Disable Bufferline And Lualine in Alpha
autocmd("User", {
	pattern = "AlphaReady",
	callback = function()
		vim.opt.cmdheight = 0
		vim.opt.laststatus = 0
		autocmd("BufUnload", {
			pattern = "<buffer>",
			callback = function()
				vim.opt.cmdheight = 1
				vim.opt.laststatus = 3
			end,
		})
	end,
})

-- Go To The Last Cursor Postion
autocmd("BufReadPost", {
	callback = function()
		if fn.line("'\"") > 1 and fn.line("'\"") <= fn.line("$") then
			vim.cmd('normal! g`"')
		end
	end,
	group = general,
})

-- Highlight when yanking
autocmd("TextYankPost", {
	callback = function()
		require("vim.highlight").on_yank({ higroup = "Visual", timeout = 200 })
	end,
	group = general,
})

-- Disable New Line Comment
autocmd("BufEnter", {
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
	group = general,
})

autocmd("FileType", {
	pattern = { "py", "java", "cs" },
	callback = function()
		vim.bo.shiftwidth = 4
		vim.bo.tabstop = 4
	end,
	group = general,
})

autocmd("FileType", {
	pattern = { "c", "h" },
	callback = function()
		vim.bo.shiftwidth = 8
		vim.bo.tabstop = 8
	end,
	group = general,
})

-- Update file
autocmd("FocusGained", {
	callback = function()
		vim.cmd("checktime")
	end,
	group = general,
})

-- Equalize Splits
autocmd("VimResized", {
	callback = function()
		vim.cmd("wincmd =")
	end,
	group = general,
})

-- Highlighting match words when searching
autocmd("ModeChanged", {
	callback = function()
		if fn.getcmdtype() == "/" or fn.getcmdtype() == "?" then
			vim.opt.hlsearch = true
		else
			vim.opt.hlsearch = false
		end
	end,
	group = general,
})

-- Enable Wrap in these filetypes
autocmd("FileType", {
	pattern = { "gitcommit", "markdown", "text", "log" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
	group = general,
})

-- Close NvimTree
vim.api.nvim_create_autocmd("BufEnter", {
	group = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true }),
	pattern = "NvimTree_*",
	callback = function()
		local layout = vim.api.nvim_call_function("winlayout", {})
		if
			layout[1] == "leaf"
			and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree"
			and layout[3] == nil
		then
			vim.cmd("confirm quit")
		end
	end,
})

-- JDTLS
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "*.java" },
	callback = function()
		require("brian.config.jdtls").setup_config()
	end,
})

-- Session
vim.api.nvim_create_autocmd("VimLeavePre", {
	pattern = "*",
	callback = function()
		if vim.g.savesession then
			if vim.g.sessionfile ~= "" then
			  vim.api.nvim_command(string.format("mks! %s", vim.g.sessionfile))
			end
		end
	end,
})
