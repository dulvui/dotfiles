#!/bin/bash

# used for files or directories, that don't work with soft links
# like godot's config

# iterate over directories and execute backup.sh
# .*/ adds hidden directories
for dir in $(ls -d */ .*/);
do
    if [ -f $dir/backup.sh ];
    then
        printf "backing up $dir...\n";
        bash $dir/backup.sh;
        printf "backing up $dir done!\n";
    fi;
done

