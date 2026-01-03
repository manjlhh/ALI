#!/usr/bin/env sh

CDIR=$(dirname "$(readlink -f "$0")")
PROFILEDIR="$CDIR/profile"

cp -r /usr/share/archiso/configs/releng/packages.x86_64 "$PROFILEDIR/packages.x86_64"
