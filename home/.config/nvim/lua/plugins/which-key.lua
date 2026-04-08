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
    replace = {
      key = {
        -- { "<space>", "SPC" },
      },
    },
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "➜", -- symbol used between a key and it's label
      group = "+", -- symbol prepended to a group
    },
    win = {
      border = "none", -- none, single, double, shadow
      position = "bottom", -- bottom, top
      margin = { 0, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]
      padding = { 1, 0, 1, 0 }, -- extra window padding [top, right, bottom, left]
    },
    layout = {
      height = { min = 1, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 1, -- spacing between columns
      align = "center", -- align columns left, center or right
    },
    filter = function(mapping)
      -- example to exclude mappings without a description
      -- return mapping.desc and mapping.desc ~= ""
      return false
    end,
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = {
      { "<auto>", mode = "nixsotc" }, -- automatically setup triggers
      -- {"<leader>"} -- or specify a list manually
    },
    disable = { filettypes = { "TelescopePrompt" } },
  },
}
