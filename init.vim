let g:python_host_prog = $NVIM_PYTHON2
let g:python3_host_prog = $NVIM_PYTHON3

" Vim Plug download
if has('nvim')
    if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
      silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
else
    if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
endif

call plug#begin('~/.vim/plugged')

Plug 'lifepillar/vim-gruvbox8'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-fugitive'

Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-path'

Plug 'phpactor/phpactor', {'do': 'composer install', 'for': 'php'}
Plug 'stanangeloff/php.vim'
Plug 'stephpy/vim-php-cs-fixer'
Plug 'phpactor/ncm2-phpactor'

call plug#end()

set number
colorscheme gruvbox8

let g:airline_theme='onedark'

map <leader>f :Files <CR>
map <leader>; :Buffers<CR>

autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect 
set shortmess+=c

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" PHPActor
nmap <Leader>u :call phpactor#UseAdd()<CR>
nmap <Leader>mm :call phpactor#ContextMenu()<CR>
nmap <Leader>nn :call phpactor#Navigate()<CR>
nmap <Leader>o :call phpactor#GotoDefinition()<CR>
nmap <Leader>ct :call phpactor#Transform()<CR>
nmap <Leader>cc :call phpactor#ClassNew()<CR>
nmap <silent><Leader>ee :call phpactor#ExtractExpression(v:false)<CR>
vmap <silent><Leader>ee :<C-U>call phpactor#ExtractExpression(v:true)<CR>
vmap <silent><Leader>em :<C-U>call phpactor#ExtractMethod()<CR>
