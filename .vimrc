scriptencoding utf-8
set nocompatible

" Vundle
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()

" Terminal
    set term=screen-256color
    set t_Co=256
    set ttyfast
    set shell=zsh

" Encoding
    set termencoding=utf-8
    set encoding=utf-8

" Bundles
    Bundle "nanotech/jellybeans.vim"
    Bundle "tomtom/tlib_vim"
    Bundle "MarcWeber/vim-addon-mw-utils"
    Bundle "aperezdc/vim-template"
    Bundle "garbas/vim-snipmate"
    Bundle "godlygeek/tabular"
    Bundle "honza/vim-snippets"
    Bundle "itchyny/lightline.vim"
    Bundle "Lokaltog/vim-easymotion"
    Bundle "rstacruz/sparkup"
    Bundle "scrooloose/nerdtree"
    Bundle "scrooloose/syntastic"
    Bundle "tomtom/tcomment_vim"
    Bundle "tpope/vim-abolish"
    Bundle "tpope/vim-fugitive"
    Bundle "tpope/vim-repeat"
    Bundle "tpope/vim-surround"
    Bundle "tpope/vim-unimpaired"
    Bundle "airblade/vim-gitgutter"
    Bundle "matchit.zip"

" Indent
    filetype plugin indent on       " enable detection, plugins and indenting in one step
    set cindent
    set smartindent                 " Do smart indenting when starting a new line
    set autoindent
    syntax on

" Functions
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
            let fname = expand('%:r:t')
            return fname =~ 'NERD_tree' ? '' :
                    \ ('' != fname ? fname : '[No Name]')
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

    " Define all tab width specific options to the passed value
    function! SetTabWidth(width)
        exec 'set tabstop='    .a:width
        exec 'set shiftwidth=' .a:width
        exec 'set softtabstop='.a:width
    endfunction

    " Toggle tw=0/80
    function! ToggleTW()
        if &tw == 0
            set tw=80
            return
        endif
        set tw=0
    endfunction

    " Toggle mouse=c/a
    function! ToggleMouse()
        if &mouse == 'c'
            set mouse=a
            return
        endif
        set mouse=c
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
    hi CursorLine term=none cterm=none ctermbg=0
    hi ColorColumn ctermbg=black guibg=black
    hi ExtraWhitespace ctermbg=none ctermfg=red
    hi LeadingTab ctermbg=none ctermfg=darkgray

" Appearance
    " Statusline
        set laststatus=2

        " lightline configurations
            let g:lightline = {
                        \ 'colorscheme': 'default',
                        \ 'active': {
                        \   'left': [ [ 'mode', 'paste' ],
                        \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
                        \ },
                        \ 'component_function': {
                        \   'fugitive'     : 'LightlineFugitive',
                        \   'readonly'     : 'LightlineReadonly',
                        \   'modified'     : 'LightlineModified',
                        \   'filename'     : 'LightlineFilename',
                        \   'fileencoding' : 'LightlineFileencoding',
                        \   'fileformat'   : 'LightlineFileformat',
                        \   'filetype'     : 'LightlineFiletype',
                        \   'mode'         : 'LightlineMode'
                        \ },
                        \ 'subseparator': { 'left': "|", 'right': "|" }
                        \ }

    " Tabs
        set tabpagemax=20
        set showtabline=2  " 0, 1 or 2; when to use a tab pages line

    " Other
        set relativenumber
        set lazyredraw
        set cul                         " Highlight cursor line
        set title                       " change the terminal's title
        set scrolloff=4                 " Always keep 4 lines off the edges when scrolling up/down
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
        map   <leader>,  ,<esc>
        vmap  <leader>C  <esc>;'<,'>:w !xclip -selection clipboard -i <CR>
        map   <leader>R  ;s/\s\+$//<cr>
        map   <leader>s  ;let @/=""<CR>
        map   <leader>v  ;tabe $MYVIMRC<CR>
        map   <leader>V  ;so $MYVIMRC<CR>
        map   <leader>x  <esc>;windo q<cr>
        map   <leader>X  <esc>;!chmod +x %<CR>
        vmap  <leader>t  ;Tabularize /\v
        vmap  <leader>T  ;Tabularize /\v=Tabularize2ColumnsRegex()<CR><CR>

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

    " 'g' key maps
        map gn ;NERDTree<CR>
        map gN ;NERDTree<CR>
        map gr ;vertical resize 85<cr>
        map gR ;vertical resize 
        map gw ;call ToggleTW()<CR>

    " 'co' key maps
        map com ;call ToggleMouse()<CR>

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
    let NERDTreeIgnore = ['\.pyc$']

" Macros
    let @m='/<<<<<<<<kbkbkbkbkbkbkbkb\<\<\<\<\<\<dd/=====kbkbkbkbkb\=\=\=\=\=\=\kbV/>>>>>kbkbkbkbkb\>\>\>\>\>\>x'
    let @d='Oimport pdbpdb.set_trace()'

" Automate
    au BufWinEnter * call matchadd('ExtraWhitespace', '\s\+$\| \+\ze\t', -1)
    au BufWinEnter * call matchadd('LeadingTab', '^\t\+', -1)
    set list
    set listchars=tab:»\ ,trail:«,nbsp:«

    " Filetype specific
        au BufNewFile,BufRead *.html    set ts=4 |  set sw=4              |  set cc=0
        au BufNewFile,BufRead *.py      set tw=0 |  set foldmethod=indent |  set foldenable |  set foldlevel=0
        au BufNewFile,BufRead *.vimrc   set tw=0 |  set foldmethod=indent |  set foldenable |  set foldlevel=0

    autocmd BufEnter * silent! lcd %:p:h
