return {
  'hedyhli/outline.nvim',
  lazy = true,
  cmd = { 'Outline', 'OutlineOpen' },
  keys = { -- Example mapping to toggle outline
    { '<leader>o', '<cmd>Outline<CR>', desc = 'Toggle outline' },
  },
  opts = {
    -- Your setup opts here
    outline_window = {
      auto_width = {
        -- Dynamically size window
        enabled = true,
        max_width = 20, -- in percent
      },
    },
  },
}
