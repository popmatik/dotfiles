local M = {}

-- Store active timer handles
M.timers = {
  hydration = nil,
  movement = nil,
}

-- Track if we're currently in a break
M.in_break = false

-- Create a timer that triggers a break
local function create_timer(break_type, config, on_trigger)
  local timer = vim.loop.new_timer()

  -- Convert seconds to milliseconds for vim.loop
  local interval_ms = config.interval * 1000

  -- Start timer with initial delay and repeat interval
  timer:start(interval_ms, interval_ms, vim.schedule_wrap(function()
    if not M.in_break then
      on_trigger(break_type, config)
    end
  end))

  return timer
end

-- Start a specific break timer
function M.start_timer(break_type, config, on_trigger)
  -- Stop existing timer if running
  M.stop_timer(break_type)

  -- Create and store new timer
  M.timers[break_type] = create_timer(break_type, config, on_trigger)
end

-- Stop a specific timer
function M.stop_timer(break_type)
  local timer = M.timers[break_type]
  if timer then
    if not timer:is_closing() then
      timer:stop()
      timer:close()
    end
    M.timers[break_type] = nil
  end
end

-- Stop all timers
function M.stop_all()
  for break_type, _ in pairs(M.timers) do
    M.stop_timer(break_type)
  end
  M.in_break = false
end

-- Check if any timers are running
function M.is_running()
  for _, timer in pairs(M.timers) do
    if timer and not timer:is_closing() then
      return true
    end
  end
  return false
end

-- Set break state
function M.set_break_state(state)
  M.in_break = state
end

return M
