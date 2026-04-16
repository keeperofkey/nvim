return {
  {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',
    opts = {
      keymap = {
        preset = 'enter',
        ['<C-y>'] = { 'select_and_accept' },
        ['<Tab>'] = { 'fallback' },
        ['<S-Tab>'] = { 'fallback' },
        ['<CR>'] = { 'snippet_forward', 'select_and_accept' },
        ['<C-Right>'] = { 'snippet_forward', 'select_and_accept' },
        ['<C-Left>'] = { 'snippet_backward', 'fallback' },
      },
      appearance = { nerd_font_variant = 'mono' },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      completion = {
        menu = {
          -- adjust menu position for noice.nvim
          -- cmdline_position = function()
          --   local pos = vim.g.ui_cmdline_pos
          --   if pos then
          --     return { pos[1] - 2, pos[2] - 3 }
          --   end
          --   local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
          --   return { vim.o.lines - height, 0 }
          -- end,
          draw = {
            -- padding = { 1, 1 },
            columns = {
              { 'label', 'label_description', gap = 1 },
              { 'kind_icon', gap = 1 },
            },
            components = {
              kind_icon = {
                text = function(ctx)
                  local kind_icon, kind_hl = get_mini_icon(ctx)
                  return kind_icon
                end,
                -- (optional) use highlights from mini.icons
                highlight = function(ctx)
                  local _, hl = get_mini_icon(ctx)
                  return hl
                end,
              },
              kind = {
                -- (optional) use highlights from mini.icons
                highlight = function(ctx)
                  local _, hl = get_mini_icon(ctx)
                  return hl
                end,
              },
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
