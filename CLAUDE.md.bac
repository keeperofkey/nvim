# Neovim Config — Build Notes

Neovim 0.12 fresh config. Run with `NVIM_APPNAME=nvim-new nvim` (or `env NVIM_APPNAME=nvim-new nvim` in fish).

---

## Structure

```
init.lua                        # leader keys + require config.* + require config.lazy
lsp/                            # per-server LSP configs (Neovim 0.11+ native API)
  lua_ls.lua
lua/
  config/
    lazy.lua                    # lazy.nvim bootstrap + setup
    options.lua                 # vim.opt + vim.diagnostic.config
    keymaps.lua                 # ALL keymaps (global, LspAttach, gitsigns, which-key groups)
    autocmds.lua                # autocommands
    filebrowser.lua             # custom fzf-lua file browser (see below)
  plugins/
    editor.lua                  # treesitter, fzf-lua, mini.nvim
    formatting.lua              # conform.nvim
    git.lua                     # gitsigns
    lsp.lua                     # mason, mason-lspconfig, blink.cmp
    ui.lua                      # which-key, snacks.nvim
```

---

## Key Patterns

### Keymaps
All keymaps live in `lua/config/keymaps.lua` — including buffer-local ones via autocmds.
- Global keymaps: plain `vim.keymap.set`
- LSP keymaps: inside `LspAttach` autocmd (buffer-local)
- Gitsigns keymaps: `M.gitsigns_on_attach(bufnr)` exported and called from `lua/plugins/git.lua`
- which-key group labels: deferred via `User VeryLazy` autocmd so which-key is loaded first

`keymaps.lua` returns `M` (for gitsigns), so it's both a side-effect module and a return value.

### LSP (Neovim 0.12 native API)
- Server configs live in `lsp/<server>.lua` — auto-loaded by Neovim
- `mason-lspconfig` with `automatic_enable = true` installs servers and calls `vim.lsp.enable()` automatically
- Adding a new server: add to `ensure_installed` in `lua/plugins/lsp.lua` + create `lsp/<server>.lua`
- Non-LSP tools (formatters etc.) installed via mason registry API directly in mason's `config` function

### Formatting
`conform.nvim` handles JS/TS/CSS/HTML/JSON/YAML/Markdown via `prettierd`.
- `lsp_format = "fallback"` means LSP formatting is used when no conform formatter is configured
- `<leader>lf` calls `conform.format()` (not `vim.lsp.buf.format` directly)
- `prettierd` is auto-installed via mason registry in `lua/plugins/lsp.lua`

### Icons
`mini.icons` replaces `nvim-web-devicons` via `MiniIcons.mock_nvim_web_devicons()`.
Any plugin declaring `nvim-web-devicons` as a dependency gets mini.icons transparently.

### Snacks
`snacks.nvim` must be `lazy = false, priority = 1000`. Enabled modules:
`bigfile, dashboard, indent, input, notifier, quickfile, scroll, statuscolumn, words`
- `snacks.notifier` automatically overrides `vim.notify`
- `snacks.indent` replaces indent-blankline

### Custom File Browser (`lua/config/filebrowser.lua`)
Built on `fzf-lua.fzf_exec` with a custom previewer extending `fzf-lua.previewer.builtin.base`.

**Why `base` not `buffer_or_file`:** `buffer_or_file` has an internal buffer cache that
asserts `cached.bufnr == self.preview_bufnr` (builtin.lua:1009). Setting custom buffers
for directories breaks this invariant. Extending `base` avoids the cache entirely.

Preview behaviour:
- Directories: `nvim_open_term` + `nvim_chan_send` with `eza --oneline --color=always`
- Files: `vim.fn.bufadd` + `vim.fn.bufload` + `vim.treesitter.start` for treesitter highlighting

Navigation:
- `<cr>` on dir or `../` → navigate into/up
- `ctrl-h` → go up a level
- `<cr>` on file → open with `:edit`

---

## Keymaps Reference

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files (fzf-lua) |
| `<leader>fb` | File browser (custom fzf-lua browser) |
| `<leader>fm` | File manager (mini.files — for rename/delete/create) |
| `<leader>fg` | Live grep |
| `<leader>f/` | Buffers |
| `<leader>fh` | Help tags |
| `<leader>fr` | Recent files |
| `<leader>fd` | Document diagnostics |
| `<leader>fs` | Document symbols |
| `<leader>lr` | LSP rename |
| `<leader>la` | LSP code action |
| `<leader>lf` | Format (conform → LSP fallback) |
| `<leader>gs/gr` | Stage/reset hunk |
| `<leader>gS/gR` | Stage/reset buffer |
| `<leader>gp` | Preview hunk |
| `<leader>gb` | Blame line |
| `<leader>gd` | Diff this |
| `]c` / `[c` | Next/prev git hunk |
| `]d` / `[d` | Next/prev diagnostic |
| `gd/gD/gi/gr` | LSP go-to |
| `K` | LSP hover |
| `sa/sd/sr/sf/sF` | mini.surround add/delete/replace/find |

---

## Adding Things

**New LSP server:** add name to `ensure_installed` in `lua/plugins/lsp.lua`, create `lsp/<name>.lua`

**New formatter:** add tool name to `tools` table in mason config (`lua/plugins/lsp.lua`), add filetype mapping in `lua/plugins/formatting.lua`

**New keymap group:** add entry to `require("which-key").add({})` in the `VeryLazy` autocmd in `lua/config/keymaps.lua`

**New plugin file:** create `lua/plugins/<name>.lua` returning a table — lazy.nvim auto-imports all files in `lua/plugins/`
