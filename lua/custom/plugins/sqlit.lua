-- sqlit.nvim — open the sqlit SQL TUI from inside Neovim.
-- Full sqlit experience (explorer pane, autocomplete, saved connections
-- including Snowflake PAT) in a terminal window. Requires the `sqlit`
-- binary on PATH (installed via `pipx install sqlit-tui`).
return {
  'Maxteabag/sqlit.nvim',
  opts = {
    theme = 'textual-ansi', -- inherit terminal colors
    keymap = '<leader>D',
    desc = 'Database (sqlit)',
  },
  keys = {
    { '<leader>D', function() require('sqlit').open() end, desc = 'Database (sqlit)' },
  },
}
