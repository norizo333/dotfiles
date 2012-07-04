"vi非互換
set nocompatible

"NeoBundle
filetype off              
filetype plugin indent off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
  call neobundle#rc(expand('~/.vim/bundle/'))
endif

NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neocomplcache-snippets-complete'

"ファイルタイプ、プラグイン有効化
filetype on
filetype plugin on
filetype indent on

"シンタックス
syntax on

"インデント
set autoindent
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set backspace=2
set cindent

"対応括弧を表示
set showmatch matchtime=1

"行番号を表示
set number
highlight LineNr ctermfg=DarkGrey
"highlight LineNr ctermbg=white ctermfg=black

"モード表示
set showmode

"検索時に大小文字を区別しない
"大小文字の両方が含まれている場合は区別する
set ignorecase
set smartcase

"インクリメンタルサーチ
set incsearch

"検索文字の強調表示
set hlsearch

"ステータス行を表示
set laststatus=2

"ステータス行の指定
set statusline=%<%F\ %m%r%h%w
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
set statusline+=%=%l/%L,%c%V%8P

"コメントの自動挿入しない
autocmd FileType * setlocal formatoptions-=ro

".mはobjective-cとして扱う
let g:filetype_m = 'objc'

"入力モード時、ステータスラインのカラーを変更
let g:hi_insert = 'highlight StatusLine guifg=white guibg=red gui=none ctermfg=white ctermbg=red cterm=none'

if has('syntax')
  augroup InsertHook
  autocmd!
  autocmd InsertEnter * call s:StatusLine('Enter')
  autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction

"neocomplcache
let g:neocomplcache_enable_at_startup = 1
imap <C-k> <Plug>(neocomplcache_snippets_expand)
smap <C-k> <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()
" <CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

hi Pmenu ctermbg=Grey
hi PmenuSel ctermfg=Yellow ctermbg=Cyan
hi PmenuSbar ctermbg=DarkGrey
hi PmenuThumb ctermfg=Green

