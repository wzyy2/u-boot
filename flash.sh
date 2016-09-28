CROSS_COMPILE=arm-linux-gnueabihf- make kylin-rk3036_defconfig all

CROSS_COMPILE=arm-linux-gnueabihf- make firefly-rk3288_defconfig all

CROSS_COMPILE=arm-linux-gnueabihf- make evb-rk3288_defconfig all

CROSS_COMPILE=arm-linux-aarch64- make evb-rk3399_defconfig all

tools/mkimage -n rk3036 -T rksd -d spl/u-boot-spl.bin RK3036_uboot.img
cat u-boot-dtb.bin >> RK3036_uboot.img

cat RK3036_DDR3_400M_V1.06.bin | openssl rc4 -K 7c4e0304550509072d2c7b38170d1711 | sudo rkflashtool l
cat rk303xusbplug.bin | openssl rc4 -K 7c4e0304550509072d2c7b38170d1711 | sudo rkflashtool L
sleep 1
export LOADER_SIZE=$(wc -c RK3036_uboot.img  | awk '{print int($1/512 + 1)}')
echo loader: RK3036_uboot.img, size: $LOADER_SIZE
sudo rkflashtool w 64 $LOADER_SIZE <RK3036_uboot.img
sudo rkflashtool b


tools/mkimage -n rk3288 -T rksd -d spl/u-boot-spl-dtb.bin u-boot-dtb.bin(normal)
tools/mkimage -n rk3288 -T rksd -d spl/u-boot-spl-nodtb.bin u-boot-dtb.bin(firefly)

tools/mkimage -n rk3288 -T rksd -d spl/u-boot-spl-dtb.bin u-boot-dtb.bin

tools/mkimage -n rk3288 -T rksd -d spl/u-boot-spl-nodtb.bin u-boot-dtb.bin
sudo upgrade_tool db  rk3288_boot.bin
sudo upgrade_tool wl 64 u-boot-dtb.bin
sudo upgrade_tool wl 256 u-boot.img
sudo upgrade_tool rd



dd if=./32_LPDDR2_200MHz_LPDDR3_200MHz_DDR3_200MHz_20150318.bin of=./u-boot-spl-dtb.bin bs=4 skip=1
tools/mkimage -n rk3288 -T rksd -d  u-boot-spl-dtb.bin out
cat u-boot-dtb.bin >> out
dd if=./out of=/dev/sdc seek=64 bs=512 conv=notrunc


tools/mkimage -n rk3288 -T rksd -d spl/u-boot-spl-nodtb.bin out&&
sudo dd if=out of=/dev/sdb seek=64&&sudo dd if=u-boot-dtb.img of=/dev/sdb seek=256


tools/mkimage -n rk3288 -T rksd -d spl/u-boot-spl-dtb.bin out&&
sudo dd if=out of=/dev/sdb seek=64&&sudo dd if=u-boot-dtb.img of=/dev/sdb seek=256


tools/mkimage -n rk3399 -T rksd -d spl/u-boot-spl.bin uboot.img
cat u-boot-dtb.bin >> uboot.img

cat RK3399_DDR_666M_V1.00.bin | openssl rc4 -K 7c4e0304550509072d2c7b38170d1711 | sudo rkflashtool l
cat rk3399usbplug.bin | openssl rc4 -K 7c4e0304550509072d2c7b38170d1711 | sudo rkflashtool L

export LOADER_SIZE=$(wc -c uboot.img  | awk '{print int($1/512 + 1)}')
echo loader: RK3399_uboot.img, size: $LOADER_SIZE
sudo rkflashtool w 64 $LOADER_SIZE <  uboot.img
sudo rkflashtool b


../rkbin/tools/loaderimage --pack --uboot u-boot-dtb.bin uboot.img

../rkbin/tools/loaderimage --pack --uboot u-boot-dtb.bin uboot.img

 make CROSS_COMPILE=aarch64-linux-gnu- evb-rk3399_defconfig all
