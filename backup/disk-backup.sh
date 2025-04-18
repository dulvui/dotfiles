#!/bin/bash

home_path="/home/dulvui"
config_path="$home_path/sync/computer/config"

# TODO
# check if disks are mounted
# if not, unlock with secret tool, if keepass is unlocked
# mount
# make zip archive of old backup on crucial
# write log
# max zip backup amount

function backup() {
    if [ $# -ne 2 ]; then
        echo "2 arguments needed: dir-file, destination" >> disk-backup.log
        return 1
    fi

    if [ ! -d "$2" ]; then
        echo "$2 not mounted, skipping..." >> disk-backup.log
        return 0
    fi


    while read dir; do
        echo "backing up $2$dir..." >> disk-backup.log
        rsync -az --delete --exclude ".stversions" "$home_path/$dir" $2$dir
        echo "backing up $2$dir done." >> disk-backup.log
    done <"$config_path/backup/$1"
}

echo "start backup at $(date)" > disk-backup.log

echo "backup to sd lexar..." >> disk-backup.log
backup "dirs-full.txt" "/media/dulvui/18d8f048-1239-46ca-8548-18b709fc2c0d/"
echo "backup to sd lexar done." >> disk-backup.log

echo "backup to sd samsung..." >> disk-backup.log
backup "dirs-tiny.txt" "/media/dulvui/63add787-ae09-465c-9d7e-be3e16b346d1/"
echo "backup to sd samsung done." >> disk-backup.log

echo "backup to ssd..." >> disk-backup.log
backup "dirs-full.txt" "/media/dulvui/24ecc7ab-d81d-47b1-bc9d-e207d72cbffc/"
echo "backup to ssd done." >> disk-backup.log

echo "end backup at $(date)" >> disk-backup.log
