#!/bin/bash

# iterate over directories and execute setup.sh
# .*/ adds hidden directories
for dir in $(ls -d */ .*/);
do
    if [ -f $dir/setup-root.sh ];
    then
        printf "setting up $dir...\n";
        bash $dir/setup-root.sh;
        printf "setting up $dir done!\n";
    fi;
done

