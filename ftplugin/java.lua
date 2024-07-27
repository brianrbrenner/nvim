vim.api.nvim_create_autocmd("LspAttach", {
  callback = function (args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end
})

local wk = require("which-key")

wk.add({
  { "<leader>j", group = "Java", nowait = true, remap = false },
  { "<leader>jb", ":TermExec cmd='mvn clean install -DskipTests'<CR>", desc = "Clean Install - no tests", nowait = true, remap = false },
  { "<leader>ji", ":TermExec cmd='mvn clean install'<CR>", desc = "Clean Install", nowait = true, remap = false },
})

require("nvim-tree").setup({
  view = {
    width = 50,
    centralize_selection = true,
  },
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true
  }
})
