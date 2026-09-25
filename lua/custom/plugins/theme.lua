-- Dynamic colorscheme driven by matugen (wallpaper -> base16 palette).
--
-- matugen writes lua/custom/generated_colors.lua (see ~/.config/matugen).
-- If that palette exists and is valid, apply it via mini.base16.
-- Otherwise fall back to tokyonight-night so nvim always has a theme,
-- including on machines where matugen has never run.
--
-- Regenerate the palette with:  matugen image /path/to/wallpaper
-- Then restart nvim, or run :MatugenReload to apply without restarting.

local BASE16_KEYS = {
  'base00', 'base01', 'base02', 'base03',
  'base04', 'base05', 'base06', 'base07',
  'base08', 'base09', 'base0A', 'base0B',
  'base0C', 'base0D', 'base0E', 'base0F',
}

-- Load and validate the generated palette. Returns a table of 16 hex
-- colors on success, or nil (with no error) if it is missing/invalid.
local function load_palette()
  local ok, palette = pcall(require, 'custom.generated_colors')
  if not ok or type(palette) ~= 'table' then
    return nil
  end
  for _, key in ipairs(BASE16_KEYS) do
    local v = palette[key]
    if type(v) ~= 'string' or not v:match('^#%x%x%x%x%x%x$') then
      return nil -- incomplete or malformed; bail to fallback
    end
  end
  return palette
end

-- Apply the generated palette. Returns true if applied.
local function apply_generated()
  local palette = load_palette()
  if not palette then
    return false
  end
  -- mini.base16 builds a full set of highlight groups from 16 colors and
  -- also wires up common plugin integrations.
  require('mini.base16').setup {
    palette = palette,
    use_cterm = true,
  }
  vim.g.colors_name = 'matugen'
  return true
end

return {
  {
    'echasnovski/mini.nvim',
    priority = 1000,
    lazy = false,
    config = function()
      if not apply_generated() then
        -- Fallback: use tokyonight if the generated palette is absent.
        local ok = pcall(function()
          require('tokyonight').setup {
            styles = { comments = { italic = false } },
          }
          vim.cmd.colorscheme 'tokyonight-night'
        end)
        if not ok then
          vim.cmd.colorscheme 'habamax' -- last-resort builtin
        end
      end

      -- Re-apply the palette without restarting (after re-running matugen).
      vim.api.nvim_create_user_command('MatugenReload', function()
        package.loaded['custom.generated_colors'] = nil
        if apply_generated() then
          vim.notify('matugen palette applied', vim.log.levels.INFO)
        else
          vim.notify('no valid matugen palette; keeping current theme', vim.log.levels.WARN)
        end
      end, { desc = 'Reload matugen-generated colorscheme' })
    end,
  },
}
