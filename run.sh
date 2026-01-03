#!/usr/bin/env sh

IMGFILE=/home/azat/Desktop/arch.img

qemu-system-x86_64 -smp cores=8 -m 8G -accel tcg -vga virtio \
 -drive "file=$IMGFILE,format=raw,if=none,id=nvm"\
 -device nvme,serial=deadbeef,drive=nvm\
 -nic bridge,br=br0,model=virtio-net-pci
