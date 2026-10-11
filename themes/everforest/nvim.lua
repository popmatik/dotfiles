return {
  colorscheme = 'everforest',
  lualine = 'everforest',
  setup = function()
    require('everforest').setup { background = 'medium' }
  end,
}
