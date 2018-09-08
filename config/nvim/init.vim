filetype indent on
filetype plugin indent on
syntax on
scriptencoding utf-8
syntax enable

set number
set autoindent
set tabstop=2
set shiftwidth=2
set expandtab
set splitright
set clipboard^=unnamedplus
set hls
set noswapfile
set mouse-=a
set list
set listchars=tab:>-,trail:-
set ambiwidth=double
set fileencoding=utf-8
set showmatch

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if &compatible
  set nocompatible
endif
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  call dein#load_toml('~/.config/nvim/dein.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/dein_lazy.toml', {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif
if dein#check_install()
  call dein#install()
endif
filetype plugin indent on
syntax enable

:command UP UpdateRemotePlugins
