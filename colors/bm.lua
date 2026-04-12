-- bm.lua
-- Unified colorscheme based on the BM/USGC palette.
-- bg = 'none' throughout for compositor transparency.

vim.cmd 'hi clear'
if vim.fn.exists 'syntax_on' == 1 then
  vim.cmd 'syntax reset'
end
vim.g.colors_name = 'bm'
vim.opt.termguicolors = true

local hi = function(name, opts)
  vim.api.nvim_set_hl(0, name, opts)
end

local c = {
  -- Full palette
  black = '#000000',
  red = '#ed1c24',
  green = '#00a651',
  blue = '#2e3192',
  cyan = '#00aeef', -- types, namespaces, modules
  yellow = '#fff200',
  magenta = '#ec008c',
  white = '#ffffff',
  sage = '#658d3c', -- strings
  teal = '#007a61',
  navy = '#184898',
  violet = '#613393',
  rose = '#a42067', -- keywords
  crimson = '#c22032',
  sienna = '#bc4c27', -- numbers, booleans, constants
  amber = '#f7b718', -- functions (defs + calls)
  gray1 = '#e6e7e8',
  gray2 = '#d1d3d4',
  gray3 = '#bcbec0',
  gray4 = '#a7a9ac',
  gray5 = '#939598',
  gray6 = '#808285',
  gray7 = '#6d6e71',
  gray8 = '#58595b',
  gray9 = '#414042',
  gray10 = '#231f20',
  -- Solid backgrounds (used only where a fill is semantically necessary:
  -- cursorline, visual selection, search, diff, popup menus)
  bg = '#231f20', -- gray-10  (used as fg on inverted elements)
  bg_alt = '#414042', -- gray-9
  bg_sel = '#a7a9ac', -- gray-8   (selection, visual)
  bg_cursor = '#58595b', -- interpolated, subtle cursorline
  -- Foregrounds
  fg = '#d1d3d4', -- gray-2   (normal text, identifiers)
  fg_dim = '#939598', -- gray-5   (operators, hints)
  fg_mute = '#808285', -- gray-6   (comments, punctuation)
  fg_faint = '#6d6e71', -- gray-7   (line numbers)
}

-- Semantic aliases (post-init so we can reference base colors)
c.keyword = c.rose
c.error = c.red
c.warn = c.amber
c.info = c.cyan
c.hint = c.fg_dim
c.diff_add = '#1e2e1e' -- dark sage tint
c.diff_del = '#2e1a1a' -- dark red tint
c.diff_chg = '#2a2510' -- dark amber tint

-- ─── Editor Chrome ───────────────────────────────────────────────────────────

hi('Normal', { fg = c.fg, bg = 'none' })
hi('NormalNC', { link = 'Normal' })
hi('NormalFloat', { fg = c.fg, bg = 'none' })

hi('Cursor', { fg = c.bg, bg = c.amber })
hi('CursorIM', { fg = c.bg, bg = c.amber })
hi('CursorLine', { bg = c.bg_cursor })
hi('CursorColumn', { bg = c.bg_cursor })
hi('ColorColumn', { bg = c.bg_cursor })

hi('LineNr', { fg = c.fg_dim })
hi('CursorLineNr', { fg = c.fg_dim, bg = c.bg_cursor })
hi('SignColumn', { bg = 'none' })
hi('FoldColumn', { fg = c.fg_faint })
hi('Folded', { fg = c.fg_mute, bg = c.bg_alt })

hi('StatusLine', { fg = c.fg_dim, bg = 'none' })
hi('StatusLineNC', { fg = c.fg_mute, bg = 'none' })
hi('TabLine', { bg = 'none' })
hi('TabLineFill', { bg = 'none' })
hi('TabLineSel', { fg = c.fg, bg = 'none', bold = true })
hi('WinSeparator', { fg = c.bg_alt })

hi('Visual', { bg = c.bg_sel })
hi('VisualNOS', { bg = c.bg_sel })

hi('Search', { fg = c.bg, bg = c.amber })
hi('IncSearch', { fg = c.bg, bg = c.amber, bold = true })
hi('CurSearch', { fg = c.bg, bg = c.amber, bold = true })
hi('Substitute', { fg = c.bg, bg = c.error })

hi('MatchParen', { fg = c.amber, bold = true, underline = true })

