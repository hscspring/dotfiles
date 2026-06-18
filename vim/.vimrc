let mapleader = ","
let g:mapleader = ','

"===========================
" Basic
"===========================
filetype on
filetype plugin on

if !exists("g:syntax_on")
    syntax enable
endif

set noeb
set history=500

"===========================
" Plug
"===========================
if filereadable(expand("~/.vimrc.bundle"))
    source ~/.vimrc.bundle
endif

" Autoformat
noremap <leader>f :Autoformat<CR>

" NERDtree
noremap <leader>t :NERDTreeToggle<CR>

" EasyMotion
nmap <leader>m <Plug>(easymotion-overwin-f)
nmap <leader><leader>m <Plug>(easymotion-overwin-f2)
map <leader>w <Plug>(easymotion-bd-w)
nmap <leader><leader>w <Plug>(easymotion-overwin-w)
map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)

" fzf (replacing LeaderF)
nnoremap <leader>l :Files<CR>
noremap <leader>lf :BTags<CR>
noremap <leader>lb :Buffers<CR>
noremap <leader>lm :History<CR>
noremap <leader>ll :BLines<CR>
noremap <leader>rg :Rg<CR>

" gv
nnoremap <leader>g :GV<CR>
nnoremap <leader>G :GV!<CR>
nnoremap <leader>gg :GV?<CR>

" color
silent! colorscheme molokai

"===========================
" CmdMap
"===========================
nnoremap <leader>sn :call SetLineNumber()<CR>
function! SetLineNumber()
    if &nu
        set nonu
        set nornu
    else
        set nu
        set rnu
    endif
endfunction

nnoremap ; :
nnoremap <leader>s :source $MYVIMRC<CR>
nnoremap <leader>i :PlugInstall<CR>
nnoremap <leader>u :PlugUpdate<CR>
vmap <leader>y "+y
nnoremap <leader>p "+p

nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

noremap <leader>sh :!
noremap <leader>py :!python3 %<CR>

"===========================
" Edit
"===========================
set shiftwidth=4
set tabstop=4
set smarttab
set expandtab
set ai
set si
filetype indent on
set backspace=2
ab #e ====================
ab #s --------------------
ab #a ********************

"===========================
" Search
"===========================
set incsearch
set hlsearch

"===========================
" Store
"===========================
set nobackup
set noswapfile
set autoread
set autowrite
set confirm

"===========================
" Display
"===========================
set t_Co=256
set number
set rnu
set cursorline
set ruler
set termencoding=utf-8
set encoding=UTF-8
set fileencodings=utf8,ucs-bom,gbk,cp936,gb2312,gb18030

augroup vimrc
    au BufReadPre * setlocal foldmethod=indent
    au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END
