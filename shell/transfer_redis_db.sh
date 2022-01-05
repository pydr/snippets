#!/bin/bash
redis-cli -h 192.168.1.101 -p 6379 -a password -n 0 keys "*" | while read key
do
    redis-cli -h 192.168.1.101 -p 6379 -a password -n 0 --raw dump $key | perl -pe 'chomp if eof' | redis-cli -h 192.168.1.102 -p 6379 -a password -n 1 -x restore $key 0
    echo "migrate key $key"
done
