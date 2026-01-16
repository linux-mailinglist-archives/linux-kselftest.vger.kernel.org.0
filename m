Return-Path: <linux-kselftest+bounces-49109-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 678E5D2DCDE
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 09:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3126130DD350
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 08:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9512F6193;
	Fri, 16 Jan 2026 08:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0XcCk/r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B40B2F5473;
	Fri, 16 Jan 2026 08:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768551083; cv=none; b=D1Xo4StTbKiGl+YEDsZDIzf7MaN47Wtd78l1Gj8amk9J/vfMPVjFMCDN4TT1VqiRFdcK7FNfHT6HHKfFUfS6C6FU9GL0Wz9x06P126Kop/6DxCUytJ9GdCX3IUAEKE8KvJ+Yl2uq9B223Ug+53vgxLvmPIOzPvQcz7+hc4/mkmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768551083; c=relaxed/simple;
	bh=o6I48bINS/v0ZTjAILAUj4HkI//FxW9C0s2E5MLeE2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SWt+5mUpWSlB+7IjoSVoirg3P0tN1v4/S44CtHXjEKQKRQXXj/6fAjd7YhXObVFuwlriDn966EbCucU4/1uIxcO1poT51Xv2GbYDehWQsdEOgFkW1fsxcY1AhIT2pJ9tQ/kztyOjgubuS4dWnRfOKM6UD/eZr6vXMnR7vA8NZg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0XcCk/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC33C19424;
	Fri, 16 Jan 2026 08:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768551082;
	bh=o6I48bINS/v0ZTjAILAUj4HkI//FxW9C0s2E5MLeE2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U0XcCk/rwnoy5MgbxpLbRnzCKPzQYVvv5lG6LTSQIwuYRvQWYKtZ+yTCprXMpupx1
	 yZpWF7MacgzE7ZzijpOXlMpXDwbb1bKfuUbTJcAJLdre9UEckP34MA9KRkEZHl1IGX
	 Se0LxvvFy8PgVee6RRNTAfWIJ/IOEG1Riwe8SVGaQBzMHTCFA/dIXEyJMbkIQ9SA7x
	 VhmgfqFxTLAhJSFQmS/wYfEkmaR4S6x6qjDVJdnzRkzOEQWxHMoDlL/gwwOI/aTZnu
	 yw6K8/Tt97xAxNfMP/QeZB/7LjptIfGiTXVcV5R8EzVIrsbRmgIYajbuswY+hkLt26
	 /exGaWCUUpWaA==
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
Subject: [PATCH 05/23] gpiolib: cdev: Correct return code on memory allocation failure
Date: Fri, 16 Jan 2026 08:10:18 +0000
Message-ID: <20260116081036.352286-6-tzungbi@kernel.org>
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

-ENOMEM is a more appropriate return code for memory allocation
failures.  Correct it.

Fixes: 20bddcb40b2b ("gpiolib: cdev: replace locking wrappers for gpio_device with guards")
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/gpio/gpiolib-cdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 6196aab5ed74..66bd260c68e9 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2699,7 +2699,7 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 
 	cdev = kzalloc(sizeof(*cdev), GFP_KERNEL);
 	if (!cdev)
-		return -ENODEV;
+		return -ENOMEM;
 
 	cdev->watched_lines = bitmap_zalloc(gdev->ngpio, GFP_KERNEL);
 	if (!cdev->watched_lines)
-- 
2.52.0.457.g6b5491de43-goog


