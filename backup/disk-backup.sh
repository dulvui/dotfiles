#!/bin/bash

config_path="/home/dulvui/sync/computer/config"

# TODO
# check if disks are mounted
# if not, unlock with secret tool, if keepass is unlocked
# mount
# make zip archive of old backup on crucial
# write log
# max zip backup amount

function backup() {
    if [ $# -ne 2 ]; then
        echo "2 arguments needed: dir-file, destination"
        return 1
    fi

    while read dir; do
        echo "backing up $2$dir..."
        rsync -az --delete  --exclude ".stversions" "$dir" $2$dir
        echo "backing up $2$dir done."
    done <"$config_path/backup/$1"
}

echo "backup to sd..."
backup "sd-dirs.txt" "/media/dulvui/63add787-ae09-465c-9d7e-be3e16b346d1/"
echo "backup to sd done."

echo "backup to ssd..."
backup "ssd-dirs.txt" "/media/dulvui/24ecc7ab-d81d-47b1-bc9d-e207d72cbffc/"
echo "backup to ssd done."
