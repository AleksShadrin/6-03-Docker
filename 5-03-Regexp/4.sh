#!/bin/bash

logfile=$1

#timestamp loadavg1 loadavg5 loadavg15 memfree memtotal diskfree disktotal
while true;
do    
    loadavg1 = cat /proc/loadavg | awk '{print $1}'
    loadavg5
    loadavg15
    cat /proc/loadavg | echo >> logfile 
    free | echo >> logfile
    
    echo date loadavg1 loadavg5 loadavg15 memfree memtotal diskfree disktotal >> $logfile
    sleep 5
done
#loadavg[1,5,15] средний показатель загрузки ЦПУ за последние 1 5 и 15 минут. Примечание: хранится в /proc/loadavg.
#memfree количество свободной оперативной памяти в байтах. Примечание: используем утилиту free.
#memtotal количество всей оперативной памяти в байтах. Примечание: используем утилиту free.
#diskfree свободное место на диске подключенного к /. Примечание: используем утилиту df.
#disktotal общий объем диска подключенного к /. Примечание: используем утилиту df.
#Формат записи: timestamp loadavg1 loadavg5 loadavg15 memfree memtotal diskfree disktotal
