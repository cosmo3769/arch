# Important commands: 

`cd` - change directory

`ls` `ls -a` - list/list all

`mv` - move file to different location/ rename 

`df -h` - disk free

`du -sh /*` - disk usage

`lsblk` - lists information about all available or the specified block devices

`fdisk` - fixed disk/format disk

`cfdisk` - create, delete, and modify partitions on a disk device (graphical interface)

`updatedb` `locate` `plocate` - update database, locate file/folder

`pacman -S` - install package

`pacman -Syyu` - update and upgrade package

`pacman -Rns` - remove all the dependency and package 

`neofetch` - about Linux/system running details(time)

`xmodmap -pke` - [utility for modifying keymaps](https://wiki.archlinux.org/title/xmodmap)

`showkey -a` - show the key and keycode 

### Mount iso image 

* Download iso image
* Go to terminal, create directory with `mkdir /mnt/iso` or `sudo mkdir /mnt/iso`
* Type in `mount -o loop /path/to/your/iso/ /mnt/iso/`

### Mount flash drives

* Plug in usb
* `fdisk -l`
* find something with `/dev/sdb1`
* create directory with `mkdir /mnt/usbstick` or `sudo mkdir /mnt/usbstick`
* `mount /dev/sdb1 /mnt/usbstick/`

### Unmount 

* `umount /mnt/iso` or `umount /mnt/usbstick`

### Conflict while updating and upgrading with pacman due to npm 

* Run this `sudo pacman -S npm --overwrite '/usr/lib/node_modules/npm/*'` to get your issue solved.
