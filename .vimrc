scriptencoding utf-8
set nocompatible

" Vundle
    filetype off                  " required by vundle
    set rtp+=~/.vim/bundle/Vundle.vim/

    " Bundles
        call vundle#begin()
        Plugin 'VundleVim/Vundle.vim'
        Plugin 'nanotech/jellybeans.vim'
        Plugin 'tomtom/tlib_vim'
        Plugin 'MarcWeber/vim-addon-mw-utils'
        Plugin 'aperezdc/vim-template'
        Plugin 'garbas/vim-snipmate'
        Plugin 'godlygeek/tabular'
        Plugin 'honza/vim-snippets'
        Plugin 'itchyny/lightline.vim'
        Plugin 'Lokaltog/vim-easymotion'
        Plugin 'rstacruz/sparkup'
        Plugin 'scrooloose/nerdtree'
        Plugin 'scrooloose/syntastic'
        Plugin 'tomtom/tcomment_vim'
        Plugin 'tpope/vim-abolish'
        Plugin 'tpope/vim-fugitive'
        Plugin 'tpope/vim-repeat'
        Plugin 'tpope/vim-surround'
        Plugin 'tpope/vim-unimpaired'
        Plugin 'airblade/vim-gitgutter'
        Plugin 'Shougo/unite.vim'
        Plugin 'nathanaelkane/vim-indent-guides'
        Plugin 'sk1418/Join'
        Plugin 'osyo-manga/vim-anzu'
        Plugin 'Raimondi/delimitMate'
        Plugin 'klen/python-mode'
        Plugin 'davidhalter/jedi-vim'
        Plugin 'michaeljsmith/vim-indent-object'
        Plugin 'crusador/scratch.vim'
        Plugin 'xolox/vim-misc'
        " Plugin 'xolox/vim-easytags'
        " Plugin 'majutsushi/tagbar'
        Plugin 'alvan/vim-closetag'
        Plugin 'kshenoy/vim-signature'
        Plugin 'tommcdo/vim-exchange'
        Plugin 'kien/ctrlp.vim'
        call vundle#end()

    filetype plugin on

" Terminal
    set term=screen-256color
    set t_Co=256
    set ttyfast
    set shell=zsh

" Encoding
    set termencoding=utf-8
    set encoding=utf-8

" Indent
    filetype plugin indent on       " enable detection, plugins and indenting in one step
    set cindent
    set smartindent                 " Do smart indenting when starting a new line
    set autoindent
    syntax on

