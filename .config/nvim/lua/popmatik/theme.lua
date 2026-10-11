-- The colorscheme comes from ~/.local/state/theme/current/nvim.lua, set by ~/dotfiles/bin/theme.
-- `theme` sends SIGUSR1 to every nvim, which re-reads that file and re-applies it.
local theme_file = vim.fn.expand '~/.local/state/theme/current/nvim.lua'

local function read_theme()
  local ok, theme = pcall(dofile, theme_file)
  if ok and type(theme) == 'table' and theme.colorscheme then
    return theme
  end
  return { colorscheme = 'catppuccin-mocha', lualine = 'catppuccin' }
end

local function apply()
  local theme = read_theme()
  vim.g.popmatik_lualine_theme = theme.lualine or 'auto'
  vim.o.background = theme.background or 'dark'
  if theme.setup then
    pcall(theme.setup)
  end

  if not pcall(vim.cmd.colorscheme, theme.colorscheme) then
    vim.notify('theme: colorscheme ' .. theme.colorscheme .. ' not found', vim.log.levels.WARN)
    return
  end

  -- You can configure highlights by doing something like:
  vim.cmd.hi 'Comment gui=none'
  for group, hl in pairs(theme.highlights or {}) do
    vim.api.nvim_set_hl(0, group, vim.tbl_extend('force', vim.api.nvim_get_hl(0, { name = group }), hl))
  end

  -- On a live switch lualine is already running; re-setup it with the new theme.
  if package.loaded['lualine'] then
    local lualine = require 'lualine'
    local config = lualine.get_config()
    config.options.theme = vim.g.popmatik_lualine_theme
    lualine.setup(config)
  end
end

vim.api.nvim_create_autocmd('Signal', {
  pattern = 'SIGUSR1',
  callback = function()
    vim.schedule(apply)
  end,
})

return {
  { 'rose-pine/neovim', name = 'rose-pine', lazy = true },
  { 'gbprod/nord.nvim', lazy = true },
  { 'ellisonleao/gruvbox.nvim', lazy = true },
  { 'bjarneo/hackerman.nvim', lazy = true, dependencies = { 'bjarneo/aether.nvim' } },
  { 'neanias/everforest-nvim', lazy = true },
  { 'loctvl842/monokai-pro.nvim', lazy = true },
  { 'OldJobobo/retro-82.nvim', lazy = true },
  { 'folke/tokyonight.nvim', lazy = true },
  {
    'catppuccin/nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      require('catppuccin').setup {}
      apply()
    end,
  },
}
