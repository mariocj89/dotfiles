filetype plugin indent on
syntax on

" vim behaviour {
    set history=1000                " remember more commands and search history
    set undolevels=1000             " use many muchos levels of undo
    set noswapfile                  " do not write annoying intermediate swap files,
                                    "    who did ever restore from swap files anyway?
    set wildmenu                    " make tab completion for files/buffers act like bash
    set wildmode=list:full          " show a list when pressing tab and complete
                                    "    first full match
    "set wildmode=longest,list
    "set wildignore=*.swp,*.bak,*.pyc,*.class
    set title                       " change the terminal's title
    let &titleold=$SHELL_TITLE        " change the terminal's title when exiting vim
    set noerrorbells                " don't beep
    set showcmd                     " show (partial) command in the last line of the screen
                                    "    this also shows visual selection info
    set nomodeline                  " disable mode lines (security measure)
    set ttyfast                     " always use a fast terminal
    set cursorline                  " underline the current line, for quick orientation
" }

" Editing behaviour {
    set pastetoggle=<F2>
    set showmode
    set showmode                    " always show what mode we're currently editing in
    "set nowrap                      " don't wrap lines
    set tabstop=4                   " a tab is four spaces
    set softtabstop=4               " when hitting <BS>, pretend like a tab is removed, even if spaces
    set expandtab                   " expand tabs by default (overloadable per file type later)
    set shiftwidth=4                " number of spaces to use for autoindenting
    set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
    set backspace=indent,eol,start  " allow backspacing over everything in insert mode
    set autoindent                  " always set autoindenting on
    set copyindent                  " copy the previous indentation on autoindenting
    set number                      " always show line numbers
                                    "    case-sensitive otherwise
    set smarttab                    " insert tabs on the start of a line according to
                                    "    shiftwidth, not tabstop
    set scrolloff=4                 " keep 4 lines off the edges of the screen when scrolling
    set virtualedit=all             " allow the cursor to go in to "invalid" places

    set nolist                      " don't show invisible characters by default,
                                    " but it is enabled for some file types (see later)
    set spell spelllang=en_us
" }


" Searching {
    "set gdefault                    " search/replace "globally" (on a line) by default
    set showmatch                   " set show matching parenthesis
    set smartcase                   " ignore case if search pattern is all lowercase,
    nnoremap <leader><space> :noh<cr>
    nnoremap <tab> %
    vnoremap <tab> %
    set hlsearch                    " highlight search terms
    set incsearch                   " show search matches as you type
    nnoremap / /\v
    vnoremap / /\v
    colorschem desert
" }


" Status line {
    set termencoding=utf-8
    set encoding=utf-8
    set ff=unix
    set t_Co=256
    set lazyredraw                  " don't update the display while executing macros
    set laststatus=2                " tell VIM to always put a status line in, even
                                    "    if there is only one window
    set cmdheight=2                 " use a status bar that is 2 rows high
    set statusline=%F%m\ %r\ Line:%l\/%L,%c\ %p%% " Format the statusline
    set ruler       " Afficher la position du curseur
    sy on
" }

" Auto delete trailing spaces
autocmd BufWritePre * :%s/\s\+$//e


set nocompatible " it's vim not vi, for Christ sake!
syntax on " why not?

" next function allows you to do completion of words by pressing <Tab>
function! InsertTabWrapper(direction)
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    elseif "backward" == a:direction
        return "\<c-p>"
    else
        return "\<c-n>"
    endif
endfunction

inoremap <tab> <c-r>=InsertTabWrapper ("forward")<cr>
inoremap <s-tab> <c-r>=InsertTabWrapper ("backward")<cr>

" Open Python wheels as zip
au BufReadCmd *.whl call zip#Browse(expand("<amatch>"))

hi clear SpellBad
hi SpellBad cterm=underline ctermfg=red
