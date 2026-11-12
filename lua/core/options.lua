-- General Neovim options

vim.opt.hlsearch = false -- Set highlight on search
vim.opt.number = true -- Make line numbers default
vim.opt.relativenumber = true -- Set relative numbered lines
vim.opt.numberwidth = 4 -- Set number column width
vim.opt.mouse = 'a' -- Enable mouse mode
vim.opt.clipboard = 'unnamedplus' -- Sync clipboard between OS and Neovim
vim.opt.breakindent = true -- Enable break indent
vim.opt.undofile = true -- Save undo history
vim.opt.ignorecase = true -- Case-insensitive searching UNLESS \C or capital in search
vim.opt.smartcase = true -- Smart case
vim.opt.signcolumn = 'yes' -- Keep signcolumn on by default
vim.opt.updatetime = 250 -- Decrease update time
vim.opt.timeoutlen = 300 -- Time to wait for a mapped sequence to complete (ms)
vim.opt.backup = false -- Do not create a backup file
vim.opt.writebackup = false -- Do not create a writebackup file
vim.opt.swapfile = false -- Do not create a swapfile
vim.opt.completeopt = 'menuone,noselect' -- Better completion experience
vim.opt.termguicolors = true -- Enable 24-bit RGB colors
vim.opt.whichwrap = 'bs<>[]hl' -- Horizontal keys allowed to travel to prev/next line
vim.opt.wrap = false -- Display lines as one long line
vim.opt.linebreak = true -- Companion to wrap: don't split words
vim.opt.scrolloff = 4 -- Minimal screen lines above/below cursor
vim.opt.sidescrolloff = 8 -- Minimal screen columns either side of cursor
vim.opt.shiftwidth = 4 -- Spaces inserted for each indentation
vim.opt.tabstop = 4 -- Spaces per tab
vim.opt.softtabstop = 4 -- Spaces a tab counts for during editing
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.cursorline = false -- Do not highlight the current line
vim.opt.splitbelow = true -- Horizontal splits go below current window
vim.opt.splitright = true -- Vertical splits go to the right of current window
vim.opt.smartindent = true -- Make indenting smarter
vim.opt.autoindent = true -- Copy indent from current line when starting new one
vim.opt.showmode = false -- Hide -- INSERT -- mode indicator
vim.opt.showtabline = 1 -- Show tabline only when >= 2 tabs exist
vim.opt.backspace = 'indent,eol,start' -- Allow backspace over everything in insert mode
vim.opt.pumheight = 10 -- Pop-up menu height
vim.opt.conceallevel = 0 -- Make `` visible in markdown files
vim.opt.fileencoding = 'utf-8' -- Encoding written to a file
vim.opt.cmdheight = 1 -- Command line height
vim.opt.shortmess:append 'c' -- Don't give |ins-completion-menu| messages
vim.opt.iskeyword:append '-' -- Hyphenated words recognized by searches
vim.opt.runtimepath:remove '/usr/share/vim/vimfiles' -- Separate vim plugins from neovim

-- Prevent filetype plugins from re-enabling auto-commenting on new lines
vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('FormatOptions', { clear = true }),
  callback = function()
    vim.opt_local.formatoptions:remove { 'c', 'r', 'o' }
  end,
})