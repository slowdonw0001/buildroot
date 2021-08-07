mmc dev 0
setenv fdto_addr_r 0x02700000
fatload mmc 0:1 ${kernel_addr_r} Image
fatload mmc 0:1 ${fdt_addr_r} bcm2711-rpi-4-b.dtb
fdt addr ${fdt_addr_r}
fdt resize 65536
fatload mmc 0:1 ${fdto_addr_r} overlays/uart0.dtbo
fdt apply ${fdto_addr_r}
setenv bootargs console=ttyAMA0,115200 root=/dev/mmcblk0p2 rootwait
booti ${kernel_addr_r} - ${fdt_addr_r}
