" vim: set tw=0:
scriptencoding utf-8

" Vundle
    filetype off                  " required by vundle
    set rtp+=~/.vim/bundle/Vundle.vim/

    " Bundles
        call vundle#begin()

            Plugin 'VundleVim/Vundle.vim'               " Plugin manager

            Plugin 'davidhalter/jedi-vim'               " Python auto-completion
            Plugin 'godlygeek/tabular'                  " Support tabular alignment
            Plugin 'hashknot/scratch.vim'               " Support 'Vscratch' buffer
            Plugin 'kien/ctrlp.vim'                     " Intelligent file/buffer auto-completion
            Plugin 'klen/python-mode'                   " Python auto-completion
            Plugin 'easymotion/vim-easymotion'          " Support arbitrary jumps to words/characters
            Plugin 'MarcWeber/vim-addon-mw-utils'
            Plugin 'michaeljsmith/vim-indent-object'    " Support 'indent' based actions
            Plugin 'osyo-manga/vim-anzu'                " Get the count of search hits
            Plugin 'scrooloose/nerdtree'                " File browser pane
            Plugin 'scrooloose/syntastic'               " Syntax checking
            Plugin 'tommcdo/vim-exchange'               " Support exchange of objects
            Plugin 'tomtom/tcomment_vim'                " Support commenting based on language
            Plugin 'tomtom/tlib_vim'
            Plugin 'tpope/vim-abolish'                  " For supporting Subvert i.e. `%S{f,F}oo/{b,B}ar/g`
            Plugin 'tpope/vim-fugitive'                 " For supporting Git operations
            Plugin 'tpope/vim-repeat'                   " For support '.' based repeat
            Plugin 'tpope/vim-surround'                 " Support arbitrary 'surround' actions
            Plugin 'tpope/vim-unimpaired'               " Miscellaneous 'co' '[' shortcuts
            Plugin 'garbas/vim-snipmate'                " For supporting common snippet tab-autocompletion
            Plugin 'honza/vim-snippets'                 " Defines commonly used snippets for multiple languages
            Plugin 'altercation/vim-colors-solarized'   " Solarized theme

        call vundle#end()

    filetype plugin on

" Terminal
    set shell=zsh

" Encoding
    set termencoding=utf-8
    set encoding=utf-8

" nvim
    " let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
    " set termguicolors

" Indent
    filetype plugin indent on       " enable detection, plugins and indenting in one step
    set cindent
    set smartindent                 " Do smart indenting when starting a new line
    set autoindent
    syntax on

" Functions
    " Define all tab width specific options to the passed value
    function! SetTabWidth(width)
        exec 'set tabstop='    .a:width
        exec 'set shiftwidth=' .a:width
        exec 'set softtabstop='.a:width
    endfunction

    " Toggle tw=0/80
    function! ToggleCC()
            if &tw == 0
                if !exists('w:tw')
                    let w:tw = 80
                endif
                exec 'set tw='.w:tw
            else
                let w:tw = &tw
                set tw=0
            endif
    endfunction
    " Return the regex to tabularize the selected data into two columns with the provided delimiter
    function! Tabularize2ColumnsRegex()
        call inputsave()
        let delim=input("Enter the delimiting string: ")
        call inputrestore()
        return "^.{-}\\zs".delim
    endfunction

" Tab character
    call SetTabWidth(4)
    set shiftround  " Round indent to multiple of 'shiftwidth'
    set expandtab
    set smarttab

" Search
    set incsearch
    set ignorecase
    set smartcase
    set nohlsearch

" Text width
    " set tw=80
    set wrap
    set cc=+1           "Display colorcolumn at tw+1

" Folding
    set foldenable
    set foldmethod=indent
    set foldlevelstart=99
    set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo "which commands open a fold

" Colors
    hi ExtraWhitespace ctermbg=none ctermfg=red
    hi LeadingTab ctermbg=none ctermfg=darkgray
    let g:solarized_termcolors=256
    set background=light
    colorscheme solarized

