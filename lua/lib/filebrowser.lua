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
      self:set_preview_buf(tmpbuf)
      vim.wo[self.win.preview_winid].number = false
      vim.wo[self.win.preview_winid].relativenumber = false
    else
      local buf = vim.fn.bufadd(full)
      vim.fn.bufload(buf)
      pcall(vim.treesitter.start, buf)
      self:set_preview_buf(buf)
      vim.wo[self.win.preview_winid].number = true
    end

    self.win:update_preview_scrollbar()
    vim.api.nvim_win_set_config(self.win.preview_winid, { focusable = false })
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

  local max_h = math.floor(vim.o.lines * 0.85)
  local min_preview = 10
  local list_h = math.min(#entries + 3, max_h - min_preview)
  local preview_h = max_h - list_h

  fzf.fzf_exec(entries, {
    prompt = vim.fn.fnamemodify(dir:sub(1, -2), ':~') .. '/',
    fzf_opts = { ['--no-sort'] = '' },
    previewer = make_previewer(dir),
    winopts = {
      height = max_h,
      preview = {
        layout = 'vertical',
        vertical = 'down:' .. preview_h,
      },
    },
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
