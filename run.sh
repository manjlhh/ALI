#!/usr/bin/env sh

IMGFILE=/home/azat/Desktop/arch.img
EFI_VARS_FILE=/home/azat/Desktop/OVMF_VARS.4m.fd

if [ ! -f "$EFI_VARS_FILE" ]; then
    echo "no efi vars file $EFI_VARS_FILE"
    exit 1
fi

qemu-system-x86_64 -smp cores=8 -m 8G -accel tcg\
 -drive if=pflash,format=raw,readonly=on,file=/usr/share/edk2/x64/OVMF_CODE.4m.fd\
 -drive if=pflash,format=raw,file=$EFI_VARS_FILE\
 -drive "file=$IMGFILE,format=raw,if=none,id=nvm"\
 -device nvme,serial=deadbeef,drive=nvm\
 -vga virtio\
 -nic bridge,br=br0,model=virtio-net-pci
