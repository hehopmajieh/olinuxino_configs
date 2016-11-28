# A33-OLinuXino 

## Android:

 * Installing required packages /Ubuntu or Debian, tested on ubuntu 12.04/ : You can follow official google documentation : Google Link
 * Getting Sources Sources are available by BitTorrent. Links to Source Archives :
 	[Android Source]() and [Lichee Source]()
 * Extracting Sources and Building Android
 	
```bash
$ mkdir ~/allwinner
$ cd ~/allwiiner
$ tar zxfv android4.4_a33.tgz
$ tar zxfv lichee-a33.tgz
$ cd lichee
$ ./build.sh config 

#Use Configuration options listed below :
#Welcome to mkscript setup progress
#All available chips:
#   0. sun8iw5p1
#Choice: 0
#All available platforms:
#   0. android
#   1. dragonboard
#   2. linux
#Choice: 0
#All available kernel:
#   0. linux-3.4
#Choice: 0
#All available boards:
#   0. evb
#   1. maple
#   2. olinuxino-a33
#   3. redwood
#   4. y2
#   5. y3
#Choice: 2
					
```
If you want to change some kernel config options  before running `build.sh` navigate to linux-3.4 
and run kernel menuconfig ex. `make menuconfig`

Building:
```bash
$ ./build.sh config 
#After Successufully build navigate to Android directory
$ cd ../android4.4
$ source build/envsetup.sh
$ lunch #select "8. olinuxino_a33-eng"
$ extract-bsp
$ make -j4
$ pack
```
Image will be located at : `../lichee/tools/pack/sun8iw5p1_android_olinuxino-a33.img`
Now you can flash device using `PhoenixSuite` tool.

### FEX File Configuration
Fex file is located in `lichee/tools/pack/chips/sun8iw5p1/configs/olinuxino-a33/` directory.
You must edit configuration before image pack operation.

For Ex: If you want to use 10'' LCD privded by Olimex, you must change `[lcd0]` section in file.
##

# Linux

### Get Kernel and setup toolchain
```bash
$ cd ~
$ apt-get install build-essential git qemu-user-static debootstrap binfmt-support
$ wget https://launchpad.net/linaro-toolchain-binaries/trunk/2012.02/+download/gcc-linaro-arm-linux-gnueabi-2012.02-20120222_linux.tar.bz2
$ sudo tar jxfv gcc-linaro-arm-linux-gnueabi-2012.02-20120222_linux.tar.bz2 -C /opt
$ sudo export PATH=$PATH:/opt/gcc-linaro-arm-linux-gnueabi-2012.02-20120222_linux/bin/
```
### Clone Linux kernel tree and build kernel
```bash
git clone https://github.com/hehopmajieh/a33_linux
cd a33_linux
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- a33Olinuxino_defconfig
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- uImage -j4
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- modules -j4
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- -j4 INSTALL_MOD_PATH=<path_to_install_modules> modules_install 
#Note:  You must specify path, where modules should be installed
```
### Build minimal RootFS
```bash
$ targetdir=rootfs
$ distro=jessie
sudo debootstrap --arch=armhf --foreign $distro $targetdir

#Cofee/Beer Time
$ sudo cp /usr/bin/qemu-arm-static $targetdir/usr/bin/
$ sudo cp /etc/resolv.conf $targetdir/etc
$ sudo chroot $targetdir

#We need to set some ENV before second stage

I have no name!@test:/# distro=jessie
I have no name!@test:/# export LANG=C
I have no name!@test:/# /debootstrap/debootstrap --second-stage

#Replace mirror address with local one

I have no name!@bundie:/# cat <<EOT > /etc/apt/sources.list
deb http://ftp.bg.debian.org/debian $distro main contrib non-free
deb-src http://ftp.bg.debian.org/debian $distro main contrib non-free
deb http://ftp.bg.debian.org/debian $distro-updates main contrib non-free
deb-src http://ftp.bg.debian.org/debian $distro-updates main contrib non-free
deb http://security.debian.org/debian-security $distro/updates main contrib non-free
deb-src http://security.debian.org/debian-security $distro/updates main contrib non-free
EOT

I have no name!@test:/# apt-get update
I have no name!@test:/# apt-get install locales dialog
I have no name!@test:/# dpkg-reconfigure locales

#Set Hostname and root password
I have no name!@test:/# passwd
I have no name!@test:/# echo "A33-OLinuXino" > /etc/hostname

# If you want to install additional packages

I have no name!@test:/# apt-get install wireless-tools alsa-tools

#Exit from chrooted ENV

I have no name!@bundie:/# exit

```



