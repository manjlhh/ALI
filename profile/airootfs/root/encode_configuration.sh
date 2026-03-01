#!/usr/bin/env sh

# openssl passwd -6 <password>

if [ $# -ne 2 ]; then
    echo 'wrong arguments number'
    echo 'usage: ./encode_configuration <password> <profile name to save in profiles directory>'
    exit 1
fi

SDIR=$(dirname "$(readlink -f "$0")")

PASSWD=$1
PROFILE=$2
PROFILES_DIR="$SDIR/profiles"

set -e

openssl aes-256-cbc -a -salt -pbkdf2 -pass "pass:$PASSWD" -in "$SDIR/plain_configuration" -out "$PROFILES_DIR/$PROFILE"
