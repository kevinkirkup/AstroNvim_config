return {
	"Yggdroot/LeaderF",
	cmd = "Leaderf",
	build = ":LeaderfInstallCExtension",
	keys = {
		{ "<leader>ff", ":Leaderf! file<CR>",             desc = "Find File" },
		{ "<leader>fu", ":Leaderf! function --fuzzy<CR>", desc = "Find Function" },
		{ "<leader>fb", ":Leaderf! buffer<CR>",           desc = "Find Buffer" },
		{ "<leader>fg", ":Leaderf! rg -F<CR>",            desc = "" },
	},
}
