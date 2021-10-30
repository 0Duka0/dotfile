" .cacheディレクトリが存在するかどうか {{{
let s:cache_dir_name = expand('~/vimrc/.cache') 
let s:dein_name = '/dein'
if !isdirectory(s:cache_dir_name)
  " .cacheディレクトリを作成
  call mkdir(s:cache_dir_name, 'p')
  let s:dein_dir = s:cache_dir_name . s:dein_name
  " /dein ディレクトリ作成
  call mkdir(s:dein_dir, 'p')
endif
" }}}

" dein.vim settings {{{
" install dir {{{
let s:dein_dir = s:cache_dir_name . s:dein_name
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
" }}}

" dein installation check {{{
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir
endif
" }}}

" begin settings {{{
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " .toml file
  let s:rc_dir = expand('~/vimrc/.vim')
  if !isdirectory(s:rc_dir)
    call mkdir(s:rc_dir, 'p')
  endif

  let s:toml = s:rc_dir . '/dein.toml'
  if !filereadable(s:toml)
    execute "redir > " . s:toml
    redir END 
  endif

  " read toml and cache 
  call dein#load_toml(s:toml, {'lazy': 0})

  " end settings
  call dein#end()
  call dein#save_state()
endif
" }}}

" plugin installation check {{{
if dein#check_install()
  call dein#install()
endif
" }}}

" plugin remove check {{{
let s:removed_plugins = dein#check_clean()
if len(s:removed_plugins) > 0
  call map(s:removed_plugins, "delete(v:val, 'rf')")
  call dein#recache_runtimepath()
endif
" }}}
