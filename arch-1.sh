#Refresh mirrors
#reflector --verbose -c "India" --sort rate > /etc/pacman.d/mirrorlist
pacman -Syy > /dev/null 2>&1
echo
echo
echo "[+] All Package Databases were updated !"
echo
echo


#Disks
mkfs.btrfs /dev/sda3 -f > /dev/null 2>&1
mkswap /dev/sda4 > /dev/null 2>&1
swapon /dev/sda4 > /dev/null 2>&1
mount /dev/sda3 /mnt
btrfs su cr /mnt/@
btrfs su cr /mnt/@home
btrfs su cr /mnt/@var
umount /mnt
mount -o noatime,compress=zstd,discard=async,space_cache,subvol=@ /dev/sda3 /mnt
mkdir /mnt/home
mkdir /mnt/var
mount -o noatime,compress=zstd,discard=async,space_cache,subvol=@home /dev/sda3 /mnt/home
mount -o noatime,compress=zstd,discard=async,space_cache,subvol=@var /dev/sda3 /mnt/var

echo 
echo "--------------------------------------------------------"
echo

lsblk

echo
echo "--------------------------------------------------------"
echo

sleep 15s

#Install Base System
echo
echo
echo "[+] Installing Packages to the new root, this might take some time."
pacstrap /mnt base linux-zen linux-firmware sudo nano vi vim networkmanager ufw > /dev/null 2>&1
echo
echo


#Generate fstab
genfstab -U -p /mnt >> /mnt/etc/fstab


