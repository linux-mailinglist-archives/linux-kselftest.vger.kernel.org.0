Return-Path: <linux-kselftest+bounces-49112-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F78FD2DC2F
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 09:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF60E304012B
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 08:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1242F99BD;
	Fri, 16 Jan 2026 08:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeWNkbYA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE062F6193;
	Fri, 16 Jan 2026 08:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768551092; cv=none; b=MtXhn8H/GApKeWJVBL4ARw6fop/Sm/cRtDxe6rJJigOUkTv1DLZlZiYI1I4xJ3KH3aJ60tA9NUM1fRlZ+XgDkq35XTExe+aV67yxb9eucWLfs4cSP8udB+eliTDk+uNoh20Id/hhxxvePAA+X/WcCfKAjYZ/2zJNQQXM3jvYGFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768551092; c=relaxed/simple;
	bh=jLCvexvUVWTffqACdCAMqylaGOnO42aUQc431dwkOaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CGUG/4zaLRKq0IsZZhej2Ijj/oPoA744EeQamYkPXhy39soo+IcG7y2NDkwoJiCcVnbyJukhIlnIE38xbQpaqUHg94H/7cd9YaE02whXOz9UetCfXo8sQ3cV8kFDrpN413J8i1M7EeymI8js/E8C/x2sP2SYzHzSv6qXhd51euU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeWNkbYA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD60C19421;
	Fri, 16 Jan 2026 08:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768551091;
	bh=jLCvexvUVWTffqACdCAMqylaGOnO42aUQc431dwkOaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CeWNkbYAKQ5Pd6W8QPxVNX1zuCl2t7Ekik3S0XyD3xs7pNVe+enDalea4SLiUJMU5
	 SFlaGCZy6r0qBH3VW7S5GHiS7jQ+NNnlOD48KsmM1N/oh26y2AKC4jLjBjX1nxGfDu
	 /VRpvBw/EcbphiWecX6FlutOrbLty0oZRF/FyhY4wsakGdmZKdfycGbPd7JfsEsBQ0
	 U4knvb5IHvB5wHMFTUCoGLRQVe4OBwOP6wVOUx7Ps680V4vqT4VkY5QXRja3AWp5HN
	 bkibQfTVv35QnmTJ9kR1RSGMR4c+KgFyKIOFSSnvc9Vk05TBPYhXlm8Xd8R5Sdqhf3
	 bRtUvEOk7qlVw==
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
Subject: [PATCH 08/23] gpiolib: sysfs: Remove redundant check for struct gpio_chip
Date: Fri, 16 Jan 2026 08:10:21 +0000
Message-ID: <20260116081036.352286-9-tzungbi@kernel.org>
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

gpiochip_sysfs_unregister() is only called by gpiochip_remove() where
the struct gpio_chip is ensured.

Remove the redundant check.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/gpio/gpiolib-sysfs.c | 9 +--------
 drivers/gpio/gpiolib-sysfs.h | 6 ++++--
 drivers/gpio/gpiolib.c       | 2 +-
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index cd553acf3055..8e6b09d8b559 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -1048,11 +1048,10 @@ int gpiochip_sysfs_register(struct gpio_device *gdev)
 	return 0;
 }
 
-void gpiochip_sysfs_unregister(struct gpio_device *gdev)
+void gpiochip_sysfs_unregister(struct gpio_device *gdev, struct gpio_chip *chip)
 {
 	struct gpiodev_data *data;
 	struct gpio_desc *desc;
-	struct gpio_chip *chip;
 
 	scoped_guard(mutex, &sysfs_lock) {
 		data = gdev_get_data(gdev);
@@ -1066,12 +1065,6 @@ void gpiochip_sysfs_unregister(struct gpio_device *gdev)
 		kfree(data);
 	}
 
-	guard(srcu)(&gdev->srcu);
-
-	chip = srcu_dereference(gdev->chip, &gdev->srcu);
-	if (!chip)
-		return;
-
 	/* unregister gpiod class devices owned by sysfs */
 	for_each_gpio_desc_with_flag(chip, desc, GPIOD_FLAG_SYSFS) {
 		gpiod_unexport(desc);
diff --git a/drivers/gpio/gpiolib-sysfs.h b/drivers/gpio/gpiolib-sysfs.h
index b794b396d6a5..93debe8e118c 100644
--- a/drivers/gpio/gpiolib-sysfs.h
+++ b/drivers/gpio/gpiolib-sysfs.h
@@ -8,7 +8,8 @@ struct gpio_device;
 #ifdef CONFIG_GPIO_SYSFS
 
 int gpiochip_sysfs_register(struct gpio_device *gdev);
-void gpiochip_sysfs_unregister(struct gpio_device *gdev);
+void gpiochip_sysfs_unregister(struct gpio_device *gdev,
+			       struct gpio_chip *chip);
 
 #else
 
@@ -17,7 +18,8 @@ static inline int gpiochip_sysfs_register(struct gpio_device *gdev)
 	return 0;
 }
 
-static inline void gpiochip_sysfs_unregister(struct gpio_device *gdev)
+static inline void gpiochip_sysfs_unregister(struct gpio_device *gdev,
+					     struct gpio_chip *chip)
 {
 }
 
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 42da3bbc5ab8..c3e1465042c4 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1286,7 +1286,7 @@ void gpiochip_remove(struct gpio_chip *gc)
 	struct gpio_device *gdev = gc->gpiodev;
 
 	/* FIXME: should the legacy sysfs handling be moved to gpio_device? */
-	gpiochip_sysfs_unregister(gdev);
+	gpiochip_sysfs_unregister(gdev, gc);
 	gpiochip_free_hogs(gc);
 	gpiochip_free_remaining_irqs(gc);
 
-- 
2.52.0.457.g6b5491de43-goog


