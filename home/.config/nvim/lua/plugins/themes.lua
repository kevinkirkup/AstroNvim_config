return {
  {
    "folke/tokyonight.nvim",
    -- lazy = false,
    priority = 1000,
    opts = {
      style = "storm", -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
      transparent = vim.g.neovide == nil, -- Enable this to disable setting the background color
      terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim                                                                                                  |
      styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value `:help attr-list`
        comments = "italic",
        keywords = "NONE",
        functions = "NONE",
        variables = "NONE",
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "transparent", -- style for sidebars, see below
        floats = "transparent", -- style for floating windows
      },
      sidebars = {
        "qf",
        "help",
        "vista_kind",
        "terminal",
        "neo-tree",
      }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`                                                      |
      day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors                                                  |
      hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**. |
      dim_inactive = false, -- dims inactive windows
      lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold|
      on_highlights = function(hl, _)
        hl.TSRainbowRed = { link = "rainbowcol1" }
        hl.TSRainbowOrange = { link = "rainbowcol2" }
        hl.TSRainbowGreen = { link = "rainbowcol3" }
        hl.TSRainbowCyan = { link = "rainbowcol4" }
        hl.TSRainbowBlue = { link = "rainbowcol5" }
        hl.TSRainbowViolet = { link = "rainbowcol6" }
        hl.TSRainbowYellow = { link = "rainbowcol7" }
      end,
    },
  },
  -- Themes
  -- { "wadackel/vim-dogrun", opt = true },
  -- { "rakr/vim-one", opt = true },
  -- { "hzchirs/vim-material", opt = true },
  -- { "embark-theme/vim", opt = true },
  -- { "drewtempelmeyer/palenight.vim", opt = true },
  -- { "cocopon/iceberg.vim", opt = true },
  -- { "fenetikm/falcon", opt = true },
  -- { "jarodl/cobalt.vim", opt = true },
  -- { "travisjeffery/vim-colors", opt = true },
  -- { "arcticicestudio/nord-vim", opt = true },
  -- { "sainnhe/sonokai", opts = true },
  {
    "mhartington/oceanic-next",
    priority = 1000,
  },
}
