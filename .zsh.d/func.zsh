# key bindings
bindkey -d
bindkey -e
bindkey "^[OH" beginning-of-line
bindkey "^[OF" end-of-line
bindkey "^[[3~" delete-char
bindkey "^g" peco-find-file
bindkey "^f" fzf-find-file
bindkey "^r" peco-select-history
bindkey "^w" peco-search-source
bindkey "^@" peco-cdr
bindkey '^m' do_enter
bindkey '^]' peco-src
bindkey '^e' peco-branch
# bindkey '^e' anyframe-widget-cd-ghq-repository

# peco settings
peco-select-history() {
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

peco-search-source(){
  exec pt "$@" . | \
    peco --exec 'awk -F : '"'"'{print "+" $2 " " $1}'"'"' | \
    xargs nvim'
}
zle -N peco-search-source

peco-cdr () {
  local selected_dir=$(cdr -l | awk '{ print $2 }' | peco --prompt "[cd]")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle redisplay
}
zle -N peco-cdr

peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src

peco-find-file() {
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

fzf-find-file() {
  if git rev-parse 2> /dev/null; then
    source_files=$(git ls-files)
  else
    source_files=$(find . -type f)
  fi
  selected_files=$(echo $source_files | fzf --prompt "[find file]")

  result=''
  for file in $selected_files; do
    result="${result}$(echo $file | tr '\n' ' ')"
  done

  BUFFER="${BUFFER}${result}"
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N fzf-find-file

# other
do_enter() {
  if [ -n "$BUFFER" ]; then
    zle accept-line
    return 0
  fi
  echo
  ls -acGU
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

ghq-update() {
  ghq list | sed -E 's/^[^\/]+\/(.+)/\1/' | xargs -n 1 -P 10 ghq get -u
}

branch-clean() {
  if [[ -n $1 ]] ; then
    git branch G $1 | xargs -I% zsh -c 'echo start to delete branch %; git branch -d %;'
  else
    echo "invalid arguments...\n"
  fi
}

available () {
  local x candidates
  candidates="$1:"
  while [ -n "$candidates" ]
  do
    x=${candidates%%:*}
    candidates=${candidates#*:}
    if type "$x" >/dev/null 2>&1; then
      echo "$x"
      return 0
    else
      continue
    fi
  done
  return 1
}

branch-select-delete() {
  git branch | fzf | xargs git branch -d
}

fshow() {
  local out shas sha q k
  while out=$(
    git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
    fzf --ansi --multi --no-sort --reverse --query="$q" \
      --print-query --expect=ctrl-d); do
    q=$(head -1 <<< "$out")
    k=$(head -2 <<< "$out" | tail -1)
    shas=$(sed '1,2d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
    [ -z "$shas" ] && continue
    if [ "$k" = ctrl-d ]; then
      git diff --color=always $shas | less -R
    else
      for sha in $shas; do
        git show --color=always $sha | less -R
      done
    fi
  done
}

# open pull request
function openpr-by-file() {
  declare file
  [ $# -ne 0 ] && { file=${1}; } || { echo "need to assign target file"; return; }
  declare target=${2:-"develop"}

  PRS=$(git prlist ${file} ${target} | awk 'BEGIN {OFS="\t"} {print NR,$8,$1,$2,$10}' | sed -e 's%#%pull/%g' | peco)
  eval "hub browse -- $(echo ${PRS} | cut -f 2)"
}

lssh () {
  IP=$(lsec2 $@ | peco | awk -F "\t" '{print $2}')
  if [ $? -eq 0 -a "${IP}" != "" ]
  then
      ssh ${IP}
  fi
}

brew-cask-upgrade() {
  for app in $(brew cask list); do
    local latest="$(brew cask info "${app}" | awk 'NR==1{print $2}')";
    local versions=($(ls -1 "/usr/local/Caskroom/${app}/.metadata/"));
    local current=$(echo ${versions} | awk '{print $NF}');
    if [[ "${latest}" = "latest" ]]; then
      echo "[!] ${app}: ${current} == ${latest}"; [[ "$1" = "-f" ]] && brew cask install "${app}" --force; continue;
    elif [[ "${current}" = "${latest}" ]]; then
      continue;
    fi;
    echo "[+] ${app}: ${current} -> ${latest}"; brew cask uninstall "${app}" --force; brew cask install "${app}";
  done;
}

function peco-branch () {
    local branch=$(git branch -a | peco | tr -d ' ' | tr -d '*')
    if [ -n "$branch" ]; then
      if [ -n "$LBUFFER" ]; then
        local new_left="${LBUFFER%\ } $branch"
      else
        local new_left="$branch"
      fi
      BUFFER=${new_left}${RBUFFER}
      CURSOR=${#new_left}
    fi
}
zle -N peco-branch

open-localhost () {
  local url='http://localhost:'
  local default_port=3000
  while getopts p: OPT
  do
    case $OPT in
      p)
        port=$OPTARG
        ;;
    esac
  done

  shift $((OPTIND-1))
  if [[ "${port}" != "${default_port}" ]]; then
    chrome "${url}${port}"
  else
    chrome "${url}${default_port}"
  fi
}
