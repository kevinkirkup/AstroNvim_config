-- blink.cmp overrides
return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      -- Tab priority:
      --   1. copilot accept  — accept inline suggestion if rendered (wins over blink menu)
      --   2. select_next     — navigate blink menu
      --   3. snippet_forward — advance snippet placeholder
      --   4. fallback        — default vim Tab
      ["<Tab>"] = {
        function()
          local suggestion = vim.fn["copilot#GetDisplayedSuggestion"]()
          if suggestion and suggestion.text ~= "" then
            vim.fn.feedkeys(vim.fn["copilot#Accept"](""), "n")
            return true
          end
          return false
        end,
        "select_next",
        "snippet_forward",
        "fallback",
      },
    },
  },
}