hi('Pmenu', { fg = c.fg, bg = 'none' })
hi('PmenuSel', { fg = c.fg, bg = c.bg_sel, bold = true })
hi('PmenuSbar', { bg = c.bg_alt })
hi('PmenuThumb', { bg = c.bg_sel })
hi('PmenuKind', { fg = c.fg_dim })
hi('PmenuKindSel', { fg = c.amber })

hi('FloatBorder', { fg = c.bg_sel })
hi('FloatTitle', { fg = c.fg_dim, bold = true })

hi('EndOfBuffer', { fg = c.fg_faint })
hi('NonText', { fg = c.fg_faint })
hi('SpecialKey', { fg = c.fg_faint })
hi('Whitespace', { fg = c.bg_alt })

hi('Directory', { fg = c.cyan })
hi('Title', { fg = c.amber, bold = true })

hi('Question', { fg = c.cyan })
hi('MoreMsg', { fg = c.cyan })
hi('ModeMsg', { fg = c.fg })
hi('MsgArea', { fg = c.fg })
hi('MsgSeparator', { fg = c.fg_mute })
hi('ErrorMsg', { fg = c.error })
hi('WarningMsg', { fg = c.warn })

hi('SpellBad', { sp = c.error, undercurl = true })
hi('SpellCap', { sp = c.info, undercurl = true })
hi('SpellRare', { sp = c.hint, undercurl = true })
hi('SpellLocal', { sp = c.hint, undercurl = true })

hi('DiffAdd', { fg = c.green })
hi('DiffDelete', { fg = c.red })
hi('DiffChange', { fg = c.blue })
hi('DiffText', { bg = c.diff_chg, underline = true })

hi('QuickFixLine', { bg = c.bg_sel })

-- ─── Syntax (legacy groups) ───────────────────────────────────────────────────

hi('Comment', { fg = c.fg_mute, italic = true })

hi('String', { fg = c.sage })
hi('Character', { fg = c.sage })
hi('SpecialChar', { fg = c.sienna }) -- escape sequences

hi('Number', { fg = c.sienna })
hi('Float', { fg = c.sienna })
hi('Boolean', { fg = c.sienna })
hi('Constant', { fg = c.sienna })

hi('Identifier', { fg = c.fg })
hi('Function', { fg = c.amber })

hi('Statement', { fg = c.keyword })
hi('Conditional', { fg = c.keyword })
hi('Repeat', { fg = c.keyword })
hi('Label', { fg = c.keyword })
hi('Keyword', { fg = c.keyword })
hi('Exception', { fg = c.keyword })
hi('Operator', { fg = c.fg_dim })

hi('Type', { fg = c.cyan })
hi('StorageClass', { fg = c.keyword })
hi('Structure', { fg = c.cyan })
hi('Typedef', { fg = c.cyan })

hi('PreProc', { fg = c.keyword })
hi('Include', { fg = c.keyword })
hi('Define', { fg = c.keyword })
hi('Macro', { fg = c.keyword })
hi('PreCondit', { fg = c.keyword })

hi('Special', { fg = c.fg_dim })
hi('Tag', { fg = c.amber })
hi('Delimiter', { fg = c.fg_mute })
hi('SpecialComment', { fg = c.fg_mute, italic = true })
hi('Debug', { fg = c.error })

hi('Underlined', { underline = true })
hi('Ignore', { fg = c.bg_alt })
hi('Error', { fg = c.error })
hi('Todo', { fg = c.amber, bold = true })

-- ─── Tree-sitter (@-groups) ───────────────────────────────────────────────────

hi('@comment', { link = 'Comment' })
hi('@comment.documentation', { fg = c.fg_mute, italic = true })

hi('@string', { link = 'String' })
hi('@string.escape', { fg = c.sienna })
hi('@string.special', { fg = c.sienna })
hi('@string.special.url', { fg = c.cyan, underline = true })
hi('@character', { link = 'Character' })
hi('@number', { link = 'Number' })
hi('@number.float', { link = 'Float' })
hi('@boolean', { link = 'Boolean' })

