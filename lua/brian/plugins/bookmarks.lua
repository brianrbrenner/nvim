return {
  "crusj/bookmarks.nvim",
  branch = "main",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function ()
   require("bookmarks").setup()
   require("telescope").load_extension("bookmarks")
  end
}
