#!/usr/bin/env bash

dpkg -s "libav-tools" &> /dev/null

if [ ! $? -eq 0 ]; then
    echo "We're missing a required package!"
    echo "Please install 'libav-tools' (apt-get install libav-tools)"
    read -r -p "Should we do this for you? [Y/n]: " response
    response=${response,,}
    if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
        dpkg -s "sudo" &> /dev/null
        if [ $? -eq 0 ]; then
            sudo apt-get install libav-tools -y
        else
            apt-get install libav-tools -y
        fi
        ./$0
    fi
    exit 0
fi

export LD_LIBRARY_PATH="$LD_LIBRARY_PAT;./libs/"
./TeaSpeakServer
#Cleanup & reset the terminal
stty cooked echo