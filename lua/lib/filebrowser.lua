local M = {}

local previewers = require('snacks.picker.preview')

local function make_items(dir)
  local items = {}

  -- parent entry
  local parent = vim.fn.fnamemodify(dir:sub(1, -2), ':h')
  table.insert(items, {
    text = '../',
    _path = parent,
    _is_dir = true,
    file = parent,
  })

  local dirs, files = {}, {}
  local handle = vim.uv.fs_scandir(dir)
  if handle then
    while true do
      local name, ftype = vim.uv.fs_scandir_next(handle)
      if not name then break end
      local full = dir .. name
      if ftype == 'directory' then
        table.insert(dirs, { name = name, full = full })
      else
        table.insert(files, { name = name, full = full })
      end
    end
  end
  table.sort(dirs, function(a, b) return a.name < b.name end)
  table.sort(files, function(a, b) return a.name < b.name end)

  for _, d in ipairs(dirs) do
    table.insert(items, {
      text = d.name .. '/',
      _path = d.full,
      _is_dir = true,
      file = d.full,
    })
  end

  for _, f in ipairs(files) do
    table.insert(items, {
      text = f.name,
      _path = f.full,
      _is_dir = false,
      file = f.full,
    })
  end

  return items
end

function M.browse(dir)
  dir = vim.fn.fnamemodify(dir or vim.fn.getcwd(), ':p')
  if dir:sub(-1) ~= '/' then dir = dir .. '/' end

  local items = make_items(dir)

  Snacks.picker.pick({
    title = vim.fn.fnamemodify(dir:sub(1, -2), ':~') .. '/',
    finder = function() return items end,
    format = function(item)
      if item._is_dir then
        return { { item.text, 'Directory' } }
      end
      return { { item.text } }
    end,
    preview = function(ctx)
      if ctx.item._is_dir then
        previewers.directory(ctx)
      else
        previewers.file(ctx)
      end
    end,
    matcher = { sort_empty = true, fuzzy = true },
    confirm = function(picker, item)
      picker:close()
      if item._is_dir then
        M.browse(item._path)
      else
        vim.cmd('edit ' .. vim.fn.fnameescape(item._path))
      end
    end,
    actions = {
      go_up = function(picker)
        picker:close()
        M.browse(vim.fn.fnamemodify(dir:sub(1, -2), ':h'))
      end,
    },
    win = {
      input = {
        keys = {
          ['<C-h>'] = { 'go_up', mode = { 'n', 'i' }, desc = 'Go up' },
        },
      },
    },
  })
end

return M
