return {
  {
    'mason-org/mason.nvim',
    lazy = false,
    opts = {},
    config = function(_, opts)
      require('mason').setup(opts)

      local registry = require 'mason-registry'
      local tools = { 'prettierd', 'stylua' }

      registry.refresh(function()
        for _, name in ipairs(tools) do
          local pkg = registry.get_package(name)
          if not pkg:is_installed() then
            pkg:install()
          end
        end
      end)
    end,
  },

  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = { 'mason-org/mason.nvim' },
    opts = {
      ensure_installed = {
        'lua_ls',
        'ts_ls',
        'cssls',
        'pyright',
        'svelte',
        'tailwindcss',
      },
      automatic_enable = true,
    },
  },
}
