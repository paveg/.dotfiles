# cd
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# ls
alias ll='ls -alfrtG'
alias la='ls -aG'
alias l='ls -cfG'
alias ls='ls -G'

# vi
alias v='nvim'
alias vim='nvim'

# file utils
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

# suffix alias
alias -s hs=runhaskell
alias -s py=python
alias -s rb=ruby
alias -s c=runc
alias -s cpp=runcpp
alias -s go='go run'

# zshtime
alias zshtime10='for i in $seq 1 10); do time zsh -i -c exit; done'
alias zshtime='time zsh -i -c'
done
