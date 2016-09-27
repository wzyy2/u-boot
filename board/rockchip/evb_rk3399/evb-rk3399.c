/*
 * (C) Copyright 2016 Rockchip Electronics Co., Ltd
 *
 * SPDX-License-Identifier:     GPL-2.0+
 */
#include <common.h>
#include <dm.h>
#include <dm/pinctrl.h>
#include <dm/uclass-internal.h>
#include <asm/arch/periph.h>
#include <power/regulator.h>
#include <asm/armv8/mmu.h>
#include <usb.h>
#include <dwc3-uboot.h>

DECLARE_GLOBAL_DATA_PTR;

int board_init(void)
{
	struct udevice *pinctrl, *regulator;
	int ret;

	/*
	 * The PWM do not have decicated interrupt number in dts and can
	 * not get periph_id by pinctrl framework, so let's init them here.
	 * The PWM2 and PWM3 are for pwm regulater.
	 */
	ret = uclass_get_device(UCLASS_PINCTRL, 0, &pinctrl);
	if (ret) {
		debug("%s: Cannot find pinctrl device\n", __func__);
		goto out;
	}

	ret = pinctrl_request_noflags(pinctrl, PERIPH_ID_PWM2);
	if (ret) {
		debug("%s PWM2 pinctrl init fail!\n", __func__);
		goto out;
	}

	ret = pinctrl_request_noflags(pinctrl, PERIPH_ID_PWM3);
	if (ret) {
		debug("%s PWM3 pinctrl init fail!\n", __func__);
		goto out;
	}

	/* rk3399 need init vdd_center to get correct output voltage */
	ret = regulator_get_by_platname("vdd_center", &regulator);
	if (ret)
		debug("%s: Cannot get vdd_center regulator\n", __func__);

	ret = regulator_get_by_platname("vcc5v0_host", &regulator);
	if (ret) {
		debug("%s vcc5v0_host init fail! ret %d\n", __func__, ret);
		goto out;
	}

	ret = regulator_set_enable(regulator, true);
	if (ret) {
		debug("%s vcc5v0-host-en set fail!\n", __func__);
		goto out;
	}

out:
	return 0;
}

int dram_init(void)
{
	gd->ram_size = 0x80000000;
	return 0;
}

void dram_init_banksize(void)
{
	/* Reserve 0x200000 for ATF bl31 */
	gd->bd->bi_dram[0].start = 0x200000;
	gd->bd->bi_dram[0].size = 0x80000000;
}

#ifdef CONFIG_USB_DWC3
static struct dwc3_device dwc3_device_data = {
	.index = 0,
};

int usb_gadget_handle_interrupts(void)
{
	dwc3_uboot_handle_interrupt(0);
	return 0;
}

int board_usb_init(int index, enum usb_init_type init)
{
	const void *blob = gd->fdt_blob;
	int node;
	const char *string;

	node = fdt_node_offset_by_compatible(blob, -1,
			"rockchip,rk3399-xhci");
	if (node < 0) {
		debug("%s dwc3 node not found\n", __func__);
	} else {
		dwc3_device_data.base = fdtdec_get_addr(blob, node, "reg");
		dwc3_device_data.dis_u2_susphy_quirk =
			fdtdec_get_int(blob, node,
				       "snps,dis-u2-susphy-quirk", -1);

		string = fdt_getprop(blob, node, "maximum-speed", NULL);
		if (string) {
			if (0 == strcmp(string, "super-speed"))
				dwc3_device_data.maximum_speed = USB_SPEED_SUPER;
			else if (0 == strcmp(string, "high-speed"))
				dwc3_device_data.maximum_speed = USB_SPEED_HIGH;
			else if (0 == strcmp(string, "full-speed"))
				dwc3_device_data.maximum_speed = USB_SPEED_FULL;
			else
				debug("%s: Cannot decode speed'%s'\n", __func__,
				      string);
		} else {
			dwc3_device_data.maximum_speed = USB_SPEED_HIGH;
		}
		/* Hardcode controller in peripheral mode */
		dwc3_device_data.dr_mode = USB_DR_MODE_PERIPHERAL;
	}

	return dwc3_uboot_init(&dwc3_device_data);
}
#endif
