Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822A545B95C
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Nov 2021 12:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241730AbhKXLqU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Nov 2021 06:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241736AbhKXLqQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Nov 2021 06:46:16 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B5CC06173E
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Nov 2021 03:43:06 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id c4so3623111wrd.9
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Nov 2021 03:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u3JjDpe+RKM3dVrlZKMX/eEU3jgsxBTgoaKKDKyKZQA=;
        b=gEVX9aE3wCobLB45Xl7lCQctWX8QiJ50xn4Or9FKEVDuasFF2lNQfxKgqobCODTD4M
         jSO6ofG61gXlCI7cJ02jWRCL7SxUPQ773Nz3W/3+lOaGMR7CcjanHV8KnH7VGorkwa3q
         pNATIn0qtPDF1iFk5zfECmw0wKe8pYTVXMn/GLVjEXoxliTUfxOuoxdrLVo8jXdns9MM
         G2b/fvjqfGeK8YDbZ32FL1UV0hsEtfQSvxVO4vyhtj/+75hMzDHn7KRflUjtoO/N3kSK
         YgsM6GvWDK4qHD0/I+3ELbdeFMHAxyC7gf6P2xrsgwmXTmGEXhCkRzHaTBlf/bsDX3w3
         igYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u3JjDpe+RKM3dVrlZKMX/eEU3jgsxBTgoaKKDKyKZQA=;
        b=qOewuz8W11KjNY+Z9vWJ9fQIZDkAqxsBumSPHih9PsuERw6yJI5vDUuRCKODJVYeJR
         hV3i36iBO54PxeX/8t28DdI5yYm9A5cf22bsYG+T4SLuC7/ilp0rIFXqAteXGXY6TDNg
         OxQ/WGXlOy5xJYsLC8kxDjkom8+fX1O9CAWcXZ1737h1MSBUEb4c1Cqf+Pd/5vZvOCsi
         PQi3zxn/eHF3UosVnAadaaW6oWQByv5j7WJbqmLCdNX0Y8CYbU306u6gUTHD4CMsg1DJ
         DEMh2uob5+fDgmfpAb5sZxBtZFi8wKm3tneBIUztxKr0k0g6xUfqvPI/diRGZAMmKqnR
         EJrA==
X-Gm-Message-State: AOAM5331T+Z6X5I1Nea5B391uqfmx4xaQbnisa/ci9efi0L5bk5dP3xO
        HbivXpEyvQw2TevzACk4ECO5UpLIscCOj2QW
X-Google-Smtp-Source: ABdhPJyCXAazGEFWmW6ZRBpVlzMNAID7T8s6tlf4cbfbJxhxA4Ps5EGNl/ygdUO+RWojN7BsmNvQvg==
X-Received: by 2002:a5d:69ce:: with SMTP id s14mr17157673wrw.25.1637754184197;
        Wed, 24 Nov 2021 03:43:04 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:334:ac00:7d50:ff5:f5c1:e225])
        by smtp.gmail.com with ESMTPSA id s63sm5165173wme.22.2021.11.24.03.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 03:43:03 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v10 2/5] gpio: sim: new testing module
Date:   Wed, 24 Nov 2021 12:42:54 +0100
Message-Id: <20211124114257.19878-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20211124114257.19878-1-brgl@bgdev.pl>
References: <20211124114257.19878-1-brgl@bgdev.pl>
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
 Documentation/admin-guide/gpio/gpio-sim.rst |   80 ++
 drivers/gpio/Kconfig                        |    8 +
 drivers/gpio/Makefile                       |    1 +
 drivers/gpio/gpio-sim.c                     | 1370 +++++++++++++++++++
 4 files changed, 1459 insertions(+)
 create mode 100644 Documentation/admin-guide/gpio/gpio-sim.rst
 create mode 100644 drivers/gpio/gpio-sim.c

