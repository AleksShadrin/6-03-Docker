#!/bin/bash
for ((i=0; i<100; i++))
do
    if [[ $i % 3 ]] 
    then
        ehco $is
    fi;
done
