return {
	"mfussenegger/nvim-dap",
	dependencies = {
    "rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup()
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end

		local wk = require("which-key")

		wk.add({
			{ "<leader>d", group = "Debug", nowait = true, remap = false },
			{ "<leader>db", ":DapToggleBreakpoint<CR>", desc = "Toggle Breakpoint", nowait = true, remap = false },
			{ "<leader>dc", ":DapContinue<CR>", desc = "Continue", nowait = true, remap = false },
			{ "<leader>de", ":DapEval<CR>", desc = "Eval Expression", nowait = true, remap = false },
			{ "<leader>dso", ":DapStepOver<CR>", desc = "Step Over", nowait = true, remap = false },
			{ "<leader>dsi", ":DapStepInto<CR>", desc = "Step Into", nowait = true, remap = false },
			{ "<leader>dt", ":DapTerminate<CR>", desc = "Terminate", nowait = true, remap = false },
		})
	end,
}
