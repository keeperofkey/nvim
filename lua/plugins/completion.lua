return {
  {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',
    opts = {
      keymap = { preset = 'enter' },
      appearance = { nerd_font_variant = 'mono' },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      completion = {
        menu = {
          border = 'rounded',
          winhighlight = 'FloatBorder:NoiceCmdlineBorder,CursorLine:BlinkCmpMenuSelection',
          cmdline_position = function()
            local pos = vim.g.ui_cmdline_pos
            if pos then
              return { pos[1] - 2, pos[2] - 3 }
            end
            local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
            return { vim.o.lines - height, 0 }
          end,
          draw = {
            -- padding = { 1, 1 },
            columns = {
              { 'label', 'label_description', gap = 1 },
              { 'kind_icon', gap = 1 },
            },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = { border = 'rounded' },
        },
      },
      signature = { window = { border = 'rounded' } },
      fuzzy = { implementation = 'prefer_rust_with_warning' },
      cmdline = {
        enabled = true,
        completion = {
          menu = {
            auto_show = true,
          },
        },
      },
    },
    opts_extend = { 'sources.default' },
  },
}