" Functions
    function! Standardize()
        %s/\v([^ =&|%+/*\-!])\=([^ =])/\1 = \2/gc
        %s/\v([^ ])\=\=([^ ])/\1 == \2/gc
        %s/\v([^ ])([&|%+/*\-!])\=([^ ])/\1 \2= \3/gc
        %s/\v([^ ])([&|%+/*\-])([^ =])/\1 \2 \3/gc
    endfunction

    " Define all tab width specific options to the passed value
    function! SetTabWidth(width)
        exec 'set tabstop='    .a:width
        exec 'set shiftwidth=' .a:width
        exec 'set softtabstop='.a:width
    endfunction

    " Toggle tw=0/80
    function! ToggleCC()
        if g:ccSet == 1
            set cc=0
            let g:currentTw = &tw
            let g:ccSet = 0
            set tw=0
        else
            exec 'set tw='.g:currentTw
            set cc=+1
            let g:ccSet = 1
        endif
    endfunction

    " Toggle mouse=c/a
    function! ToggleMouse()
        if &mouse == 'c'
            set mouse=a
            return
        endif
        set mouse=c
    endfunction

    " Lightline functions
        " Override lightline's method to return 'n+' when there are 'n' modified buffers in a tab
        function! lightline#tab#modified(n)
            let winnr = tabpagewinnr(a:n)
            let buflist = tabpagebuflist(a:n)
            let m = 0 " &modified counter
            " loop through each buffer in a tab
            for b in buflist
                " check and ++ tab's &modified count
                if getbufvar( b, "&modified" )
                let m += 1
                endif
            endfor
            return (m > 0) ? (m > 1) ? m.'+' : '+' : gettabwinvar(a:n, winnr, '&modifiable') ? '' : '-'
        endfunction

        function! LightlineModified()
            if &filetype == "help"
                return ""
            elseif &modified
                return "+"
            elseif &modifiable
                return ""
            else
                return ""
            endif
        endfunction

        function! LightlineReadonly()
            if &filetype == "help"
                return ""
            elseif &readonly
                return "x"
            else
                return ""
            endif
        endfunction

        function! LightlineFugitive()
            try
                if expand('%:t') !~? 'NERD' && exists('*fugitive#head')
                let mark = 'Y '  " edit here for cool mark
                let _ = fugitive#head()
                return strlen(_) ? mark._ : ''
                endif
            catch
            endtry
            return ''
        endfunction

        function! LightlineFilename()
            let fname = expand('%:t')
            return fname =~ 'NERD_tree' ? '' :
                    \ ('' != fname ? fname : '[No Name]')
        endfunction

        function! LightlineFileDir()
            let dirname = expand('%:p:h')
            let fname = expand('%:t')
            if fname =~ 'NERD_tree'
                return ''
            endif
            let allowedLen = winwidth(0) - strlen(fname) - 80
            return allowedLen < 0 ? '' : strlen(dirname) > allowedLen ? '..'.dirname[-(allowedLen):] : dirname
        endfunction

        function! LightlineMode()
            let fname = expand('%:t')
            return fname =~ 'NERD_tree' ? 'NERDTree' :
                \ winwidth(0) > 60 ? lightline#mode() : ''
        endfunction

        function! LightlineFileencoding()
            return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
        endfunction

        function! LightlineFileformat()
            return winwidth(0) > 70 ? &fileformat : ''
        endfunction

        function! LightlineFiletype()
            return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
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
    set tw=80
    set wrap
    set cc=+1           "Display colorcolumn at tw+1

" Folding
    set foldenable
    set foldmethod=indent
    set foldlevelstart=99
    set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo "which commands open a fold

" Colors
    colorscheme jellybeans
    hi ExtraWhitespace ctermbg=none ctermfg=red
    hi LeadingTab ctermbg=none ctermfg=darkgray

" Appearance
    set laststatus=2
    set cul                         " Highlight cursor line

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

    " lightline configurations
        let g:lightline = {
                    \ 'colorscheme': 'default',
                    \ 'active': {
                    \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'readonly', 'filename', 'modified' ] ],
                    \   'right': [ [ 'lineinfo' ], ['percent'], [ 'filedir', 'fileformat', 'fileencoding', 'filetype' ] ]
                    \ },
                    \ 'component_function': {
                    \   'fugitive'     : 'LightlineFugitive',
                    \   'readonly'     : 'LightlineReadonly',
                    \   'modified'     : 'LightlineModified',
                    \   'filename'     : 'LightlineFilename',
                    \   'fileencoding' : 'LightlineFileencoding',
                    \   'fileformat'   : 'LightlineFileformat',
                    \   'filetype'     : 'LightlineFiletype',
                    \   'filedir'      : 'LightlineFileDir',
                    \   'mode'         : 'LightlineMode'
                    \ },
                    \ 'subseparator': { 'left': "|", 'right': "|" }
                    \ }

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

        " Unite maps
            map   <leader>ub  ;Unite buffer<cr>
            map   <leader>uf  ;Unite file<CR>
            map   <leader>ut  ;Unite tab<CR>
            map   <leader>uu  ;Unite buffer file tab<CR>

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
        let g:ccSet=1
        map gw ;call ToggleCC()<CR>
        map gn ;NERDTree<CR>
        map gN ;NERDTree<CR>


    " 'co' key maps
        map com ;call ToggleMouse()<CR>
        map cof ;set foldmethod=indent<CR>

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
    let g:indent_guides_enable_on_vim_startup = 0
    let g:indent_guides_guide_size = 1
    let g:indent_guides_start_level = 2
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
        au BufNewFile,BufRead *.html    set ts=4 | set sw=4               | set cc=0
        au BufNewFile,BufRead *.vimrc   set tw=0 | set foldmethod=indent  | set foldenable | set foldlevel=0
        au BufNewFile,BufRead COMMIT_EDITMSG       set filetype=gitcommit | set tw=50

    if &diff != 1 && $NO_LCD != "true"
        autocmd BufEnter * silent! lcd %:p:h
    endif
