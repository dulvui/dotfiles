#!/bin/bash

cd ~

# install vim-plug https://github.com/junegunn/vim-plug
if [ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]; then
	curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	echo "vim-plug installed"
else
	echo "vim-plug already installed"
fi

mkdir ~/.config/nvim
ln -s $config_path/nvim/init.lua ~/.config/nvim/init.lua  
ls -l $config_path/nvim/init.lua ~/.config/nvim/init.lua  
