#!/bin/bash

TERMINAL_PIPE="/tmp/teaspeak_\${pid}_\${direction}.term"
COMMANDLINE_PARAMETERS="${@:2}" #add any command line parameters you want to pass here

file_base=$(readlink -f "$0")
file_base="$0"
directory_base=$(dirname ${file_base})
cd ${directory_base} || exit 1

LIBRARYPATH="./libs/"
PRELOADPATH="./libs/libjemalloc.so.2"
BINARYNAME="TeaSpeakServer"
PID_FILE="tpid.pid"

if [[ ! -d logs ]]; then
    echo "Please start the TeaSpeak-Server for the first time over teastart_minimal.sh"
    echo "You could get the query interface information only over this way!"
    exit 0
fi

if [[ -e "stpid.pid" ]]; then
    echo "You already started you TeaSpeak server over teastart_autorestart.sh"
    exit 0
fi

execute_command() {
    if [[ ! -e ${PID_FILE} ]]; then
        echo "No server running (${PID_FILE} is missing)"
        exit 1
    fi

    pid=$(cat "$PID_FILE")
    if ! ( kill -0 "$pid" 2> /dev/null ); then
        echo "Server seems to have died"
        exit 1
    fi

    pipe="${TERMINAL_PIPE/\$\{pid\}/$pid}"
    pipe_in="${pipe/\$\{direction\}/in}"
    pipe_out="${pipe/\$\{direction\}/out}"

    if [[ ! -p "$pipe_in" ]]; then
        echo "Terminal input pipe does not exists ($pipe_in)"
        exit 1
    fi

    if [[ ! -p "$pipe_out" ]]; then
        echo "Terminal output pipe does not exists ($pipe_out)"
        exit 1
    fi

    # Read everything from the out pipe and drop it
    # shellcheck disable=SC2162
    while read -t 0 line < "$pipe_out"
    do
        true
    done

    echo -en "\u001b[36m>\u001b[0m "
    echo "${*}"

    echo -e "\n${*}" > "$pipe_in"

    empty_line_received=0
    first_line=1
    while true
    do
        # shellcheck disable=SC2162
        if read -t 5 line < "$pipe_out"; then
            if [[ $first_line -eq 1 ]]; then
                first_line=0
                if [[ "$line" == "error" ]]; then
                    color="\u001b[31;1m"
                else
                    color="\u001b[32;1m"
                fi
            fi
            if [[ "$line" == $'\r' ]]; then
                if [[ $empty_line_received -eq 1 ]]; then
                    break
                else
                    empty_line_received=1
                fi
                continue
            fi
            if [[ $empty_line_received -eq 1 ]]; then
                echo -e "$color<\u001b[0m \r"
            fi
            echo -en "$color<\u001b[0m "
            echo "$line"
        fi
    done
}

start_server() {
    if [[ -e ${PID_FILE} ]]; then
        if ( kill -0 $(cat ${PID_FILE}) 2> /dev/null ); then
            echo "The server is already running, try restart or stop"
            exit 1
        else
            echo "${PID_FILE} found, but no server running. Possibly your previously started server crashed"
            echo "Please view the logfile for details."
            rm ${PID_FILE}
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

    echo -n "Starting the TeaSpeak server"
    if [[ -e "$BINARYNAME" ]]; then
        if [[ ! -x "$BINARYNAME" ]]; then
            echo -e "\n${BINARYNAME} is not executable, trying to set it"
            chmod u+x "${BINARYNAME}"
        fi
        if [[ -x "$BINARYNAME" ]]; then
            export LD_LIBRARY_PATH="${LIBRARYPATH}:${LD_LIBRARY_PATH}"
            export LD_PRELOAD="${PRELOADPATH}"
            "./${BINARYNAME}" --pipe-path "$TERMINAL_PIPE" ${COMMANDLINE_PARAMETERS} < /dev/null > /dev/null 2>&1 &
             PID=$!
            ps -p ${PID} > /dev/null 2>&1
            if [[ "$?" -ne "0" ]]; then
                echo -e "\nTeaSpeak server could not start (PID == 0)"
            else
                echo ${PID} > ${PID_FILE}

                c=1
                while [[ "$c" -le 3 ]]; do
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
                    if [[ -d logs/ ]]; then
                        LF=$(find logs/* -printf '%p\n' | sort -r | head -1)
                        cat ${LF}
                    else
                        echo "ERROR: Could not resolve log file"
                    fi
                    rm ${PID_FILE}
                fi
            fi
        else
            echo -e "\n${BINARNAME} is not executable, cannot start TeaSpeak server"
        fi
    else
        echo -e "\nCould not find binary, aborting"
        exit 5
    fi
}

stop_server() {
    if [[ -e ${PID_FILE} ]]; then
        echo -n "Stopping the TeaSpeak server"
        if ( kill -TERM $(cat ${PID_FILE}) 2> /dev/null ); then
            c=1
            while [[ "$c" -le 30 ]]; do
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
            echo -e "\nServer is not shutting down cleanly - killing"
            kill -KILL $(cat ${PID_FILE})
        else
            echo -e "\ndone"
        fi
        rm ${PID_FILE}
    else
        echo "No server running (${PID_FILE} is missing)"
        exit 7
    fi
}

status_server() {
    if [[ -e ${PID_FILE} ]]; then
        if ( kill -0 $(cat ${PID_FILE}) 2> /dev/null ); then
            echo "Server is running"
            exit 0
        else
            echo "Server seems to have died"
            exit 1
        fi
    else
        echo "No server running (${PID_FILE} is missing)"
        exit 1
    fi
}

case "$1" in
    start)
        start_server
    ;;
    stop)
        stop_server
    ;;
    restart)
        $0 stop && $0 start ${COMMANDLINE_PARAMETERS} || exit 1
    ;;
    status)
        status_server
    ;;
    reload)
        execute_command "config reload"
        exit 0
    ;;
    execute)
        execute_command "${@:2}"
        exit 0
    ;;
    *)
        echo "Invalid usage: ${0} {start|stop|restart|status|reload|execute}"
        exit 2
esac
exit 0
