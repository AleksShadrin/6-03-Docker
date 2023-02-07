#!/bin/bash
echo "Input path to create"
read path
if [[ ! -d $path ]];
then 
    mkdir $path
    echo "Directory has been created: $path"
else 
    echo "Derectory is already exist"
fi;