-- blink.cmp overrides
return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      -- Tab priority:
      --   1. select_next   — navigate menu when visible
      --   2. snippet_forward — advance snippet placeholder
      --   3. copilot accept — accept inline Copilot suggestion
      --   4. fallback       — default vim Tab
      ["<Tab>"] = {
        "select_next",
        "snippet_forward",
        function()
          local suggestion = vim.fn["copilot#GetDisplayedSuggestion"]()
          if suggestion and suggestion.text ~= "" then
            vim.fn.feedkeys(vim.fn["copilot#Accept"](""), "n")
            return true
          end
          return false
        end,
        "fallback",
      },
    },
  },
}
