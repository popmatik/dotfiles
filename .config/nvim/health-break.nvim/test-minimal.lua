-- Minimal test script for health-break.nvim
-- Run with: nvim -u test-minimal.lua

-- Reset runtimepath to minimal
vim.opt.runtimepath:remove(vim.fn.stdpath('config'))
vim.opt.runtimepath:remove(vim.fn.stdpath('data') .. '/site')

-- Add only this plugin
vim.opt.runtimepath:append('.')

-- Setup with very short intervals for testing
require('health-break').setup({
  hydration = {
    enabled = true,
    interval = 10,  -- 10 seconds
    lock_duration = 5,  -- 5 seconds
    message = "💧 HYDRATION TEST (5 sec)",
  },
  movement = {
    enabled = true,
    interval = 7,  -- 7 seconds
    lock_duration = 8,  -- 8 seconds
    message = "🚶 MOVEMENT TEST (8 sec)",
  },
  auto_start = true,
})

-- Print test instructions
print("=== health-break.nvim Test ===")
print("Timers started with short intervals:")
print("- Movement: 7 seconds interval, 8 second lock")
print("- Hydration: 10 seconds interval, 5 second lock")
print("")
print("Commands to test:")
print(":HealthBreakNow - Trigger immediate break")
print(":HealthBreakStop - Stop timers")
print(":HealthBreakStart - Restart timers")
print(":HealthBreakStatus - Check status")
print("")
print("Wait 7-10 seconds to see automatic breaks...")
