-- Customize Mason

---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        -- install language servers
        "ansible-language-server",
        "clangd",
        "docker-compose-language-service",
        "docker-language-server",
        "dockerfile-language-server",
        -- "elixir-ls",
        "gopls",
        "json-lsp",
        "lua-language-server",
        "python-lsp-server",
        "pyright",
        "rust-analyzer",
        "sourcery",
        "sqlls",
        "taplo",
        "tflint",
        "vim-language-server",
        "yaml-language-server",

        -- install formatters
        "ansible-lint",
        "clang-format",
        "misspell",
        "protolint",
        "pyre",
        "staticcheck",
        "tflint",
        "terraform-ls",
        "stylua",

        -- install debuggers
        "debugpy",

        -- install any other package
        "tree-sitter-cli",
      },
    },
  },
}
