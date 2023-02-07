#!/bin/bash
echo Input filename
read filename
case "$filename" in
    *.jpg|*.gif|*.png)
        echo image
    ;;
    *.wav|*.mp3) 
        echo audio
    ;;
    *.txt|*.doc) 
        echo text
    ;;
    *) 
        echo unknown
    ;;
esac