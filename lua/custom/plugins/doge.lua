return {
  'kkoomen/vim-doge',
  build = ':call doge#install()',
  init = function()
    -- Disable default keybinds
    vim.g.doge_enable_mappings = 0 --
  end,
  config = function()
    -- Generate comment for current line
    vim.keymap.set('n', '<Leader>c', '<Plug>(doge-generate)')

    -- Interactive mode comment todo-jumping
    vim.keymap.set('n', '<TAB>', '<Plug>(doge-comment-jump-forward)')
    vim.keymap.set('n', '<S-TAB>', '<Plug>(doge-comment-jump-backward)')
    vim.keymap.set('i', '<TAB>', '<Plug>(doge-comment-jump-forward)')
    vim.keymap.set('i', '<S-TAB>', '<Plug>(doge-comment-jump-backward)')
    vim.keymap.set('x', '<TAB>', '<Plug>(doge-comment-jump-forward)')
    vim.keymap.set('x', '<S-TAB>', '<Plug>(doge-comment-jump-backward)')
  end,
}
