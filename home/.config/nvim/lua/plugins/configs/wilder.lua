-- Wilder configuration
return function(_, opts)
  local wilder = require "wilder"

  wilder.setup(opts)

  wilder.set_option("pipeline", {
    wilder.branch(
      wilder.python_file_finder_pipeline {
        file_command = function(_, arg)
          if string.find(arg, ".") ~= nil then
            return { "fd", "-tf", "-H" }
          else
            return { "fd", "-tf" }
          end
        end,
        dir_command = { "fd", "-td" },
        filters = { "cpsm_filter" },
      },
      wilder.substitute_pipeline {
        pipeline = wilder.python_search_pipeline {
          skip_cmdtype_check = 1,
          pattern = wilder.python_fuzzy_pattern { start_at_boundary = 0 },
        },
      },
      wilder.cmdline_pipeline { fuzzy = 2, fuzzy_filter = wilder.lua_fzy_filter() },
      {
        wilder.check(function(_, x) return x == "" end),
        wilder.history(),
      },
      wilder.python_search_pipeline {
        pattern = wilder.python_fuzzy_pattern { start_at_boundary = 0 },
      }
    ),
  })

  local highlighters = {
    wilder.pcre2_highlighter(),
    wilder.lua_fzy_highlighter(),
  }

  local highlights = {
    accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = "#f4468f" } }),
  }

  local popupmenu_renderer = wilder.popupmenu_renderer(wilder.popupmenu_border_theme {
    border = "rounded",
    pumblend = 15,
    empty_message = wilder.popupmenu_empty_message_with_spinner(),
    highlighter = highlighters,
    highlights = highlights,
    left = {
      " ",
      wilder.popupmenu_devicons(),
      wilder.popupmenu_buffer_flags {
        flags = " a + ",
        icons = { ["+"] = "", a = "", h = "" },
      },
    },
    right = { " ", wilder.popupmenu_scrollbar() },
    min_width = "25%", -- minimum height of the popupmenu, can also be a number
  })

  local wildmenu_renderer = wilder.wildmenu_renderer {
    highlighter = highlighters,
    highlights = highlights,
    separator = " · ",
    left = { " ", wilder.wildmenu_spinner(), " " },
    right = { " ", wilder.wildmenu_index() },
  }

  wilder.set_option(
    "renderer",
    wilder.renderer_mux {
      [":"] = popupmenu_renderer,
      ["/"] = wildmenu_renderer,
      substitute = wildmenu_renderer,
    }
  )
end
