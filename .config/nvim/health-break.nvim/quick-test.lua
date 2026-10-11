-- Quick visual test - loads plugin and triggers immediate break
-- Run with: nvim -u quick-test.lua

-- Minimal setup
vim.opt.runtimepath:prepend('/Users/robleach/dotfiles/.config/nvim/health-break.nvim')

-- Setup plugin
require('health-break').setup({
  hydration = {
    enabled = true,
    interval = 20,
    lock_duration = 5,
    message = "💧 Hydration test! Try to escape (you can't)",
  },
  movement = {
    enabled = true,
    interval = 15,
    lock_duration = 7,
    message = "🚶 Movement test! Press ESC (nothing happens)",
  },
  auto_start = false,
})

-- Wait a moment for Neovim to initialize, then trigger break
vim.defer_fn(function()
  print("Triggering test break in 2 seconds...")
  print("When the lock screen appears:")
  print("  - Try pressing ESC")
  print("  - Try pressing Ctrl-C")
  print("  - Try pressing 'q'")
  print("  - Try pressing ':'")
  print("  - Nothing should work!")
  print("  - Wait for the countdown to reach 0")

  vim.defer_fn(function()
    require('health-break').now()
  end, 2000)
end, 500)
