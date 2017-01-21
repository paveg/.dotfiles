export DOTFILES=$HOME/.dotfiles
export ZDOTDIR=$DOTFILES/.zsh.d

. $DOTFILES/etc/libs.zsh

# loadfiles
loadlib $ZDOTDIR/00_utils.zsh
# loadlib $ZDOTDIR/01_dev.zsh
loadlib $ZDOTDIR/02_setopt.zsh
loadlib $ZDOTDIR/03_alias.zsh
loadlib $ZDOTDIR/04_func.zsh
loadlib $ZDOTDIR/05_os.zsh
loadlib $ZDOTDIR/06_misc.zsh
loadlib $ZDOTDIR/07_tmux.zsh
loadlib $ZDOTDIR/08_keybind.zsh

autoload -U promptinit; promptinit
prompt pure

if [[ -f $ZPLUG_HOME/init.zsh ]]; then
  export ZPLUG_LOADFILE=$ZDOTDIR/zplug.zsh
  # For development version of zplug
  # source ~/.zplug/init.zsh
  source $ZPLUG_HOME/init.zsh

  # install check
  if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
      echo; zplug install
    fi
      echo
  fi
  zplug load
fi

eval "$(direnv hook zsh)"

if (which zprof > /dev/null) ;then
  zprof | less
fi
