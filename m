Return-Path: <linux-kselftest+bounces-49113-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E151D2DD71
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 09:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2286310EAEF
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 08:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC0A2F39B8;
	Fri, 16 Jan 2026 08:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwSeG9KG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3767E2F1FED;
	Fri, 16 Jan 2026 08:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768551099; cv=none; b=lZgPqet0ahQFd+ch1sADqJvD+MDA1LGtcwEdFM5JWw3ALMcmiPCvT+7OqpTkHSKdF7qtwfue+2HnPbAcH/Gy/k5SscGgqIBm75ffmMzKvkBPQm/eTGKm1Wl79XvzJaNSQQz8I7lK4yg62p9UG0RwpHQLIXw9XuOxAOZkay4koKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768551099; c=relaxed/simple;
	bh=jLMk5jOJOkev2PV84zit/QMXNzAOhBT5t5NGWW6kN1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VwDinA8fFQnmvGyb6ro9Xing1Hzkj5DQzKfRKXDcIyXAUgWoZ1MOSzjQl2Wmaxc+72aPz/SG5rXngXZ3IkXzappSc6f7trkMvxeA2tzu91zxihWhUWuUCiWl01LYxUBZ4UfpxpBWeJ2fBec02ftEizYc1uZ/5cwZNlqSIz6ULSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwSeG9KG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B07C19424;
	Fri, 16 Jan 2026 08:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768551094;
	bh=jLMk5jOJOkev2PV84zit/QMXNzAOhBT5t5NGWW6kN1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VwSeG9KGz+NSfpCSbFrHx8huxGYLoqGEUfZTatUs+S5y0CYu1/qqCZaynn4ONvoO5
	 TiizBFloJolOsH4gMyn3KovNqIo6umaVIcCgMoeP9VXLgqqf/jmdHG4v5e6Hj1ufik
	 L9mSZxN6KjIDaNfBClBbLAJ5+1IyCfqumyDhCJVzfS3ypaiUqytzYik9VONSwhPxaw
	 X4buW/2SgahdGC7T4JRjKg36K7VZtRXGoiJ7ozmKr2eQq1yCtj/jSU4KdNm+4S09jf
	 Z4NbjXMRkTeuYYkQrVt1FIeUjHvG4HczhU+14ONaRagdDSuBoojyxQtv4daoxx189H
	 LUCs9VFNOPZ5A==
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
Subject: [PATCH 09/23] gpiolib: Ensure struct gpio_chip for gpiochip_setup_dev()
Date: Fri, 16 Jan 2026 08:10:22 +0000
Message-ID: <20260116081036.352286-10-tzungbi@kernel.org>
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

Ensure struct gpio_chip for gpiochip_setup_dev().  This eliminates a few
checks for struct gpio_chip.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/gpio/gpiolib-cdev.c  | 13 ++-----------
 drivers/gpio/gpiolib-cdev.h  |  3 ++-
 drivers/gpio/gpiolib-sysfs.c | 11 ++---------
 drivers/gpio/gpiolib-sysfs.h |  5 +++--
 drivers/gpio/gpiolib.c       | 24 +++++++++++++++++-------
 5 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 66bd260c68e9..24449bbe38c9 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2784,9 +2784,9 @@ static const struct file_operations gpio_fileops = {
 #endif
 };
 
-int gpiolib_cdev_register(struct gpio_device *gdev, dev_t devt)
+int gpiolib_cdev_register(struct gpio_device *gdev, struct gpio_chip *gc,
+			  dev_t devt)
 {
-	struct gpio_chip *gc;
 	int ret;
 
 	cdev_init(&gdev->chrdev, &gpio_fileops);
@@ -2802,18 +2802,9 @@ int gpiolib_cdev_register(struct gpio_device *gdev, dev_t devt)
 	if (ret)
 		goto err_free_workqueue;
 
-	guard(srcu)(&gdev->srcu);
-	gc = srcu_dereference(gdev->chip, &gdev->srcu);
-	if (!gc) {
-		ret = -ENODEV;
-		goto err_free_cdev;
-	}
-
 	gpiochip_dbg(gc, "added GPIO chardev (%d:%d)\n", MAJOR(devt), gdev->id);
 
 	return 0;
-err_free_cdev:
-	cdev_device_del(&gdev->chrdev, &gdev->dev);
 err_free_workqueue:
 	destroy_workqueue(gdev->line_state_wq);
 	return ret;
diff --git a/drivers/gpio/gpiolib-cdev.h b/drivers/gpio/gpiolib-cdev.h
index b42644cbffb8..16ef1e2e96a0 100644
--- a/drivers/gpio/gpiolib-cdev.h
+++ b/drivers/gpio/gpiolib-cdev.h
@@ -7,7 +7,8 @@
 
 struct gpio_device;
 
-int gpiolib_cdev_register(struct gpio_device *gdev, dev_t devt);
+int gpiolib_cdev_register(struct gpio_device *gdev, struct gpio_chip *gc,
+			  dev_t devt);
 void gpiolib_cdev_unregister(struct gpio_device *gdev);
 
 #endif /* GPIOLIB_CDEV_H */
diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 8e6b09d8b559..a4427a5cfa85 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -978,10 +978,9 @@ void gpiod_unexport(struct gpio_desc *desc)
 }
 EXPORT_SYMBOL_GPL(gpiod_unexport);
 
