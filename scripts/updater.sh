#!/usr/bin/env bash

#  Copyright (c) 2019 Markus Hadenfeldt
#
#  Permission is hereby granted, free of charge, to any person obtaining
#  a copy of this software and associated documentation files (the "Software"),
#  to deal in the Software without restriction, including
#  without limitation the rights to use, copy, modify, merge, publish,
#  distribute, sublicense, and/or sell copies of the Software, and to
#  permit persons to whom the Software is furnished to do so, subject to
#  the following conditions:
#
#  The above copyright notice and this permission notice shall be
#  included in all copies or substantial portions of the Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
#  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
#  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
#  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
#  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
#  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
#  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# Script version 1.0.0
version_major=1
version_minor=0
version_patch=0
version_date="So 23. Jun 2019"

# Global static vars
should_log_debug=0
should_log_info=1
should_log_warn=1
should_log_error=1

repo_url="https://repo.teaspeak.de/server/"
os="linux"
arch=$([[ "$(uname -m)" == "x86_64" ]] && echo "amd64" || echo "x86")

# We want root!
root="%"
if [[ "$EUID" -ne 0 ]]; then
	 if command -v sudo > /dev/null 2>&1; then
		  root="sudo %"
	 else
		  root='su -c "%"'
	 fi
fi

# Log helpers
function log_debug() {
	[[ ${should_log_debug} -eq 1 ]] && echo "[DEBUG] ${@}"
}

function log_info() {
	[[ ${should_log_info} -eq 1 ]] && echo "[INFO] ${@}"
}

function log_warn() {
	[[ ${should_log_warn} -eq 1 ]] && echo "[WARN] ${@}"
}

function log_error() {
	[[ ${should_log_error} -eq 1 ]] && echo "[ERROR] ${@}"
}

