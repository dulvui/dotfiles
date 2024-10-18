#!/bin/bash

# iterate over directories and execute setup.sh
# .*/ adds hidden directories
for dir in $(ls -d */ .*/);
do
    if [ -f $dir/setup.sh ];
    then
        printf "setting up $dir...\n";
        bash $dir/setup.sh;
        printf "setting up $dir done!\n";
    fi;
done

