typeset -gx -U path
setopt no_global_rcs

path=( \
    /usr/local/bin(N-/) \
    ~/bin(N-/) \
    ~/.zplug/bin(N-/) \
    ~/.tmux/bin(N-/) \
    "$path[@]" \
    )

# zmodload zsh/zprof && zprof

autoload -Uz run-help
autoload -Uz add-zsh-hook
autoload -Uz colors && colors
# autoload -Uz compinit && compinit -u -> comment out for speed-up
autoload -Uz is-at-least
autoload -Uz promptinit
promptinit
# prompt pure


# set dotfiles, zdotdir, zplug_home
export DOTFILES=$HOME/.dotfiles
export ZDOTDIR=$DOTFILES/.zsh.d
export ZPLUG_HOME=$HOME/.zplug

# openssl
export LD_LIBRARY_PATH=/usr/local/opt/openssl/lib:$LD_LIBRARY_PATH
export CPATH=/usr/local/opt/openssl/include:$LD_LIBRARY_PATH

# language
export LANGUAGE=ja_JP.UTF-8
export LANG="${LANGUAGE}"
export LC_ALL="${LANGUAGE}"
export LC_CTYPE="${LANGUAGE}"

# Editor
export EDITOR=nvim
export CVSEDITOR="${EDITOR}"
export SVN_EDITOR="${EDITOR}"
export GIT_EDITOR="${EDITOR}"

export VIM=/usr/local/Cellar/neovim/0.1.7/share/nvim
export XDG_CONFIG_HOME=$DOTFILES/config
export XDG_CACHE_HOME=$HOME/.cache
export ENHANCD_COMMAND=ed
export ENHANCD_FILTER=ENHANCD_FILTER=fzy:fzf:peco

export ANYENV_ROOT=$HOME/.anyenv
export GOPATH=$HOME
export CONFIGURE_OPTS="--with-readline-dir=`brew --prefix readline` --with-openssl-dir=`brew --prefix openssl` --with-iconv-dir=`brew --prefix libiconv` --disable-install-rdoc"
export CLICOLOR=true
export LSCOLORS='exfxcxdxbxGxDxabagacad'
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000

export FZF_DEFAULT_OPTS="--extended --ansi --multi"
export HOMEBREW_BREWFILE=$HOME/Brewfile

