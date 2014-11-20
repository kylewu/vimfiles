#!/bin/bash

echo "Downloading Vundle"
git submodule init
git submodule update

ROOT=`pwd`

echo "Linking vim files"

ln -s "$ROOT/.vim" ~
ln -s "$ROOT/.vimrc" ~

echo "Installing bundles"
vim +BundleInstall +qall

echo "Done"
