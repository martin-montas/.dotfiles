hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "handmade"

set background=dark

" ------------------------------------------------------------------
" UI
" ------------------------------------------------------------------

hi Normal         guifg=#90b080 guibg=#0c0c0c
hi NormalNC       guifg=#90b080 guibg=#0c0c0c

hi Cursor         guifg=#0c0c0c guibg=#00ee00
hi CursorLine     guibg=#1e1e1e
hi CursorColumn   guibg=#1e1e1e

hi LineNr         guifg=#404040 guibg=#101010
hi CursorLineNr   guifg=#d08f20 guibg=#101010 gui=bold

hi ColorColumn    guibg=#181818
hi SignColumn     guibg=#0c0c0c
hi FoldColumn     guifg=#404040 guibg=#0c0c0c

hi VertSplit      guifg=#181818 guibg=#0c0c0c
hi WinSeparator   guifg=#181818

hi StatusLine     guifg=#90b080 guibg=#666666
hi StatusLineNC   guifg=#404040 guibg=#181818

hi Visual         guibg=#494949

hi Search         guifg=#0c0c0c guibg=#ddee00
hi IncSearch      guifg=#0c0c0c guibg=#ee7700

hi MatchParen     guifg=#ff44dd gui=bold

hi Pmenu          guifg=#90b080 guibg=#181818
hi PmenuSel       guifg=#0c0c0c guibg=#323232

hi NonText        guifg=#4e5e46
hi EndOfBuffer    guifg=#0c0c0c

" ------------------------------------------------------------------
" Syntax
" ------------------------------------------------------------------

hi Comment        guifg=#2090f0 gui=italic

hi Constant       guifg=#50ff30
hi String         guifg=#50ff30
hi Character      guifg=#50ff30
hi Number         guifg=#50ff30
hi Boolean        guifg=#50ff30
hi Float          guifg=#50ff30

hi Identifier     guifg=#90b080
hi Function       guifg=#90b080

hi Statement      guifg=#d08f20
hi Keyword        guifg=#d08f20
hi Conditional    guifg=#d08f20
hi Repeat         guifg=#d08f20
hi Label          guifg=#d08f20
hi Exception      guifg=#d08f20

hi Operator       guifg=#90b080

hi Type           guifg=#90b080
hi StorageClass   guifg=#90b080
hi Structure      guifg=#90b080
hi Typedef        guifg=#90b080

hi PreProc        guifg=#90b080
hi Include        guifg=#50ff30
hi Define         guifg=#90b080
hi Macro          guifg=#90b080

hi Special        guifg=#90b080
hi SpecialChar    guifg=#ff0000
hi Delimiter      guifg=#90b080

hi Todo           guifg=#ddee00 gui=bold
hi Error          guifg=#ff0000 guibg=#3a0000
hi WarningMsg     guifg=#ff0000

" ------------------------------------------------------------------
" Diff
" ------------------------------------------------------------------

hi DiffAdd        guibg=#003a3a
hi DiffDelete     guifg=#ff0000
hi DiffChange     guibg=#494949
hi DiffText       guibg=#ddee00

" ------------------------------------------------------------------
" Diagnostics
" ------------------------------------------------------------------

hi DiagnosticError guifg=#ff0000
hi DiagnosticWarn  guifg=#d08f20
hi DiagnosticInfo  guifg=#2090f0
hi DiagnosticHint  guifg=#00a000
