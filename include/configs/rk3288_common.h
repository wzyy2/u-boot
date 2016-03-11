/*
 * (C) Copyright 2015 Google, Inc
 *
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __CONFIG_RK3288_COMMON_H
#define __CONFIG_RK3288_COMMON_H

#include <asm/arch/hardware.h>

#define CONFIG_SYS_NO_FLASH
#define CONFIG_NR_DRAM_BANKS		1
#define CONFIG_ENV_SIZE			0x2000
#define CONFIG_SYS_MAXARGS		16
#define CONFIG_BAUDRATE			115200
#define CONFIG_SYS_MALLOC_LEN		(32 << 20)
#define CONFIG_SYS_CBSIZE		1024
#define CONFIG_SYS_THUMB_BUILD
#define CONFIG_OF_LIBFDT
#define CONFIG_DISPLAY_BOARDINFO

#define CONFIG_SYS_TIMER_RATE		(24 * 1000 * 1000)
#define	CONFIG_SYS_TIMER_BASE		0xff810020 /* TIMER7 */
#define CONFIG_SYS_TIMER_COUNTER	(CONFIG_SYS_TIMER_BASE + 8)

#define CONFIG_SPL_FRAMEWORK
#define CONFIG_SPL_LIBCOMMON_SUPPORT
#define CONFIG_SPL_LIBGENERIC_SUPPORT
#define CONFIG_SPL_SERIAL_SUPPORT
#define CONFIG_SYS_NS16550_MEM32
#define CONFIG_SPL_BOARD_INIT

 #define CONFIG_SILENT_CONSOLE
#ifndef CONFIG_SPL_BUILD
# define CONFIG_SYS_CONSOLE_IS_IN_ENV
# define CONFIG_CONSOLE_MUX
#endif

/*
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
*/
/* internal sram 0xff70_0000 ~ 0xff71_7fff */
/* spl stack */
#define CONFIG_SPL_STACK		    0xff718000
/* maybe internal bootrom uses ~0xff703fff for data&stack */
#define CONFIG_SPL_TEXT_BASE		0xff704004

/* DRAM: 0x0000_0000 ~ 0x7fff_ffff */
#define CONFIG_SYS_SDRAM_BASE       0
#define CONFIG_NR_DRAM_BANKS        1
#define SDRAM_BANK_SIZE             (2UL << 30)

/* uboot start address @0MB */
#define CONFIG_SYS_TEXT_BASE		0x00000000
/* uboot stack pointer */
#define CONFIG_SYS_INIT_SP_ADDR		0x00100000
/* 8MB offset */
#define CONFIG_SYS_LOAD_ADDR        0x00800800


/*
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
*/
#define CONFIG_ROCKCHIP_COMMON
#define CONFIG_SPL_ROCKCHIP_COMMON

/* MMC/SD IP block */
#define CONFIG_MMC
#define CONFIG_GENERIC_MMC
#define CONFIG_CMD_MMC
#define CONFIG_SDHCI
#define CONFIG_DWMMC
#define CONFIG_BOUNCE_BUFFER

#define CONFIG_DOS_PARTITION
#define CONFIG_CMD_FAT
#define CONFIG_FAT_WRITE
#define CONFIG_CMD_EXT2
#define CONFIG_CMD_EXT4
#define CONFIG_CMD_FS_GENERIC
#define CONFIG_PARTITION_UUIDS
#define CONFIG_CMD_PART

/* RAW SD card / eMMC locations. */
#define CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR	256
#define CONFIG_SYS_SPI_U_BOOT_OFFS	(128 << 10)

/* FAT sd card locations. */
#define CONFIG_SYS_MMCSD_FS_BOOT_PARTITION	1
#define CONFIG_SPL_FS_LOAD_PAYLOAD_NAME		"u-boot.img"

#define CONFIG_SPL_PINCTRL_SUPPORT
#define CONFIG_SPL_GPIO_SUPPORT
#define CONFIG_SPL_RAM_SUPPORT
#define CONFIG_SPL_DRIVERS_MISC_SUPPORT

#define CONFIG_CMD_CACHE
#define CONFIG_CMD_TIME

#define CONFIG_SPI_FLASH
#define CONFIG_SPI
#define CONFIG_CMD_SF
#define CONFIG_CMD_SPI
#define CONFIG_SF_DEFAULT_SPEED 20000000

#define CONFIG_CMD_I2C

#define CONFIG_EFI_PARTITION

/* FASTBOOT */
#define CONFIG_CMD_FASTBOOT
#define CONFIG_USB_GADGET
#define CONFIG_USB_GADGET_DOWNLOAD
#define CONFIG_USB_GADGET_DUALSPEED
#define CONFIG_USB_GADGET_DWC2_OTG
#define CONFIG_USB_GADGET_RK_OTG_PHY
#define CONFIG_USB_FUNCTION_FASTBOOT
#define CONFIG_USB_FUNCTION_MASS_STORAGE
#define CONFIG_FASTBOOT_FLASH
#define CONFIG_FASTBOOT_FLASH_MMC_DEV		0
#define CONFIG_FASTBOOT_BUF_ADDR	(CONFIG_SYS_SDRAM_BASE \
					+ SDRAM_BANK_SIZE)
