Return-Path: <linux-kselftest+bounces-49127-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CEAD2DE27
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 09:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 571213120048
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 08:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5224D30148B;
	Fri, 16 Jan 2026 08:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJo4pQ9P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B6B2F5461;
	Fri, 16 Jan 2026 08:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768551138; cv=none; b=SblwW1+JcV4isg9k4nJIlYLh07Ql5fiHB59JaoRe533W7bWm9/Be8BH9n54Yl3ARZDFL889I/greApflcadgJHOz0HvwqTSU9Ycy5zj//IFRJkFs9CXTU6VKcp+MpYiDIrXqpxuBlixlYQuyyCTMBPs59+SD++ohjGTof0zTGzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768551138; c=relaxed/simple;
	bh=GhZ4IEFrAvMGKCF8VQdEwrw8Y7MMLL9mIj9KkZbgkIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0Pc/0CNBK6OUiKc3qMYMV8J2V8U5+2OFCS8vnnhIZzv/qTL9df7JpLJOT9EppNnvhFTYVKcJWc4QFAeKAs438wdUMSulGWoAiIItbuXfvs45da0FNBEN/5XUEfN/fETlxVBgV9vr5XQJH7OHIKwycMT5IxwZDuNDZ7eMh1eQ5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJo4pQ9P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4EEC116C6;
	Fri, 16 Jan 2026 08:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768551137;
	bh=GhZ4IEFrAvMGKCF8VQdEwrw8Y7MMLL9mIj9KkZbgkIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mJo4pQ9PjN3qB0t8dLoed3B2Qv1+l8fJOdvOUCq0vXCCFlXCITTF4I/01WIQqEEqo
	 9PkKr2qG4j/mN6dplWd7s8taoSX4AaPfIGZqoQ/tk1aoxWTsu9vmtKadHuH0eAIF6h
	 UkhGQpPtz5F36KDrMpNRRTgfyBHAgUiOh3VM7qUEt2/vxja4caSWm7XMb12T6kzLxI
	 wAFDkPQdQpqjEK/RaTAQwm+QV7oo+cVQkawSK8MAdcbUD1LwOP/D2VebLXDzP7nOdb
	 EsF2dZ6oKqX6ZGj+X+fklKVcp6eL45N/hzgmqYkIwxvto1xUWeOj0C2w8zm/L4Zg5l
	 7qETsHVKWghNg==
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
Subject: [PATCH 23/23] gpiolib: Remove unused `chip` and `srcu` in struct gpio_device
Date: Fri, 16 Jan 2026 08:10:36 +0000
Message-ID: <20260116081036.352286-24-tzungbi@kernel.org>
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

`chip` and `srcu` in struct gpio_device are unused as their usages are
replaced to use revocable.  Remove them.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/gpio/gpiolib.c | 26 +-------------------------
 drivers/gpio/gpiolib.h |  4 ----
 2 files changed, 1 insertion(+), 29 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 44915c8b6131..31f6cc27e0b7 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -424,8 +424,6 @@ static int gpiochip_get_direction(struct gpio_chip *gc, unsigned int offset)
 {
 	int ret;
 
-	lockdep_assert_held(&gc->gpiodev->srcu);
-
 	if (WARN_ON(!gc->get_direction))
 		return -EOPNOTSUPP;
 
@@ -880,7 +878,6 @@ static void gpiodev_release(struct device *dev)
 	ida_free(&gpio_ida, gdev->id);
 	kfree_const(gdev->label);
 	kfree(gdev->descs);
-	cleanup_srcu_struct(&gdev->srcu);
 	kfree(gdev);
 }
 
@@ -1104,14 +1101,9 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 		goto err_free_descs;
 	}
 
-	ret = init_srcu_struct(&gdev->srcu);
-	if (ret)
-		goto err_free_label;
-	rcu_assign_pointer(gdev->chip, gc);
-
 	ret = init_srcu_struct(&gdev->desc_srcu);
 	if (ret)
