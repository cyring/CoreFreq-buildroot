# Prerequisities
## QEMU
* qemu
## EFI
* edk2-ovmf

## Buildroot

# Build
## EFI
```
cd buildroot && make BR2_EXTERNAL=../external defconfig BR2_DEFCONFIG=../efi-defconfig && make BR2_EXTERNAL=../external && cd ..
```
## MBR
```
cd buildroot && make BR2_EXTERNAL="../external" defconfig BR2_DEFCONFIG=../mbr-defconfig && make BR2_EXTERNAL=../external && cd ..
```
# Run
## EFI
```
qemu-system-x86_64 -smp 8 -m 2048 -enable-kvm -cpu max,hv-runtime buildroot/output/images/disk.img -bios /usr/share/OVMF/x64/OVMF.fd
```
## MBR
```
qemu-system-x86_64 -smp 8 -m 2048 -enable-kvm -cpu max,hv-runtime -cdrom buildroot/output/images/rootfs.iso9660
```
