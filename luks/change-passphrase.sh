# search for device
lsblk

# find encrypted partition
cryptsetup luksDump /dev/nvme0n1p3

# change passphrase
cryptsetup luksChangeKey /dev/nvme0n1p3
