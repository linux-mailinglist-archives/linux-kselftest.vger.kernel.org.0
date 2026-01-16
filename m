Return-Path: <linux-kselftest+bounces-49106-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A8CD2DC68
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 09:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D03C930B470B
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 08:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1161F2F25FD;
	Fri, 16 Jan 2026 08:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDarakeb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACC3281520;
	Fri, 16 Jan 2026 08:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768551073; cv=none; b=bfVliZExOcveAA7SYeevDR5QKDoAv158ski9c73vruZZeDhOJlEqGXBuVSwH2fVzdvNRYhusnmdapW8T1WerokTTSElBW94zSUcjO+eovOkVm6PoRYtAXvzeziNz1BfPfh3lXIIWFt71QpOpvZN/P7YHrQpneRmjFF5XmVcWeXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768551073; c=relaxed/simple;
	bh=69pG6w4Xdr2sPbaRa1R8SZLmAPZBUmeVdfDx/U98QV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aw2OtTvy+x5mSkGdrA23nzm5e2fRjcj/lzFFjcZ0R0oTHvErv4gVtcqBQyNkc5kk/Wa1yFREJ3CXAc6YbHPgAvJZT3LaPUfCgsza7ByQtO76z5Ci43Ro4a63NFwh7hSFtA7W6XBfeGM7wvI+m+tL/mHVzrflUyGuc5ktvP6bK+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDarakeb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7585C19423;
	Fri, 16 Jan 2026 08:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768551073;
	bh=69pG6w4Xdr2sPbaRa1R8SZLmAPZBUmeVdfDx/U98QV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NDarakebh7JLgCgBuxTphef3UWbCWlNQzQ677JzLKyz4LFH4dJIeFUUxIU+Tl/+Su
	 +RVn/BFp31fO9p7/cvdAH6bO4FCfhTlPcxY0tPk3EZHpnxgssN7vdum2XuKdKFHRmU
	 HTEE60r/KPCpXVPNkUsc5orEtDRPeMngqSJd3+lVZjTutTANy7TbJLoSgFiqLmSLmI
	 pWJd+XvFyMBKgVf63S+1jqjs13YhF8O3zACCQe24nBYz7YLXG3b71h9mVidc/rKfa1
	 oGvtpJ68xqsEvnTKJc1FaPyh/9jekXbOlHOt5NBKSS2WC5wsHBKwnjnxGB0+lF9sFe
	 Wj4nhlBOoGCgQ==
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
Subject: [PATCH 02/23] gpiolib: cdev: Fix resource leaks on errors in gpiolib_cdev_register()
Date: Fri, 16 Jan 2026 08:10:15 +0000
Message-ID: <20260116081036.352286-3-tzungbi@kernel.org>
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

On error handling paths, gpiolib_cdev_register() doesn't free the
allocated resources which results leaks.  Fix it.

Cc: stable@vger.kernel.org
Fixes: 7b9b77a8bba9 ("gpiolib: add a per-gpio_device line state notification workqueue")
Fixes: d83cee3d2bb1 ("gpio: protect the pointer to gpio_chip in gpio_device with SRCU")
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/gpio/gpiolib-cdev.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 3735c9fe1502..ba1eae15852d 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2797,16 +2797,23 @@ int gpiolib_cdev_register(struct gpio_device *gdev, dev_t devt)
 
 	ret = cdev_device_add(&gdev->chrdev, &gdev->dev);
 	if (ret)
-		return ret;
+		goto err_free_workqueue;
 
 	guard(srcu)(&gdev->srcu);
 	gc = srcu_dereference(gdev->chip, &gdev->srcu);
-	if (!gc)
-		return -ENODEV;
+	if (!gc) {
+		ret = -ENODEV;
+		goto err_free_cdev;
+	}
 
 	gpiochip_dbg(gc, "added GPIO chardev (%d:%d)\n", MAJOR(devt), gdev->id);
 
 	return 0;
+err_free_cdev:
+	cdev_device_del(&gdev->chrdev, &gdev->dev);
+err_free_workqueue:
+	destroy_workqueue(gdev->line_state_wq);
+	return ret;
 }
 
 void gpiolib_cdev_unregister(struct gpio_device *gdev)
-- 
2.52.0.457.g6b5491de43-goog


