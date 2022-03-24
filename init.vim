"  plugins via vim-plug
call plug#begin('~/.local/share/nvim/plugged') " vim-plug syntax

" /////////////////////////////////

Plug 'sheerun/vim-polyglot'            " syntax highlighting for over 100 programming languages
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " treesitter para hacer syntax highlighting mejorado

Plug 'dense-analysis/ale'              " syntax linting to check errors with Language Server Protocol (LSP) support

" autocomplete via Conquer of Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}  " plugin for manage autocompletion for different languages, load extensions like VSCode and host language servers.

" /////////////////////////////////
" Plugins to improve user experience (the goal is VIM as a fully fledged IDE)
Plug 'Chiel92/vim-autoformat'  " Format code with one button press (or automatically on save).

Plug 'jiangmiao/auto-pairs'  " Plugin to automatically include final enclosing symbol with any starting one

Plug 'tpope/vim-surround'              " Plugin to easily modify brackets

Plug 'alvan/vim-closetag'  " Similar to autopairs but for html-style tags

Plug 'scrooloose/nerdtree'             " File explorer within nvim

Plug 'Yggdroot/indentLine'            " Muestra los niveles de indentación con lineas verticales 

Plug 'joshdick/onedark.vim'            " color theme inspired in atom

" /////////////////////////////////
" live coding
Plug 'tidalcycles/vim-tidal'           " plugin to run tidal within nvim
Plug 'suzanje/foxdot-nvim'             " run FoxDot in vim

" arduino
Plug 'stevearc/vim-arduino'            " Plugin to compile, debug and upload arduino sketches

" processing
Plug 'sophacles/vim-processing'        " Plugin para crear y ejecutar sketches de processin en vim 

" openscad
Plug 'salkin-mada/openscad.nvim'             " Plugin para sintaxis y ejecución de scripts openscad

"LATEX AND VIM
Plug 'lervag/vimtex' " Plugins to compile latex projects with vim

"Dart/Flutter
Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'
Plug 'natebosch/vim-lsc'
Plug 'natebosch/vim-lsc-dart'


call plug#end()

" ////////////////////////////////////////////////////////////
        " plugin-based configurations
" ////////////////////////////////////////////////////////////
set nocompatible                       " Not compatible with vi

filetype plugin on                     " Plugins are habilitated

"tidal cycles
let g:tidal_target = "terminal"        " This config is to run from terminal

" colorscheme
set termguicolors                      " Activate true colors in terminal
colorscheme onedark                    " Change colorscheme.

" NerdTree
let g:NerdTreeChDirMode=2              " Change current directory to father node
map <F3> :NERDTreeToggle<CR>           " Open/close NerdTree with F3

" indentLine
" No mostrar en ciertos tipos de buffers y archivos
let g:indentLine_fileTypeExclude = ['text', 'sh', 'help', 'terminal']
let g:indentLine_bufNameExclude = ['NERD_tree.*', 'term:.*']

        " configurations from the book Osipov, Mastering Vim.
syntax on                       " Enable syntax highlighting
filetype plugin indent on       " Enable file type based indentation

set autoindent                  " Respect indentation when starting a new line
set expandtab                   " Expand tabs to spaces. Essential in Python.
set tabstop=4                   " Number of spaces tab is counted for.
set shiftwidth=4                " Number of spaces to use for autoindent

set backspace=2                 " Fix backspaces behaviour on most terminals

set nu                  " Agrega numeración a las lineas de texto

set tw=80           "  Automatic word wrapping by number of characters 

" ////////////////////////////////////////////////////////////
"                            CONQUEROR OF COMPLETION
"                        Make your vim as smart as VSCode
" ////////////////////////////////////////////////////////////
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

autocmd FileType python let b:coc_root_patterns = ['.git','.env']
set sessionoptions +=globals

" ////////////////////////////////////////////////////////////
"                  NVIM - LATEX CONFIGURATION
"               Dabbling with latex to improve my CV
" ////////////////////////////////////////////////////////////
" " This is necessary for VimTeX to load properly. The 'indent' is optional.
" Note that most plugin managers will do this automatically.
filetype plugin indent on

" This enables Vim's and neovim's syntax-related features. Without this, some
" VimTeX features will not work (see ':help vimtex-requirements' for more
" info).
syntax enable

" Viewer options: One may configure the viewer either by specifying a built-in
" viewer method:
let g:vimtex_view_method = 'mupdf'

" Or with a generic interface:
let g:vimtex_view_general_viewer = 'okular'
"let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

" VimTeX uses latexmk as the default compiler backend. If you use it, which is
" strongly recommended, you probably don't need to configure anything. If you
" want another compiler backend, you can change it as follows. The list of
" supported backends and further explanation is provided in the documentation,
" see ':help vimtex-compiler'.

let g:vimtex_compiler_method = 'latexmk'
"
let g:vimtex_compiler_latexmk = { 
        \ 'executable' : 'latexmk',
        \ 'options' : [ 
        \   '-xelatex',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
        \ ],
        \}

"let g:vimtex_compiler_latexmk_engines = '-pdf -pdflatex="texexec --xtx"'
"{
"     '_'                : '-pdf',
"     'pdfdvi'           : '-pdfdvi',
"     'pdfps'            : '-pdfps',
"     'pdflatex'         : '-pdf',
"     'luatex'           : '-lualatex',
"     'lualatex'         : '-lualatex',
"     'xelatex'          : '-xelatex',
"     'context (pdftex)' : '-pdf -pdflatex=texexec',
"     'context (luatex)' : '-pdf -pdflatex=context',
"     'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
"    }

" Most VimTeX mappings rely on localleader and this can be changed with the
" following line. The default is usually fine and is the symbol '\'.
let maplocalleader = '\'

" ////////////////////////////////////////////////////////////
"             folding better CONFIGURATION
"    plegamiento customizado permite ver el bigger picture
"    setlocal foldmethod=indent

set nofoldenable
set foldlevel=99
set fillchars=fold:\
set foldtext=CustomFoldText()
setlocal foldmethod=expr
setlocal foldexpr=GetPotionFold(v:lnum)
function! GetPotionFold(lnum)
  if getline(a:lnum) =~? '\v^\s*$'
    return '-1'
  endif
  let this_indent = IndentLevel(a:lnum)
  let next_indent = IndentLevel(NextNonBlankLine(a:lnum))
  if next_indent == this_indent
    return this_indent
  elseif next_indent < this_indent
    return this_indent
  elseif next_indent > this_indent
    return '>' . next_indent
  endif
endfunction
function! IndentLevel(lnum)
    return indent(a:lnum) / &shiftwidth
endfunction
function! NextNonBlankLine(lnum)
  let numlines = line('$')
  let current = a:lnum + 1
  while current <= numlines
      if getline(current) =~? '\v\S'
          return current
      endif
      let current += 1
  endwhile
  return -2
endfunction
function! CustomFoldText()
  " get first non-blank line
  let fs = v:foldstart
  while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
  endwhile
  if fs > v:foldend
      let line = getline(v:foldstart)
  else
      let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
  endif
  let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
  let foldSize = 1 + v:foldend - v:foldstart
  let foldSizeStr = " " . foldSize . " lines "
  let foldLevelStr = repeat("+--", v:foldlevel)
  let expansionString = repeat(" ", w - strwidth(foldSizeStr.line.foldLevelStr))
  return line . expansionString . foldSizeStr . foldLevelStr
endfunction
" ////////////////////////////////////////////////////
" ////////////////////////////////////////////////////////////
"             some fancy package CONFIGURATION
"                 What is this shit for?
" ////////////////////////////////////////////////////////////
