local fn = vim.fn

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- General Settings
local general = augroup("General Settings", { clear = true })

-- Disable Bufferline And Lualine in Alpha
autocmd("User", {
	pattern = "AlphaReady",
	callback = function()
		vim.opt.showtabline = 0
		vim.opt.cmdheight = 0
		vim.opt.laststatus = 0
		autocmd("BufUnload", {
			pattern = "<buffer>",
			callback = function()
				vim.opt.cmdheight = 1
				vim.opt.showtabline = 2
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
	pattern = { "c", "h", "cpp", "hpp", "rs" },
	callback = function()
		vim.bo.shiftwidth = 8
		vim.bo.tabstop = 8
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
