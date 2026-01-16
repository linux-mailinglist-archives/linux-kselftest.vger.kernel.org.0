Return-Path: <linux-kselftest+bounces-49107-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B136D2DBFA
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 09:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D14683031651
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 08:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323272F5331;
	Fri, 16 Jan 2026 08:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHR6x2Il"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046272F362B;
	Fri, 16 Jan 2026 08:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768551080; cv=none; b=Uhwzq4vzR/0Baw3oYsi6lTJ7O+Y1sUAeEUpx0XqTnWxUgnJboAcPqZbrw8VlO6xf9rBSFjra3MAZ28TvgWZ09HgKVCwEg2225QaiCA7Go/5YzW2NNIscryGWPiKy5dbNDuOcTibR9HAB8hNYp40sK3nYri0F/YAJ5bUODjUh48A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768551080; c=relaxed/simple;
	bh=RYs+sf+T6d+HEd4Ono2iLRkgb4L+bV72F1yST1OGoCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CAcpSw80crYg004xlVB+3Ngnt8qP5MwIxO1YkcERTarW8OEjuYjt8EaS9sQCrogm4g2B1nCG7qnW5oVdQueeioOGupeSeordvxljyoOeehHaJiDdXYU6RrUykvHJA8w3jZ3g7Nb2TnP2fv5ay72DLY/tbMH87rwFejzGqJEGA+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHR6x2Il; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB549C19424;
	Fri, 16 Jan 2026 08:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768551076;
	bh=RYs+sf+T6d+HEd4Ono2iLRkgb4L+bV72F1yST1OGoCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kHR6x2Ilj8RRxzYO6jl/Sbuw0BK+YU1hbw4p5QBQmNVKMkyH5vTYE8M0bZ5hwnOoj
	 DA2Kw/IgLuJKSpsFi5diBK6cwIgmtc+Nme1aVMjoRGf5TDSL24oDpJdZ8o2gQimZN4
	 bZIjDozIbcvtuMhPzlVt+6BYhcSCa7WN873CDQg3xAGG5CJcya10l2yv2VmSeYyDA/
	 nQVYdm6MPNdyXnwZk6ptJOogVrARSi+geJSP7PG4D2XupyUyTSo4KoA48z5s6L+5Vy
	 UalBlekwff/kTb9lAftJi7iTMcXVJ5YlumbMnRHZXBwP29XFOE4ly/R7O40kOx+FQY
	 RZ3hVdgir0AVQ==
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
	linux-gpio@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 03/23] gpiolib: Fix resource leaks on errors in gpiochip_add_data_with_key()
Date: Fri, 16 Jan 2026 08:10:16 +0000
Message-ID: <20260116081036.352286-4-tzungbi@kernel.org>
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

Since commit aab5c6f20023 ("gpio: set device type for GPIO chips"),
`gdev->dev.release` is unset.  As a result, the reference count to
`gdev->dev` isn't dropped on the error handling paths.

Drop the reference on errors.

