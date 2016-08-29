/*
 * (C) Copyright 2015 Rockchip Electronics Co., Ltd
 *
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __CONFIG_H
#define __CONFIG_H

#include <linux/sizes.h>
#include <configs/rk3036_common.h>

#ifndef CONFIG_SPL_BUILD

/* Store env in emmc */
#undef CONFIG_ENV_SIZE
#define CONFIG_ENV_SIZE			SZ_32K
#undef CONFIG_ENV_IS_NOWHERE
#define CONFIG_ENV_IS_IN_MMC
#define CONFIG_SYS_MMC_ENV_DEV		0 /* emmc */
#define CONFIG_ENV_OFFSET		(SZ_4M - SZ_64K) /* reserved area */
#define CONFIG_ENV_OFFSET_REDUND	(CONFIG_ENV_OFFSET + CONFIG_ENV_SIZE)
#define CONFIG_SYS_REDUNDAND_ENVIRONMENT

/* Enable gpt partition table */
#define CONFIG_CMD_GPT
#define CONFIG_RANDOM_UUID
#define PARTS_DEFAULT \
	"uuid_disk=${uuid_gpt_disk};" \
	"name=loader1,start=32K,size=4000K,uuid=${uuid_gpt_loader1};" \
	"name=reserved1,size=64K,uuid=${uuid_gpt_reserved1};" \
	"name=reserved2,size=4M,uuid=${uuid_gpt_reserved2};" \
	"name=loader2,size=4MB,uuid=${uuid_gpt_loader2};" \
	"name=atf,size=4M,uuid=${uuid_gpt_atf};" \
	"name=boot,size=128M,bootable,uuid=${uuid_gpt_boot};" \
	"name=rootfs,size=-,uuid=${uuid_gpt_rootfs};\0" \

#undef CONFIG_EXTRA_ENV_SETTINGS
#define CONFIG_EXTRA_ENV_SETTINGS \
	"partitions=" PARTS_DEFAULT \
	ENV_MEM_LAYOUT_SETTINGS \
	BOOTENV
#endif

#define CONFIG_BOARD_LATE_INIT
#define CONFIG_PREBOOT

#endif
