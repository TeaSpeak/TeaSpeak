#!/usr/bin/env bash

file_base=$(readlink -f "$0")
directory_base=$(dirname ${file_base})
cd ${directory_base}

export LD_LIBRARY_PATH="$LD_LIBRARY_PATH;./libs/"
# Since 1.5.0 we don't provide jemalloc any more
#export LD_PRELOAD="./libs/libjemalloc.so.2"

./TeaSpeakServer $@
#Cleanup & reset the terminal
stty cooked echo
