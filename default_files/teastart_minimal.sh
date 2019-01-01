#!/usr/bin/env bash

BASE_DIR=$(dirname "$0")
cd "$BASE_DIR"

# pck manager / search pck / update src list / install pck / pck
packageManagersList=(
    # apt for debian based distributions
    'apt;apt list --installed % | grep %;apt update;apt install % -y;libnice10'
    # pacman for arch based distributions
    'pacman;pacman -Q %;pacman -Sy;pacman -S %;libnice'
    # zypper for opensuse based distributions
    'zypper;zypper se --installed-only %;zypper ref;zypper in %;libnice10'
    # yum for RHEL based distributions
    'yum;rpm -q %;yum update -y;yum install -y %;libnice'
)

# elevate privileges if the user is not root
root="%"
if [ "$EUID" -ne 0 ]; then
    if command -v sudo > /dev/null 2>&1; then
        root="sudo %"
    else
        root='su -c "%"'
    fi
fi

#Test if we've already libnice manually installed
if [ ! -e libs/libnice.so.10 ]; then
    for packageManager in "${packageManagersList[@]}"; do
        # split string by delimiter and replace "%" with package name
        IFS=';' read -r -a packageManagerData <<< $packageManager
        packageManagerData[1]="${packageManagerData[1]//%/${packageManagerData[4]}}"
        packageManagerData[3]="${packageManagerData[3]//%/${packageManagerData[4]}}"
        # check if package manager is available
        if command -v ${packageManagerData[0]} > /dev/null 2>&1; then
            # check if required package is installed
            if ! eval "${packageManagerData[1]}" > /dev/null 2>&1; then
                printf "\nWe're missing a required package!\n"
                printf "Please install '${packageManagerData[4]}' (${packageManagerData[3]})\n"
                read -r -p "Should we do this for you? [Y/n]: " response
                response=${response,,}
                if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
                    # install package
                    eval "${root//%/${packageManagerData[2]}}"
                    eval "${root//%/${packageManagerData[3]}}"
                    ./$0
                fi
                exit 0
            fi
            break;
        fi
        # Couldn't find a supported package manager
        if [ "$packageManager" = "${packageManagersList[-1]}" ]; then
            printf '\nYour package manager is not supported!\n'
            printf 'Please report this problem to\n'
            printf 'https://github.com/TeaSpeak/TeaSpeak/issues\n\n'
        fi
    done
fi

export LD_LIBRARY_PATH="$LD_LIBRARY_PATH;./libs/"
export LD_PRELOAD="./libs/libjemalloc.so.2"

./TeaSpeakServer $@
#Cleanup & reset the terminal
stty cooked echo
