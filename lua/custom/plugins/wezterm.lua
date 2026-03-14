-- Only load wezterm plugin if actually running in wezterm
if vim.env.TERM_PROGRAM ~= 'WezTerm' then
  return {}
end

return {
  'willothy/wezterm.nvim',
  config = true,
}
