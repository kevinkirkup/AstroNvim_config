-- The missing auto-completion for cmdline!
return {
  {
    "gelguy/wilder.nvim",
    dependencies = {
      "romgrk/fzy-lua-native",
      "nvim-tree/nvim-web-devicons",
    },
    build = ":UpdateRemotePlugins",
    opts = {
      modes = { ":", "/", "?" },
      next_key = "<Tab>",
      previous_key = "<S-Tab>",
      accept_key = "",
      reject_key = "<C-k>",
      enable_cmdline_enter = 1, -- for auto show
    },
    config = require "plugins.configs.wilder",
  },
}