../rkbin/tools/loaderimage --pack --uboot u-boot-dtb.bin uboot.img
sudo upgrade_tool UL ../rkbin/rk33/rk3399miniloader_V040601_emmc100M_DDR200.bin
sudo upgrade_tool DI uboot uboot.img  parameter.txt
sudo upgrade_tool RD



sudo dd if=../rkbin/rk33/rk3399miniloader_V040601_emmc100M_DDR200.bin of=/dev/sdb seek=64

sudo dd if=uboot.img of=/dev/sdb seek=16384

apt-get install libx11-dev

export CMAKE_INSTALL_PREFIX=/usr/
 cmake .  -DCODEC_BACKEND=libvpu  -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_LIBDIR=/usr/lib/arm-linux-gnueabihf

make install
 cp -rf /usr/local/lib/dri/rockchip_drv_video.so /usr/lib/arm-linux-gnueabihf/dri/rockchip_drv_video.so

su linaro -c "DISPLAY=:0.0 x11perf -tilerect500"
 DISPLAY=:0.0 x11perf -tilerect500
 40000 reps @   0.1595 msec (  6270.0/sec): 500x500 tiled rectangle (4x4 tile)
	400 reps @  14.8869 msec (    67.2/sec): 500x500 opaque stippled rectangle (8x8 stipple)

su linaro -c "DISPLAY=:0.0 x11perf -osrect500"
	without 3000 reps @   2.1171 msec (   472.0/sec): 500x500 tiled rectangle (4x4 tile)
	without 3000 reps @   2.4227 msec (   413.0/sec): 500x500 opaque stippled rectangle (8x8 stipple)
libnuma-dev  libslang2-dev
	sudo apt-get install  libelf-dev libdw-dev binutils-dev -t testing
	sudo apt-get install libaudit-dev   libperl-dev python-dev  liblzma-dev  libslang2-dev libunwind-dev  \
libiberty-dev

make LDFLAGS=-static ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- DEBUG=1 

./perf stat x11perf -osrect500

x11perf
glmark2-es2
Sync time adjustment is 0.0883 msecs

./perf stat x11perf -osrect500

./perf record –g   x11perf -osrect500

with glamor

CROSS_COMPILE=aarch64-linux-gnu- make evb-rk3399_defconfig all

win32disk

mkdir image
mv trust.img ./image/
mv uboot.img ./image/rk3399evb-uboot.bin

./rkbin/tools/trust_merger rkbin/tools/RK3399TRUST.ini
./rkbin/tools/loaderimage --pack --uboot u-boot-rockchip/u-boot-dtb.bin uboot.img

sudo upgrade_tool UL   miniloader.img

sudo upgrade_tool UL   rk3399miniloader_V040601_emmc100M_DDR200.bin
sleep 1
sudo upgrade_tool DI uboot uboot.img  ./rkbin/tools/rk3399_parameter.txt
sleep 1
upgrade_tool DI trust trust.img  ./rkbin/tools/rk3399_parameter.txt
sudo upgrade_tool RD

upgrade_tool DI trust trust-no-checkv1.4.img  ./rkbin/tools/rk3399_parameter.txt

sudo upgrade_tool DI uboot trust2.img  ./rkbin/tools/rk3399_parameter.txt

sudo upgrade_tool wl 64 image/miniloader.img

sudo upgrade_tool wl 64 rk3399miniloader_V040601_emmc100M_DDR200.bin

sudo upgrade_tool UL   RK3399MiniLoaderAll_V1.05.bin


cp arm-trusted-firmware/build/rk3399/release/bl31.bin rkbin/rk33/rk3399bl31.bin

dd if=./rkbin/rk33/rk3399miniloaderall_v1.05.bin of=miniloader.tmp bs=4 skip=1
./u-boot/tools/mkimage -n rk3399 -T rksd -d miniloader.tmp miniloader.img

./rkbin/tools/trust_merger rkbin/tools/RK3399TRUST.ini
./rkbin/tools/loaderimage --pack --uboot u-boot-rockchip/u-boot-dtb.bin uboot.img
sudo upgrade_tool DB   rk3399miniloader_V040601_emmc100M_DDR200.bin
sudo upgrade_tool wl 64 ./rkbin/rk33/RK3399MiniLoaderAll_V1.05.bin  
sudo upgrade_tool wl 16384 uboot.img  
sudo upgrade_tool wl 24576 trust.img
sudo upgrade_tool rd

