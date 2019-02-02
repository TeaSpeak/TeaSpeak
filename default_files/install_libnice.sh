#!/bin/bash

LOCAL_FILE="libnice.tar.gz"
BASE_URL="https://repo.teaspeak.de/libnice/"

BASE_DIR=$(dirname "$0")
cd "$BASE_DIR"

#Function check
tar --version &>/dev/null
if [ $? -ne 0 ]; then
    echo "Missing command \"tar\". Please install it to proceed!"
    exit 1
fi

curl --version &>/dev/null
if [ $? -ne 0 ]; then
    echo "Missing command \"curl\". Please install it to proceed!"
    exit 1
fi

wget --version &>/dev/null
if [ $? -ne 0 ]; then
    echo "Missing command \"wget\". Please install it to proceed!"
    exit 1
fi

if [ $? -ne 0 ]; then
    echo "Failed to get download information"
    exit 1
fi

if [ ! -d libs ]; then
    echo "Your server installation seems to be broken! Please first fix the server right!"
    exit 1
fi

function error_exit() {
    echo "cleaning up"
    if [ -e "$LOCAL_FILE" ]; then
        rm "$LOCAL_FILE"
    fi
    exit 1
}

#Getting information
VERSION=$(curl -sk ${BASE_URL}/latest)
echo "Installing libnice from $BASE_URL$VERSION ($VERSION)"

#Download
wget -q "$BASE_URL$VERSION" -O "$LOCAL_FILE"
if [ $? -ne 0 ]; then
    echo "Failed to download package"
    exit 1
fi

#Extract (should create a folder called libnice)
tar xvf "$LOCAL_FILE"
if [ $? -ne 0 ]; then
    echo "Failed to extract package"
    error_exit
fi
if [ ! -d libnice ]; then
    echo "Missing expected directory"
    error_exit
fi

cd libs/
ln -s ../libnice/* .