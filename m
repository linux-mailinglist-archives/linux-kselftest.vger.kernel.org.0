Return-Path: <linux-kselftest+bounces-49120-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EBED2DD82
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 09:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5E7A93034A61
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 08:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3E03019D9;
	Fri, 16 Jan 2026 08:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXYi+I3v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97943016EE;
	Fri, 16 Jan 2026 08:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768551116; cv=none; b=C+wWN2SgAi5TKQfSfs5JrEc8cYd9SilpMF+A2Q2Rmh4ZJIv1v5T6KOSDz/f0/f2kLIhPki0dbB6WoMCCkP3K1MhofzHnpJ1Vriv8w/6O/c8kWiIV04vpIKhWEUmx/JdaR+/ffRIPF4QMZLKUU2H6KxiQlpSus4vy6T60+LA6ldE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768551116; c=relaxed/simple;
	bh=MBLv2iZu7XsY6OooCqDiJYH2d/hEHZ6RdvykyjVtWZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BbSUIFdrD0mInuDoZ/PMYrCs1QNFO0NuvrVB/aOWZfvR9tUeO0hj1PBDnL2GwA1ss/Kf5NWywY1rwgSvz3YmvQFMrpBwBWRpB6QI7jzRcgvknzvRwIkSu9V6ALeoaEO4J8xDpwi0BE1jahPQ0IVBOyaHRylZqU671rGXpmrAzIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXYi+I3v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8BEC19421;
	Fri, 16 Jan 2026 08:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768551116;
	bh=MBLv2iZu7XsY6OooCqDiJYH2d/hEHZ6RdvykyjVtWZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EXYi+I3vL5mznzcDNrFx//OPcxl6ri+2DyZLgDEJcJYitcr7pwNWxS2AuREd8dKlU
	 71HkHZyvJdfum9+HXNANQdDJHkPnb2hsWOHIB8S+Encg1qfn2T+RLdJir7Cfxyi+Jq
	 uY6uGPhe7Gmhk9fNkZRZgJYGlatyXfAbWMSWcny7tMEH8/Cl8XEwi1BbABjN0aLtCk
	 ybnrWWSZkcjMRP00i4Yd7xDkRcVof3C4H2T8uN4gGN44NdCTn5Gm6g1ZrgUT3DgSeO
	 JH4XLDzvD7rGl3WM2dfIIuhSSYA1Sf4hYkzaT/ybGa0QevCuIheeTqae/1N12Y6qkM
	 aVKg+mCYCDp2g==
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
Subject: [PATCH 16/23] gpiolib: cdev: Leverage revocable for lineevent_fileops
Date: Fri, 16 Jan 2026 08:10:29 +0000
Message-ID: <20260116081036.352286-17-tzungbi@kernel.org>
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
struct gpio_chip.  Leverage revocable for lineevent_fileops so that it
doesn't need to handle the synchronization by accessing the SRCU
explicitly.

Also, it's unneeded to hold a reference count to the struct gpio_device
while the file is opening.  The struct gpio_device
(i.e., (struct gpio_chip *)->gpiodev)) is valid as long as struct
gpio_chip is valid.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/gpio/gpiolib-cdev.c | 46 ++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index f078d135a581..54150d718931 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1772,7 +1772,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
 
 /**
  * struct lineevent_state - contains the state of a userspace event
- * @gdev: the GPIO device the event pertains to
+ * @chip_rev: revocable consumer handle for the corresponding struct gpio_chip
  * @label: consumer label used to tag descriptors
  * @desc: the GPIO descriptor held by this event
  * @eflags: the event flags this line was requested with
@@ -1785,7 +1785,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
  * event
  */
 struct lineevent_state {
-	struct gpio_device *gdev;
+	struct revocable *chip_rev;
 	const char *label;
 	struct gpio_desc *desc;
 	u32 eflags;
@@ -1805,10 +1805,10 @@ static __poll_t lineevent_poll(struct file *file,
 {
 	struct lineevent_state *le = file->private_data;
 	__poll_t events = 0;
+	struct gpio_chip *gc;
 
-	guard(srcu)(&le->gdev->srcu);
-
-	if (!rcu_access_pointer(le->gdev->chip))
+	REVOCABLE_TRY_ACCESS_WITH(le->chip_rev, gc);
+	if (!gc)
 		return EPOLLHUP | EPOLLERR;
 
 	poll_wait(file, &le->wait, wait);
@@ -1843,10 +1843,10 @@ static ssize_t lineevent_read(struct file *file, char __user *buf,
 	ssize_t bytes_read = 0;
 	ssize_t ge_size;
 	int ret;
+	struct gpio_chip *gc;
 
-	guard(srcu)(&le->gdev->srcu);
-
-	if (!rcu_access_pointer(le->gdev->chip))
+	REVOCABLE_TRY_ACCESS_WITH(le->chip_rev, gc);
+	if (!gc)
 		return -ENODEV;
 
 	/*
@@ -1901,15 +1901,24 @@ static ssize_t lineevent_read(struct file *file, char __user *buf,
 
 static void lineevent_free(struct lineevent_state *le)
 {
-	if (le->device_unregistered_nb.notifier_call)
-		blocking_notifier_chain_unregister(&le->gdev->device_notifier,
-						   &le->device_unregistered_nb);
+	if (le->device_unregistered_nb.notifier_call) {
+		struct gpio_chip *gc;
+
+		REVOCABLE_TRY_ACCESS_WITH(le->chip_rev, gc);
+		if (gc) {
+			struct gpio_device *gdev = gc->gpiodev;
+
+			blocking_notifier_chain_unregister(&gdev->device_notifier,
+					&le->device_unregistered_nb);
+		}
+	}
 	if (le->irq)
 		free_irq_label(free_irq(le->irq, le));
 	if (le->desc)
 		gpiod_free(le->desc);
 	kfree(le->label);
-	gpio_device_put(le->gdev);
+	if (le->chip_rev)
+		revocable_free(le->chip_rev);
 	kfree(le);
 }
 
@@ -1925,10 +1934,10 @@ static long lineevent_ioctl(struct file *file, unsigned int cmd,
 	struct lineevent_state *le = file->private_data;
 	void __user *ip = (void __user *)arg;
 	struct gpiohandle_data ghd;
+	struct gpio_chip *gc;
 
-	guard(srcu)(&le->gdev->srcu);
-
-	if (!rcu_access_pointer(le->gdev->chip))
+	REVOCABLE_TRY_ACCESS_WITH(le->chip_rev, gc);
+	if (!gc)
 		return -ENODEV;
 
 	/*
@@ -2081,7 +2090,12 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 	le = kzalloc(sizeof(*le), GFP_KERNEL);
 	if (!le)
 		return -ENOMEM;
-	le->gdev = gpio_device_get(gdev);
+
+	le->chip_rev = revocable_alloc(gdev->chip_rp);
+	if (!le->chip_rev) {
+		ret = -ENOMEM;
+		goto out_free_le;
+	}
 
 	if (eventreq.consumer_label[0] != '\0') {
 		/* label is only initialized if consumer_label is set */
-- 
2.52.0.457.g6b5491de43-goog