Also reorder the instructions to make the intent more clear.  Now
gpiochip_add_data_with_key() roughly looks like:

   >>> Some memory allocation.  Go to ERR ZONE 1 on errors.
   >>> device_initialize().

   (gpiodev_release() takes over the responsibility for freeing the
    resources of `gdev->dev`.  The following error handling paths
    shouldn't go through ERR ZONE 1 again which leads to double free.)

   >>> Some initialization mainly on `gdev`.
   >>> The rest of initialization.  Go to ERR ZONE 2 on errors.
   >>> Chip registration success and exit.

   >>> ERR ZONE 2.  gpio_device_put() and exit.
   >>> ERR ZONE 1.

Cc: stable@vger.kernel.org
Fixes: aab5c6f20023 ("gpio: set device type for GPIO chips")
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/gpio/gpiolib.c | 81 ++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 43 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index ba9323432e3a..6fac59716405 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -893,13 +893,15 @@ static const struct device_type gpio_dev_type = {
 #define gcdev_unregister(gdev)		device_del(&(gdev)->dev)
 #endif
 
+/*
+ * An initial reference count has been held in gpiochip_add_data_with_key().
+ * The caller should drop the reference via gpio_device_put() on errors.
+ */
 static int gpiochip_setup_dev(struct gpio_device *gdev)
 {
 	struct fwnode_handle *fwnode = dev_fwnode(&gdev->dev);
 	int ret;
 
-	device_initialize(&gdev->dev);
-
 	/*
 	 * If fwnode doesn't belong to another device, it's safe to clear its
 	 * initialized flag.
@@ -965,9 +967,11 @@ static void gpiochip_setup_devs(void)
 	list_for_each_entry_srcu(gdev, &gpio_devices, list,
 				 srcu_read_lock_held(&gpio_devices_srcu)) {
 		ret = gpiochip_setup_dev(gdev);
-		if (ret)
+		if (ret) {
+			gpio_device_put(gdev);
 			dev_err(&gdev->dev,
 				"Failed to initialize gpio device (%d)\n", ret);
+		}
 	}
 }
 
@@ -1048,24 +1052,12 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	int base = 0;
 	int ret;
 
-	/*
-	 * First: allocate and populate the internal stat container, and
-	 * set up the struct device.
-	 */
 	gdev = kzalloc(sizeof(*gdev), GFP_KERNEL);
 	if (!gdev)
 		return -ENOMEM;
-
-	gdev->dev.type = &gpio_dev_type;
-	gdev->dev.bus = &gpio_bus_type;
-	gdev->dev.parent = gc->parent;
-	rcu_assign_pointer(gdev->chip, gc);
-
 	gc->gpiodev = gdev;
 	gpiochip_set_data(gc, data);
 
-	device_set_node(&gdev->dev, gpiochip_choose_fwnode(gc));
-
 	ret = ida_alloc(&gpio_ida, GFP_KERNEL);
 	if (ret < 0)
 		goto err_free_gdev;
@@ -1075,17 +1067,10 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	if (ret)
 		goto err_free_ida;
 
-	if (gc->parent && gc->parent->driver)
-		gdev->owner = gc->parent->driver->owner;
-	else if (gc->owner)
-		/* TODO: remove chip->owner */
-		gdev->owner = gc->owner;
-	else
-		gdev->owner = THIS_MODULE;
-
 	ret = gpiochip_get_ngpios(gc, &gdev->dev);
 	if (ret)
 		goto err_free_dev_name;
+	gdev->ngpio = gc->ngpio;
 
 	gdev->descs = kcalloc(gc->ngpio, sizeof(*gdev->descs), GFP_KERNEL);
 	if (!gdev->descs) {
@@ -1099,21 +1084,37 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 		goto err_free_descs;
 	}
 
-	gdev->ngpio = gc->ngpio;
-	gdev->can_sleep = gc->can_sleep;
-
-	rwlock_init(&gdev->line_state_lock);
-	RAW_INIT_NOTIFIER_HEAD(&gdev->line_state_notifier);
-	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->device_notifier);
-
 	ret = init_srcu_struct(&gdev->srcu);
 	if (ret)
 		goto err_free_label;
+	rcu_assign_pointer(gdev->chip, gc);
 
 	ret = init_srcu_struct(&gdev->desc_srcu);
 	if (ret)
 		goto err_cleanup_gdev_srcu;
 
+	device_initialize(&gdev->dev);
+	/* From this point, the .release() function cleans up gdev->dev */
+	gdev->dev.type = &gpio_dev_type;
+	gdev->dev.bus = &gpio_bus_type;
+	gdev->dev.parent = gc->parent;
+	device_set_node(&gdev->dev, gpiochip_choose_fwnode(gc));
+
+	gdev->can_sleep = gc->can_sleep;
+	rwlock_init(&gdev->line_state_lock);
+	RAW_INIT_NOTIFIER_HEAD(&gdev->line_state_notifier);
+	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->device_notifier);
+#ifdef CONFIG_PINCTRL
+	INIT_LIST_HEAD(&gdev->pin_ranges);
+#endif
+	if (gc->parent && gc->parent->driver)
+		gdev->owner = gc->parent->driver->owner;
+	else if (gc->owner)
+		/* TODO: remove chip->owner */
+		gdev->owner = gc->owner;
+	else
+		gdev->owner = THIS_MODULE;
+
 	scoped_guard(mutex, &gpio_devices_lock) {
 		/*
 		 * TODO: this allocates a Linux GPIO number base in the global
@@ -1128,7 +1129,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 			if (base < 0) {
 				ret = base;
 				base = 0;
-				goto err_cleanup_desc_srcu;
+				goto err_put_device;
 			}
 
 			/*
@@ -1148,14 +1149,10 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 		ret = gpiodev_add_to_list_unlocked(gdev);
 		if (ret) {
 			gpiochip_err(gc, "GPIO integer space overlap, cannot add chip\n");
-			goto err_cleanup_desc_srcu;
+			goto err_put_device;
 		}
 	}
 
-#ifdef CONFIG_PINCTRL
-	INIT_LIST_HEAD(&gdev->pin_ranges);
-#endif
-
 	if (gc->names)
 		gpiochip_set_desc_names(gc);
 
@@ -1249,13 +1246,10 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	scoped_guard(mutex, &gpio_devices_lock)
 		list_del_rcu(&gdev->list);
 	synchronize_srcu(&gpio_devices_srcu);
-	if (gdev->dev.release) {
-		/* release() has been registered by gpiochip_setup_dev() */
-		gpio_device_put(gdev);
-		goto err_print_message;
-	}
-err_cleanup_desc_srcu:
-	cleanup_srcu_struct(&gdev->desc_srcu);
+err_put_device:
+	gpio_device_put(gdev);
+	goto err_print_message;
+
 err_cleanup_gdev_srcu:
 	cleanup_srcu_struct(&gdev->srcu);
 err_free_label:
@@ -1268,6 +1262,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	ida_free(&gpio_ida, gdev->id);
 err_free_gdev:
 	kfree(gdev);
+
 err_print_message:
 	/* failures here can mean systems won't boot... */
 	if (ret != -EPROBE_DEFER) {
-- 
2.52.0.457.g6b5491de43-goog