hi('@keyword', { link = 'Keyword' })
hi('@keyword.function', { fg = c.amber }) -- fn/end blocks: ties to function amber
hi('@keyword.return', { link = 'Keyword' })
hi('@keyword.operator', { link = 'Operator' })
hi('@keyword.import', { link = 'Keyword' })
hi('@keyword.modifier', { link = 'Keyword' })
hi('@keyword.repeat', { link = 'Keyword' })
hi('@keyword.conditional', { link = 'Keyword' })
hi('@keyword.exception', { link = 'Keyword' })
hi('@keyword.directive', { link = 'Keyword' })
hi('@keyword.coroutine', { link = 'Keyword' })

hi('@variable', { fg = c.fg })
hi('@variable.builtin', { fg = c.keyword, italic = true })
hi('@variable.parameter', { fg = c.fg_dim })
hi('@variable.member', { fg = c.fg })
hi('@constant', { link = 'Constant' })
hi('@constant.builtin', { fg = c.sienna, italic = true })
hi('@constant.macro', { fg = c.sienna })

hi('@function', { link = 'Function' })
hi('@function.builtin', { fg = c.amber, italic = true })
hi('@function.call', { fg = c.amber })
hi('@function.macro', { fg = c.amber })
hi('@function.method', { fg = c.amber })
hi('@function.method.call', { fg = c.amber })
hi('@constructor', { fg = c.cyan })

hi('@type', { link = 'Type' })
hi('@type.builtin', { fg = c.cyan, italic = true })
hi('@type.definition', { fg = c.cyan })
hi('@type.qualifier', { link = 'Keyword' })

hi('@module', { fg = c.fg_dim })
hi('@module.builtin', { fg = c.fg_dim, italic = true })
hi('@namespace', { fg = c.fg_dim })

hi('@attribute', { fg = c.fg_dim })
hi('@attribute.builtin', { fg = c.fg_dim, italic = true })

hi('@operator', { fg = c.fg_dim })
hi('@punctuation.bracket', { fg = c.fg_mute })
hi('@punctuation.delimiter', { fg = c.fg_mute })
hi('@punctuation.special', { fg = c.fg_dim })

hi('@markup.heading', { fg = c.amber, bold = true })
hi('@markup.heading.1', { fg = c.amber, bold = true })
hi('@markup.heading.2', { fg = c.amber })
hi('@markup.heading.3', { fg = c.fg, bold = true })
hi('@markup.heading.4', { fg = c.fg })
hi('@markup.bold', { bold = true })
hi('@markup.italic', { italic = true })
hi('@markup.strikethrough', { strikethrough = true })
hi('@markup.underline', { underline = true })
hi('@markup.link', { fg = c.cyan, underline = true })
hi('@markup.link.url', { fg = c.cyan, underline = true })
hi('@markup.link.label', { fg = c.amber })
hi('@markup.raw', { fg = c.sage })
hi('@markup.raw.block', { fg = c.sage })
hi('@markup.list', { fg = c.fg_dim })
hi('@markup.list.checked', { fg = c.sage })
hi('@markup.list.unchecked', { fg = c.fg_mute })

hi('@tag', { fg = c.keyword })
hi('@tag.attribute', { fg = c.cyan })
hi('@tag.delimiter', { fg = c.fg_mute })

hi('@diff.plus', { fg = c.sage })
hi('@diff.minus', { fg = c.error })
hi('@diff.delta', { fg = c.amber })

-- ─── LSP Semantic Tokens ─────────────────────────────────────────────────────

hi('@lsp.type.variable', {}) -- let treesitter @variable show through
hi('@lsp.type.class', { link = '@type' })
hi('@lsp.type.enum', { link = '@type' })
hi('@lsp.type.enumMember', { link = '@constant' })
hi('@lsp.type.interface', { link = '@type' })
hi('@lsp.type.struct', { link = '@type' })
hi('@lsp.type.typeParameter', { link = '@type' })
hi('@lsp.type.parameter', { link = '@variable.parameter' })
hi('@lsp.type.property', { link = '@variable.member' })
hi('@lsp.type.function', { link = '@function' })
hi('@lsp.type.method', { link = '@function.method' })
hi('@lsp.type.macro', { link = '@function.macro' })
hi('@lsp.type.decorator', { link = '@attribute' })
hi('@lsp.type.namespace', { link = '@module' })
hi('@lsp.type.keyword', { link = '@keyword' })
hi('@lsp.type.comment', { link = '@comment' })
hi('@lsp.type.string', { link = '@string' })
hi('@lsp.type.number', { link = '@number' })
hi('@lsp.type.operator', { link = '@operator' })
hi('@lsp.mod.deprecated', { strikethrough = true })
hi('@lsp.mod.readonly', { italic = true })
hi('@lsp.mod.static', { italic = true })

