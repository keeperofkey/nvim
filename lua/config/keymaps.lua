local map = vim.keymap.set

local function project_root()
  local bufnr = vim.api.nvim_get_current_buf()
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  local cwd = (vim.uv or vim.loop).cwd()

  for _, client in ipairs(vim.lsp.get_clients { bufnr = bufnr }) do
    local root = client.config.root_dir
    if root and root ~= '' then
      return root
    end

    local workspace_folders = client.config.workspace_folders
    if workspace_folders and workspace_folders[1] and workspace_folders[1].name then
      return workspace_folders[1].name
    end
  end

  local start = bufname ~= '' and vim.fs.dirname(bufname) or cwd

  return vim.fs.root(start, {
    '.git',
    '.luarc.json',
    '.luarc.jsonc',
    'package.json',
    'pyproject.toml',
    'Cargo.toml',
    'go.mod',
    'Makefile',
    '.jj',
  }) or cwd
end

-- snacks picker
map('n', '<leader>fp', function()
  Snacks.picker()
end, { desc = 'Pick picker' })
map('n', '<leader>ff', function()
  Snacks.picker.files { cwd = project_root() }
end, { desc = 'Find project files' })
map('n', '<leader>fb', function()
  require('lib.filebrowser').browse()
end, { desc = 'File browser' })
map('n', '<leader>fm', function()
  require('mini.files').open()
end, { desc = 'File manager' })
map('n', '<leader>fg', function()
  Snacks.picker.grep { cwd = project_root() }
end, { desc = 'Live grep project' })
map('n', '<leader>f/', function()
  Snacks.picker.buffers()
end, { desc = 'Buffers' })
map('n', '<leader>fh', function()
  Snacks.picker.help()
end, { desc = 'Help tags' })
map('n', '<leader>fc', function()
  Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
end, { desc = 'Neovim config files' })
map('n', '<leader>fC', function()
  Snacks.picker.files { cwd = vim.fs.dirname(vim.fn.stdpath 'config') }
end, { desc = '.config files' })
map('n', '<leader>fr', function()
  Snacks.picker.recent()
end, { desc = 'Recent files' })
map('n', '<leader>fd', function()
  Snacks.picker.diagnostics_buffer()
end, { desc = 'Document diagnostics' })
map('n', '<leader>fs', function()
  Snacks.picker.lsp_symbols()
end, { desc = 'Document symbols' })
map('n', '<leader>fz', function()
  Snacks.picker.zoxide()
end, { desc = 'Zoxide' })

-- buffers
map('n', '<leader><Tab>', '<cmd>bnext<cr>', { desc = 'Next buffer' })
map('n', '<leader><S-Tab>', '<cmd>bprev<cr>', { desc = 'Prev buffer' })

-- noice
map('n', '<leader>n', function()
  Snacks.picker 'noice'
end, { desc = 'Notification history' })

-- lazygit
map('n', '<leader>gg', function()
  Snacks.lazygit { cwd = project_root() }
end, { desc = 'Lazygit' })

-- zen
map('n', '<leader>z', function()
  Snacks.zen()
end, { desc = 'Zen mode' })

-- todo-comments
map('n', '<leader>ft', function()
  Snacks.picker.todo_comments()
end, { desc = 'Find todos' })

-- clear search highlight
map('n', '<Esc>', '<cmd>nohlsearch<cr>')

-- window navigation
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Focus left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Focus right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Focus lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Focus upper window' })

-- window splits
map('n', '<leader>v', '<C-w><C-v>', { desc = 'Vertical split' })
map('n', '<leader>h', '<C-w><C-s>', { desc = 'Horizontal split' })

-- window move
map('n', '<leader>wL', '<C-w>L', { desc = 'Move window right' })
map('n', '<leader>wJ', '<C-w>J', { desc = 'Move window down' })

-- window resize
map('n', '<leader>we', '<C-w>=', { desc = 'Equal window sizes' })
map('n', '<leader>wi', '<C-w>+', { desc = 'Increase height' })
map('n', '<leader>wd', '<C-w>-', { desc = 'Decrease height' })
map('n', '<leader>wI', '<C-w><', { desc = 'Decrease width' })
map('n', '<leader>wD', '<C-w>>', { desc = 'Increase width' })

-- terminal
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
map('n', '<leader>tt', function()
  Snacks.terminal(nil, { count = 1 })
end, { desc = 'Toggle terminal (float)' })
map('n', '<leader>tT', function()
  Snacks.terminal(nil, { count = 2, cwd = vim.fn.expand '%:p:h' })
end, { desc = 'Terminal (file dir)' })
map('n', '<leader>ts', function()
  Snacks.terminal(nil, { count = 3, win = { position = 'right', width = 0.4 } })
end, { desc = 'Toggle terminal (split)' })

