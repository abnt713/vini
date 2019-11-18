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

"Plugins
call plug#begin()

Plug 'lifepillar/vim-gruvbox8'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'wsdjeg/FlyGrep.vim'
Plug 'scrooloose/nerdtree'

Plug 'dense-analysis/ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'

Plug 'sheerun/vim-polyglot'

Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-path'

" PHP
Plug 'phpactor/phpactor', {'do': 'composer install', 'for': 'php'}
Plug 'stanangeloff/php.vim'
Plug 'stephpy/vim-php-cs-fixer'
Plug 'phpactor/ncm2-phpactor'
Plug 'mattn/emmet-vim'

" Go
Plug 'stamblerre/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'ncm2/ncm2-go'

" Python
Plug 'tell-k/vim-autopep8'
Plug 'fisadev/vim-isort'
Plug 'ncm2/ncm2-jedi'

Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'

call plug#end()

" Relative line numbers
set nu rnu

" Theme
colorscheme gruvbox8
let g:airlike_theme='onedark'
let g:ale_sign_column_always = 1
let g:ale_sign_warning = ''
let g:ale_sign_error = ''

" NERDTree ignored files and settings
let NERDTreeIgnore = ['\.pyc$', '\.egg-info$', '__pycache__', '__pycache__']
nnoremap <leader>t :NERDTreeToggle <CR>
let g:hardtime_ignore_buffer_patterns = [ "NERD.*" ]

" Text wrap limit
au BufRead,BufNewFile *.md setlocal textwidth=80

" Fuzzy functions
map <leader>s :FlyGrep <CR>
map <leader>f :Files <CR>
map <leader>; :Buffers<CR>

" NCM2 for every buffer
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect 
set shortmess+=c

" PHP settings
autocmd BufWritePost *.php silent! call PhpCsFixerFixFile()
let g:php_cs_fixer_rules = "@PSR2,no_unused_imports" " options: --fixers

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

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

" Python
let g:autopep8_on_save = 1
let g:autopep8_disable_show_diff=1
