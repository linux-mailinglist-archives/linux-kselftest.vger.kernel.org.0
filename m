Return-Path: <linux-kselftest+bounces-49116-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B14D3D2DDAF
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 09:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D296D306516E
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 08:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB322FD1A5;
	Fri, 16 Jan 2026 08:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7j5orLC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576C42F99BD;
	Fri, 16 Jan 2026 08:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768551104; cv=none; b=aO2OZ2m0u7B/Y3Al5/CkZfQ0rYMayyxYNkq3w/4AWZwPQEuHeUTVrjEbvPnuyWzuE3Us+1ohWA/cSC+HYUkDVDlKqyvxVIaEZQDxfiotJuWscCt5g3cC6yZOEXR3yhI10f1RwwwARIIHcv9cv7TvGLT1n/C5OgThvQ+fArpShFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768551104; c=relaxed/simple;
	bh=Pz79IlxjrkGq59udguFlcb8/r7IPz/iqTpbQYgt220Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGMFylGSmC5KzJpQkk+kzrMpuaeVkKEdpPo+HAJzFjD86fW4N0QML1na1SuBPWcG2aGHX3hl2zsT6ma3p3PEBzBaSJsFipuBclYpjFr/MYKgYl+esg9NLllK8zSnPHYV0qaGfkpypC6G8z4m6Qk+r2TZCDvxoHof1JdgvIUAQNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7j5orLC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45FE3C19421;
	Fri, 16 Jan 2026 08:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768551104;
	bh=Pz79IlxjrkGq59udguFlcb8/r7IPz/iqTpbQYgt220Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C7j5orLCoGUG0ux+pcwHETDPRgBmBkriwlsx4euy2O6G/ZYgraViyjgXBnKwUTmzS
	 WKhlduhcbHRZORBL9xTIBBlSDcu32TcCWPi0L8nJtHIlEYt63sPeBea6v8qIDZVQEZ
	 eKutJhBd5C4IxfbX8R/q8ln7bQZ0yn+QoTrEhwVdNyhoitghMHhilfkcJVvgm02Epr
	 03tybAwMZsKQaaXz05KZ8Zk14B3bymPI5UA+yPAPv08kUzte8R2AHxH7KQZzM7JXSj
	 fkusFO6zWhlFE2yrRZLZJ803sKBtuC80g5l44F5Oxpsc+OCycwFqduMVCCGhnaOKsx
	 xtBnfuUv3t5ZA==
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
Subject: [PATCH 12/23] gpiolib: Add revocable provider handle for struct gpio_chip
Date: Fri, 16 Jan 2026 08:10:25 +0000
Message-ID: <20260116081036.352286-13-tzungbi@kernel.org>
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

The underlying chip can be removed asynchronously.  `gdev->srcu` is used
to ensure the synchronization before accessing `gdev->chip`.

Revocable encapsulates the details in a neat way.  Add revocable
provider handle for the corresponding struct gpio_chip in struct
gpio_device so that we can start to hide the synchronization details.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/gpio/gpiolib.c | 19 +++++++++++++++++++
 drivers/gpio/gpiolib.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index efe72b81e131..6226dc738281 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -22,6 +22,7 @@
 #include <linux/nospec.h>
 #include <linux/of.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/revocable.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/srcu.h>
@@ -1105,6 +1106,12 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	if (ret)
 		goto err_cleanup_gdev_srcu;
 
+	gdev->chip_rp = revocable_provider_alloc(gc);
+	if (!gdev->chip_rp) {
+		ret = -ENOMEM;
+		goto err_cleanup_desc_srcu;
+	}
+
 	device_initialize(&gdev->dev);
 	/* From this point, the .release() function cleans up gdev->dev */
 	gdev->dev.type = &gpio_dev_type;
@@ -1258,9 +1265,20 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 		list_del_rcu(&gdev->list);
 	synchronize_srcu(&gpio_devices_srcu);
 err_put_device:
+	/*
+	 * Error handling of the revocable provider is tricky.  Unlike other
+	 * allocated resources for `gdev` are freed in gpiodev_release().
+	 * We need to call revocable_provider_revoke() here as it's designed
+	 * to be called when the chip is gone (i.e. gpiochip_remove()).
+	 *
+	 * Note: must before gpio_device_put() as it frees `gdev`.
+	 */
+	revocable_provider_revoke(gdev->chip_rp);
 	gpio_device_put(gdev);
 	goto err_print_message;
 
+err_cleanup_desc_srcu:
+	cleanup_srcu_struct(&gdev->desc_srcu);
 err_cleanup_gdev_srcu:
 	cleanup_srcu_struct(&gdev->srcu);
 err_free_label:
@@ -1307,6 +1325,7 @@ void gpiochip_remove(struct gpio_chip *gc)
 	/* Numb the device, cancelling all outstanding operations */
 	rcu_assign_pointer(gdev->chip, NULL);
 	synchronize_srcu(&gdev->srcu);
+	revocable_provider_revoke(gdev->chip_rp);
 	gpio_device_teardown_shared(gdev);
 	gpiochip_irqchip_remove(gc);
 	acpi_gpiochip_remove(gc);
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 77f6f2936dc2..e61db3a75e84 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -52,6 +52,7 @@
  * @device_notifier: used to notify character device wait queues about the GPIO
  *                   device being unregistered
  * @srcu: protects the pointer to the underlying GPIO chip
+ * @chip_rp: revocable provider handle for the corresponding struct gpio_chip.
  * @pin_ranges: range of pins served by the GPIO driver
  *
  * This state container holds most of the runtime variable data
@@ -79,6 +80,7 @@ struct gpio_device {
 	struct workqueue_struct	*line_state_wq;
 	struct blocking_notifier_head device_notifier;
 	struct srcu_struct	srcu;
+	struct revocable_provider *chip_rp;
 
 #ifdef CONFIG_PINCTRL
 	/*
-- 
2.52.0.457.g6b5491de43-goog


