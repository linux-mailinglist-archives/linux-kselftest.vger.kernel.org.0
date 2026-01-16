Return-Path: <linux-kselftest+bounces-49119-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B477D2DCCE
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 09:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10E81305992A
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 08:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D472F301004;
	Fri, 16 Jan 2026 08:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFCRuAMA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D372F5A27;
	Fri, 16 Jan 2026 08:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768551113; cv=none; b=VaK09bAi8ZzK8hwNA5ahamhwFUvz4OhqtJ9fZYbJrDBnZJrH6EJ8YIJsvTYa5Nzr7+Hwx1NbZUrOivRcQz4EW1uiLhGFUrav1bS9ojRqcy9yQz5C4zwhdmvgZXGELyhsVQGVIE5oRGiC9F8wLaAyu1Imdj7ukgYrzJjSrIphTSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768551113; c=relaxed/simple;
	bh=vsSvq8AguO7TYYELrmF0WwiB1WEaAYbIowbsd3ctUKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUqKbnOC10PH1ni6eEh29uA88uW+oE4IjCJFdAhVLvUMpGl7Hsk+V+Updr8RAUoecmaLrmP5z/Af/LMD0AZNN0l/gRB+Q1FOoKT4/c0MBOLmiBVH9BeyvDhF0Zb3eYw2i1/gcPMYKC36MoR0MqbvJ+tv1gWQ8fQ1RCrP6ELJ9Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sFCRuAMA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56EFEC116C6;
	Fri, 16 Jan 2026 08:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768551113;
	bh=vsSvq8AguO7TYYELrmF0WwiB1WEaAYbIowbsd3ctUKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sFCRuAMAmXyNlDMSxgF5Vmx5Hw8eoG7f0iNw0kqJpA9hySctghyaFbhiviINZJTuM
	 wXDFvoZEXCrqHf/BnZnm1iCMzPVMAgiwhGvArXcShjC3MsIdaYGL3i+SFPuj4FbNLt
	 5MVEQW2BtpBS5eDdf9YnVBQrlLXdzYPDpI2tTzVjKAoCuOP70+9naiWeBOOOJCeYRB
	 xzzVb9UMKfH5MpnpfeO63uw+Xrd/pvuDE701GhcNEEsIqSU4YeIxFT0B9r9VA2IfAY
	 W8qosJg+paNa/vw2BJjuT6lzN/eqMBgFQOApCBi33fPxZycodPLEiEFRqigkqOsXw5
	 qHpDq5yFNpRXA==
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
Subject: [PATCH 15/23] gpiolib: cdev: Leverage revocable for line_fileops
Date: Fri, 16 Jan 2026 08:10:28 +0000
Message-ID: <20260116081036.352286-16-tzungbi@kernel.org>
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
struct gpio_chip.  Leverage revocable for line_fileops so that it doesn't
need to handle the synchronization by accessing the SRCU explicitly.

