#!/bin/sh

# run as root

#####################################################
# debian packages
#####################################################

# base
apt install -y keepassxc 
apt install -y chromium
apt install -y thunderbird
apt install -y firefox-esr
apt install -y gimp
apt install -y krita
apt install -y libreoffice-gtk3
apt install -y gedit

# audio
apt install -y pipewire
apt install -y wireplumber
apt install -y pipewire-alsa
apt install -y pipewire-audio 
apt install -y pipewire-audio-client-libraries
apt install -y pipewire-bin
apt install -y pipewire-jack
apt install -y pipewire-pulse
# cli audio control
apt install -y pulsemixer

# bluetooth
apt install -y bluez
apt install -y blueman
apt install -y libspa-0.2-bluetooth

# thunar
apt install -y thunar
apt install -y thunar-archive-plugin
apt install -y thunar-archive-plugin
apt install -y unrar-free

# terminal/cli tools
apt install -y curl
apt install -y git
apt install -y htop
apt install -y ffmpeg
apt install -y fzf 
apt install -y ripgrep
apt install -y trash-cli
apt install -y foot foot-themes
apt install -y wl-clipboard
apt install -y fd-find
apt install -y tmux
apt install -y sudo

# dev
apt install -y openjdk-17-jdk

# syncthing
apt install -y syncthing
systemctl enable syncthing@dulvui

# hstr
apt install -y hstr
# hstr --show-configuration >> /home/dulvui/.bashrc

# podman
apt install -y podman podman-compose podman-toolbox

# sway
apt install -y  sway waybar kanshi swayidle swaylock light wlsunset wofi waybar
apt install -y xwayland xserver-xorg-video-intel
apt install -y network-manager
# apt install -y fonts-font-awesome
# screenshots
apt install -y slurp grimshot
# notifications
apt install -y mako-notifier
# backgrounds
apt install -y desktop-base

# pipx
apt install -y pipx

#####################################################
# remove packages
#####################################################

apt purge nano

