""""""""""""""""""""""""""""""""""""""""""""""""
" 	DEFAULT SETTINGS FOR ME
""""""""""""""""""""""""""""""""""""""""""""""""
set number
set title
set mouse=a
set hidden
set lazyredraw
set updatetime=250
set scrolloff=5
set history=100
set nowrap

set encoding=utf-8
set clipboard+=unnamedplus

if(has("termguicolors"))
  set termguicolors
endif

" Indents
set tabstop=2 shiftwidth=2
set smarttab smartindent autoindent

set nobackup noswapfile noundofile
set ignorecase smartcase hlsearch incsearch
set splitbelow splitright
set shortmess+=c

" Format document and go back to orginal line
map <F7> gg=G<C-o>

"Auto source vimrc when saved
autocmd! bufwritepost $MYVIMRC source $MYVIMRC

let mapleader=" "
nnoremap <leader>s <cmd>write<CR>
nnoremap <leader>q <cmd>quit<CR>
nnoremap <leader>x <cmd>:qa!<CR>
nnoremap <silent> <leader>ev <cmd>:tabnew $MYVIMRC<CR>
nnoremap <leader><leader> <cmd>:b#<CR>

nnoremap ; :
vnoremap ; :

" Move between windows
nmap <up> <C-w><up>
nmap <down> <C-w><down>
nmap <left> <C-w><left>
nmap <right> <C-w><right>

""""""""""""""""""""""""""""""""""""""""""""""""""""
" Neovide requires guifont settings
set guifont=Envy\ Code\ R:h10
" set guifont=Jetbrains\ Mono:h12

" Paste non-linewise text above or below current cursor,
" see https://stackoverflow.com/a/1346777/6064933
nnoremap <leader>p m`o<ESC>p``
nnoremap <leader>P m`O<ESC>p``

""""""""""""""""""""""""""""""""""""""""""""""""
" 	UTILTIES AUTOCOMMANDS
""""""""""""""""""""""""""""""""""""""""""""""""
" https://gist.github.com/jdhao/d592ba03a8862628f31cba5144ea04c2

" Do not use smart case in commandline mode
augroup dynamic_smartcase
  autocmd!
  autocmd CmdLineEnter : set nosmartcase
  autocmd CmdLineLeave : set smartcase
augroup END

" Term settings
augroup term_settings
  autocmd!
  autocmd TermOpen * setlocal norelativenumber nonumber
  autocmd TermOpen * startinsert
augroup END

" Display msg when the current file is not in UTF-8 format
augroup non_utf8_file_warn
  autocmd!
  autocmd BufRead * if &fileencoding != 'utf-8'
          \ | unsilent echomsg 'File not in UTF-8 format!' | endif
augroup END

" https://stackoverflow.com/a/3879737
" Create command alias safely
fun! Cabbrev(from, to)
	exec 'cnoreabbrev <expr> '.a:from
				\ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
				\ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun

" https://stackoverflow.com/a/5703164
fun! HasColorscheme(name) abort
	let l:pat = printf('colors/%s.vim', a:name)
	return !empty(globpath(&runtimepath, l:pat))
endfun

"https://dmerej.info/blog/post/vim-cwd-and-neovim/
function! OnTabEnter(path)
  if isdirectory(a:path)
    let dirname = a:path
  else
    let dirname = fnamemodify(a:path, ":h")
  endif
  execute "tcd ". dirname
endfunction()

autocmd TabNewEntered * call OnTabEnter(expand("<amatch>"))
""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""
" 	PLUGINS
""""""""""""""""""""""""""""""""""""""""""""""""
" call plug#begin('~/.local/share/nvim/plugged')
call plug#begin('~/.config/nvim/plugged')
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'deathlyfrantic/vim-distill'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'jghauser/mkdir.nvim'
Plug 'b3nj5m1n/kommentary'
Plug 'szw/vim-maximizer'
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'hrsh7th/nvim-compe'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'rhysd/clever-f.vim'
Plug 'phaazon/hop.nvim'
Plug 'mboughaba/i3config.vim'
Plug 'windwp/nvim-autopairs'
Plug 'norcalli/snippets.nvim'
Plug 'mhartington/formatter.nvim'
" Plug 'lewis6991/gitsigns.nvim'
" nvim-toggleterm is optional
call plug#end()

" Use Shortnames for common vimplug to reduce typing
let g:plug_window='new' " Open plug window horizontally
call Cabbrev('pi', 'PlugInstall')
call Cabbrev('pud', 'PlugUpdate')
call Cabbrev('pug', 'PlugUpgrade')
call Cabbrev('ps', 'PlugStatus')
call Cabbrev('pc', 'PlugClean')

" Default mappings with plugins
" maximizer => f3
" kommentry => gcc

set background=dark
colorscheme distill

"Clever-f conig
let g:clever_f_across_no_line=1
let g:clever_f_smart_case=1
let g:clever_f_fix_key_direction=1

lua << EOF
require('_lsp')
require('_treesitter')
require('_completion')
require('_telescope')
require('_hop')
--require('_gitsigns')
require('_autopairs')
require('_formatter')
require('mkdir') -- this is for plugin load
EOF
