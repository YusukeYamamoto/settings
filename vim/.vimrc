scriptencoding utf-8
set nocompatible

if has('vim_starting')
      filetype plugin off
        filetype indent off
          execute 'set runtimepath+=' . expand('~/.vim/bundle/neobundle.vim')
          endif
          call neobundle#rc(expand('~/.vim/bundle'))

          NeoBundle 'git://github.com/kien/ctrlp.vim.git'
          NeoBundle 'git://github.com/Shougo/neobundle.vim.git'
          NeoBundle 'git://github.com/scrooloose/nerdtree.git'
          NeoBundle 'git://github.com/scrooloose/syntastic.git'

          syntax on
          filetype plugin on
          filetype indent on

          " SSH クライアントの設定によってはマウスが使える（putty だと最初からいける）
          set mouse=n

" バッファエクスプローラー
:let g:miniBufExplMapWindowNavVim = 1
:let g:miniBufExplMapWindowNavArrows = 1
:let g:miniBufExplMapCTabSwitchBuffs = 1

"クリップボードをWindowsと連携
set clipboard=unnamed
"Vi互換をオフ
set nocompatible
"タブの代わりに空白文字を挿入する
set expandtab
"変更中のファイルでも、保存しないで他のファイルを表示
set hidden
"インクリメンタルサーチを行う
set incsearch
"タブ文字、行末など不可視文字を表示する
set list
"listで表示される文字のフォーマットを指定する
set listchars=eol:$,tab:>\ ,extends:<
"行番号を表示する
set number
"シフト移動幅
"set shiftwidth=4
"閉じ括弧が入力されたとき、対応する括弧を表示する
set showmatch
"検索時に大文字を含んでいたら大/小を区別
set smartcase
"新しい行を作ったときに高度な自動インデントを行う
set smartindent
"行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
set smarttab
set backspace=indent,eol,start "Backspaceキーの影響範囲に制限を設けない
set whichwrap=b,s,h,l,<,>,[,] "行頭行末の左右移動で行をまたぐ
set scrolloff=8                "上下8行の視界を確保

"ファイル内の  が対応する空白の数
set tabstop=4
"縦幅
set lines=40
"横幅
set columns=120
"入力モード時、ステータスラインのカラーを変更
augroup InsertHook
autocmd!
autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
augroup END
"日本語入力をリセット
au BufNewFile,BufRead * set iminsert=0
"タブ幅をリセット
au BufNewFile,BufRead * set tabstop=4 shiftwidth=4

"カラースキーマを設定
colorscheme koehler
syntax on
let g:molokai_original = 1
let g:rehash256 = 1
"set background=dark"

"----------------------------------------------------
" Emacs風関係
"----------------------------------------------------
" コマンド入力中断
"imap <silent> <C-g> <ESC><ESC><ESC><CR>i
" 消去、編集
imap <C-k> <ESC>d$i
imap <C-y> <ESC>pi
imap <C-d> <ESC>xi

imap <C-l> <ESC>:MiniBufExplorer<CR>

"imap <C-e>  <End>
"imap <C-b>  <Left>hogehoge
""imap <C-f>  <Right>
"imap <C-n>  <Down>
"imap <C-p>  <UP>
"imap <ESC>< <ESC>ggi
"imap <ESC>> <ESC>Gi

" NERD
"imap <C-e> <ESC>:NERDTree

" ファイル
"imap <C-c><C-c>  <ESC>:qa<CR>
"imap <C-x><C-c>  <ESC>:qa!<CR>
"imap <C-w><C-w>  <ESC>:w<CR>
"imap <C-x><C-w>  <ESC>:w!<CR>
"imap <C-x><C-f>  <ESC>:e 