-- ─── Diagnostics ─────────────────────────────────────────────────────────────

hi('DiagnosticError', { fg = c.error })
hi('DiagnosticWarn', { fg = c.warn })
hi('DiagnosticInfo', { fg = c.info })
hi('DiagnosticHint', { fg = c.hint })
hi('DiagnosticOk', { fg = c.sage })
hi('DiagnosticUnderlineError', { sp = c.error, undercurl = true })
hi('DiagnosticUnderlineWarn', { sp = c.warn, undercurl = true })
hi('DiagnosticUnderlineInfo', { sp = c.info, undercurl = true })
hi('DiagnosticUnderlineHint', { sp = c.hint, undercurl = true })
hi('DiagnosticVirtualTextError', { fg = c.error, italic = true })
hi('DiagnosticVirtualTextWarn', { fg = c.warn, italic = true })
hi('DiagnosticVirtualTextInfo', { fg = c.info, italic = true })
hi('DiagnosticVirtualTextHint', { fg = c.hint, italic = true })
hi('DiagnosticSignError', { fg = c.error })
hi('DiagnosticSignWarn', { fg = c.warn })
hi('DiagnosticSignInfo', { fg = c.info })
hi('DiagnosticSignHint', { fg = c.hint })
hi('DiagnosticUnnecessary', { underline = true })

-- ─── mini.statusline ─────────────────────────────────────────────────────────

hi('MiniStatuslineModeNormal', { fg = c.sage, bg = 'none', bold = true })
hi('MiniStatuslineModeInsert', { fg = c.cyan, bg = 'none', bold = true })
hi('MiniStatuslineModeVisual', { fg = c.amber, bg = 'none', bold = true })
hi('MiniStatuslineModeReplace', { fg = c.error, bg = 'none', bold = true })
hi('MiniStatuslineModeCommand', { fg = c.sienna, bg = 'none', bold = true })
hi('MiniStatuslineModeOther', { fg = c.fg_mute, bg = 'none', bold = true })
hi('MiniStatuslineDevinfo', { fg = c.fg_dim, bg = 'none' })
hi('MiniStatuslineFilename', { fg = c.amber, bg = 'none' })
hi('MiniStatuslineFileinfo', { fg = c.fg_dim, bg = 'none' })
hi('MiniStatuslineInactive', { fg = c.fg_mute, bg = 'none' })

-- ─── mini.tabline ────────────────────────────────────────────────────────────

hi('MiniTablineCurrent', { fg = c.fg, bg = 'none', bold = true })
hi('MiniTablineVisible', { fg = c.fg_dim, bg = 'none' })
hi('MiniTablineHidden', { fg = c.fg_mute, bg = 'none' })
hi('MiniTablineFill', { bg = 'none' })
hi('MiniTablineModifiedCurrent', { fg = c.amber, bg = 'none', bold = true })
hi('MiniTablineModifiedVisible', { fg = c.amber, bg = 'none' })
hi('MiniTablineModifiedHidden', { fg = c.sienna, bg = 'none' })

-- ─── Blink.cmp ───────────────────────────────────────────────────────────────

