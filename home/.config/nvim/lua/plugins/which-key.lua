-- showing keybindings
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    plugins = {
      spelling = {
        enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
        suggestions = 9, -- how many suggestions should be shown in the list?
      },
    },
    layout = {
      height = { min = 1, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 1, -- spacing between columns
      align = "center", -- align columns left, center or right
    },
    triggers = {
      { "<auto>", mode = "nixsotc" }, -- automatically setup triggers
      -- { "<leader>?" }, -- or specify a list manually
    },
    disable = { filettypes = { "TelescopePrompt" } },
  },
}