diff --git a/Documentation/admin-guide/gpio/gpio-sim.rst b/Documentation/admin-guide/gpio/gpio-sim.rst
new file mode 100644
index 000000000000..5da24bc698d7
--- /dev/null
+++ b/Documentation/admin-guide/gpio/gpio-sim.rst
@@ -0,0 +1,80 @@
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
+Once the confiuration is complete, the 'live' attribute must be set to 1 in
+order to instantiate the chip. It can be set back to 0 to destroy the simulated
+chip. The module will synchronously wait for the new simulated device to be
+successfully probed and if this doesn't happen, writing to 'live' will result
+in an error.
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
+Lines can be hogged by creating a new directory under the line's directory. The
+directory must be called 'hog' and there can only be a single instance of it.
+The hog directory also exposes additional attributes:
+
+  name - name of the kernel consumer of this hogged line
+
+  direction - hog direction, must be one of: 'input', 'output-high' and
+              'output-low'
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
+Each simulated GPIO chip creates a separate sysfs group under its device
+directory for each exposed line. The name of each group is of the form:
+'sim_gpioX' where X is the offset of the line. Inside each group there are
+two attibutes:
+
+  pull - allows to read and set the current simulated pull setting for every
+         line, when writing the value must be one of: 'pull-up', 'pull-down'
+
+  value - allows to read the current value of the line which may be different
+          from the pull if the line is being driven from user-space
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 60d9374c72c0..9acdb4d1047b 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1694,6 +1694,14 @@ config GPIO_VIRTIO
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
index 000000000000..d4ddbb4a4e3b
--- /dev/null
+++ b/drivers/gpio/gpio-sim.c
@@ -0,0 +1,1370 @@
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
+#include <linux/completion.h>
+#include <linux/configfs.h>
+#include <linux/device.h>
+#include <linux/gpio/driver.h>
+#include <linux/gpio/machine.h>
+#include <linux/idr.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irq_sim.h>
+#include <linux/list.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
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
+	unsigned long *direction_map;
+	unsigned long *value_map;
+	unsigned long *pull_map;
+	struct irq_domain *irq_sim;
+	struct mutex lock;
+	const struct attribute_group **attr_groups;
+};
+
+/* value, pull and sentinel */
+#define GPIO_SIM_NUM_ATTRS 3
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
+		curr_val = !!test_bit(offset, chip->value_map);
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
+		__assign_bit(offset, chip->value_map, value);
+
+set_pull:
+	__assign_bit(offset, chip->pull_map, value);
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
+	ret = !!test_bit(offset, chip->value_map);
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
+	__assign_bit(offset, chip->value_map, value);
+	mutex_unlock(&chip->lock);
+}
+
+static int gpio_sim_get_multiple(struct gpio_chip *gc,
+				 unsigned long *mask, unsigned long *bits)
+{
+	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
+
+	mutex_lock(&chip->lock);
+	bitmap_copy(bits, chip->value_map, gc->ngpio);
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
+	bitmap_copy(chip->value_map, bits, gc->ngpio);
+	mutex_unlock(&chip->lock);
+}
+
+static int gpio_sim_direction_output(struct gpio_chip *gc,
+				     unsigned int offset, int value)
+{
+	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
+
+	mutex_lock(&chip->lock);
+	__clear_bit(offset, chip->direction_map);
+	__assign_bit(offset, chip->value_map, value);
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
+	__set_bit(offset, chip->direction_map);
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
+	direction = !!test_bit(offset, chip->direction_map);
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
+	__assign_bit(offset, chip->value_map, !!test_bit(offset, chip->pull_map));
+	mutex_unlock(&chip->lock);
+}
+
+static ssize_t gpio_sim_sysfs_val_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct gpio_sim_attribute *line_attr = to_gpio_sim_attr(attr);
+	struct gpio_sim_chip *chip = dev_get_drvdata(dev);
+	int val;
+
+	mutex_lock(&chip->lock);
+	val = !!test_bit(line_attr->offset, chip->value_map);
+	mutex_unlock(&chip->lock);
+
+	return sysfs_emit(buf, "%d\n", val);
+}
+
+static ssize_t gpio_sim_sysfs_val_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	/*
+	 * Not assigning this function will result in write() returning -EIO
+	 * which is confusing. Return -EPERM explicitly.
+	 */
+	return -EPERM;
+}
+
+static ssize_t gpio_sim_sysfs_pull_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct gpio_sim_attribute *line_attr = to_gpio_sim_attr(attr);
+	struct gpio_sim_chip *chip = dev_get_drvdata(dev);
+	char *repr;
+	int pull;
+
+	mutex_lock(&chip->lock);
+	pull = !!test_bit(line_attr->offset, chip->pull_map);
+	mutex_unlock(&chip->lock);
+
+	if (pull)
+		repr = "pull-up";
+	else
+		repr = "pull-down";
+
+	return sysfs_emit(buf, "%s\n", repr);
+}
+
+static ssize_t gpio_sim_sysfs_pull_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t len)
+{
+	struct gpio_sim_attribute *line_attr = to_gpio_sim_attr(attr);
+	struct gpio_sim_chip *chip = dev_get_drvdata(dev);
+	int ret, pull;
+
+	if (sysfs_streq(buf, "pull-down"))
+		pull = 0;
+	else if (sysfs_streq(buf, "pull-up"))
+		pull = 1;
+	else
+		return -EINVAL;
+
+	ret = gpio_sim_apply_pull(chip, line_attr->offset, pull);
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
+	sysfs_remove_groups(&chip->gc.parent->kobj, chip->attr_groups);
+}
+
+static int gpio_sim_setup_sysfs(struct gpio_sim_chip *chip)
+{
+	struct device_attribute *val_dev_attr, *pull_dev_attr;
+	struct gpio_sim_attribute *val_attr, *pull_attr;
+	unsigned int num_lines = chip->gc.ngpio;
+	struct device *dev = chip->gc.parent;
+	struct attribute_group *attr_group;
+	struct attribute **attrs;
+	int i, ret;
+
+	chip->attr_groups = devm_kcalloc(dev, sizeof(*chip->attr_groups),
+					 num_lines + 1, GFP_KERNEL);
+	if (!chip->attr_groups)
+		return -ENOMEM;
+
+	for (i = 0; i < num_lines; i++) {
+		attr_group = devm_kzalloc(dev, sizeof(*attr_group), GFP_KERNEL);
+		attrs = devm_kcalloc(dev, sizeof(*attrs),
+				     GPIO_SIM_NUM_ATTRS, GFP_KERNEL);
+		val_attr = devm_kzalloc(dev, sizeof(*val_attr), GFP_KERNEL);
+		pull_attr = devm_kzalloc(dev, sizeof(*pull_attr), GFP_KERNEL);
+		if (!attr_group || !attrs || !val_attr || !pull_attr)
+			return -ENOMEM;
+
+		attr_group->name = devm_kasprintf(dev, GFP_KERNEL,
+						  "sim_gpio%u", i);
+		if (!attr_group->name)
+			return -ENOMEM;
+
+		val_attr->offset = pull_attr->offset = i;
+
+		val_dev_attr = &val_attr->dev_attr;
+		pull_dev_attr = &pull_attr->dev_attr;
+
+		sysfs_attr_init(&val_dev_attr->attr);
+		sysfs_attr_init(&pull_dev_attr->attr);
+
+		val_dev_attr->attr.name = "value";
+		pull_dev_attr->attr.name = "pull";
+
+		val_dev_attr->attr.mode = pull_dev_attr->attr.mode = 0644;
+
+		val_dev_attr->show = gpio_sim_sysfs_val_show;
+		val_dev_attr->store = gpio_sim_sysfs_val_store;
+		pull_dev_attr->show = gpio_sim_sysfs_pull_show;
+		pull_dev_attr->store = gpio_sim_sysfs_pull_store;
+
+		attrs[0] = &val_dev_attr->attr;
+		attrs[1] = &pull_dev_attr->attr;
+
+		attr_group->attrs = attrs;
+		chip->attr_groups[i] = attr_group;
+	}
+
+	ret = sysfs_create_groups(&dev->kobj, chip->attr_groups);
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
+	chip->direction_map = devm_bitmap_alloc(dev, num_lines, GFP_KERNEL);
+	if (!chip->direction_map)
+		return -ENOMEM;
+
+	/* Default to input mode. */
+	bitmap_fill(chip->direction_map, num_lines);
+
+	chip->value_map = devm_bitmap_zalloc(dev, num_lines, GFP_KERNEL);
+	if (!chip->value_map)
+		return -ENOMEM;
+
+	chip->pull_map = devm_bitmap_zalloc(dev, num_lines, GFP_KERNEL);
+	if (!chip->pull_map)
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
+	 *
+	 * We use this lock fo protecting all line context structures owned by
+	 * this object too.
+	 */
+	struct mutex lock;
+
+	char label[32];
+	unsigned int num_lines;
+
+	struct list_head line_ctx_list;
+
+	struct notifier_block bus_notifier;
+	struct completion probe_completion;
+	bool driver_bound;
+
+	struct gpiod_hog *hogs;
+};
+
+static struct gpio_sim_chip_ctx *
+gpio_sim_item_to_chip_ctx(struct config_item *item)
+{
+	struct config_group *group = to_config_group(item);
+	return container_of(group, struct gpio_sim_chip_ctx, group);
+}
+
+static struct gpio_sim_chip_ctx *
+gpio_sim_nb_to_chip_ctx(struct notifier_block *nb)
+{
+	return container_of(nb, struct gpio_sim_chip_ctx, bus_notifier);
+}
+
+/* This is called with ctx->lock taken. */
+static int gpio_sim_bus_notifier_call(struct notifier_block *nb,
+				      unsigned long action, void *data)
+{
+	struct gpio_sim_chip_ctx *ctx = gpio_sim_nb_to_chip_ctx(nb);
+	struct device *dev = data;
+	char devname[32];
+
+	snprintf(devname, sizeof(devname), "gpio-sim.%u", ctx->id);
+
+	if (strcmp(dev_name(dev), devname) == 0) {
+		if (action == BUS_NOTIFY_BOUND_DRIVER)
+			ctx->driver_bound = true;
+		else if (action == BUS_NOTIFY_DRIVER_NOT_BOUND)
+			ctx->driver_bound = false;
+		else
+			return NOTIFY_DONE;
+
+		complete(&ctx->probe_completion);
+		return NOTIFY_OK;
+	}
+
+	return NOTIFY_DONE;
+}
+
+struct gpio_sim_line_ctx {
+	struct config_group group;
+	struct list_head list;
+
+	/*
+	 * We could have used the ci_parent field of the config_item but
+	 * configfs is stupid and calls the item's release callback after
+	 * already having cleared the parent pointer even though the parent
+	 * is guaranteed to survive the child...
+	 *
+	 * So we need to store the pointer to the parent struct here. We can
+	 * dereference it anywhere we need with no checks and no locking as
+	 * it's guaranteed to survive the childred and protected by configfs
+	 * locks.
+	 */
+	struct gpio_sim_chip_ctx *parent;
+
+	unsigned int offset;
+	char *name;
+
+	/*
+	 * There can only be one hog per line so we're reusing the line context
+	 * structure in order to simplify the code and avoid a whole new
+	 * allocation and object management.
+	 */
+	struct config_item hog_item;
+	bool hogged;
+	char *hog_name;
+	int hog_dir;
+};
+
+static struct gpio_sim_line_ctx *
+gpio_sim_item_to_line_ctx(struct config_item *item)
+{
+	struct config_group *group = to_config_group(item);
+
+	return container_of(group, struct gpio_sim_line_ctx, group);
+}
+
+static struct gpio_sim_line_ctx *
+gpio_sim_hog_item_to_line_ctx(struct config_item *item)
+{
+	return container_of(item, struct gpio_sim_line_ctx, hog_item);
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
+	struct gpio_sim_chip_ctx *ctx = gpio_sim_item_to_chip_ctx(item);
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
+	struct gpio_sim_chip_ctx *ctx = gpio_sim_item_to_chip_ctx(item);
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
+	struct gpio_sim_chip_ctx *ctx = gpio_sim_item_to_chip_ctx(item);
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
+	struct gpio_sim_chip_ctx *ctx = gpio_sim_item_to_chip_ctx(item);
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
+	struct gpio_sim_chip_ctx *ctx = gpio_sim_item_to_chip_ctx(item);
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
+	struct gpio_sim_chip_ctx *ctx = gpio_sim_item_to_chip_ctx(item);
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
+	struct gpio_sim_chip_ctx *ctx = gpio_sim_item_to_chip_ctx(item);
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
+	list_for_each_entry(line_ctx, &chip_ctx->line_ctx_list, list)
+		line_names[line_ctx->offset] = line_ctx->name;
+
+	return line_names;
+}
+
+static void gpio_sim_remove_hogs(struct gpio_sim_chip_ctx *ctx)
+{
+	struct gpiod_hog *hog;
+
+	if (!ctx->hogs)
+		return;
+
+	gpiod_remove_hogs(ctx->hogs);
+
+	for (hog = ctx->hogs; !hog->chip_label; hog++) {
+		kfree(hog->chip_label);
+		kfree(hog->line_name);
+	}
+
+	kfree(ctx->hogs);
+	ctx->hogs = NULL;
+}
+
+static int gpio_sim_add_hogs(struct gpio_sim_chip_ctx *chip_ctx)
+{
+	struct gpio_sim_line_ctx *line_ctx;
+	unsigned int num_hogs = 0, idx = 0;
+	struct gpiod_hog *hog;
+
+	list_for_each_entry(line_ctx, &chip_ctx->line_ctx_list, list) {
+		if (line_ctx->hogged)
+			num_hogs++;
+	}
+
+	if (!num_hogs)
+		return 0;
+
+	/* Allocate one more for the sentinel. */
+	chip_ctx->hogs = kcalloc(num_hogs + 1,
+				 sizeof(*chip_ctx->hogs), GFP_KERNEL);
+	if (!chip_ctx->hogs)
+		return -ENOMEM;
+
+	list_for_each_entry(line_ctx, &chip_ctx->line_ctx_list, list) {
+		hog = &chip_ctx->hogs[idx++];
+
+		/*
+		 * We need to make this string manually because at this point
+		 * the device doesn't exist yet and so dev_name() is not
+		 * available.
+		 */
+		hog->chip_label = kasprintf(GFP_KERNEL,
+					    "gpio-sim.%u", chip_ctx->id);
+		if (!hog->chip_label) {
+			gpio_sim_remove_hogs(chip_ctx);
+			return -ENOMEM;
+		}
+
+		/*
+		 * We need to duplicate this because the hog config item can
+		 * be removed at any time (and we can't block it) and gpiolib
+		 * doesn't make a deep copy of the hog data.
+		 */
+		if (line_ctx->hog_name) {
+			hog->line_name = kstrdup(line_ctx->hog_name,
+						 GFP_KERNEL);
+			if (!hog->line_name) {
+				gpio_sim_remove_hogs(chip_ctx);
+				return -ENOMEM;
+			}
+		}
+
+		hog->chip_hwnum = line_ctx->offset;
+		hog->dflags = line_ctx->hog_dir;
+	}
+
+	gpiod_add_hogs(chip_ctx->hogs);
+
+	return 0;
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
+	int ret;
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
+	kfree(line_names);
+	if (IS_ERR(fwnode))
+		return PTR_ERR(fwnode);
+
+	ret = gpio_sim_add_hogs(ctx);
+	if (ret) {
+		fwnode_remove_software_node(fwnode);
+		return ret;
+	}
+
+	pdevinfo.name = "gpio-sim";
+	pdevinfo.fwnode = fwnode;
+	pdevinfo.id = ctx->id;
+
+	reinit_completion(&ctx->probe_completion);
+	ctx->driver_bound = false;
+	bus_register_notifier(&platform_bus_type, &ctx->bus_notifier);
+
+	pdev = platform_device_register_full(&pdevinfo);
+	if (IS_ERR(pdev)) {
+		bus_unregister_notifier(&platform_bus_type, &ctx->bus_notifier);
+		gpio_sim_remove_hogs(ctx);
+		fwnode_remove_software_node(fwnode);
+		return PTR_ERR(pdev);
+	}
+
+	wait_for_completion(&ctx->probe_completion);
+	bus_unregister_notifier(&platform_bus_type, &ctx->bus_notifier);
+
+	if (!ctx->driver_bound) {
+		/* Probe failed, check kernel log. */
+		platform_device_unregister(pdev);
+		gpio_sim_remove_hogs(ctx);
+		fwnode_remove_software_node(fwnode);
+		return -ENXIO;
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
+	gpio_sim_remove_hogs(ctx);
+}
+
+static ssize_t
+gpio_sim_config_chip_live_store(struct config_item *item,
+				const char *page, size_t count)
+{
+	struct gpio_sim_chip_ctx *ctx = gpio_sim_item_to_chip_ctx(item);
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
+	struct gpio_sim_line_ctx *ctx = gpio_sim_item_to_line_ctx(item);
+	int ret;
+
+	mutex_lock(&ctx->parent->lock);
+	ret = sprintf(page, "%s\n", ctx->name ?: "");
+	mutex_unlock(&ctx->parent->lock);
+
+	return ret;
+}
+
+static ssize_t gpio_sim_config_line_name_store(struct config_item *item,
+					       const char *page, size_t count)
+{
+	struct gpio_sim_line_ctx *ctx = gpio_sim_item_to_line_ctx(item);
+	char *trimmed;
+
+	mutex_lock(&ctx->parent->lock);
+
+	if (gpio_sim_chip_live(ctx->parent)) {
+		mutex_unlock(&ctx->parent->lock);
+		return -EBUSY;
+	}
+
+	trimmed = gpio_sim_strdup_trimmed(page, count);
+	if (!trimmed) {
+		mutex_unlock(&ctx->parent->lock);
+		return -ENOMEM;
+	}
+
+	kfree(ctx->name);
+	ctx->name = trimmed;
+
+	mutex_unlock(&ctx->parent->lock);
+
+	return count;
+}
+
+CONFIGFS_ATTR(gpio_sim_config_line_, name);
+
+static struct configfs_attribute *gpio_sim_config_line_attrs[] = {
+	&gpio_sim_config_line_attr_name,
+	NULL,
+};
+
+static ssize_t gpio_sim_config_hog_name_show(struct config_item *item,
+					     char *page)
+{
+	struct gpio_sim_line_ctx *ctx = gpio_sim_hog_item_to_line_ctx(item);
+	int ret;
+
+	mutex_lock(&ctx->parent->lock);
+	ret = sprintf(page, "%s\n", ctx->hog_name ?: "");
+	mutex_unlock(&ctx->parent->lock);
+
+	return ret;
+}
+
+static ssize_t gpio_sim_config_hog_name_store(struct config_item *item,
+					      const char *page, size_t count)
+{
+	struct gpio_sim_line_ctx *ctx = gpio_sim_hog_item_to_line_ctx(item);
+	char *trimmed;
+
+	mutex_lock(&ctx->parent->lock);
+
+	if (gpio_sim_chip_live(ctx->parent)) {
+		mutex_unlock(&ctx->parent->lock);
+		return -EBUSY;
+	}
+
+	trimmed = gpio_sim_strdup_trimmed(page, count);
+	if (!trimmed) {
+		mutex_unlock(&ctx->parent->lock);
+		return -ENOMEM;
+	}
+
+	kfree(ctx->hog_name);
+	ctx->hog_name = trimmed;
+
+	mutex_unlock(&ctx->parent->lock);
+
+	return count;
+}
+
+CONFIGFS_ATTR(gpio_sim_config_hog_, name);
+
+static ssize_t gpio_sim_config_hog_direction_show(struct config_item *item,
+						  char *page)
+{
+	struct gpio_sim_line_ctx *ctx = gpio_sim_hog_item_to_line_ctx(item);
+	char *repr;
+	int dir;
+
+	mutex_lock(&ctx->parent->lock);
+	dir = ctx->hog_dir;
+	mutex_unlock(&ctx->parent->lock);
+
+	switch (dir) {
+	case GPIOD_IN:
+		repr = "input";
+		break;
+	case GPIOD_OUT_HIGH:
+		repr = "output-high";
+		break;
+	case GPIOD_OUT_LOW:
+		repr = "output-low";
+		break;
+	default:
+		WARN(1, "Unexpected hog direction value: %d", dir);
+		break;
+	}
+
+	return sprintf(page, "%s\n", repr);
+}
+
+static ssize_t
+gpio_sim_config_hog_direction_store(struct config_item *item,
+				    const char *page, size_t count)
+{
+	struct gpio_sim_line_ctx *ctx = gpio_sim_hog_item_to_line_ctx(item);
+	char *trimmed;
+	int dir;
+
+	mutex_lock(&ctx->parent->lock);
+
+	if (gpio_sim_chip_live(ctx->parent)) {
+		mutex_unlock(&ctx->parent->lock);
+		return -EBUSY;
+	}
+
+	trimmed = gpio_sim_strdup_trimmed(page, count);
+	if (!trimmed) {
+		mutex_unlock(&ctx->parent->lock);
+		return -ENOMEM;
+	}
+
+	if (strcmp(trimmed, "input") == 0)
+		dir = GPIOD_IN;
+	else if (strcmp(trimmed, "output-high") == 0)
+		dir = GPIOD_OUT_HIGH;
+	else if (strcmp(trimmed, "output-low") == 0)
+		dir = GPIOD_OUT_LOW;
+	else
+		dir = -EINVAL;
+
+	kfree(trimmed);
+
+	if (dir < 0) {
+		mutex_unlock(&ctx->parent->lock);
+		return dir;
+	}
+
+	ctx->hog_dir = dir;
+
+	mutex_unlock(&ctx->parent->lock);
+
+	return count;
+}
+
+CONFIGFS_ATTR(gpio_sim_config_hog_, direction);
+
+static struct configfs_attribute *gpio_sim_config_hog_attrs[] = {
+	&gpio_sim_config_hog_attr_name,
+	&gpio_sim_config_hog_attr_direction,
+	NULL,
+};
+
+static void gpio_sim_config_hog_item_release(struct config_item *item)
+{
+	struct gpio_sim_line_ctx *ctx = gpio_sim_hog_item_to_line_ctx(item);
+
+	mutex_lock(&ctx->parent->lock);
+	ctx->hogged = false;
+	kfree(ctx->hog_name);
+	mutex_unlock(&ctx->parent->lock);
+}
+
+struct configfs_item_operations gpio_sim_config_hog_item_ops = {
+	.release	= gpio_sim_config_hog_item_release,
+};
+
+static const struct config_item_type gpio_sim_config_hog_type = {
+	.ct_item_ops	= &gpio_sim_config_hog_item_ops,
+	.ct_attrs	= gpio_sim_config_hog_attrs,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct config_item *
+gpio_sim_config_make_hog_item(struct config_group *group, const char *name)
+{
+	struct gpio_sim_line_ctx *ctx = gpio_sim_item_to_line_ctx(&group->cg_item);
+	
+	mutex_lock(&ctx->parent->lock);
+
+	ctx->hogged = true;
+	ctx->hog_dir = GPIOD_IN;
+	ctx->hog_name = NULL;
+
+	config_item_init_type_name(&ctx->hog_item, name,
+				   &gpio_sim_config_hog_type);
+
+	mutex_unlock(&ctx->parent->lock);
+
+	return &ctx->hog_item;
+}
+
+static struct config_item *
+gpio_sim_config_make_line_item(struct config_group *group, const char *name)
+{
+	if (strcmp(name, "hog") == 0)
+		return gpio_sim_config_make_hog_item(group, name);
+
+	return ERR_PTR(-EINVAL);
+}
+
+static void gpio_sim_config_line_group_release(struct config_item *item)
+{
+	struct gpio_sim_line_ctx *ctx = gpio_sim_item_to_line_ctx(item);
+
+	mutex_lock(&ctx->parent->lock);
+	list_del(&ctx->list);
+	mutex_unlock(&ctx->parent->lock);
+
+	kfree(ctx->name);
+	kfree(ctx);
+}
+
+static struct configfs_item_operations gpio_sim_config_line_item_ops = {
+	.release	= gpio_sim_config_line_group_release,
+};
+
+static struct configfs_group_operations gpio_sim_config_line_group_ops = {
+	.make_item	= gpio_sim_config_make_line_item,
+};
+
+static const struct config_item_type gpio_sim_config_line_type = {
+	.ct_item_ops	= &gpio_sim_config_line_item_ops,
+	.ct_group_ops	= &gpio_sim_config_line_group_ops,
+	.ct_attrs	= gpio_sim_config_line_attrs,
+	.ct_owner       = THIS_MODULE,
+};
+
+static struct config_group *
+gpio_sim_config_make_line_group(struct config_group *group, const char *name)
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
+	chip_ctx = gpio_sim_item_to_chip_ctx(&group->cg_item);
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
+	config_group_init_type_name(&line_ctx->group, name,
+				    &gpio_sim_config_line_type);
+
+	line_ctx->parent = chip_ctx;
+	line_ctx->offset = offset;
+	list_add_tail(&line_ctx->list, &chip_ctx->line_ctx_list);
+
+	mutex_unlock(&chip_ctx->lock);
+
+	return &line_ctx->group;
+}
+
+static void gpio_sim_config_chip_group_release(struct config_item *item)
+{
+	struct gpio_sim_chip_ctx *ctx = gpio_sim_item_to_chip_ctx(item);
+
+	mutex_lock(&ctx->lock);
+	if (gpio_sim_chip_live(ctx))
+		gpio_sim_deactivate_chip_unlocked(ctx);
+	mutex_unlock(&ctx->lock);
+
+	mutex_destroy(&ctx->lock);
+	ida_free(&gpio_sim_ida, ctx->id);
+	kfree(ctx);
+}
+
+static struct configfs_item_operations gpio_sim_config_chip_item_ops = {
+	.release	= gpio_sim_config_chip_group_release,
+};
+
+static struct configfs_group_operations gpio_sim_config_chip_group_ops = {
+	.make_group	= gpio_sim_config_make_line_group,
+};
+
+static const struct config_item_type gpio_sim_config_chip_group_type = {
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
+				    &gpio_sim_config_chip_group_type);
+	ctx->num_lines = 1;
+	ctx->id = id;
+	mutex_init(&ctx->lock);
+	INIT_LIST_HEAD(&ctx->line_ctx_list);
+
+	ctx->bus_notifier.notifier_call = gpio_sim_bus_notifier_call;
+	init_completion(&ctx->probe_completion);
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

