local servers = {
  'lua_ls',
  'ts_ls',
  'cssls',
  'pyright',
  'svelte',
  'tailwindcss',
}

return {
  {
    'mason-org/mason.nvim',
    cmd = { 'Mason', 'MasonInstall', 'MasonUninstall', 'MasonUpdate', 'MasonLog' },
    opts = {},
  },

  {
    'mason-org/mason-lspconfig.nvim',
    event = 'VeryLazy',
    dependencies = { 'mason-org/mason.nvim' },
    opts = {
      ensure_installed = servers,
      automatic_enable = false,
    },
  },

  {
    'neovim/nvim-lspconfig',
    lazy = false,
    init = function()
      vim.lsp.enable(servers)
    end,
  },
}
