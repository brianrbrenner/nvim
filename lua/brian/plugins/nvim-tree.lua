local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
  return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup {
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true
  },
  -- ignore_ft_on_setup = { i believe this is deprecated
  --   "startify",
  --   "dashboard",
  --   "alpha",
  -- },
  -- diagnostics = {
  --   enable = false,
  --   icons = {
  --     hint = "",
  --     info = "",
  --     warning = "",
  --     error = "",
  --   },
  -- },
  -- renderer = {
  --   icons = {
  --     glyphs = {
  --       -- default = "",
  --       default = "",
  --       symlink = "",
  --       folder = {
  --         default = "",
  --         open = "",
  --         empty = "",
  --         empty_open = "",
  --         symlink = "",
  --       },
  --       git = {
  --         unstaged = "",
  --         staged = "S",
  --         unmerged = "",
  --         renamed = "➜",
  --         deleted = "",
  --         untracked = "U",
  --         ignored = "◌",
  --       },
  --     },
  --   },
  -- },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = false,
      global = false,
      restrict_above_cwd = false,
    },
  },
  view = {
    mappings = {
      custom_only = false,
      list = {
        { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
        { key = "h", cb = tree_cb "close_node" },
        { key = "v", cb = tree_cb "vsplit" },
        { key = "s", cb = tree_cb "split" },
        { key = "u", action = "dir_up" },
      },
    },
  },
}
