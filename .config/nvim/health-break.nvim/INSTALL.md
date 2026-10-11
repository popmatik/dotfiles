# Installation Guide

## Quick Start (Local Testing)

Since you're developing this plugin locally, here's how to test it in your current Neovim setup:

### Option 1: Add to your init.lua (Temporary)

Add this to your Neovim config:

```lua
-- Add the local plugin to runtimepath
vim.opt.runtimepath:append('~/.config/nvim/health-break.nvim')

-- Setup with test intervals
require('health-break').setup({
  hydration = {
    interval = 30,  -- 30 seconds for testing
    lock_duration = 5,
  },
  movement = {
    interval = 20,  -- 20 seconds for testing
    lock_duration = 8,
  },
  auto_start = true,
})
```

### Option 2: Source the example config

```vim
:source ~/.config/nvim/health-break.nvim/examples/test-config.lua
```

### Option 3: Using lazy.nvim (Recommended for actual use)

Add to your lazy.nvim plugin config:

```lua
{
  dir = '~/.config/nvim/health-break.nvim',  -- Local directory
  name = 'health-break',
  config = function()
    require('health-break').setup({
      -- Use real intervals for actual work
      hydration = {
        interval = 3600,  -- 60 minutes
        lock_duration = 30,
      },
      movement = {
        interval = 2700,  -- 45 minutes
        lock_duration = 60,
      },
      auto_start = true,
    })
  end,
}
```

## Testing Commands

After loading the plugin, try:

```vim
:HealthBreakNow              " Trigger immediate break (both types)
:HealthBreakNowHydration     " Test hydration break only
:HealthBreakNowMovement      " Test movement break only
:HealthBreakStatus           " Check timer status
:HealthBreakStop             " Stop all timers
:HealthBreakStart            " Restart timers
```

## Troubleshooting

### Plugin not loading

Check that the path is correct:
```vim
:lua print(vim.fn.expand('~/.config/nvim/health-break.nvim'))
```

### Timers not starting

Check for errors:
```vim
:messages
```

### Lock screen not appearing

Try manual trigger:
```vim
:HealthBreakNow
```

If it works, timers are configured correctly but may need more time to fire.

## Publishing to GitHub

When ready to share:

1. Initialize git repo:
```bash
cd ~/.config/nvim/health-break.nvim
git init
git add .
git commit -m "Initial commit: health-break.nvim v0.1.0"
```

2. Create GitHub repo and push:
```bash
git remote add origin git@github.com:yourusername/health-break.nvim.git
git branch -M main
git push -u origin main
```

3. Update README.md to use your GitHub username instead of 'yourusername'

4. Update lazy.nvim config to use GitHub URL:
```lua
{
  'yourusername/health-break.nvim',
  config = function()
    require('health-break').setup()
  end,
}
```
