-- Setup nvim-cmp.
return {
	-- Snippets
	{ "SirVer/ultisnips", event = "InsertEnter" },
	{ "kevinkirkup/vim-snippets", dependencies = { "SirVer/ultisnips" } },
	{
		"quangnguyen30192/cmp-nvim-ultisnips",
		dependencies = {
			"SirVer/ultisnips",
			"kevinkirkup/vim-snippets",
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"hrsh7th/nvim-cmp",
		-- commit = "a9c701fa7e12e9257b3162000e5288a75d280c28", -- https://github.com/hrsh7th/nvim-cmp/issues/1382
		dependencies = {
			"quangnguyen30192/cmp-nvim-ultisnips",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-calc",
			"f3fora/cmp-spell",
			"tamago324/cmp-zsh",
			"hrsh7th/cmp-emoji",
		},
		event = "InsertEnter",
		config = function(plugin, opts)
			local cmp = require("cmp")
			-- run cmp setup
			cmp.setup(opts)

			-- configure `cmp-cmdline` as described in their repo: https://github.com/hrsh7th/cmp-cmdline#setup
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{
						name = "cmdline",
						option = {
							ignore_cmds = { "Man", "!" },
						},
					},
				}),
			})
		end,
		opts = function()
			local cmp = require("cmp")
			local lspkind_status_ok, lspkind = pcall(require, "lspkind")
			local border_opts = {
				border = "single",
				winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
			}

			return {
				enabled = function()
					if vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt" then
						return false
					end
					return vim.g.cmp_enabled
				end,
				preselect = cmp.PreselectMode.None,
				formatting = {
					fields = { "kind", "abbr", "menu" },
					-- format = lspkind_status_ok and lspkind.cmp_format(astronvim.lspkind) or nil,
					format = lspkind_status_ok and lspkind.cmp_format({
						mode = "symbol_text",
						menu = {
							ultisnips = "[Snip]",
							nvim_lsp = "[LSP]",
							nvim_lua = "[Lua]",
							path = "[Path]",
							buffer = "[Buffer]",
							emoji = "[Emoji]",
							omni = "[Omni]",
							spell = "[Spellings]",
							zsh = "[Zsh]",
							treesitter = "[Treesitter]",
							calc = "[Calculator]",
							nvim_lsp_signature_help = "[Signature]",
							cmdline = "[Vim Command]",
						},
					}) or nil,
				},
				snippet = {
					expand = function(args)
						-- For `ultisnips` user.
						vim.fn["UltiSnips#Anon"](args.body)
					end,
				},
				duplicates = {
					utlisnips = 1,
					nvim_lsp = 1,
					buffer = 1,
					path = 1,
				},
				confirm_opts = {
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				},
				window = {
					completion = cmp.config.window.bordered(border_opts),
					documentation = cmp.config.window.bordered(border_opts),
				},
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end,
					["<S-Tab>"] = function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end,
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-e>"] = cmp.mapping.abort(),
					["<Esc>"] = cmp.mapping.close(),
				}),
				sources = {
					{ name = "ultisnips", keyword_length = 2, priority = 1000 }, -- For ultisnips user.
					{ name = "nvim_lsp", keyword_length = 2, priority = 800 }, -- For nvim-lsp
					{ name = "nvim_lsp_signature_help", priority = 500 }, -- LSP Signature completion
					{ name = "path", priority = 300 }, -- for path completion
					{ name = "buffer", keyword_length = 2, priority = 300 }, -- for buffer word completion
					{ name = "omni", priority = 200 }, -- omni complete
					{ name = "buffer", priority = 100 }, -- current buffer
					{ name = "emoji", insert = true, priority = 100 }, -- emoji completion
					{ name = "spell", spell = true, spelllang = { "en_us" } }, -- spelling completion
					{ name = "calc" }, -- calculator completion
					{ name = "zsh", zshrc = true, filetypes = { "zsh" } }, -- zsh completion
				},
				completion = { keyword_length = 3, completeopt = "menu,noselect" },
				view = { entries = "custom" },
				matching = {
					disallow_fuzzy_matching = false,
				},
			}
		end,
	},
}
