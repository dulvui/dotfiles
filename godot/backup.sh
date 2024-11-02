#!/bin/bash

# simply copy files/dirs manually, since links brake
# godot always creates new files
cp ~/.config/godot/editor_settings* $config_path/godot/
cp -r ~/.config/godot/script_templates $config_path/godot/
