return {
	"nvim-java/nvim-java",
	config = function()
		require("java").setup({
			settings = {
				java = {
					configuration = {
						runtimes = {
							{
								name = "JavaSE-21",
								path = os.getenv("JAVA_HOME"),
								default = true,
							},
						},
					},
				},
			},
		})
	end,
}
