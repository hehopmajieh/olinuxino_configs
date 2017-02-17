# A64-OLinuXino Build Instructions

## Linux

### 1. Getting source code and helper scripts
	
```bash
mkdir a64-olinuxino
cd a64-olinuxino
git clone https://github.com/hehopmajieh/linux-a64
git clone https://github.com/hehopmajieh/u-boot-a64
git clone https://github.com/hehopmajieh/arm-trusted-firmware-a64
git clone https://github.com/hehopmajieh/a64_blobs
git clone https://github.com/longsleep/sunxi-pack-tools.git sunxi-pack-tools
```
### 2. Setup toolchain
```bash
	sudo apt install gcc-aarch64-linux-gnu
    sudo apt install gcc-4.7-arm-linux-gnueabihf
```

### 3. Cross-compile sources

#### Linux
```bash
cd linux-a64
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- sun50iw1p1smp_linux_defconfig
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- LOCALVERSION= clean
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j4 LOCALVERSION= Image
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j4 LOCALVERSION= modules
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j4 LOCALVERSION= modules_install  INSTALL_MOD_PATH=out INSTALL_MOD_STRIP=1
```
#### U-Boot
```bash
cd ../u-boot-a64/
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- sun50iw1p1_config
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-
```
#### ATF
```bash
cd ../arm-trusted-firmware-a64/
make clean
make ARCH=arm CROSS_COMPILE=aarch64-linux-gnu- PLAT=sun50iw1p1 bl31
```
#### Allwinner Pack Tools 
```bash
cd ../
make -C sunxi-pack-tools
```
### 4. Helper Scripts
Scripts are located under Tools directory in this repo. 
They must be copied in a64-olinuxino directory.

