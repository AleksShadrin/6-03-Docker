#!/bin/bash
logfile=$1
echo "timestamp loadavg1 loadavg5 loadavg15 memfree memtotal diskfree disktotal" >> $logfile
while true;
do
    timestamp=$(date | awk '{print $4}')
    loadavg=$(cat /proc/loadavg | awk '{print $1, $2, $3}')
    mem=$(free | grep Mem | awk '{print $4, $2}')
    disk=$(df -h | awk '/\/$/{print $4, $2}')
    echo $timestamp $loadavg $mem $disk>> $logfile
    sleep 5
done
