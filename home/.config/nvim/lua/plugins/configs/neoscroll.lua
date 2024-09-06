return function(_, opts)
  neoscroll = require "neoscroll"
  neoscroll.setup(opts)

  local keymap = {
    -- Use the "sine" easing function
    ["<C-u>"] = function() neoscroll.ctrl_u { move_cursor = true, duration = 20, easing = "cubic" } end,
    ["<C-d>"] = function() neoscroll.ctrl_d { move_cursor = true, duration = 20, easing = "cubic" } end,

    -- Use the "circular" easing function
    ["<C-b>"] = function() neoscroll.ctrl_b { move_cursor = true, duration = 50, easing = "cubic" } end,
    ["<C-f>"] = function() neoscroll.ctrl_f { move_cursor = true, duration = 50, easing = "cubic" } end,

    -- Pass "nil" to disable the easing animation (constant scrolling speed)
    ["<C-y>"] = function() neoscroll.scroll(-0.1, { move_cursor = false, duration = 100 }) end,
    ["<C-e>"] = function() neoscroll.scroll(0.1, { move_cursor = false, duration = 100 }) end,

    ["zt"] = function() neoscroll.zt { half_win_duration = 10 } end,
    ["zz"] = function() neoscroll.zz { half_win_duration = 10 } end,
    ["zb"] = function() neoscroll.zb { half_win_duration = 10 } end,
  }
  local modes = { "n", "v", "x" }
  for key, func in pairs(keymap) do
    vim.keymap.set(modes, key, func)
  end
end