sudo dd if=rk3399miniloader_V040601_emmc100M_DDR200.bin of=/dev/sdb seek=64
sudo dd if=uboot.img of=/dev/sdb seek=16384
&&sudo dd if=u-boot-dtb.img of=/dev/sdb seek=256

u-boot/tools/mkimage -n rk3399 -T rksd -d 

sudo dd if=image/miniloader.img of=/dev/sdb seek=64
sudo dd if=uboot.img of=/dev/sdb seek=16384


x11perf  -all -repeat 2 


./perf record -e cpu-clock -g  ./x11perf/x11perf  -osrect500
./perf report


readelf -S /usr/bin/x11perf |grep debug

readelf -S ./x11perf/x11perf |grep debug

 sudo echo "-1" >  /proc/sys/kernel/perf_event_paranoid





git send-email --annotate --cc "kever.yang@rock-chips.com" --cc-cmd "./tools/patman/patman --cc-cmd /tmp/patman.4531" 0000-cover-letter.patch 0001-rockchip-move-partitons-define-from-3036-kylin-to-30.patch 0002-rockchip-rename-board.c-to-rk3288-board.c.patch 0003-rockchip-move-common-function-from-board-file-to-rk3.patch 0004-rockchip-add-boot-mode-support-for-rk3288-rk3036.patch





su linaro -c "DISPLAY=:0.0 kodi"

sudo ifconfig wlan0 down && sudo ifconfig wlan0 up

