return {
  'benlubas/molten-nvim',
  dependencies = { 'willothy/wezterm.nvim' }, -- Required for WezTerm image provider
  build = ':UpdateRemotePlugins',
  init = function()
    -- 1. Point Neovim to your dedicated Python virtual environment
    vim.g.python3_host_prog = vim.fn.expand '~/.virtualenvs/debugpy/bin/python3'

    -- 2. Setup WezTerm as the image provider
    vim.g.molten_image_provider = 'wezterm'

    -- 3. WezTerm specific configurations
    -- auto_open_output MUST be false when using the wezterm image provider
    vim.g.molten_auto_open_output = false
    vim.g.molten_auto_image_popup = false

    -- 4. Formatting and Window output settings
    vim.g.molten_split_direction = 'right' -- direction of the output window ("right", "left", "top", "bottom")
    vim.g.molten_split_size = 40 -- (0-100) % size of the screen dedicated to the output window
    vim.g.molten_output_show_more = true
    vim.g.molten_output_virt_lines = true
    vim.g.molten_virt_text_output = true
    vim.g.molten_use_border_highlights = true
    vim.g.molten_virt_lines_off_by_1 = true
    vim.g.molten_output_win_zindex = 50

    -- 5. Helpful Keymaps
    -- Initialize Molten
    vim.keymap.set('n', '<localleader>mi', ':MoltenInit<CR>', { desc = '[M]olten [I]nitialize', silent = true })

    -- Evaluate code
    vim.keymap.set('n', '<localleader>e', ':MoltenEvaluateOperator<CR>', { desc = '[E]valuate Operator', silent = true })
    vim.keymap.set('n', '<localleader>ml', ':MoltenEvaluateLine<CR>', { desc = 'Evaluate [R]un [L]ine', silent = true })
    vim.keymap.set('n', '<localleader>mc', ':MoltenReevaluateCell<CR>', { desc = 'Evaluate [R]un [C]ell', silent = true })
    vim.keymap.set('v', '<localleader>m', ':<C-u>MoltenEvaluateVisual<CR>gv', { desc = 'Evaluate [R]un Visual', silent = true })

    -- Output management
    vim.keymap.set('n', '<localleader>md', ':MoltenDelete<CR>', { desc = '[R]un [D]elete Cell', silent = true })
    vim.keymap.set('n', '<localleader>os', ':MoltenShowOutput<CR>', { desc = '[O]utput [S]how', silent = true })
    vim.keymap.set('n', '<localleader>oh', ':MoltenHideOutput<CR>', { desc = '[O]utput [H]ide', silent = true })
  end,
}
