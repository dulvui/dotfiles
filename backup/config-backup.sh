#!/bin/bash

home_path="/home/dulvui"
config_path="$home_path/sync/computer/config"
date=$(date +'%Y-%m-%d %H:%M:%S')

# used for files or directories, that don't work with soft links
# like godot's config
echo "start backup at $date" > $home_path/logs/config-backup.log

# iterate over directories and execute backup.sh
# .*/ adds hidden directories
for dir in $(ls -d $config_path/*/ $config_path/.*/);
do
    if [ -f $dir/backup.sh ];
    then
        echo "backing up $dir...\n" >> $home_path/logs/config-backup.log
        bash $dir/backup.sh;
        echo "backing up $dir done.\n" >> $home_path/logs/config-backup.log
    fi;
done

echo "end backup at $date" >> $home_path/logs/config-backup.log
