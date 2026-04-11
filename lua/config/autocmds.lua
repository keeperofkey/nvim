-- Highlight yanked text briefly
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Per-filetype indent width
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'python', 'cpp', 'c' },
  callback = function()
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
  end,
})

-- Refresh statusline on macro record start/stop
vim.api.nvim_create_autocmd({ 'RecordingEnter', 'RecordingLeave' }, {
  callback = function()
    vim.cmd 'redrawstatus'
  end,
})
