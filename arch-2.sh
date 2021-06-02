#Time
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
timedatectl set-ntp true
hwclock --systohc

#Locale
echo 'en_IN UTF-8' >> /etc/locale.gen
locale-gen
echo "LANG=en_IN.UTF-8" > /etc/locale.conf

#Hosts
echo arch > /etc/hostname
echo "127.0.0.1		localhost" >> /etc/hosts
echo "::1		localhost" >> /etc/hosts
echo "127.0.1.1		arch.localdomain	arch" >> /etc/hosts

#Bootloader
pacman -S grub grub-btrfs os-prober ntfs-3g
os-prober
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

#Extra packages
pacman -S mesa

#enable service
systemctl enable ufw
systemctl enable NetworkManager
