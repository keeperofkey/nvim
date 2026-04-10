local M = {}

local function make_previewer(dir)
  local builtin = require 'fzf-lua.previewer.builtin'
  local Previewer = builtin.base:extend()

  function Previewer:new(o, opts, fzf_win)
    Previewer.super.new(self, o, opts, fzf_win)
    setmetatable(self, Previewer)
    return self
  end

  function Previewer:populate_preview_buf(entry_str)
    local full = entry_str == '../' and vim.fn.fnamemodify(dir:sub(1, -2), ':h') or dir .. entry_str:gsub('/$', '')
    local stat = vim.uv.fs_stat(full)
    local tmpbuf = self:get_tmp_buffer()

    if stat and stat.type == 'directory' then
      local chan = vim.api.nvim_open_term(tmpbuf, {})
      local output = vim.fn.system('eza --oneline --color=always --group-directories-first --all ' .. vim.fn.shellescape(full))
      vim.api.nvim_chan_send(chan, output)
    else
      local buf = vim.fn.bufadd(full)
      vim.fn.bufload(buf)
      pcall(vim.treesitter.start, buf)
      self:set_preview_buf(buf)
      self.win:update_preview_scrollbar()
      return
    end

    self:set_preview_buf(tmpbuf)
    self.win:update_preview_scrollbar()
  end

  return Previewer
end

function M.browse(dir)
  dir = vim.fn.fnamemodify(dir or vim.fn.getcwd(), ':p')
  if dir:sub(-1) ~= '/' then
    dir = dir .. '/'
  end

  local fzf = require 'fzf-lua'
  local dirs, files = {}, {}

  local handle = vim.uv.fs_scandir(dir)
  if handle then
    while true do
      local name, ftype = vim.uv.fs_scandir_next(handle)
      if not name then
        break
      end
      if ftype == 'directory' then
        table.insert(dirs, name .. '/')
      else
        table.insert(files, name)
      end
    end
  end

  table.sort(dirs)
  table.sort(files)

  local entries = { '../' }
  vim.list_extend(entries, dirs)
  vim.list_extend(entries, files)

  fzf.fzf_exec(entries, {
    prompt = vim.fn.fnamemodify(dir:sub(1, -2), ':~') .. '/  ',
    fzf_opts = { ['--no-sort'] = '' },
    previewer = make_previewer(dir),
    actions = {
      ['default'] = function(selected)
        if not selected or not selected[1] then
          return
        end
        local item = selected[1]
        if item == '../' then
          M.browse(vim.fn.fnamemodify(dir:sub(1, -2), ':h'))
          return
        end
        local full = dir .. item:gsub('/$', '')
        local stat = vim.uv.fs_stat(full)
        if stat and stat.type == 'directory' then
          M.browse(full)
        else
          vim.cmd('edit ' .. vim.fn.fnameescape(full))
        end
      end,
      ['ctrl-h'] = function()
        M.browse(vim.fn.fnamemodify(dir:sub(1, -2), ':h'))
      end,
    },
  })
end

return M
