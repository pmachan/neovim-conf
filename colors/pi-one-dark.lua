-- ~/.config/nvim/colors/pi-one-dark.lua
-- Built from the user's pi-agent one-dark.json palette.
-- Activate with: vim.cmd.colorscheme("pi-one-dark")

local M = {}

-- Palette (from one-dark.json "vars")
local p = {
	bg      = "#23262d",
	panel   = "#2b2f36",
	panel2  = "#31353d",
	line    = "#3a3f47",
	muted   = "#7f8490",
	dim     = "#676c78",
	text    = "#cfd3dc",
	accent  = "#e5c07b",
	green   = "#98c379",
	red     = "#e06c75",
	blue    = "#61afef",
	cyan    = "#56b6c2",
	purple  = "#c678dd",
}

local function hi(group, opts)
	vim.api.nvim_set_hl(0, group, opts)
end

function M.setup()
	vim.cmd("hi clear")
	if vim.fn.exists("syntax_on") then vim.cmd("syntax reset") end
	vim.o.background = "dark"
	vim.g.colors_name = "pi-one-dark"

	-- ---- Editor UI ----
	hi("Normal",        { fg = p.text, bg = p.bg })
	hi("NormalFloat",   { fg = p.text, bg = p.panel })
	hi("FloatBorder",   { fg = p.line, bg = p.panel })
	hi("ColorColumn",   { bg = p.panel })
	hi("Cursor",        { fg = p.bg, bg = p.text })
	hi("CursorLine",    { bg = p.panel })
	hi("CursorLineNr",  { fg = p.accent, bold = true })
	hi("LineNr",        { fg = p.dim })
	hi("SignColumn",    { bg = p.bg })
	hi("VertSplit",     { fg = p.line, bg = p.bg })
	hi("WinSeparator",  { fg = p.line, bg = p.bg })
	hi("Folded",        { fg = p.muted, bg = p.panel })
	hi("FoldColumn",    { fg = p.dim, bg = p.bg })
	hi("Visual",        { bg = p.panel2 })
	hi("Search",        { fg = p.bg, bg = p.accent })
	hi("IncSearch",     { fg = p.bg, bg = p.cyan })
	hi("CurSearch",     { fg = p.bg, bg = p.accent })
	hi("MatchParen",    { fg = p.accent, bold = true })
	hi("Pmenu",         { fg = p.text, bg = p.panel })
	hi("PmenuSel",      { fg = p.text, bg = p.panel2, bold = true })
	hi("PmenuSbar",     { bg = p.panel })
	hi("PmenuThumb",    { bg = p.line })
	hi("StatusLine",    { fg = p.text, bg = p.panel })
	hi("StatusLineNC",  { fg = p.muted, bg = p.panel })
	hi("TabLine",       { fg = p.muted, bg = p.panel })
	hi("TabLineSel",    { fg = p.text, bg = p.bg })
	hi("TabLineFill",   { bg = p.bg })
	hi("WildMenu",      { fg = p.bg, bg = p.accent })
	hi("Title",         { fg = p.accent, bold = true })
	hi("Directory",     { fg = p.blue })
	hi("NonText",       { fg = p.line })
	hi("Whitespace",    { fg = p.line })
	hi("SpecialKey",    { fg = p.line })
	hi("EndOfBuffer",   { fg = p.bg })
	hi("Conceal",       { fg = p.muted })
	hi("QuickFixLine",  { bg = p.panel2 })
	hi("WinBar",        { fg = p.text, bg = p.bg })
	hi("WinBarNC",      { fg = p.muted, bg = p.bg })

	-- ---- Syntax (mapped from one-dark.json "colors" syntax* keys) ----
	hi("Comment",       { fg = p.muted, italic = true })          -- syntaxComment
	hi("Keyword",       { fg = p.purple })                        -- syntaxKeyword
	hi("Statement",     { fg = p.purple })
	hi("Conditional",   { fg = p.purple })
	hi("Repeat",        { fg = p.purple })
	hi("Label",         { fg = p.purple })
	hi("Exception",     { fg = p.purple })
	hi("Keyword",       { fg = p.purple })
	hi("Function",      { fg = p.blue })                          -- syntaxFunction
	hi("Identifier",    { fg = p.text })                          -- syntaxVariable
	hi("Variable",      { fg = p.text })
	hi("String",        { fg = p.green })                         -- syntaxString
	hi("Character",     { fg = p.green })
	hi("Number",        { fg = p.accent })                        -- syntaxNumber
	hi("Float",         { fg = p.accent })
	hi("Boolean",       { fg = p.accent })
	hi("Constant",      { fg = p.accent })
	hi("Type",          { fg = p.cyan })                          -- syntaxType
	hi("StorageClass",  { fg = p.cyan })
	hi("Structure",     { fg = p.cyan })
	hi("Typedef",       { fg = p.cyan })
	hi("Operator",      { fg = p.accent })                        -- syntaxOperator
	hi("Delimiter",     { fg = p.muted })                         -- syntaxPunctuation
	hi("Special",       { fg = p.cyan })
	hi("SpecialChar",   { fg = p.cyan })
	hi("PreProc",       { fg = p.purple })
	hi("Include",       { fg = p.purple })
	hi("Define",        { fg = p.purple })
	hi("Macro",         { fg = p.purple })
	hi("Tag",           { fg = p.red })
	hi("Todo",          { fg = p.bg, bg = p.accent, bold = true })
	hi("Error",         { fg = p.red })
	hi("Underlined",    { fg = p.blue, underline = true })

	-- ---- Treesitter ----
	hi("@comment",            { link = "Comment" })
	hi("@keyword",            { fg = p.purple })
	hi("@keyword.function",   { fg = p.purple })
	hi("@keyword.return",     { fg = p.purple })
	hi("@keyword.operator",   { fg = p.purple })
	hi("@conditional",        { fg = p.purple })
	hi("@repeat",             { fg = p.purple })
	hi("@function",           { fg = p.blue })
	hi("@function.call",      { fg = p.blue })
	hi("@function.method",    { fg = p.blue })
	hi("@function.builtin",   { fg = p.blue })
	hi("@constructor",        { fg = p.cyan })
	hi("@variable",           { fg = p.text })
	hi("@variable.builtin",   { fg = p.red })
	hi("@variable.member",    { fg = p.text })
	hi("@property",           { fg = p.text })
	hi("@field",              { fg = p.text })
	hi("@parameter",          { fg = p.text })
	hi("@string",             { fg = p.green })
	hi("@string.escape",      { fg = p.cyan })
	hi("@character",          { fg = p.green })
	hi("@number",             { fg = p.accent })
	hi("@float",              { fg = p.accent })
	hi("@boolean",            { fg = p.accent })
	hi("@constant",           { fg = p.accent })
	hi("@constant.builtin",   { fg = p.accent })
	hi("@type",               { fg = p.cyan })
	hi("@type.builtin",       { fg = p.cyan })
	hi("@type.definition",    { fg = p.cyan })
	hi("@operator",           { fg = p.accent })
	hi("@punctuation.delimiter", { fg = p.muted })
	hi("@punctuation.bracket",   { fg = p.muted })
	hi("@punctuation.special",   { fg = p.cyan })
	hi("@tag",                { fg = p.red })
	hi("@tag.attribute",      { fg = p.accent })
	hi("@namespace",          { fg = p.cyan })
	hi("@module",             { fg = p.cyan })
	hi("@attribute",          { fg = p.accent })

	-- ---- Diagnostics (success/error/warning from JSON) ----
	hi("DiagnosticError",   { fg = p.red })
	hi("DiagnosticWarn",    { fg = p.accent })
	hi("DiagnosticInfo",    { fg = p.blue })
	hi("DiagnosticHint",    { fg = p.cyan })
	hi("DiagnosticOk",      { fg = p.green })
	hi("DiagnosticUnderlineError", { undercurl = true, sp = p.red })
	hi("DiagnosticUnderlineWarn",  { undercurl = true, sp = p.accent })
	hi("DiagnosticUnderlineInfo",  { undercurl = true, sp = p.blue })
	hi("DiagnosticUnderlineHint",  { undercurl = true, sp = p.cyan })
	-- Unused / dead code (gopls tags it "Unnecessary") + deprecated APIs:
	-- dim + strike-through so it's unmistakable.
	hi("DiagnosticUnnecessary", { fg = p.dim, strikethrough = true })
	hi("DiagnosticDeprecated",  { fg = p.dim, strikethrough = true })

	-- ---- Git / diff (toolDiff* + success/error) ----
	hi("DiffAdd",       { fg = p.green, bg = p.panel })
	hi("DiffChange",    { fg = p.accent, bg = p.panel })
	hi("DiffDelete",    { fg = p.red, bg = p.panel })
	hi("DiffText",      { fg = p.accent, bg = p.panel2 })
	hi("Added",         { fg = p.green })
	hi("Changed",       { fg = p.accent })
	hi("Removed",       { fg = p.red })
	hi("GitSignsAdd",     { fg = p.green })
	hi("GitSignsChange",  { fg = p.accent })
	hi("GitSignsDelete",  { fg = p.red })

	-- ---- Plugin: neo-tree ----
	hi("NeoTreeNormal",       { fg = p.text, bg = p.bg })
	hi("NeoTreeNormalNC",     { fg = p.text, bg = p.bg })
	hi("NeoTreeDirectoryName",{ fg = p.blue })
	hi("NeoTreeDirectoryIcon",{ fg = p.blue })
	hi("NeoTreeFileName",     { fg = p.text })
	hi("NeoTreeRootName",     { fg = p.accent, bold = true })
	hi("NeoTreeGitModified",  { fg = p.accent })
	hi("NeoTreeGitAdded",     { fg = p.green })
	hi("NeoTreeGitDeleted",   { fg = p.red })
	hi("NeoTreeIndentMarker", { fg = p.line })
	hi("NeoTreeWinSeparator", { fg = p.line, bg = p.bg })

	-- ---- Plugin: Telescope ----
	hi("TelescopeNormal",       { fg = p.text, bg = p.panel })
	hi("TelescopeBorder",       { fg = p.line, bg = p.panel })
	hi("TelescopePromptNormal", { fg = p.text, bg = p.panel2 })
	hi("TelescopePromptBorder", { fg = p.panel2, bg = p.panel2 })
	hi("TelescopePromptTitle",  { fg = p.bg, bg = p.accent })
	hi("TelescopeResultsTitle", { fg = p.bg, bg = p.blue })
	hi("TelescopePreviewTitle", { fg = p.bg, bg = p.green })
	hi("TelescopeSelection",    { fg = p.text, bg = p.panel2 })
	hi("TelescopeMatching",     { fg = p.accent, bold = true })

	-- ---- Plugin: snacks.picker (LazyVim default picker) ----
	hi("SnacksPickerFile",        { fg = p.text })             -- file basename (bright)
	hi("SnacksPickerDir",         { fg = p.muted })            -- dirname prefix (readable, dim)
	hi("SnacksPickerPathHidden",  { fg = p.dim })              -- hidden files/dirs
	hi("SnacksPickerPathIgnored", { fg = p.dim, italic = true }) -- gitignored
	hi("SnacksPickerDirectory",   { fg = p.blue })             -- directory entries
	hi("SnacksPickerMatch",       { fg = p.accent, bold = true }) -- matched query chars
	hi("SnacksPickerCol",         { fg = p.dim })              -- :col number
	hi("SnacksPickerRow",         { fg = p.green })            -- :line number

	-- ---- Plugin: bufferline (minimal) ----
	hi("BufferLineFill",        { bg = p.bg })

	-- ---- Plugin: which-key / misc floats ----
	hi("WhichKeyFloat",         { bg = p.panel })
end

M.setup()
return M
