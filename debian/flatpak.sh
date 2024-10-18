#####################################################
# flatpack
#####################################################

apt install -y flatpack
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# zola
flatpak install org.getzola.zola

# signal
flatpak install org.signal.Signal
