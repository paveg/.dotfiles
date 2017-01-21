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
zplug "b4b4r07/emoji-cli", on:"stedolan/jq"
zplug 'mafredri/zsh-async', from:'github'
zplug 'sindresorhus/pure', use:'pure.zsh', from:'github', as:'theme'
# zplug 'nojhan/liquidprompt'
# zplug 'yonchu/zsh-vcs-prompt'
