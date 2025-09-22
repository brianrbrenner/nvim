return {
	"williamboman/mason.nvim",
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"nvim-lua/plenary.nvim",
	},

	config = function()
		require("mason").setup({
			registries = {
				"github:nvim-java/mason-registry",
				"github:mason-org/mason-registry",
			},
		})
	end,
}
