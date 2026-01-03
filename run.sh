#!/usr/bin/env sh

IMGFILE=/home/azat/Desktop/arch.img

qemu-system-x86_64 -smp cores=8 -m 8G -accel tcg -drive "file=$IMGFILE,format=raw" -vga virtio \
    -nic bridge,br=br0,model=virtio-net-pci
