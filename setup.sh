#!/bin/sh

echo "current: $PWD"

ln -sfv "$PWD/.zsh.d/.zshrc" "$HOME/.zshrc"
ln -sfv "$PWD/.zsh.d/.zshenv" "$HOME/.zshenv"
ln -sfv "$PWD/.tmux.conf" "$HOME/.tmux.conf"
# for homebrew
ln -sfv "$HOME/Brewfile" "$PWD/Dropbox/dev/Brewfile"

# for nvim
if [[ -z $XDG_CONFIG_HOME ]]; then
  XDG_CONFIG_HOME="$HOME/.config"
fi
if [[ -d $XDG_CONFIG_HOME/nvim ]]; then
  echo "$XDG_CONFIG_HOME exists"
else
  mkdir "$XDG_CONFIG_HOME/nvim"
fi

ln -sfv "$PWD/config/nvim/dein.toml" "$XDG_CONFIG_HOME/nvim/dein.toml"
ln -sfv "$PWD/config/nvim/dein_lazy.toml" "$XDG_CONFIG_HOME/nvim/dein_lazy.toml"

