#!/usr/bin/env sh

ISOFILE=/tmp/archiso/out/archlinux-latest-x86_64.iso
IMGFILE=/home/azat/Desktop/arch.img
EFI_VARS_FILE=/home/azat/Desktop/OVMF_VARS.4m.fd

case "$1" in
"reinit")
    rm "$EFI_VARS_FILE"
    cp /usr/share/edk2/x64/OVMF_VARS.4m.fd "$EFI_VARS_FILE"
    ;;
"init")
    cp /usr/share/edk2/x64/OVMF_VARS.4m.fd "$EFI_VARS_FILE"
    ;;
esac

if [ ! -f "$EFI_VARS_FILE" ]; then
    echo "no efi vars file $EFI_VARS_FILE"
    exit 1
fi

qemu-system-x86_64 -smp cores=8 -m 8G -accel tcg\
 -drive if=pflash,format=raw,readonly=on,file=/usr/share/edk2/x64/OVMF_CODE.4m.fd\
 -drive if=pflash,format=raw,file=$EFI_VARS_FILE\
 -drive file=$ISOFILE,index=0,media=cdrom,readonly=on\
 -boot d\
 -drive "file=$IMGFILE,format=raw,if=none,id=nvm"\
 -device nvme,serial=deadbeef,drive=nvm\
 -vga virtio\
 -nic none
