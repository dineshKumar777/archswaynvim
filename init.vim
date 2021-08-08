" https://old.reddit.com/r/neovim/comments/oqr2t8/how_to_prevent_tutorvim_and_zippluginvim_from/h6egptx/
" Disable default plugins
let g:loaded_2html_plugin = 1
let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_gzip = 1
let g:loaded_matchparen = 1
let g:loaded_rrhelper = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1


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

" Mapping to move lines
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" http://vimcasts.org/episodes/neovim-terminal-mappings/
tnoremap <Esc> <C-\><C-n>

" https://superuser.com/a/271024
set formatoptions-=cro " Disable autoinsert of comments on nextline

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

" https://dmerej.info/blog/post/vim-cwd-and-neovim/
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
call plug#begin('~/.config/nvim/plugged')
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'deathlyfrantic/vim-distill'
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
Plug 'akinsho/nvim-toggleterm.lua'
Plug 'abecodes/tabout.nvim'
Plug 'romainl/vim-cool' " turn off hlsearch when done
Plug 'karb94/neoscroll.nvim'
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
require('_autopairs')
require('_formatter')
require('_toggleterm')
require('_tabout')
require('_neoscroll')
require('mkdir') -- this is for plugin load
EOF

" Chsarp autoformat on filesave. Have to find replacement using formatter
" plugin
autocmd BufWritePre *.cs lua vim.lsp.buf.formatting_sync(nil,100)

" Execute c# code in cmd on keypress
nnoremap <F8> <cmd>TermExec cmd='dotnet run'<CR>
