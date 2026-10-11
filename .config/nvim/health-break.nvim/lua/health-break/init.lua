local M = {}

local config = require('health-break.config')
local timer = require('health-break.timer')
local overlay = require('health-break.overlay')

-- Track which breaks are pending (for combined breaks)
local pending_breaks = {}

-- Handle a break trigger
local function trigger_break(break_type, break_config)
  -- Add to pending breaks
  table.insert(pending_breaks, {
    type = break_type,
    config = break_config,
  })

  -- If multiple breaks are pending, combine them
  if #pending_breaks == 1 then
    -- Wait a brief moment to see if another break fires
    vim.defer_fn(function()
      execute_breaks()
    end, 100)
  end
end

-- Execute all pending breaks
function execute_breaks()
  if #pending_breaks == 0 then
    return
  end

  -- Collect messages and find max duration
  local messages = {}
  local max_duration = 0

  for _, break_info in ipairs(pending_breaks) do
    table.insert(messages, break_info.config.message)
    if break_info.config.lock_duration > max_duration then
      max_duration = break_info.config.lock_duration
    end
  end

  -- Clear pending breaks
  pending_breaks = {}

  -- Show combined overlay
  overlay.show(messages, max_duration)
end

-- Start all enabled timers
function M.start()
  local opts = config.get()

  -- Start hydration timer if enabled
  if opts.hydration.enabled then
    timer.start_timer('hydration', opts.hydration, trigger_break)
  end

  -- Start movement timer if enabled
  if opts.movement.enabled then
    timer.start_timer('movement', opts.movement, trigger_break)
  end

  vim.notify('Health breaks started!', vim.log.levels.INFO)
end

-- Stop all timers
function M.stop()
  timer.stop_all()
  vim.notify('Health breaks stopped', vim.log.levels.INFO)
end

-- Trigger immediate break (for testing)
function M.now(break_type)
  local opts = config.get()

  if break_type == 'hydration' then
    trigger_break('hydration', opts.hydration)
  elseif break_type == 'movement' then
    trigger_break('movement', opts.movement)
  else
    -- Trigger both
    trigger_break('hydration', opts.hydration)
    trigger_break('movement', opts.movement)
  end

  execute_breaks()
end

-- Setup function
function M.setup(user_config)
  -- Initialize configuration
  config.setup(user_config)

  -- Auto-start if enabled
  local opts = config.get()
  if opts.auto_start then
    -- Delay start slightly to allow Neovim to fully initialize
    vim.defer_fn(function()
      M.start()
    end, 1000)
  end
end

-- Status information
function M.status()
  if timer.is_running() then
    return 'Health breaks: Active'
  else
    return 'Health breaks: Stopped'
  end
end

return M
