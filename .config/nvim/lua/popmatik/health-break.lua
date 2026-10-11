return {
  'popmatik/health-break.nvim',
  config = function()
    require('health-break').setup {
      -- Default config shown - all optional
      hydration = {
        enabled = true,
        interval = 3600, -- 60 minutes in seconds
        lock_duration = 30,
        message = '💧 Hydrate! Your kidneys need this.',
      },
      movement = {
        enabled = true,
        interval = 2700, -- 45 minutes in seconds
        lock_duration = 60,
        message = '🚶 Move your arse! Stand, stretch, walk.',
      },
      auto_start = true, -- Start timers automatically
    }
  end,
}
