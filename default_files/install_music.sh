#!/usr/bin/env bash

BASE_DIR=$(dirname "$0")
cd "$BASE_DIR"

function error_exit() {
    cleanup
    if [[ ! -z $1 ]]; then
        echo "Installation error:"
        echo "$1"
    fi
    exit 1
}

function cleanup() {
    [[ -d tmp_files ]] || rm -r tmp_files
    [[ $? -eq 0 ]] || echo "Failed to remove tmp_files directory"
}

function print_help() {
    echo "./install_music.sh [action] [options]"
    echo "Actions:"
    echo "  install                    | Install FFMPEG and youtube-dl if its not installed"
    echo "  install-ffmpeg             | Install FFMPEG if its not installed"
    echo "  install-youtube-dl         | Install youtube-dl if its not installed"
    echo "  update-youtube-dl          | Update youtube-dl"
    echo ""
    echo "Options:"
    echo "  -f or --force-ffmpeg       | Enforce the installation or reinstallation of FFMPEG"
    echo "  -y or --force-youtube-dl   | Enforce the installation or reinstallation of youtube-dl"
    echo "  -h or --help               | Show this menu"
}

function wget_() {
    wget -h | grep -e "--show-progress" &>/dev/null; _exit_code=$?
    _wget_show_progress=""
    [[ $_exit_code -eq 0 ]] && _wget_show_progress="--show-progress"
    wget "$1" -q ${_wget_show_progress} -O "$2"
}

# For FFMPEG we're using a prebuild build downloaded from here: https://ffbinaries.com/downloads
# Arguments:
# $1 [0/1] enforce (re)install
function install_ffmpeg() {
    [[ -d providers ]] || mkdir -p providers
    [ $? -eq 0 ] || error_exit "failed to find or create provider directory"

    if [[ -z $1 ]] || [[ $1 -ne 1 ]]; then
        # Test if FFMPEG had been already manually specified
        cat providers/config_ffmpeg.ini 2>/dev/null | grep -E 'ffmpeg_command=' &> /dev/null
        if [[ $? -eq 0 ]]; then
            echo "FFMPEG has been already specially installed"
            read -e -p "Do you want over reinstall FFMPEG? [y/N] " YN

            if ! [[ ${YN} == "y" || ${YN} == "Y" ]]; then
                echo "Skipping FFMPEG installation"
                return
            fi
        fi

        # Test for a local valid FFMPEG version
        ffmpeg_version=$(ffmpeg -version 2>/dev/null | head -n1 | grep -Po '(?<=version )(\d)+\.(\d)+\.(\d)+')
        ffmpeg_major_version=$(echo "${ffmpeg_version}" | grep -Po '\d' | head -n 1)

        if [[ ! -z "${ffmpeg_major_version}" ]] && ([[ "${ffmpeg_major_version}" == "3" ]] || [[ "${ffmpeg_major_version}" == "4" ]]); then
            echo "Local installed FFMPEG version (${ffmpeg_version}) is okey. No need to install FFMPEG."
            return
        fi

        if [[ ! -z "${ffmpeg_major_version}" ]]; then
            echo "Local FFMPEG version (${ffmpeg_version} => major version: ${ffmpeg_major_version}) is too low. Downloading newer one."
        else
            echo "Failed to find FFMPEG locally. Downloading FFMPEG."
        fi
    fi

    # Setup and test environment
    [[ ! -d tmp_files ]] || rm -r tmp_files >/dev/null
    mkdir -p tmp_files
    [ $? -eq 0 ] || error_exit "failed to find or tmp_files directory"

    wget --version &>/dev/null
    [[ $? -eq 0 ]] || error_exit "FFMPEG installation requires wget!"

    unzip -v &>/dev/null
    [[ $? -eq 0 ]] || error_exit "FFMPEG installation requires unzip! (Install unzip via apt-get install unzip)"

    # Download FFMPEG binaries
    download_file="tmp_files/ffmpeg.zip"
    if [ "$(uname -m)" == "x86_64" ]; then
      download_path="https://github.com/vot/ffbinaries-prebuilt/releases/download/v4.0/ffmpeg-4.0.1-linux-64.zip"
    else
      download_path="https://github.com/vot/ffbinaries-prebuilt/releases/download/v4.0/ffmpeg-4.0.1-linux-32.zip"
    fi

    echo "Downloading FFMPEG from ${download_path} to ${download_file}"
    [[ ! -e "${download_file}" ]] || rm "${download_file}"
    [[ $? -eq 0 ]] || error_exit "Failed to remove old downloaded FFMPEG file" # This should never happen

    wget_ "${download_path}" "${download_file}"
    [[ $? -eq 0 ]] || error_exit "Failed to download FFMPEG"

    # Extract and verify downloaded file
    echo "Extracting FFMPEG"
    unzip_output=$(unzip -o "${download_file}" -d tmp_files/ 2>&1)
    [[ $? -eq 0 ]] || error_exit "Failed to unzip downloaded file: ${unzip_output}"

    echo "Validating FFMPEG"
    [[ -x "${download_file}" ]] || chmod +x "${download_file}"
    [[ $? -eq 0 ]] || error_exit "Failed to add execute permissions to the ffmpeg binary"

    ffmpeg_version=$(./tmp_files/ffmpeg -version 2>/dev/null | head -n1 | grep -Po '(?<=version )(\d)+\.(\d)+\.(\d)+')
    [[ "${ffmpeg_version}" == "4.0.1" ]] || error_exit "Invalid downloaded FFMPEG version. Got ${ffmpeg_version} but expected 4.0.1"

    # Install downloaded binary
    echo "Register FFMPEG for the FFMPEG provider"
    [[ -e providers/bin/ ]] || mkdir -p providers/bin
    [[ $? -eq 0 ]] || error_exit "Failed to find or create provider bin directory"

    [[ ! -e providers/bin/ffmpeg ]] || rm providers/bin/ffmpeg
    [[ $? -eq 0 ]] || error_exit "Failed delete old FFMPEG binary"

    mv tmp_files/ffmpeg providers/bin/ffmpeg
    [[ $? -eq 0 ]] || error_exit "Failed to move the downloaded FFMPEG binary"

    ffmpeg_config="providers/config_ffmpeg.ini"
    [[ -f "${ffmpeg_config}" ]] || echo "" > "${ffmpeg_config}"
    [[ $? -eq 0 ]] || error_exit "Failed to get or create config"

    config=$(cat "${ffmpeg_config}" | sed -E "s/^(ffmpeg_command[ ]*=.*)$/; \1/")
    [[ $? -ne 0 ]] || echo "$config" > ${ffmpeg_config} # Only write again when command above was successfully
    [[ $? -eq 0 ]] || error_exit "Failed to comment old FFMPEG command"

    echo -e "[general]\nffmpeg_command=`pwd`/providers/bin/ffmpeg" >> ${ffmpeg_config}
    [[ $? -eq 0 ]] || error_exit "Failed to append own command"

    echo "FFMPEG installed successfully"
}

