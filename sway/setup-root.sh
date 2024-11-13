#!/bin/bash

# needed to be able to run light for display brightness change
# and systemctl to power off, reboot and suspend

echo "setting perimssions for light and systemctl..."

echo "# for light and systemctl shutdown, suspend, reboot" >> /etc/sudoers
echo "%dulvui ALL=(root) NOPASSWD: /usr/bin/light,/usr/bin/systemctl" >> /etc/sudoers

echo "setting perimssions for light and systemctl done."
