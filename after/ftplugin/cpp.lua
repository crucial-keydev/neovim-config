local map = function(keys, func, desc)
  vim.keymap.set('n', keys, func, { buffer = true, desc = 'CPP: ' .. desc })
end

-- Helper function to open a terminal split and run the command
local function run_in_terminal(make_target)
  vim.cmd 'w' -- 1. Save the file
  vim.cmd 'botright 15split' -- 2. Open a small split window at the bottom
  vim.cmd('terminal make ' .. make_target) -- 3. Run make in a real terminal
  vim.cmd 'startinsert' -- 4. Automatically switch to typing mode
end

-- <leader>r : Build & Run with GCC (Interactive)
map('<leader>r', function()
  run_in_terminal 'run-gcc'
end, 'Build & Run (GCC)')

-- <leader>rr : Build & Run with Clang (Interactive)
map('<leader>rr', function()
  run_in_terminal 'run-clang'
end, 'Build & Run (Clang)')
