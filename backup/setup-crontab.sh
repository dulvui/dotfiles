#!/bin/bash

##########################
# backup
##########################
# set exectute permissins
chmod a+x "$config_path/backup/config-backup.sh"

# set cron tab
(crontab -l 2>/dev/null || true; echo "0 * * * * $config_path/backup/config-backup.sh") | crontab -

##########################
# disk backup
##########################

# set exectute permissins
chmod a+x "$config_path/backup/disk-backup.sh"

# set cron tab
(crontab -l 2>/dev/null || true; echo "0 * * * * $config_path/backup/disk-backup.sh") | crontab -
