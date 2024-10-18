#!/bin/bash

# install build deps
apt install -y ninja-build gettext cmake unzip curl build-essential

make CMAKE_BUILD_TYPE=RelWithDebInfo
cd build && cpack -G DEB

# as root with su -
dpkg -i nvim-linux64.deb
