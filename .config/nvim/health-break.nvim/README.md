# health-break.nvim

> Force yourself to take health breaks. Because gentle reminders don't work when you're in the zone.

A Neovim plugin that **locks your editor** and forces you to take hydration and movement breaks. No dismissing, no escaping, no "just one more minute."

## Why This Exists

I've had kidney stones. Three times. Each time caused by the same thing: getting hyperfocused on code and forgetting to drink water for 8+ hours straight. I also deal with back pain and hamstring tightness from sitting for too long.

Gentle reminders don't work. I dismiss them instantly. My brain is in the zone, and a notification is just noise.

**This plugin doesn't ask. It forces.**

Every 60 minutes, your editor locks for 30 seconds and tells you to hydrate. Every 45 minutes, it locks for 60 seconds and tells you to move. You cannot dismiss it. You cannot escape it. You wait it out, and you take the break.

This is health-driven development.

## Features

- **Forced hydration breaks** every 60 minutes (30-second lock)
- **Forced movement breaks** every 45 minutes (60-second lock)
- **Undismissable lock screen** - no escape sequences work
- **Countdown timer** so you know exactly how long to wait
- **Combined breaks** - if both timers fire together, you get both messages and the longer duration
- **Auto-start on launch** - protection begins immediately
- **Fully configurable** intervals and messages

## Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  'yourusername/health-break.nvim',
  config = function()
    require('health-break').setup({
      -- Default config shown - all optional
      hydration = {
        enabled = true,
        interval = 3600,  -- 60 minutes in seconds
        lock_duration = 30,
        message = "💧 Hydrate! Your kidneys need this.",
      },
      movement = {
        enabled = true,
        interval = 2700,  -- 45 minutes in seconds
        lock_duration = 60,
        message = "🚶 Move your arse! Stand, stretch, walk.",
      },
      auto_start = true,  -- Start timers automatically
    })
  end,
}
```

### Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  'yourusername/health-break.nvim',
  config = function()
    require('health-break').setup()
  end
}
```

## Usage

### Commands

```vim
:HealthBreakStart          " Start all enabled timers
:HealthBreakStop           " Stop all timers
:HealthBreakNow            " Trigger immediate break (both types)
:HealthBreakStatus         " Check if timers are running

" Testing individual break types:
:HealthBreakNowHydration   " Test hydration break
:HealthBreakNowMovement    " Test movement break
```

### Configuration

```lua
require('health-break').setup({
  hydration = {
    enabled = true,           -- Enable/disable hydration breaks
    interval = 3600,          -- Seconds between breaks (60 min)
    lock_duration = 30,       -- How long the screen locks (30 sec)
    message = "💧 Custom message here",
  },
  movement = {
    enabled = true,           -- Enable/disable movement breaks
    interval = 2700,          -- Seconds between breaks (45 min)
    lock_duration = 60,       -- How long the screen locks (60 sec)
    message = "🚶 Custom message here",
  },
  auto_start = true,          -- Auto-start on Neovim launch
})
```

## Medical Context

**Disclaimer:** I'm a developer, not a doctor. This is personal experience and research, not medical advice. Consult healthcare professionals for medical guidance.

### Kidney Stones and Hydration

Kidney stones form when minerals crystallize in concentrated urine. Coding sessions can easily stretch 4-8 hours without water, creating perfect conditions for stone formation. Even mild dehydration increases risk.

The pain is excruciating. The medical bills are expensive. The recovery disrupts your work for days or weeks.

**Prevention is simple: drink water regularly.**

### Sitting Disease

Prolonged sitting is linked to:
- Cardiovascular disease
- Diabetes risk
- Back and neck pain
- Reduced circulation
- Muscle atrophy
- Increased mortality risk

Studies show that even regular exercise doesn't fully offset the risks of sitting 8+ hours daily. **Movement breaks are essential.**

### Why Hyperfocus Makes This Worse

For people with ADHD, autism, or intense focus states:
- **Interoception** (sensing body signals) is impaired
- You genuinely don't notice thirst, hunger, or discomfort
- Time distortion makes hours feel like minutes
- Context switching feels impossible

This isn't laziness or poor discipline. **Your brain is wired differently.** You need external systems that don't rely on self-awareness.

### Resources

- [Kidney Stone Prevention (Mayo Clinic)](https://www.mayoclinic.org/diseases-conditions/kidney-stones/symptoms-causes/syc-20355755)
- [Sitting Disease Research](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC8006163/)
- [ADHD and Interoception](https://www.additudemag.com/interoception-adhd-awareness/)

## Philosophy

This plugin is **intentionally inflexible**. There's no snooze button. There's no "skip this break" option. There's no "focus mode" that disables breaks.

Why? Because those features would defeat the purpose.

Your brain will rationalize skipping breaks: "Just finish this function." "One more test." "Let me fix this bug first."

The lock forces you to:
1. **Step away from the screen** (even for 30 seconds)
2. **Break the hyperfocus cycle**
3. **Remember your body exists**
4. **Actually hydrate or move**

If you find yourself frustrated by the interruptions, that's a sign you needed them.

## FAQ

**Q: Can I disable breaks temporarily?**
A: Yes, use `:HealthBreakStop`. But be honest about why. Are you in a real emergency, or are you rationalizing?

**Q: 60/45 minutes seems too frequent!**
A: Adjust the intervals in your config. But consider: if breaks feel frequent, you might be sitting too long.

**Q: What if I'm in a meeting/presentation?**
A: Run `:HealthBreakStop` beforehand. Set a reminder to restart afterward.

**Q: Can I make the messages nicer?**
A: Absolutely. Customize them in your config. Use whatever language motivates you.

**Q: Will this work with my setup (tmux/multiplexer)?**
A: It only locks the Neovim instance where it's running. Other terminal panes remain accessible.

**Q: Is this overkill?**
A: Maybe. But kidney stones are also overkill. Choose your battles.

## Roadmap

MVP (Current):
- [x] Hydration and movement timers
- [x] Undismissable lock screen
- [x] Combined breaks
- [x] Auto-start
- [x] Basic commands

Future ideas:
- [ ] Streak tracking
- [ ] Break history/stats
- [ ] Sound notifications
- [ ] Rotating stretch suggestions
- [ ] Status line integration
- [ ] Multiple break types (eyes, posture)
- [ ] Sit/stand desk integration

## Contributing

PRs welcome! Especially:
- Bug fixes
- Better lock screen visuals
- Cross-platform testing
- Documentation improvements

Please don't submit:
- Features that make breaks optional/skippable
- "Smart" break timing (AI/ML)
- Dismissable notifications

The forced break mechanism is the core feature, not a bug.

## License

MIT

## Credits

Built with frustration, medical bills, and a genuine desire to prevent others from experiencing kidney stone pain.

If this plugin helps you, consider:
1. Drinking a glass of water right now
2. Standing up and stretching
3. Sharing this with other hyperfocus-prone developers

Stay hydrated. Keep moving. Your body will thank you.
