-- Colorscheme configuration.
--
-- Default: a premade theme (see DEFAULT_COLORSCHEME below), applied on startup.
-- Optional: a matugen-generated palette (wallpaper -> base16) applied on demand.
--
-- This is a plain module (not a lazy plugin spec). Its setup() is called from
-- the single mini.nvim spec in init.lua, so mini.nvim is declared exactly once.
--
-- Commands:
--   :MatugenReload   apply the matugen-generated palette (lua/custom/generated_colors.lua)
--   :ThemeDefault    switch back to the premade default theme
--
-- Generate/refresh the matugen palette from a shell first:
--   matugen image /path/to/wallpaper --mode dark --prefer saturation \
--     --type scheme-expressive --contrast 0.3
-- then run :MatugenReload inside nvim.

-- The premade theme used on startup and by :ThemeDefault.
local DEFAULT_COLORSCHEME = 'tokyonight-moon'

local BASE16_KEYS = {
  'base00',
  'base01',
  'base02',
  'base03',
  'base04',
  'base05',
  'base06',
  'base07',
  'base08',
  'base09',
  'base0A',
  'base0B',
  'base0C',
  'base0D',
  'base0E',
  'base0F',
}

-- Apply the premade default theme. Returns true on success.
local function apply_default()
  local ok = pcall(function()
    require('tokyonight').setup {
      styles = { comments = { italic = false } },
    }
    vim.cmd.colorscheme(DEFAULT_COLORSCHEME)
  end)
  if not ok then
    pcall(vim.cmd.colorscheme, 'habamax') -- last-resort builtin
  end
  return ok
end

-- Load and validate the matugen-generated palette. Returns a table of 16 hex
-- colors on success, or nil if it is missing/invalid.
local function load_palette()
  local ok, palette = pcall(require, 'custom.generated_colors')
  if not ok or type(palette) ~= 'table' then return nil end
  for _, key in ipairs(BASE16_KEYS) do
    local v = palette[key]
    if type(v) ~= 'string' or not v:match '^#%x%x%x%x%x%x$' then return nil end
  end
  return palette
end

-- Apply the matugen palette via mini.base16. Returns true if applied.
local function apply_matugen()
  package.loaded['custom.generated_colors'] = nil -- always read fresh from disk
  local palette = load_palette()
  if not palette then return false end
  require('mini.base16').setup {
    palette = palette,
    use_cterm = true,
  }
  vim.g.colors_name = 'matugen'
  return true
end

local M = {}

-- Apply the startup theme and register the :MatugenReload / :ThemeDefault
-- commands. Call this once, from the mini.nvim spec's config in init.lua.
function M.setup()
  -- Premade theme is the default on startup.
  apply_default()

  -- Opt in to the matugen-generated palette.
  vim.api.nvim_create_user_command('MatugenReload', function()
    if apply_matugen() then
      vim.notify('matugen palette applied', vim.log.levels.INFO)
    else
      vim.notify('no valid matugen palette found (run matugen first)', vim.log.levels.WARN)
    end
  end, { desc = 'Apply the matugen-generated colorscheme' })

  -- Return to the premade default theme.
  vim.api.nvim_create_user_command('ThemeDefault', function()
    apply_default()
    vim.notify('default theme applied (' .. DEFAULT_COLORSCHEME .. ')', vim.log.levels.INFO)
  end, { desc = 'Switch back to the premade default colorscheme' })
end

return M
