#!/sbin/sh

# The below variables shouldn't need to be changed
# unless you want to call the script something else
SCRIPTNAME="ezext4format"

umount /data
umount /sdcard

SIZE=$(blockdev --getsz /dev/block/bootdevice/by-name/userdata)
SIZE=$((SIZE - 32))
mkfs.ext4 -L data -b 4096 /dev/block/bootdevice/by-name/userdata $((SIZE * 512 / 4096))