Also, it's unneeded to hold a reference count to the struct gpio_device
while the file is opening.  The struct gpio_device
(i.e., (struct gpio_chip *)->gpiodev)) is valid as long as struct
gpio_chip is valid.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/gpio/gpiolib-cdev.c | 53 +++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index f7c6f1367235..f078d135a581 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -488,7 +488,7 @@ struct line {
 
 /**
  * struct linereq - contains the state of a userspace line request
- * @gdev: the GPIO device the line request pertains to
+ * @chip_rev: revocable consumer handle for the corresponding struct gpio_chip
  * @label: consumer label used to tag GPIO descriptors
  * @num_lines: the number of lines in the lines array
  * @wait: wait queue that handles blocking reads of events
@@ -503,7 +503,7 @@ struct line {
  * @lines: the lines held by this line request, with @num_lines elements.
  */
 struct linereq {
-	struct gpio_device *gdev;
+	struct revocable *chip_rev;
 	const char *label;
 	u32 num_lines;
 	wait_queue_head_t wait;
@@ -1437,10 +1437,10 @@ static long linereq_ioctl(struct file *file, unsigned int cmd,
 {
 	struct linereq *lr = file->private_data;
 	void __user *ip = (void __user *)arg;
+	struct gpio_chip *gc;
 
-	guard(srcu)(&lr->gdev->srcu);
-
-	if (!rcu_access_pointer(lr->gdev->chip))
+	REVOCABLE_TRY_ACCESS_WITH(lr->chip_rev, gc);
+	if (!gc)
 		return -ENODEV;
 
 	switch (cmd) {
@@ -1468,10 +1468,10 @@ static __poll_t linereq_poll(struct file *file,
 {
 	struct linereq *lr = file->private_data;
 	__poll_t events = 0;
+	struct gpio_chip *gc;
 
-	guard(srcu)(&lr->gdev->srcu);
-
-	if (!rcu_access_pointer(lr->gdev->chip))
+	REVOCABLE_TRY_ACCESS_WITH(lr->chip_rev, gc);
+	if (!gc)
 		return EPOLLHUP | EPOLLERR;
 
 	poll_wait(file, &lr->wait, wait);
@@ -1490,10 +1490,10 @@ static ssize_t linereq_read(struct file *file, char __user *buf,
 	struct gpio_v2_line_event le;
 	ssize_t bytes_read = 0;
 	int ret;
+	struct gpio_chip *gc;
 
-	guard(srcu)(&lr->gdev->srcu);
-
-	if (!rcu_access_pointer(lr->gdev->chip))
+	REVOCABLE_TRY_ACCESS_WITH(lr->chip_rev, gc);
+	if (!gc)
 		return -ENODEV;
 
 	if (count < sizeof(le))
@@ -1537,9 +1537,17 @@ static void linereq_free(struct linereq *lr)
 {
 	unsigned int i;
 
-	if (lr->device_unregistered_nb.notifier_call)
-		blocking_notifier_chain_unregister(&lr->gdev->device_notifier,
-						   &lr->device_unregistered_nb);
+	if (lr->device_unregistered_nb.notifier_call) {
+		struct gpio_chip *gc;
+
+		REVOCABLE_TRY_ACCESS_WITH(lr->chip_rev, gc);
+		if (gc) {
+			struct gpio_device *gdev = gc->gpiodev;
+
+			blocking_notifier_chain_unregister(&gdev->device_notifier,
+					&lr->device_unregistered_nb);
+		}
+	}
 
 	for (i = 0; i < lr->num_lines; i++) {
 		if (lr->lines[i].desc) {
@@ -1549,7 +1557,8 @@ static void linereq_free(struct linereq *lr)
 	}
 	kfifo_free(&lr->events);
 	kfree(lr->label);
-	gpio_device_put(lr->gdev);
+	if (lr->chip_rev)
+		revocable_free(lr->chip_rev);
 	kvfree(lr);
 }
 
@@ -1565,9 +1574,15 @@ static int linereq_release(struct inode *inode, struct file *file)
 static void linereq_show_fdinfo(struct seq_file *out, struct file *file)
 {
 	struct linereq *lr = file->private_data;
-	struct device *dev = &lr->gdev->dev;
+	struct gpio_chip *gc;
+	struct device *dev;
 	u16 i;
 
+	REVOCABLE_TRY_ACCESS_WITH(lr->chip_rev, gc);
+	if (!gc)
+		return;
+	dev = &gc->gpiodev->dev;
+
 	seq_printf(out, "gpio-chip:\t%s\n", dev_name(dev));
 
 	for (i = 0; i < lr->num_lines; i++)
@@ -1620,7 +1635,11 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
 		return -ENOMEM;
 	lr->num_lines = ulr.num_lines;
 
-	lr->gdev = gpio_device_get(gdev);
+	lr->chip_rev = revocable_alloc(gdev->chip_rp);
+	if (!lr->chip_rev) {
+		ret = -ENOMEM;
+		goto out_free_linereq;
+	}
 
 	for (i = 0; i < ulr.num_lines; i++) {
 		lr->lines[i].req = lr;
-- 
2.52.0.457.g6b5491de43-goog


