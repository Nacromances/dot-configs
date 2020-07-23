" General
set nu
set relativenumber
colorscheme desert
syntax on
set autoindent

set nocompatible              " be iMproved, required
filetype off                  " required

" Backspace
set backspace=indent,eol,start  " more powerful backspacing

set path+=**
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'tpope/vim-fugitive'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'altercation/vim-colors-solarized'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'majutsushi/tagbar'
Plugin 'sjl/gundo.vim'
Plugin 'honza/vim-snippets'
Plugin 'tomasr/molokai'
Plugin 'nanotech/jellybeans.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'davidhalter/jedi-vim'
Plugin 'jmcantrell/vim-virtualenv'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'valloric/youcompleteme'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'vhdirk/vim-cmake'
Plugin 'rdnetto/YCM-Generator'
Plugin 'rhysd/vim-clang-format'           " Call clang format
Plugin 'octol/vim-cpp-enhanced-highlight' " CPP highlight
call vundle#end()            " required
set nocp
filetype plugin on


" windows nav
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l


" Nerdtree related
noremap <F9> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" Ctags
set tags+=./tags
set tags+=~/.vim/tags/cpp


" build tags of your own project with Ctrl-F12
nnoremap <F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>


map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <C-S-x> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
nnoremap <F8> :TagbarToggle<CR>


" Gundo
nnoremap <F5> :GundoToggle<CR>
let g:gundo_prefer_python3=1

" Tab settings
set smartindent
" Kernel development"
function KernelMode()
let g:ycm_filetype_blacklist = {
    \ 'c' : 1,
    \ 'c++' : 1
    \ }
set tabstop=8
set softtabstop=8
set shiftwidth=8
set noexpandtab
endfunction


" User land development"
function UserMode()
let g:ycm_filetype_whitelist = {
    \ 'c' : 1,
    \ 'c++' : 1,
    \ 'cpp' : 1
    \ }
endfunction

call UserMode()

" Other options
"
let mapleader = ","
set incsearch
set hlsearch
set wildmenu
set hidden
set noswapfile
set wildignore=*.o,*~,*.pyc,build/*,**/build/*
set mouse=a
set foldmethod=indent
set foldlevel=99
set colorcolumn=120
nnoremap <space> za
" Whitespace managment
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
"

" Minibufexplorer
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1


" CtrlP
"
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
" airline
set t_Co=256
let g:airline_theme = 'bubblegum'
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':p:t'  " filename too long
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#csv#enabled = 1
let g:airline_powerline_fonts=1


" load custom .vim.custom if found
au BufNewFile,BufRead *.h call CheckForCustomConfiguration()
au BufNewFile,BufRead *.c call CheckForCustomConfiguration()
au BufNewFile,BufRead *.hpp call CheckForCustomConfiguration()
au BufNewFile,BufRead *.cpp call CheckForCustomConfiguration()
function! CheckForCustomConfiguration()
    " Check for .vim.custom in the directory containing the newly opened file
    let custom_config_file = expand('%:p:h') . '/.vim.custom'
    if filereadable(custom_config_file)
        exe 'source' custom_config_file
    endif
endfunction


" YCM
if v:version < 740 || !(has('python'))
    let g:enable_ycm_at_startup = 0
endif
let g:ycm_auto_trigger=1
let g:ycm_collect_identifiers_from_tags_files=1
nnoremap <silent> <Leader>gd : YcmCompleter GoToDefinition<CR>
nnoremap <silent> <Leader>gi : YcmCompleter GoToInclude<CR>
nnoremap <silent> <Leader>gD : YcmCompleter GoToDeclaration<CR>
nnoremap <silent> <Leader>gr : YcmCompleter GoToReferences<CR>



" Python
" Folding
let g:SimpylFold_docstring_preview=1

" W for save with sudo
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!

" Buffer navigation
"
nnoremap <C-a> :bnext<CR>
nnoremap <C-b> :bprevious<CR>
nnoremap <C-X> :bd<CR>

" CMake

let g:cmake_ycm_symlinks=1

set makeprg=make\ -C\ build


" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
        \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>
set modelines=5


" CPP Highlites

let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1


" Trailing spaced
"
autocmd FileType c,cpp,python,sh,xml,json autocmd BufWritePre <buffer> %s/\s\+$//e
