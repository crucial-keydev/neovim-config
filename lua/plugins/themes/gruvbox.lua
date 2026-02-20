return {
  'sainnhe/gruvbox-material',
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    -- Option: Set the background contrast
    -- Available values: 'hard', 'medium'(default), 'soft'
    vim.g.gruvbox_material_background = 'hard'

    -- Option: Enable better performance
    vim.g.gruvbox_material_better_performance = 1

    -- Option: italicize comments
    vim.g.gruvbox_material_enable_italic = 1

    -- Load the colorscheme
    vim.cmd.colorscheme 'gruvbox-material'
  end,
}
