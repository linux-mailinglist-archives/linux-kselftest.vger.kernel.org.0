Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A299455E9D
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Nov 2021 15:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhKROzA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Nov 2021 09:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhKROy7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Nov 2021 09:54:59 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6FDC061574
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Nov 2021 06:51:59 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d24so12140717wra.0
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Nov 2021 06:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qoORRoj+cZ0fK9Y6Dg4KUsgRH95MYb78TPlRcFhZ3LU=;
        b=4biBP3uf7C/VN+eIiPvdWnao2QzlfJNz0uWB1c7iyFwM7Kl5hkZ3YYU8QbB2Xwsl2a
         dDLA6KczqjxSrd5tGiX/SVEXlkVrJRfcwjZ48Z4LVKkw45vaRZI5ttC9UPK1fgLGdIjD
         b94ZZugvtCwoSRAysm8ZbMjqXFCBNQX0tKTfipos0Du0yJ/vg62pcwCVwY04GvHqhVRk
         MQP4XS5DVthvYz0prAeMzgKemlr/Pj9+To5iAqPZVI9i5TLODuIbyJLSMNMag0oLtjWw
         L5fySc7iB7ITvMPzDehGmSwV4jQ+6u9vp1hQov+0lY7Z+vE41ZKX1zb4bPhCwcdp+4Fj
         luYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qoORRoj+cZ0fK9Y6Dg4KUsgRH95MYb78TPlRcFhZ3LU=;
        b=EVL8w5W1WEyYCIlwF+0C9/dW1oWSSNg7UMfClbunTi8hWceJ30YYVi3WRA4eke65Bb
         uSarsXMlNmPwI1Di6uMyEY0XlEfdA6di4l5B+9mRipk95PtqM5kE+rhvVjXJis4TN+wA
         SwZcQY/qbAlb+VnzIC1XAR63Fm3brovA6p+INAWjTxmcUfHgEjZRfBG5d8v3ccDtO681
         fN6Meb/QQpmZdaBrh3z70XenylN6RFVnTtmd9qZvtizIBXaKh/+WQNcjQwBs37QN91/d
         e3aK6IJT3V/TS8nxl9+oy3weoGgTxuKqax2jvfu4I/gjeUNztmi6l/d1fsmxRWANAzBM
         FsHg==
X-Gm-Message-State: AOAM531dfqPg9gHxcdGLN4fEyxe7TsFlpdTtTSKNFYttvTRNIptlnJGN
        uHPWhd72W571hBnmbVNxv3UPuVFlgnu4ifdt
X-Google-Smtp-Source: ABdhPJzPGTSsRzqmgHoba69pPp7LlHchd0Jw+AiWfybU3gLoN6ozZhePUb10AOYkCpm6jEXfLbDNjA==
X-Received: by 2002:adf:dc52:: with SMTP id m18mr33624600wrj.216.1637247117487;
        Thu, 18 Nov 2021 06:51:57 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:334:ac00:7d50:ff5:f5c1:e225])
        by smtp.gmail.com with ESMTPSA id f7sm63154wri.74.2021.11.18.06.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 06:51:57 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v9 1/4] gpio: sim: new testing module
Date:   Thu, 18 Nov 2021 15:51:39 +0100
Message-Id: <20211118145142.14519-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20211118145142.14519-1-brgl@bgdev.pl>
References: <20211118145142.14519-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Implement a new, modern GPIO testing module controlled by configfs
attributes instead of module parameters. The goal of this driver is
to provide a replacement for gpio-mockup that will be easily extensible
with new features and doesn't require reloading the module to change
the setup.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 Documentation/admin-guide/gpio/gpio-sim.rst |  67 ++
 drivers/gpio/Kconfig                        |   8 +
 drivers/gpio/Makefile                       |   1 +
 drivers/gpio/gpio-sim.c                     | 990 ++++++++++++++++++++
 4 files changed, 1066 insertions(+)
 create mode 100644 Documentation/admin-guide/gpio/gpio-sim.rst
 create mode 100644 drivers/gpio/gpio-sim.c

