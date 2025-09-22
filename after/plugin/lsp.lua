local autocmd = vim.api.nvim_create_autocmd
-- JDTLS
autocmd("FileType", {
	pattern = "java",
	callback = function()
		require("brian.config.jdtls_setup").setup({})
	end,
})


-- sonarlint setup
local mason = vim.fn.stdpath("data") .. "/mason"
require("sonarlint").setup({
	server = {
		cmd = {
			"sonarlint-language-server",
			-- Ensure that sonarlint-language-server uses stdio channel
			"-stdio",
			"-analyzers",
			-- paths to the analyzers you need, using those for python and java in this example
			vim.fn.expand(mason .. "share/sonarlint-analyzers/sonarpython.jar"),
			vim.fn.expand(mason .. "share/sonarlint-analyzers/sonarcfamily.jar"),
			vim.fn.expand(mason .. "share/sonarlint-analyzers/sonarjava.jar"),
			vim.fn.expand(mason .. "share/sonarlint-analyzers/sonarjs.jar.jar"),
		},
	},
	filetypes = {
		-- Tested and working
		"cs",
		"dockerfile",
		"js",
		"python",
		"java",
	},
})
