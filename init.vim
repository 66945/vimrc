" set rtp+=C:/Users/Owner/vimfiles/bundle/Vundle.vim

call plug#begin('~/vimfiles/plugged')
" visual modification
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'enricobacis/vim-airline-clock'
Plug 'folke/todo-comments.nvim'
Plug 'folke/twilight.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
" themes
Plug 'gruvbox-community/gruvbox'
Plug 'https://gitlab.com/madyanov/gruber.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'catppuccin/nvim'
" file navigation
Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" movement
Plug 'ggandor/leap.nvim'
" language support
Plug 'nvim-treesitter/nvim-treesitter'

Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer' " literally never use
Plug 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'
Plug 'mfussenegger/nvim-jdtls' " literally never use
Plug 'Tetralux/odin.vim'

" NOTE: semantic highlighting will exist by default in
" neovim 0.9. this is just a getaround until then
Plug 'theHamsta/nvim-semantic-tokens' " referenced in my config code, but don't really use

Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'leoluz/nvim-dap-go'
Plug 'mxsdev/nvim-dap-vscode-js' " literally never use
" autocomplete
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'onsails/lspkind.nvim'
" wakatime
Plug 'wakatime/vim-wakatime'
call plug#end()

set encoding=UTF-8
let mapleader=" "

set completeopt=menu,menuone,noselect

set termguicolors
set number relativenumber
set noshowmode
set cursorline

set scrolloff=3

" let g:airline_theme = 'gruvbox'
let g:gruvbox_contrast_dark = 'hard'
let g:gruber_contrast_dark = 'hard'
let g:everforest_background = 'hard'
let g:gruvbox_sign_column = 'bg0'
let g:gruvbox_cursorline = 'dark0_cursor'
let g:gruvbox_italic=1
let g:gruvbox_italicize_comments=1
let g:gruvbox_background = 'black'
let g:gruber_italic=1
let g:gruber_italicize_comments=1

let g:airline_powerline_fonts=1
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

let g:airline_left_sep = '' " ''
let g:airline_left_alt_sep = '' " ''
let g:airline_right_sep = '' " ''
let g:airline_right_alt_sep = '' " ''
" let g:airline_symbols.branch = ''
" let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = ''

hi Normal guibg=NONE ctermbg=NONE
colorscheme gruvbox
" colorscheme catppuccin
" hi SignColumn guibg=black

augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
	autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
	autocmd TermOpen * setlocal nonumber nornu
augroup END

augroup CursorLine
	au!
	au!VimEnter,WinEnter,BufWinEnter * setlocal cursorline
	au!WinLeave * setlocal nocursorline
augroup END

set tabstop=4
set shiftwidth=4

:command FRCDeploy !gradlew deploy<CR><CR>
:command FRCSim !gradlew simulateJava<CR><CR>

autocmd BufReadPost,FileReadPost * normal zR

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

noremap <C-c> <C-l>

" CodeWars remaps
noremap <C-C> "*y
noremap <C-y> ggVG"*y

nmap Te <C-w>s<C-w>j :term<CR>i
tnoremap <Esc> <C-\><C-n>
tnoremap <C-c> <C-c><Esc>

" set shell=bash

nmap nt :NvimTreeToggle<CR>
nmap vrc :tabedit $MYVIMRC<CR>
nmap <leader>ff <cmd>Telescope find_files<CR>
nmap <leader>fs <C-w>v<C-l><cmd>Telescope find_files<CR>
nmap <leader>fg <cmd>Telescope live_grep<CR>
nmap <leader>fb <cmd>Telescope buffers<CR>
nmap <leader>fh <cmd>Telescope help_tags<CR>

nmap <leader>t <cmd>Twilight<CR>

nmap <leader>ll <cmd>lua require 'lsp_lines'.toggle()<CR><cmd>lua vim.diagnostic.config({virtual_text = false,})<CR>
nmap <leader>lo <cmd>lua require 'lsp_lines'.toggle()<CR><cmd>lua vim.diagnostic.config({virtual_text = true,})<CR>

lua require 'mcgrath'