[   40.643889] dhd_stop: Enter ee3a5000
[   40.653140] wl_event_handler: was terminated
[   40.657519] wl_destroy_event_handler(): thread:wl_event_handler:588 terminated OK
[   40.665883] CFGP2P-ERROR) wl_cfgp2p_disable_discovery :  do nothing, not initialized
[   40.673799] CFGP2P-ERROR) wl_cfgp2p_deinit_priv : In
[   40.681872] CFG80211-ERROR) wl_cfg80211_event : Event handler is not created
[   40.691082] wl_android_wifi_off in 1
[   40.694765] wl_android_wifi_off in 2: g_wifi_on=1, on_failure=1
[   40.701563] dhdsdio_isr : bus is down. we have nothing to do
[   40.707244] bcmsdh_oob_intr_unregister: Enter
[   40.711656] bcmsdh_oob_intr_unregister 225 
[   40.716581] dhd_txglom_enable: enable 0
[   40.720479] dhd_conf_set_txglom_params: swtxglom=0, txglom_ext=0
[   40.726510] dhd_conf_set_txglom_params: txglom_bucket_size=0
[   40.732200] dhd_conf_set_txglom_params: txglomsize=0, deferred_tx_len=0, bus_txglom=0
[   40.740056] dhd_conf_set_txglom_params: tx_in_rx=1, tx_max_offset=0
[   40.746340] dhd_bus_devreset:  WLAN OFF DONE
[   40.751761] wifi_platform_set_power = 0
[   40.755620] ======== PULL WL_REG_ON LOW! ========
[   40.760375] [WLAN_RFKILL]: rockchip_wifi_power: 0
[   40.765487] [WLAN_RFKILL]: wifi shut off power.
[   40.770050] wl_android_wifi_off out
[   40.908949] dhd_stop: Exit
[   41.008640] dhd_open: Enter ee3a5000
[   41.012234] 
[   41.012234] Dongle Host Driver, version 1.363.59.144.1 (r)
[   41.019213] wl_android_wifi_on in 1
[   41.022849] wl_android_wifi_on in 2: g_wifi_on=0
[   41.027460] wifi_platform_set_power = 1
[   41.031324] ======== PULL WL_REG_ON HIGH! ========
[   41.036113] [WLAN_RFKILL]: rockchip_wifi_power: 1
[   41.040827] [WLAN_RFKILL]: wifi turn on power. -1
[   41.248356] sdio_reset_comm():
[   41.268340] mmc_host mmc1: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div )
[   41.292062] mmc_host mmc1: Bus speed (slot 0) = 200000Hz (slot req 200000Hz, actual 200000HZ div )
[   41.340378] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
[   41.349560] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[   41.358758] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[   41.370354] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
[   41.486613] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 50000000Hz, actual 50000000H)
[   41.868974] dwmmc_rockchip ff0d0000.dwmmc: Successfully tuned phase to 84
[   41.875967] sdioh_start: set sd_f2_blocksize 128
[   41.882302] 
[   41.882302] 
[   41.882302] dhd_bus_devreset: == WLAN ON ==
[   41.890401] F1 signature read @0x18000000=0x16224335
[   41.904317] F1 signature OK, socitype:0x1 chip:0x4339 rev:0x1 pkg:0x2
[   41.912166] DHD: dongle ram size is set to 786432(orig 786432) at 0x180000
[   41.920289] dhd_os_open_image: /system/etc/firmware/config.txt (204 bytes) open success
[   41.929014] dhd_conf_read_config: dhd_doflow = 1
[   41.933705] dhd_conf_read_config: srl = 15
[   41.937813] dhd_conf_read_config: lrl = 15
[   41.942347] dhd_conf_set_fw_name_by_chip: firmware_path=/system/etc/firmware/fw_bcm4339a0_ag.bin
[   41.951178] dhdsdio_download_firmware: set use_rxchain 0
[   41.956508] dhdsdio_download_firmware: set txglomsize 40
[   41.961873] sdioh_set_mode: set txglom_mode to copy
[   41.966758] Final fw_path=/system/etc/firmware/fw_bcm4339a0_ag.bin
[   41.972978] Final nv_path=/system/etc/firmware/nvram_AP6335.txt
[   41.978947] Final conf_path=/system/etc/firmware/config.txt
[   41.985773] dhd_os_open_image: /system/etc/firmware/fw_bcm4339a0_ag.bin (517576 bytes) open succes
[   42.053257] dhd_os_open_image: /system/etc/firmware/nvram_AP6335.txt (2375 bytes) open success
[   42.061920] NVRAM version: AP6335_NVRAM_V1.2_01092014
[   42.067867] dhdsdio_write_vars: Download, Upload and compare of NVRAM succeeded.
[   42.253305] dhd_bus_init: enable 0x06, ready 0x06 (waited 0us)
[   42.259539] bcmsdh_oob_intr_register: Enter
[   42.263722] bcmsdh_oob_intr_register: HW_OOB enabled
[   42.268740] bcmsdh_oob_intr_register OOB irq=225 flags=4
[   42.277693] dhd_conf_set_fw_int_cmd: set WLC_SET_BAND 142 0
[   42.293474] Firmware up: op_mode=0x0005, MAC=6c:fa:a7:21:93:1b
[   42.299330] dhd_conf_set_country: set country ALL, revision 0
[   42.305067] dhd_conf_set_fw_string_struct_cmd: set country
[   42.311193] CONFIG-ERROR) dhd_conf_set_fw_string_struct_cmd: country setting failed -2
[   42.319900] Country code: US (US/0)
[   42.323588] dhd_conf_set_fw_string_cmd: set roam_off 1
[   42.330074] dhd_conf_set_fw_int_cmd: set WLC_SET_SRL 32 15
[   42.335695] dhd_conf_set_fw_int_cmd: set WLC_SET_LRL 34 15
[   42.341714] dhd_conf_set_fw_string_cmd: set txbf 1
[   42.354743] dhd_preinit_ioctls event_msgs_ext not support or version mismatch -23
[   42.366107] Firmware version = wl0: Jul 25 2013 00:04:02 version 6.37.32.5 (r414538)
[   42.373857]   Driver: 1.363.59.144.1 (r)
[   42.373857]   Firmware: wl0: Jul 25 2013 00:04:02 version 6.37.32.5 (r414538) 
[   42.385262] dhd_txglom_enable: enable 1
[   42.389110] dhd_conf_set_txglom_params: swtxglom=0, txglom_ext=0
[   42.395108] dhd_conf_set_txglom_params: txglom_bucket_size=0
[   42.400786] dhd_conf_set_txglom_params: txglomsize=40, deferred_tx_len=40, bus_txglom=0
[   42.408793] dhd_conf_set_txglom_params: tx_in_rx=1, tx_max_offset=0
[   42.415049] dhd_conf_set_disable_proptx: set disable_proptx 0
[   42.422327] dhd_wlfc_hostreorder_init(): successful bdcv2 tlv signaling, 64
[   42.429892] wl_android_wifi_on: Success
[   42.434230] wl_create_event_handler(): thread:wl_event_handler:65c started
[   42.434236] tsk Enter, tsk = 0xedce15c8
[   42.516705] dhd_open: Exit ret=0




