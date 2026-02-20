return {
  'folke/tokyonight.nvim',
  lazy = false, -- make sure we load this during startup
  priority = 1000, -- load this before all other plugins
  config = function()
    require('tokyonight').setup {
      -- Styles: "storm", "moon", "night", "day"
      style = 'moon',
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = 'dark',
        floats = 'dark',
      },
      on_colors = function(colors)
        colors.hint = colors.orange
        colors.error = '#ff0000'
      end, -- Closes 'on_colors' function
    } -- Closes 'setup' call

    -- actually load the colorscheme
    vim.cmd [[colorscheme tokyonight]]
  end, -- Closes 'config' function
} -- Closes the main table
