Return-Path: <linux-kselftest+bounces-49117-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 98450D2DCD8
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 09:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 78C30301C3BE
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 08:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C902F83AE;
	Fri, 16 Jan 2026 08:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpsvJ9n+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755122E2EEE;
	Fri, 16 Jan 2026 08:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768551107; cv=none; b=gofOs/DFmh61gyPkxVnP3wcaEUsqe/A46fNs4mtFqGvuNsQ8qE2hO4+5xKfRvs7/8Lj4iVy5GDSQ2wh/aUKsmZVSJ2K9Pvc4DwLMJ39p3nm5uP6pk02594XEuGel3VNXX3BBQK6HW/ZarHS26o05wcarlD/Xa9xN7P85yjx3yL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768551107; c=relaxed/simple;
	bh=J0wAI5T5xWGzyZsPv6F0vIcak1H/ZaaUABKtaYhxLX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xua5JkTYk433EG6N2mybXCF5zt1e1nQpjnkCdwZCKElhtWMt46suVK1M91b13/evV0/xz4yL5PJrKbu7I58CyzJeCY5VYIBYgxD7CLFN9SoMyMl/VeJr98H4rZ4egJ5wkAscLIsxM8/A4TFQd4lwDj8UWG/zgEiFml1fyUfERDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpsvJ9n+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BEDDC116C6;
	Fri, 16 Jan 2026 08:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768551107;
	bh=J0wAI5T5xWGzyZsPv6F0vIcak1H/ZaaUABKtaYhxLX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XpsvJ9n+3WdxpRkLI8l+VSGCwFDiAzJSMbHpRx9nj8DHHEXleSe836NbuF1w5VfMQ
	 0yWe2Iq21n0frX0SI1Ua/vvsjD8EOaT+G7g8xOSjHReQsGK0pzRIuJtFLysOS+v9zX
	 oUnstsQfW/1N40zLo3Yxubw1fXL0a+aPQ8hJEu/EP5EO//GYSgWsuZGFuyh927hkvy
	 cZdUVksxus5iASPYBK+9FFVAHxyfR1Keeeg5g41/3GniLFMm0sZTeyf2pQ7JAaTpNZ
	 XgelPAkozfJZgLpSB2VGGZ3cr9KJt8Vk7CZFYx6I/M5DICLegZfzxiyhRmUh+eZl7i
	 cRVSIi627qtRA==
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
Subject: [PATCH 13/23] gpiolib: cdev: Leverage revocable for gpio_fileops
Date: Fri, 16 Jan 2026 08:10:26 +0000
Message-ID: <20260116081036.352286-14-tzungbi@kernel.org>
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

Struct gpio_device now provides a revocable provider to the underlying
struct gpio_chip.  Leverage revocable for gpio_fileops so that it doesn't
need to handle the synchronization by accessing the SRCU explicitly.

Also, it's unneeded to hold a reference count to the struct gpio_device
while the file is opening.  The struct gpio_device
(i.e., (struct gpio_chip *)->gpiodev)) is valid as long as struct
gpio_chip is valid.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/gpio/gpiolib-cdev.c | 87 ++++++++++++++++++++++---------------
 1 file changed, 52 insertions(+), 35 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index e42cfdb47885..832a542c4f7a 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -22,6 +22,7 @@
 #include <linux/overflow.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/poll.h>
+#include <linux/revocable.h>
 #include <linux/seq_file.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
