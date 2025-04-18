#!/bin/bash

config_path="/home/dulvui/sync/computer/config"

# used for files or directories, that don't work with soft links
# like godot's config
echo "start backup at $(date)" > config-backup.log

# iterate over directories and execute backup.sh
# .*/ adds hidden directories
for dir in $(ls -d $config_path/*/ $config_path/.*/);
do
    if [ -f $dir/backup.sh ];
    then
        echo "backing up $dir...\n" >> config-backup.log
        bash $dir/backup.sh;
        echo "backing up $dir done.\n" >> config-backup.log
    fi;
done

echo "end backup at $(date)" >> config-backup.log
