#!/bin/bash
echo Input 2 numbers, with delimiter " "
read a b
if [[ $a -gt $b ]];
then 
    echo "$a - $b = $(($a-$b))"
elif [[ $a -lt $b ]]
then
    echo "$b - $a = $(($b-$a))"
else
    echo "$a * $b = $(($a*$b))"
fi;