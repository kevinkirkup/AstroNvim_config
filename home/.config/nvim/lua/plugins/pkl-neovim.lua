return {
	"apple/pkl-neovim",
	lazy = true,
	event = "BufReadPre *.pkl",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	build = function()
		pcall(vim.cmd, "TSInstall! pkl")
	end,
}
