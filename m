Return-Path: <linux-kselftest+bounces-49126-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 35724D2DD78
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 09:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 732F430B24D1
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 08:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A943309EEA;
	Fri, 16 Jan 2026 08:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deq14Vdg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2602B3093C3;
	Fri, 16 Jan 2026 08:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768551135; cv=none; b=TWXX+ypZJzCHEj6y8IfxEzoEn6g45x6kAOWVTI0UCpBVnOuWNj1slJ/GgEgrCVB3mQldWbPaNHmF+Y/qjeuM16g5SuZJSpA8hPcBDCN1LMjoW27s84OnPnpKOD8aX0o50/9EqwjioztskJlniZi+1OSjdIk23xuUhSM1i/RUBaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768551135; c=relaxed/simple;
	bh=MFKNleTWwG/FcWVtwvNRXbw/dTbJ+FoO/rj4XLMCi0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MR+ialRA+Vbamow2DZ9qLOY4Db4hmjAQY3YCtlWBZpnSEadZPtjk66vtyHQG778JLbHkKs2VGoo+HuvFdtoo5GfP+Kg7a2/eL89j37jamC2rVms1sNL1rfDso2+3whP+ffn0A8Vj9jnjaQlgydauifQnCryCv2WzJ2XI+17RhSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deq14Vdg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D01C19423;
	Fri, 16 Jan 2026 08:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768551134;
	bh=MFKNleTWwG/FcWVtwvNRXbw/dTbJ+FoO/rj4XLMCi0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=deq14VdgjT0MJbqw4YZOrwzdShufh4/jqefOIJmJHMzLpEnVBc1dneLmesQKAF2ZM
	 yXkKWuodw2GBRlccgbfMALZUXWTyf3lPrQSdZvKv6xuJ2z6/WgYkU6V/RgELWsKnXH
	 LX/47aRc+bS3tI+S+i4VUS0T2KUw0aWknlVVLC4emZFyAXIlCGv3xqYnjE5ymWnVpJ
	 e1yhhueQhL+NJlM7qBPdKGemwvZ5ahvlamnj5yMCipQFj+FZSQ2vU9EDGnUynnKIKa
	 5ewSNiClov7dl6gc7bFf/X5eIcLCCzofbK7qCSCP9vVZe9YFpj9Zk6i4SL/bojf19f
	 I+ZbaEoBKpnUg==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linusw@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	tzungbi@kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	linux-gpio@vger.kernel.org
Subject: [PATCH 22/23] gpiolib: Leverage revocable for other independent lifecycle instances
Date: Fri, 16 Jan 2026 08:10:35 +0000
Message-ID: <20260116081036.352286-23-tzungbi@kernel.org>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
In-Reply-To: <20260116081036.352286-1-tzungbi@kernel.org>
References: <20260116081036.352286-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are independent lifecycle instances (e.g., other drivers) can save
a raw pointer to the struct gpio_device (e.g., via gpio_device_find())
or struct gpio_desc (e.g., via gpio_to_desc()).  In some operations,
they have to access the underlying struct gpio_chip.

Leverage revocable for them so that they don't need to handle the
synchronization by accessing the SRCU explicitly.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/gpio/gpiolib-cdev.c  |  10 +-
 drivers/gpio/gpiolib-sysfs.c |  35 +++--
 drivers/gpio/gpiolib.c       | 241 ++++++++++++++++++++---------------
 drivers/gpio/gpiolib.h       |  21 ---
 4 files changed, 163 insertions(+), 144 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 1a4dde56dc0c..ecb1472b5c8f 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2252,9 +2252,11 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
 	u32 debounce_period_us;
 	unsigned long dflags;
 	const char *label;
+	struct gpio_chip *gc;
+	DEFINE_REVOCABLE(rev, desc->gdev->chip_rp);
 
-	CLASS(gpio_chip_guard, guard)(desc);
-	if (!guard.gc)
+	REVOCABLE_TRY_ACCESS_WITH(rev, gc);
+	if (!gc)
 		return;
 
 	memset(info, 0, sizeof(*info));
@@ -2288,10 +2290,10 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
 	    test_bit(GPIOD_FLAG_IS_HOGGED, &dflags) ||
 	    test_bit(GPIOD_FLAG_EXPORT, &dflags) ||
 	    test_bit(GPIOD_FLAG_SYSFS, &dflags) ||
-	    !gpiochip_line_is_valid(guard.gc, info->offset)) {
+	    !gpiochip_line_is_valid(gc, info->offset)) {
 		info->flags |= GPIO_V2_LINE_FLAG_USED;
 	} else if (!atomic) {
-		if (!pinctrl_gpio_can_use_line(guard.gc, info->offset))
+		if (!pinctrl_gpio_can_use_line(gc, info->offset))
 			info->flags |= GPIO_V2_LINE_FLAG_USED;
 	}
 
diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index a4427a5cfa85..bc8d4af73cc3 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -215,9 +215,11 @@ static int gpio_sysfs_request_irq(struct gpiod_data *data, unsigned char flags)
 	struct gpio_desc *desc = data->desc;
 	unsigned long irq_flags;
 	int ret;
+	struct gpio_chip *gc;
+	DEFINE_REVOCABLE(rev, desc->gdev->chip_rp);
 
-	CLASS(gpio_chip_guard, guard)(desc);
-	if (!guard.gc)
+	REVOCABLE_TRY_ACCESS_WITH(rev, gc);
+	if (!gc)
 		return -ENODEV;
 
 	data->irq = gpiod_to_irq(desc);
@@ -244,7 +246,7 @@ static int gpio_sysfs_request_irq(struct gpiod_data *data, unsigned char flags)
 	 * Remove this redundant call (along with the corresponding unlock)
 	 * when those drivers have been fixed.
 	 */
-	ret = gpiochip_lock_as_irq(guard.gc, gpiod_hwgpio(desc));
+	ret = gpiochip_lock_as_irq(gc, gpiod_hwgpio(desc));
 	if (ret < 0)
 		goto err_clr_bits;
 
@@ -258,7 +260,7 @@ static int gpio_sysfs_request_irq(struct gpiod_data *data, unsigned char flags)
 	return 0;
 
 err_unlock:
-	gpiochip_unlock_as_irq(guard.gc, gpiod_hwgpio(desc));
+	gpiochip_unlock_as_irq(gc, gpiod_hwgpio(desc));
 err_clr_bits:
 	clear_bit(GPIOD_FLAG_EDGE_RISING, &desc->flags);
 	clear_bit(GPIOD_FLAG_EDGE_FALLING, &desc->flags);
@@ -273,14 +275,16 @@ static int gpio_sysfs_request_irq(struct gpiod_data *data, unsigned char flags)
 static void gpio_sysfs_free_irq(struct gpiod_data *data)
 {
 	struct gpio_desc *desc = data->desc;
+	struct gpio_chip *gc;
+	DEFINE_REVOCABLE(rev, desc->gdev->chip_rp);
 
-	CLASS(gpio_chip_guard, guard)(desc);
-	if (!guard.gc)
+	REVOCABLE_TRY_ACCESS_WITH(rev, gc);
+	if (!gc)
 		return;
 
 	data->irq_flags = 0;
 	free_irq(data->irq, data);
-	gpiochip_unlock_as_irq(guard.gc, gpiod_hwgpio(desc));
+	gpiochip_unlock_as_irq(gc, gpiod_hwgpio(desc));
 	clear_bit(GPIOD_FLAG_EDGE_RISING, &desc->flags);
 	clear_bit(GPIOD_FLAG_EDGE_FALLING, &desc->flags);
 }
