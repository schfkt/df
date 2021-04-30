#!/bin/bash

echo "Updating packages..."
if [[ $OSTYPE =~ ^darwin ]]; then
  brew update
  brew upgrade
  brew bundle
elif [[ $OSTYPE =~ ^linux ]]; then
  sudo dnf update
fi

echo "Updating VIM and it's plugins..."
if [[ $OSTYPE =~ ^darwin ]]; then
  vim +PluginUpdate +qall
elif [[ $OSTYPE =~ ^linux ]]; then
  vimx +PluginUpdate +qall
fi
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer --go-completer --ts-completer --rust-completer

echo "Done!"
