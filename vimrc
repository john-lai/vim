call pathogen#infect()
filetype plugin indent on

"开启语法高亮
syntax on

"依文件类型设置自动缩进
filetype indent plugin on

"显示当前的行号列号
set ruler
set rulerformat=%20(%2*%<%f%=\ %m%r\ %3l\ %c\ %p%%%)

"在状态栏显示正在输入的命令
set showcmd

"允许backspacing
set backspace=indent,eol,start

"设置语言支持
set fileencodings=utf-8,gbk,gb2312,cp936,gb18030,latin1
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936
set termencoding=utf-8

"字体设置
set guifont=Dejavu_Sans_Mono:h11:cANSI

"鼠标
set mouse=a

"配色方案
colorscheme koehler

"搜索忽略大小写
set ignorecase

"当有错误时不发出声音
set flash
set noerrorbells
set novisualbell
set t_vb=

"使得注释换行时自动加上前导的空格和星号
set formatoptions=tcqro

"状态栏设置:文件路径、文件名、标记、文件类型、字符编码、文件格式、当前位置、当前相对位置、文件总行数、日期、星期
"set statusline=%F\ %h%1*%m%r%w%0*[%{strlen(&filetype)?&filetype:'none'},%{&encoding},%{&fileformat}]%=%-14.(%l,%c%V%)\ %<%p%%\ \ \ [%L]\ \ \ %{strftime('%y-%m-%d\ %A')}
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
"进入插入模式时改变状态栏颜色（仅限于Vim 7）
"总是显示状态行
set laststatus=2
if version >= 700
au InsertEnter * hi StatusLine guibg=#818D29 guifg=#FCFCFC gui=none
au InsertLeave * hi StatusLine guibg=#EEEEEE guifg=#363636 gui=none
endif

source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

"设置窗口的起始位置和大小
"winpos 200 200
"set lines=35
"set columns=90

"窗口最大化
if has('win32')
	au GUIEnter * simalt ~x
else
	au GUIEnter * call MaximizeWindow()
endif

function MaximizeWindow()
	silent ! wmctrl -r:ACTIVE: -b add , maximized_vert, maximized_horz
endfunction

"用 Alt+n 切换 Vim 的标签
function! TabPos_ActivateBuffer(num) 
let s:count = a:num 
exe "tabfirst" 
exe "tabnext" s:count 
endfunction 
function! TabPos_Initialize() 
for i in range(1, 9) 
exe "map <M-" . i . "> :call TabPos_ActivateBuffer(" . i . ")<CR>" 
endfor 
exe "map <M-0> :call TabPos_ActivateBuffer(10)<CR>" 
endfunction 
autocmd VimEnter * call TabPos_Initialize()

"关闭/打开配对括号高亮
set showmatch

"匹配括号高亮的时间
set matchtime=2

"显示行号:
set number
"为方便复制，用<F2>开启/关闭行号显示：
nnoremap <F2> : set nonumber!<CR>:set foldcolumn=0<CR>

"启用Modeline
set modeline

"为深色背景调整配色
set background=dark

set helplang=cn "帮助系统设置为中文

"让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
set completeopt+=longest,menu
 
"离开插入模式后自动关闭预览窗口
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
 
"回车即选中当前项
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
 
"上下左右键的行为
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

set nobackup      " do not keep a backup file, use versions instead

"自动补全
let g:acp_completeoptPreview=1

"多行注释
"=====ToDo

"缩进设置
set sw=4
set ts=4
"开启自动的缩进检测
filetype indent on
"根据Python语言的建议（将tab展成四个空格）进行了专门设置
autocmd FileType python setlocal et sta sw=4 sts=4

"编译后，如有错误则打开quickfix窗口
"注意：需要开启netsting autocmd
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

"代码折叠
set foldmethod=syntax
"默认情况下不折叠
set foldlevel=99
map <F3> za

"现代的代码结构浏览工具
nmap <F8> :TagbarToggle<CR>


"=============Python==============
autocmd FileType python setlocal foldmethod=indent
"默认展开所有代码 
set foldlevel=99

if has("gui_running") 
          highlight SpellBad term=underline gui=undercurl guisp=Orange 
endif 
"禁止PyFlakes使用QuickFix，这样在按下<F7>时会调用flake8，而有对于代码编辑时的错误仍能得到有效的提示
let g:pyflakes_use_quickfix = 0

au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix
autocmd FileType python set omnifunc=pythoncomplete#Complete

let g:pydiction_location = 'D:/Program Files/Vim/vim73/ftplugin/pydiction/complete-dict'

if has("autocmd")
  autocmd FileType python set complete+=k"D:/Program Files/Vim/vim73/ftplugin/pydiction/"
endif


"powerline{
set guifont=PowerlineSymbols\ for\ Powerline
set nocompatible
set t_Co=256
let g:Powerline_symbols = 'fancy'
"}

"自动打开NERDTree
"autocmd vimenter * NERDTree

" 开关文件浏览器
map <D-1> :NERDTreeToggle <CR>
" 在文件浏览器中定位当前文件
map <D-!> :NERDTreeFind <CR>
" 关闭文件时同时关闭文件浏览器
let NERDTreeQuitOnOpen = 1

" 打开文件定位窗口
nnoremap <slient> <D-R> :CommandT<CR>
" 打开最近打开的文件列表
nnoremap <slient> <D-E> :CommandTBuffer<CR>

"""""""""""""""Tlist"""""""""""""""""""""
let Tlist_Auto_Open = 0 
let Tlist_Ctags_Cmd = '/usr/bin/ctags'
let Tlist_Show_One_File = 1 
let Tlist_Exit_OnlyWindow = 1 

let g:agprg="<custom-ag-path-goes-here> --column"
let g:ag_working_path_mode="r"
let g:ag_prg="ag --vimgrep --smart-case"
set runtimepath^=~/.vim/bundle/ag
