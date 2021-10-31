# Prerequisities
## GNU
* `nproc` @ [coreutils](https://www.gnu.org/software/coreutils)
## QEMU
* `qemu-x86_64` @ [qemu](https://wiki.qemu.org)
## EFI
* [edk2-ovmf](https://github.com/tianocore/edk2)

## Buildroot
* submodule [buildroot/buildroot](https://github.com/buildroot/buildroot)

# Build
## EFI
```
cd buildroot \
&& make BR2_EXTERNAL=../external defconfig BR2_DEFCONFIG=../efi-defconfig \
&& make BR2_EXTERNAL=../external \
&& cd ..
```
## MBR
```
cd buildroot \
&& make BR2_EXTERNAL="../external" defconfig BR2_DEFCONFIG=../mbr-defconfig \
&& make BR2_EXTERNAL=../external \
&& cd ..
```
# Run
## EFI
```
declare -i CPU_COUNT=$(nproc) \
&& qemu-system-x86_64 -smp ${CPU_COUNT} -m $(( ${CPU_COUNT} * 128 )) \
-enable-kvm -cpu max,hv-runtime \
-drive file=buildroot/output/images/disk.img,format=raw \
-bios /usr/share/OVMF/x64/OVMF.fd
```
## MBR
```
declare -i CPU_COUNT=$(nproc) \
&& qemu-system-x86_64 -smp ${CPU_COUNT} -m $(( ${CPU_COUNT} * 128 )) \
-enable-kvm -cpu max,hv-runtime \
-cdrom buildroot/output/images/rootfs.iso9660
```

## Command-line
* Run twice number of CPUs
```
declare -i CPU_COUNT=$(( $(nproc) * 2 )) \
&& qemu-system-x86_64 -smp ${CPU_COUNT} -m $(( ${CPU_COUNT} * 128 * 2 )) \
-enable-kvm -cpu max,hv-runtime \
-drive file=buildroot/output/images/disk.img,format=raw \
-kernel buildroot/output/images/bzImage \
-append "nr_cpus=$(( ${CPU_COUNT} * 2 )) root=/dev/sda2 rootwait console=tty1 quiet"
```
