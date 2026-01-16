Return-Path: <linux-kselftest+bounces-49118-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EBDD2DCA3
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 09:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E7A93088DF9
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 08:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DF72FFF80;
	Fri, 16 Jan 2026 08:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIb5ZjIK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD602FF67F;
	Fri, 16 Jan 2026 08:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768551110; cv=none; b=nqhoSkzTxDbmt9EPgMaiLmduBWGuOlQgA4uLAja2ZtxV40y7cX2VabDsyuaZ/PPsiIYRmujqnqi4zctrpc0FvUAvG1AChncnOT/AVPfuZXNpoXk4XDwhR3Xhi6zUqLiJViGwXuzwcf8s5Mgooj6EoTacYNLov+fUGKRDxB7HNFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768551110; c=relaxed/simple;
	bh=GLd0pO6DDW0qCQ2R2su1AekMIqpgOgZ3a4dUXAlVYsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t2uL7qrMRXLB0nc96ZDhx0PKCqBch6tEIqmJjtFAFAOxNoQofvTuR/3/6Ut0ZL8gZdH1KyGGkD8ciXPKDFWQDnaM3LQMCkKH0ycflOqCSjsuGYKiV90NOYgp4Fyo17eMWlUQ6FbqY3aUE+etbmZ903yUWJi9LhgWjGnYgbyHNDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIb5ZjIK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B32C19424;
	Fri, 16 Jan 2026 08:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768551110;
	bh=GLd0pO6DDW0qCQ2R2su1AekMIqpgOgZ3a4dUXAlVYsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nIb5ZjIKJWdz6K8+6araDGUin32VHdwfUQQbDFc/suftp1u0KxcvT/0681Ge5/f42
	 BGlQAXU1Cjd7kMHiCnGs3h4T7BkIOgxS8sAqeRnNFM5NChSuHN8D6Z5UJaPTFYTIg/
	 ZhVoAw9c//GTDNk4WL9vRwBJNCrms+CWHa9eVwxyZFVjUlcMsIiCBKAVysRPAss9OL
	 BEDV9oM2WL98TVg7/8F+6vG8OIj9A8FA9ZjHyvXS9ook5+3vUkwINXBQNpEZCmbLm6
	 7VHrVjf4lAU58OsNyGvBmn1edrkuL21fB/41zY0p1p2jX12M62ENqv/KJB7TPcU9uY
	 RX/wHeSAyQEkQ==
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
Subject: [PATCH 14/23] gpiolib: cdev: Leverage revocable for linehandle_fileops
Date: Fri, 16 Jan 2026 08:10:27 +0000
Message-ID: <20260116081036.352286-15-tzungbi@kernel.org>
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
struct gpio_chip.  Leverage revocable for linehandle_fileops so that it
doesn't need to handle the synchronization by accessing the SRCU
explicitly.

Also, it's unneeded to hold a reference count to the struct gpio_device
while the file is opening.  The struct gpio_device
(i.e., (struct gpio_chip *)->gpiodev)) is valid as long as struct
gpio_chip is valid.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/gpio/gpiolib-cdev.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 832a542c4f7a..f7c6f1367235 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -67,13 +67,13 @@ static_assert(IS_ALIGNED(sizeof(struct gpio_v2_line_values), 8));
 #ifdef CONFIG_GPIO_CDEV_V1
 /**
  * struct linehandle_state - contains the state of a userspace handle
- * @gdev: the GPIO device the handle pertains to
+ * @chip_rev: revocable consumer handle for the corresponding struct gpio_chip
  * @label: consumer label used to tag descriptors
  * @descs: the GPIO descriptors held by this handle
  * @num_descs: the number of descriptors held in the descs array
  */
 struct linehandle_state {
-	struct gpio_device *gdev;
+	struct revocable *chip_rev;
 	const char *label;
 	struct gpio_desc *descs[GPIOHANDLES_MAX];
 	u32 num_descs;
@@ -211,10 +211,10 @@ static long linehandle_ioctl(struct file *file, unsigned int cmd,
 	DECLARE_BITMAP(vals, GPIOHANDLES_MAX);
 	unsigned int i;
 	int ret;
+	struct gpio_chip *gc;
 
-	guard(srcu)(&lh->gdev->srcu);
-
-	if (!rcu_access_pointer(lh->gdev->chip))
+	REVOCABLE_TRY_ACCESS_WITH(lh->chip_rev, gc);
+	if (!gc)
 		return -ENODEV;
 
 	switch (cmd) {
@@ -279,7 +279,8 @@ static void linehandle_free(struct linehandle_state *lh)
 		if (lh->descs[i])
 			gpiod_free(lh->descs[i]);
 	kfree(lh->label);
-	gpio_device_put(lh->gdev);
+	if (lh->chip_rev)
+		revocable_free(lh->chip_rev);
 	kfree(lh);
 }
 
@@ -322,7 +323,10 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
 	lh = kzalloc(sizeof(*lh), GFP_KERNEL);
 	if (!lh)
 		return -ENOMEM;
-	lh->gdev = gpio_device_get(gdev);
+
+	lh->chip_rev = revocable_alloc(gdev->chip_rp);
+	if (!lh->chip_rev)
+		return -ENOMEM;
 
 	if (handlereq.consumer_label[0] != '\0') {
 		/* label is only initialized if consumer_label is set */
-- 
2.52.0.457.g6b5491de43-goog


