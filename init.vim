call plug#begin('~/vimfiles/plugged')
" visual modification
Plug 'nvim-lualine/lualine.nvim' " must have
Plug 'folke/todo-comments.nvim' " must have
Plug 'folke/twilight.nvim' " maybe
Plug 'lukas-reineke/indent-blankline.nvim' " must have
Plug 'kyazdani42/nvim-web-devicons' " must have
" Plug 'edluffy/hologram.nvim'
" themes
Plug 'n1ghtmare/noirblaze-vim'

" these were for a lua version of my color scheme
" Plug 'tjdevries/colorbuddy.nvim', { 'branch': 'dev' }
" Plug 'jesseleite/nvim-noirbuddy'

" Plug 'https://gitlab.com/madyanov/gruber.vim'  these color plugins are fun
" Plug 'ayu-theme/ayu-vim'                       <---
" Plug 'catppuccin/nvim'                         <---
" Plug 'rebelot/kanagawa.nvim'                   <---
" Plug 'savq/melange-nvim'                       <---
" Plug 'jhlgns/naysayer88.vim'                   <---
" Plug 'gruvbox-community/gruvbox'               <---
" Plug 'sjl/badwolf'

" file navigation
Plug 'kyazdani42/nvim-tree.lua'      " must have
Plug 'nvim-lua/plenary.nvim'         " must have
Plug 'nvim-telescope/telescope.nvim' " must have
" terminal
Plug 'numToStr/FTerm.nvim' " must have
" movement
Plug 'ggandor/leap.nvim' " must have
" language support
Plug 'nvim-treesitter/nvim-treesitter' " must have

Plug 'neovim/nvim-lspconfig' " must have
Plug 'williamboman/mason.nvim', { 'do': ':MasonUpdate' }
Plug 'https://git.sr.ht/~whynothugo/lsp_lines.nvim' " must have
Plug 'mfussenegger/nvim-jdtls'                      " literally never use
Plug 'Tetralux/odin.vim'                            " temporary - until a better treesitter grammar comes along
Plug 'simrat39/symbols-outline.nvim'

Plug 'mfussenegger/nvim-dap' " must have NOTE: it is worth going through heaven and earth to get this working for c at some point
Plug 'rcarriga/nvim-dap-ui'  " must have
Plug 'leoluz/nvim-dap-go'        " literally never use (unless I start using go a lot soon)
Plug 'mxsdev/nvim-dap-vscode-js' " literally never use
" autocomplete
Plug 'hrsh7th/cmp-nvim-lsp'     " must have
Plug 'hrsh7th/nvim-cmp'         " must have
Plug 'L3MON4D3/LuaSnip'         " must have
Plug 'saadparwaiz1/cmp_luasnip' " must have
Plug 'onsails/lspkind.nvim'     " must have
" wakatime
Plug 'wakatime/vim-wakatime' " this one is not that important, but it is nice to track my habits
call plug#end()

set encoding=UTF-8
let mapleader=" "

set completeopt=menu,menuone,noselect

set termguicolors
set number relativenumber
set noshowmode
set cursorline

set scrolloff=3
set laststatus=3

let g:gruvbox_contrast_dark = 'hard'
let g:gruber_contrast_dark = 'hard'
let g:everforest_background = 'hard'
let g:gruvbox_sign_column = 'bg0'
let g:gruvbox_cursorline = 'dark0_cursor'
let g:gruvbox_italic=0
let g:gruvbox_background = 'black'
let g:gruber_italic=0

colorscheme noirblaze
hi Normal guibg=NONE ctermbg=NONE

hi! link NormalFloat Normal

augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
	autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
	autocmd TermOpen * setlocal nonumber nornu
augroup END

augroup CursorLine
	au!
	au!VimEnter,WinEnter,BufWinEnter * setlocal cursorline
	au!WinLeave                      * setlocal nocursorline
augroup END

set tabstop=4
set shiftwidth=4

:command FRCDeploy !gradlew deploy<CR><CR>
:command FRCSim !gradlew simulateJava<CR><CR>

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

autocmd BufReadPost,FileReadPost * normal zxzR

noremap <leader>fo zxzc

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

noremap <leader>cl <cmd>noh<CR>
" noremap <leader>cl <C-l>

nmap Te <C-w>s<C-w>j :term<CR>i
tnoremap <Esc> <C-\><C-n>
tnoremap <C-c> <C-c><Esc>

nmap nt <cmd>NvimTreeToggle<CR>
nmap vrc <cmd>tabedit $MYVIMRC<CR><cmd>lua name_tab()<CR>vimrc<CR>
nmap <leader>ff <cmd>Telescope find_files<CR>
nmap <leader>fs <C-w>v<C-l><cmd>Telescope find_files<CR>
nmap <leader>fg <cmd>Telescope live_grep<CR>
nmap <leader>fb <cmd>Telescope buffers<CR>
nmap <leader>fh <cmd>Telescope help_tags<CR>
nmap <leader>ft <cmd>TodoTelescope<CR>
nmap <leader>fl <cmd>Telescope lsp_workspace_symbols<CR>

nmap <leader>t <cmd>Twilight<CR>
noremap <leader>a <cmd>SymbolsOutline<CR><C-l>

nmap <leader>ll <cmd>lua require 'lsp_lines'.toggle()<CR><cmd>lua vim.diagnostic.config({virtual_text = false,})<CR>
nmap <leader>lo <cmd>lua require 'lsp_lines'.toggle()<CR><cmd>lua vim.diagnostic.config({virtual_text = true,})<CR>
nmap <leader>rt <cmd>lua name_tab()<CR>

noremap ]t <cmd>lua require 'todo-comments' .jump_next()<CR>
noremap [t <cmd>lua require 'todo-comments' .jump_prev()<CR>

set shell=cmd

nmap <A-i> <cmd>lua require 'FTerm' .toggle()<CR>
tmap <A-i> <C-\><C-n><cmd>lua require("FTerm").toggle()<CR>

lua require 'mcgrath'

hi TabLineFill ctermbg=black guibg=black
" #2b2500
hi DiagnosticWarn  guifg=#ffd700 guibg=#1c1801
hi DiagnosticError guifg=#ff0000 guibg=#220000
hi VertSplit       guifg=#ff0088 guibg=#000000