" Appearance
    set cul                         " Highlight cursor line

    " Statusline
        set laststatus=2            " Always display statusline
        set statusline =%m          " Modified flag '[+]'
        set statusline+=\ \%-.60F   " full file path, truncated at 60 chars, left justified
        set statusline+=%=          " left/right separator
        set statusline+=%<          " truncate here if out of space
        set statusline+=%c          " cursor column
        set statusline+=\ %l/%L     " cursor line/total lines.
        set statusline+=\ %P        " percent through file
        set statusline+=\ %R        " read-only flag '[RO]'
        set statusline+=%Y          " filetype e.g. '[vim]'

    " Tabs
        set tabpagemax=20
        set showtabline=2  " 0, 1 or 2; when to use a tab pages line

    " Other
        set list
        set listchars=tab:»\ ,trail:«,nbsp:«
        set relativenumber number
        set wrap
        set lazyredraw
        set title                       " change the terminal's title
        set scrolloff=2                 " Always keep 4 lines off the edges when scrolling up/down
        set showcmd                     " show (partial) command in the last line of the screen
                                        " this also shows visual selection info

" Behaviour
    set switchbuf=useopen
    set backspace=indent,eol,start  " allow backspacing over everything in insert mode
    set history=1000                " remember more commands and search history
    set splitright                  " split on the right side
    set splitbelow                  " split below
    set undolevels=1000             " use many muchos levels of undo
    if v:version >= 730
        set undofile                " keep a persistent backup file
        set undodir=~/.vim/.undo,~/tmp,/tmp
    endif
    set nobackup                    " do not keep backup files, it's 70's style cluttering
    set noswapfile                  " do not write annoying intermediate swap files,
    set directory=~/.vim/.tmp,~/tmp,/tmp " store swap files in one of these directories
    set viminfo='20,\"80            " read/write a .viminfo file, don't store more
    set wildmode=longest,list,full
    set wildmenu                    " make tab completion for files/buffers act like bash
    set wildignore=*.swp,*.bak,*.pyc,*.class
    set noerrorbells                " don't beep
    set timeoutlen=500
    set modeline                    " enable file-specific vim settings
    set modelines=5                 " enable file-specific vim settings

