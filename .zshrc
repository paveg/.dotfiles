if [ $DOTFILES/.zshrc -nt $HOME/.zshrc.zwc ] ; then
  zcompile $HOME/.zshrc
fi

source $ZPLUG_HOME/init.zsh

if [ -e $ZPLUG_HOME ] ; then

  # define plugin
  zplug 'zsh-users/zsh-autosuggestions'
  zplug 'zsh-users/zsh-completions'
  zplug 'zsh-users/zsh-syntax-highlighting', defer:2
  zplug 'zsh-users/zsh-history-substring-search'
  zplug 'b4b4r07/enhancd', use:enhancd.sh
  zplug 'mollifier/anyframe'
  zplug 'mollifier/cd-gitroot'
  zplug 'peco/peco', as:command, from:gh-r, use:"*amd64*"
  zplug 'b4b4r07/dotfiles', as:command, use:bin/peco-tmux
  zplug 'chrissicool/zsh-256color', use:"zsh-256color.plugin.zsh"
  zplug 'nojhan/liquidprompt'
  zplug "b4b4r07/emoji-cli", on:"stedolan/jq"
  #zplug 'yonchu/zsh-vcs-prompt'

  # install
  #if ! zplug check --verbose; then
  #  printf 'Install? [y/N]: '
  #  if read -q; then
  #    echo; zplug install
  #  fi
  #fi
  zplug load --verbose
fi

# Completion
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' use-cache true
zstyle ':completion:*' verbose yes
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:options' description 'yes'

# key bindingsnd
bindkey "^[OH" beginning-of-line
bindkey "^[OF" end-of-line
bindkey "^[[3~" delete-char
bindkey "^g" peco-find-file
bindkey "^r" peco-select-history
bindkey "^@" peco-cdr
bindkey '^m' do_enter
bindkey '^]' peco-src
bindkey '^e' anyframe-widget-cd-ghq-repository

## options
setopt ignore_eof
setopt prompt_subst
setopt auto_cd
setopt auto_param_keys
setopt auto_param_slash
setopt interactive_comments
setopt no_beep
setopt no_hist_beep
setopt no_list_beep
setopt magic_equal_subst
setopt notify
setopt print_eight_bit
setopt print_exit_value
setopt pushd_ignore_dups
setopt rm_star_wait
setopt share_history
setopt transient_rprompt
setopt correct

## history
setopt share_history
setopt pushd_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt extended_history
setopt inc_append_history

## alias
alias ...='../..'
alias ....='../../..'
alias .....='../../../..'
# some more ls aliases
alias ll='ls -alfrtG'
alias la='ls -aG'
alias l='ls -cfG'
alias ls='ls -G'
# some more vi aliases
alias vi='nvim'
alias vim='nvim'
# others
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
# after sudo command ...
alias sudo='sudo '
# mdfind
alias mdf='mdfind'
alias mdfo='mdfind -onlyin'
# my aliases
alias rre="rbenv rehash"
alias be="bundle exec"
alias g='git'
# some more global aliases
alias -g L='| less'
alias -g G='| grep'
alias -g B='`git branch -a | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`'
alias -g R='`git remote | peco --prompt "GIT REMOTE>" | head -n 1`'
alias ctags="`brew --prefix`/bin/ctags"
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

## others

case ${OSTYPE} in
  darwin*)
    function tp() {
      if [ $# -ne 1 ] ; then
        echo "    invalid argument."
        echo "    use 0 - 9"
      else
        echo "
          tell application \"iTerm\"
            activate -- make window active
            tell current session of current window
              set transparency to $1/10
            end tell
          end tell
        " | /usr/bin/osascript -
      fi
    }
    ;;
esac

# peco settings
function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history

function peco-cdr () {
  local selected_dir=$(cdr -l | awk '{ print $2 }' | peco --prompt "[cd]")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle redisplay
}
zle -N peco-cdr

function do_enter() {
    if [ -n "$BUFFER" ]; then
        zle accept-line
        return 0
    fi
    echo
    ls -cfG
    # ↓おすすめ
    # ls_abbrev
    if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
        echo
        echo -e "\e[0;33m--- git status ---\e[0m"
        git status -sb
    fi
    zle reset-prompt
    return 0
}
zle -N do_enter

function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src

function peco-find-file() {
  if git rev-parse 2> /dev/null; then
    source_files=$(git ls-files)
  else
    source_files=$(find . -type f)
  fi
  selected_files=$(echo $source_files | peco --prompt "[find file]")

  result=''
  for file in $selected_files; do
    result="${result}$(echo $file | tr '\n' ' ')"
  done

  BUFFER="${BUFFER}${result}"
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N peco-find-file

#if (which zprof > /dev/null) ;then
#  zprof | less
#fi
