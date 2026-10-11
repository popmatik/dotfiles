# Testing health-break.nvim

## Quick Test Setup

To test the plugin with shorter intervals (so you don't have to wait an hour):

```lua
require('health-break').setup({
  hydration = {
    enabled = true,
    interval = 20,  -- 20 seconds for testing
    lock_duration = 5,  -- 5 seconds lock
    message = "💧 TEST: Hydrate!",
  },
  movement = {
    enabled = true,
    interval = 15,  -- 15 seconds for testing
    lock_duration = 8,  -- 8 seconds lock
    message = "🚶 TEST: Move!",
  },
  auto_start = true,
})
```

## Manual Testing Checklist

### Basic Functionality
- [ ] Plugin loads without errors
- [ ] `:HealthBreakStart` starts timers
- [ ] `:HealthBreakStop` stops timers
- [ ] `:HealthBreakStatus` shows correct status
- [ ] `:HealthBreakNow` triggers immediate break

### Lock Screen
- [ ] Full-screen overlay appears
- [ ] Countdown timer displays correctly
- [ ] Messages are centered and readable
- [ ] Cannot dismiss with ESC
- [ ] Cannot dismiss with Ctrl-C
- [ ] Cannot dismiss with any key
- [ ] Timer counts down to 0
- [ ] Screen auto-unlocks when timer expires
- [ ] Normal editing resumes after unlock

### Timer Coordination
- [ ] Hydration timer fires at correct interval
- [ ] Movement timer fires at correct interval
- [ ] Combined breaks show both messages
- [ ] Combined breaks use longer duration
- [ ] Timers don't overlap (only one lock at a time)
- [ ] Timers restart after break completes

### Individual Break Types
- [ ] `:HealthBreakNowHydration` shows only hydration message
- [ ] `:HealthBreakNowMovement` shows only movement message
- [ ] `:HealthBreakNow` shows both messages combined

### Edge Cases
- [ ] Plugin works with split windows
- [ ] Plugin works with multiple tabs
- [ ] Stopping timers mid-countdown works correctly
- [ ] Restarting timers resets intervals
- [ ] Plugin handles Neovim resize during lock

## Automated Testing Ideas

For future development:

1. Unit tests for timer logic
2. Integration tests for overlay display
3. Test timer coordination
4. Test configuration validation
5. Test command execution

## Performance Testing

Monitor for:
- Memory leaks from timer objects
- CPU usage during countdown
- Buffer cleanup after unlock
- Timer cleanup on :HealthBreakStop

## Installation Test

Test in a fresh Neovim config:

```lua
-- minimal init.lua for testing
vim.opt.runtimepath:append('~/path/to/health-break.nvim')

require('health-break').setup({
  hydration = {
    interval = 20,
    lock_duration = 5,
  },
  movement = {
    interval = 15,
    lock_duration = 8,
  },
})
```

Run: `nvim -u minimal-init.lua`