-int gpiochip_sysfs_register(struct gpio_device *gdev)
+int gpiochip_sysfs_register(struct gpio_device *gdev, struct gpio_chip *chip)
 {
 	struct gpiodev_data *data;
-	struct gpio_chip *chip;
 	struct device *parent;
 	int err;
 
@@ -994,12 +993,6 @@ int gpiochip_sysfs_register(struct gpio_device *gdev)
 	if (!class_is_registered(&gpio_class))
 		return 0;
 
-	guard(srcu)(&gdev->srcu);
-
-	chip = srcu_dereference(gdev->chip, &gdev->srcu);
-	if (!chip)
-		return -ENODEV;
-
 	/*
 	 * For sysfs backward compatibility we need to preserve this
 	 * preferred parenting to the gpio_chip parent field, if set.
@@ -1082,7 +1075,7 @@ static int gpiofind_sysfs_register(struct gpio_chip *gc, const void *data)
 	struct gpio_device *gdev = gc->gpiodev;
 	int ret;
 
-	ret = gpiochip_sysfs_register(gdev);
+	ret = gpiochip_sysfs_register(gdev, gc);
 	if (ret)
 		gpiochip_err(gc, "failed to register the sysfs entry: %d\n", ret);
 
diff --git a/drivers/gpio/gpiolib-sysfs.h b/drivers/gpio/gpiolib-sysfs.h
index 93debe8e118c..192b1ee041a6 100644
--- a/drivers/gpio/gpiolib-sysfs.h
+++ b/drivers/gpio/gpiolib-sysfs.h
@@ -7,13 +7,14 @@ struct gpio_device;
 
 #ifdef CONFIG_GPIO_SYSFS
 
-int gpiochip_sysfs_register(struct gpio_device *gdev);
+int gpiochip_sysfs_register(struct gpio_device *gdev, struct gpio_chip *chip);
 void gpiochip_sysfs_unregister(struct gpio_device *gdev,
 			       struct gpio_chip *chip);
 
 #else
 
-static inline int gpiochip_sysfs_register(struct gpio_device *gdev)
+static inline int gpiochip_sysfs_register(struct gpio_device *gdev,
+					  struct gpio_chip *chip)
 {
 	return 0;
 }
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index c3e1465042c4..efe72b81e131 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -882,14 +882,15 @@ static const struct device_type gpio_dev_type = {
 };
 
 #ifdef CONFIG_GPIO_CDEV
-#define gcdev_register(gdev, devt)	gpiolib_cdev_register((gdev), (devt))
+#define gcdev_register(gdev, gc, devt)	\
+		gpiolib_cdev_register((gdev), (gc), (devt))
 #define gcdev_unregister(gdev)		gpiolib_cdev_unregister((gdev))
 #else
 /*
  * gpiolib_cdev_register() indirectly calls device_add(), which is still
  * required even when cdev is not selected.
  */
-#define gcdev_register(gdev, devt)	device_add(&(gdev)->dev)
+#define gcdev_register(gdev, gc, devt)	device_add(&(gdev)->dev)
 #define gcdev_unregister(gdev)		device_del(&(gdev)->dev)
 #endif
 
@@ -897,7 +898,7 @@ static const struct device_type gpio_dev_type = {
  * An initial reference count has been held in gpiochip_add_data_with_key().
  * The caller should drop the reference via gpio_device_put() on errors.
  */
-static int gpiochip_setup_dev(struct gpio_device *gdev)
+static int gpiochip_setup_dev(struct gpio_device *gdev, struct gpio_chip *gc)
 {
 	struct fwnode_handle *fwnode = dev_fwnode(&gdev->dev);
 	int ret;
@@ -911,11 +912,11 @@ static int gpiochip_setup_dev(struct gpio_device *gdev)
 	if (fwnode && !fwnode->dev)
 		fwnode_dev_initialized(fwnode, false);
 
-	ret = gcdev_register(gdev, gpio_devt);
+	ret = gcdev_register(gdev, gc, gpio_devt);
 	if (ret)
 		return ret;
 
-	ret = gpiochip_sysfs_register(gdev);
+	ret = gpiochip_sysfs_register(gdev, gc);
 	if (ret)
 		goto err_remove_device;
 
@@ -962,13 +963,22 @@ static void machine_gpiochip_add(struct gpio_chip *gc)
 static void gpiochip_setup_devs(void)
 {
 	struct gpio_device *gdev;
+	struct gpio_chip *gc;
 	int ret;
 
 	guard(srcu)(&gpio_devices_srcu);
 
 	list_for_each_entry_srcu(gdev, &gpio_devices, list,
 				 srcu_read_lock_held(&gpio_devices_srcu)) {
-		ret = gpiochip_setup_dev(gdev);
+		guard(srcu)(&gdev->srcu);
+
+		gc = srcu_dereference(gdev->chip, &gdev->srcu);
+		if (!gc) {
+			dev_err(&gdev->dev, "Underlying GPIO chip is gone\n");
+			continue;
+		}
+
+		ret = gpiochip_setup_dev(gdev, gc);
 		if (ret) {
 			gpio_device_put(gdev);
 			dev_err(&gdev->dev,
@@ -1222,7 +1232,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	 * (i.e., `gpio_bus_type` is ready).  Otherwise, defer until later.
 	 */
 	if (gpiolib_initialized) {
-		ret = gpiochip_setup_dev(gdev);
+		ret = gpiochip_setup_dev(gdev, gc);
 		if (ret)
 			goto err_teardown_shared;
 	}
-- 
2.52.0.457.g6b5491de43-goog


