set rtp+=C:/Users/Owner/vimfiles/bundle/Vundle.vim

call vundle#begin()
" visual modification
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'folke/todo-comments.nvim'
Plugin 'lukas-reineke/indent-blankline.nvim'
Plugin 'ryanoasis/vim-devicons'
Plugin 'kyazdani42/nvim-web-devicons'
" themes
Plugin 'phanviet/vim-monokai-pro'
Plugin 'shaunsingh/nord.nvim'
Plugin 'gruvbox-community/gruvbox'
" file navigation
Plugin 'kyazdani42/nvim-tree.lua'
Plugin 'nvim-lua/plenary.nvim'
Plugin 'nvim-telescope/telescope.nvim'
" language support
Plugin 'nvim-treesitter/nvim-treesitter'
Plugin 'stevearc/aerial.nvim'

Plugin 'neovim/nvim-lspconfig'
Plugin 'williamboman/nvim-lsp-installer'
Plugin 'mfussenegger/nvim-jdtls'

Plugin 'mfussenegger/nvim-dap'
Plugin 'rcarriga/nvim-dap-ui'
" autocomplete
Plugin 'hrsh7th/cmp-nvim-lsp'
Plugin 'hrsh7th/nvim-cmp'
Plugin 'L3MON4D3/LuaSnip'
Plugin 'saadparwaiz1/cmp_luasnip'
call vundle#end()

let mapleader=" "

set completeopt=menu,menuone,noselect

set termguicolors
set number relativenumber
set noshowmode
set cursorline

set scrolloff=3

let g:airline_theme='bubblegum'
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox

hi Normal guibg=NONE ctermbg=NONE

augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
	autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
	autocmd TermOpen * setlocal nonumber nornu
augroup END

augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
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

nmap Te <C-w>s<C-w>j :term<CR>i
tnoremap <Esc> <C-\><C-n>
tnoremap <C-c> <C-c><Esc>

set shell=bash

nmap nt :NvimTreeToggle<CR>
nmap vrc :tabedit $MYVIMRC<CR>
nmap <leader>ff <cmd>Telescope find_files<CR>
nmap <leader>fg <cmd>Telescope live_grep<CR>
nmap <leader>fb <cmd>Telescope buffers<CR>
nmap <leader>fh <cmd>Telescope help_tags<CR>

lua require 'mcgrath'
