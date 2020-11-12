set nocompatible
filetype off


" ------------------------------------------------------------------------------
" Plugins
" ------------------------------------------------------------------------------

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'mhinz/vim-signify'
Plugin 'tpope/vim-commentary'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-surround' " TODO: Remove? Don't use it much
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-unimpaired'
Plugin 'pangloss/vim-javascript'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'mattn/emmet-vim' " TODO: Remove? Don't do frontend stuff
Plugin 'dense-analysis/ale'
Plugin 'leafoftree/vim-vue-plugin'
Plugin 'SirVer/ultisnips'
Plugin 'dyng/ctrlsf.vim'
Plugin 'MaxMEllon/vim-jsx-pretty'
Plugin 'liuchengxu/vim-which-key'
Plugin 'leafgarland/typescript-vim'
Plugin 'ianks/vim-tsx'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'christoomey/vim-tmux-runner'

call vundle#end()


" ------------------------------------------------------------------------------
" General settings
" ------------------------------------------------------------------------------

filetype plugin on  " Load filetype-specific plugin files
filetype indent on  " Load filetype-specific indent files
syntax on           " Enable syntax highlighting

set encoding=utf-8

set shiftwidth=2    " Number of spaces to use for each step of (auto)indent
set tabstop=2       " Number of visual spaces per TAB
set expandtab       " Tabs are spaces
set smarttab

set number          " Show line numbers
set relativenumber  " But show them relative to the current line
set hidden          " Allows to switch buffers without saving changes
set autoread        " Auto reload if file saved externally

set hlsearch        " Highlight search terms
set incsearch       " Show search matches as you type
set ignorecase      " Ignore case when searching

set colorcolumn=121 " Ruler at the 121th column
set cursorline      " Highlight current line

set splitbelow
set splitright

set history=1000    " How many commands to store in the history

set undofile        " Enable persistent undo history
set undolevels=1000 " Store up to 1000 undo entries

set wildmenu        " Visual autocomplete for command menu
set lazyredraw      " Redraw only when it is really needed