diff --git a/Documentation/admin-guide/gpio/gpio-sim.rst b/Documentation/admin-guide/gpio/gpio-sim.rst
new file mode 100644
index 000000000000..7f2080f520d6
--- /dev/null
+++ b/Documentation/admin-guide/gpio/gpio-sim.rst
@@ -0,0 +1,67 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Configfs GPIO Simulator
+=======================
+
+The configfs GPIO Simulator (gpio-sim) provides a way to create simulated GPIO
+chips for testing purposes. The lines exposed by these chips can be accessed
+using the standard GPIO character device interface as well as manipulated
+using sysfs attributes.
+
+Creating simulated chips
+------------------------
+
+The gpio-sim module registers a configfs subsystem called 'gpio-sim'.
+
+In order to instantiate a new simulated chip, the user needs to mkdir() a new
+directory gpio-sim/. Inside each new directory, there's a set of attributes
+that can be used to configure the new chip. Additionally the user can mkdir()
+subdirectories inside the chip's directory that allow to pass additional
+configuration for specific lines. The name of those subdirectories must take
+the form of: 'line<offset>' (e.g. 'line0', 'line20', etc.) as the name will be
+used by the module to assign the config to the specific line at given offset.
+
+Once the confiuration is complete, the 'active' attribute must be set to 1 in
+order to instantiate the chip. It can be set back to 0 to destroy the simulated
+chip.
+
+Currently supported chip configuration attributes are:
+
+  num_lines - an unsigned integer value defining the number of GPIO lines to
+              export
+
+  label - a string defining the label for the GPIO chip
+
+Additionally two read-only attributes named 'chip_name' and 'dev_name' are
+exposed in order to provide users with a mapping from configfs directories to
+the actual devices created in the kernel. The former returns the name of the
+GPIO device as assigned by gpiolib (i.e. "gpiochip0", "gpiochip1", etc.). The
+latter returns the parent device name as defined by the gpio-sim driver (i.e.
+"gpio-sim.0", "gpio-sim.1", etc.). This allows user-space to map the configfs
+items both to the correct character device file as well as the associated entry
+in sysfs.
+
+Supported line configuration attributes are:
+
+  name - a string defining the name of this line as used by the
+         "gpio-line-names" device property
+
+Simulated GPIO chips can also be defined in device-tree. The compatible string
+must be: "gpio-simulator". Supported properties are:
+
+  "gpio-sim,label" - chip label
+
+Other standard GPIO properties (like "gpio-line-names", "ngpios" or gpio-hog)
+are also supported.
+
+Manipulating simulated lines
+----------------------------
+
+Each simulated GPIO chip creates a sysfs attribute group under its device
+directory called 'line-ctrl'. Inside each group, there's a separate attribute
+for each GPIO line. The name of the attribute is of the form 'gpioX' where X
+is the line's offset in the chip.
+
+Reading from a line attribute returns the current value. Writing to it (0 or 1)
+changes the configuration of the simulated pull-up/pull-down resistor
+(1 - pull-up, 0 - pull-down).
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 072ed610f9c6..5c3b29bddc5b 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1693,6 +1693,14 @@ config GPIO_VIRTIO
 	  These virtual GPIOs can be routed to real GPIOs or attached to
 	  simulators on the host (like QEMU).
 
+config GPIO_SIM
+	tristate "GPIO Simulator Module"
+	select IRQ_SIM
+	select CONFIGFS_FS
+	help
+	  This enables the GPIO simulator - a configfs-based GPIO testing
+	  driver.
+
 endmenu
 
 endif
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 71ee9fc2ff83..f21577de2474 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -133,6 +133,7 @@ obj-$(CONFIG_GPIO_SAMA5D2_PIOBU)	+= gpio-sama5d2-piobu.o
 obj-$(CONFIG_GPIO_SCH311X)		+= gpio-sch311x.o
 obj-$(CONFIG_GPIO_SCH)			+= gpio-sch.o
 obj-$(CONFIG_GPIO_SIFIVE)		+= gpio-sifive.o
+obj-$(CONFIG_GPIO_SIM)			+= gpio-sim.o
 obj-$(CONFIG_GPIO_SIOX)			+= gpio-siox.o
 obj-$(CONFIG_GPIO_SL28CPLD)		+= gpio-sl28cpld.o
 obj-$(CONFIG_GPIO_SODAVILLE)		+= gpio-sodaville.o
diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
new file mode 100644
index 000000000000..2a1c548548a0
--- /dev/null
+++ b/drivers/gpio/gpio-sim.c
@@ -0,0 +1,990 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * GPIO testing driver based on configfs.
+ *
+ * Copyright (C) 2021 Bartosz Golaszewski <brgl@bgdev.pl>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/bitmap.h>
+#include <linux/configfs.h>
+#include <linux/device.h>
+#include <linux/gpio/driver.h>
+#include <linux/idr.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irq_sim.h>
+#include <linux/list.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/string_helpers.h>
+#include <linux/sysfs.h>
+
+#include "gpiolib.h"
+
+static DEFINE_IDA(gpio_sim_ida);
+
+struct gpio_sim_chip {
+	struct gpio_chip gc;
+	unsigned long *directions;
+	unsigned long *values;
+	unsigned long *pulls;
+	struct irq_domain *irq_sim;
+	struct mutex lock;
+	struct attribute_group attr_group;
+};
+
+struct gpio_sim_attribute {
+	struct device_attribute dev_attr;
+	unsigned int offset;
+};
+
+static struct gpio_sim_attribute *
+to_gpio_sim_attr(struct device_attribute *dev_attr)
+{
+	return container_of(dev_attr, struct gpio_sim_attribute, dev_attr);
+}
+
+static int gpio_sim_apply_pull(struct gpio_sim_chip *chip,
+			       unsigned int offset, int value)
+{
+	int curr_val, irq, irq_type, ret;
+	struct gpio_desc *desc;
+	struct gpio_chip *gc;
+
+	gc = &chip->gc;
+	desc = &gc->gpiodev->descs[offset];
+
+	mutex_lock(&chip->lock);
+
+	if (test_bit(FLAG_REQUESTED, &desc->flags) &&
+	    !test_bit(FLAG_IS_OUT, &desc->flags)) {
+		curr_val = !!test_bit(offset, chip->values);
+		if (curr_val == value)
+			goto set_pull;
+
+		/*
+		 * This is fine - it just means, nobody is listening
+		 * for interrupts on this line, otherwise
+		 * irq_create_mapping() would have been called from
+		 * the to_irq() callback.
+		 */
+		irq = irq_find_mapping(chip->irq_sim, offset);
+		if (!irq)
+			goto set_value;
+
+		irq_type = irq_get_trigger_type(irq);
+
+		if ((value && (irq_type & IRQ_TYPE_EDGE_RISING)) ||
+		    (!value && (irq_type & IRQ_TYPE_EDGE_FALLING))) {
+			ret = irq_set_irqchip_state(irq, IRQCHIP_STATE_PENDING,
+						    true);
+			if (ret)
+				goto set_pull;
+		}
+	}
+
+set_value:
+	/* Change the value unless we're actively driving the line. */
+	if (!test_bit(FLAG_REQUESTED, &desc->flags) ||
+	    !test_bit(FLAG_IS_OUT, &desc->flags))
+		__assign_bit(offset, chip->values, value);
+
+set_pull:
+	__assign_bit(offset, chip->pulls, value);
+	mutex_unlock(&chip->lock);
+	return 0;
+}
+
+static int gpio_sim_get(struct gpio_chip *gc, unsigned int offset)
+{
+	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
+	int ret;
+
+	mutex_lock(&chip->lock);
+	ret = !!test_bit(offset, chip->values);
+	mutex_unlock(&chip->lock);
+
+	return ret;
+}
+
+static void gpio_sim_set(struct gpio_chip *gc, unsigned int offset, int value)
+{
+	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
+
+	mutex_lock(&chip->lock);
+	__assign_bit(offset, chip->values, value);
+	mutex_unlock(&chip->lock);
+}
+
+static int gpio_sim_get_multiple(struct gpio_chip *gc,
+				 unsigned long *mask, unsigned long *bits)
+{
+	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
+
+	mutex_lock(&chip->lock);
+	bitmap_copy(bits, chip->values, gc->ngpio);
+	mutex_unlock(&chip->lock);
+
+	return 0;
+}
+
+static void gpio_sim_set_multiple(struct gpio_chip *gc,
+				  unsigned long *mask, unsigned long *bits)
+{
+	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
+
+	mutex_lock(&chip->lock);
+	bitmap_copy(chip->values, bits, gc->ngpio);
+	mutex_unlock(&chip->lock);
+}
+
+static int gpio_sim_direction_output(struct gpio_chip *gc,
+				     unsigned int offset, int value)
+{
+	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
+
+	mutex_lock(&chip->lock);
+	__clear_bit(offset, chip->directions);
+	__assign_bit(offset, chip->values, value);
+	mutex_unlock(&chip->lock);
+
+	return 0;
+}
+
+static int gpio_sim_direction_input(struct gpio_chip *gc, unsigned int offset)
+{
+	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
+
+	mutex_lock(&chip->lock);
+	__set_bit(offset, chip->directions);
+	mutex_unlock(&chip->lock);
+
+	return 0;
+}
+
+static int gpio_sim_get_direction(struct gpio_chip *gc, unsigned int offset)
+{
+	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
+	int direction;
+
+	mutex_lock(&chip->lock);
+	direction = !!test_bit(offset, chip->directions);
+	mutex_unlock(&chip->lock);
+
+	return direction ? GPIO_LINE_DIRECTION_IN : GPIO_LINE_DIRECTION_OUT;
+}
+
+static int gpio_sim_set_config(struct gpio_chip *gc,
+				  unsigned int offset, unsigned long config)
+{
+	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
+
+	switch (pinconf_to_config_param(config)) {
+	case PIN_CONFIG_BIAS_PULL_UP:
+		return gpio_sim_apply_pull(chip, offset, 1);
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		return gpio_sim_apply_pull(chip, offset, 0);
+	default:
+		break;
+	}
+
+	return -ENOTSUPP;
+}
+
+static int gpio_sim_to_irq(struct gpio_chip *gc, unsigned int offset)
+{
+	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
+
+	return irq_create_mapping(chip->irq_sim, offset);
+}
+
+static void gpio_sim_free(struct gpio_chip *gc, unsigned int offset)
+{
+	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
+
+	mutex_lock(&chip->lock);
+	__assign_bit(offset, chip->values, !!test_bit(offset, chip->pulls));
+	mutex_unlock(&chip->lock);
+}
+
+static ssize_t gpio_sim_sysfs_line_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct gpio_sim_attribute *line_attr = to_gpio_sim_attr(attr);
+	struct gpio_sim_chip *chip = dev_get_drvdata(dev);
+	int ret;
+
+	mutex_lock(&chip->lock);
+	ret = sysfs_emit(buf, "%u\n",
+			 !!test_bit(line_attr->offset, chip->values));
+	mutex_unlock(&chip->lock);
+
+	return ret;
+}
+
+static ssize_t gpio_sim_sysfs_line_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t len)
+{
+	struct gpio_sim_attribute *line_attr = to_gpio_sim_attr(attr);
+	struct gpio_sim_chip *chip = dev_get_drvdata(dev);
+	int ret, val;
+
+	if (len > 2 || (buf[0] != '0' && buf[0] != '1'))
+		return -EINVAL;
+
+	val = buf[0] == '0' ? 0 : 1;
+
+	ret = gpio_sim_apply_pull(chip, line_attr->offset, val);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static void gpio_sim_mutex_destroy(void *data)
+{
+	struct mutex *lock = data;
+
+	mutex_destroy(lock);
+}
+
+static void gpio_sim_sysfs_remove(void *data)
+{
+	struct gpio_sim_chip *chip = data;
+
+	sysfs_remove_group(&chip->gc.parent->kobj, &chip->attr_group);
+}
+
+static int gpio_sim_setup_sysfs(struct gpio_sim_chip *chip)
+{
+	unsigned int i, num_lines = chip->gc.ngpio;
+	struct device *dev = chip->gc.parent;
+	struct gpio_sim_attribute *line_attr;
+	struct device_attribute *dev_attr;
+	struct attribute **attrs;
+	int ret;
+
+	attrs = devm_kcalloc(dev, sizeof(*attrs), num_lines + 1, GFP_KERNEL);
+	if (!attrs)
+		return -ENOMEM;
+
+	for (i = 0; i < num_lines; i++) {
+		line_attr = devm_kzalloc(dev, sizeof(*line_attr), GFP_KERNEL);
+		if (!line_attr)
+			return -ENOMEM;
+
+		line_attr->offset = i;
+
+		dev_attr = &line_attr->dev_attr;
+		sysfs_attr_init(&dev_attr->attr);
+
+		dev_attr->attr.name = devm_kasprintf(dev, GFP_KERNEL,
+						     "gpio%u", i);
+		if (!dev_attr->attr.name)
+			return -ENOMEM;
+
+		dev_attr->attr.mode = 0644;
+
+		dev_attr->show = gpio_sim_sysfs_line_show;
+		dev_attr->store = gpio_sim_sysfs_line_store;
+
+		attrs[i] = &dev_attr->attr;
+	}
+
+	chip->attr_group.name = "control";
+	chip->attr_group.attrs = attrs;
+
+	ret = sysfs_create_group(&dev->kobj, &chip->attr_group);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, gpio_sim_sysfs_remove, chip);
+}
+
+static int gpio_sim_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct gpio_sim_chip *chip;
+	struct gpio_chip *gc;
+	const char *label;
+	u32 num_lines;
+	int ret;
+
+	ret = device_property_read_u32(dev, "ngpios", &num_lines);
+	if (ret)
+		return ret;
+
+	ret = device_property_read_string(dev, "gpio-sim,label", &label);
+	if (ret)
+		label = dev_name(dev);
+
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->directions = devm_bitmap_alloc(dev, num_lines, GFP_KERNEL);
+	if (!chip->directions)
+		return -ENOMEM;
+
+	/* Default to input mode. */
+	bitmap_fill(chip->directions, num_lines);
+
+	chip->values = devm_bitmap_zalloc(dev, num_lines, GFP_KERNEL);
+	if (!chip->values)
+		return -ENOMEM;
+
+	chip->pulls = devm_bitmap_zalloc(dev, num_lines, GFP_KERNEL);
+	if (!chip->pulls)
+		return -ENOMEM;
+
+	chip->irq_sim = devm_irq_domain_create_sim(dev, NULL, num_lines);
+	if (IS_ERR(chip->irq_sim))
+		return PTR_ERR(chip->irq_sim);
+
+	mutex_init(&chip->lock);
+	ret = devm_add_action_or_reset(dev, gpio_sim_mutex_destroy,
+				       &chip->lock);
+	if (ret)
+		return ret;
+
+	gc = &chip->gc;
+	gc->base = -1;
+	gc->ngpio = num_lines;
+	gc->label = label;
+	gc->owner = THIS_MODULE;
+	gc->parent = dev;
+	gc->get = gpio_sim_get;
+	gc->set = gpio_sim_set;
+	gc->get_multiple = gpio_sim_get_multiple;
+	gc->set_multiple = gpio_sim_set_multiple;
+	gc->direction_output = gpio_sim_direction_output;
+	gc->direction_input = gpio_sim_direction_input;
+	gc->get_direction = gpio_sim_get_direction;
+	gc->set_config = gpio_sim_set_config;
+	gc->to_irq = gpio_sim_to_irq;
+	gc->free = gpio_sim_free;
+
+	ret = devm_gpiochip_add_data(dev, gc, chip);
+	if (ret)
+		return ret;
+
+	/* Used by sysfs and configfs callbacks. */
+	dev_set_drvdata(dev, chip);
+
+	return gpio_sim_setup_sysfs(chip);
+}
+
+static const struct of_device_id gpio_sim_of_match[] = {
+	{ .compatible = "gpio-simulator" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, gpio_sim_of_match);
+
+static struct platform_driver gpio_sim_driver = {
+	.driver = {
+		.name = "gpio-sim",
+		.of_match_table = gpio_sim_of_match,
+	},
+	.probe = gpio_sim_probe,
+};
+
+struct gpio_sim_chip_ctx {
+	struct config_group group;
+
+	/*
+	 * If pdev is NULL, the item is 'pending' (waiting for configuration).
+	 * Once the pointer is assigned, the device has been created and the
+	 * item is 'live'.
+	 */
+	struct platform_device *pdev;
+	int id;
+
+	/*
+	 * Each configfs filesystem operation is protected with the subsystem
+	 * mutex. Each separate attribute is protected with the buffer mutex.
+	 * This structure however can be modified by callbacks of different
+	 * attributes so we need another lock.
+	 */
+	struct mutex lock;
+
+	char label[32];
+	unsigned int num_lines;
+
+	struct list_head line_ctx_list;
+};
+
+struct gpio_sim_line_ctx {
+	struct config_item item;
+	struct list_head list;
+
+	/*
+	 * We could have used the ci_parent field of the config_item but
+	 * configfs is stupid and calls the item's release callback after
+	 * already having cleared the parent pointer even though the parent
+	 * is guaranteed to survive the child...
+	 *
+	 * So we need to store the pointer to the parent struct here.
+	 */
+	struct gpio_sim_chip_ctx *parent;
+
+	/* Same as the chip context. */
+	struct mutex lock;
+
+	unsigned int offset;
+	char *name;
+};
+
+static struct gpio_sim_chip_ctx *to_gpio_sim_chip_ctx(struct config_item *item)
+{
+	struct config_group *group = container_of(item, struct config_group,
+						  cg_item);
+
+	return container_of(group, struct gpio_sim_chip_ctx, group);
+}
+
+static struct gpio_sim_line_ctx *to_gpio_sim_line_ctx(struct config_item *item)
+{
+	return container_of(item, struct gpio_sim_line_ctx, item);
+}
+
+static bool gpio_sim_chip_live(struct gpio_sim_chip_ctx *ctx)
+{
+	return !!ctx->pdev;
+}
+
+static char *gpio_sim_strdup_trimmed(const char *str, size_t count)
+{
+	char *dup, *trimmed, *ret;
+
+	dup = kstrndup(str, count, GFP_KERNEL);
+	if (!dup)
+		return NULL;
+
+	trimmed = strstrip(dup);
+	ret = kstrdup(trimmed, GFP_KERNEL);
+	kfree(dup);
+	return ret;
+}
+
+static ssize_t gpio_sim_config_chip_dev_name_show(struct config_item *item,
+						  char *page)
+{
+	struct gpio_sim_chip_ctx *ctx = to_gpio_sim_chip_ctx(item);
+	struct platform_device *pdev;
+	int ret;
+
+	mutex_lock(&ctx->lock);
+	pdev = ctx->pdev;
+	if (pdev)
+		ret = sprintf(page, "%s\n", dev_name(&pdev->dev));
+	else
+		ret = sprintf(page, "gpio-sim.%d\n", ctx->id);
+	mutex_unlock(&ctx->lock);
+
+	return ret;
+}
+
+CONFIGFS_ATTR_RO(gpio_sim_config_chip_, dev_name);
+
+static ssize_t gpio_sim_config_chip_chip_name_show(struct config_item *item,
+						   char *page)
+{
+	struct gpio_sim_chip_ctx *ctx = to_gpio_sim_chip_ctx(item);
+	struct gpio_sim_chip *chip = NULL;
+	int ret;
+
+	mutex_lock(&ctx->lock);
+	if (gpio_sim_chip_live(ctx))
+		chip = dev_get_drvdata(&ctx->pdev->dev);
+
+	if (chip)
+		ret = sprintf(page, "%s\n", dev_name(&chip->gc.gpiodev->dev));
+	else
+		ret = sprintf(page, "none\n");
+	mutex_unlock(&ctx->lock);
+
+	return ret;
+}
+
+CONFIGFS_ATTR_RO(gpio_sim_config_chip_, chip_name);
+
+static ssize_t
+gpio_sim_config_chip_label_show(struct config_item *item, char *page)
+{
+	struct gpio_sim_chip_ctx *ctx = to_gpio_sim_chip_ctx(item);
+	int ret;
+
+	mutex_lock(&ctx->lock);
+	ret = sprintf(page, "%s\n", ctx->label);
+	mutex_unlock(&ctx->lock);
+
+	return ret;
+}
+
+static ssize_t gpio_sim_config_chip_label_store(struct config_item *item,
+						const char *page, size_t count)
+{
+	struct gpio_sim_chip_ctx *ctx = to_gpio_sim_chip_ctx(item);
+	char *trimmed;
+	int ret;
+
+	mutex_lock(&ctx->lock);
+
+	if (gpio_sim_chip_live(ctx)) {
+		mutex_unlock(&ctx->lock);
+		return -EBUSY;
+	}
+
+	trimmed = gpio_sim_strdup_trimmed(page, count);
+	if (!trimmed) {
+		mutex_unlock(&ctx->lock);
+		return -ENOMEM;
+	}
+
+	ret = snprintf(ctx->label, sizeof(ctx->label), "%s", trimmed);
+	kfree(trimmed);
+	if (ret < 0) {
+		mutex_unlock(&ctx->lock);
+		return ret;
+	}
+
+	mutex_unlock(&ctx->lock);
+	return count;
+}
+
+CONFIGFS_ATTR(gpio_sim_config_chip_, label);
+
+static ssize_t
+gpio_sim_config_chip_num_lines_show(struct config_item *item, char *page)
+{
+	struct gpio_sim_chip_ctx *ctx = to_gpio_sim_chip_ctx(item);
+	int ret;
+
+	mutex_lock(&ctx->lock);
+	ret = sprintf(page, "%u\n", ctx->num_lines);
+	mutex_unlock(&ctx->lock);
+
+	return ret;
+}
+
+static ssize_t
+gpio_sim_config_chip_num_lines_store(struct config_item *item,
+				     const char *page, size_t count)
+{
+	struct gpio_sim_chip_ctx *ctx = to_gpio_sim_chip_ctx(item);
+	unsigned int num_lines;
+	int ret;
+
+	mutex_lock(&ctx->lock);
+
+	if (gpio_sim_chip_live(ctx)) {
+		mutex_unlock(&ctx->lock);
+		return -EBUSY;
+	}
+
+	ret = kstrtouint(page, 10, &num_lines);
+	if (ret) {
+		mutex_unlock(&ctx->lock);
+		return ret;
+	}
+
+	if (num_lines == 0) {
+		mutex_unlock(&ctx->lock);
+		return -EINVAL;
+	}
+
+	ctx->num_lines = num_lines;
+
+	mutex_unlock(&ctx->lock);
+	return count;
+}
+
+CONFIGFS_ATTR(gpio_sim_config_chip_, num_lines);
+
+static ssize_t
+gpio_sim_config_chip_live_show(struct config_item *item, char *page)
+{
+	struct gpio_sim_chip_ctx *ctx = to_gpio_sim_chip_ctx(item);
+	int ret;
+
+	mutex_lock(&ctx->lock);
+	ret = sprintf(page, "%c\n", gpio_sim_chip_live(ctx) ? '1' : '0');
+	mutex_unlock(&ctx->lock);
+
+	return ret;
+}
+
+static char **gpio_sim_make_line_names(struct gpio_sim_chip_ctx *chip_ctx,
+				       unsigned int *line_names_size)
+{
+	struct gpio_sim_line_ctx *line_ctx;
+	unsigned int max_offset = 0;
+	bool has_line_names = false;
+	char **line_names;
+
+	list_for_each_entry(line_ctx, &chip_ctx->line_ctx_list, list) {
+		if (line_ctx->name) {
+			if (line_ctx->offset > max_offset)
+				max_offset = line_ctx->offset;
+
+			/*
+			 * max_offset can stay at 0 so it's not an indicator
+			 * of whether line names were configured at all.
+			 */
+			has_line_names = true;
+		}
+	}
+
+	if (!has_line_names)
+		/*
+		 * This is not an error - NULL means, there are no line
+		 * names configured.
+		 */
+		return NULL;
+
+	*line_names_size = max_offset + 1;
+
+	line_names = kcalloc(*line_names_size, sizeof(*line_names), GFP_KERNEL);
+	if (!line_names)
+		return ERR_PTR(-ENOMEM);
+
+	list_for_each_entry(line_ctx, &chip_ctx->line_ctx_list, list) {
+		if (line_ctx->name)
+			line_names[line_ctx->offset] = line_ctx->name;
+	}
+
+	return line_names;
+}
+
+static int gpio_sim_activate_chip_unlocked(struct gpio_sim_chip_ctx *ctx)
+{
+	unsigned int prop_idx = 0, line_names_size = 0;
+	struct platform_device_info pdevinfo;
+	struct property_entry properties[4]; /* Max 3 properties + sentinel. */
+	struct fwnode_handle *fwnode;
+	struct platform_device *pdev;
+	char **line_names;
+
+	memset(&pdevinfo, 0, sizeof(pdevinfo));
+	memset(properties, 0, sizeof(properties));
+
+	properties[prop_idx++] = PROPERTY_ENTRY_U32("ngpios",
+						    ctx->num_lines);
+
+	if (ctx->label[0] != '\0')
+		properties[prop_idx++] = PROPERTY_ENTRY_STRING("gpio-sim,label",
+							       ctx->label);
+
+	line_names = gpio_sim_make_line_names(ctx, &line_names_size);
+	if (IS_ERR(line_names))
+		return PTR_ERR(line_names);
+
+	if (line_names)
+		properties[prop_idx++] = PROPERTY_ENTRY_STRING_ARRAY_LEN(
+						"gpio-line-names",
+						line_names, line_names_size);
+
+	fwnode = fwnode_create_software_node(properties, NULL);
+	/*
+	 * fwnode_create_software_node() makes a deep copy of the properties,
+	 * so no need to store the array of line names.
+	 */
+	kfree_strarray(line_names, line_names_size);
+	if (IS_ERR(fwnode))
+		return PTR_ERR(fwnode);
+
+	pdevinfo.name = "gpio-sim";
+	pdevinfo.fwnode = fwnode;
+	pdevinfo.id = ctx->id;
+
+	pdev = platform_device_register_full(&pdevinfo);
+	if (IS_ERR(pdev)) {
+		fwnode_remove_software_node(fwnode);
+		return PTR_ERR(pdev);
+	}
+
+	ctx->pdev = pdev;
+
+	return 0;
+}
+
+static void gpio_sim_deactivate_chip_unlocked(struct gpio_sim_chip_ctx *ctx)
+{
+	struct fwnode_handle *fwnode;
+
+	fwnode = dev_fwnode(&ctx->pdev->dev);
+	platform_device_unregister(ctx->pdev);
+	fwnode_remove_software_node(fwnode);
+	ctx->pdev = NULL;
+}
+
+static ssize_t
+gpio_sim_config_chip_live_store(struct config_item *item,
+				  const char *page, size_t count)
+{
+	struct gpio_sim_chip_ctx *ctx = to_gpio_sim_chip_ctx(item);
+	int live, ret;
+
+	ret = kstrtouint(page, 10, &live);
+	if (ret)
+		return ret;
+
+	mutex_lock(&ctx->lock);
+
+	if ((live == 0 && !gpio_sim_chip_live(ctx)) ||
+	    (live == 1 && gpio_sim_chip_live(ctx)))
+		ret = -EPERM;
+	else if (live == 1)
+		ret = gpio_sim_activate_chip_unlocked(ctx);
+	else if (live == 0)
+		gpio_sim_deactivate_chip_unlocked(ctx);
+	else
+		ret = -EINVAL;
+
+	mutex_unlock(&ctx->lock);
+
+	return ret ?: count;
+}
+
+CONFIGFS_ATTR(gpio_sim_config_chip_, live);
+
+static struct configfs_attribute *gpio_sim_config_chip_attrs[] = {
+	&gpio_sim_config_chip_attr_dev_name,
+	&gpio_sim_config_chip_attr_chip_name,
+	&gpio_sim_config_chip_attr_label,
+	&gpio_sim_config_chip_attr_num_lines,
+	&gpio_sim_config_chip_attr_live,
+	NULL
+};
+
+static ssize_t
+gpio_sim_config_line_name_show(struct config_item *item, char *page)
+{
+	struct gpio_sim_line_ctx *ctx = to_gpio_sim_line_ctx(item);
+	int ret;
+
+	mutex_lock(&ctx->lock);
+	ret = sprintf(page, "%s\n", ctx->name ?: "");
+	mutex_unlock(&ctx->lock);
+
+	return ret;
+}
+
+static ssize_t gpio_sim_config_line_name_store(struct config_item *item,
+					       const char *page, size_t count)
+{
+	struct gpio_sim_line_ctx *line_ctx = to_gpio_sim_line_ctx(item);
+	struct gpio_sim_chip_ctx *chip_ctx = line_ctx->parent;
+	char *trimmed;
+
+	mutex_lock(&chip_ctx->lock);
+
+	if (gpio_sim_chip_live(chip_ctx)) {
+		mutex_unlock(&chip_ctx->lock);
+		return -EBUSY;
+	}
+
+	trimmed = gpio_sim_strdup_trimmed(page, count);
+	if (!trimmed) {
+		mutex_unlock(&chip_ctx->lock);
+		return -ENOMEM;
+	}
+
+	mutex_lock(&line_ctx->lock);
+
+	kfree(line_ctx->name);
+	line_ctx->name = trimmed;
+
+	mutex_unlock(&line_ctx->lock);
+	mutex_unlock(&chip_ctx->lock);
+
+	return count;
+}
+
+CONFIGFS_ATTR(gpio_sim_config_line_, name);
+
+static struct configfs_attribute *gpio_sim_line_config_attrs[] = {
+	&gpio_sim_config_line_attr_name,
+	NULL,
+};
+
+static void gpio_sim_line_item_release(struct config_item *item)
+{
+	struct gpio_sim_line_ctx *line_ctx = to_gpio_sim_line_ctx(item);
+	struct gpio_sim_chip_ctx *chip_ctx = line_ctx->parent;
+
+	mutex_lock(&chip_ctx->lock);
+	list_del(&line_ctx->list);
+	mutex_unlock(&chip_ctx->lock);
+
+	mutex_destroy(&line_ctx->lock);
+	kfree(line_ctx->name);
+	kfree(line_ctx);
+}
+
+static struct configfs_item_operations gpio_sim_config_line_item_ops = {
+	.release	= gpio_sim_line_item_release,
+};
+
+static const struct config_item_type gpio_sim_line_config_type = {
+	.ct_item_ops	= &gpio_sim_config_line_item_ops,
+	.ct_attrs	= gpio_sim_line_config_attrs,
+	.ct_owner       = THIS_MODULE,
+};
+
+static struct config_item *
+gpio_sim_config_make_line_item(struct config_group *group, const char *name)
+{
+	struct gpio_sim_chip_ctx *chip_ctx;
+	struct gpio_sim_line_ctx *line_ctx;
+	unsigned int offset;
+	int ret, nchar;
+
+	ret = sscanf(name, "line%u%n", &offset, &nchar);
+	if (ret != 1 || nchar != strlen(name))
+		return ERR_PTR(-EINVAL);
+
+	chip_ctx = to_gpio_sim_chip_ctx(&group->cg_item);
+
+	mutex_lock(&chip_ctx->lock);
+
+	if (gpio_sim_chip_live(chip_ctx)) {
+		mutex_unlock(&chip_ctx->lock);
+		return ERR_PTR(-EBUSY);
+	}
+
+	line_ctx = kzalloc(sizeof(*line_ctx), GFP_KERNEL);
+	if (!line_ctx) {
+		mutex_unlock(&chip_ctx->lock);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	config_item_init_type_name(&line_ctx->item, name,
+				   &gpio_sim_line_config_type);
+
+	line_ctx->parent = chip_ctx;
+	line_ctx->offset = offset;
+	list_add_tail(&line_ctx->list, &chip_ctx->line_ctx_list);
+	mutex_init(&line_ctx->lock);
+
+	mutex_unlock(&chip_ctx->lock);
+
+	return &line_ctx->item;
+}
+
+static void gpio_sim_chip_item_release(struct config_item *item)
+{
+	struct gpio_sim_chip_ctx *ctx = to_gpio_sim_chip_ctx(item);
+
+	if (gpio_sim_chip_live(ctx))
+		gpio_sim_deactivate_chip_unlocked(ctx);
+
+	mutex_destroy(&ctx->lock);
+	ida_free(&gpio_sim_ida, ctx->id);
+	kfree(ctx);
+}
+
+static struct configfs_item_operations gpio_sim_config_chip_item_ops = {
+	.release	= gpio_sim_chip_item_release,
+};
+
+static struct configfs_group_operations gpio_sim_config_chip_group_ops = {
+	.make_item	= gpio_sim_config_make_line_item,
+};
+
+static const struct config_item_type gpio_sim_chip_group_config_type = {
+	.ct_item_ops	= &gpio_sim_config_chip_item_ops,
+	.ct_group_ops	= &gpio_sim_config_chip_group_ops,
+	.ct_attrs	= gpio_sim_config_chip_attrs,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct config_group *
+gpio_sim_config_make_chip_group(struct config_group *group, const char *name)
+{
+	struct gpio_sim_chip_ctx *ctx;
+	int id;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	id = ida_alloc(&gpio_sim_ida, GFP_KERNEL);
+	if (id < 0) {
+		kfree(ctx);
+		return ERR_PTR(id);
+	}
+
+	config_group_init_type_name(&ctx->group, name,
+				    &gpio_sim_chip_group_config_type);
+	ctx->num_lines = 1;
+	ctx->id = id;
+	mutex_init(&ctx->lock);
+	INIT_LIST_HEAD(&ctx->line_ctx_list);
+
+	return &ctx->group;
+}
+
+static struct configfs_group_operations gpio_sim_config_group_ops = {
+	.make_group	= gpio_sim_config_make_chip_group,
+};
+
+static const struct config_item_type gpio_sim_config_type = {
+	.ct_group_ops	= &gpio_sim_config_group_ops,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct configfs_subsystem gpio_sim_config_subsys = {
+	.su_group = {
+		.cg_item = {
+			.ci_namebuf	= "gpio-sim",
+			.ci_type	= &gpio_sim_config_type,
+		},
+	},
+};
+
+static int __init gpio_sim_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&gpio_sim_driver);
+	if (ret) {
+		pr_err("Error %d while registering the platform driver\n", ret);
+		return ret;
+	}
+
+	config_group_init(&gpio_sim_config_subsys.su_group);
+	mutex_init(&gpio_sim_config_subsys.su_mutex);
+	ret = configfs_register_subsystem(&gpio_sim_config_subsys);
+	if (ret) {
+		pr_err("Error %d while registering the configfs subsystem %s\n",
+		       ret, gpio_sim_config_subsys.su_group.cg_item.ci_namebuf);
+		mutex_destroy(&gpio_sim_config_subsys.su_mutex);
+		platform_driver_unregister(&gpio_sim_driver);
+		return ret;
+	}
+
+	return 0;
+}
+module_init(gpio_sim_init);
+
+static void __exit gpio_sim_exit(void)
+{
+	configfs_unregister_subsystem(&gpio_sim_config_subsys);
+	mutex_destroy(&gpio_sim_config_subsys.su_mutex);
+	platform_driver_unregister(&gpio_sim_driver);
+}
+module_exit(gpio_sim_exit);
+
+MODULE_AUTHOR("Bartosz Golaszewski <brgl@bgdev.pl");
+MODULE_DESCRIPTION("GPIO Simulator Module");
+MODULE_LICENSE("GPL");
-- 
2.25.1

