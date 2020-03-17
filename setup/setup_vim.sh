#!/usr/bin/bash

if [ ! -d ~/bin ]
then
    mkdir -p ~/bin
fi


if [ ! -d ~/src ]
then
    mkdir -p ~/src
fi

pushd .
cd ~/src

git clone https://github.com/vim/vim

cd vim

./configure \
    --with-features=huge \
    --enable-multibyte \
    --enable-python3interp=yes \
    --with-python3-config-dir=$(python3-config --configdir) \
    --enable-luainterp=yes \
    --enable-cscope \
    --prefix=$HOME

make

make install

cd $HOME

mv ~/.vimrc ~/.vimrc.back

ln -s ~/dot-config/vim/.vimrc .vimrc

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

vim +PluginInstall +qall

cd $HOME/.vim/bundle/youcompleteme/

python3 install.py --clang-completer

cd $HOME/.vim/bundle/color_coded
mkdir build
cd build
cmake ..
make
make install

popd

echo "Vim successfully installed"
