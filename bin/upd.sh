#!/bin/bash

echo "Updating packages..."
if [[ $OSTYPE =~ ^darwin ]]; then
  brew update
  brew upgrade
  brew bundle
elif [[ $OSTYPE =~ ^linux ]]; then
  sudo apt update
  sudo apt upgrade -y
fi

echo "Updating VIM and it's plugins..."
vim +PlugUpdate +PlugUpgrade +qall
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer --go-completer --ts-completer --rust-completer

echo "Done!"
