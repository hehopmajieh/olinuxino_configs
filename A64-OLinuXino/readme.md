# A64-OLinuXino Build Instructions

## Linux

### 1. Getting source code and helper scripts
	
```bash
mkdir a64-olinuxino
cd a64-olinuxino
git clone https://github.com/A64-TERES/linux-a64
git clone https://github.com/A64-TERES/u-boot_new
git clone https://github.com/hehopmajieh/arm-trusted-firmware-a64
git clone https://github.com/A64-TERES/blobs
git clone https://github.com/A64-TERES/sunxi-pack-tools sunxi-pack-tools -b pinebook
git clone https://github.com/A64-TERES/scripts
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
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- olimex_teres1_defconfig
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- LOCALVERSION= clean
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j4 LOCALVERSION= Image
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j4 LOCALVERSION= modules
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j4 LOCALVERSION= modules_install  INSTALL_MOD_PATH=out INSTALL_MOD_STRIP=1
```
#### U-Boot
```bash
cd ../scripts/
./build_uboot.sh #A64-Teres
```
or 
```bash
./build_uboot_a64.sh #A64-OLinuXino
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

