-- sqlit.nvim — open the sqlit SQL TUI from inside Neovim.
-- Full sqlit experience (explorer pane, autocomplete, saved connections
-- including Snowflake PAT) in a terminal window. Requires the `sqlit`
-- binary on PATH (installed via `pipx install sqlit-tui`).
return {
  'Maxteabag/sqlit.nvim',
  opts = {
    theme = 'tokyo-night', -- sqlit's built-in Tokyo Night theme (matches nvim tokyonight)
    keymap = '<leader>D',
    desc = 'Database (sqlit)',
  },
  keys = {
    { '<leader>D', function() require('sqlit').open() end, desc = 'Database (sqlit)' },
  },
}
