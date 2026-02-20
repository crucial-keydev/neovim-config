return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
    'mfussenegger/nvim-dap-python',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      automatic_setup = true,
      automatic_installation = true,
      handlers = {},
      ensure_installed = {
        'debugpy',
      },
    }

    -- Basic debugging keymaps
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })

    -- --- NEW KEYMAPS ---

    -- 1. Stop/Terminate Debugging
    -- Shift+F5 is standard in many IDEs for "Stop"
    vim.keymap.set('n', '<S-F5>', dap.terminate, { desc = 'Debug: Stop/Terminate' })

    -- 2. Close Debug Windows
    -- F7 toggles the UI. If it is open, this closes it.
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: Toggle/Close UI' })

    -- (Optional) Specific "Force Close" if you prefer explicit closing
    vim.keymap.set('n', '<leader>dx', dapui.close, { desc = 'Debug: Close UI' })

    -- Dap UI setup
    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Listeners to automatically open/close the UI
    dap.listeners.after.event_initialized['dapui_config'] = dapui.open

    -- Note: We generally want the UI to close when the session ends,
    -- but sometimes it's useful to keep it open to see logs.
    -- If you want it to ALWAYS close when you hit Stop (<S-F5>), keep these lines:
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    require('dap-python').setup()
  end,
}
