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
        Plugin 'haya14busa/incsearch.vim'           " Improved incsearch
        Plugin 'haya14busa/incsearch-easymotion.vim'" Easymotion with incsearch
        Plugin 'vim-scripts/indentpython.vim'       " Indent python according to PEP8
        Plugin 'tmhedberg/SimpylFold'               " Fold python

    call vundle#end()

    filetype plugin indent on   " enable detection, plugins and indenting in one step

" Encoding
    set termencoding=utf-8
    set encoding=utf-8

" Indent
    set cindent                 " enable C-type indenting.
    set smartindent             " Do smart indenting when starting a new line
    set autoindent              " Copy current line's indent to new line

" Functions
    function! SetTabWidth(width)
        " Define all tab width specific options to the passed value

        " Number of spaces to be used while indenting using '>>'/'<<'/'='.
        exec 'set shiftwidth=' .a:width

        " Number of spaces to be used against <Tab> in files.
        exec 'set tabstop='    .a:width

        " Number of spaces to be used corresponding to '<Tab>' insert.
        exec 'set softtabstop='.a:width

    endfunction

    function! SetPyTrace(pos)
        execute "normal! Oimport pdb; pdb.set_trace()"
        call setpos('.', a:pos)
        execute "normal! j"
    endfunction

    function! ToggleTextWidth()
        " Toggle tw=0/tw(default: 80)

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

    function! Tabularize2ColumnsRegex()
        " Return the regex to tabularize the selected data into two columns with
        " the provided delimiter

        call inputsave()
        let delim=input("Enter the delimiting string: ")
        call inputrestore()
        return "^.{-}\\zs".delim
    endfunction

" Tab character
    call SetTabWidth(4)
    set shiftround  " Round indent to multiple of 'shiftwidth'
    set expandtab   " Expand tab to spaces while indenting
    set smarttab    " This does some tab magic!

" Search
    set incsearch   " Search as you type
    set ignorecase
    set smartcase   " Search case-sensitively if there's at least one capitalized letter
    set nohlsearch  " Do not highlight searches

" Text width
    set tw=80           " Textwidth
    set wrap            " Wrap around textwidth
    set cc=+1           " Display vertical colorcolumn at `tw`+1

" Appearance
    set cul                     " Highlight cursor line
    set list                    " Display special chars
    set listchars=tab:»\ ,trail:«,nbsp:«
                                " Display these chars in place of special chars
    set relativenumber number   " Display line no. relative to current line.
                                " Display abs line no. for current line.
    set lazyredraw
    set title                   " change the terminal's title
    set showcmd                 " show (partial) command in the last line of the screen
                                " this also shows visual selection info
    set scrolloff=2             " Always keep 4 lines off the edges when scrolling up/down

    " Folding
        set foldenable
        set foldmethod=indent   " Fold based on indent levels
        set foldlevelstart=2    " Start folding from the 10th innermost block

        " Which commands open a fold
        set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo

    " Colors
        syntax on                   " enable syntax based highlighting
        let g:solarized_termcolors=256
        set background=light        " Goes well with solarized
        colorscheme solarized

    " Statusline
        set laststatus=2            " Always display statusline
        set statusline =%m          " Modified flag '[+]'
        set statusline+=\ \%-.60F   " full file path, truncated at 60 chars, left justified
        set statusline+=%=          " left/right separator
        set statusline+=%<          " truncate here if out of space
        set statusline+=%c          " cursor column
        set statusline+=\ %l/%L     " cursor line/total lines.
        set statusline+=\ %P        " percent through file
        set statusline+=\ %R        " read-only flag 'RO'
        set statusline+=%Y          " filetype e.g. 'VIM'

    " Tabs
        set tabpagemax=20           " Max tab pages
        set showtabline=2           " Always show tabline

" Behaviour
    set switchbuf=useopen           " Jump to first open window for the buffer
    set backspace=indent,eol,start  " allow backspacing over everything in insert mode
    set history=1000                " remember more commands and search history
    set splitright                  " split new windows on current window's right side
    set splitbelow                  " split new windows below the current window

    set undolevels=1000             " use many muchos levels of undo
    if v:version >= 730
        set undofile                " keep a persistent backup file
        set undodir=~/.vim/.undo,~/tmp,/tmp
    endif

    set nobackup                    " do not keep backup files, it's 70's style cluttering
    set noswapfile                  " do not write annoying intermediate swap files,
    set directory=~/.vim/.tmp,~/tmp,/tmp " store swap files in one of these directories

    " Read/write a .viminfo file; retaining command-line history, registers, and many
    " more things from the last session.
    set viminfo='20,\"80


    set wildmode=longest,list,full  " Match longest substr, list all matches, complete next full
    set wildmenu                    " make tab completion for files/buffers act like bash
    set wildignore=*.swp,*.bak,*.pyc,*.class

    set noerrorbells                " don't beep
    set timeoutlen=500              " wait time(ms) for mapped key sequence to finish

    set modeline                    " enable file-specific vim settings e.g. `# vim: set tw=0:`
    set modelines=5                 " look for file-specific settings in these many lines

