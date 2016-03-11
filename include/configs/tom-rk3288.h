/*
 * (C) Copyright 2015 Rockchip Electronics Co., Ltd
 *
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __CONFIG_H
#define __CONFIG_H

#define ROCKCHIP_DEVICE_SETTINGS \
        "stdin=serial,cros-ec-keyb\0" \
        "stdout=serial\0" \
        "stderr=serial\0" \
        "splashimage=0x03000000\0"  \
        "splashpos=m,m\0" \
        "splashfile=update/logo.bmp\0"\
        "splashpart=1:1\0"


#include <configs/rk3288_common.h>

#define CONFIG_SPLASH_SCREEN
#define CONFIG_SPLASH_SCREEN_ALIGN
#define CONFIG_SPLASH_SOURCE
#define CONFIG_VIDEO_BMP_GZIP
#define CONFIG_CMD_BMP
#define CONFIG_SYS_VIDEO_LOGO_MAX_SIZE (1024 * 1024 * 8)
#define CONFIG_BOARD_LATE_INIT


#define CONFIG_SPL_MMC_SUPPORT

#ifndef CONFIG_ENV_IS_NOWHERE
    #define CONFIG_ENV_IS_IN_MMC
    #define CONFIG_SYS_MMC_ENV_DEV 0
    /* SPL @ 32k for ~36k
     * ENV @ 96k
     * u-boot @ 128K
     */
    #define CONFIG_ENV_OFFSET (96 * 1024)
#endif


#define CONFIG_CONSOLE_SCROLL_LINES		10

#endif
