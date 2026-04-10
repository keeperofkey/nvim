-- Highlight yanked text briefly
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Refresh statusline on macro record start/stop
vim.api.nvim_create_autocmd({ 'RecordingEnter', 'RecordingLeave' }, {
  callback = function()
    vim.cmd 'redrawstatus'
  end,
})
