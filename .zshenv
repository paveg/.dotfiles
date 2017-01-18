setopt no_global_rcs
typeset -U path PATH cdpath fpath manpath
path=( \
    /usr/local/bin(N-/) \
    ~/bin(N-/) \
    ~/.zplug/bin(N-/) \
    ~/.tmux/bin(N-/) \
    "$path[@]" \
    )
#zmodload zsh/zprof && zprof
if [ -z $ZSH_ENV_LOADED ] ; then
  export DOTFILES=$HOME/.dotfiles
  export VIM=/usr/local/Cellar/neovim/0.1.7/share/nvim
  export ZPLUG_HOME=$HOME/.zplug
  export XDG_CONFIG_HOME="$DOTFILES/.config"
  export XDG_CACHE_HOME="$HOME/.cache"
  export ENHANCD_COMMAND=ed
  export ENHANCD_FILTER=ENHANCD_FILTER=fzy:fzf:peco
  # anyenv
  if [ -d $HOME/.anyenv ] ; then
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init - --no-rehash)"
    alias brew="env PATH=${PATH/\/Users\/$USERNAME\/.anyenv\/envs\/*env\/shims:/} brew"
    for D in `ls $HOME/.anyenv/envs`
    do
      export PATH="$HOME/.anyenv/envs/$D/shims:$PATH"
    done
  fi
  export GOPATH=$HOME
  export CLICOLOR=true
  export LSCOLORS='exfxcxdxbxGxDxabagacad'
  export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'
  export EDITOR=nvim
  export HISTFILE=$HOME/.zsh_history
  export HISTSIZE=1000000
  export SAVEHIST=1000000
  export LANG=ja_JP.UTF-8
  export ZSH_ENV_LOADED="1"
else
  print "skipped to read .zshenv \n"
fi