# Arguments:
# $1 [0/1] enforce (re)install
function install_youtubedl() {
    [[ -d providers ]] || mkdir -p providers
    [ $? -eq 0 ] || error_exit "failed to find or create provider directory"

    if [[ -z $1 ]] || [[ $1 -ne 1 ]]; then
        # Test if youtube-dl had been already manually specified
        cat providers/config_youtube.ini 2>/dev/null | grep -E 'youtubedl_command=' &> /dev/null
        if [[ $? -eq 0 ]]; then
            echo "youtubedl-dl has been already specially installed"
            read -e -p "Do you want over reinstall youtubedl-dl? [y/N] " YN

            if ! [[ ${YN} == "y" || ${YN} == "Y" ]]; then
                echo "Skipping youtubedl-dl installation"
                return
            fi
        fi

        youtubedl_version=$(youtube-dl --version 2>/dev/null)
        if [[ ! -z $youtubedl_version ]]; then
            echo "Local YouTube-DL version (${youtubedl_version}) is okey. No need to install it"
            return
        fi
    fi

    # Testing for python (Requirement is 2.6/2.7 or 3.2+)
    python_supported=0
    python_version=$(python --version 2>&1 | grep -Po ' (\d+).(\d+).(\d+)')
    [[ $? -eq 0 ]] || error_exit "youtube-dl requires python to run! Please install python first"

    python_major_version=$(echo "${python_version}" | grep -Po '\d' | sed -n 1p)
    python_minor_version=$(echo "${python_version}" | grep -Po '\d' | sed -n 2p)
    if [[ "${python_major_version}" == "3" ]]; then
        if [[ "${python_minor_version}" -ge "2" ]]; then
            python_supported=1
        fi
    elif [[ "${python_major_version}" == "2" ]]; then
        if [[ "${python_minor_version}" == "6" ]] || [[ "${python_minor_version}" == "7" ]]; then
            python_supported=1
        fi
    fi

    if [[ ${python_supported} -ne 1 ]]; then
        echo "Your python version (${python_version}) isn't supported by youtube-dl."
        echo "Please install python 2.6/2.7 or any python grater then 3.2."
        error_exit
    fi

    # Setup and test environment
    [[ ! -d tmp_files ]] || rm -r tmp_files >/dev/null
    mkdir -p tmp_files
    [ $? -eq 0 ] || error_exit "failed to find or tmp_files directory"

    wget --version &>/dev/null
    [[ $? -eq 0 ]] || error_exit "youtube-dl installation requires wget!"

    # Download YouTube-DL
    download_path="https://yt-dl.org/downloads/latest/youtube-dl"
    download_file="tmp_files/youtube-dl"

    echo "Downloading youtube-dl from ${download_path} to ${download_file}"
    [[ ! -e "${download_file}" ]] || rm "${download_file}"
    [[ $? -eq 0 ]] || error_exit "Failed to remove old downloaded youtube-dl file" # This should never happen

    wget_ "${download_path}" "${download_file}"
    [[ $? -eq 0 ]] || error_exit "Failed to download youtube-dl"

    [[ -x "${download_file}" ]] || chmod +x "${download_file}"
    [[ $? -eq 0 ]] || error_exit "Failed to add execute permissions to the youtube-dl binary"

    youtubedl_version=$(${download_file} --version 2>/dev/null)
    [[ ! -z "$youtubedl_version" ]] || error_exit "Failed to verify downloaded youtube-dl binary"


     # Install downloaded binary
    echo "Register youtube-dl for the youtueb-dl provider"
    [[ -e providers/bin/ ]] || mkdir -p providers/bin
    [[ $? -eq 0 ]] || error_exit "Failed to find or create provider bin directory"

    [[ ! -e providers/bin/youtube-dl ]] || rm providers/bin/youtube-dl
    [[ $? -eq 0 ]] || error_exit "Failed delete old youtube-dl binary"

    mv tmp_files/youtube-dl providers/bin/youtube-dl
    [[ $? -eq 0 ]] || error_exit "Failed to move the downloaded youtube-dl binary"

    youtubedl_config="providers/config_youtube.ini"
    [[ -f "${youtubedl_config}" ]] || echo "" > "${youtubedl_config}"
    [[ $? -eq 0 ]] || error_exit "Failed to get or create config"

    config=$(cat "${youtubedl_config}" | sed -E "s/^(youtubedl_command[ ]*=.*)$/; \1/")
    [[ $? -ne 0 ]] || echo "$config" > ${youtubedl_config} # Only write again when command above was successfully
    [[ $? -eq 0 ]] || error_exit "Failed to comment old youtube-dl command"

    echo -e "[general]\nyoutubedl_command=`pwd`/providers/bin/youtube-dl" >> ${youtubedl_config}
    [[ $? -eq 0 ]] || error_exit "Failed to append own command"

    echo "youtube-dl installed successfully"
}

