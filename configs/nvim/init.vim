" Install vim-plug if doesn't exist
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd!
    autocmd VimEnter * PlugInstall
endif

" Vim-plug bootstrap
call plug#begin('~/.config/nvim/plugged')
  Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
  Plug 'ycm-core/YouCompleteMe'
  Plug 'rking/ag.vim'
  Plug 'jiangmiao/auto-pairs'
  Plug 'easymotion/vim-easymotion'
  " Git Section
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'
  " PHP section
  Plug 'StanAngeloff/php.vim', {'for': 'php'}
  Plug 'arnaud-lb/vim-php-namespace', {'for': 'php'}
  Plug 'sumpygump/php-documentor-vim', {'for': 'php'}
  " Theme section
  Plug 'ryanoasis/vim-devicons'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'jacoborus/tender.vim'
  " Hard mode
  Plug 'takac/vim-hardtime'
call plug#end()

" Nvim settings
set number
set list
set hlsearch
set incsearch
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set smarttab
set smartindent
set wildmenu
set autoread
syntax on

" Theme settings
if (has("termguicolors"))
  set termguicolors
endif

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Theme
syntax enable
colorscheme tender
let g:lightline = { 'colorscheme': 'tender' }
let g:airline_theme = 'tender'

" Helpful files for nvim redactor
set noswapfile
set nobackup
set noundofile

" Variables
let g:mapleader=','
" If something goes wrong with ruby gem neovim
""" let g:ruby_host_prog='~/.gem/bin/neovim-ruby-host'
" Airplane settings
let g:airline_theme='zenburn'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#tab_min_count=0
let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline#extensions#tabline#show_buffers=0
let g:airline#extensions#tabline#fnamemod=':t'
let g:airline_section_warning=''
let g:airline_section_error=''
let g:airline#extensions#tabline#show_close_button=0
let g:airline#extensions#tabline#left_alt_sep=''
let g:airline#extensions#tagbar#enabled=0
let g:airline#extensions#tabline#show_tab_nr=1
let g:airline#extensions#tabline#tab_nr_type=1

" Mappings
map <C-n> :NERDTreeToggle<CR>
map <Leader> <Plug>(easymotion-prefix)

au BufRead,BufNewFile *.php inoremap <buffer> <C-P> :call PhpDoc()<CR>
au BufRead,BufNewFile *.php nnoremap <buffer> <C-P> :call PhpDoc()<CR>
au BufRead,BufNewFile *.php vnoremap <buffer> <C-P> :call PhpDocRange()<CR>
