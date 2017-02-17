out="$1"
disk_size="$2"

boot0="blobs/boot0.bin"
uboot="build/u-boot-with-dtb.bin"


if [ -z "$out" ]; then
	echo "Usage: $0 <image-file.img> [disk size in MiB]"
	exit 1
fi

if [ -z "$disk_size" ]; then
	disk_size=100 #MiB
fi

if [ "$disk_size" -lt 60 ]; then
	echo "Disk size must be at least 60 MiB"
	exit 2
fi

echo "Creating image $out of size $disk_size MiB ..."



temp=$(mktemp -d)

cleanup() {
	if [ -d "$temp" ]; then
		rm -rf "$temp"
	fi
}
trap cleanup EXIT

boot0_position=8      # KiB
uboot_position=19096  # KiB
part_position=20480   # KiB
boot_size=50          # MiB

set -x

# Create beginning of disk
dd if=/dev/zero bs=1M count=$((part_position/1024)) of="$out"
dd if="$boot0" conv=notrunc bs=1k seek=$boot0_position of="$out"
dd if="$uboot" conv=notrunc bs=1k seek=$uboot_position of="$out"

# Create boot file system (VFAT)
dd if=/dev/zero bs=1M count=${boot_size} of=${out}1
mkfs.vfat -n BOOT ${out}1

dd if=${out}1 conv=notrunc oflag=append bs=1M seek=$((part_position/1024)) of="$out"
rm -f ${out}1

# Create additional ext4 file system for rootfs
dd if=/dev/zero bs=1M count=$((disk_size-boot_size-part_position/1024)) of=${out}2
mkfs.ext4 -F -b 4096 -E stride=2,stripe-width=1024 -L rootfs ${out}2
dd if=${out}2 conv=notrunc oflag=append bs=1M seek=$((part_position/1024+boot_size)) of="$out"
rm -f ${out}2

# Add partition table
cat <<EOF | fdisk "$out"
o
n
p
1
$((part_position*2))
+${boot_size}M
t
c
n
p
2
$((part_position*2 + boot_size*1024*2))
t
2
83
w
EOF

sync
