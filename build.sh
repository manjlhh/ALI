#!/usr/bin/env sh

set -e

pacman -Qqi archiso >/dev/null 2>&1 || PKGS="$PKGS archiso"
if [ ! -z "$PKGS" ]; then
    sudo pacman --needed --noconfirm -S "$PKGS"

    if [ "$?" -ne 0 ]; then
    echo "error on $PKGS installing"
    exit 1
    fi
fi

CDIR=$(dirname "$(readlink -f "$0")")
ARCHDIR="/tmp/archiso"
sudo rm -rf  "$ARCHDIR"
mkdir -p "$ARCHDIR"

PROFILEDIR="$ARCHDIR/profile"
mkdir -p "$PROFILEDIR"
cp -r /usr/share/archiso/configs/releng/* "$PROFILEDIR"

# apply profile patches
cp -r $CDIR/profile/* "$PROFILEDIR"

ROOTFS="$PROFILEDIR/airootfs"
mkdir -p "$ROOTFS/root/repo/db"
mkdir -p "$ROOTFS/root/repo/pkg"

# services
rm "$ROOTFS/etc/systemd/system/dbus-org.freedesktop.ModemManager1.service"
rm "$ROOTFS/etc/systemd/system/multi-user.target.wants/ModemManager.service"
rm "$ROOTFS/etc/systemd/system/multi-user.target.wants/vboxservice.service"

echo 'db & cache'
sudo pacman -Syw --cachedir "$ROOTFS/root/repo/pkg" --dbpath "$ROOTFS/root/repo/db" - < "$CDIR/packages" \
--noconfirm

# exit 0

# mkarchiso
WORKDIR="$ARCHDIR/tmp"
OUTDIR="$ARCHDIR/out"
sudo mkarchiso -v -w "$WORKDIR" -o "$OUTDIR" "$PROFILEDIR"