function err_exit() {
	[[ ${#@} -ne 0 ]] && log_error ${@}
	exit 1
}

# Dependencies
function install_dependencies() {
	 IFS=$'\n' local package_managers=(${@})

	 for packageManager in "${package_managers[@]}"; do
		  # split string by delimiter and replace "%" with package name
		  IFS=';' read -r -a packageManagerData <<< $packageManager
		  packageManagerData[1]="${packageManagerData[1]//%/${packageManagerData[4]}}"
		  packageManagerData[3]="${packageManagerData[3]//%/${packageManagerData[4]}}"
		  # check if package manager is available
		  if command -v ${packageManagerData[0]} > /dev/null 2>&1; then
				# check if required package is installed
				if ! eval "${packageManagerData[1]}" > /dev/null 2>&1; then
					 log_info "Missing dependency (${packageManagerData[4]})! Installing it (${packageManagerData[3]})!"
					 eval "${root//%/${packageManagerData[2]}}"
					 [[ $? -ne 0 ]] && {
						  err_exit "Failed to update package list!"
					 }
					 eval "${root//%/${packageManagerData[3]}}"
					 [[ $? -ne 0 ]] && {
						  err_exit "Failed to install missing dependency"
					 }
				fi
				break;
		  fi
		  # Couldn't find a supported package manager
		  if [[ "$packageManager" = "${packageManagersList[-1]}" ]]; then
				printf '\nYour package manager is not supported!\n'
				printf 'Please report this problem to\n'
				printf 'https://github.com/TeaSpeak/TeaSpeak/issues\n\n'
				exit 1
		  fi
	 done

	 return 0
}

_ensured_dependencies=0
function ensure_dependencies() {
	 [[ ${_ensured_dependencies} -eq 1 ]] && return 0


	 log_debug "Ensuring dependencies"
	 # pck manager / search pck / update src list / install pck / pck
	 package_managers=(
		  # apt for debian based distributions
		  'apt;apt list --installed % | grep %;apt update;apt install % -y;wget'
		  # pacman for arch based distributions
		  'pacman;pacman -Q %;pacman -Sy;pacman -S %;wget'
		  # zypper for opensuse based distributions
		  'zypper;zypper se --installed-only %;zypper ref;zypper in %;wget'
		  # yum for RHEL based distributions
		  'yum;rpm -q %;yum update -y;yum install -y %;wget'
	 )
	 IFS=$'\n' install_dependencies "${package_managers[@]}"

	 [[ $? -eq 0 ]] && _ensured_dependencies=1
	 return $?
}

_ensured_ui_dependencies=0
function ensure_ui_dependencies() {
	 [[ ${_ensured_ui_dependencies} -eq 1 ]] && return 0

	 log_debug "Ensuring UI dependencies"
	 # pck manager / search pck / update src list / install pck / pck
	 package_managers=(
		  # apt for debian based distributions
		  'apt;apt list --installed % | grep %;apt update;apt install % -y;dialog'
		  # pacman for arch based distributions
		  'pacman;pacman -Q %;pacman -Sy;pacman -S %;dialog'
		  # zypper for opensuse based distributions
		  'zypper;zypper se --installed-only %;zypper ref;zypper in %;dialog'
		  # yum for RHEL based distributions
		  'yum;rpm -q %;yum update -y;yum install -y %;dialog'
	 )
	 IFS=$'\n' install_dependencies "${package_managers[@]}"
	 [[ $? -eq 0 ]] && _ensured_ui_dependencies=1
	 return $?
}

# General www helpers
declare -A request_cache
function request() {
	if [[ ! -z ${request_cache[$1]} ]]; then
		response=${request_cache[$1]}
		return 0
	fi

	response=$(wget -q -O - $1)
	response_code=$?

	if [[ ${response_code} == 0 ]]; then
		request_cache[$1]=$response
	fi
	return ${response_code}
}

function remote_list() {
	log_debug "Getting list for $1"
	request $1
	if [[ ${response_code} -ne 0 ]]; then
		return ${response_code}
	fi

	IFS=$'\n' _response=(${response})
	result=()
	for line in "${_response[@]}"; do
		href=$(echo ${line} | sed -n -E 's:^.*href="([A-Za-z0-9\.\_\-]+)/?".*$:\1:p')
		[[ -z ${href} ]] && continue;
		[[ ${href} == ${line} ]] && continue;
		[[ ".." == "${href}" ]] && continue;

		result+=("$href")
	done

	return 0
}

function available_channels() {
	remote_list "$repo_url$os/"
	[[ $? -ne 0 ]] && return 1

	channels=()

	for channel in ${result[@]}; do
		[[ "$channel" != ${arch}* ]] && continue;
		channels+=(${channel})
	done
	return 0
}

function available_versions() {
	remote_list "$repo_url$os/$1"
	[[ $? -ne 0 ]] && return 1

	versions=()

	for file in ${result[@]}; do
		versions+=(${file})
	done

	#Sort the array
	versions=($(echo "${versions[@]}" | tr " " "\n" | sort -r -V | tr "\n" " "))
	IFS=' '
}

function parse_version() {
	#version_data := [ <major> | <minor> | <patch> | <type> | <build count> ]
	version_data=($(echo "$1" | sed -E 's:^TeaSpeak-([0-9]+)\.([0-9]+)\.([0-9]+)(-([A-Za-z]+))?(-([0-9]+))?\.tar\.gz:\1 \2 \3 \5 \7:'))
}

function channel_name() {
	name=$(echo "$1" | sed -n 's/.*_//p')
	[[ -z "$name" ]] && echo "default" || echo "$name"
}

function channel_version() {
	url="$repo_url$os/$1/latest"
	request ${url}

	[[ $? -ne 0 ]] && echo "unknown" || echo $response
}

# UI-Helpers
function select_version() {
	 ensure_ui_dependencies

	args=($@)

	select=()
	index=0
	b_index=2
	declare -A index_map
	for version in ${@:2}; do
		index_map[$index]=${b_index}
		b_index=$((b_index+1))

		[[ "$version" == "latest" ]] && continue
		index=$((index+1))

		parse_version "$version"
		text="${version_data[0]}.${version_data[1]}.${version_data[2]}"
		[[ ! -z "${version_data[3]}" ]] && text+="-${version_data[3]}"
		[[ ! -z "${version_data[4]}" ]] && text+="-${version_data[4]}";

		select+=($index "${text}")
	done

	choice=$(
		dialog --clear \
			--extra-button --extra-label "Select channel"\
			--no-shadow \
			--title "Version select (${@:1:1} channel)" \
			--menu "Select the version you want to install from the ${@:1:1} channel" 30 150 30 "${select[@]}" \
			2>&1 >/dev/tty
	)
	choice_state=$?
	clear

	[[ ${choice_state} -ne 0 ]] && return ${choice_state}

	b_index=${index_map[$(($choice - 1))]}

	choice=${@:$b_index:1}
	return 0
}

function select_channel() {
	 ensure_ui_dependencies

	args=($@)

	select=()
	index=0

	printf -v pad %40s
	for channel in ${@:1}; do
		index=$(($index + 1))

		name=$(channel_name ${channel})$pad
		select+=($index "${name:0:20} (Current version: $(channel_version $channel))")
	done

	choice=$(dialog --clear --no-shadow --title "Channel select" --menu "Select the build channel" 30 150 30 "${select[@]}" 2>&1 >/dev/tty)
	choice_state=$?
	clear
	[[ ${choice_state} -ne 0 ]] && return ${choice_state}

	b_index=$(($choice - 1))
	choice=${args[$b_index]}
	return 0
}

function select_channel_version() {
	available_channels
	select_channel ${channels[@]}
	[[ $? -ne 0 ]] && {
		echo "canceled"
		exit 2
	}

	channel=${choice}

	available_versions ${channel}
	select_version $(channel_name ${channel}) ${versions[@]}
	result=$?
	version=$choice
	if [[ ${result} -ne 0 ]]; then
		[[ ${result} == 1 ]] && {
			echo "canceled"
			exit 2
		}

		select_channel_version
	fi
}

function input_directory() {
	 ensure_ui_dependencies

	default_dir=$1
	cli_only=$2

	if [[ ${cli_only} == 1 ]]; then
		read -e -p "Select the TeaSpeak server directory: " -i ${default_dir} choice
		return 0
	fi
	choice=$(dialog --clear --extra-button --extra-label "Select via command line" --no-shadow --title "Select the TeaSpeak server directory" --dselect ${default_dir} 30 150 2>&1 >/dev/tty)
	choice_state=$?
	clear
	if [[ ${choice_state} -ne 0 ]]; then
		[[ ${choice_state} != 3 ]] && return ${choice_state}
		input_directory ${default_dir} 1
		return $?
	fi
	return 0
}

function is_teaspeak_directory() {
	directory=$1

	[[ ! -e "$directory/teastart_minimal.sh" ]] && return 0
	[[ ! -e "$directory/buildVersion.txt" ]] && return 0
	[[ ! -e "$directory/TeaSpeakServer" ]] && return 0

	return 1
}

function select_target_directory() {
	base=$([[ -z "$1" ]] && echo "./" || echo "$1")
	input_directory ${base}
	input_result=$?
	directory=${choice}

	[[ ${input_result} -ne 0 ]] && return 1
	[[ ! -d "$choice" ]] && {
		choice=$(dialog --clear --extra-button --extra-label "Create path" --no-ok --no-label "Cancel" --yesno "Entered path is not a directory.\nWould you like to try again or create the path?\n\nTeaSpeak directory: $choice" 30 150 2>&1 >/dev/tty)
		choice_result=$?
		[[ ${choice_result} -ne 0 ]] && {
			[[ ${choice_result} != 3 ]] && {
				return 1
			}

			output=$(mkdir -p ${directory} 2>&1)
			[[ $? == 0 ]] && {
				return 0
			}

			choice=$(dialog --clear --colors --yesno "Failed to create target path ($directory):\n\Z1$output\Zn\nWould you like to select another path?" 30 150 2>&1 >/dev/tty)
			[[ $? -ne 0 ]] &&  {
				return 1
			}
		}
		select_target_directory ${directory}
		return $?
	}
	return 0
}

# Download and install helpers
function install_version() {
	# Parameters
	directory=$1
	url=$2

	local download_file="$directory/TeaSpeak-Server.download"

	log_debug "Installing $url to $directory"

	if [[ -e "$download_file" ]]; then
		rm ${download_file}
		[[ -e "$download_file" ]] && {
			log_error "Failed to remove old temporary download file ($download_file)"
			return 1
		}
	fi
	wget -q -O "$download_file" ${url} &>/dev/null
	result=$?
	[[ result -ne 0 ]] && {
		log_error "Failed to download file from ${url}. Exit code: $result"
		return 1
	}

	log_debug "Unpacking downloaded archive"
	tar xf ${download_file} -C ${directory}
	[[ $? -ne 0 ]] && {
		log_error "Failed to unpack downloaded archive"
		return 1
	}

	rm ${download_file} &>/dev/null
	[[ $? -ne 0 ]] && {
		log_warn "Failed to remove temporary download files ($download_file)"
	}
	log_debug "Installation successfully"
	return 0
}

# CLI Interface
function print_help() {
	log_info "TeaSpeak Server updater and installer script"
	log_info "Usage: $0 options... [target]"
	log_info ""
	log_info "Available targets:"
	log_info "  install (default)           | Install the TeaSpeak server"
	log_info "  update                      | Update an already installed TeaSpeak server. Alias for 'install' (same behaviour)"
	log_info "  list-channels               | List all available build channels for your architecture"
	log_info "  list-versions [max size]    | List all available versions within the specified channel."
	log_info "  version                     | Prints the version of this script."
	log_info "  copyright                   | Prints the copyright notice of this script."
	log_info ""
	log_info "Available options:"
	log_info "  -c, --no-cli                | Disable CLI interface (Arguments only). Useful for automated scripts"
	log_info "  -t, --build-type=<value>    | Specify the build type you want to install. Use 'default' for the default build type."
	log_info "                              | Available types are listed here: https://repo.teaspeak.de/server/linux/"
	log_info "  -v, --version=<value>       | Specify the build version you want to install. Use 'latest' for the latest version"
	log_info "  -d, --directory=<value>     | Specify the target directory where you want to install/upgrade your TeaSpeak Server"
	#log_info "  -u, --no-check-update       | Disable the script update check"
	log_info "  -h, --help                  | Shows this page"
	log_info ""
	log_info "Examples:"
	log_info "  $0 list-channels => list all available channels"
	log_info "  $0 list-versions (With UI for channel selection)   => List all versions within the selected channel"
	log_info "  $0 -t stable list-versions                         => List all versions in the stable channel"
	log_info "  $0 -t stable list-versions 2                       => List the newest two versions within the stable channel"
	log_info "  $0 -v latest -t optimized -d /home/teaspeak/       => Update your server located at '/home/teaspeak/' to the newest optimized version"
	log_info ""
	log_info "Dependencies:"
	log_info "  This tool is dependent of 'wget' and 'dialog'."
	log_info "  'dialog' is not required when the '--no-cli' option is enabled."
	log_info "  Dependencies will be automatically installed as they are required."
}

target=""
target_arguments=()
option_no_cli=0
option_build_type=""
option_version=""
option_directory=""
option_help=0
option_script_no_update=0

function parse_arguments() {
	while [[ $# -gt 0 ]]; do
		case $1 in
		-c|--no-cli)
			option_no_cli=1
			shift
			;;
		-u|--no-check-update)
			option_script_no_update=1
			shift
			;;
		-h|--help)
			option_help=1
			shift
			;;
		-t)
			option_build_type="$2"
			shift; shift
			;;
		--build-type=*)
			option_build_type="${1:13}"
			shift
			;;
		-v)
			option_version="$2"
			shift; shift
			;;
		--version=*)
			option_version="${1:9}"
			shift
			;;
		-d)
			option_directory="$2"
			shift; shift
			;;
		--directory=*)
			option_version="${1:12}"
			shift
			;;
		*)
			if [[ "$1" == -* ]]; then
				log_warn "Ignoring command option $1"
				shift;
			else
				target="$1"

				local _arg=($@)
				target_arguments=(${_arg[@]:1})
				break
			fi
			shift
			;;
		esac
	done
}

