return {
	"nvim-java/nvim-java",
	config = function()
		require("java").setup()
		require("lspconfig").jdtls.setup({})
	end,
}
