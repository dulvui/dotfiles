#!/bin/bash

# configure
mkdir -p ~/.config/sway

ln -s $config_path/sway/config ~/.config/sway/
ls -l $config_path/sway/config ~/.config/sway/

chmod a+x $config_path/sway/config.d/*.sh

# mkdir -p ~/.config/sway/config.d/
# ln -s $config_path/sway/config.d/* ~/.config/sway/config.d/

