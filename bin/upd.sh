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

echo "Updating neovim and it's plugins..."
nvim +PlugUpdate +PlugUpgrade +qall

echo "Done!"
