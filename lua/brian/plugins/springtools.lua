return {
    "brianrbrenner/springboot-nvim",
    depedencies = {
        "neovim/nvim-lspconfig",
        "mfussenegger/nvim-jdtls"
    },
    config = function()
        local springboot_nvim = require("springboot-nvim")
        springboot_nvim.setup()
    end
}
