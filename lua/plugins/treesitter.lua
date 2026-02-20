return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'master', -- Kept as requested to prevent regression
  build = ':TSUpdate',
  dependencies = {
    {
      'nvim-treesitter/nvim-treesitter-textobjects',
      lazy = true,
    },
  },
  config = function()
    local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
    if not status_ok then
      return
    end

    configs.setup {
      -- A list of parser names, or "all"
      ensure_installed = {
        'lua',
        'python',
        'javascript',
        'typescript',
        'vimdoc',
        'vim',
        'regex',
        'terraform',
        'sql',
        'dockerfile',
        'toml',
        'json',
        'java',
        'groovy',
        'go',
        'gitignore',
        'graphql',
        'yaml',
        'make',
        'cmake',
        'markdown',
        'markdown_inline',
        'bash',
        'tsx',
        'css',
        'html',
        'c',
        'cpp',
      },

      -- Install parsers synchronously (only useful if you have issues with async)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      auto_install = true,

      highlight = {
        enable = true,
        -- Set this to `true` ONLY if your colorscheme is very old and doesn't support Treesitter.
        -- Otherwise, keep it `false` for speed and correct Treesitter colors.
        additional_vim_regex_highlighting = false,
        disable = { 'fidget' },
      },

      indent = { enable = true },

      -- NEW: Smart selection (this is a game changer for C++ blocks)
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<c-space>', -- Start selecting (Ctrl + Space)
          node_incremental = '<c-space>', -- Expand selection
          scope_incremental = '<c-s>', -- Expand to surrounding scope (function/class)
          node_decremental = '<M-space>', -- Shrink selection (Alt + Space)
        },
      },

      -- Your existing textobjects config (preserved)
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            [']m'] = '@function.outer',
            [']]'] = '@class.outer',
          },
          goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>a'] = '@parameter.inner',
          },
          swap_previous = {
            ['<leader>A'] = '@parameter.inner',
          },
        },
      },
    }

    -- Cleaned up filetype associations
    vim.filetype.add {
      extension = {
        tf = 'terraform',
        tfvars = 'terraform',
        pipeline = 'groovy',
        multibranch = 'groovy',
      },
    }
  end,
}