#define CONFIG_FASTBOOT_BUF_SIZE		0x07000000
#define CONFIG_USB_GADGET_VBUS_DRAW		0
#define CONFIG_SYS_CACHELINE_SIZE		64
#define CONFIG_G_DNL_MANUFACTURER		"Rockchip"
#define CONFIG_G_DNL_VENDOR_NUM		0x2207
#define CONFIG_G_DNL_PRODUCT_NUM		0x0006


#ifndef CONFIG_SPL_BUILD
    #include <config_distro_defaults.h>
    
    #define CONFIG_PARTITION_UUIDS
    #define CONFIG_CMD_PART
    #define CONFIG_BOOTCOMMAND          "run autoboot"
        
    
    /*The kernel should be placed in the first 128MiB of RAM */
    #define CONFIG_EXTRA_ENV_SETTINGS \
        ROCKCHIP_DEVICE_SETTINGS \
        "fdt_high=0x07ffffff\0" \
        "initrd_high=0x07ffffff\0" \
        "kernel_addr=0x02000000\0" \
        "dtb_addr=0x06000000\0" \
        "initrd_addr=0x06800000\0" \
        "fn_kernel=uImage\0" \
        "fn_dtb=dtb.bin\0" \
        "fn_initrd=initrd.img\0" \
        "fn_kernel_a=uImage_a\0" \
        "fn_kernel_b=uImage_b\0" \
        "fn_dtb_a=dtb_a.bin\0" \
        "fn_dtb_b=dtb_b.bin\0" \
        "bootpart=a\0" \
        "sdmmc=1\0" \
        "emmc=0\0" \
        "emmc_partition=0:2\0" \
        "sdmmc_partition=1:1\0" \
        "loglevel=7\0" \
        "panicargs=panic=10\0" \
        "extraargs=consoleblank=0\0" \
        "console=ttyS2,115200\0" \
        "setargs_emmc_a=" \
            "root=\"/dev/mmcblk0p5 rootwait rw rootfstype=ext4\";" \
            "setenv bootargs console=${console} root=${root}" \
            "   loglevel=${loglevel} ${panicarg} ${extraargs};" \
            "setenv fn_kernel ${fn_kernel_a};" \
            "setenv fn_dtb ${fn_dtb_a};" \
            "setenv boot_param ${kernel_addr} - ${dtb_addr}" \
            "\0" \
        "setargs_emmc_b=" \
            "root=\"/dev/mmcblk0p6 rootwait rw rootfstype=ext4\";" \
            "setenv bootargs console=${console} root=${root}" \
            "   loglevel=${loglevel} ${panicarg} ${extraargs};" \
            "setenv fn_kernel ${fn_kernel_b};" \
            "setenv fn_dtb ${fn_dtb_b};" \
            "setenv boot_param ${kernel_addr} - ${dtb_addr}" \
            "\0" \
        "setargs_sdmmc=" \
            "root=\"/dev/ram0 rw rootfstype=ext4\";" \
            "setenv bootargs console=${console} root=${root}" \
            "   loglevel=${loglevel} ${panicarg} ${extraargs};" \
            "setenv boot_param ${kernel_addr} ${initrd_addr} ${dtb_addr}" \
            "\0" \
        "load=" \
            "if "\
                "mmc dev ${sdmmc} " \
                " && " \
                "fatload mmc ${sdmmc_partition} ${dtb_addr} update/${fn_dtb}" \
                " && " \
                "fatload mmc ${sdmmc_partition} ${kernel_addr} update/${fn_kernel}" \
                " && " \
                "fatload mmc ${sdmmc_partition} ${initrd_addr} update/${fn_initrd}" \
                " && " \
                "run setargs_sdmmc" \
             ";then true; elif " \
                "mmc dev ${emmc} " \
                " && " \
                "run setargs_emmc_${bootpart}" \
                " && " \
                "ext4load mmc ${emmc_partition} ${dtb_addr} ${fn_dtb}" \
                " && " \
                "ext4load mmc ${emmc_partition} ${kernel_addr} ${fn_kernel}" \
             ";then true; else " \
                "reset" \
             ";fi" \
             "\0" \
        "autoboot=run load && bootm ${boot_param}\0" \
        "bootdelay=-1\0" \
        "bootcmd=" \
            "run autoboot" \
            "\0"  /*end of line*/
    
    #if !defined CONFIG_ENV_IS_IN_MMC && \
        !defined CONFIG_ENV_IS_IN_NAND && \
        !defined CONFIG_ENV_IS_IN_FAT && \
        !defined CONFIG_ENV_IS_IN_SPI_FLASH
        
        #define CONFIG_ENV_IS_NOWHERE
    #else
        #error "some ENVs defined"
    #endif

#endif

#endif