# Targets
function target_install() {
	 channel=${option_build_type}
	 version=$([[ -z ${option_version} ]] && echo "" || echo "TeaSpeak-${option_version}.tar.gz")
	 directory=${option_directory}

	 if [[ ${channel} == "default" ]]; then
		 log_debug "Default channel points to $arch"
		 channel=${arch}
	fi

	if [[ ${channel} != *_* && ${channel} != "amd64" && ${channel} != "x86" && ${channel} != "${arch}" ]]; then
		 #Test if we have a arch prefix
		 log_debug "Appending arch prefix to channel type"
		 channel="${arch}_${channel}"
	fi

	if [[ -z "$option_version" && -z "$option_build_type" ]]; then
		[[ ${option_no_cli} -ne 0 ]] && {
			err_exit "Missing channel (Build type) and version. Please specify it or remove then '--no-cli' flag!"
		}

		select_channel_version
		[[ $? -ne 0 ]] && {
			log_info "Canceled"
			exit 0
		}
	elif [[ -z "$option_build_type" ]]; then
		[[ ${option_no_cli} -ne 0 ]] && {
			err_exit "Missing channel (Build type). Please specify it or remove then '--no-cli' flag!"
		}
		available_channels
		[[ $? -ne 0 ]] && {
			err_exit "Failed to fetch channel list!"
		}
		select_channel ${channels[@]}
		[[ $? -ne 0 ]] && {
			log_info "Canceled"
			exit 1
		}

		channel=${choice}
	elif [[ -z "$option_version" ]]; then
		[[ ${option_no_cli} -ne 0 ]] && {
			err_exit "Missing version. Please specify it or remove then '--no-cli' flag!"
		}

		available_versions ${channel}
		[[ $? -ne 0 ]] && {
			log_error "Failed to fetch version list."
			[[ ! -z "$option_build_type" ]] && log_error "Please ensure you're specifying a valid channel!"
			err_exit
		}
		select_version $(channel_name ${channel}) ${versions[@]}
		result=$?
		version=${choice}
		if [[ ${result} -ne 0 ]]; then
			[[ ${result} == 1 ]] && {
				echo "canceled"
				exit 2
			}

			select_channel_version
		fi
	fi

	if [[ -z "$directory" ]]; then
		[[ ${option_no_cli} -ne 0 ]] && {
				err_exit "Missing target directory. Please specify it or remove then '--no-cli' flag!"
		  }

		  select_target_directory
		  [[ $? -ne 0 ]] && {
				log_info "Canceled"
				exit 0
		  }
	fi

	if [[ ${version} == "latest" || ${version} == "TeaSpeak-latest.tar.gz" ]]; then
		 log_debug "Resolving latest version"
		 version="TeaSpeak-$(channel_version ${channel}).tar.gz"
		 log_info "Resolved latest version to $version"
	fi


	log_info "Installing version $version from channel $(channel_name ${channel}) to $directory"
	install_version ${directory} "$repo_url$os/${channel}/$version"
	[[ $? -ne 0 ]] && {
		log_error "Failed to install target version"
		exit 1
	}
	log_info "Successfully installed version $version. You may need to restart your TeaSpeak Server!"
	exit 0
}

