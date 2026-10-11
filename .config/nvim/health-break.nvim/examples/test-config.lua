-- Test configuration for health-break.nvim
-- Use shorter intervals to test without waiting hours

require('health-break').setup({
  hydration = {
    enabled = true,
    interval = 30,  -- 30 seconds for quick testing
    lock_duration = 5,  -- 5 second lock
    message = "💧 TEST: Time to hydrate! (5 sec test)",
  },
  movement = {
    enabled = true,
    interval = 20,  -- 20 seconds for quick testing
    lock_duration = 8,  -- 8 second lock
    message = "🚶 TEST: Time to move! (8 sec test)",
  },
  auto_start = true,
})

-- Print reminder
vim.notify('Health break test config loaded! Breaks will trigger soon.', vim.log.levels.INFO)
vim.notify('Movement: 20s interval, Hydration: 30s interval', vim.log.levels.INFO)
