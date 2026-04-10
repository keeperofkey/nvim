return {
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {},
  },

  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      bigfile      = { enabled = true },
      dashboard    = { enabled = true },
      indent       = { enabled = false },
      input        = { enabled = false },
      lazygit      = { enabled = true },
      notifier     = { enabled = false },
      quickfile    = { enabled = true },
      scroll       = { enabled = true },
      statuscolumn = { enabled = true },
      words        = { enabled = true },
    },
  },

  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = { 'MunifTanjim/nui.nvim' },
    opts = {
      cmdline = {
        enabled = true,
        view = 'cmdline_popup',
      },
      messages  = { enabled = true },
      popupmenu = { enabled = false }, -- blink handles completion menu
      notify    = { enabled = true },
      lsp = {
        progress  = { enabled = true },
        hover     = { enabled = false },    -- use native LSP hover
        signature = { enabled = false },    -- use native LSP signature
        message   = { enabled = true },
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
        },
      },
      presets = {
        bottom_search        = true,
        command_palette      = true,
        long_message_to_split = true,
      },
    },
  },

  {
    'nvim-mini/mini.nvim',
    lazy = false,
    config = function()
      require('mini.ai').setup()
      require('mini.surround').setup()
      require('mini.pairs').setup()
      require('mini.icons').setup()
      MiniIcons.mock_nvim_web_devicons()

      require('mini.files').setup {
        windows = {
          preview = true,
          width_focus = 30,
          width_preview = 50,
        },
      }

      require('mini.tabline').setup()

      require('mini.statusline').setup {
        content = {
          active = function()
            local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }
            mode = mode:upper()
            local git         = MiniStatusline.section_git { trunc_width = 75 }
            local diagnostics = MiniStatusline.section_diagnostics { trunc_width = 75 }
            local location    = MiniStatusline.section_location { trunc_width = 75 }

            local macro = vim.fn.reg_recording()
            local macro_str = macro ~= '' and ('Recording @' .. macro) or ''

            local ft = vim.bo.filetype
            local ft_icon = ft ~= '' and (MiniIcons.get('filetype', ft) .. ' ' .. ft) or ''

            local clock = '   ' .. os.date '%R' .. ' '

            return MiniStatusline.combine_groups {
              { hl = mode_hl,                    strings = { mode } },
              { hl = 'MiniStatuslineDevinfo',    strings = { git, diagnostics } },
              { hl = 'MiniStatuslineFilename',   strings = { macro_str } },
              '%<',
              '%=',
              { hl = 'MiniStatuslineFileinfo',   strings = { ft_icon } },
              { hl = 'MiniStatuslineDevinfo',    strings = { location } },
              { hl = mode_hl,                    strings = { clock } },
            }
          end,
          inactive = function()
            return MiniStatusline.combine_groups {
              { hl = 'MiniStatuslineInactive', strings = { '%f%m' } },
            }
          end,
        },
      }
    end,
  },
}
