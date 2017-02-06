alias p="print -l"

# For mac, aliases
if is_osx; then
    has "qlmanage" && alias ql='qlmanage -p "$@" >&/dev/null'
    alias gvim="open -a MacVim"
fi

if has 'git'; then
    alias gst='git status'
fi

if has 'richpager'; then
    alias cl='richpager'
fi

if (( $+commands[gls] )); then
    alias ls='gls -F --color --group-directories-first'
elif (( $+commands[ls] )); then
    if is_osx; then
        alias ls='ls -GF'
    else
    alias ls='ls -F --color'
    fi
fi

# Common aliases
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias ld='ls -ld'          # Show info about the directory
alias lla='ls -lAF'        # Show hidden all files
alias ll='ls -lF'          # Show long file information
alias la='ls -AF'          # Show hidden files
alias lx='ls -lXB'         # Sort by extension
alias lk='ls -lSr'         # Sort by size, biggest last
alias lc='ls -ltcr'        # Sort by and show change time, most recent last
alias lu='ls -ltur'        # Sort by and show access time, most recent last
alias lt='ls -ltr'         # Sort by date, most recent last
alias lr='ls -lR'          # Recursive ls
alias hi='history'

# The ubiquitous 'll': directories first, with alphanumeric sorting:
#alias ll='ls -lv --group-directories-first'

alias rm="${ZSH_VERSION:+nocorrect} rm -i"
alias cp="${ZSH_VERSION:+nocorrect} cp -i"
alias mv="${ZSH_VERSION:+nocorrect} mv -i"
alias mkdir="${ZSH_VERSION:+nocorrect} mkdir -p"

autoload -Uz zmv
alias zmv='noglob zmv -W'

alias du='du -h'
alias job='jobs -l'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Use if colordiff exists
if has 'colordiff'; then
    alias diff='colordiff -u'
else
    alias diff='diff -u'
fi

# Use plain vim.
alias vi="vim"

alias v='nvim'
alias vim='nvim'

# The first word of each simple command, if unquoted, is checked to see if it has an alias.
# [...] If the last character of the alias value is a space or tab character,
# then the next command word following the alias is also checked for alias expansion.
alias sudo='sudo '
if is_osx; then
    alias sudo="${ZSH_VERSION:+nocorrect} sudo "
fi

# Global aliases
alias -g G=  '| grep'
alias -g GG= '| multi_grep'
alias -g W=  '| wc'
alias -g X=  '| xargs'
alias -g F=  '| "$(available $INTERACTIVE_FILTER)"'
alias -g S=  "| sort"
alias -g V=  "| tovim"
alias -g N=  " >/dev/null 2>&1"
alias -g N1= " >/dev/null"
alias -g N2= " 2>/dev/null"
alias -g VI= '| xargs -o vim'

# mdfind
alias mdf='mdfind'
alias mdfo='mdfind -onlyin'

# my aliases
alias be="bundle exec"
alias git='hub'
alias g='git'

# suffix alias
alias -s hs=runhaskell
alias -s py=python
alias -s rb=ruby
alias -s c=runc
alias -s cpp=runcpp
alias -s go='go run'

# zshtime
alias zshtime10='for i in $(seq 1 10); do time zsh -i -c exit; done'
alias zshtime='time zsh -i -c exit;'

