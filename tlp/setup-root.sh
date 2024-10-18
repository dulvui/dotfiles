#!/bin/bash

config_path=/home/dulvui/sync/computer/config

# ln -l $config_path/tlp/00-template.conf /etc/tlp.d/
ln -s $config_path/tlp/tlp.d/* /etc/tlp.d/