-		goto err_cleanup_gdev_srcu;
+		goto err_free_label;
 
 	gdev->chip_rp = revocable_provider_alloc(gc);
 	if (!gdev->chip_rp) {
@@ -1286,8 +1278,6 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 
 err_cleanup_desc_srcu:
 	cleanup_srcu_struct(&gdev->desc_srcu);
-err_cleanup_gdev_srcu:
-	cleanup_srcu_struct(&gdev->srcu);
 err_free_label:
 	kfree_const(gdev->label);
 err_free_descs:
@@ -1330,8 +1320,6 @@ void gpiochip_remove(struct gpio_chip *gc)
 	synchronize_srcu(&gpio_devices_srcu);
 
 	/* Numb the device, cancelling all outstanding operations */
-	rcu_assign_pointer(gdev->chip, NULL);
-	synchronize_srcu(&gdev->srcu);
 	revocable_provider_revoke(gdev->chip_rp);
 	gpio_device_teardown_shared(gdev);
 	gpiochip_irqchip_remove(gc);
@@ -2843,8 +2831,6 @@ static int gpiochip_direction_input(struct gpio_chip *gc, unsigned int offset)
 {
 	int ret;
 
-	lockdep_assert_held(&gc->gpiodev->srcu);
-
 	if (WARN_ON(!gc->direction_input))
 		return -EOPNOTSUPP;
 
@@ -2860,8 +2846,6 @@ static int gpiochip_direction_output(struct gpio_chip *gc, unsigned int offset,
 {
 	int ret;
 
-	lockdep_assert_held(&gc->gpiodev->srcu);
-
 	if (WARN_ON(!gc->direction_output))
 		return -EOPNOTSUPP;
 
@@ -2952,8 +2936,6 @@ static int gpiochip_set(struct gpio_chip *gc, unsigned int offset, int value)
 {
 	int ret;
 
-	lockdep_assert_held(&gc->gpiodev->srcu);
-
 	if (WARN_ON(unlikely(!gc->set)))
 		return -EOPNOTSUPP;
 
@@ -3312,8 +3294,6 @@ static int gpiochip_get(struct gpio_chip *gc, unsigned int offset)
 {
 	int ret;
 
-	lockdep_assert_held(&gc->gpiodev->srcu);
-
 	/* Make sure this is called after checking for gc->get(). */
 	ret = gc->get(gc, offset);
 	if (ret > 1)
@@ -3368,8 +3348,6 @@ static int gpiod_get_raw_value_commit(const struct gpio_desc *desc)
 static int gpio_chip_get_multiple(struct gpio_chip *gc,
 				  unsigned long *mask, unsigned long *bits)
 {
-	lockdep_assert_held(&gc->gpiodev->srcu);
-
 	if (gc->get_multiple) {
 		int ret;
 
@@ -3731,8 +3709,6 @@ static int gpiochip_set_multiple(struct gpio_chip *gc,
 	unsigned int i;
 	int ret;
 
-	lockdep_assert_held(&gc->gpiodev->srcu);
-
 	if (gc->set_multiple) {
 		ret = gc->set_multiple(gc, mask, bits);
 		if (ret > 0)
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 00aa354950c9..c1952c287a64 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -28,7 +28,6 @@
  * @chrdev: character device for the GPIO device
  * @id: numerical ID number for the GPIO chip
  * @owner: helps prevent removal of modules exporting active GPIOs
- * @chip: pointer to the corresponding gpiochip, holding static
  * data for this device
  * @descs: array of ngpio descriptors.
  * @valid_mask: If not %NULL, holds bitmask of GPIOs which are valid to be
@@ -51,7 +50,6 @@
  *                 process context
  * @device_notifier: used to notify character device wait queues about the GPIO
  *                   device being unregistered
- * @srcu: protects the pointer to the underlying GPIO chip
  * @chip_rp: revocable provider handle for the corresponding struct gpio_chip.
  * @pin_ranges: range of pins served by the GPIO driver
  *
@@ -65,7 +63,6 @@ struct gpio_device {
 	struct cdev		chrdev;
 	int			id;
 	struct module		*owner;
-	struct gpio_chip __rcu	*chip;
 	struct gpio_desc	*descs;
 	unsigned long		*valid_mask;
 	struct srcu_struct	desc_srcu;
@@ -79,7 +76,6 @@ struct gpio_device {
 	rwlock_t		line_state_lock;
 	struct workqueue_struct	*line_state_wq;
 	struct blocking_notifier_head device_notifier;
-	struct srcu_struct	srcu;
 	struct revocable_provider *chip_rp;
 
 #ifdef CONFIG_PINCTRL
-- 
2.52.0.457.g6b5491de43-goog