" Ignore node_modules folders
set wildignore+=*/node_modules/*

" Allow to use Russian keymap in normal mode
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

" Folding
set foldmethod=indent
set foldlevelstart=99 " Start with all the foldings opened

" Where to store backups, swap and undo files
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" Fix for backspace in os x
set backspace=indent,eol,start

" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Don’t show the intro message when starting Vim
set shortmess=atI

" Don't show tabs and trailing whritespaces
set nolist

" Don't show preview window with autocompletion
set completeopt-=preview


" ------------------------------------------------------------------------------
" Status line
" ------------------------------------------------------------------------------

set laststatus=2
set statusline=
set statusline+=%-3.3n\                      " buffer number
set statusline+=%f\                          " filename
set statusline+=%h%m%r%w                     " status flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type
set statusline+=%=                           " right align remainder
set statusline+=0x%-8B                       " character value
set statusline+=%-14(%l,%c%V%)               " line, character
set statusline+=%<%P                         " file position


" ------------------------------------------------------------------------------
" Colors
" ------------------------------------------------------------------------------

set t_Co=256
colorscheme solarized
set bg=light
highlight ColorColumn ctermbg=7
highlight clear SignColumn
highlight CursorLineNr cterm=bold ctermfg=12 ctermbg=7


" ------------------------------------------------------------------------------
" Common mappings
" ------------------------------------------------------------------------------

:command WQ wq
:command Wq wq
:command W w
:command Q q
:command Qa qa

nnoremap <C-n> :NERDTreeToggle<CR>

" Disable arrow keys
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Hide search highlighting
nmap <silent> <BS> :noh<CR>

" Bye bye ex mode
nnoremap Q <nop>

" Highlight last inserted text
nnoremap gV `[v`]

" Write with sudo
cnoremap w!! w !sudo tee % >/dev/null


" ------------------------------------------------------------------------------
" Leader-based mappings
" ------------------------------------------------------------------------------

" Colors
augroup vim-which-key-colors
  autocmd!

  autocmd FileType which_key highlight WhichKey ctermbg=7 ctermfg=11
  autocmd FileType which_key highlight WhichKeySeperator ctermbg=7 ctermfg=11
  autocmd FileType which_key highlight WhichKeyGroup cterm=bold ctermbg=7 ctermfg=11
  autocmd FileType which_key highlight WhichKeyDesc ctermbg=7 ctermfg=11
augroup END

let g:which_key_map = {}

" File operations
let g:which_key_map.f = {
      \ 'name' : '+file',
      \ 'a' : 'find-all-files',
      \ 'd' : 'open-vimrc',
      \ 'f' : 'find-file',
      \ 'h' : 'history',
      \ 'm' : 'most-recent',
      \ 'r' : 'reveal-in-tree',
      \ 't' : 'toggle-tree',
      \ }

nnoremap <leader>fa :Files<cr>
nnoremap <leader>fd :e ~/.vimrc<cr>
nnoremap <leader>ff :GFiles<cr>
nnoremap <leader>fh :History<cr>
nnoremap <leader>fr :NERDTreeFind<cr>
nnoremap <leader>ft :NERDTreeToggle<cr>

" Buffers
let g:which_key_map.b = {
      \ 'name' : '+buffer',
      \ 'b' : 'find-buffer',
      \ 'l' : 'lines-in-buffers',
      \ }

nnoremap <leader>bb :Buffers<cr>
nnoremap <leader>bl :Lines<cr>

" Search & Replace
nnoremap <leader>sc :CtrlSFClose<cr>
nnoremap <leader>sf :CtrlSF -filetype

nnoremap <leader>smf :CtrlSF "FIXME:"<cr>
nnoremap <leader>smn :CtrlSF "NOTE:"<cr>
nnoremap <leader>smt :CtrlSF "TODO:"<cr>

nnoremap <leader>so :CtrlSFOpen<cr>
nnoremap <leader>sp :CtrlSF -R ""<left>
nnoremap <leader>sr :.,$s/\<<C-r><C-w>\>//gc<left><left><left>
nnoremap <leader>ss :CtrlSF ""<left>
nnoremap <leader>su :CtrlSFUpdate<cr>
nnoremap <leader>sw :CtrlSF -W "<C-r><C-w>"

let g:which_key_map.s = {
      \ 'name' : '+search',
      \ 'c' : 'close-window',
      \ 'f' : 'filetype',
      \ 'o' : 'open-window',
      \ 'p' : 'pattern',
      \ 'r' : 'replace-word',
      \ 's' : 'search',
      \ 'u' : 'update-search',
      \ 'w' : 'search-word',
      \ }

let g:which_key_map.s.m = {
      \ 'name' : '+marks',
      \ 'f' : 'FIXME',
      \ 'n' : 'NOTE',
      \ 't' : 'TODO',
      \}

" Git
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gf :Gfetch<cr>
nnoremap <leader>gh :SignifyHunkDiff<cr>
nnoremap <leader>gl :Glog --<cr>
nnoremap <leader>gp :Gpush -u origin HEAD<cr>
nnoremap <leader>gs :vertical Gstatus<cr>
nnoremap <leader>gu :SignifyHunkUndo<cr>

let g:which_key_map.g = {
      \ 'name' : '+git',
      \ 'b' : 'blame',
      \ 'c' : 'commit',
      \ 'd' : 'diff',
      \ 'f' : 'fetch',
      \ 'h' : 'hunk-diff',
      \ 'l' : 'log',
      \ 'p' : 'push',
      \ 's' : 'status',
      \ 'u' : 'undo-hunk',
      \ }

" Working with references
nnoremap <leader>rd :YcmCompleter GetDoc<cr>
nnoremap <leader>rf :YcmCompleter FixIt<cr>
nnoremap <leader>rg :YcmCompleter GoToDefinition<cr>
nnoremap <leader>ri :YcmCompleter GoToType<cr>
nnoremap <leader>rr :YcmCompleter RefactorRename <C-r><C-w>
nnoremap <leader>rt :YcmCompleter GetType<cr>
nnoremap <leader>ru :YcmCompleter GoToReferences<cr>
nnoremap <leader>rv :vsplit \| YcmCompleter GoToDefinition<cr>
nnoremap <leader>rb :tab split \| YcmCompleter GoToDefinition<cr>

" TODO: custom wrapper for ycm:
" - close search window
" - call ycm

let g:which_key_map.r = {
      \ 'name' : '+reference',
      \ 'd' : 'doc',
      \ 'f' : 'fix-it',
      \ 'g' : 'go-to-definition',
      \ 'i' : 'go-to-type',
      \ 'r' : 'rename',
      \ 't' : 'get-type',
      \ 'u' : 'show-usages',
      \ 'v' : 'go-to-vsplit',
      \ }

" Other code-related actions
nnoremap <leader>cf :ALEFix<cr>
nnoremap <leader>cm :Marks<cr>
nnoremap <leader>cs :Snippets<cr>
nnoremap <leader>cr :YcmRestartServer<cr>
" TODO: :call UltiSnips#RefreshSnippets()

let g:which_key_map.c = {
      \ 'name' : '+code',
      \ 'f' : 'fix',
      \ 'm' : 'marks',
      \ 's' : 'snippets',
      \ 'r' : 'restart-ycm-server',
      \ }

" Window-related commands
nnoremap <leader>wo :call MyWindowCodeOnly()<cr>
nnoremap <leader>wz :wincmd _<cr>:wincmd \|<cr>

let g:which_key_map.w = {
      \ 'name' : '+window',
      \ 'o' : 'only-code',
      \ 'z' : 'zoom',
      \ }

" Tmux interactions
" TODO: add more https://github.com/christoomey/vim-tmux-runner/blob/master/doc/vim-tmux-runner.txt
nnoremap <leader>ta :VtrAttachToPane<cr>
nnoremap <leader>tf :VtrSendFile!<cr>
nnoremap <leader>to :VtrOpenRunner<cr>

let g:which_key_map.t = {
      \ 'name' : '+tmux',
      \ 'a' : 'attach-to-pane',
      \ 'f' : 'send-file',
      \ 'o' : 'open-runner',
      \ }

" Plugin setup
call which_key#register('\', "g:which_key_map")
nnoremap <silent> <leader> :<c-u>WhichKey '\'<CR>


" ------------------------------------------------------------------------------
" Autogroups
" ------------------------------------------------------------------------------

augroup configgroup
  autocmd!

  " Trim whitespaces on save
  autocmd BufWritePre * :%s/\s\+$//e

  " Disable automatic comment insertion
  autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

  " Enable Emmet only for specific files
  autocmd FileType html,vue,javascript EmmetInstall
augroup END

augroup custom_functions
  autocmd!

  function MyGoToReferences()
    execute "CtrlSFClose"
    execute "YcmCompleter GoToReferences"
  endfunction

  function MyWindowCodeOnly()
    " Close windows that don't contain code itself
    " i.e. QuickFix window, CtrlSF search result
    execute "cclose"
    execute "CtrlSFClose"
  endfunction
augroup END


" ------------------------------------------------------------------------------
" Settings for plugins
" ------------------------------------------------------------------------------

" vim-airline theme settings
let g:airline_theme = 'solarized'
let g:airline_left_sep=''
let g:airline_right_sep=''

" No lag when leaving insert mode with vim-airline plugin activated
set ttimeoutlen=50

" ALE
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'

highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow

" Only enable linters specified by ale_linters map
let g:ale_linters_explicit = 1

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['tslint', 'eslint'],
\   'typescript.tsx': ['tslint', 'eslint'],
\   'vue': ['eslint'],
\   'json': ['jsonlint'],
\   'go': ['go vet'],
\}

let g:ale_fixers = {
\   'javascript': ['prettier', 'eslint'],
\   'typescript': ['prettier', 'tslint'],
\   'typescript.tsx': ['prettier', 'tslint'],
\   'vue': ['eslint'],
\   'html': ['prettier'],
\   'go': ['gofmt'],
\   'json': ['jq'],
\}

" editorconfig-vim
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" emmet-vim
let g:user_emmet_install_global = 0

" NERDTree
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 1

" CtrlSF
let g:ctrlsf_default_view_mode = 'compact'

" UltiSnips
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/ultisnips']
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

" vim-tmux-runner
let g:VtrOrientation = "h"
let g:VtrPercentage = 40

let g:vtr_filetype_runner_overrides = {
      \ 'rust': 'rustc {file}',
      \ 'typescript': '~/Dropbox/df/bin/tmux-exec-file.sh {file}',
      \ 'javascript': '~/Dropbox/df/bin/tmux-exec-file.sh {file}',
      \ 'go': '~/Dropbox/df/bin/tmux-exec-file.sh {file}',
      \ }

" YouCompleteMe
" Don't close QuickFix window
autocmd User YcmQuickFixOpened autocmd! ycmquickfix WinLeave
