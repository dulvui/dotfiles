# create luks disk

https://www.reddit.com/r/linux4noobs/comments/1dxrm9r/how_would_you_use_luks_to_encrypt_a_microsd_or_usb/

```bash
cryptsetup luksFormat /dev/sdX
cryptsetup open /dev/sdX my_encrypted_device
mkfs.ext4 /dev/mapper/my_encrypted_device
cryptsetup close my_encrypted_device
```
