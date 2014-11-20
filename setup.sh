#!/bin/bash

echo "Linking vim files"

ln -s "($pwd)/.vim" ~/
ln -s "($pwd)/.vimrc" ~/

echo "Installing bundles"
vim +BundleInstall +qall

echo "Done"
