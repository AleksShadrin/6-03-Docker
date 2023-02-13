#!/bin/bash
path=$1
i=0
a=0
if [[ -d $path ]];
then
    for file in $path*
    do
        if  [[ ! -d $file ]]&&[[ ! -h $file ]];
        then
            ((a=$a+$(stat --format='%s' $file)))
            ((i++))
        fi;
    done
else
    echo directory doesn\'t exist
fi;
echo "average size of files in $path : $(($a/$i))"