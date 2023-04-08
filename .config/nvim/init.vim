" ------------------------------------------------------------------------------
" Plugins
" ------------------------------------------------------------------------------

call plug#begin()

Plug 'ycm-core/YouCompleteMe'
Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-neo-tree/neo-tree.nvim', { 'tag': 'v2.*' }
Plug 'nvim-lualine/lualine.nvim'
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-commentary'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-unimpaired'
Plug 'pangloss/vim-javascript'
Plug 'editorconfig/editorconfig-vim'
Plug 'dense-analysis/ale'
Plug 'SirVer/ultisnips'
Plug 'dyng/ctrlsf.vim'
Plug 'liuchengxu/vim-which-key'
Plug 'leafgarland/typescript-vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'godlygeek/tabular'
Plug 'tweekmonster/startuptime.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()


" ------------------------------------------------------------------------------
" General settings
" ------------------------------------------------------------------------------

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

nnoremap <C-n> :Neotree toggle<CR>

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

" Buffers
let g:which_key_map.b = {
      \ 'name' : '+buffer',
      \ 'b' : 'find-buffer',
      \ 'l' : 'lines-in-buffers',
      \ 'o' : 'opened-buffers',
      \ }

nnoremap <leader>bb :Buffers<cr>
nnoremap <leader>bl :Lines<cr>
nnoremap <leader>bo :Neotree toggle source=buffers reveal=true position=right<cr>

" Search & Replace
nnoremap <leader>sc :CtrlSFClose<cr>
nnoremap <leader>sf :CtrlSF -filetype
nnoremap <leader>si :Rg<cr>

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
      \ 'i' : 'interactive',
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
nnoremap <leader>gb :Git blame<cr>
nnoremap <leader>gc :Git commit<cr>
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gf :Gfetch<cr>
nnoremap <leader>gh :Gitsigns preview_hunk<cr>
nnoremap <leader>gl :Gclog --<cr>
nnoremap <leader>gp :Git push -u origin HEAD<cr>
nnoremap <leader>gs :vertical Git<cr>
nnoremap <leader>gu :Gitsigns reset_hunk<cr>

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

" Copy file and line number under cursor to system clipboard (+ register)
nnoremap <silent> <leader>cl :let @+ = join([expand('%'), line(".")], ':')<cr>

nnoremap <leader>cm :Marks<cr>

nnoremap <leader>csl :Snippets<cr>
nnoremap <leader>csr :call UltiSnips#RefreshSnippets()<cr>

nnoremap <leader>cr :YcmRestartServer<cr>

let g:which_key_map.c = {
      \ 'name' : '+code',
      \ 'f' : 'fix',
      \ 'l' : 'location',
      \ 'm' : 'marks',
      \ 'r' : 'restart-ycm-server',
      \ }

let g:which_key_map.c.s = {
      \ 'name' : '+snippets',
      \ 'l' : 'list',
      \ 'r' : 'refresh',
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

" Linter
nnoremap <leader>lo :lopen<cr>
nnoremap <leader>lc :lclose<cr>
nnoremap <leader>ln :lnext<cr>
nnoremap <leader>lp :lprevious<cr>

let g:which_key_map.l = {
      \ 'name' : '+linter',
      \ 'c' : 'close-list',
      \ 'n' : 'next-error',
      \ 'o' : 'open-list',
      \ 'p' : 'previous-error',
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

" TODO: use LSPs - tsserver, gopls
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
\   'go': ['gofmt', 'goimports'],
\   'json': ['jq'],
\   'sh': ['shfmt'],
\}

" editorconfig-vim
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" CtrlSF
let g:ctrlsf_default_view_mode = 'compact'

" UltiSnips
let g:UltiSnipsSnippetDirectories=[stdpath('data').'/ultisnips']
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

" YouCompleteMe
" Don't close QuickFix window
autocmd User YcmQuickFixOpened autocmd! ycmquickfix WinLeave

function! s:CustomizeYcmQuickFixWindow()
  10wincmd _
endfunction

autocmd User YcmQuickFixOpened call s:CustomizeYcmQuickFixWindow()

lua <<EOF
require("neo-tree").setup({
  window = {
    width = 30,
    mappings = {
      ["o"] = "open",
    },
  },
  filesystem = {
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = false,
    },
    follow_current_file = true,
    use_libuv_file_watcher = true,
  },
})
require('gitsigns').setup()
require('lualine').setup({
  options = {
    theme = 'solarized_light'
  },
  extensions = {'neo-tree', 'fugitive'},
})
require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
  },
  ensure_installed = {
    'lua',
    'vim',
    'help',
    'javascript',
    'typescript',
    'tsx',
    'css',
    'json',
    'go',
    'dockerfile',
  },
})
EOF
