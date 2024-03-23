local options = {
	backup = false, -- creates a backup file
  -- use xclip in X and wl-copy/wl-paste in wayland
	clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	-- completeopt = { "menuone", "noselect" }, -- mostly just for cmp
	conceallevel = 0, -- so that `` is visible in markdown files
	fileencoding = "utf-8", -- the encoding written to a file
	ignorecase = true, -- ignore case in search patterns
	-- guicursor = "i-r:block-Cursor",
	mouse = "a", -- allow the mouse to be used in neovim
	pumheight = 8, -- pop up menu height
	pumblend = 10, -- transparency of pop-up menu
	showmode = false, -- we don't need to see things like -- INSERT -- anymore
	smartcase = true, -- smart case
	smartindent = true, -- make indenting smarter again
	splitbelow = true, -- force all horizontal splits to go below current window
	splitright = true, -- force all vertical splits to go to the right of current window
	swapfile = true, -- creates a swapfile
	timeoutlen = 300, -- time to wait for a mapped sequence to complete (in milliseconds)
	termguicolors = true,
	undofile = true, -- enable persistent undo
	updatetime = 500, -- faster completion (4000ms default)
	writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	expandtab = true, -- convert tabs to spaces
	shiftwidth = 2, -- the number of spaces inserted for each indentation
	tabstop = 2, -- insert 2 spaces for a tab
	cursorline = true, -- highlight the current line
	laststatus = 3, -- global status line
	number = true, -- set numbered lines
	relativenumber = true, -- set relative numbered lines
	numberwidth = 2, -- set number column width to 4 {default 4}
	signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
	wrap = false, -- display lines as one long line
	scrolloff = 8, -- minimal number of columns to scroll horizontally.
	sidescrolloff = 8, -- minimal number of screen columns
	lazyredraw = true, -- Won't be redrawn while executing macros, register and other commands.
	-- shell = vim.fn.executable "pwsh" and "pwsh" or "powershell",
	-- shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
	-- shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
	-- shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
	-- shellquote = "",
	-- shellxquote = "",
}

local global = {
	did_load_filetypes = false,
	mkdp_auto_close = 0, -- Don't Exit Preview When Switching Buffers
	highlighturl_enabled = true, -- highlight URLs by default
	-- disable netrw at the very start of your init.lua (strongly advised)
	loaded = true,
	loaded_netrwPlugin = true,
	zipPlugin = true, -- disable zip
	load_black = true, -- disable black
	loaded_2html_plugin = true, -- disable 2html
	loaded_getscript = true, -- disable getscript
	loaded_getscriptPlugin = true, -- disable getscript
	loaded_gzip = true, -- disable gzip
	loaded_logipat = true, -- disable logipat
	loaded_matchit = true, -- disable matchit
	loaded_remote_plugins = true, -- disable remote plugins
	loaded_tar = true, -- disable tar
}

vim.opt.shortmess:append("A") -- Disable asking when editing file with swapfile.
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.iskeyword:append("-")

-- Set the char for the indent line
vim.g.indentline_char = '|'

-- vim.opt.listchars = { tab = "» ", eol = "↵" }
-- vim.opt.list = true

-- I am using tab and leadmultispace in listchars to display the indent line. The chars for tab and
-- leadmultispace should be updated based on whether the indentation has been changed.
-- * If using space as indentation: set tab to a special character for denotation and leadmultispace
-- to the indent line character followed by multiple spaces whose amounts depends on the number of
-- spaces to use in each step of indent.
-- * If using tab as indentation: set leadmultispace to a special character for denotation and tab
-- to the indent line character.
-- local function update(is_local)
--   local listchars_update = function(items)
--     local listchars = vim.api.nvim_get_option_value('listchars', {})
--     for item, val in pairs(items) do
--       if listchars:match(item) then
--         listchars = listchars:gsub('(' .. item .. ':)[^,]*', '%1' .. val)
--       else
--         listchars = listchars .. ',' .. item .. ':' .. val
--       end
--     end
--     return listchars
--   end
--   local new_listchars = ''
--   if vim.api.nvim_get_option_value('expandtab', {}) then
--     local spaces = vim.api.nvim_get_option_value('shiftwidth', {})
--     -- When shiftwidth is 0, vim will use tabstop value
--     if spaces == 0 then
--       spaces = vim.api.nvim_get_option_value('tabstop', {})
--     end
--     new_listchars = listchars_update({
--       tab = '› ',
--       leadmultispace = vim.g.indentline_char .. string.rep(' ', spaces - 1),
--     })
--   else
--     new_listchars = listchars_update({
--       tab = vim.g.indentline_char .. ' ',
--       leadmultispace = '␣'
--     })
--   end
--   local opts = {}
--   if is_local then
--     opts.scope = 'local'
--   end
--   vim.api.nvim_set_option_value('listchars', new_listchars, opts)
-- end
-- vim.api.nvim_create_augroup('indent_line', { clear = true })
-- vim.api.nvim_create_autocmd({ 'OptionSet' }, {
--   group = 'indent_line',
--   pattern = { 'shiftwidth', 'expandtab', 'tabstop' },
--   callback = function()
--     update(vim.v.option_type == 'local')
--   end,
-- })
-- -- OptionSet is not triggered on startup
-- -- This may be not needed. The listchars has been set properly in options.vim and it will be sourced
-- -- on startup.
-- vim.api.nvim_create_autocmd({ 'VimEnter' }, {
--   group = 'indent_line',
--   callback = function()
--     update(false)
--   end,
-- })



for k, v in pairs(options) do
	vim.opt[k] = v
end
for k, v in pairs(global) do
	vim.g[k] = v
end

if vim.fn.exists("g:neovide") == 1 then
	vim.opt.guifont = "JetBrainsMono Nerd Font:h8"
	vim.g.remember_window_size = true
	vim.g.remember_window_position = true
	local function toggleTransparency()
		if vim.g.neovide_transparency == 1.0 then
			vim.cmd("let g:neovide_transparency=0.8")
		else
			vim.cmd("let g:neovide_transparency=1.0")
		end
	end

	local function toggleFullscreen()
		if vim.g.neovide_fullscreen == false then
			vim.cmd("let g:neovide_fullscreen=v:true")
		else
			vim.cmd("let g:neovide_fullscreen=v:false")
		end
	end

	vim.keymap.set("n", "<F11>", toggleFullscreen, { silent = true })
	vim.keymap.set("n", "<F10>", toggleTransparency, { silent = true })
end
