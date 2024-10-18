# systemd config

## prevent powerbutton shutdown
https://www.reddit.com/r/swaywm/comments/180ly44/how_to_change_power_button_behavior/

as root
```bash
vim /etc/systemd/logind.conf
```
change folowing values
```bash
HandlePowerKey=ignore
HandlePowerKeyLongPress=poweroff
```

restart logind or reboot
```bash
systemctl restart systemd-logind
```
