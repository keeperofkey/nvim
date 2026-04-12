return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('nvim-treesitter').setup {
        ensure_installed = {
          'lua',
          'vim',
          'vimdoc',
          'query',
          'markdown',
          'markdown_inline',
          'bash',
        },
      }

      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          local ok = pcall(vim.treesitter.start)
          if not ok then
            return
          end
          vim.wo.foldmethod = 'expr'
          vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          vim.wo.foldlevel = 99
        end,
      })
    end,
  },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },
    ft = { 'markdown' },
    opts = {
      heading = {
        width = 'block',
        left_pad = 1,
        right_pad = 4,
        icons = '',
        border = true,
        border_virtual = true,
        above = '',
        below = '━',
      },
      pipe_table = {
        preset = 'round',
        cell = 'padded',
      },
    },
  },

  {
    'supermaven-inc/supermaven-nvim',
    event = 'InsertEnter',
    opts = {
      keymaps = {
        accept_suggestion = '<Tab>',
        clear_suggestion = '<C-]>',
        accept_word = '<C-Right>',
        clear_word = '<C-Left>',
      },
    },
  },

  {
    'folke/todo-comments.nvim',
    event = 'BufReadPost',
    opts = { signs = false },
  },

  {
    'catgoose/nvim-colorizer.lua',
    event = 'BufReadPost',
    config = function()
      require('colorizer').setup()
    end,
  },
}
