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

let s:theme.accent1 = 'a7c957'
let s:theme.accent2 = 'f18e5e'
let s:theme.accent3 = 'd48190'

let s:theme.green = '9cbf50'
let s:theme.red = 'e84231'
let s:theme.orange = 'e8aa58'
let s:theme.yellow = 'ffd166'
let s:theme.cyan = '74b0a8'
let s:theme.blue = '57afde'
let s:theme.indigo = '57afde'
let s:theme.magenta = 'e657a1'
let s:theme.purple = 'a186ad'

" Scheme variations

if exists('g:lore_mode')
    if g:lore_mode == 'harmony'
        let s:theme.shade2 = 'f5696f'
        " let s:theme.shade3 = 'f7a877'
    elseif g:lore_mode == 'suave'
        let s:theme.shade2 = 'fa5555'
    elseif g:lore_mode == 'brown'
        let s:theme.shade2 = 'c5917e'
    elseif g:lore_mode == 'crisp'
        let s:theme.shade2 = 'fc5e03'
    elseif g:lore_mode == 'soft'
        let s:theme.shade2 = 'fc7303'
        let s:theme.shade2 = 'fc8003'
    elseif g:lore_mode == 'alt'
        let s:theme.shade2 = 'ED4A6B'
    endif
endif

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

if exists('g:lore_respect_terminal_bg') && g:lore_respect_terminal_bg
    call s:HL('Normal', 'wheat')
else
    call s:HL('Normal', 'wheat', 'onyx')
endif
call s:HL('Identifier', 'wheat')

" shades

call s:HL('PreProc', 'shade1')
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
call s:HL('Include', 'accent3')

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

call s:HL('Error', 'wheat', 'red')
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

" TypeScript

call s:HL('typescriptVariable', 'shade2')
call s:HL('typescriptAssign', 'shade1')
call s:HL('typescriptObjectLabel', 'wheat')
call s:HL('typescriptBoolean', 'accent3')
call s:HL('typescriptNull', 'accent3')
call s:HL('typescriptBraces', 'wheat')
call s:HL('typescriptCall', 'wheat')
call s:HL('typescriptDestructureVariable', 'wheat')
call s:HL('typescriptDestructureLabel', 'wheat')

" jsDoc

call s:HL('jsDocTags', 'blue')


" jsDoc

call s:HL('jsDocTags', 'blue')

" HTML

call s:HL('htmlTagName', 'shade3')
call s:HL('htmlTagN', 'shade3')
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

" Python

call s:HL('pythonBoolean', 'accent3')
call s:HL('pythonNone', 'accent3')
call s:HL('pythonDecorator', 'shade1')
call s:HL('pythonStatement', 'shade2')
call s:HL('pythonExClass', 'wheat')
call s:HL('pythonClass', 'shade3')
call s:HL('pythonException', 'shade1')
call s:HL('pythonClassVar', 'shade4')

" Django

call s:HL('djangoTagBlock', 'shade3')
call s:HL('djangoArgument', 'shade4')
call s:HL('djangoStatement', 'shade2')

" Rust

call s:HL('rustSelf', 'shade4')
call s:HL('rustMacro', 'accent3')
call s:HL('rustEnumVariant', 'shade4')
call s:HL('rustSigil', 'shade1')
call s:HL('rustKeyword', 'shade2')
call s:HL('rustModPath', 'shade4')
call s:HL('rustModPathSep', 'accent2')
call s:HL('rustStorage', 'shade2')
call s:HL('rustBoolean', 'accent3')
call s:HL('rustDeriveTrait', 'accent3')
call s:HL('rustAssert', 'accent3')

" Haskell

call s:HL('haskellType', 'shade4')
call s:HL('haskellKeyword', 'shade3')
call s:HL('haskellIdentifier', 'accent2')

" Erlang

call s:HL('erlangAttribute', 'shade1')
call s:HL('erlangLocalFuncCall', 'shade3')
call s:HL('erlangGlobalFuncCall', 'shade4')
call s:HL('erlangBIF', 'shade4')

call s:HL('erlangInclude', 'shade1')
call s:HL('erlangRecord', 'accent2')
call s:HL('erlangMacro', 'shade1')
call s:HL('erlangBracket', 'wheat')
call s:HL('erlangVariable', 'wheat')
call s:HL('erlangKeyword', 'shade1')
call s:HL('erlangType', 'shade2')
call s:HL('erlangBoolean', 'accent2')
call s:HL('erlangAtom', 'accent2')

" CSS

call s:HL('cssPositioningProp', 'wheat')
call s:HL('cssMediaProp', 'wheat')
call s:HL('cssBackgroundProp', 'wheat')
call s:HL('cssColorProp', 'wheat')
call s:HL('cssTextProp', 'wheat')
call s:HL('cssBoxProp', 'wheat')
call s:HL('cssFlexibleBoxProp', 'wheat')
call s:HL('cssBorderProp', 'wheat')
call s:HL('cssFontProp', 'wheat')
call s:HL('cssUIProp', 'wheat')
call s:HL('cssPageProp', 'wheat')
call s:HL('cssListProp', 'wheat')
call s:HL('cssGeneratedContentProp', 'wheat')
call s:HL('cssTableProp', 'wheat')
call s:HL('cssTransitionProp', 'wheat')
call s:HL('cssTransformProp', 'wheat')
call s:HL('cssGridProp', 'wheat')
call s:HL('cssMultiColumnProp', 'wheat')
call s:HL('cssInteractProp', 'wheat')

call s:HL('cssPositioningAttr', 'shade4')
call s:HL('cssMediaAttr', 'shade4')
call s:HL('cssBackgroundAttr', 'shade4')
call s:HL('cssColorAttr', 'shade4')
call s:HL('cssTextAttr', 'shade4')
call s:HL('cssBoxAttr', 'shade4')
call s:HL('cssFlexibleBoxAttr', 'shade4')
call s:HL('cssBorderAttr', 'shade4')
call s:HL('cssFontAttr', 'shade4')
call s:HL('cssUIAttr', 'shade4')
call s:HL('cssPageAttr', 'shade4')
call s:HL('cssCommonAttr', 'shade4')
call s:HL('cssListAttr', 'shade4')
call s:HL('cssGeneratedContentAttr', 'shade4')
call s:HL('cssTableAttr', 'shade4')
call s:HL('cssTransitionAttr', 'shade4')
call s:HL('cssTransformAttr', 'shade4')
call s:HL('cssMultiColumnAttr', 'shade4')
call s:HL('cssGridAttr', 'shade4')
call s:HL('cssMultiColumnAttr', 'shade4')
call s:HL('cssInteractAttr', 'shade4')

call s:HL('cssPseudoClassId', 'accent3')

call s:HL('cssBraces', 'wheat')

call s:HL('scssSelectorName', 'shade3')
call s:HL('scssVariable', 'shade4')
call s:HL('scssAmpersand', 'shade1')

" Vim wiki

call s:HL('VimwikiHeader1', 'shade3')

" FIXME
" ModeMsg
" MoreMsg
" NonText
" Question
" CursorColumn
" CursorLine
