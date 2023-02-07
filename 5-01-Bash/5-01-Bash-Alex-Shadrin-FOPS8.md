Задание 1.
Напишите скрипт, который при запуске спрашивает у пользователя путь до директории и создает ее при условии, что ее еще не существует. Если директория существует – пользователю выводится сообщение, что директория существует. Скрипт должен принимать абсолютный путь до директории, например /tmp/testdir или /home/user/testdir
Пришлите получившийся код и скриншот, показывающий работу скрипта в качестве ответа.

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

![](https://github.com/AleksShadrin/netology/blob/main/5-01-Bash/1.png)

Задание 2.
Напишите скрипт:

При запуске скрипта пользователь вводит два числа.
Необходимо вычесть из большего числа меньшее и вывести результат в консоль.
Если числа равны – умножить их друг на друга (или возвести в квадрат одно из чисел) и вывести результат в консоль.
Пришлите получившийся код и скриншот, показывающий работу скрипта в качестве ответа.

#!/bin/bash
echo Input 2 numbers, with delimiter \"\ \"
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

![](https://github.com/AleksShadrin/netology/blob/main/5-01-Bash/2.png)

Задание 3.
Напишите скрипт с использованием оператора case:

При запуске скрипта пользователь вводит в консоль имя файла с расширением, например 123.jpg или track.mp3.
Необходимо сообщить пользователю тип файла.
Если jpg, gif или png – вывести слово «image»
Если mp3 или wav – вывести слово «audio»
Если txt или doc – вывести слово «text»
Если формат не подходит под заданные выше – написать «unknown»
Пришлите получившийся код и скриншот, показывающий работу скрипта в качестве ответа.

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

![](https://github.com/AleksShadrin/netology/blob/main/5-01-Bash/3.png)