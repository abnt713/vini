let g:python_host_prog = $NVIM_PYTHON2
let g:python3_host_prog = $NVIM_PYTHON3

if exists('+termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

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


let g:ale_sign_column_always = 1
let g:ale_sign_warning = ''
let g:ale_sign_error = ''

let g:ale_php_phpcbf_standard = 'PSR2'
let g:ale_php_phpcs_options = '--config-set default_standard PSR2'

let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

"Plugins
call plug#begin()

" Theme
Plug 'lifepillar/vim-gruvbox8'
Plug 'arcticicestudio/nord-vim'
Plug 'nicklasos/numix-molokai'

" File, buffer and window surfing
Plug 'christoomey/vim-tmux-navigator'
Plug 'francoiscabrol/ranger.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'logico/typewriter-vim'
Plug 'preservim/nerdtree'

" Common
Plug 'dense-analysis/ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/goyo.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'chrisbra/colorizer'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Debug
Plug 'puremourning/vimspector'

" COC
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" HTML
Plug 'mattn/emmet-vim'

" Go
Plug 'fatih/vim-go', {'tag': 'v1.23'}

" PHP
Plug 'stephpy/vim-php-cs-fixer'

call plug#end()

" Relative line numbers
set nu rnu

" Theme
set background=dark
colorscheme gruvbox8


" Text wrap limit
au BufRead,BufNewFile *.md setlocal textwidth=80

" Git Gutter
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '>'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = '<'

" Go
let g:go_fmt_command = "goimports"
let g:go_code_completion_enabled = 0
" let g:go_highlight_functions = 1
" let g:go_highlight_function_calls = 1
" let g:go_highlight_structs = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_build_constraints = 1

" COC Config
let g:go_def_mapping_enabled = 0
let g:go_rename_command = 'gopls'

set hidden
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes


inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"


function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction



" Remap for format selected region
" vmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)


" highlight OverLength ctermbg=darkgray ctermfg=white guibg=#FFD9D9
" augroup vimrc_autocmds
"     autocmd!
"     autocmd BufEnter,WinEnter * call matchadd('OverLength', '\%>80v.\+', -1)
" augroup END
"

autocmd BufWritePost *.php silent! call PhpCsFixerFixFile()

""""""""
" MAPS "
""""""""
" NERDTree
nmap <space>ft :NERDTreeToggle<CR>

" Git
nmap <space>gs :Gstatus<CR>
nmap <space>gc :Gcommit<CR>

" Buffer 
nmap <space>bb :Buffers<CR>
nmap <space>bw :bd<CR>
nmap <space>bn :bn<CR>
nmap <space>bp :bp<CR>

" Tabs
nmap <space>tt :tabnew<CR>
nmap <space>tn :tabn<CR>
nmap <space>tp :tabp<CR>
nmap <space>tw :tabclose<CR>

" Fuzzy functions
map <space>fs :Ag<CR>
map <space>ff :Files<CR>
map <space>fb :Buffers<CR>

" Vimspector
let g:vimspector_enable_mappings = 'HUMAN'
nmap <space>dd :call vimspector#Launch()<CR>
nmap <space>dw :VimspectorReset<CR>
nmap <space>di :call vimspector#StepInto()<CR>
nmap <space>do :call vimspector#StepOver()<CR>
nmap <space>db :call vimspector#StepOut()<CR>
nmap <space>dp :call vimspector#ToggleBreakpoint()<CR>

" COC
inoremap <silent><expr> <c-space> coc#refresh()
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <space>cr <Plug>(coc-rename)
nnoremap <silent> <space>cd :call <SID>show_documentation()<CR>
nnoremap <silent> <space>ca  :<C-u>CocList diagnostics<cr>
nnoremap <silent> <space>ce  :<C-u>CocList extensions<cr>
nnoremap <silent> <space>cc  :<C-u>CocList commands<cr>
nnoremap <silent> <space>co  :<C-u>CocList outline<cr>
nnoremap <silent> <space>cs  :<C-u>CocList -I symbols<cr>
nnoremap <silent> <space>cj  :<C-u>CocNext<CR>
nnoremap <silent> <space>ck  :<C-u>CocPrev<CR>
nnoremap <silent> <space>cp  :<C-u>CocListResume<CR>
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" PHP-CS-Fixer
nnoremap <silent><space>pcd :call PhpCsFixerFixDirectory()<CR>
nnoremap <silent><space>pcf :call PhpCsFixerFixFile()<CR>

" Autocomplete tweaks
inoremap <c-c> <ESC>
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
