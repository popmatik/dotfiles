local M = {}

-- Default configuration
M.defaults = {
  hydration = {
    enabled = true,
    interval = 3600, -- seconds (60 minutes)
    lock_duration = 30,
    message = "💧 Hydrate! Your kidneys need this.",
  },
  movement = {
    enabled = true,
    interval = 2700, -- seconds (45 minutes)
    lock_duration = 60,
    message = "🚶 Move your arse! Stand, stretch, walk.",
  },
  auto_start = true, -- Auto-start timers on launch
}

-- Current configuration (merged defaults + user config)
M.options = {}

-- Merge user config with defaults
function M.setup(user_config)
  M.options = vim.tbl_deep_extend("force", M.defaults, user_config or {})
  return M.options
end

-- Get current configuration
function M.get()
  return M.options
end

return M
