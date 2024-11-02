#!/bin/bash

(crontab -l 2>/dev/null || true; echo "@reboot $config_path/backup.sh") | crontab -
