umask 022
limit coredumpsize 0
bindkey -d

. $DOTFILES/etc/libs.zsh

# loadfiles
loadlib $ZDOTDIR/utils.zsh
loadlib $ZDOTDIR/dev.zsh
loadlib $ZDOTDIR/normal_opt.zsh
loadlib $ZDOTDIR/alias.zsh
loadlib $ZDOTDIR/func.zsh
loadlib $ZDOTDIR/os.zsh
loadlib $ZDOTDIR/tmux.zsh

if [ -n "${DOCKER_CONTAINER}" ]; then
  PROMPT="(${DOCKER_CONTAINER})%# "
fi
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