@@ -2297,7 +2298,7 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
 }
 
 struct gpio_chardev_data {
-	struct gpio_device *gdev;
+	struct revocable *chip_rev;
 	wait_queue_head_t wait;
 	DECLARE_KFIFO(events, struct gpio_v2_line_info_changed, 32);
 	struct notifier_block lineinfo_changed_nb;
@@ -2309,9 +2310,8 @@ struct gpio_chardev_data {
 	struct file *fp;
 };
 
-static int chipinfo_get(struct gpio_chardev_data *cdev, void __user *ip)
+static int chipinfo_get(struct gpio_device *gdev, void __user *ip)
 {
-	struct gpio_device *gdev = cdev->gdev;
 	struct gpiochip_info chipinfo;
 
 	memset(&chipinfo, 0, sizeof(chipinfo));
@@ -2339,7 +2339,8 @@ static int lineinfo_ensure_abi_version(struct gpio_chardev_data *cdata,
 	return abiv;
 }
 
-static int lineinfo_get_v1(struct gpio_chardev_data *cdev, void __user *ip,
+static int lineinfo_get_v1(struct gpio_chardev_data *cdev,
+			   struct gpio_device *gdev, void __user *ip,
 			   bool watch)
 {
 	struct gpio_desc *desc;
@@ -2350,7 +2351,7 @@ static int lineinfo_get_v1(struct gpio_chardev_data *cdev, void __user *ip,
 		return -EFAULT;
 
 	/* this doubles as a range check on line_offset */
-	desc = gpio_device_get_desc(cdev->gdev, lineinfo.line_offset);
+	desc = gpio_device_get_desc(gdev, lineinfo.line_offset);
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
 
@@ -2375,7 +2376,8 @@ static int lineinfo_get_v1(struct gpio_chardev_data *cdev, void __user *ip,
 }
 #endif
 
-static int lineinfo_get(struct gpio_chardev_data *cdev, void __user *ip,
+static int lineinfo_get(struct gpio_chardev_data *cdev,
+			struct gpio_device *gdev, void __user *ip,
 			bool watch)
 {
 	struct gpio_desc *desc;
@@ -2387,7 +2389,7 @@ static int lineinfo_get(struct gpio_chardev_data *cdev, void __user *ip,
 	if (!mem_is_zero(lineinfo.padding, sizeof(lineinfo.padding)))
 		return -EINVAL;
 
-	desc = gpio_device_get_desc(cdev->gdev, lineinfo.offset);
+	desc = gpio_device_get_desc(gdev, lineinfo.offset);
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
 
@@ -2410,14 +2412,15 @@ static int lineinfo_get(struct gpio_chardev_data *cdev, void __user *ip,
 	return 0;
 }
 
-static int lineinfo_unwatch(struct gpio_chardev_data *cdev, void __user *ip)
+static int lineinfo_unwatch(struct gpio_chardev_data *cdev,
+			    struct gpio_device *gdev, void __user *ip)
 {
 	__u32 offset;
 
 	if (copy_from_user(&offset, ip, sizeof(offset)))
 		return -EFAULT;
 
-	if (offset >= cdev->gdev->ngpio)
+	if (offset >= gdev->ngpio)
 		return -EINVAL;
 
 	if (!test_and_clear_bit(offset, cdev->watched_lines))
@@ -2432,37 +2435,38 @@ static int lineinfo_unwatch(struct gpio_chardev_data *cdev, void __user *ip)
 static long gpio_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct gpio_chardev_data *cdev = file->private_data;
-	struct gpio_device *gdev = cdev->gdev;
+	struct gpio_chip *gc;
+	struct gpio_device *gdev;
 	void __user *ip = (void __user *)arg;
 
-	guard(srcu)(&gdev->srcu);
-
 	/* We fail any subsequent ioctl():s when the chip is gone */
-	if (!rcu_access_pointer(gdev->chip))
+	REVOCABLE_TRY_ACCESS_WITH(cdev->chip_rev, gc);
+	if (!gc)
 		return -ENODEV;
+	gdev = gc->gpiodev;
 
 	/* Fill in the struct and pass to userspace */
 	switch (cmd) {
 	case GPIO_GET_CHIPINFO_IOCTL:
-		return chipinfo_get(cdev, ip);
+		return chipinfo_get(gdev, ip);
 #ifdef CONFIG_GPIO_CDEV_V1
 	case GPIO_GET_LINEHANDLE_IOCTL:
 		return linehandle_create(gdev, ip);
 	case GPIO_GET_LINEEVENT_IOCTL:
 		return lineevent_create(gdev, ip);
 	case GPIO_GET_LINEINFO_IOCTL:
-		return lineinfo_get_v1(cdev, ip, false);
+		return lineinfo_get_v1(cdev, gdev, ip, false);
 	case GPIO_GET_LINEINFO_WATCH_IOCTL:
-		return lineinfo_get_v1(cdev, ip, true);
+		return lineinfo_get_v1(cdev, gdev, ip, true);
 #endif /* CONFIG_GPIO_CDEV_V1 */
 	case GPIO_V2_GET_LINEINFO_IOCTL:
-		return lineinfo_get(cdev, ip, false);
+		return lineinfo_get(cdev, gdev, ip, false);
 	case GPIO_V2_GET_LINEINFO_WATCH_IOCTL:
-		return lineinfo_get(cdev, ip, true);
+		return lineinfo_get(cdev, gdev, ip, true);
 	case GPIO_V2_GET_LINE_IOCTL:
 		return linereq_create(gdev, ip);
 	case GPIO_GET_LINEINFO_UNWATCH_IOCTL:
-		return lineinfo_unwatch(cdev, ip);
+		return lineinfo_unwatch(cdev, gdev, ip);
 	default:
 		return -EINVAL;
 	}
@@ -2585,10 +2589,10 @@ static __poll_t lineinfo_watch_poll(struct file *file,
 {
 	struct gpio_chardev_data *cdev = file->private_data;
 	__poll_t events = 0;
+	struct gpio_chip *gc;
 
-	guard(srcu)(&cdev->gdev->srcu);
-
-	if (!rcu_access_pointer(cdev->gdev->chip))
+	REVOCABLE_TRY_ACCESS_WITH(cdev->chip_rev, gc);
+	if (!gc)
 		return EPOLLHUP | EPOLLERR;
 
 	poll_wait(file, &cdev->wait, pollt);
@@ -2608,10 +2612,10 @@ static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
 	ssize_t bytes_read = 0;
 	int ret;
 	size_t event_size;
+	struct gpio_chip *gc;
 
-	guard(srcu)(&cdev->gdev->srcu);
-
-	if (!rcu_access_pointer(cdev->gdev->chip))
+	REVOCABLE_TRY_ACCESS_WITH(cdev->chip_rev, gc);
+	if (!gc)
 		return -ENODEV;
 
 #ifndef CONFIG_GPIO_CDEV_V1
@@ -2695,13 +2699,16 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 	if (!cdev)
 		return -ENOMEM;
 
+	cdev->chip_rev = revocable_alloc(gdev->chip_rp);
+	if (!cdev->chip_rev)
+		goto out_free_cdev;
+
 	cdev->watched_lines = bitmap_zalloc(gdev->ngpio, GFP_KERNEL);
 	if (!cdev->watched_lines)
-		goto out_free_cdev;
+		goto out_free_chip_rev;
 
 	init_waitqueue_head(&cdev->wait);
 	INIT_KFIFO(cdev->events);
-	cdev->gdev = gpio_device_get(gdev);
 
 	cdev->lineinfo_changed_nb.notifier_call = lineinfo_changed_notify;
 	scoped_guard(write_lock_irqsave, &gdev->line_state_lock)
@@ -2734,8 +2741,9 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 		raw_notifier_chain_unregister(&gdev->line_state_notifier,
 					      &cdev->lineinfo_changed_nb);
 out_free_bitmap:
-	gpio_device_put(gdev);
 	bitmap_free(cdev->watched_lines);
+out_free_chip_rev:
+	revocable_free(cdev->chip_rev);
 out_free_cdev:
 	kfree(cdev);
 	return ret;
@@ -2752,15 +2760,24 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 static int gpio_chrdev_release(struct inode *inode, struct file *file)
 {
 	struct gpio_chardev_data *cdev = file->private_data;
-	struct gpio_device *gdev = cdev->gdev;
+	struct gpio_chip *gc;
+	struct gpio_device *gdev;
+
+	REVOCABLE_TRY_ACCESS_SCOPED(cdev->chip_rev, gc) {
+		if (!gc)
+			break;
+		gdev = gc->gpiodev;
+
+		blocking_notifier_chain_unregister(&gdev->device_notifier,
+				&cdev->device_unregistered_nb);
+
+		scoped_guard(write_lock_irqsave, &gdev->line_state_lock)
+			raw_notifier_chain_unregister(&gdev->line_state_notifier,
+					&cdev->lineinfo_changed_nb);
+	}
+	revocable_free(cdev->chip_rev);
 
-	blocking_notifier_chain_unregister(&gdev->device_notifier,
-					   &cdev->device_unregistered_nb);
-	scoped_guard(write_lock_irqsave, &gdev->line_state_lock)
-		raw_notifier_chain_unregister(&gdev->line_state_notifier,
-					      &cdev->lineinfo_changed_nb);
 	bitmap_free(cdev->watched_lines);
-	gpio_device_put(gdev);
 	kfree(cdev);
 
 	return 0;
-- 
2.52.0.457.g6b5491de43-goog


