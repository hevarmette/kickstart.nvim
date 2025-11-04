-- File: lua/custom/plugins/iron.lua

return {
  'Vigemus/iron.nvim',

  -- These keys will lazy-load the plugin when you press them
  keys = {
    { '<space>rr', desc = 'Iron: Toggle REPL' },
    { '<space>rf', desc = 'Iron: Focus REPL' },
    { '<space>rh', desc = 'Iron: Hide REPL' },
    { '<space>rc', mode = { 'n', 'v' }, desc = 'Iron: Send to REPL' },
    { '<space>rl', desc = 'Iron: Send Line' },
  },

  -- This config function will run *after* the plugin is loaded
  config = function()
    local iron = require 'iron.core'
    local view = require 'iron.view'
    local common = require 'iron.fts.common'

    iron.setup {
      config = {
        scratch_repl = true,
        repl_definition = {
          sh = {
            command = { 'bash' },
          },
          python = {
            -- Using ipython as requested
            command = { 'ipython', '--no-autoindent' },
            format = common.bracketed_paste_python,
            block_dividers = { '# %%', '#%%' },
            env = { PYTHON_BASIC_REPL = '1' }, --this is needed for python3.13 and up.
          },
        },
        repl_filetype = function(bufnr, ft)
          return ft
        end,
        dap_integration = true,
        repl_open_cmd = view.right(80),
      },
      keymaps = {
        -- Core REPL Controls
        toggle_repl = '<space>rr', -- [R]un REPL
        restart_repl = '<space>rR', -- [R]estart REPL
        exit = '<space>rq', -- [Q]uit REPL
        interrupt = '<space>rc', -- [C]ancel / Interrupt (like Ctrl+C)
        clear = '<space>rx', -- E[x]terminate / Clear screen

        -- Sending Code
        send_line = '<space>rl', -- Send [L]ine
        send_motion = '<space>rs', -- [S]end motion
        visual_send = '<space>rs', -- [S]end visual (uses the same key)
        send_file = '<space>rF', -- Send [F]ile (Shift+F)
        send_paragraph = '<space>rp', -- Send [P]aragraph
        send_until_cursor = '<space>ru', -- Send [U]ntil cursor
        send_code_block = '<space>rb', -- Send [B]lock
        send_code_block_and_move = '<space>rn', -- Send block and move [N]ext

        -- Marks
        send_mark = '<space>rm', -- [R]un [M]arked
        mark_motion = '<space>mc', -- [M]ark [C]ode
        mark_visual = '<space>mc', -- [M]ark [C]ode (visual)
        remove_mark = '<space>md', -- [M]ark [D]elete

        -- Special Sending
        cr = '<space>r<cr>', -- Send Carriage Return (Enter)
      },
      highlight = {
        italic = true,
      },
      ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
    }

    -- These keymaps MUST be inside the config function to ensure iron is loaded
    vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>')
    vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')
  end,
}
