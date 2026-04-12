# nvim config

Neovim 0.12 config using native APIs where possible.

## Structure

```
init.lua                        # leader keys + bootstrap
lsp/                            # per-server LSP configs (0.11+ native API)
lua/
  config/
    lazy.lua                    # lazy.nvim bootstrap
    options.lua                 # vim.opt settings + diagnostic config
    keymaps.lua                 # all keymaps (global, LspAttach, gitsigns, which-key groups)
    autocmds.lua                # autocommands (yank highlight, macro statusline refresh)
  lib/
    filebrowser.lua             # custom fzf-lua file browser
  plugins/
    colorscheme.lua             # custom xresources-based theme
    editor.lua                  # treesitter, fzf-lua, render-markdown, supermaven, todo-comments, colorizer
    ui.lua                      # which-key, snacks, noice, mini.nvim
    lsp.lua                     # mason, mason-lspconfig
    completion.lua              # blink.cmp
    formatting.lua              # conform (prettierd, stylua)
    git.lua                     # gitsigns
```

## Plugins

| Plugin                  | Purpose                                                |
| ----------------------- | ------------------------------------------------------ |
| lazy.nvim               | Package manager                                        |
| nvim-treesitter         | Syntax, folds, indent                                  |
| fzf-lua                 | Fuzzy finder                                           |
| mini.nvim               | Statusline, tabline, surround, pairs, files, icons, ai |
| snacks.nvim             | Dashboard, scroll, statuscolumn, words, lazygit        |
| noice.nvim              | Cmdline float, LSP progress, notifications             |
| which-key.nvim          | Keymap hints                                           |
| mason + mason-lspconfig | LSP server management                                  |
| blink.cmp               | Completion                                             |
| conform.nvim            | Formatting (prettierd, stylua)                         |
| gitsigns.nvim           | Git hunk signs + actions                               |
| supermaven-nvim         | AI completion                                          |
| render-markdown.nvim    | Markdown rendering                                     |
| todo-comments.nvim      | TODO/FIXME highlights                                  |
| nvim-colorizer.lua      | Inline color preview                                   |

## LSP Servers

| Server  | Language                |
| ------- | ----------------------- |
| lua_ls  | Lua                     |
| ts_ls   | TypeScript / JavaScript |
| cssls   | CSS / SCSS              |
| pyright | Python                  |

## Keymaps

| Key             | Action                        |
| --------------- | ----------------------------- |
| `<leader>ff`    | Find files                    |
| `<leader>fb`    | File browser (custom fzf-lua) |
| `<leader>fm`    | File manager (mini.files)     |
| `<leader>fg`    | Live grep                     |
| `<leader>f/`    | Buffers                       |
| `<leader>fh`    | Help tags                     |
| `<leader>fr`    | Recent files                  |
| `<leader>fd`    | Document diagnostics          |
| `<leader>fs`    | Document symbols              |
| `<leader>ft`    | Find TODOs                    |
| `<leader>n`     | Notification history          |
| `<leader>gg`    | Lazygit                       |
| `<leader>lr`    | LSP rename                    |
| `<leader>la`    | LSP code action               |
| `<leader>lf`    | Format                        |
| `<leader>gs/gr` | Stage/reset hunk              |
| `<leader>gS/gR` | Stage/reset buffer            |
| `<leader>gp`    | Preview hunk                  |
| `<leader>gb`    | Blame line                    |
| `<leader>gd`    | Diff this                     |
| `<leader>v/h`   | Vertical/horizontal split     |
| `<leader>w*`    | Window resize/move            |
| `<leader>e`     | Diagnostic float              |
| `<leader>q`     | Diagnostic quickfix           |
| `]d/[d`         | Next/prev diagnostic          |
| `]e/[e`         | Next/prev error               |
| `]c/[c`         | Next/prev git hunk            |
| `gd/gD/gi/gr`   | LSP go-to                     |
| `K`             | LSP hover                     |
| `<C-h/j/k/l>`   | Window navigation             |
| `sa/sd/sr`      | Surround add/delete/replace   |

## Theme

Custom theme reading from Xresources (`color0`–`color15`, `foreground`).
Falls back to gruvbox-inspired dark palette if Xresources is unavailable.
All highlight groups defined in `lua/plugins/colorscheme.lua`.
