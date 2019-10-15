#!/usr/bin/env bash

BASE_DIR=$(readlink -f "$0")
cd "$BASE_DIR"

while true;
do
    ./teastart_minimal.sh $@
    c=5
    echo "Automatically restarting TeaSpeak"
    echo "  Press ^K^C to break this loop!"
    while [[ "$c" -ge 0 ]]; do
        echo -n -e "\r  Restart in $c seconds!"
        sleep 1
        c=$(($c-1))
    done
    echo -n -e "Restarting TeaSpeak\n"
done
