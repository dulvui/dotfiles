#!/bin/bash

##########################
# backup
##########################
# set exectute permissins
chmod a+x "$config_path/backup/backup.sh"

# set cron tab
(crontab -l 2>/dev/null || true; echo "@reboot $config_path/backup.sh") | crontab -

##########################
# disk backup
##########################

# set exectute permissins
chmod a+x "$config_path/backup/disk-backup.sh"

# set cron tab
(crontab -l 2>/dev/null || true; echo "@reboot $config_path/disk-backup.sh") | crontab -
