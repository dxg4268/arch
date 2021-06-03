#Refresh mirrors
reflector --verbose -c "India" --sort rate > /etc/pacman.d/mirrorlist
pacman -Syy

#Disks
mkfs.btrfs /dev/sda3 -f
mkswap /dev/sda4
swapon /dev/sda4
mount /dev/sda3 /mnt
btrfs su cr /mnt/@
btrfs su cr /mnt/@home
umount /mnt
mount -o compress=zstd,subvol=@ /dev/sda3 /mnt
mkdir /mnt/home
mount -o compress=zstd,subvol=@home /dev/sda3 /mnt/home

#Install Base System
pacstrap /mnt base linux-zen linux-firmware sudo nano vi vim networkmanager ufw

#Generate fstab
genfstab -U -p /mnt >> /mnt/etc/fstab


