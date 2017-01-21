DOTPATH 	 := $(PWD)
TARGET 		 := $(wildcard .??*)
EXCLUSIONS := .DS_Store .git .gitmodules .gitignore
DOTFILES 	 := $(filter-out $(EXCLUSIONS), $(TARGET))
ZSHFILES   := $= .zsh.d .zshrc .zshenv

all:install

