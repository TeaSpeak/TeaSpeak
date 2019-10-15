#!/bin/bash

file_base=$(readlink -f "$0")
directory_base=$(dirname ${file_base})
cd ${directory_base}

if [[ ! -d logs/ ]]; then
    echo "Please start the TeaSpeak-Server for the first time over teastart_minimal.sh"
    echo "You could get the query interface information only over this way!"
    exit 0
fi

if !( hash screen 2>/dev/null; ); then
    echo "Could not found 'screen'"
    echo "Please install 'screen' (apt-get install screen)"
    exit 0
fi

PID_FILE="tpid.pid"
SPID_FILE="stpid.pid"

COMMANDLINE_PARAMETERS="${@:2}" #add any command line parameters you want to pass here

if [[ -e ${PID_FILE} ]]; then
    if ( kill -0 $(cat ${PID_FILE}) 2> /dev/null ); then
        echo "You've started your TeaSpeak server with teastart.sh. Please use this script for all actions"
        exit 1
    else
        echo "${PID_FILE} found, but no server running. Possibly your previously started server crashed."
        echo "Please view the logfile for details."
        rm ${PID_FILE}
    fi
fi

case "$1" in
	start)
		if [[ -e ${SPID_FILE} ]]; then
			SCREEN_NAME="TeaSpeak-$(cat ${SPID_FILE})"
			if (screen -ls | grep "${SCREEN_NAME}" > /dev/null); then
				echo "The server screen is already running."
				exit 1
			else
				echo "${SPID_FILE} found, but no server running. Possibly your previously started server crashed"
				echo "Please view the logfile for details."
				rm ${SPID_FILE}
			fi
		fi

		if [[ "${UID}" = "0" ]]; then
			echo WARNING ! For security reasons we advise: DO NOT RUN THE SERVER AS ROOT
			c=1
			while [[ "$c" -le 10 ]]; do
				echo -n "!"
				sleep 1
				c=$(($c+1))
			done
			echo "!"
		fi

        if !([[ -e "tealoop.sh" ]];); then
            echo "Could not resolve tealoop.sh"
            exit 2;
        fi

        SCREEN_UUID=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32)
		echo "Starting the TeaSpeak server screen (Uid: $SCREEN_UUID)"
		screen -d -m -S TeaSpeak-${SCREEN_UUID} ./tealoop.sh > /dev/null &

        PID=$!
        ps -p ${PID} > /dev/null 2>&1
        if [[ "$?" -ne "0" ]]; then
            echo "TeaSpeak server could not start"
        else
            echo ${SCREEN_UUID} > ${SPID_FILE}
            echo "TeaSpeak server started"
        fi
	;;
	status)
		if [[ ! -e ${SPID_FILE} ]]; then
		    echo "Missing ${SPID_FILE} file. Server not running!"
		    exit 1
		fi

        if ( screen -ls | grep "${SCREEN_NAME}" > /dev/null ); then
            echo "Server is running."
            exit 0
        fi
        echo "Server seems to be stopped."
        exit 1
	;;
	attach)
		if [[ -e ${SPID_FILE} ]]; then
			echo "Attaching to the server"
			SCREEN_NAME="TeaSpeak-$(cat ${SPID_FILE})"
			if (screen -ls | grep "${SCREEN_NAME}" > /dev/null); then
			    screen -rdx ${SCREEN_NAME}
			    echo "Screen detached"
			    exit 0
		    else
		        echo "Screen not running... Could not attach!"
		        exit 6
		    fi
		else
			echo "No server running (${PID_FILE} is missing)"
			exit 7
		fi
	;;
	*)
		echo "Invalid usage: ${0} {start|status|attach}"
		exit 2
esac
exit 0
