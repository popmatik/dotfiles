return {
  'nvim-treesitter/nvim-treesitter-context',
  event = 'VeryLazy',
  config = function()
    require('treesitter-context').setup {
      enable = true, -- Enable this plugin
      max_lines = 3, -- How many lines the context window can span
      trim_scope = 'outer', -- How to trim long contexts ('inner' or 'outer')
      mode = 'cursor', -- Show context at cursor or top line
      separator = nil, -- You can add a line separator if you want
    }
  end,
}
