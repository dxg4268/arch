#Refresh mirrors
reflector --verbose -c "India" --sort "rate" > /etc/pacman.d/mirrorlist
pacman -Syy

#Install Base System
pacstrap /mnt base linux-zen linux-firmware sudo nano vi vim networkmanager ufw

#Generate fstab
genfstab -U /mnt >> /mnt/etc/fstab


