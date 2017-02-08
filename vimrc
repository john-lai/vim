call pathogen#infect()
filetype plugin indent on

"�����﷨����
syntax on

"���ļ����������Զ�����
filetype indent plugin on

"��ʾ��ǰ���к��к�
set ruler
set rulerformat=%20(%2*%<%f%=\ %m%r\ %3l\ %c\ %p%%%)

"��״̬����ʾ�������������
set showcmd

"����backspacing
set backspace=indent,eol,start

"��������֧��
set fileencodings=utf-8,gbk,gb2312,cp936,gb18030,latin1
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936
set termencoding=utf-8

"��������
set guifont=Dejavu_Sans_Mono:h11:cANSI

"���
set mouse=a

"��ɫ����
colorscheme koehler

"�������Դ�Сд
set ignorecase

"���д���ʱ����������
set flash
set noerrorbells
set novisualbell
set t_vb=

"ʹ��ע�ͻ���ʱ�Զ�����ǰ���Ŀո���Ǻ�
set formatoptions=tcqro

"״̬������:�ļ�·�����ļ�������ǡ��ļ����͡��ַ����롢�ļ���ʽ����ǰλ�á���ǰ���λ�á��ļ������������ڡ�����
"set statusline=%F\ %h%1*%m%r%w%0*[%{strlen(&filetype)?&filetype:'none'},%{&encoding},%{&fileformat}]%=%-14.(%l,%c%V%)\ %<%p%%\ \ \ [%L]\ \ \ %{strftime('%y-%m-%d\ %A')}
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
"�������ģʽʱ�ı�״̬����ɫ��������Vim 7��
"������ʾ״̬��
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

"���ô��ڵ���ʼλ�úʹ�С
"winpos 200 200
"set lines=35
"set columns=90

"�������
if has('win32')
	au GUIEnter * simalt ~x
else
	au GUIEnter * call MaximizeWindow()
endif

function MaximizeWindow()
	silent ! wmctrl -r:ACTIVE: -b add , maximized_vert, maximized_horz
endfunction

"�� Alt+n �л� Vim �ı�ǩ
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

"�ر�/��������Ÿ���
set showmatch

"ƥ�����Ÿ�����ʱ��
set matchtime=2

"��ʾ�к�:
set number
"Ϊ���㸴�ƣ���<F2>����/�ر��к���ʾ��
nnoremap <F2> : set nonumber!<CR>:set foldcolumn=0<CR>

"����Modeline
set modeline

"Ϊ��ɫ����������ɫ
set background=dark

set helplang=cn "����ϵͳ����Ϊ����

"��Vim�Ĳ�ȫ�˵���Ϊ��һ��IDEһ��(�ο�VimTip1228)
set completeopt+=longest,menu
 
"�뿪����ģʽ���Զ��ر�Ԥ������
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
 
"�س���ѡ�е�ǰ��
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
 
"�������Ҽ�����Ϊ
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

set nobackup      " do not keep a backup file, use versions instead

"�Զ���ȫ
let g:acp_completeoptPreview=1

"����ע��
"=====ToDo

"��������
set sw=4
set ts=4
"�����Զ����������
filetype indent on
"����Python���ԵĽ��飨��tabչ���ĸ��ո񣩽�����ר������
autocmd FileType python setlocal et sta sw=4 sts=4

"��������д������quickfix����
"ע�⣺��Ҫ����netsting autocmd
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

"�����۵�
set foldmethod=syntax
"Ĭ������²��۵�
set foldlevel=99
map <F3> za

"�ִ��Ĵ���ṹ�������
nmap <F8> :TagbarToggle<CR>


"=============Python==============
autocmd FileType python setlocal foldmethod=indent
"Ĭ��չ�����д��� 
set foldlevel=99

if has("gui_running") 
          highlight SpellBad term=underline gui=undercurl guisp=Orange 
endif 
"��ֹPyFlakesʹ��QuickFix�������ڰ���<F7>ʱ�����flake8�����ж��ڴ���༭ʱ�Ĵ������ܵõ���Ч����ʾ
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

"�Զ���NERDTree
"autocmd vimenter * NERDTree

" �����ļ������
map <D-1> :NERDTreeToggle <CR>
" ���ļ�������ж�λ��ǰ�ļ�
map <D-!> :NERDTreeFind <CR>
" �ر��ļ�ʱͬʱ�ر��ļ������
let NERDTreeQuitOnOpen = 1

" ���ļ���λ����
nnoremap <slient> <D-R> :CommandT<CR>
" ������򿪵��ļ��б�
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
