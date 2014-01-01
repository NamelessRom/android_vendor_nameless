#!/bin/bash

# Check if imagemagick is installed, else exit
if [ -z mogrify ]; then
    echo "Please install imagemagick!"
    echo "> sudo apt-get install imagemagick <"
    exit 1
fi

# get all png's, copy them, rename and invert
find . -type f -name '*.png' |\
 while read PNG
 do
    cp $PNG "${PNG}_light"
 done
rename s/".png_light"/"_light.png"/g *
mogrify -modulate "65, 100, 100" -strip *_light.png