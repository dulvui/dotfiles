#!/bin/sh

for i in *.wav;
  do name=`echo "$i" | cut -d'.' -f1`
  echo "$name"
  ffmpeg -i "$i" -c:a libvorbis -b:a 64k "${name}.ogg"
done 
