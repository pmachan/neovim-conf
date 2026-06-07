-- ~/.config/nvim/colors/islands-dark.lua
-- A Neovim port of JetBrains' "Islands Dark" (a GoLand/IntelliJ dark theme).
-- Activate with: vim.cmd.colorscheme("islands-dark")
--
-- The exported .icls only overrides editor-UI chrome (background, gutters,
-- guides, diff, carets); the syntax colors below are the JetBrains dark
-- palette it inherits: orange keywords, green strings, blue numbers, gold
-- functions, grey comments, purple constants/fields, olive annotations.

local M = {}

-- ── Palette ────────────────────────────────────────────────────────────────
local p = {
  -- Backgrounds / chrome (verbatim from the .icls overrides)
  bg          = "#1e1f22", -- TEXT background / CONSOLE_BACKGROUND (editor)
  sidebar     = "#18191c", -- tool-window bg: a touch darker than the editor,
                           -- so the file tree reads as a separate "island"
  bg_alt      = "#2b2d30", -- CARET_ROW / panels / floats / lookup / docs
  cursorline  = "#2b2d30", -- CARET_ROW_COLOR
  indent      = "#313438", -- INDENT_GUIDE
  indent_sel  = "#6f737a", -- SELECTED_INDENT_GUIDE
  right_margin = "#393b40", -- RIGHT_MARGIN_COLOR (colorcolumn)
  separator   = "#393b40", -- window separators
  method_sep  = "#43454a", -- METHOD_SEPARATORS_COLOR (borders)
  notify_bg   = "#25324d", -- NOTIFICATION_BACKGROUND

  -- Foregrounds
  fg          = "#a9b7c6", -- TEXT foreground (main text)
  fg_bright   = "#dfe1e5", -- BREADCRUMBS_CURRENT (brightest text)
  dir         = "#d4dae2", -- explorer folder names: clearly lighter than fg,
                           -- to set folders apart from files (still below bright)
  line_nr     = "#4e5157", -- LINE_NUMBERS_COLOR
  line_nr_cur = "#9da0a8", -- LINE_NUMBER_ON_CARET_ROW_COLOR
  dim         = "#6f737a", -- BREADCRUMBS_INACTIVE / disabled

  -- Selection / search / matched brace
  visual      = "#214283", -- SELECTION_BACKGROUND
  search      = "#32593d", -- text-search result
  search_cur  = "#4e7a4a", -- current search match
  brace_fg    = "#ced9d2", -- MATCHED_BRACE foreground
  brace_bg    = "#326146", -- MATCHED_BRACE background

  -- Syntax (the JetBrains dark palette, inherited from the parent scheme)
  orange      = "#cc7832", -- keywords, builtin types, booleans
  gold        = "#ffc66d", -- function / method names
  green       = "#6a8759", -- strings
  doc_green   = "#629755", -- doc comments
  blue        = "#6897bb", -- numbers
  purple      = "#9876aa", -- constants, fields, static members
  olive       = "#bbb529", -- annotations / metadata / tags
  hyperlink   = "#a571e6", -- FOLLOWED_HYPERLINK_ATTRIBUTES
  comment     = "#808080", -- line / block comments

  -- Diagnostics / VCS (from the .icls overrides + IntelliJ stripe colors)
  error       = "#f75464", -- error stripe / text
  error_bg    = "#402929", -- ERROR_HINT
  warn        = "#be9117", -- WARNING error-stripe
  warn_bg     = "#3d3322", -- WARNING background
  info        = "#3592c4", -- information blue
  hint        = "#868a91", -- weak / hint grey
  git_add     = "#549159", -- ADDED_LINES_COLOR
  git_change  = "#4a73c0", -- (lightened MODIFIED_LINES 375fad for visibility)
  git_delete  = "#c75c5c", -- deletions (red, conventional gutter marker)

  none        = "NONE",
}

-- Diff backgrounds (subtle washes derived from the VCS marker hues)
local diff = {
  add    = "#293b2e",
  change = "#293340",
  delete = "#3c2829",
  text   = "#35508a",
}

-- Identifier-under-caret highlights (IntelliJ read/write occurrences)
local occ = { read = "#344134", write = "#50402d" }

local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

