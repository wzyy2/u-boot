../rkbin/tools/trust_merger ../rkbin/tools/RK3399TRUST.ini
../rkbin/tools/loaderimage --pack --uboot ../u-boot-rockchip/u-boot-dtb.bin ../uboot.img
upgrade_tool UL  ../rkbin/rk33/rk3399miniloader_V040601_emmc100M_DDR200.bin
upgrade_tool DI uboot ../uboot.img  ../rkbin/tools/rk3399_parameter.txt
upgrade_tool DI trust ../trust.img  ../rkbin/tools/rk3399_parameter.txt
upgrade_tool RD