[ 2867.653302] dhd_stop: Enter ee3a5000
[ 2867.660164] wl_event_handler: was terminated
[ 2867.664493] wl_destroy_event_handler(): thread:wl_event_handler:65c terminated OK
[ 2867.672187] CFGP2P-ERROR) wl_cfgp2p_disable_discovery :  do nothing, not initialized
[ 2867.680037] CFGP2P-ERROR) wl_cfgp2p_deinit_priv : In
[ 2867.685469] wl_android_wifi_off in 1
[ 2867.689254] wl_android_wifi_off in 2: g_wifi_on=1, on_failure=1
[ 2867.695611] dhdsdio_isr : bus is down. we have nothing to do
[ 2867.701515] bcmsdh_oob_intr_unregister: Enter
[ 2867.705895] bcmsdh_oob_intr_unregister 225 
[ 2867.710146] ------------[ cut here ]------------
[ 2867.714769] WARNING: CPU: 0 PID: 1718 at drivers/clk/clk.c:680 clk_core_disable+0x34/0x170()
[ 2867.723192] Modules linked in:
[ 2867.726260] CPU: 0 PID: 1718 Comm: ifconfig Not tainted 4.4.16 #403
[ 2867.732518] Hardware name: Rockchip (Device Tree)
[ 2867.737233] [<c010fec4>] (unwind_backtrace) from [<c010ba98>] (show_stack+0x20/0x24)
[ 2867.744976] [<c010ba98>] (show_stack) from [<c038c934>] (dump_stack+0x80/0x9c)
[ 2867.752196] [<c038c934>] (dump_stack) from [<c011d6f0>] (warn_slowpath_common+0x9c/0xc8)
[ 2867.760280] [<c011d6f0>] (warn_slowpath_common) from [<c011d7d8>] (warn_slowpath_null+0x2c/0x34)
[ 2867.769055] [<c011d7d8>] (warn_slowpath_null) from [<c073d058>] (clk_core_disable+0x34/0x170)
[ 2867.777571] [<c073d058>] (clk_core_disable) from [<c073d430>] (clk_disable+0x34/0x40)
[ 2867.785397] [<c073d430>] (clk_disable) from [<c03be21c>] (rockchip_irq_gc_mask_set_bit+0x28/0x2c)
[ 2867.794265] [<c03be21c>] (rockchip_irq_gc_mask_set_bit) from [<c01704d4>] (irq_shutdown+0x68/0x7c)
[ 2867.803218] [<c01704d4>] (irq_shutdown) from [<c016dbb8>] (__free_irq+0x124/0x270)
[ 2867.810782] [<c016dbb8>] (__free_irq) from [<c016ddc8>] (free_irq+0x6c/0x78)
[ 2867.817827] [<c016ddc8>] (free_irq) from [<c05917cc>] (bcmsdh_oob_intr_unregister+0x9c/0xbc)
[ 2867.826260] [<c05917cc>] (bcmsdh_oob_intr_unregister) from [<c05a1e58>] (dhd_bus_devreset+0x8c/0x)
[ 2867.835472] [<c05a1e58>] (dhd_bus_devreset) from [<c0575310>] (dhd_net_bus_devreset+0xd4/0x118)
[ 2867.844167] [<c0575310>] (dhd_net_bus_devreset) from [<c0587380>] (wl_android_wifi_off+0x98/0xfc)
[ 2867.853032] [<c0587380>] (wl_android_wifi_off) from [<c05794f4>] (dhd_stop+0x6c/0x1e4)
[ 2867.860945] [<c05794f4>] (dhd_stop) from [<c07bc19c>] (__dev_close_many+0xa8/0xcc)
[ 2867.868510] [<c07bc19c>] (__dev_close_many) from [<c07bc2dc>] (__dev_close+0x38/0x50)
[ 2867.876334] [<c07bc2dc>] (__dev_close) from [<c07c4134>] (__dev_change_flags+0x9c/0x140)
[ 2867.884419] [<c07c4134>] (__dev_change_flags) from [<c07c4200>] (dev_change_flags+0x28/0x58)
[ 2867.892850] [<c07c4200>] (dev_change_flags) from [<c0846f38>] (devinet_ioctl+0x304/0x684)
[ 2867.901022] [<c0846f38>] (devinet_ioctl) from [<c0848894>] (inet_ioctl+0xd0/0x100)
[ 2867.908587] [<c0848894>] (inet_ioctl) from [<c07a6518>] (sock_ioctl+0x27c/0x2c8)
[ 2867.915981] [<c07a6518>] (sock_ioctl) from [<c0234274>] (do_vfs_ioctl+0x570/0x694)
[ 2867.923547] [<c0234274>] (do_vfs_ioctl) from [<c02343f4>] (SyS_ioctl+0x5c/0x84)
[ 2867.930853] [<c02343f4>] (SyS_ioctl) from [<c01072c0>] (ret_fast_syscall+0x0/0x3c)
[ 2867.938412] ---[ end trace ad8799bd7858e75e ]---
[ 2867.943749] dhd_txglom_enable: enable 0
[ 2867.947611] dhd_conf_set_txglom_params: swtxglom=0, txglom_ext=0
[ 2867.953672] dhd_conf_set_txglom_params: txglom_bucket_size=0
[ 2867.959379] dhd_conf_set_txglom_params: txglomsize=0, deferred_tx_len=0, bus_txglom=0
[ 2867.967224] dhd_conf_set_txglom_params: tx_in_rx=1, tx_max_offset=0
[ 2867.973528] dhd_bus_devreset:  WLAN OFF DONE
[ 2867.977910] wifi_platform_set_power = 0
[ 2867.981805] ======== PULL WL_REG_ON LOW! ========
[ 2867.986520] [WLAN_RFKILL]: rockchip_wifi_power: 0
[ 2867.991260] [WLAN_RFKILL]: wifi shut off power.
[ 2867.995795] wl_android_wifi_off out
[ 2868.128118] dhd_stop: Exit
[ 2868.206888] dhd_open: Enter ee3a5000
[ 2868.210674] 
[ 2868.210674] Dongle Host Driver, version 1.363.59.144.1 (r)
[ 2868.217644] wl_android_wifi_on in 1
[ 2868.221237] wl_android_wifi_on in 2: g_wifi_on=0
[ 2868.225869] wifi_platform_set_power = 1
[ 2868.229777] ======== PULL WL_REG_ON HIGH! ========
[ 2868.234577] [WLAN_RFKILL]: rockchip_wifi_power: 1
[ 2868.239350] [WLAN_RFKILL]: wifi turn on power. -1
[ 2868.448828] sdio_reset_comm():
[ 2868.468227] mmc_host mmc1: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div )
[ 2868.491630] mmc_host mmc1: Bus speed (slot 0) = 200000Hz (slot req 200000Hz, actual 200000HZ div )
[ 2868.538945] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
[ 2868.547607] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[ 2868.556178] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[ 2868.567148] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
[ 2868.681608] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 50000000Hz, actual 50000000H)
[ 2869.099175] dwmmc_rockchip ff0d0000.dwmmc: Successfully tuned phase to 86
[ 2869.106250] sdioh_start: set sd_f2_blocksize 128
[ 2869.115958] 
[ 2869.115958] 
[ 2869.115958] dhd_bus_devreset: == WLAN ON ==
[ 2869.123775] F1 signature read @0x18000000=0x16224335
[ 2869.144080] F1 signature OK, socitype:0x1 chip:0x4339 rev:0x1 pkg:0x2
[ 2869.151159] DHD: dongle ram size is set to 786432(orig 786432) at 0x180000
[ 2869.158430] dhd_os_open_image: /system/etc/firmware/config.txt (204 bytes) open success
[ 2869.166625] dhd_conf_read_config: dhd_doflow = 1
[ 2869.171308] dhd_conf_read_config: srl = 15
[ 2869.175405] dhd_conf_read_config: lrl = 15
[ 2869.179705] dhd_conf_set_fw_name_by_chip: firmware_path=/system/etc/firmware/fw_bcm4339a0_ag.bin
[ 2869.188509] dhdsdio_download_firmware: set use_rxchain 0
[ 2869.193815] dhdsdio_download_firmware: set txglomsize 40
[ 2869.199139] sdioh_set_mode: set txglom_mode to copy
[ 2869.204018] Final fw_path=/system/etc/firmware/fw_bcm4339a0_ag.bin
[ 2869.210209] Final nv_path=/system/etc/firmware/nvram_AP6335.txt
[ 2869.216141] Final conf_path=/system/etc/firmware/config.txt
[ 2869.223174] dhd_os_open_image: /system/etc/firmware/fw_bcm4339a0_ag.bin (517576 bytes) open succes
[ 2869.297520] dhd_os_open_image: /system/etc/firmware/nvram_AP6335.txt (2375 bytes) open success
[ 2869.306160] NVRAM version: AP6335_NVRAM_V1.2_01092014
[ 2869.312134] dhdsdio_write_vars: Download, Upload and compare of NVRAM succeeded.
[ 2869.497405] dhd_bus_init: enable 0x06, ready 0x06 (waited 0us)
[ 2869.503517] bcmsdh_oob_intr_register: Enter
[ 2869.507696] bcmsdh_oob_intr_register: HW_OOB enabled
[ 2869.512693] bcmsdh_oob_intr_register OOB irq=225 flags=4
[ 2869.520919] dhd_conf_set_fw_int_cmd: set WLC_SET_BAND 142 0
[ 2869.537582] Firmware up: op_mode=0x0005, MAC=6c:fa:a7:21:93:1b
[ 2869.543433] dhd_conf_set_country: set country ALL, revision 0
[ 2869.549188] dhd_conf_set_fw_string_struct_cmd: set country
[ 2869.554996] CONFIG-ERROR) dhd_conf_set_fw_string_struct_cmd: country setting failed -2
[ 2869.563611] Country code: US (US/0)
[ 2869.567290] dhd_conf_set_fw_string_cmd: set roam_off 1
[ 2869.573744] dhd_conf_set_fw_int_cmd: set WLC_SET_SRL 32 15
[ 2869.579379] dhd_conf_set_fw_int_cmd: set WLC_SET_LRL 34 15
[ 2869.585314] dhd_conf_set_fw_string_cmd: set txbf 1
[ 2869.598353] dhd_preinit_ioctls event_msgs_ext not support or version mismatch -23
[ 2869.609752] Firmware version = wl0: Jul 25 2013 00:04:02 version 6.37.32.5 (r414538)
[ 2869.617484]   Driver: 1.363.59.144.1 (r)
[ 2869.617484]   Firmware: wl0: Jul 25 2013 00:04:02 version 6.37.32.5 (r414538) 
[ 2869.629413] dhd_txglom_enable: enable 1
[ 2869.633245] dhd_conf_set_txglom_params: swtxglom=0, txglom_ext=0
[ 2869.639261] dhd_conf_set_txglom_params: txglom_bucket_size=0
[ 2869.644909] dhd_conf_set_txglom_params: txglomsize=40, deferred_tx_len=40, bus_txglom=0
[ 2869.652913] dhd_conf_set_txglom_params: tx_in_rx=1, tx_max_offset=0
[ 2869.659180] dhd_conf_set_disable_proptx: set disable_proptx 0
[ 2869.665563] dhd_wlfc_hostreorder_init(): successful bdcv2 tlv signaling, 64
[ 2869.672869] wl_android_wifi_on: Success
[ 2869.677192] wl_create_event_handler(): thread:wl_event_handler:6c2 started
[ 2869.677197] tsk Enter, tsk = 0xedce15c8
[ 2869.761386] dhd_open: Exit ret=0


	qos_cpup: qos@ffa80000 {
		compatible = "syscon";
		reg = <0x0 0xffa80000 0x0 0x20>;
	};

	qos_cpum_r: qos@ffa80080 {
		compatible = "syscon";
		reg = <0x0 0xffa80080 0x0 0x20>;
	};

	qos_cpum_w: qos@ffa80100 {
		compatible = "syscon";
		reg = <0x0 0xffa80100 0x0 0x20>;
	};

	qos_bus_dmac: qos@ffa90000 {
		compatible = "syscon";
		reg = <0x0 0xffa90000 0x0 0x20>;
	};

	qos_host: qos@ffa90080 {
		compatible = "syscon";
		reg = <0x0 0xffa90080 0x0 0x20>;
	};

	qos_crypto: qos@ffa90100 {
		compatible = "syscon";
		reg = <0x0 0xffa90100 0x0 0x20>;
	};

	qos_ccp: qos@ffa90180 {
		compatible = "syscon";
		reg = <0x0 0xffa90180 0x0 0x20>;
	};

	qos_ccs: qos@ffa90200 {
		compatible = "syscon";
		reg = <0x0 0xffa90200 0x0 0x20>;
	};

	qos_gpu_r: qos@ffaa0000 {
		compatible = "syscon";
		reg = <0x0 0xffaa0000 0x0 0x20>;
	};

	qos_gpu_w: qos@ffaa0080 {
		compatible = "syscon";
		reg = <0x0 0xffaa0080 0x0 0x20>;
	};

	qos_peri: qos@ffab0000 {
		compatible = "syscon";
		reg = <0x0 0xffab0000 0x0 0x20>;
	};

	qos_vio1_vop: qos@ffad0000 {
		compatible = "syscon";
		reg = <0x0 0xffad0000 0x0 0x20>;
	};

	qos_vio1_isp_w0: qos@ffad0100 {
		compatible = "syscon";
		reg = <0x0 0xffad0100 0x0 0x20>;
	};

	qos_vio1_isp_w1: qos@ffad0180 {
		compatible = "syscon";
		reg = <0x0 0xffad0180 0x0 0x20>;
	};

	qos_vio0_vop: qos@ffad0400 {
		compatible = "syscon";
		reg = <0x0 0xffad0400 0x0 0x20>;
	};

	qos_vio0_vip: qos@ffad0480 {
		compatible = "syscon";
		reg = <0x0 0xffad0480 0x0 0x20>;
	};

	qos_vio0_iep: qos@ffad0500 {
		compatible = "syscon";
		reg = <0x0 0xffad0500 0x0 0x20>;
	};

	qos_vio2_rga_r: qos@ffad0800 {
		compatible = "syscon";
		reg = <0x0 0xffad0800 0x0 0x20>;
	};

	qos_vio2_rga_w: qos@ffad0880 {
		compatible = "syscon";
		reg = <0x0 0xffad0880 0x0 0x20>;
	};

	qos_vio1_isp_r: qos@ffad0900 {
		compatible = "syscon";
		reg = <0x0 0xffad0900 0x0 0x20>;
	};

	qos_video: qos@ffae0000 {
		compatible = "syscon";
		reg = <0x0 0xffae0000 0x0 0x20>;
	};

	qos_hevc_r: qos@ffaf0000 {
		compatible = "syscon";
		reg = <0x0 0xffaf0000 0x0 0x20>;
	};

	qos_hevc_w: qos@ffaf0080 {
		compatible = "syscon";
		reg = <0x0 0xffaf0080 0x0 0x20>;
	};