@@ -473,13 +477,15 @@ static DEVICE_ATTR_RO(ngpio);
 static int export_gpio_desc(struct gpio_desc *desc)
 {
 	int offset, ret;
+	struct gpio_chip *gc;
+	DEFINE_REVOCABLE(rev, desc->gdev->chip_rp);
 
-	CLASS(gpio_chip_guard, guard)(desc);
-	if (!guard.gc)
+	REVOCABLE_TRY_ACCESS_WITH(rev, gc);
+	if (!gc)
 		return -ENODEV;
 
 	offset = gpiod_hwgpio(desc);
-	if (!gpiochip_line_is_valid(guard.gc, offset)) {
+	if (!gpiochip_line_is_valid(gc, offset)) {
 		pr_debug_ratelimited("%s: GPIO %d masked\n", __func__,
 				     gpiod_hwgpio(desc));
 		return -EINVAL;
@@ -732,6 +738,7 @@ int gpiod_export(struct gpio_desc *desc, bool direction_may_change)
 	struct gpio_device *gdev;
 	struct attribute **attrs;
 	int status;
+	struct gpio_chip *gc;
 
 	/* can't export until sysfs is available ... */
 	if (!class_is_registered(&gpio_class)) {
@@ -744,8 +751,10 @@ int gpiod_export(struct gpio_desc *desc, bool direction_may_change)
 		return -EINVAL;
 	}
 
-	CLASS(gpio_chip_guard, guard)(desc);
-	if (!guard.gc)
+	DEFINE_REVOCABLE(rev, desc->gdev->chip_rp);
+
+	REVOCABLE_TRY_ACCESS_WITH(rev, gc);
+	if (!gc)
 		return -ENODEV;
 
 	if (test_and_set_bit(GPIOD_FLAG_EXPORT, &desc->flags))
@@ -769,7 +778,7 @@ int gpiod_export(struct gpio_desc *desc, bool direction_may_change)
 
 	desc_data->desc = desc;
 	mutex_init(&desc_data->mutex);
-	if (guard.gc->direction_input && guard.gc->direction_output)
+	if (gc->direction_input && gc->direction_output)
 		desc_data->direction_can_change = direction_may_change;
 	else
 		desc_data->direction_can_change = false;
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index cd18ff42b610..44915c8b6131 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -338,7 +338,11 @@ EXPORT_SYMBOL(gpio_device_get_label);
  */
 struct gpio_chip *gpio_device_get_chip(struct gpio_device *gdev)
 {
-	return rcu_dereference_check(gdev->chip, 1);
+	struct gpio_chip *gc;
+	DEFINE_REVOCABLE(rev, gdev->chip_rp);
+
+	REVOCABLE_TRY_ACCESS_WITH(rev, gc);
+	return gc;
 }
 EXPORT_SYMBOL_GPL(gpio_device_get_chip);
 
@@ -449,13 +453,16 @@ int gpiod_get_direction(struct gpio_desc *desc)
 	unsigned long flags;
 	unsigned int offset;
 	int ret;
+	struct gpio_chip *gc;
 
 	ret = validate_desc(desc, __func__);
 	if (ret <= 0)
 		return -EINVAL;
 
-	CLASS(gpio_chip_guard, guard)(desc);
-	if (!guard.gc)
+	DEFINE_REVOCABLE(rev, desc->gdev->chip_rp);
+
+	REVOCABLE_TRY_ACCESS_WITH(rev, gc);
+	if (!gc)
 		return -ENODEV;
 
 	offset = gpiod_hwgpio(desc);
@@ -469,7 +476,7 @@ int gpiod_get_direction(struct gpio_desc *desc)
 	    test_bit(GPIOD_FLAG_IS_OUT, &flags))
 		return 0;
 
-	ret = gpiochip_get_direction(guard.gc, offset);
+	ret = gpiochip_get_direction(gc, offset);
 	if (ret < 0)
 		return ret;
 
@@ -557,9 +564,9 @@ static struct gpio_desc *gpio_name_to_desc(const char * const name)
 
 	list_for_each_entry_srcu(gdev, &gpio_devices, list,
 				 srcu_read_lock_held(&gpio_devices_srcu)) {
-		guard(srcu)(&gdev->srcu);
+		DEFINE_REVOCABLE(rev, gdev->chip_rp);
 
-		gc = srcu_dereference(gdev->chip, &gdev->srcu);
+		REVOCABLE_TRY_ACCESS_WITH(rev, gc);
 		if (!gc)
 			continue;
 
@@ -971,9 +978,9 @@ static void gpiochip_setup_devs(void)
 
 	list_for_each_entry_srcu(gdev, &gpio_devices, list,
 				 srcu_read_lock_held(&gpio_devices_srcu)) {
-		guard(srcu)(&gdev->srcu);
+		DEFINE_REVOCABLE(rev, gdev->chip_rp);
 
-		gc = srcu_dereference(gdev->chip, &gdev->srcu);
+		REVOCABLE_TRY_ACCESS_WITH(rev, gc);
 		if (!gc) {
 			dev_err(&gdev->dev, "Underlying GPIO chip is gone\n");
 			continue;
@@ -1386,11 +1393,13 @@ struct gpio_device *gpio_device_find(const void *data,
 		if (!device_is_registered(&gdev->dev))
 			continue;
 
-		guard(srcu)(&gdev->srcu);
+		DEFINE_REVOCABLE(rev, gdev->chip_rp);
 
-		gc = srcu_dereference(gdev->chip, &gdev->srcu);
+		REVOCABLE_TRY_ACCESS_WITH(rev, gc);
+		if (!gc)
+			continue;
 
-		if (gc && match(gc, data))
+		if (match(gc, data))
 			return gpio_device_get(gdev);
 	}
 
@@ -2482,31 +2491,33 @@ static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
 {
 	unsigned int offset;
 	int ret;
+	struct gpio_chip *gc;
+	DEFINE_REVOCABLE(rev, desc->gdev->chip_rp);
 
-	CLASS(gpio_chip_guard, guard)(desc);
-	if (!guard.gc)
+	REVOCABLE_TRY_ACCESS_WITH(rev, gc);
+	if (!gc)
 		return -ENODEV;
 
 	if (test_and_set_bit(GPIOD_FLAG_REQUESTED, &desc->flags))
 		return -EBUSY;
 
 	offset = gpiod_hwgpio(desc);
-	if (!gpiochip_line_is_valid(guard.gc, offset))
+	if (!gpiochip_line_is_valid(gc, offset))
 		return -EINVAL;
 
 	/* NOTE:  gpio_request() can be called in early boot,
 	 * before IRQs are enabled, for non-sleeping (SOC) GPIOs.
 	 */
 
-	if (guard.gc->request) {
-		ret = guard.gc->request(guard.gc, offset);
+	if (gc->request) {
+		ret = gc->request(gc, offset);
 		if (ret > 0)
 			ret = -EBADE;
 		if (ret)
 			goto out_clear_bit;
 	}
 
-	if (guard.gc->get_direction)
+	if (gc->get_direction)
 		gpiod_get_direction(desc);
 
 	ret = desc_set_label(desc, label ? : "?");
@@ -2543,16 +2554,21 @@ int gpiod_request(struct gpio_desc *desc, const char *label)
 static void gpiod_free_commit(struct gpio_desc *desc)
 {
 	unsigned long flags;
+	struct gpio_chip *gc;
 
 	might_sleep();
 
-	CLASS(gpio_chip_guard, guard)(desc);
+	DEFINE_REVOCABLE(rev, desc->gdev->chip_rp);
+
+	REVOCABLE_TRY_ACCESS_WITH(rev, gc);
+	if (!gc)
+		return;
 
 	flags = READ_ONCE(desc->flags);
 
-	if (guard.gc && test_bit(GPIOD_FLAG_REQUESTED, &flags)) {
-		if (guard.gc->free)
-			guard.gc->free(guard.gc, gpiod_hwgpio(desc));
+	if (gc && test_bit(GPIOD_FLAG_REQUESTED, &flags)) {
+		if (gc->free)
+			gc->free(gc, gpiod_hwgpio(desc));
 
 		clear_bit(GPIOD_FLAG_ACTIVE_LOW, &flags);
 		clear_bit(GPIOD_FLAG_REQUESTED, &flags);
@@ -2704,15 +2720,17 @@ EXPORT_SYMBOL_GPL(gpiochip_free_own_desc);
 int gpio_do_set_config(struct gpio_desc *desc, unsigned long config)
 {
 	int ret;
+	struct gpio_chip *gc;
+	DEFINE_REVOCABLE(rev, desc->gdev->chip_rp);
 
-	CLASS(gpio_chip_guard, guard)(desc);
-	if (!guard.gc)
+	REVOCABLE_TRY_ACCESS_WITH(rev, gc);
+	if (!gc)
 		return -ENODEV;
 
-	if (!guard.gc->set_config)
+	if (!gc->set_config)
 		return -ENOTSUPP;
 
-	ret = guard.gc->set_config(guard.gc, gpiod_hwgpio(desc), config);
+	ret = gc->set_config(gc, gpiod_hwgpio(desc), config);
 	if (ret > 0)
 		ret = -EBADE;
 
@@ -2881,9 +2899,11 @@ EXPORT_SYMBOL_GPL(gpiod_direction_input);
 int gpiod_direction_input_nonotify(struct gpio_desc *desc)
 {
 	int ret = 0, dir;
+	struct gpio_chip *gc;
+	DEFINE_REVOCABLE(rev, desc->gdev->chip_rp);
 
-	CLASS(gpio_chip_guard, guard)(desc);
-	if (!guard.gc)
+	REVOCABLE_TRY_ACCESS_WITH(rev, gc);
+	if (!gc)
 		return -ENODEV;
 
 	/*
@@ -2891,7 +2911,7 @@ int gpiod_direction_input_nonotify(struct gpio_desc *desc)
 	 * the chip is output-only, but you can't specify .direction_input()
 	 * and not support the .get() operation, that doesn't make sense.
 	 */
-	if (!guard.gc->get && guard.gc->direction_input) {
+	if (!gc->get && gc->direction_input) {
 		gpiod_warn(desc,
 			   "%s: missing get() but have direction_input()\n",
 			   __func__);
@@ -2904,11 +2924,10 @@ int gpiod_direction_input_nonotify(struct gpio_desc *desc)
 	 * direction (if .get_direction() is supported) else we silently
 	 * assume we are in input mode after this.
 	 */
-	if (guard.gc->direction_input) {
-		ret = gpiochip_direction_input(guard.gc,
-					       gpiod_hwgpio(desc));
-	} else if (guard.gc->get_direction) {
-		dir = gpiochip_get_direction(guard.gc, gpiod_hwgpio(desc));
+	if (gc->direction_input) {
+		ret = gpiochip_direction_input(gc, gpiod_hwgpio(desc));
+	} else if (gc->get_direction) {
+		dir = gpiochip_get_direction(gc, gpiod_hwgpio(desc));
 		if (dir < 0)
 			return dir;
 
@@ -2948,9 +2967,11 @@ static int gpiochip_set(struct gpio_chip *gc, unsigned int offset, int value)
 static int gpiod_direction_output_raw_commit(struct gpio_desc *desc, int value)
 {
 	int val = !!value, ret = 0, dir;
+	struct gpio_chip *gc;
+	DEFINE_REVOCABLE(rev, desc->gdev->chip_rp);
 
-	CLASS(gpio_chip_guard, guard)(desc);
-	if (!guard.gc)
+	REVOCABLE_TRY_ACCESS_WITH(rev, gc);
+	if (!gc)
 		return -ENODEV;
 
 	/*
@@ -2958,21 +2979,19 @@ static int gpiod_direction_output_raw_commit(struct gpio_desc *desc, int value)
 	 * output-only, but if there is then not even a .set() operation it
 	 * is pretty tricky to drive the output line.
 	 */
-	if (!guard.gc->set && !guard.gc->direction_output) {
+	if (!gc->set && !gc->direction_output) {
 		gpiod_warn(desc,
 			   "%s: missing set() and direction_output() operations\n",
 			   __func__);
 		return -EIO;
 	}
 
-	if (guard.gc->direction_output) {
-		ret = gpiochip_direction_output(guard.gc,
-						gpiod_hwgpio(desc), val);
+	if (gc->direction_output) {
+		ret = gpiochip_direction_output(gc, gpiod_hwgpio(desc), val);
 	} else {
 		/* Check that we are in output mode if we can */
-		if (guard.gc->get_direction) {
-			dir = gpiochip_get_direction(guard.gc,
-						     gpiod_hwgpio(desc));
+		if (gc->get_direction) {
+			dir = gpiochip_get_direction(gc, gpiod_hwgpio(desc));
 			if (dir < 0)
 				return dir;
 
@@ -2987,7 +3006,7 @@ static int gpiod_direction_output_raw_commit(struct gpio_desc *desc, int value)
 		 * If we can't actively set the direction, we are some
 		 * output-only chip, so just drive the output as desired.
 		 */
-		ret = gpiochip_set(guard.gc, gpiod_hwgpio(desc), val);
+		ret = gpiochip_set(gc, gpiod_hwgpio(desc), val);
 		if (ret)
 			return ret;
 	}
@@ -3125,20 +3144,22 @@ int gpiod_direction_output_nonotify(struct gpio_desc *desc, int value)
 int gpiod_enable_hw_timestamp_ns(struct gpio_desc *desc, unsigned long flags)
 {
 	int ret;
+	struct gpio_chip *gc;
 
 	VALIDATE_DESC(desc);
 
-	CLASS(gpio_chip_guard, guard)(desc);
-	if (!guard.gc)
+	DEFINE_REVOCABLE(rev, desc->gdev->chip_rp);
+
+	REVOCABLE_TRY_ACCESS_WITH(rev, gc);
+	if (!gc)
 		return -ENODEV;
 
-	if (!guard.gc->en_hw_timestamp) {
+	if (!gc->en_hw_timestamp) {
 		gpiod_warn(desc, "%s: hw ts not supported\n", __func__);
 		return -ENOTSUPP;
 	}
 
-	ret = guard.gc->en_hw_timestamp(guard.gc,
-					gpiod_hwgpio(desc), flags);
+	ret = gc->en_hw_timestamp(gc, gpiod_hwgpio(desc), flags);
 	if (ret)
 		gpiod_warn(desc, "%s: hw ts request failed\n", __func__);
 
@@ -3158,20 +3179,22 @@ EXPORT_SYMBOL_GPL(gpiod_enable_hw_timestamp_ns);
 int gpiod_disable_hw_timestamp_ns(struct gpio_desc *desc, unsigned long flags)
 {
 	int ret;
+	struct gpio_chip *gc;
 
 	VALIDATE_DESC(desc);
 
-	CLASS(gpio_chip_guard, guard)(desc);
-	if (!guard.gc)
+	DEFINE_REVOCABLE(rev, desc->gdev->chip_rp);
+
+	REVOCABLE_TRY_ACCESS_WITH(rev, gc);
+	if (!gc)
 		return -ENODEV;
 
-	if (!guard.gc->dis_hw_timestamp) {
+	if (!gc->dis_hw_timestamp) {
 		gpiod_warn(desc, "%s: hw ts not supported\n", __func__);
 		return -ENOTSUPP;
 	}
 
-	ret = guard.gc->dis_hw_timestamp(guard.gc, gpiod_hwgpio(desc),
-					 flags);
+	ret = gc->dis_hw_timestamp(gc, gpiod_hwgpio(desc), flags);
 	if (ret)
 		gpiod_warn(desc, "%s: hw ts release failed\n", __func__);
 
@@ -3328,16 +3351,11 @@ static int gpio_chip_get_value(struct gpio_chip *gc, const struct gpio_desc *des
 
 static int gpiod_get_raw_value_commit(const struct gpio_desc *desc)
 {
-	struct gpio_device *gdev;
 	struct gpio_chip *gc;
 	int value;
+	DEFINE_REVOCABLE(rev, desc->gdev->chip_rp);
 
-	/* FIXME Unable to use gpio_chip_guard due to const desc. */
-	gdev = desc->gdev;
-
-	guard(srcu)(&gdev->srcu);
-
-	gc = srcu_dereference(gdev->chip, &gdev->srcu);
+	REVOCABLE_TRY_ACCESS_WITH(rev, gc);
 	if (!gc)
 		return -ENODEV;
 
@@ -3378,9 +3396,11 @@ static int gpio_chip_get_multiple(struct gpio_chip *gc,
 /* The 'other' chip must be protected with its GPIO device's SRCU. */
 static bool gpio_device_chip_cmp(struct gpio_device *gdev, struct gpio_chip *gc)
 {
-	guard(srcu)(&gdev->srcu);
+	struct gpio_chip *chip;
+	DEFINE_REVOCABLE(rev, gdev->chip_rp);
 
-	return gc == srcu_dereference(gdev->chip, &gdev->srcu);
+	REVOCABLE_TRY_ACCESS_WITH(rev, chip);
+	return chip ? chip == gc : false;
 }
 
 int gpiod_get_array_value_complex(bool raw, bool can_sleep,
@@ -3403,9 +3423,9 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 		if (!can_sleep)
 			WARN_ON(array_info->gdev->can_sleep);
 
-		guard(srcu)(&array_info->gdev->srcu);
-		gc = srcu_dereference(array_info->gdev->chip,
-				      &array_info->gdev->srcu);
+		DEFINE_REVOCABLE(rev, array_info->gdev->chip_rp);
+
+		REVOCABLE_TRY_ACCESS_WITH(rev, gc);
 		if (!gc)
 			return -ENODEV;
 
@@ -3430,32 +3450,33 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 		DECLARE_BITMAP(fastpath_bits, FASTPATH_NGPIO);
 		unsigned long *mask, *bits;
 		int first, j;
+		DEFINE_REVOCABLE(rev, desc_array[i]->gdev->chip_rp);
 
-		CLASS(gpio_chip_guard, guard)(desc_array[i]);
-		if (!guard.gc)
+		REVOCABLE_TRY_ACCESS_WITH(rev, gc);
+		if (!gc)
 			return -ENODEV;
 
-		if (likely(guard.gc->ngpio <= FASTPATH_NGPIO)) {
+		if (likely(gc->ngpio <= FASTPATH_NGPIO)) {
 			mask = fastpath_mask;
 			bits = fastpath_bits;
 		} else {
 			gfp_t flags = can_sleep ? GFP_KERNEL : GFP_ATOMIC;
 
-			mask = bitmap_alloc(guard.gc->ngpio, flags);
+			mask = bitmap_alloc(gc->ngpio, flags);
 			if (!mask)
 				return -ENOMEM;
 
-			bits = bitmap_alloc(guard.gc->ngpio, flags);
+			bits = bitmap_alloc(gc->ngpio, flags);
 			if (!bits) {
 				bitmap_free(mask);
 				return -ENOMEM;
 			}
 		}
 
-		bitmap_zero(mask, guard.gc->ngpio);
+		bitmap_zero(mask, gc->ngpio);
 
 		if (!can_sleep)
-			WARN_ON(guard.gc->can_sleep);
+			WARN_ON(gc->can_sleep);
 
 		/* collect all inputs belonging to the same chip */
 		first = i;
@@ -3470,9 +3491,9 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 				i = find_next_zero_bit(array_info->get_mask,
 						       array_size, i);
 		} while ((i < array_size) &&
-			 gpio_device_chip_cmp(desc_array[i]->gdev, guard.gc));
+			 gpio_device_chip_cmp(desc_array[i]->gdev, gc));
 
-		ret = gpio_chip_get_multiple(guard.gc, mask, bits);
+		ret = gpio_chip_get_multiple(gc, mask, bits);
 		if (ret) {
 			if (mask != fastpath_mask)
 				bitmap_free(mask);
@@ -3621,15 +3642,17 @@ EXPORT_SYMBOL_GPL(gpiod_get_array_value);
 static int gpio_set_open_drain_value_commit(struct gpio_desc *desc, bool value)
 {
 	int ret = 0, offset = gpiod_hwgpio(desc);
+	struct gpio_chip *gc;
+	DEFINE_REVOCABLE(rev, desc->gdev->chip_rp);
 
-	CLASS(gpio_chip_guard, guard)(desc);
-	if (!guard.gc)
+	REVOCABLE_TRY_ACCESS_WITH(rev, gc);
+	if (!gc)
 		return -ENODEV;
 
 	if (value) {
-		ret = gpiochip_direction_input(guard.gc, offset);
+		ret = gpiochip_direction_input(gc, offset);
 	} else {
-		ret = gpiochip_direction_output(guard.gc, offset, 0);
+		ret = gpiochip_direction_output(gc, offset, 0);
 		if (!ret)
 			set_bit(GPIOD_FLAG_IS_OUT, &desc->flags);
 	}
@@ -3650,17 +3673,19 @@ static int gpio_set_open_drain_value_commit(struct gpio_desc *desc, bool value)
 static int gpio_set_open_source_value_commit(struct gpio_desc *desc, bool value)
 {
 	int ret = 0, offset = gpiod_hwgpio(desc);
+	struct gpio_chip *gc;
+	DEFINE_REVOCABLE(rev, desc->gdev->chip_rp);
 
-	CLASS(gpio_chip_guard, guard)(desc);
-	if (!guard.gc)
+	REVOCABLE_TRY_ACCESS_WITH(rev, gc);
+	if (!gc)
 		return -ENODEV;
 
 	if (value) {
-		ret = gpiochip_direction_output(guard.gc, offset, 1);
+		ret = gpiochip_direction_output(gc, offset, 1);
 		if (!ret)
 			set_bit(GPIOD_FLAG_IS_OUT, &desc->flags);
 	} else {
-		ret = gpiochip_direction_input(guard.gc, offset);
+		ret = gpiochip_direction_input(gc, offset);
 	}
 	trace_gpio_direction(desc_to_gpio(desc), !value, ret);
 	if (ret < 0)
@@ -3673,15 +3698,19 @@ static int gpio_set_open_source_value_commit(struct gpio_desc *desc, bool value)
 
 static int gpiod_set_raw_value_commit(struct gpio_desc *desc, bool value)
 {
+	struct gpio_chip *gc;
+
 	if (unlikely(!test_bit(GPIOD_FLAG_IS_OUT, &desc->flags)))
 		return -EPERM;
 
-	CLASS(gpio_chip_guard, guard)(desc);
-	if (!guard.gc)
+	DEFINE_REVOCABLE(rev, desc->gdev->chip_rp);
+
+	REVOCABLE_TRY_ACCESS_WITH(rev, gc);
+	if (!gc)
 		return -ENODEV;
 
 	trace_gpio_value(desc_to_gpio(desc), 0, value);
-	return gpiochip_set(guard.gc, gpiod_hwgpio(desc), value);
+	return gpiochip_set(gc, gpiod_hwgpio(desc), value);
 }
 
 /*
@@ -3748,9 +3777,9 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 				return -EPERM;
 		}
 
-		guard(srcu)(&array_info->gdev->srcu);
-		gc = srcu_dereference(array_info->gdev->chip,
-				      &array_info->gdev->srcu);
+		DEFINE_REVOCABLE(rev, array_info->gdev->chip_rp);
+
+		REVOCABLE_TRY_ACCESS_WITH(rev, gc);
 		if (!gc)
 			return -ENODEV;
 
@@ -3775,32 +3804,33 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 		DECLARE_BITMAP(fastpath_bits, FASTPATH_NGPIO);
 		unsigned long *mask, *bits;
 		int count = 0;
+		DEFINE_REVOCABLE(rev, desc_array[i]->gdev->chip_rp);
 
-		CLASS(gpio_chip_guard, guard)(desc_array[i]);
-		if (!guard.gc)
+		REVOCABLE_TRY_ACCESS_WITH(rev, gc);
+		if (!gc)
 			return -ENODEV;
 
-		if (likely(guard.gc->ngpio <= FASTPATH_NGPIO)) {
+		if (likely(gc->ngpio <= FASTPATH_NGPIO)) {
 			mask = fastpath_mask;
 			bits = fastpath_bits;
 		} else {
 			gfp_t flags = can_sleep ? GFP_KERNEL : GFP_ATOMIC;
 
-			mask = bitmap_alloc(guard.gc->ngpio, flags);
+			mask = bitmap_alloc(gc->ngpio, flags);
 			if (!mask)
 				return -ENOMEM;
 
-			bits = bitmap_alloc(guard.gc->ngpio, flags);
+			bits = bitmap_alloc(gc->ngpio, flags);
 			if (!bits) {
 				bitmap_free(mask);
 				return -ENOMEM;
 			}
 		}
 
-		bitmap_zero(mask, guard.gc->ngpio);
+		bitmap_zero(mask, gc->ngpio);
 
 		if (!can_sleep)
-			WARN_ON(guard.gc->can_sleep);
+			WARN_ON(gc->can_sleep);
 
 		do {
 			struct gpio_desc *desc = desc_array[i];
@@ -3839,10 +3869,10 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 				i = find_next_zero_bit(array_info->set_mask,
 						       array_size, i);
 		} while ((i < array_size) &&
-			 gpio_device_chip_cmp(desc_array[i]->gdev, guard.gc));
+			 gpio_device_chip_cmp(desc_array[i]->gdev, gc));
 		/* push collected bits to outputs */
 		if (count != 0) {
-			ret = gpiochip_set_multiple(guard.gc, mask, bits);
+			ret = gpiochip_set_multiple(gc, mask, bits);
 			if (ret)
 				return ret;
 		}
@@ -4048,7 +4078,6 @@ EXPORT_SYMBOL_GPL(gpiod_is_shared);
  */
 int gpiod_to_irq(const struct gpio_desc *desc)
 {
-	struct gpio_device *gdev;
 	struct gpio_chip *gc;
 	int offset;
 	int ret;
@@ -4057,10 +4086,9 @@ int gpiod_to_irq(const struct gpio_desc *desc)
 	if (ret <= 0)
 		return -EINVAL;
 
-	gdev = desc->gdev;
-	/* FIXME Cannot use gpio_chip_guard due to const desc. */
-	guard(srcu)(&gdev->srcu);
-	gc = srcu_dereference(gdev->chip, &gdev->srcu);
+	DEFINE_REVOCABLE(rev, desc->gdev->chip_rp);
+
+	REVOCABLE_TRY_ACCESS_WITH(rev, gc);
 	if (!gc)
 		return -ENODEV;
 
@@ -5058,9 +5086,11 @@ int gpiod_hog(struct gpio_desc *desc, const char *name,
 	struct gpio_desc *local_desc;
 	int hwnum;
 	int ret;
+	struct gpio_chip *gc;
+	DEFINE_REVOCABLE(rev, desc->gdev->chip_rp);
 
-	CLASS(gpio_chip_guard, guard)(desc);
-	if (!guard.gc)
+	REVOCABLE_TRY_ACCESS_WITH(rev, gc);
+	if (!gc)
 		return -ENODEV;
 
 	if (test_and_set_bit(GPIOD_FLAG_IS_HOGGED, &desc->flags))
@@ -5068,8 +5098,7 @@ int gpiod_hog(struct gpio_desc *desc, const char *name,
 
 	hwnum = gpiod_hwgpio(desc);
 
-	local_desc = gpiochip_request_own_desc(guard.gc, hwnum, name,
-					       lflags, dflags);
+	local_desc = gpiochip_request_own_desc(gc, hwnum, name, lflags, dflags);
 	if (IS_ERR(local_desc)) {
 		clear_bit(GPIOD_FLAG_IS_HOGGED, &desc->flags);
 		ret = PTR_ERR(local_desc);
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index e61db3a75e84..00aa354950c9 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -224,27 +224,6 @@ struct gpio_desc {
 
 #define gpiod_not_found(desc)		(IS_ERR(desc) && PTR_ERR(desc) == -ENOENT)
 
-struct gpio_chip_guard {
-	struct gpio_device *gdev;
-	struct gpio_chip *gc;
-	int idx;
-};
-
-DEFINE_CLASS(gpio_chip_guard,
-	     struct gpio_chip_guard,
-	     srcu_read_unlock(&_T.gdev->srcu, _T.idx),
-	     ({
-		struct gpio_chip_guard _guard;
-
-		_guard.gdev = desc->gdev;
-		_guard.idx = srcu_read_lock(&_guard.gdev->srcu);
-		_guard.gc = srcu_dereference(_guard.gdev->chip,
-					     &_guard.gdev->srcu);
-
-		_guard;
-	     }),
-	     struct gpio_desc *desc)
-
 int gpiod_request(struct gpio_desc *desc, const char *label);
 void gpiod_free(struct gpio_desc *desc);
 
-- 
2.52.0.457.g6b5491de43-goog


