let s:theme = {}

let s:theme.snow = 'f5f3f0'

let s:theme.wheat = 'd6d2c9'
let s:theme.darkwheat = 'aba8a0'
let s:theme.darkerwheat = '807e78'
let s:theme.darkestwheat = '555450'

let s:theme.lightestonyx = '5e6165'
let s:theme.lighteronyx = '464a4f'
let s:theme.lightonyx = '2f3439'
let s:theme.onyx = '14181c'

let s:theme.shade1 = '4cba9c'
let s:theme.shade2 = 'fc5e03'
let s:theme.shade3 = 'faba52'
let s:theme.shade4 = 'fad87a'

" Harmony
" let s:theme.shade1 = '6bbbb5'
" let s:theme.shade2 = 'f5696f'
" let s:theme.shade3 = 'f7a877'

let s:theme.accent1 = 'a7c957'
let s:theme.accent2 = 'f18e5e'
let s:theme.accent3 = 'c76fa5'

let s:theme.green = '9cbf50'
let s:theme.red = 'e84231'
let s:theme.orange = 'e8aa58'
let s:theme.yellow = 'ffd166'
let s:theme.cyan = '74b0a8'
let s:theme.blue = '57afde'
let s:theme.magenta = 'e657a1'
let s:theme.purple = 'a186ad'

" Color conversion algorithm from:
" https://unix.stackexchange.com/questions/269077/tput-setaf-color-table-how-to-determine-color-codes
"
" Arguments: hex without hash
function! s:to8bit(hex)
    let r = str2nr(a:hex[0:1], 16)
    let g = str2nr(a:hex[2:3], 16)
    let b = str2nr(a:hex[4:5], 16)
    return (r < 75 ? 0 : (r - 35) / 40) * 6 * 6 +
          \(g < 75 ? 0 : (g - 35) / 40) * 6 +
          \(b < 75 ? 0 : (b - 35) / 40) + 16
endfunction

" Resolve color name
"
" Arguments: key of color in the theme dictionary or the special values `fg`
" and `bg`.
function! s:resolve(key)
    if a:key == 'fg' || a:key == 'bg'
        return [a:key, a:key]
    else
        let color = get(s:theme, a:key, '000000')
        return ['#' . color, s:to8bit(color)]
    endif
endfunction

" Generate highlight rule
"
" Arguments: group, [fg], [bg], [attrs]
" Example: HL('Normal', 'onyx', 'bg', 'bold,italic')
function! s:HL(group, ...)
    let histring = 'hi ' . a:group

    if a:0 >= 1
        let colors = s:resolve(a:1)
        let histring .= ' guifg=' . colors[0] . ' ctermfg=' . colors[1]
    endif

    if a:0 >= 2
        let colors = s:resolve(a:2)
        let histring .= ' guibg=' . colors[0] . ' ctermbg=' . colors[1]
    endif

    if a:0 >= 3
        let histring .= ' gui=' . a:3 . ' cterm=' . a:3
    else
        let histring .= ' cterm=NONE gui=NONE'
    endif

    " echom histring
    execute histring
endfunction

" normal

call s:HL('Normal', 'wheat', 'onyx')
call s:HL('Identifier', 'wheat')

" shades

call s:HL('PreProc', 'shade1')
call s:HL('Include', 'shade1')
call s:HL('Statement', 'shade1')
call s:HL('Operator', 'shade1')

call s:HL('Type', 'shade2')
call s:HL('StorageClass', 'shade2')
call s:HL('Keyword', 'shade2')
call s:HL('Exception', 'shade2')
call s:HL('Constant', 'shade2')
" call s:HL('Operator', 'shade2')


call s:HL('Function', 'shade3')

call s:HL('Special', 'shade4')

" Accents

call s:HL('String', 'accent1')
call s:HL('Number', 'accent2')

" UI

call s:HL('LineNr', 'darkestwheat')
call s:HL('Visual', 'onyx', 'cyan')
call s:HL('CursorLineNr', 'yellow')

" Folds

call s:HL('Folded', 'cyan', 'lightonyx', 'italic')
call s:HL('FoldColumn', 'onyx', 'cyan', 'italic')

call s:HL('ColorColumn', 'fg', 'lightonyx')
call s:HL('VertSplit', 'lightonyx', 'lightonyx')
call s:HL('SignColumn', 'lightonyx', 'lightonyx')
call s:HL('NonText', 'lighteronyx')
call s:HL('Error', 'red')