" Maps
    " Standard keys remaps

        " Shift+; is too much work!
        nnoremap ; :
        nnoremap : ;
        vnoremap ; :
        vnoremap : ;

        " I always want to jump to specfic column within a line using '<mark>
        nnoremap ' `
        nnoremap ` '

        " Jump to zeroth character on a line using 0.
        nnoremap 0 ^
        nnoremap ^ 0
        vnoremap 0 ^
        vnoremap ^ 0

        " Open command history window
        map Q q:

        " I mistype K for k quite frequently
        " map K k

        " Move one view line, and not based on lines in file.
        nmap j gj
        nmap k gk

        noremap! <F1>  <Esc>

    " Search maps

        " Forward/backward search current visual selection
        vnoremap // y/<C-R>"<CR>
        vnoremap ?? y?<C-R>"<CR>

        map   <leader>/  <Plug>(incsearch-easymotion-/)
        map   <leader>?  <Plug>(incsearch-easymotion-?)
        map   <leader>g/ <Plug>(incsearch-easymotion-stay)

        " Search related standard remaps
            map  /  <Plug>(incsearch-forward)
            map  ?  <Plug>(incsearch-backward)
            map  g/ <Plug>(incsearch-stay)
            map  g* <Plug>(incsearch-nohl-g*)
            map  g# <Plug>(incsearch-nohl-g#)
            nmap n  <Plug>(incsearch-nohl)<Plug>(anzu-n-with-echo)
            nmap N  <Plug>(incsearch-nohl)<Plug>(anzu-N-with-echo)
            nmap *  <Plug>(anzu-star-with-echo)
            nmap #  <Plug>(anzu-sharp-with-echo)
            nmap <Esc><Esc> <Plug>(anzu-clear-search-status)


    " Standard keymap remap
        noremap  zH zt
        vnoremap zH zt
        noremap  zL zb
        vnoremap zL zb

    " Control key maps

        " Complete filenames using '<C-f>' in insert mode
        inoremap <C-f> <C-x><C-f>

        " Complete whole lines using '<C-l>' in insert mode
        inoremap <C-l> <C-x><C-l>

        " <C-c> in insert mode opens insert command
        imap     <C-c> <esc>;

        " <C-t> out/in insert mode fills 'tabe' in command-line.
        map      <C-t> <esc>;tabe 
        imap     <C-t> <esc>;tabe 

        " Open current window in a separate tab
        map      <C-w>o ;tab sp<CR>

        " Jump to matching brackets on Ctrl+Tab
        nnoremap <C-Tab> %
        vnoremap <C-Tab> %

    " Leader key maps
        " Use ',' as leader key instead of '\'
        let mapleader =  ","

        " Use ',,' to simulate the default ',' behavior.
        map   <leader>,  ,,<esc>

        " [Linux only] Copy the current selected line to system clipboard.
        vmap  <leader>C  <esc>;'<,'>:w !DISPLAY=:0 xclip -selection clipboard -i <CR>

        " Remove trailing whitespace in the current line or selected text
        map   <leader>R  ;s/\s\+$//<cr>

        " Sort visually selected text using 'sort' command-line tool
        vmap  <leader>S  <esc>;'<,'>:!sort<CR>

        " Open vimrc
        map   <leader>v  ;tabe $MYVIMRC<CR>

        " Reload vimrc
        map   <leader>V  ;so $MYVIMRC<CR>

        " Quit all windows in the current tab
        map   <leader>x  ;windo q<cr>

        " Shorthand for tabularizing text
        vmap  <leader>t  ;Tabularize /\v

        " Tabularize 2 columns using the entered delimiter
        vmap  <leader>T  ;Tabularize /\v=Tabularize2ColumnsRegex()<CR><CR>

        " Incremental search with easymotion
        map   <leader>/  <Plug>(incsearch-easymotion-/)
        map   <leader>?  <Plug>(incsearch-easymotion-?)
        map   <leader>g/ <Plug>(incsearch-easymotion-stay)

        " Set py trace
        map  <leader>b   ;call SetPyTrace(getcurpos()) <CR>


        " Correct spellings. Spell check must be enabled (`:set spellcheck`)
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
        map <space>o  ;tab sp<CR>
        nmap <space><space> ;exe "tabn ".g:lasttab<CR>

    " 'g' key maps
        map gr ;vertical resize 85<cr>
        map gR ;vertical resize 
        map gw ;call ToggleTextWidth()<CR>
        map gn ;NERDTree<CR>
        map gN ;NERDTree<CR>

    " 'co' key maps
        map cof ;set foldmethod=indent<CR>
        map cot ;exe 'call inputsave() \| call SetTabWidth(input("Enter tab width: ")) \| call inputrestore()'<CR>

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
    let g:incsearch#separate_highlight = 1

    " pymode/jedi
        let g:jedi#popup_on_dot = 0
        let g:jedi#popup_select_first = 0
        let g:jedi#show_call_signatures = 0
        let g:jedi#use_tabs_not_buffers = 1
        autocmd FileType python setlocal completeopt-=preview

" Automate
    let g:lasttab = 1
    au TabLeave * let g:lasttab = tabpagenr()

    " Filetype specific
        au BufNewFile,BufRead COMMIT_EDITMSG set filetype=gitcommit | set tw=50

    if &diff != 1 && $NO_LCD != "true"
        autocmd BufEnter * silent! lcd %:p:h
    endif
