local M = {}

local timer_module = require('health-break.timer')

-- Store overlay state
M.overlay = {
  buf = nil,
  win = nil,
  timer = nil,
  original_keymaps = {},
}

-- Disable all keymaps by mapping everything to <Nop>
local function disable_all_input()
  -- Store original keymaps for restoration later
  M.overlay.original_keymaps = {}

  -- Create a comprehensive list of keys to disable
  local keys_to_disable = {
    -- Normal mode keys
    '<Esc>', '<C-c>', '<C-[>', 'q', 'Q', 'ZZ', 'ZQ',
    'i', 'I', 'a', 'A', 'o', 'O',
    ':', '/', '?',
    -- Function keys
    '<F1>', '<F2>', '<F3>', '<F4>', '<F5>', '<F6>',
    '<F7>', '<F8>', '<F9>', '<F10>', '<F11>', '<F12>',
    -- Control combinations
    '<C-w>', '<C-q>', '<C-z>',
  }

  -- Disable keys in all modes
  local modes = { 'n', 'i', 'v', 'x', 's', 'o', 't', 'c' }
  for _, mode in ipairs(modes) do
    for _, key in ipairs(keys_to_disable) do
      vim.keymap.set(mode, key, '<Nop>', { buffer = M.overlay.buf })
    end
  end

  -- Also disable mouse
  vim.keymap.set('n', '<LeftMouse>', '<Nop>', { buffer = M.overlay.buf })
  vim.keymap.set('n', '<RightMouse>', '<Nop>', { buffer = M.overlay.buf })
end

-- Create the lock overlay window
local function create_overlay_window(messages, duration)
  -- Create a new buffer for overlay
  M.overlay.buf = vim.api.nvim_create_buf(false, true)

  -- Set buffer options
  vim.api.nvim_buf_set_option(M.overlay.buf, 'buftype', 'nofile')
  vim.api.nvim_buf_set_option(M.overlay.buf, 'bufhidden', 'wipe')
  vim.api.nvim_buf_set_option(M.overlay.buf, 'swapfile', false)
  vim.api.nvim_buf_set_option(M.overlay.buf, 'modifiable', false)

  -- Get editor dimensions
  local width = vim.o.columns
  local height = vim.o.lines

  -- Create fullscreen floating window
  local opts = {
    relative = 'editor',
    width = width,
    height = height,
    row = 0,
    col = 0,
    style = 'minimal',
    border = 'none',
    focusable = true,
    zindex = 1000,
  }

  M.overlay.win = vim.api.nvim_open_win(M.overlay.buf, true, opts)

  -- Set window options
  vim.api.nvim_win_set_option(M.overlay.win, 'winhl', 'Normal:HealthBreakOverlay')
  vim.api.nvim_win_set_option(M.overlay.win, 'cursorline', false)

  -- Disable all input
  disable_all_input()

  -- Initial render
  M.render_overlay(messages, duration)
end

-- Render the overlay content with countdown
function M.render_overlay(messages, remaining_seconds)
  if not M.overlay.buf or not vim.api.nvim_buf_is_valid(M.overlay.buf) then
    return
  end

  -- Make buffer modifiable temporarily
  vim.api.nvim_buf_set_option(M.overlay.buf, 'modifiable', true)

  -- Calculate centering
  local width = vim.o.columns
  local height = vim.o.lines

  local lines = {}

  -- Add empty lines to center vertically
  local content_height = #messages + 5 -- messages + spacing + countdown + info
  local top_padding = math.floor((height - content_height) / 2)

  for _ = 1, top_padding do
    table.insert(lines, '')
  end

  -- Add messages (centered)
  for _, message in ipairs(messages) do
    local padding = math.floor((width - vim.fn.strwidth(message)) / 2)
    table.insert(lines, string.rep(' ', padding) .. message)
  end

  -- Add spacing
  table.insert(lines, '')
  table.insert(lines, '')

  -- Add countdown (centered)
  local countdown_text = string.format('⏱  %d seconds remaining', remaining_seconds)
  local countdown_padding = math.floor((width - vim.fn.strwidth(countdown_text)) / 2)
  table.insert(lines, string.rep(' ', countdown_padding) .. countdown_text)

  table.insert(lines, '')

  -- Add info message (centered)
  local info_text = '(This break cannot be dismissed)'
  local info_padding = math.floor((width - vim.fn.strwidth(info_text)) / 2)
  table.insert(lines, string.rep(' ', info_padding) .. info_text)

  -- Set buffer content
  vim.api.nvim_buf_set_lines(M.overlay.buf, 0, -1, false, lines)

  -- Make buffer non-modifiable again
  vim.api.nvim_buf_set_option(M.overlay.buf, 'modifiable', false)
end

-- Close the overlay window
local function close_overlay()
  -- Stop countdown timer
  if M.overlay.timer then
    if not M.overlay.timer:is_closing() then
      M.overlay.timer:stop()
      M.overlay.timer:close()
    end
    M.overlay.timer = nil
  end

  -- Close window
  if M.overlay.win and vim.api.nvim_win_is_valid(M.overlay.win) then
    vim.api.nvim_win_close(M.overlay.win, true)
    M.overlay.win = nil
  end

  -- Delete buffer
  if M.overlay.buf and vim.api.nvim_buf_is_valid(M.overlay.buf) then
    vim.api.nvim_buf_delete(M.overlay.buf, { force = true })
    M.overlay.buf = nil
  end

  -- Reset break state
  timer_module.set_break_state(false)
end

-- Show the lock overlay for the specified duration
function M.show(messages, duration)
  -- Set break state
  timer_module.set_break_state(true)

  -- Create overlay window
  create_overlay_window(messages, duration)

  -- Start countdown
  local remaining = duration
  M.overlay.timer = vim.loop.new_timer()

  M.overlay.timer:start(0, 1000, vim.schedule_wrap(function()
    remaining = remaining - 1

    if remaining <= 0 then
      close_overlay()
    else
      M.render_overlay(messages, remaining)
    end
  end))
end

-- Define highlight group for overlay
vim.api.nvim_set_hl(0, 'HealthBreakOverlay', { bg = '#1e1e2e', fg = '#cdd6f4' })

return M
