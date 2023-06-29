" ------------------------------------------------------------------------------
" Plugins
" ------------------------------------------------------------------------------

call plug#begin()

Plug 'nvim-lua/plenary.nvim'

" LSP
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'

" Completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" Debugger
Plug 'mfussenegger/nvim-dap'
Plug 'leoluz/nvim-dap-go'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'

Plug 'SirVer/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'

Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-neo-tree/neo-tree.nvim', { 'tag': 'v2.*' }
Plug 'nvim-lualine/lualine.nvim'
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-commentary'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-unimpaired'
Plug 'editorconfig/editorconfig-vim'
Plug 'dense-analysis/ale'
Plug 'dyng/ctrlsf.vim'
Plug 'liuchengxu/vim-which-key'
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

" set t_Co=256
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

" NOTE: see lua config below
" Working with references
" nnoremap <leader>rd :YcmCompleter GetDoc<cr>
" nnoremap <leader>rf :YcmCompleter FixIt<cr>
" nnoremap <leader>rg :YcmCompleter GoToDefinition<cr>
" nnoremap <leader>ri :YcmCompleter GoToType<cr>
" nnoremap <leader>rr :YcmCompleter RefactorRename <C-r><C-w>
" nnoremap <leader>rt :YcmCompleter GetType<cr>
" nnoremap <leader>ru :YcmCompleter GoToReferences<cr>
" nnoremap <leader>rv :vsplit \| YcmCompleter GoToDefinition<cr>
" nnoremap <leader>rb :tab split \| YcmCompleter GoToDefinition<cr>

let g:which_key_map.r = {
      \ 'name' : '+reference',
      \ 'd' : 'doc',
      \ 'e' : 'show-diagnostics',
      \ 'f' : 'fix-it',
      \ 'g' : 'go-to-definition',
      \ 'i' : 'list-implementations',
      \ 'r' : 'rename',
      \ 't' : 'go-to-type',
      \ 'u' : 'show-usages',
      \ 'v' : 'go-to-vsplit',
      \ }

" Other code-related actions
nnoremap <leader>cf :ALEFix<cr>
" Copy file and line number under cursor to system clipboard (+ register)
nnoremap <silent> <leader>cl :let @+ = join([expand('%'), line(".")], ':')<cr>
nnoremap <leader>cm :Marks<cr>

let g:which_key_map.c = {
      \ 'name' : '+code',
      \ 'f' : 'fix',
      \ 'l' : 'location',
      \ 'm' : 'marks',
      \ }

nnoremap <leader>csl :Snippets<cr>
nnoremap <leader>csr :call UltiSnips#RefreshSnippets()<cr>

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

" Debugger
nnoremap <leader>db :lua require('dap').toggle_breakpoint()<cr>
nnoremap <leader>dc :lua require('dap').continue()<cr>
nnoremap <leader>ds :lua require('dap').step_over()<cr>
nnoremap <leader>di :lua require('dap').step_into()<cr>
nnoremap <leader>do :lua require('dap').step_out()<cr>
nnoremap <leader>du :lua require('dapui').toggle()<cr>

let g:which_key_map.d = {
      \ 'name' : '+debugger',
      \ 'b' : 'toggle-breakpoint',
      \ 'c' : 'continue',
      \ 's' : 'step-over',
      \ 'i' : 'step-into',
      \ 'o' : 'step-out',
      \ 'u' : 'ui-toggle',
      \ }

" Plugin setup
call which_key#register('\', "g:which_key_map")
nnoremap <silent> <leader> :<c-u>WhichKey '\'<CR>


" ------------------------------------------------------------------------------
" Autogroups
" ------------------------------------------------------------------------------

augroup configgroup
  autocmd!

  " Disable automatic comment insertion
  autocmd BufNewFile,BufRead * setlocal formatoptions-=cro
augroup END

augroup custom_functions
  autocmd!

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

" ALE
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'

highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow

let g:ale_fix_on_save = 1
" LSP is handled by nvim
let g:ale_disable_lsp = 1
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

-- Completion
local cmp = require('cmp')

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),

    ['<Tab>'] = cmp.mapping(function(fallback)
      local col = vim.fn.col('.') - 1

      if cmp.visible() then
        cmp.select_next_item(select_opts)
      elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        fallback()
      else
        cmp.complete()
      end
    end, {'i', 's'}),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item(select_opts)
      else
        fallback()
      end
    end, {'i', 's'}),
  }),
  sources = cmp.config.sources({
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'ultisnips' },
  }, {
    { name = 'buffer' },
  })
})
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
  { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- LSP
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    'gopls',
    'tsserver',
  }
})

local lspconfig = require('lspconfig')
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

local get_servers = require('mason-lspconfig').get_installed_servers
for _, server_name in ipairs(get_servers()) do
  lspconfig[server_name].setup({
    capabilities = lsp_capabilities,
  })
end

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = {buffer = true}
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    bufmap('n', '<leader>rd', '<cmd>lua vim.lsp.buf.hover()<cr>')
    bufmap('n', '<leader>rg', '<cmd>lua vim.lsp.buf.definition()<cr>')
    bufmap('n', '<leader>ri', '<cmd>lua vim.lsp.buf.implementation()<cr>')
    bufmap('n', '<leader>rt', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
    bufmap('n', '<leader>ru', '<cmd>lua vim.lsp.buf.references()<cr>')
    bufmap('n', '<leader>rr', '<cmd>lua vim.lsp.buf.rename()<cr>')
    bufmap('n', '<leader>rf', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    bufmap('n', '<leader>re', '<cmd>lua vim.diagnostic.open_float()<cr>')
  end
})

-- Debugger
local dap, dapui = require("dap"), require("dapui")
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

require('dap-go').setup()
require("nvim-dap-virtual-text").setup()
EOF
