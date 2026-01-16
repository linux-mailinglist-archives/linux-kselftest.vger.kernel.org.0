Return-Path: <linux-kselftest+bounces-49121-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E614D2DDE7
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 09:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E995530A1EA2
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 08:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A58303A1D;
	Fri, 16 Jan 2026 08:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBWBDz9W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE7F2FD1C1;
	Fri, 16 Jan 2026 08:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768551119; cv=none; b=OETRFsY9pkdIdpfW5Qv2kyNRxrIdz7X30i4yrVzfoRBmAQUxwqTFVPk9fAdOlngOYIUMIak5AGnEO0I68VxEETFJ2s9WeM2ciG3O448VtDZN6SNZlmCYiW2oo/NnlQV9l7BpiDAMMr7VoTyXGMZMm/AvLhfcEGCMF6u9wQ297/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768551119; c=relaxed/simple;
	bh=vyYMV5QhjflcofTLaNItfu44HrOf/uN6d8iFrlO8uOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HvNyxfTmohj+891C2JrStee5xYYyKTxjaqMObPK55wGavGY+LIwglEuHQarik6139jSdhiP2f6WF/xWlX1eZyIie7713Gtc33JxQR5NqeKHBY7f550i1P1LwHAU5LA0rKHS6hAy8RlS6oUwRLw7P7SZfdpU+XC4Yi1CaExdPoxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBWBDz9W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B15C19423;
	Fri, 16 Jan 2026 08:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768551119;
	bh=vyYMV5QhjflcofTLaNItfu44HrOf/uN6d8iFrlO8uOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vBWBDz9W7QDcLCgO/btne0VY50vcex8VOreTFCRw8HxOp3KfBbLme09Z6ayUuf7AI
	 cXm11s28nlbDpPsMNh2zx/MBS/+YAcCjMyHhJEJfoL9vgB2IPDmHaDU9CpTQzUPlrX
	 xmtSQpdoK9Rn7Qa+FEzHCr2kFhhKmZc9mEce0zNCG8WqJvEqANXfECWL7iyurDBz5z
	 L9/HiPxtjI+Cxr5d69G0pjSyrplfA2744ttFHg3OvxaxiKPZ9+KpdVgpXIGrystqys
	 j+gCbA6lrOat/8Ez9QffvKmkSStNCBhDqQksU/cSeiMLpUxAkf5IvkpIHq/wC8gugL
	 VpirQKwZ6vXeQ==
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
Subject: [PATCH 17/23] gpiolib: cdev: Leverage revocable for lineinfo_changed_notify
Date: Fri, 16 Jan 2026 08:10:30 +0000
Message-ID: <20260116081036.352286-18-tzungbi@kernel.org>
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
struct gpio_chip.  Leverage revocable for lineinfo_changed_notify so
that it doesn't need to handle the synchronization by accessing the SRCU
explicitly.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/gpio/gpiolib-cdev.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 54150d718931..1a4dde56dc0c 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2522,6 +2522,7 @@ struct lineinfo_changed_ctx {
 	struct gpio_v2_line_info_changed chg;
 	struct gpio_device *gdev;
 	struct gpio_chardev_data *cdev;
+	struct revocable *chip_rev;
 };
 
 static void lineinfo_changed_func(struct work_struct *work)
@@ -2538,12 +2539,9 @@ static void lineinfo_changed_func(struct work_struct *work)
 		 * Pin functions are in general much more static and while it's
 		 * not 100% bullet-proof, it's good enough for most cases.
 		 */
-		scoped_guard(srcu, &ctx->gdev->srcu) {
-			gc = srcu_dereference(ctx->gdev->chip, &ctx->gdev->srcu);
-			if (gc &&
-			    !pinctrl_gpio_can_use_line(gc, ctx->chg.info.offset))
-				ctx->chg.info.flags |= GPIO_V2_LINE_FLAG_USED;
-		}
+		REVOCABLE_TRY_ACCESS_WITH(ctx->chip_rev, gc);
+		if (gc && !pinctrl_gpio_can_use_line(gc, ctx->chg.info.offset))
+			ctx->chg.info.flags |= GPIO_V2_LINE_FLAG_USED;
 	}
 
 	ret = kfifo_in_spinlocked(&ctx->cdev->events, &ctx->chg, 1,
@@ -2553,6 +2551,7 @@ static void lineinfo_changed_func(struct work_struct *work)
 	else
 		pr_debug_ratelimited("lineinfo event FIFO is full - event dropped\n");
 
+	revocable_free(ctx->chip_rev);
 	gpio_device_put(ctx->gdev);
 	fput(ctx->cdev->fp);
 	kfree(ctx);
@@ -2599,11 +2598,19 @@ static int lineinfo_changed_notify(struct notifier_block *nb,
 	/* Keep the GPIO device alive until we emit the event. */
 	ctx->gdev = gpio_device_get(desc->gdev);
 	ctx->cdev = cdev;
+	ctx->chip_rev = revocable_alloc(desc->gdev->chip_rp);
+	if (!ctx->chip_rev) {
+		pr_err("Failed to allocate memory for revocable handle\n");
+		goto err_put_device;
+	}
 
 	INIT_WORK(&ctx->work, lineinfo_changed_func);
 	queue_work(ctx->gdev->line_state_wq, &ctx->work);
 
 	return NOTIFY_OK;
+err_put_device:
+	gpio_device_put(desc->gdev);
+	kfree(ctx);
 err_put_fp:
 	fput(fp);
 	return NOTIFY_DONE;
-- 
2.52.0.457.g6b5491de43-goog


