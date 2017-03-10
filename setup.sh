#!/bin/bash

echo "Downloading Vundle"
git submodule init
git submodule update

ROOT=`pwd`

echo "Linking vim files"

cp -r "$ROOT/.vim" ~/.vim
cp "$ROOT/.vimrc" ~/.vimrc

echo "Installing bundles"
vim +BundleInstall +qall

echo "Done"
