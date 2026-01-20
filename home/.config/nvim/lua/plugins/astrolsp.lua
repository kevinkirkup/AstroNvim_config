-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing
local config = require "util.lsp-config"

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- Configuration table of features provided by AstroLSP
    features = {
      autoformat = true, -- enable or disable auto formatting on start
      codelens = true, -- enable/disable codelens refresh on start
      inlay_hints = false, -- enable/disable inlay hints on start
      semantic_tokens = true, -- enable/disable semantic token highlighting
    },
    -- Configure default capabilities for language servers (`:h vim.lsp.protocol.make_client.capabilities()`)
    capabilities = {
      textDocument = {
        completion = {
          completeItem = {
            snippetSupport = true,
          },
        },
      },
    },
    -- A custom flags table to be passed to all language servers  (`:h lspconfig-setup`)
    flags = {
      debounce_text_changes = 150,
    },
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          "python",
          "markdown",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      clangd = {
        on_attach = config.custom_attach,
        filetypes = { "c", "cpp", "cc" },
        flags = { debounce_text_changes = 500 },
        capabilities = { offsetEncoding = "utf-8" },
      },
      lua_ls = {
        on_attach = config.custom_attach,
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = "LuaJIT",
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { "vim", "astronvim" },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files,
              -- see also https://github.com/sumneko/lua-language-server/wiki/Libraries#link-to-workspace .
              -- Lua-dev.nvim also has similar settings for sumneko lua,
              -- https://github.com/folke/lua-dev.nvim/blob/main/lua/lua-dev/sumneko.lua .
              library = {
                vim.fn.stdpath "data" .. "/site/pack/packer/opt/emmylua-nvim",
                vim.fn.stdpath "config",
              },
              maxPreload = 2000,
              preloadFileSize = 50000,
            },
          },
        },
      },
      vimls = {
        on_attach = config.custom_attach,
        flags = { debounce_text_changes = 500 },
      },
      yamls = {
        settings = {
          yaml = {
            validate = { enable = true },
            format = { enable = false },
            schemaStore = { enable = false },
            keyOrdering = false,
            schemas = {
              ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
            },
          },
        },
      },
      bashls = {
        on_attach = config.custom_attach,
      },
      pylsp = {
        on_attach = config.custom_attach,
        settings = {
          pylsp = {
            configurationSources = { "flake8" },
            plugins = {
              autopep8 = { enabled = true },
              flake8 = { enabled = true, ignore = {}, maxLineLength = 100 },
              pylint = { enabled = true, executable = "pylint" },
              pyflakes = { enabled = true },
              pycodestyle = { enabled = false },
              mccabe = { enabled = true },
              jedi_completion = { fuzzy = true },
              pylsp_mypy = { enabled = true },
              pylsp_rope = { enabled = true },
              yapf = { enabled = false },
            },
          },
        },
        flags = { debounce_text_changes = 200 },
      },
      rust_analyzer = {
        settings = {
          ["rust-analyzer"] = {},
        },
      },
      ansiblels = {
        filetypes = { "yaml.ansible" },
        settings = {
          ansible = {
            ansible = {
              path = "ansible",
              useFullyQualifiedCollectionNames = true,
            },
            ansibleLint = {
              enabled = true,
              path = "ansible-lint",
            },
            executionEnvironment = {
              enabled = false,
            },
            python = {
              interpreterPath = "python",
            },
            completion = {
              provideRedirectModules = true,
              provideModuleOptionAliases = true,
            },
          },
        },
      },
      elixirls = {
        cmd = { "elixir-ls-language_server.sh" },
        settings = {
          elixirLS = {
            format = { enable = false },
            -- I choose to disable dialyzer for personal reasons, but
            -- I would suggest you also disable it unless you are well
            -- aquainted with dialzyer and know how to use it.
            dialyzerEnabled = true,
            -- I also choose to turn off the auto dep fetching feature.
            -- It often get's into a weird state that requires deleting
            -- the .elixir_ls directory and restarting your editor.
            fetchDeps = false,
          },
        },
      },
    },
    -- customize how language servers are attached
    handlers = {
      -- a function without a key is simply the default handler, functions take two parameters, the server name and the configured options table for that server
      -- function(server, opts) require("lspconfig")[server].setup(opts) end

      -- the key is the server that is being setup with `lspconfig`
      -- rust_analyzer = false, -- setting a handler to false will disable the set up of that language server
      -- pyright = function(_, opts) require("lspconfig").pyright.setup(opts) end -- or a custom handler function can be passed
    },
    -- Configure buffer local auto commands to add when attaching a language server
    autocmds = {
      -- first key is the `augroup` to add the auto commands to (:h augroup)
      lsp_document_highlight = {
        -- Optional condition to create/delete auto command group
        -- can either be a string of a client capability or a function of `fun(client, bufnr): boolean`
        -- condition will be resolved for each client on each execution and if it ever fails for all clients,
        -- the auto commands will be deleted for that buffer
        cond = "textDocument/documentHighlight",
        -- cond = function(client, bufnr) return client.name == "lua_ls" end,
        -- list of auto commands to set
        {
          -- events to trigger
          event = { "CursorHold", "CursorHoldI" },
          -- the rest of the autocmd options (:h nvim_create_autocmd)
          desc = "Document Highlighting",
          callback = function() vim.lsp.buf.document_highlight() end,
        },
        {
          event = { "CursorMoved", "CursorMovedI", "BufLeave" },
          desc = "Document Highlighting Clear",
          callback = function() vim.lsp.buf.clear_references() end,
        },
      },
    },
    -- mappings to be set up on attaching of a language server
    mappings = {
      n = {
        gl = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" },
        -- a `cond` key can provided as the string of a server capability to be required to attach, or a function with `client` and `bufnr` parameters from the `on_attach` that returns a boolean
        -- gD = {
        --   function() vim.lsp.buf.declaration() end,
        --   desc = "Declaration of current symbol",
        --   cond = "textDocument/declaration",
        -- },
        -- ["<Leader>uY"] = {
        --   function() require("astrolsp.toggles").buffer_semantic_tokens() end,
        --   desc = "Toggle LSP semantic highlight (buffer)",
        --   cond = function(client) return client.server_capabilities.semanticTokensProvider and vim.lsp.semantic_tokens end,
        -- },
      },
    },
    -- A custom `on_attach` function to be run after the default `on_attach` function
    -- takes two parameters `client` and `bufnr`  (`:h lspconfig-setup`)
    on_attach = function(client, bufnr)
      -- Enable completion triggered by <c-x><c-o>
      vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.lsp.omnifunc")
    end,
  },
}