-- lsp (buffer-local, set on attach)
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local lmap = function(keys, func, desc)
      map('n', keys, func, { buffer = event.buf, desc = desc })
    end

    lmap('gd', vim.lsp.buf.definition, 'Go to definition')
    lmap('gD', vim.lsp.buf.declaration, 'Go to declaration')
    lmap('gi', vim.lsp.buf.implementation, 'Go to implementation')
    lmap('gr', vim.lsp.buf.references, 'Go to references')
    lmap('K', vim.lsp.buf.hover, 'Hover')
    lmap('<leader>lr', vim.lsp.buf.rename, 'Rename')
    lmap('<leader>la', vim.lsp.buf.code_action, 'Code action')
    lmap('<leader>lf', function()
      require('conform').format { bufnr = event.buf, lsp_format = 'fallback' }
    end, 'Format')
  end,
})

-- diagnostics
map('n', '[d', function() vim.diagnostic.jump { count = -1 } end, { desc = 'Prev diagnostic' })
map('n', ']d', function() vim.diagnostic.jump { count = 1 } end, { desc = 'Next diagnostic' })
map('n', '[e', function()
  vim.diagnostic.jump { count = -1, severity = vim.diagnostic.severity.ERROR }
end, { desc = 'Prev error' })
map('n', ']e', function()
  vim.diagnostic.jump { count = 1, severity = vim.diagnostic.severity.ERROR }
end, { desc = 'Next error' })
map('n', '<leader>e', function()
  local winid = vim.diagnostic.open_float { focusable = true }
  if winid then
    vim.schedule(function()
      if vim.api.nvim_win_is_valid(winid) then
        vim.api.nvim_set_current_win(winid)
      end
    end)
  end
end, { desc = 'Show diagnostic float' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostic quickfix' })

-- gitsigns (buffer-local, set on attach)
local M = {}

M.gitsigns_on_attach = function(bufnr)
  local gs = require 'gitsigns'
  local gmap = function(mode, keys, func, desc)
    map(mode, keys, func, { buffer = bufnr, desc = desc })
  end

  gmap('n', ']c', function()
    if vim.wo.diff then
      vim.cmd.normal { ']c', bang = true }
    else
      gs.nav_hunk 'next'
    end
  end, 'Next hunk')

  gmap('n', '[c', function()
    if vim.wo.diff then
      vim.cmd.normal { '[c', bang = true }
    else
      gs.nav_hunk 'prev'
    end
  end, 'Prev hunk')

  gmap('n', '<leader>gs', gs.stage_hunk, 'Stage hunk')
  gmap('n', '<leader>gr', gs.reset_hunk, 'Reset hunk')
  gmap('v', '<leader>gs', function()
    gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
  end, 'Stage hunk')
  gmap('v', '<leader>gr', function()
    gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
  end, 'Reset hunk')
  gmap('n', '<leader>gS', gs.stage_buffer, 'Stage buffer')
  gmap('n', '<leader>gR', gs.reset_buffer, 'Reset buffer')
  gmap('n', '<leader>gp', gs.preview_hunk, 'Preview hunk')
  gmap('n', '<leader>gb', function()
    gs.blame_line { full = true }
  end, 'Blame line')
  gmap('n', '<leader>gd', gs.diffthis, 'Diff this')
  gmap({ 'o', 'x' }, 'ih', gs.select_hunk, 'Select hunk')
end

-- which-key groups (deferred until after which-key loads)
vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    require('which-key').add {
      { '<leader>a', group = 'ai/claude' },
      { '<leader>f', group = 'find/files' },
      { '<leader>g', group = 'git' },
      { '<leader>l', group = 'lsp' },
      { '<leader>lr', desc = 'Rename' },
      { '<leader>la', desc = 'Code action' },
      { '<leader>lf', desc = 'Format' },
      { '<leader>w', group = 'window' },
      { '<leader>t', group = 'terminal' },
      { '<leader>z', desc = 'Zen mode' },
      { 's', group = 'surround' },
      { 'sa', desc = 'Add surrounding' },
      { 'sd', desc = 'Delete surrounding' },
      { 'sr', desc = 'Replace surrounding' },
      { 'sf', desc = 'Find surrounding (right)' },
      { 'sF', desc = 'Find surrounding (left)' },
      { 'g', group = 'goto' },
      { '[', group = 'prev' },
      { ']', group = 'next' },
    }
  end,
})

return M
