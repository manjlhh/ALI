#!/usr/bin/env sh

pacman -Qqi arch-install-scripts >/dev/null 2>&1 || PKGS="$PKGS arch-install-scripts"
if [ ! -z "$PKGS" ]; then
    sudo pacman --needed --noconfirm -S "$PKGS"

    if [ "$?" -ne 0 ]; then
    echo "error on $PKGS installing"
    exit 1
    fi
fi

CDIR=$(dirname "$(readlink -f "$0")")
PROFILEDIR="$CDIR/profile"
ROOTFS="$PROFILEDIR/airootfs/root"

cp /usr/share/archiso/configs/releng/packages.x86_64 /usr/share/archiso/configs/releng/pacman.conf "$PROFILEDIR/"

sed 's/pacmode=-Sy/pacmode=-S/' $(which pacstrap) > "$ROOTFS/pacstrap"
