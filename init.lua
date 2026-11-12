require 'core.options' -- Load general options
require 'core.keymaps' -- Load general keymaps
require 'core.snippets' -- Custom code snippets
require 'tools.sql-runner'
require 'tools.wezterm-img-preview'

-- Install package manager
local uv = vim.uv or vim.loop
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not uv.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Import color theme based on environment variable NVIM_THEME
local default_color_scheme = 'gruvbox'
local env_var_nvim_theme = os.getenv 'NVIM_THEME' or default_color_scheme

-- Define a table of theme modules
local themes = {
  nord = 'plugins.themes.nord',
  onedark = 'plugins.themes.onedark',
  gruvbox = 'plugins.themes.gruvbox',
  tokyonight = 'plugins.themes.tokyonight',
}

local selected_theme = themes[env_var_nvim_theme] or themes[default_color_scheme]

-- Setup plugins
require('lazy').setup({
  require(selected_theme),
  require 'plugins.telescope',
  require 'plugins.treesitter',
  require 'plugins.lsp',
  require 'plugins.autocompletion',
  require 'plugins.none-ls',
  require 'plugins.lualine',
  require 'plugins.bufferline',
  require 'plugins.neo-tree',
  require 'plugins.oil',
  require 'plugins.alpha',
  require 'plugins.indent-blankline',
  require 'plugins.lazygit',
  require 'plugins.comment',
  require 'plugins.debug',
  require 'plugins.gitsigns',
  require 'plugins.database',
  require 'plugins.misc',
  require 'plugins.harpoon',
  require 'plugins.vim-tmux-navigator',
  require 'plugins.surround',
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- Auto-load local session file if present
local session_file = '.session.vim'
if uv.fs_stat(session_file) then
  vim.cmd('source ' .. vim.fn.fnameescape(session_file))
end
