-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  require 'kickstart.plugins.indent_line',
  require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps
  require 'kickstart.plugins.debug',
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.lint',
  require 'kickstart.plugins.neo-tree',
  require 'custom.plugins.iron', -- run lines with a terminal on right side
  require 'custom.plugins.dadbod', -- database support
}
