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
  Plug 'itchyny/lightline.vim'
  Plug 'fcpg/vim-fahrenheit'
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
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Theme
syntax on
set t_Co=256
set laststatus=2
set cursorline
colorscheme fahrenheit
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent', 'allLines' ],
      \              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ]
      \ },
      \ 'component': {
      \   'charvaluehex': '0x%B',
      \   'allLines': '%L'
      \ }
      \ }

" Helpful files for vim redactor
set noswapfile
set nobackup
set noundofile

" Variables
let g:mapleader=','

" Mappings
map <C-n> :NERDTreeToggle<CR>
map <Leader> <Plug>(easymotion-prefix)

