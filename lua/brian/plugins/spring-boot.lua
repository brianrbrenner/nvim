return {
  "brianrbrenner/springboot-nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-jdtls",
  },
  config = function ()
    require("springboot-nvim").setup()
  end
}