" Maps
    " Standard keys remaps
        nnoremap ; :
        nnoremap : ;
        vnoremap ; :
        vnoremap : ;
        nnoremap ' `
        nnoremap ` '
        nnoremap 0 ^
        nnoremap ^ 0
        vnoremap 0 ^
        vnoremap ^ 0
        map      Q <Nop>
        map      K <Nop>
        nmap     j gj
        nmap     k gk
        nnoremap ? ?\v
        vnoremap ? ?\v
        nnoremap / /\v
        vnoremap / /\v
        vnoremap <expr> // 'y/\V'.escape(@",'\').'<CR>'
        noremap! <F1>  <Esc>
        nmap n <Plug>(anzu-n-with-echo)
        nmap N <Plug>(anzu-N-with-echo)
        nmap * <Plug>(anzu-star-with-echo)
        nmap <Esc><Esc> <Plug>(anzu-clear-search-status)
        nmap # <Plug>(anzu-sharp-with-echo)

    " Standard keymap remap
        noremap  zH zt
        vnoremap zH zt
        noremap  zL zb
        vnoremap zL zb

    " Control key maps
        inoremap <C-f> <C-x><C-f>
        inoremap <C-l> <C-x><C-l>
        imap     <C-c> <esc>;
        map      <C-t> <esc>;tabe 
        imap     <C-t> <esc>;tabe 
        map      <C-w>o ;tab sp<CR>
        nnoremap <C-Tab> %
        vnoremap <C-Tab> %

    " Leader key maps
        let mapleader =  ","
        map   <leader>,  ,,<esc>
        vmap  <leader>C  <esc>;'<,'>:w !DISPLAY=:0 xclip -selection clipboard -i <CR>
        map   <leader>R  ;s/\s\+$//<cr>
        map   <leader>s  ;let @/=""<CR>
        vmap  <leader>S  <esc>;'<,'>:!sort<CR>
        map   <leader>v  ;tabe $MYVIMRC<CR>
        map   <leader>V  ;so $MYVIMRC<CR>
        map   <leader>x  ;windo q<cr>
        map   <leader>X  ;!chmod +x %<CR>
        nnoremap   <leader>/  /
        vnoremap   <leader>/  /
        nnoremap   <leader>?  ?
        vnoremap   <leader>?  ?
        vmap  <leader>t  ;Tabularize /\v
        vmap  <leader>T  ;Tabularize /\v=Tabularize2ColumnsRegex()<CR><CR>

        " Correct spellings
        map   <leader>c  1z=

        " CtrlP maps
            map   <leader>pb  ;CtrlPBuffer<CR>
            map   <leader>pf  ;CtrlP<CR>
            map   <leader>pp  ;CtrlPMixed<CR>

    " Space key maps (All are used for managing windows)
        map <space>q  <c-W>q
        map <space>H  <c-W>H
        map <space>J  <c-W>J
        map <space>K  <c-W>K
        map <space>L  <c-W>L
        map <space>h  <c-W>h
        map <space>j  <c-W>j
        map <space>k  <c-W>k
        map <space>l  <c-W>l
        map <space>w  <c-W>w
        map <space>W  <c-W>W
        map <space>=  <c-W>=
        map <space>\| <c-W>\|
        map <space>>  5<c-W>>
        map <space><  5<c-W><
        map <space>+  ;resize +1<CR>
        map <space>-  ;resize -1<CR>
        nmap <space><space> ;exe "tabn ".g:lasttab<CR>

    " 'g' key maps
        map gr ;vertical resize 85<cr>
        map gR ;vertical resize 
        map gw ;call ToggleCC()<CR>
        map gn ;NERDTree<CR>
        map gN ;NERDTree<CR>

    " 'co' key maps
        map cof ;set foldmethod=indent<CR>
        map cot ;exe 'call inputsave() \| call SetTabWidth(input("Enter tab width: ")) \| call inputrestore()'<CR>

    " [] based key maps
        map ]] j0[[%/{<CR>
        map [[ ?{<CR>w99[{
        map ][ /}<CR>b99]}
        map [] k$][%?}<CR>

    " Custom commands
        com! -nargs=1 -complete=file Rot tab sview <args>
        com! -nargs=1 -complete=file Rov vnew | view <args>
        com! -nargs=1 -complete=file Ro view <args>
        com! Reload tabdo :windo :e %
        com! Q q
        com! Qa qa
        com! Qall qall

" Plugin Settings
    let g:EasyMotion_leader_key = '<Leader>'
    let g:sparkupNextMapping = '<c-y>'
    let g:closetag_filenames = "*.html,*.xml"
    let NERDTreeIgnore = ['\.pyc$']
    let NERDTreeMinimalUI = 1
    let NERDTreeShowBookmarks = 1
    au BufNewFile,BufRead if &ft == "nerdtree" | call SetTabWidth(2)

    " pymode/jedi
        let g:pymode_rope = 0
        let g:pymode_doc = 1
        let g:pymode_doc_key = 'K'
        let g:pymode_lint = 0
        let g:pymode_virtualenv = 1
        let g:pymode_virtualenv_path = $VIRTUAL_ENV
        let g:pymode_breakpoint = 1
        let g:pymode_breakpoint_key = '<leader>B'
        let g:pymode_syntax = 1
        let g:pymode_syntax_all = 1
        let g:pymode_syntax_indent_errors = g:pymode_syntax_all
        let g:pymode_folding = 1
        autocmd FileType python setlocal completeopt-=preview
        autocmd FileType python setlocal foldmethod=expr

" Automate
    au BufWinEnter * call matchadd('ExtraWhitespace', '\s\+$\| \+\ze\t', -1)
    au BufWinEnter * call matchadd('LeadingTab', '^\t\+', -1)
    let g:lasttab = 1
    au TabLeave * let g:lasttab = tabpagenr()

    " Filetype specific
        au BufNewFile,BufRead *.htm set ts=4 | set sw=4
        au BufNewFile,BufRead *.vimrc set foldmethod=indent  | set foldenable | set foldlevel=0
        au BufNewFile,BufRead COMMIT_EDITMSG set filetype=gitcommit | set tw=50

    if &diff != 1 && $NO_LCD != "true"
        autocmd BufEnter * silent! lcd %:p:h
    endif
