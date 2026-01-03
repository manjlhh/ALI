#!/usr/bin/env sh

if [ $# -ne 2 ]; then
    echo 'wrong arguments number'
    echo 'usage: ./decode_configuration <password> <profile name from profiles directory>'
    exit 1
fi

CDIR=$(dirname "$(readlink -f "$0")")
PASSWD=$1
PROFILE=$2
PROFILES_DIR="$CDIR/profiles"

set -e

[ ! -f "$PROFILES_DIR/$PROFILE" ] && echo "no profile '$PROFILES_DIR/$2' exists" && exit 1

rm -f "$CDIR/plain_configuration"
openssl aes-256-cbc -d -a -pbkdf2 -pass "pass:$PASSWD" -in "$PROFILES_DIR/$PROFILE" -out "$CDIR/plain_configuration"
