#Time
pacman -S ntp
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
echo "::1		      localhost" >> /etc/hosts
echo "127.0.1.1		arch.localdomain	arch" >> /etc/hosts

#Bootloader
pacman -S grub grub-btrfs os-prober ntfs-3g
os-prober
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

#Extra packages
pacman -S vlc xorg base-devel git go gnome firefox

#Chaotic AUR and imp AUR Packages
pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
pacman-key --lsign-key 3056513887B78AEB
pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-'{keyring,mirrorlist}'.pkg.tar.zst'
echo "[multilib]" >> /etc/pacman.conf
echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
echo "[chaotic-aur]" >> /etc/pacman.conf
echo "Include = /etc/pacman.d/chaotic-mirrorlist" >> /etc/pacman.conf
pacman -Sy pamac-aur archlinux-appstream-data libpamac-aur yay

#enable service
systemctl enable ufw
systemctl enable NetworkManager
systemctl enable gdm

