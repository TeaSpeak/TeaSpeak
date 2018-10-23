#!/bin/bash

COMMANDLINE_PARAMETERS="${@:2}" #add any command line parameters you want to pass here
D1=$(readlink -f "$0") #Get own binary path
BINARYPATH="$(dirname "${D1}")"
cd "${BINARYPATH}"
LIBRARYPATH="./libs/"
PRELOADPATH="./libs/libjemalloc.so.2"
BINARYNAME="TeaSpeakServer"
PID_FILE="tpid.pid"

if [ ! -d logs ]; then
    echo "Please start the TeaSpeak-Server for the first time over teastart_minimal.sh"
    echo "You could get the query interface information only over this way!"
    exit 0
fi

if [ -e "stpid.pid" ]; then
    echo "You already started you TeaSpeak server over teastart_autorestart.sh"
    exit 0
fi

case "$1" in
	start)
		if [ -e ${PID_FILE} ]; then
			if ( kill -0 $(cat ${PID_FILE}) 2> /dev/null ); then
				echo "The server is already running, try restart or stop"
				exit 1
			else
				echo "${PID_FILE} found, but no server running. Possibly your previously started server crashed"
				echo "Please view the logfile for details."
				rm ${PID_FILE}
			fi
		fi

		if [ "${UID}" = "0" ]; then
			echo WARNING ! For security reasons we advise: DO NOT RUN THE SERVER AS ROOT
			c=1
			while [ "$c" -le 10 ]; do
				echo -n "!"
				sleep 1
				c=$(($c+1))
			done
			echo "!"
		fi

		echo -n "Starting the TeaSpeak server"
		if [ -e "$BINARYNAME" ]; then
			if [ ! -x "$BINARYNAME" ]; then
				echo -n "\n${BINARYNAME} is not executable, trying to set it"
				chmod u+x "${BINARYNAME}"
			fi
			if [ -x "$BINARYNAME" ]; then
				export LD_LIBRARY_PATH="${LIBRARYPATH}:${LD_LIBRARY_PATH}"
				export LD_PRELOAD="${PRELOADPATH}"
				"./${BINARYNAME}" ${COMMANDLINE_PARAMETERS} < /dev/null > /dev/null 2>&1 &
 				PID=$!
				ps -p ${PID} > /dev/null 2>&1
				if [ "$?" -ne "0" ]; then
					echo -e "\nTeaSpeak server could not start (PID == 0)"
				else
					echo ${PID} > ${PID_FILE}

					c=1
                    while [ "$c" -le 3 ]; do
                        if ( kill -0 $(cat ${PID_FILE}) 2> /dev/null ); then
                            echo -n "."
                            sleep 1
                        else
                            break
                        fi
                        c=$(($c+1))
                    done

                    if ( kill -0 $(cat ${PID_FILE}) 2> /dev/null ); then
                        echo -e "\nTeaSpeak server started, for details please view the log file"
                    else
                        echo -e "\nCould not start TeaSpeak server."
                        echo "Last log entries:"
                        if [ -d logs/ ]; then
                            LF=$(find logs/* -printf '%p\n' | sort -r | head -1)
                            cat ${LF}
                        else
                            echo "ERROR: Could not resolve log file"
                        fi
                        rm ${PID_FILE}
                    fi
				fi
			else
				echo "\n${BINARNAME} is not exectuable, cannot start TeaSpeak server"
			fi
		else
			echo "\nCould not find binary, aborting"
			exit 5
		fi
	;;
	stop)
		if [ -e ${PID_FILE} ]; then
			echo -n "Stopping the TeaSpeak server"
			if ( kill -TERM $(cat ${PID_FILE}) 2> /dev/null ); then
				c=1
				while [ "$c" -le 30 ]; do
					if ( kill -0 $(cat ${PID_FILE}) 2> /dev/null ); then
						echo -n "."
						sleep 1
					else
						break
					fi
					c=$(($c+1))
				done
			fi
			if ( kill -0 $(cat ${PID_FILE}) 2> /dev/null ); then
				echo "\nServer is not shutting down cleanly - killing"
				kill -KILL $(cat ${PID_FILE})
			else
				echo "\ndone"
			fi
			rm ${PID_FILE}
		else
			echo "No server running (${PID_FILE} is missing)"
			exit 7
		fi
	;;
	restart)
		$0 stop && $0 start ${COMMANDLINE_PARAMETERS} || exit 1
	;;
	status)
		if [ -e ${PID_FILE} ]; then
			if ( kill -0 $(cat ${PID_FILE}) 2> /dev/null ); then
				echo "Server is running"
			else
				echo "Server seems to have died"
			fi
		else
			echo "No server running (${PID_FILE} is missing)"
		fi
	;;
	*)
		echo "Invalid usage: ${0} {start|stop|restart|status}"
		exit 2
esac
exit 0