function update_youtubedl() {
    binary_location=$(cat providers/config_youtube.ini 2>/dev/null | grep -Po '(?<=youtubedl_command=).*')
    [[ ! -z ${binary_location} ]] || binary_location="youtube-dl"

    ${binary_location} --version &> /dev/null
    [[ $? -eq 0 ]] || error_exit "Failed to find youtube-dl. Please install youtube-dl first!";

    if [[ ! -w ${binary_location} ]]; then
        error_exit "Could not update youtube-dl. (No write permissions. May run as sudo?)"
    fi

    ${binary_location} -U
}

action="$1"
[[ "$action" == -* ]] || shift 1

action_update_ytdl=0
action_install_ytdl=0
action_install_ffmpeg=0

option_force_help=0
option_force_ffmpeg=0
option_force_ytdl=0
option_upgrade_ytdl=0

for option in "$@";
do
    case "${option}"
    in
    --force-ffmpeg|-f)
        option_force_ffmpeg=1
        echo "Enforcing FFMPEG install/update"
        ;;
    --force-youtube-dl|-y)
        option_force_ytdl=1
        echo "Enforcing youtube-dl install/update"
        ;;
    --help|-h)
        option_force_help=1
        ;;
    esac
done

if [[ ${option_force_help} -eq 1 ]]; then
    print_help
    exit 0
fi

case "${action}"
in
install)
    action_install_ytdl=1
    action_install_ffmpeg=1
    ;;
install-ffmpeg)
    action_install_ffmpeg=1
    ;;
install-youtube-dl)
    action_install_ytdl=1
    ;;
update-youtube-dl)
    action_update_ytdl=1
    ;;

*)
    if [[ ! -z "${action}" ]]; then
        echo "Invalid usage: Could not find action \"${action}\"";
    else
        echo "Invalid usage: Please provide a valid action";
    fi
    echo ""
    print_help
    exit 1
    ;;
esac

if [[ ${action_install_ffmpeg} -eq 1 ]]; then
    echo "Testing/Installing FFMPEG"
    install_ffmpeg ${option_force_ffmpeg}
fi

if [[ ${action_install_ytdl} -eq 1 ]]; then
    echo "Testing/Installing youtube-dl"
    install_youtubedl ${option_force_ytdl}
fi

if [[ ${action_update_ytdl} -eq 1 ]]; then
    echo "Updating youtube-dl"
    update_youtubedl
fi
