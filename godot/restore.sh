#!/bin/bash

# simply copy files/dirs manually, since links brake
# godot always creates new files
mkdir -p ~/.config/godot
cp  $config_path/godot/editor_settings* ~/.config/godot/
cp -r  $config_path/godot/script_templates ~/.config/godot/
