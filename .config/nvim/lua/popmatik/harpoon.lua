return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' }, -- Dependency for Harpoon
  config = function()
    local harpoon = require 'harpoon'

    -- Setup harpoon
    harpoon:setup {
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
        key = function()
          return vim.loop.cwd()
        end,
      },
      menu = {
        width = 80,
        height = 10,
      },
    }

    -- Keymappings for Harpoon 2
    vim.keymap.set('n', '<leader>h', function()
      harpoon:list():add()
    end, { desc = 'Add file to Harpoon' })

    vim.keymap.set('n', '<leader>l', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Toggle Harpoon list' })

    -- Navigate between Harpoon marks
    vim.keymap.set('n', '<leader>1', function()
      harpoon:list():select(1)
    end, { desc = 'Go to Harpoon mark 1' })

    vim.keymap.set('n', '<leader>2', function()
      harpoon:list():select(2)
    end, { desc = 'Go to Harpoon mark 2' })

    vim.keymap.set('n', '<leader>3', function()
      harpoon:list():select(3)
    end, { desc = 'Go to Harpoon mark 3' })

    vim.keymap.set('n', '<leader>4', function()
      harpoon:list():select(4)
    end, { desc = 'Go to Harpoon mark 4' })

    -- Add navigation between marks
    vim.keymap.set('n', '<C-p>', function()
      harpoon:list():prev()
    end, { desc = 'Go to previous Harpoon mark' })

    vim.keymap.set('n', '<C-n>', function()
      harpoon:list():next()
    end, { desc = 'Go to next Harpoon mark' })
  end,
}
