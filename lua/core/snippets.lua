-- Custom code snippets and global behaviors

local hl = vim.hl or vim.highlight

-- Prevent LSP from overwriting treesitter color settings
-- https://github.com/NvChad/NvChad/issues/1907
if hl and hl.priorities then
  hl.priorities.semantic_tokens = 95 -- Lower than 100 (treesitter's priority level)
end

-- Appearance of diagnostics
vim.diagnostic.config {
  virtual_text = {
    prefix = '●',
    format = function(diagnostic)
      local code = diagnostic.code and string.format('[%s]', diagnostic.code) or ''
      return string.format('%s %s', code, diagnostic.message)
    end,
  },
  underline = false,
  update_in_insert = true,
  float = {
    source = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = ' ',
      [vim.diagnostic.severity.WARN] = ' ',
      [vim.diagnostic.severity.INFO] = ' ',
      [vim.diagnostic.severity.HINT] = '󰌵 ',
    },
  },
}

-- Make diagnostic virtual text background transparent across colorschemes
vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('DiagnosticHighlight', { clear = true }),
  callback = function()
    vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextError', { bg = 'NONE', default = true })
    vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextWarn', { bg = 'NONE', default = true })
    vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextInfo', { bg = 'NONE', default = true })
    vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextHint', { bg = 'NONE', default = true })
  end,
})

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    if hl and hl.on_yank then
      hl.on_yank()
    end
  end,
  group = highlight_group,
  pattern = '*',
})

-- Set kitty terminal padding to 0 when in nvim (only runs inside Kitty)
if vim.env.KITTY_WINDOW_ID then
  local kitty_group = vim.api.nvim_create_augroup('kitty_mp', { clear = true })
  vim.api.nvim_create_autocmd('VimEnter', {
    group = kitty_group,
    command = 'silent !kitty @ set-spacing padding=0 margin=0 3 0 3',
  })
  vim.api.nvim_create_autocmd('VimLeave', {
    group = kitty_group,
    command = 'silent !kitty @ set-spacing padding=default margin=default',
  })
end