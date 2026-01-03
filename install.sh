#!/usr/bin/env sh

ISOFILE=/tmp/archiso/out/archlinux-latest-x86_64.iso
IMGFILE=/home/azat/Desktop/arch.img

qemu-system-x86_64 -smp cores=8 -m 8G -accel tcg -cdrom "$ISOFILE" -drive "file=$IMGFILE,format=raw" -vga virtio