function M.setup()
  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end
  vim.o.background = "dark"
  vim.g.colors_name = "islands-dark"

  -- ── Editor UI ──────────────────────────────────────────────────────────
  hi("Normal", { fg = p.fg, bg = p.bg })
  hi("NormalNC", { fg = p.fg, bg = p.bg })
  hi("NormalFloat", { fg = p.fg, bg = p.bg_alt })
  hi("FloatBorder", { fg = p.method_sep, bg = p.bg_alt })
  hi("FloatTitle", { fg = p.gold, bg = p.bg_alt, bold = true })
  hi("ColorColumn", { bg = p.bg_alt })
  hi("Cursor", { fg = p.bg, bg = p.fg })
  hi("lCursor", { fg = p.bg, bg = p.fg })
  hi("CursorLine", { bg = p.cursorline })
  hi("CursorColumn", { bg = p.cursorline })
  hi("CursorLineNr", { fg = p.line_nr_cur, bold = true })
  hi("LineNr", { fg = p.line_nr })
  hi("LineNrAbove", { fg = p.line_nr })
  hi("LineNrBelow", { fg = p.line_nr })
  hi("SignColumn", { bg = p.bg })
  hi("FoldColumn", { fg = p.dim, bg = p.bg })
  hi("Folded", { fg = p.dim, bg = p.bg_alt })
  hi("VertSplit", { fg = p.separator, bg = p.bg })
  hi("WinSeparator", { fg = p.separator, bg = p.bg })
  hi("Visual", { bg = p.visual })
  hi("VisualNOS", { bg = p.visual })
  hi("Search", { fg = p.fg_bright, bg = p.search })
  hi("IncSearch", { fg = p.bg, bg = p.search_cur, bold = true })
  hi("CurSearch", { fg = p.bg, bg = p.search_cur, bold = true })
  hi("Substitute", { fg = p.bg, bg = p.gold })
  hi("MatchParen", { fg = p.brace_fg, bg = p.brace_bg, bold = true })
  hi("Pmenu", { fg = p.fg, bg = p.bg_alt })
  hi("PmenuSel", { fg = p.fg_bright, bg = p.visual, bold = true })
  hi("PmenuKind", { fg = p.dim, bg = p.bg_alt })
  hi("PmenuKindSel", { fg = p.fg_bright, bg = p.visual })
  hi("PmenuExtra", { fg = p.dim, bg = p.bg_alt })
  hi("PmenuExtraSel", { fg = p.fg_bright, bg = p.visual })
  hi("PmenuSbar", { bg = p.bg_alt })
  hi("PmenuThumb", { bg = p.method_sep })
  hi("StatusLine", { fg = p.fg, bg = p.bg_alt })
  hi("StatusLineNC", { fg = p.dim, bg = p.bg_alt })
  hi("TabLine", { fg = p.dim, bg = p.bg })
  hi("TabLineSel", { fg = p.fg_bright, bg = p.bg_alt })
  hi("TabLineFill", { bg = p.bg })
  hi("WildMenu", { fg = p.bg, bg = p.gold })
  hi("Title", { fg = p.gold, bold = true })
  hi("Directory", { fg = p.fg })
  hi("NonText", { fg = p.indent })
  hi("Whitespace", { fg = p.indent })
  hi("SpecialKey", { fg = p.indent })
  hi("EndOfBuffer", { fg = p.bg })
  hi("Conceal", { fg = p.dim })
  hi("QuickFixLine", { bg = p.cursorline, bold = true })
  hi("WinBar", { fg = p.fg_bright, bg = p.bg })
  hi("WinBarNC", { fg = p.line_nr_cur, bg = p.bg })
  hi("ModeMsg", { fg = p.fg })
  hi("MsgArea", { fg = p.fg })
  hi("MoreMsg", { fg = p.green })
  hi("Question", { fg = p.green })
  hi("ErrorMsg", { fg = p.error })
  hi("WarningMsg", { fg = p.warn })
  hi("FloatShadow", { bg = "#000000", blend = 60 })
  hi("FloatShadowThrough", { bg = "#000000", blend = 100 })

  -- ── Syntax (legacy / vim regex groups) ───────────────────────────────────
  hi("Comment", { fg = p.comment })
  hi("Keyword", { fg = p.orange })
  hi("Statement", { fg = p.orange })
  hi("Conditional", { fg = p.orange })
  hi("Repeat", { fg = p.orange })
  hi("Label", { fg = p.orange })
  hi("Exception", { fg = p.orange })
  hi("Operator", { fg = p.fg })
  hi("Function", { fg = p.gold })
  hi("Identifier", { fg = p.fg })
  hi("String", { fg = p.green })
  hi("Character", { fg = p.green })
  hi("Number", { fg = p.blue })
  hi("Float", { fg = p.blue })
  hi("Boolean", { fg = p.orange })
  hi("Constant", { fg = p.purple })
  hi("Type", { fg = p.fg })
  hi("StorageClass", { fg = p.orange })
  hi("Structure", { fg = p.orange })
  hi("Typedef", { fg = p.orange })
  hi("Delimiter", { fg = p.fg })
  hi("Special", { fg = p.orange })
  hi("SpecialChar", { fg = p.orange })
  hi("Tag", { fg = p.olive })
  hi("PreProc", { fg = p.orange })
  hi("Include", { fg = p.orange })
  hi("Define", { fg = p.orange })
  hi("Macro", { fg = p.orange })
  hi("PreCondit", { fg = p.orange })
  hi("Todo", { fg = p.bg, bg = p.gold, bold = true })
  hi("Error", { fg = p.error })
  hi("Underlined", { fg = p.hyperlink, underline = true })
  hi("Ignore", { fg = p.dim })
  hi("Debug", { fg = p.purple })

  -- ── Treesitter ────────────────────────────────────────────────────────────
  hi("@comment", { link = "Comment" })
  hi("@comment.documentation", { fg = p.doc_green, italic = true })
  hi("@comment.error", { fg = p.bg, bg = p.error })
  hi("@comment.warning", { fg = p.bg, bg = p.warn })
  hi("@comment.todo", { fg = p.bg, bg = p.gold, bold = true })
  hi("@comment.note", { fg = p.bg, bg = p.info })

  hi("@keyword", { fg = p.orange })
  hi("@keyword.function", { fg = p.orange })
  hi("@keyword.operator", { fg = p.orange })
  hi("@keyword.return", { fg = p.orange })
  hi("@keyword.import", { fg = p.orange })
  hi("@keyword.repeat", { fg = p.orange })
  hi("@keyword.conditional", { fg = p.orange })
  hi("@keyword.exception", { fg = p.orange })
  hi("@keyword.coroutine", { fg = p.orange })
  hi("@keyword.directive", { fg = p.orange })
  hi("@conditional", { fg = p.orange })
  hi("@repeat", { fg = p.orange })
  hi("@exception", { fg = p.orange })
  hi("@label", { fg = p.orange })

  hi("@function", { fg = p.gold })
  hi("@function.call", { fg = p.gold })
  hi("@function.method", { fg = p.gold })
  hi("@function.method.call", { fg = p.gold })
  hi("@function.builtin", { fg = p.gold })
  hi("@function.macro", { fg = p.orange })
  hi("@constructor", { fg = p.fg })
  hi("@method", { fg = p.gold })

  hi("@variable", { fg = p.fg })
  hi("@variable.builtin", { fg = p.orange })
  hi("@variable.parameter", { fg = p.fg })
  hi("@variable.member", { fg = p.purple })
  hi("@parameter", { fg = p.fg })
  hi("@property", { fg = p.purple })
  hi("@field", { fg = p.purple })

  hi("@string", { fg = p.green })
  hi("@string.documentation", { fg = p.doc_green })
  hi("@string.regexp", { fg = p.orange })
  hi("@string.escape", { fg = p.orange })
  hi("@string.special", { fg = p.orange })
  hi("@character", { fg = p.green })
  hi("@character.special", { fg = p.orange })

  hi("@number", { fg = p.blue })
  hi("@number.float", { fg = p.blue })
  hi("@float", { fg = p.blue })
  hi("@boolean", { fg = p.orange })

  hi("@constant", { fg = p.purple })
  hi("@constant.builtin", { fg = p.orange })
  hi("@constant.macro", { fg = p.purple })

  hi("@type", { fg = p.fg })
  hi("@type.builtin", { fg = p.orange })
  hi("@type.definition", { fg = p.fg })
  hi("@type.qualifier", { fg = p.orange })
  hi("@structure", { fg = p.orange })
  hi("@storageclass", { fg = p.orange })

  hi("@operator", { fg = p.fg })
  hi("@punctuation.delimiter", { fg = p.fg })
  hi("@punctuation.bracket", { fg = p.fg })
  hi("@punctuation.special", { fg = p.orange })

  hi("@namespace", { fg = p.fg })
  hi("@module", { fg = p.fg })
  hi("@module.builtin", { fg = p.orange })

  hi("@attribute", { fg = p.olive })
  hi("@attribute.builtin", { fg = p.olive })
  hi("@annotation", { fg = p.olive })

  -- Markup (markdown, help, etc.)
  hi("@markup.heading", { fg = p.gold, bold = true })
  hi("@markup.heading.1", { fg = p.gold, bold = true })
  hi("@markup.heading.2", { fg = p.gold, bold = true })
  hi("@markup.heading.3", { fg = p.blue, bold = true })
  hi("@markup.strong", { fg = p.fg_bright, bold = true })
  hi("@markup.italic", { fg = p.fg, italic = true })
  hi("@markup.strikethrough", { fg = p.dim, strikethrough = true })
  hi("@markup.underline", { underline = true })
  hi("@markup.heading.marker", { fg = p.dim })
  hi("@markup.quote", { fg = p.comment, italic = true })
  hi("@markup.math", { fg = p.blue })
  hi("@markup.link", { fg = p.hyperlink })
  hi("@markup.link.label", { fg = p.blue })
  hi("@markup.link.url", { fg = p.hyperlink, underline = true })
  hi("@markup.raw", { fg = p.green })
  hi("@markup.raw.block", { fg = p.green })
  hi("@markup.list", { fg = p.orange })
  hi("@markup.list.checked", { fg = p.git_add })
  hi("@markup.list.unchecked", { fg = p.dim })

  -- Tags (HTML/JSX/XML)
  hi("@tag", { fg = p.olive })
  hi("@tag.builtin", { fg = p.olive })
  hi("@tag.attribute", { fg = p.purple })
  hi("@tag.delimiter", { fg = p.fg })

  -- Diff / comment text
  hi("@diff.plus", { fg = p.git_add })
  hi("@diff.minus", { fg = p.git_delete })
  hi("@diff.delta", { fg = p.git_change })

  -- ── LSP semantic tokens ──────────────────────────────────────────────────
  -- gopls and other servers emit these; align them with the treesitter palette.
  hi("@lsp.type.namespace", { fg = p.fg })
  hi("@lsp.type.type", { fg = p.fg })
  hi("@lsp.type.class", { fg = p.fg })
  hi("@lsp.type.struct", { fg = p.fg })
  hi("@lsp.type.interface", { fg = p.fg })
  hi("@lsp.type.enum", { fg = p.fg })
  hi("@lsp.type.typeParameter", { fg = p.fg })
  hi("@lsp.type.parameter", { fg = p.fg })
  hi("@lsp.type.variable", { fg = p.fg })
  hi("@lsp.type.property", { fg = p.purple })
  hi("@lsp.type.enumMember", { fg = p.purple })
  hi("@lsp.type.function", { fg = p.gold })
  hi("@lsp.type.method", { fg = p.gold })
  hi("@lsp.type.keyword", { fg = p.orange })
  hi("@lsp.type.modifier", { fg = p.orange })
  hi("@lsp.type.comment", { fg = p.comment })
  hi("@lsp.type.string", { fg = p.green })
  hi("@lsp.type.number", { fg = p.blue })
  hi("@lsp.type.operator", { fg = p.fg })
  hi("@lsp.type.decorator", { fg = p.olive })
  hi("@lsp.type.macro", { fg = p.orange })
  hi("@lsp.type.label", { fg = p.orange })
  hi("@lsp.type.selfKeyword", { fg = p.orange })
  -- Modifiers: builtin/default-library symbols read as keyword-orange
  hi("@lsp.typemod.type.defaultLibrary", { fg = p.orange })
  hi("@lsp.typemod.function.defaultLibrary", { fg = p.gold })
  hi("@lsp.typemod.variable.defaultLibrary", { fg = p.orange })
  hi("@lsp.typemod.variable.readonly", { fg = p.purple })
  hi("@lsp.typemod.variable.global", { fg = p.purple })
  hi("@lsp.typemod.property.readonly", { fg = p.purple })
  hi("@lsp.mod.deprecated", { strikethrough = true })

  -- Language-scoped semantic-token overrides. Neovim applies a per-language
  -- variant (@lsp.type.<type>.<ft>) on top of the generic group, so these
  -- retune one language without touching others. terraform-ls tags HCL block
  -- types (variable/resource/module/output/provider/validation/data/…) as the
  -- generic `type` token — which is grey for Go type names but should read as a
  -- keyword (orange) in HC..
  hi("@lsp.type.type.terraform", { fg = p.orange })
  hi("@lsp.type.type.hcl", { fg = p.orange })
  -- HCL block labels (variable "my_name", resource "type" "name", …) come as
  -- the `enumMember` token — purple suits Go enum constants, but GoLand renders
  -- HCL labels as plain text.
  hi("@lsp.type.enumMember.terraform", { fg = p.fg })
  hi("@lsp.type.enumMember.hcl", { fg = p.fg })

  -- ── Diagnostics ────────────────────────────────────────────────────────
  hi("DiagnosticError", { fg = p.error })
  hi("DiagnosticWarn", { fg = p.warn })
  hi("DiagnosticInfo", { fg = p.info })
  hi("DiagnosticHint", { fg = p.hint })
  hi("DiagnosticOk", { fg = p.git_add })
  hi("DiagnosticVirtualTextError", { fg = p.error, bg = p.error_bg })
  hi("DiagnosticVirtualTextWarn", { fg = p.warn, bg = p.warn_bg })
  hi("DiagnosticVirtualTextInfo", { fg = p.info, bg = p.bg_alt })
  hi("DiagnosticVirtualTextHint", { fg = p.hint, bg = p.bg_alt })
  hi("DiagnosticUnderlineError", { undercurl = true, sp = p.error })
  hi("DiagnosticUnderlineWarn", { undercurl = true, sp = p.warn })
  hi("DiagnosticUnderlineInfo", { undercurl = true, sp = p.info })
  hi("DiagnosticUnderlineHint", { undercurl = true, sp = p.hint })
  -- gopls "Unnecessary" (unused/dead code) + deprecated APIs.
  hi("DiagnosticUnnecessary", { fg = p.dim })
  hi("DiagnosticDeprecated", { fg = p.dim, strikethrough = true })
  hi("DiagnosticError", { fg = p.error })

  -- ── LSP references / occurrences ──────────────────────────────────────────
  hi("LspReferenceText", { bg = occ.read })
  hi("LspReferenceRead", { bg = occ.read })
  hi("LspReferenceWrite", { bg = occ.write })
  hi("LspInlayHint", { fg = p.dim, bg = p.bg_alt })
  hi("LspCodeLens", { fg = p.dim, italic = true })
  hi("LspCodeLensSeparator", { fg = p.method_sep })
  hi("LspSignatureActiveParameter", { fg = p.gold, bold = true })

  -- ── Git / diff ────────────────────────────────────────────────────────────
  hi("DiffAdd", { bg = diff.add })
  hi("DiffChange", { bg = diff.change })
  hi("DiffDelete", { fg = p.git_delete, bg = diff.delete })
  hi("DiffText", { bg = diff.text })
  hi("diffAdded", { fg = p.git_add })
  hi("diffRemoved", { fg = p.git_delete })
  hi("diffChanged", { fg = p.git_change })
  hi("diffLine", { fg = p.blue })
  hi("diffFile", { fg = p.gold })
  hi("diffNewFile", { fg = p.green })
  hi("diffOldFile", { fg = p.git_delete })
  hi("Added", { fg = p.git_add })
  hi("Changed", { fg = p.git_change })
  hi("Removed", { fg = p.git_delete })

  hi("GitSignsAdd", { fg = p.git_add })
  hi("GitSignsChange", { fg = p.git_change })
  hi("GitSignsDelete", { fg = p.git_delete })
  hi("GitSignsAddNr", { fg = p.git_add })
  hi("GitSignsChangeNr", { fg = p.git_change })
  hi("GitSignsDeleteNr", { fg = p.git_delete })
  hi("GitSignsCurrentLineBlame", { fg = p.dim, italic = true })

  -- ── Spell ─────────────────────────────────────────────────────────────────
  hi("SpellBad", { undercurl = true, sp = p.error })
  hi("SpellCap", { undercurl = true, sp = p.warn })
  hi("SpellRare", { undercurl = true, sp = p.info })
  hi("SpellLocal", { undercurl = true, sp = p.info })

  -- ── Plugin: neo-tree ──────────────────────────────────────────────────────
  -- Tool-window background slightly darker than the editor (the "Islands" look).
  hi("NeoTreeNormal", { fg = p.fg, bg = p.sidebar })
  hi("NeoTreeNormalNC", { fg = p.fg, bg = p.sidebar })
  hi("NeoTreeWinSeparator", { fg = p.separator, bg = p.sidebar })
  hi("NeoTreeEndOfBuffer", { fg = p.sidebar, bg = p.sidebar })
  hi("NeoTreeRootName", { fg = p.fg_bright, bold = true })
  hi("NeoTreeDirectoryName", { fg = p.dir })
  hi("NeoTreeDirectoryIcon", { fg = p.gold })
  hi("NeoTreeFileName", { fg = p.fg })
  hi("NeoTreeFileNameOpened", { fg = p.fg_bright })
  hi("NeoTreeIndentMarker", { fg = p.indent })
  hi("NeoTreeExpander", { fg = p.dim })
  hi("NeoTreeDotfile", { fg = p.dim })
  hi("NeoTreeHiddenByName", { fg = p.dim })
  hi("NeoTreeGitAdded", { fg = p.git_add })
  hi("NeoTreeGitModified", { fg = p.git_change })
  hi("NeoTreeGitDeleted", { fg = p.git_delete })
  hi("NeoTreeGitUntracked", { fg = p.olive })
  hi("NeoTreeGitIgnored", { fg = p.dim })
  hi("NeoTreeGitConflict", { fg = p.error })
  hi("NeoTreeTabActive", { fg = p.fg_bright, bg = p.bg_alt })
  hi("NeoTreeTabInactive", { fg = p.dim, bg = p.bg })
  hi("NeoTreeTitleBar", { fg = p.bg, bg = p.gold })

  -- ── Plugin: aerial (structure outline) ──────────────────────────────────
  hi("AerialLine", { bg = p.cursorline })
  hi("AerialGuide", { fg = p.indent })
  hi("AerialNormal", { fg = p.fg })
  hi("AerialFunctionIcon", { fg = p.gold })
  hi("AerialMethodIcon", { fg = p.gold })
  hi("AerialStructIcon", { fg = p.orange })
  hi("AerialInterfaceIcon", { fg = p.orange })
  hi("AerialConstantIcon", { fg = p.purple })
  hi("AerialFieldIcon", { fg = p.purple })
  hi("AerialVariableIcon", { fg = p.fg })

  -- ── Plugin: snacks.nvim (picker / dashboard / indent / notifier / input) ──
  -- The explorer (folder tree) names share the editor's text palette: folders
  -- and files are plain text (like GoLand), distinguished by icon + git color,
  -- not by tinting the name itself. SnacksPickerDir is only the greyed dirname
  -- *prefix* shown in file/grep results.
  hi("SnacksPickerFile", { fg = p.fg })
  hi("SnacksPickerDirectory", { fg = p.dir })
  hi("SnacksPickerDir", { fg = p.dim })
  hi("SnacksPickerPathHidden", { fg = p.dim })
  hi("SnacksPickerPathIgnored", { fg = p.dim, italic = true })
  hi("SnacksPickerMatch", { fg = p.gold, bold = true })
  hi("SnacksPickerCol", { fg = p.dim })
  hi("SnacksPickerRow", { fg = p.green })
  hi("SnacksPickerSelected", { fg = p.gold })
  hi("SnacksPickerTitle", { fg = p.gold, bold = true })
  -- Picker window backgrounds: the "Islands" look — tool windows sit on a
  -- background slightly darker than the editor. SnacksPicker is the base group
  -- every picker window (list/input/box) links to, so this darkens the explorer
  -- sidebar and the floating pickers alike. The preview shows file content, so
  -- it keeps the editor background to stay faithful to the open file.
  hi("SnacksPicker", { fg = p.fg, bg = p.sidebar })
  hi("SnacksPickerPreview", { fg = p.fg, bg = p.bg })
  hi("SnacksPickerBorder", { fg = p.method_sep, bg = p.sidebar })
  hi("SnacksPickerPrompt", { fg = p.gold })
  hi("SnacksPickerInputBorder", { fg = p.method_sep, bg = p.sidebar })
  hi("SnacksPickerListCursorLine", { bg = p.visual })
  hi("SnacksPickerToggle", { fg = p.bg, bg = p.dim })
  hi("SnacksPickerTree", { fg = p.indent })
  -- git status badges in the explorer / pickers (GoLand VCS hues)
  hi("SnacksPickerGitStatusAdded", { fg = p.git_add })
  hi("SnacksPickerGitStatusStaged", { fg = p.git_add })
  hi("SnacksPickerGitStatusModified", { fg = p.git_change })
  hi("SnacksPickerGitStatusDeleted", { fg = p.git_delete })
  hi("SnacksPickerGitStatusUntracked", { fg = p.olive })
  hi("SnacksPickerGitStatusIgnored", { fg = p.dim })
  hi("SnacksPickerGitStatusRenamed", { fg = p.git_change })
  hi("SnacksPickerGitStatus", { fg = p.dim })

  -- snacks content windows (terminal, scratch, zen) default their Normal to
  -- NormalFloat (the lighter float bg). Pin them to the editor background so a
  -- bottom terminal split blends with the editor instead of standing out.
  hi("SnacksNormal", { fg = p.fg, bg = p.bg })
  hi("SnacksNormalNC", { fg = p.fg, bg = p.bg })
  hi("SnacksWinBar", { fg = p.fg_bright, bg = p.bg, bold = true })
  hi("SnacksWinBarNC", { fg = p.dim, bg = p.bg })

  hi("SnacksIndent", { fg = p.indent })
  hi("SnacksIndentScope", { fg = p.indent_sel })
  hi("SnacksIndentChunk", { fg = p.indent_sel })

  hi("SnacksDashboardHeader", { fg = p.gold })
  hi("SnacksDashboardDesc", { fg = p.fg })
  hi("SnacksDashboardIcon", { fg = p.orange })
  hi("SnacksDashboardKey", { fg = p.blue })
  hi("SnacksDashboardFooter", { fg = p.dim })
  hi("SnacksDashboardDir", { fg = p.dim })
  hi("SnacksDashboardSpecial", { fg = p.purple })

  hi("SnacksNotifierInfo", { fg = p.info })
  hi("SnacksNotifierWarn", { fg = p.warn })
  hi("SnacksNotifierError", { fg = p.error })
  hi("SnacksNotifierDebug", { fg = p.dim })
  hi("SnacksNotifierTrace", { fg = p.purple })
  hi("SnacksNotifierBorderInfo", { fg = p.info, bg = p.bg_alt })
  hi("SnacksNotifierBorderWarn", { fg = p.warn, bg = p.bg_alt })
  hi("SnacksNotifierBorderError", { fg = p.error, bg = p.bg_alt })

  hi("SnacksInputBorder", { fg = p.method_sep, bg = p.bg_alt })
  hi("SnacksInputTitle", { fg = p.gold })

  -- ── Plugin: Telescope (in case it's used) ──────────────────────────────────
  hi("TelescopeNormal", { fg = p.fg, bg = p.bg_alt })
  hi("TelescopeBorder", { fg = p.method_sep, bg = p.bg_alt })
  hi("TelescopePromptNormal", { fg = p.fg, bg = p.cursorline })
  hi("TelescopePromptBorder", { fg = p.cursorline, bg = p.cursorline })
  hi("TelescopePromptTitle", { fg = p.bg, bg = p.gold })
  hi("TelescopeResultsTitle", { fg = p.bg, bg = p.blue })
  hi("TelescopePreviewTitle", { fg = p.bg, bg = p.green })
  hi("TelescopeSelection", { fg = p.fg_bright, bg = p.visual })
  hi("TelescopeMatching", { fg = p.gold, bold = true })

  -- ── Plugin: blink.cmp (LazyVim default completion) ─────────────────────────
  hi("BlinkCmpMenu", { fg = p.fg, bg = p.bg_alt })
  hi("BlinkCmpMenuBorder", { fg = p.method_sep, bg = p.bg_alt })
  hi("BlinkCmpMenuSelection", { fg = p.fg_bright, bg = p.visual })
  hi("BlinkCmpLabel", { fg = p.fg })
  hi("BlinkCmpLabelMatch", { fg = p.gold, bold = true })
  hi("BlinkCmpLabelDeprecated", { fg = p.dim, strikethrough = true })
  hi("BlinkCmpLabelDescription", { fg = p.dim })
  hi("BlinkCmpKind", { fg = p.blue })
  hi("BlinkCmpDoc", { fg = p.fg, bg = p.bg_alt })
  hi("BlinkCmpDocBorder", { fg = p.method_sep, bg = p.bg_alt })
  hi("BlinkCmpGhostText", { fg = p.dim })
  hi("BlinkCmpSignatureHelp", { fg = p.fg, bg = p.bg_alt })

  -- ── Plugin: nvim-cmp (fallback completion) ──────────────────────────────────
  hi("CmpItemAbbr", { fg = p.fg })
  hi("CmpItemAbbrDeprecated", { fg = p.dim, strikethrough = true })
  hi("CmpItemAbbrMatch", { fg = p.gold, bold = true })
  hi("CmpItemAbbrMatchFuzzy", { fg = p.gold, bold = true })
  hi("CmpItemMenu", { fg = p.dim, italic = true })
  hi("CmpItemKindFunction", { fg = p.gold })
  hi("CmpItemKindMethod", { fg = p.gold })
  hi("CmpItemKindVariable", { fg = p.fg })
  hi("CmpItemKindField", { fg = p.purple })
  hi("CmpItemKindProperty", { fg = p.purple })
  hi("CmpItemKindKeyword", { fg = p.orange })
  hi("CmpItemKindClass", { fg = p.fg })
  hi("CmpItemKindStruct", { fg = p.fg })
  hi("CmpItemKindInterface", { fg = p.fg })
  hi("CmpItemKindConstant", { fg = p.purple })
  hi("CmpItemKindText", { fg = p.green })
  hi("CmpItemKindSnippet", { fg = p.olive })
  hi("CmpItemKindModule", { fg = p.fg })

  -- ── Plugin: which-key ──────────────────────────────────────────────────────
  hi("WhichKey", { fg = p.gold })
  hi("WhichKeyGroup", { fg = p.blue })
  hi("WhichKeyDesc", { fg = p.fg })
  hi("WhichKeySeparator", { fg = p.dim })
  hi("WhichKeyValue", { fg = p.dim })
  hi("WhichKeyFloat", { bg = p.bg_alt })
  hi("WhichKeyBorder", { fg = p.method_sep, bg = p.bg_alt })
  hi("WhichKeyTitle", { fg = p.gold, bg = p.bg_alt, bold = true })

  -- ── Plugin: trouble ────────────────────────────────────────────────────────
  hi("TroubleNormal", { fg = p.fg, bg = p.bg })
  hi("TroubleNormalNC", { fg = p.fg, bg = p.bg })
  hi("TroubleText", { fg = p.fg })
  hi("TroubleCount", { fg = p.purple, bold = true })
  hi("TroubleSource", { fg = p.dim })
  hi("TroubleFoldIcon", { fg = p.dim })
  hi("TroubleIndent", { fg = p.indent })
  hi("TroublePos", { fg = p.dim })

  -- ── Plugin: flash ─────────────────────────────────────────────────────────
  hi("FlashLabel", { fg = p.bg, bg = p.gold, bold = true })
  hi("FlashMatch", { fg = p.fg_bright, bg = p.search })
  hi("FlashCurrent", { fg = p.bg, bg = p.search_cur })
  hi("FlashBackdrop", { fg = p.dim })

  -- ── Plugin: lazy.nvim / mason ──────────────────────────────────────────────
  hi("LazyNormal", { fg = p.fg, bg = p.bg_alt })
  hi("LazyButton", { fg = p.fg, bg = p.cursorline })
  hi("LazyButtonActive", { fg = p.bg, bg = p.gold, bold = true })
  hi("LazyH1", { fg = p.bg, bg = p.gold, bold = true })
  hi("LazyProgressdone", { fg = p.gold })
  hi("LazyProgressTodo", { fg = p.method_sep })
  hi("LazySpecial", { fg = p.blue })
  hi("LazyReasonPlugin", { fg = p.purple })
  hi("LazyReasonEvent", { fg = p.olive })
  hi("LazyReasonKeys", { fg = p.green })
  hi("MasonNormal", { fg = p.fg, bg = p.bg_alt })
  hi("MasonHeader", { fg = p.bg, bg = p.gold, bold = true })
  hi("MasonHighlight", { fg = p.blue })
  hi("MasonHighlightBlock", { fg = p.bg, bg = p.blue })
  hi("MasonHighlightBlockBold", { fg = p.bg, bg = p.gold, bold = true })
  hi("MasonMuted", { fg = p.dim })
  hi("MasonMutedBlock", { fg = p.fg, bg = p.cursorline })

  -- ── Plugin: noice ──────────────────────────────────────────────────────────
  hi("NoiceCmdlinePopup", { fg = p.fg, bg = p.bg_alt })
  hi("NoiceCmdlinePopupBorder", { fg = p.method_sep, bg = p.bg_alt })
  hi("NoiceCmdlineIcon", { fg = p.gold })
  hi("NoiceConfirm", { fg = p.fg, bg = p.bg_alt })
  hi("NoiceConfirmBorder", { fg = p.method_sep, bg = p.bg_alt })

  -- ── Plugin: mini.nvim (icons / statusline / indentscope) ────────────────────
  hi("MiniIconsAzure", { fg = p.blue })
  hi("MiniIconsBlue", { fg = p.blue })
  hi("MiniIconsCyan", { fg = p.info })
  hi("MiniIconsGreen", { fg = p.green })
  hi("MiniIconsGrey", { fg = p.dim })
  hi("MiniIconsOrange", { fg = p.orange })
  hi("MiniIconsPurple", { fg = p.purple })
  hi("MiniIconsRed", { fg = p.error })
  hi("MiniIconsYellow", { fg = p.gold })
  hi("MiniIndentscopeSymbol", { fg = p.indent_sel })
  hi("MiniDiffSignAdd", { fg = p.git_add })
  hi("MiniDiffSignChange", { fg = p.git_change })
  hi("MiniDiffSignDelete", { fg = p.git_delete })

  -- ── Terminal ANSI palette ──────────────────────────────────────────────────
  vim.g.terminal_color_0 = "#2b2d30"
  vim.g.terminal_color_1 = p.error
  vim.g.terminal_color_2 = p.green
  vim.g.terminal_color_3 = p.gold
  vim.g.terminal_color_4 = p.blue
  vim.g.terminal_color_5 = p.purple
  vim.g.terminal_color_6 = p.info
  vim.g.terminal_color_7 = p.fg
  vim.g.terminal_color_8 = p.dim
  vim.g.terminal_color_9 = "#ff7a85"
  vim.g.terminal_color_10 = "#7faf6a"
  vim.g.terminal_color_11 = p.orange
  vim.g.terminal_color_12 = "#7fb0d8"
  vim.g.terminal_color_13 = p.hyperlink
  vim.g.terminal_color_14 = "#4fb0d8"
  vim.g.terminal_color_15 = p.fg_bright
end

M.setup()
return M