hi('BlinkCmpMenu', { link = 'NormalFloat' })
hi('BlinkCmpDoc', { link = 'NormalFloat' })
hi('BlinkCmpMenuBorder', { link = 'FloatBorder' })
hi('BlinkCmpDocBorder', { link = 'FloatBorder' })
hi('BlinkCmpDocSeparator', { link = 'FloatBorder' })
hi('BlinkCmpMenuSelection', { fg = c.fg, bg = c.bg_sel, bold = true })
hi('BlinkCmpLabel', { fg = c.fg })
hi('BlinkCmpLabelMatch', { fg = c.amber, bold = true })
hi('BlinkCmpLabelDeprecated', { fg = c.fg_mute, strikethrough = true })
hi('BlinkCmpKindFunction', { fg = c.amber })
hi('BlinkCmpKindMethod', { fg = c.amber })
hi('BlinkCmpKindConstructor', { fg = c.cyan })
hi('BlinkCmpKindClass', { fg = c.cyan })
hi('BlinkCmpKindInterface', { fg = c.cyan })
hi('BlinkCmpKindStruct', { fg = c.cyan })
hi('BlinkCmpKindModule', { fg = c.fg_dim })
hi('BlinkCmpKindVariable', { fg = c.fg })
hi('BlinkCmpKindField', { fg = c.fg })
hi('BlinkCmpKindProperty', { fg = c.fg })
hi('BlinkCmpKindConstant', { fg = c.sienna })
hi('BlinkCmpKindEnum', { fg = c.sienna })
hi('BlinkCmpKindEnumMember', { fg = c.sienna })
hi('BlinkCmpKindKeyword', { fg = c.keyword })
hi('BlinkCmpKindOperator', { fg = c.fg_dim })
hi('BlinkCmpKindSnippet', { fg = c.fg_mute })
hi('BlinkCmpKindText', { fg = c.fg_mute })
hi('BlinkCmpKindValue', { fg = c.sienna })

-- ─── Gitsigns ────────────────────────────────────────────────────────────────

hi('GitSignsAdd', { fg = c.sage })
hi('GitSignsChange', { fg = c.amber })
hi('GitSignsDelete', { fg = c.error })

-- ─── render-markdown.nvim ────────────────────────────────────────────────────

hi('RenderMarkdownCode', { bg = 'none', bold = true, italic = true })
hi('RenderMarkdownH1', { fg = c.amber, bold = true })
hi('RenderMarkdownH2', { fg = c.amber })
hi('RenderMarkdownH3', { fg = c.fg, bold = true })
hi('RenderMarkdownH4', { fg = c.fg })
hi('RenderMarkdownH5', { fg = c.fg_dim })
hi('RenderMarkdownH6', { fg = c.fg_mute })
hi('RenderMarkdownH1Bg', { bg = 'none' })
hi('RenderMarkdownH2Bg', { bg = 'none' })
hi('RenderMarkdownH3Bg', { bg = 'none' })
hi('RenderMarkdownH4Bg', { bg = 'none' })
hi('RenderMarkdownH5Bg', { bg = 'none' })
hi('RenderMarkdownH6Bg', { bg = 'none' })
hi('RenderMarkdownTableHead', { fg = c.amber, bold = true })
hi('RenderMarkdownTableRow', { fg = c.fg_mute })

-- ─── Noice ───────────────────────────────────────────────────────────────────

hi('NoiceCmdlineBorder', { link = 'FloatBorder' })
hi('NoiceCmdlinePopupBorder', { link = 'FloatBorder' })

-- ─── Flash ───────────────────────────────────────────────────────────────────

hi('FlashMatch', { fg = c.bg, bg = c.sage })
hi('FlashLabel', { fg = c.bg, bg = c.amber, bold = true, italic = true })

-- ─── Telescope ───────────────────────────────────────────────────────────────

hi('TelescopeNormal', { link = 'NormalFloat' })
hi('TelescopePromptNormal', { link = 'NormalFloat' })
hi('TelescopePreviewNormal', { link = 'NormalFloat' })
hi('TelescopeResultsNormal', { link = 'NormalFloat' })
hi('TelescopeBorder', { link = 'FloatBorder' })
hi('TelescopePromptBorder', { link = 'FloatBorder' })
hi('TelescopePreviewBorder', { link = 'FloatBorder' })
hi('TelescopeResultsBorder', { link = 'FloatBorder' })
hi('TelescopeMatching', { fg = c.amber, bold = true })
hi('TelescopeSelection', { bg = c.bg_sel })
hi('TelescopePromptPrefix', { fg = c.amber })
hi('TelescopePromptTitle', { fg = c.amber, bold = true })
hi('TelescopePreviewTitle', { fg = c.sage, bold = true })
hi('TelescopeResultsTitle', { fg = c.cyan, bold = true })

-- ─── Which-key ───────────────────────────────────────────────────────────────

hi('WhichKey', { fg = c.amber })
hi('WhichKeyGroup', { fg = c.cyan })
hi('WhichKeyDesc', { fg = c.fg })
hi('WhichKeySeparator', { fg = c.fg_mute })
