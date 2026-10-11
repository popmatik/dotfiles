-- Interactive test for health-break.nvim
-- This will guide you through testing all features

-- Add plugin to runtimepath
vim.opt.runtimepath:prepend('/Users/robleach/dotfiles/.config/nvim/health-break.nvim')

-- Don't auto-start so we can test manually
require('health-break').setup({
  hydration = {
    enabled = true,
    interval = 15,  -- 15 seconds for testing
    lock_duration = 5,  -- 5 seconds
    message = "💧 TEST: Hydration break! (5 seconds)",
  },
  movement = {
    enabled = true,
    interval = 10,  -- 10 seconds for testing
    lock_duration = 7,  -- 7 seconds
    message = "🚶 TEST: Movement break! (7 seconds)",
  },
  auto_start = false,  -- We'll start manually
})

-- Create a test buffer with instructions
local buf = vim.api.nvim_create_buf(false, true)
local lines = {
  "=== health-break.nvim Interactive Test ===",
  "",
  "STEP 1: Test immediate break",
  "  Run: :HealthBreakNow",
  "  Expected: Full-screen lock with both messages, 7 second countdown",
  "  Try to press ESC, Ctrl-C, or any key - nothing should work!",
  "  Wait for the countdown to reach 0",
  "",
  "STEP 2: Test individual breaks",
  "  Run: :HealthBreakNowHydration",
  "  Expected: Hydration message only, 5 second countdown",
  "  ",
  "  Run: :HealthBreakNowMovement",
  "  Expected: Movement message only, 7 second countdown",
  "",
  "STEP 3: Check status",
  "  Run: :HealthBreakStatus",
  "  Expected: 'Health breaks: Stopped' (since auto_start is false)",
  "",
  "STEP 4: Start timers",
  "  Run: :HealthBreakStart",
  "  Expected: Notification 'Health breaks started!'",
  "  ",
  "  Run: :HealthBreakStatus",
  "  Expected: 'Health breaks: Active'",
  "",
  "STEP 5: Wait for automatic breaks",
  "  Wait ~10 seconds: Movement break should appear (7 sec lock)",
  "  Wait ~15 seconds: Hydration break should appear (5 sec lock)",
  "  Around 30 seconds total: You might see a combined break!",
  "",
  "STEP 6: Stop timers",
  "  Run: :HealthBreakStop",
  "  Expected: Notification 'Health breaks stopped'",
  "",
  "STEP 7: Restart timers",
  "  Run: :HealthBreakStart",
  "  Expected: Timers reset and start counting from 0 again",
  "",
  "=== All tests complete! ===",
  "",
  "Notes:",
  "- The lock screen should be IMPOSSIBLE to dismiss",
  "- Countdown should update every second",
  "- Normal editing should resume immediately after unlock",
  "- Combined breaks show both messages with the longer duration",
  "",
  "Press any key to begin testing...",
}

vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
vim.api.nvim_buf_set_option(buf, 'modifiable', false)
vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')

-- Open the buffer
vim.api.nvim_set_current_buf(buf)

-- Print to command line too
print("health-break.nvim test loaded!")
print("Follow the instructions in the buffer.")
print("Start with: :HealthBreakNow")
