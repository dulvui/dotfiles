#!/bin/bash

# set exectute permissins
chmod a+x "$config_path/backup.sh"

# set cron tab
(crontab -l 2>/dev/null || true; echo "@reboot $config_path/backup.sh") | crontab -
