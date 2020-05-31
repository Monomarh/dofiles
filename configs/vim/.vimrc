if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
  Plug 'ryanoasis/vim-devicons'
  Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
  " Plug 'ycm-core/YouCompleteMe'
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
call plug#end()

" vim settings
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

" Theme
syntax enable
colorscheme tender
let g:lightline = { 'colorscheme': 'tender' }
let g:airline_theme = 'tender'

" Helpful files for vim redactor
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
