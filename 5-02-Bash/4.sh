#!/bin/bash
while true; 
do
    read a	
    read b
    if [[  $a =~ ^[1-9][0-9]*$ ]] && [[  $b =~ ^[1-9][0-9]*$ ]]
    then 
        break
    else 
        echo  wrong input 
    fi;
done
select operation in \+ \- \* \/; do
    case $operation in
    \+)
        echo $(($a+$b));
	break;;
    \-)
        echo $(($a-$b));
	break;;
    \*)
        echo $(($a*$b));
	break;;
    \/)
        echo $(($a/$b));
	break;;
    esac
done