function target_update() {
	local _args=(${@})
	target_install ${_args[@]}
}

function target_list_channels() {
	log_info "Listing available channels. (OS: $os; Arch: $arch)"
	available_channels
	[[ $? -ne 0 ]] && {
		err_exit "Failed to fetch channel list"
	}

	printf -v pad %30s
	for channel in ${channels[@]}; do
		channel_name=$(channel_name ${channel})
		channel_name+="$pad"
		channel_name=${channel_name:0:30}
		log_info "  $channel_name (Current version: $(channel_version ${channel}))"
	done
	exit 0
}

function target_list_versions() {
	if [[ ${#@} -ge 1 ]]; then
		[[ ! "$1" =~ ^[0-9]+$ ]] && {
			err_exit "Max length must be a number! Given: '$1'"
		}

		version_limit=$(($1))
	fi

	if [[ -z "$option_build_type" ]]; then
		[[ ${option_no_cli} -ne 0 ]] && {
			err_exit "Missing channel (Build type). Please specify it or remove then '--no-cli' flag!"
		}
		available_channels
		[[ $? -ne 0 ]] && {
			err_exit "Failed to fetch channel list"
		}
		select_channel ${channels[@]}
		[[ $? -ne 0 ]] && {
			log_info "Canceled"
			exit 1
		}

		channel=${choice}
	else
		channel=${option_build_type}
	fi

	 if [[ ${channel} == "default" ]]; then
		 log_debug "Default channel points to $arch"
		 channel=${arch}
	fi

	if [[ ${channel} != *_* && ${channel} != "amd64" && ${channel} != "x86" && ${channel} != "${arch}" ]]; then
		 #Test if we have a arch prefix
		 log_debug "Appending arch prefix to channel type"
		 channel="${arch}_${channel}"
	fi

	log_info "Listing versions for channel $(channel_name ${channel}). (OS: $os; Arch: $arch)"
	available_versions ${channel}
	[[ $? -ne 0 ]] && {
		log_error "Failed to fetch version list."
		[[ ! -z "$option_build_type" ]] && log_error "Please ensure you're specifying a valid channel!"
		err_exit
	}

	log_info "Fetching latest version"
	latest_version=$(channel_version ${channel})
	log_debug "Latest version: $latest_version"

	log_info "Available versions:"
	for version in ${versions[@]}; do
		[[ "$version" == "latest" ]] && continue

		if [[ "$version" == "TeaSpeak-$latest_version.tar.gz" ]]; then
			log_info "  $version (latest)"
		else
			log_info "  $version"
		fi

		if [[ ! -z "$version_limit" ]]; then
			version_limit=$(($version_limit - 1))
			[[ ${version_limit} -eq 0 ]] && break
		fi
	done

	exit 0
}

function target_copyright() {
    message=$(cat $0 | head -n 23 | tail -n +2)

    IFS=$'\n' message=(${message})
    for line in "${message[@]}"; do
        echo "${line:3}"
    done

    echo ""
    echo "ATTENTION: Please checkout the scripts first lines for the copyright notice!"
    exit 0
}

function target_version() {
    echo "$(basename $0): TeaSpeak Server updater and installer script version $version_major.$version_minor.$version_patch ($version_date)"
    exit 0
}

parse_arguments ${@}
[[ $? -ne 0 ]] && err_exit "Failed to parse arguments"

if [[ ${option_help} -ne 0 ]]; then
	print_help
	exit 0
fi

ensure_dependencies

case ${target} in
install|"")
	target_install ${target_arguments[@]}
	;;
update)
	target_update ${target_arguments[@]}
	;;
list-channels)
	target_list_channels ${target_arguments[@]}
	;;
list-versions)
	target_list_versions ${target_arguments[@]}
	;;
copyright)
	target_copyright ${target_arguments[@]}
	;;
version)
	target_version ${target_arguments[@]}
	;;
*)
	err_exit "Invalid target $target. For help please type $0 --help"
	;;
esac