call s:HL('StatusLine', 'onyx', 'wheat')
call s:HL('StatusLineNC', 'darkwheat', 'lightonyx')

call s:HL('Search', 'onyx', 'yellow')
call s:HL('SpecialKey', 'red')
call s:HL('Directory', 'blue')

" Menu

call s:HL('WildMenu', 'wheat', 'lightonyx')
call s:HL('Pmenu', 'wheat', 'lightonyx')
call s:HL('PmenuSel', 'onyx', 'blue')

" Misc

call s:HL('Title', 'cyan')
call s:HL('Underlined', 'blue')

" Errors

call s:HL('Error', 'red')
call s:HL('ErrorMsg', 'wheat', 'red')

" Comments

call s:HL('Comment', 'darkerwheat')
call s:HL('Todo', 'yellow', 'lightonyx')

" Coc

call s:HL('CocErrorSign', 'red', 'lightonyx')
call s:HL('CocWarningSign', 'orange', 'lightonyx')
call s:HL('CocInfoSign', 'yellow', 'lightonyx')

" Vim

call s:HL('vimUserFunc', 'shade3')
call s:HL('vimMapRhs', 'shade3')
call s:HL('vimOption', 'shade3')
call s:HL('vimCommentTitle', 'blue')

" JS

call s:HL('jsGlobalObjects', 'shade4')
call s:HL('jsBuiltIns', 'shade4')
call s:HL('jsExceptions', 'shade4')
call s:HL('jsTemplateBraces', 'darkwheat')
call s:HL('jsBooleanTrue', 'accent3')
call s:HL('jsBooleanFalse', 'accent3')
call s:HL('jsNull', 'accent3')
call s:HL('jsOperatorKeyword', 'shade4')
call s:HL('jsObjectKey', 'wheat')

" JSX

call s:HL('jsxComponentName', 'shade3')
call s:HL('jsxTagName', 'shade3')
call s:HL('jsxAttrib', 'shade4')
call s:HL('jsxOpenPunct', 'shade3')
call s:HL('jsxClosePunct', 'shade3')
call s:HL('jsxCloseString', 'shade3')
call s:HL('jsxBraces', 'shade3')

" jsDoc

call s:HL('jsDocTags', 'blue')

" HTML

call s:HL('htmlTagName', 'shade2')
call s:HL('htmlTagN', 'shade2')
call s:HL('htmlEndTag', 'shade3')
call s:HL('htmlArg', 'shade4')

" XML

call s:HL('xmlAttrib', 'shade4')
call s:HL('xmlEqual', 'shade1')

" Diff

call s:HL('DiffDelete', 'onyx', 'red')
call s:HL('DiffAdd', 'onyx', 'green')
call s:HL('DiffChange', 'onyx', 'cyan')
call s:HL('DiffText', 'onyx', 'yellow')

call s:HL('diffRemoved', 'onyx', 'red')
call s:HL('diffAdded', 'onyx', 'green')
call s:HL('diffChanged', 'onyx', 'cyan')
call s:HL('diffLine', 'onyx', 'blue')

" call s:HL('DiffChange', s:aqua, s:bg0, s:inverse)
" call s:HL('DiffText',   s:yellow, s:bg0, s:inverse)

" Python

call s:HL('pythonBoolean', 'accent3')
call s:HL('pythonNone', 'accent3')
call s:HL('pythonDecorator', 'shade1')
call s:HL('pythonStatement', 'shade2')

" Erlang

call s:HL('erlangAttribute', 'shade1')
call s:HL('erlangInclude', 'accent3')
call s:HL('erlangRecord', 'accent2')
call s:HL('erlangMacro', 'shade1')
call s:HL('erlangAtom', 'shade3')
call s:HL('erlangBracket', 'shade3')
call s:HL('erlangLocalFuncCall', 'shade2')
call s:HL('erlangGlobalFuncCall', 'wheat')
call s:HL('erlangVariable', 'wheat')
call s:HL('erlangKeyword', 'shade1')

" FIXME
" CursorColumn
" CursorLine
" DiffChange
" DiffText
" FoldColumn
" ModeMsg
" ModeMsg
" MoreMsg
" CursorLineNr
" MatchParen
" NonText
" Question
" Highlighted directory

