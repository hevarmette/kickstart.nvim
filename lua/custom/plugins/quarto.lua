return {
  'quarto-dev/quarto-nvim',
  dependencies = {
    'jmbuhr/otter.nvim', -- Required for LSP features in code cells
    'benlubas/molten-nvim', -- Uncomment if you plan to use molten for code execution
  },
  -- Ensure quarto is loaded for markdown and quarto files as requested
  ft = { 'quarto', 'markdown' },
  config = function()
    local quarto = require 'quarto'

    quarto.setup {
      lspFeatures = {
        languages = { 'python' },
        chunks = 'all',
        diagnostics = {
          enabled = true,
          triggers = { 'BufWritePost' },
        },
        completion = {
          enabled = true,
        },
      },
      keymap = {
        hover = 'H',
        definition = 'gd',
        rename = '<leader>rn',
        references = 'gr',
        format = '<leader>gf',
      },
      codeRunner = {
        enabled = true,
        -- Note: If you want to use your existing iron.nvim setup, you might
        -- need to change this default_method to "iron" (if supported) or
        -- install molten-nvim.
        default_method = 'molten',
      },
    }

    -- Quarto Runner Keymaps
    local runner = require 'quarto.runner'
    vim.keymap.set('n', '<localleader>mc', runner.run_cell, { desc = 'run cell', silent = true })
    vim.keymap.set('n', '<localleader>ma', runner.run_above, { desc = 'run cell and above', silent = true })
    vim.keymap.set('n', '<localleader>mA', runner.run_all, { desc = 'run all cells', silent = true })
    vim.keymap.set('n', '<localleader>ml', runner.run_line, { desc = 'run line', silent = true })
    vim.keymap.set('v', '<localleader>m', runner.run_range, { desc = 'run visual range', silent = true })
    vim.keymap.set('n', '<localleader>MA', function()
      runner.run_all(true)
    end, { desc = 'run all cells of all languages', silent = true })
  end,
}
