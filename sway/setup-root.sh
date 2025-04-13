#!/bin/bash

# needed to be able to run light for display brightness change
# and systemctl to power off, reboot and suspend

echo "setting perimssions for light and systemctl..."
cp sudoerds.d/dulvui /etc/sudoers.d/
echo "setting perimssions for light and systemctl done."

