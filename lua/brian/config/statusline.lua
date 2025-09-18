local modes = {
	n = "NOR",
	no = "ONR",
	nov = "ONR",
	noV = "ONR",
	["no\22"] = "ONR",
	niI = "NOR",
	niR = "NOR",
	niV = "NOR",
	nt = "NOR",
	v = "VIS",
	vs = "VIS",
	V = "VLN",
	Vs = "VLN",
	["\22"] = "VBL",
	["\22s"] = "VBL",
	s = "SEL",
	S = "SLN",
	["\19"] = "SBL",
	i = "INS",
	ic = "INS",
	ix = "INS",
	R = "REP",
	Rc = "REP",
	Rx = "REP",
	Rv = "REP",
	Rvc = "REP",
	Rvx = "REP",
	c = "CMD",
	cv = "CMD",
	r = "PRM",
	rm = "MOR",
	["r?"] = "CNF",
	["!"] = "SHL",
	t = "TRM",
}

local function mode()
	return modes[vim.fn.mode(1)]
end

local function git_branch()
	return vim.g.git_branch and string.format(" %s", vim.g.git_branch) or nil
end

local function diagnostics()
	local parts = {}
	for _, s in ipairs({
		vim.diagnostic.severity.ERROR,
		vim.diagnostic.severity.WARN,
		vim.diagnostic.severity.INFO,
		vim.diagnostic.severity.HINT,
	}) do
		local diagnostic = #vim.diagnostic.get(0, { severity = s })
		local icon = vim.diagnostic.config().signs.text[s]
		if diagnostic > 0 then
			table.insert(parts, icon .. diagnostic)
		end
	end

	return not vim.tbl_isempty(parts) and table.concat(parts, " ") or nil
end

local function file_name()
	local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.")
	return name ~= "" and name or "[No Name]"
end

local function file_icon()
	local icon, _, _ = require("nvim-web-devicons").get_icon(vim.fn.expand("%:t"), vim.bo.filetype)
	return icon
end

local function file_status()
	if vim.bo.modified then
		return "●"
	end

	if vim.bo.readonly then
		return ""
	end

	return ""
end

local function recording()
	local rec = vim.fn.reg_recording()
	return rec ~= "" and "󰻂 recording @" .. rec or nil
end

local function search()
	if vim.v.hlsearch <= 0 then
		return nil
	end

	local _, res = pcall(vim.fn.searchcount, { maxcount = 999, timeout = 500 })
	if not res.total or res.total <= 0 then
		return nil
	end

	return string.format(" %" .. #tostring(res.total) .. "d/%d", res.current, res.total)
end

local function ruler()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local row = cursor[1]
	local col = cursor[2] + 1
	local lines = vim.api.nvim_buf_line_count(0)
	local pos = nil

	if row == 1 then
		pos = "TOP"
	elseif row == lines then
		pos = "BOT"
	else
		pos = string.format("%2d%%%%", math.floor((row / lines) * 100))
	end

	return string.format("%" .. #tostring(lines) .. "d:%-3d %s", row, col, pos)
end

local function with_padding(func)
	local str = func()
	return str and " " .. str .. " " or ""
end

function Statusline()
	return "%#Bold#"
		.. with_padding(mode)
		.. with_padding(git_branch)
		.. with_padding(diagnostics)
		.. with_padding(file_icon)
		.. "%<"
		.. file_name()
		.. with_padding(file_status)
		.. "%="
		.. with_padding(recording)
		.. with_padding(search)
		.. with_padding(ruler)
end

vim.opt.statusline = "%!v:lua.Statusline()"
