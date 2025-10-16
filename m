Return-Path: <linux-kselftest+bounces-43286-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A20BE18BD
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 07:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD4934EFC5D
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 05:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E308C25524C;
	Thu, 16 Oct 2025 05:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjeExjP4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C242550CA;
	Thu, 16 Oct 2025 05:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760593392; cv=none; b=KujLf1Jj+OOCf94I7HJ40l1R6748NFrCg+uwuQhd3CG2nR6n0bMTtl7pLhWUFd975AG0yF/FWUQZ9mBqgPF2VYxPzA1gvRbWQuIZgZvHqudBgofIgL/GrYEp0Rj08bPLjAyvIElSX2BsHdrLQjPJWDpmgVRLUe+x4tJ4nNRXBkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760593392; c=relaxed/simple;
	bh=eIVI8OqgEV3xHp+az9XF8OTJlngtcvHJX8WxH8mJ3xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QMHVZ6xwUqT29jYX/iZeSnMmsWFV/fUnWxajYe8w8RTu2dUHDC2N5bmNsBz9ZkrImKHbfj88yj/0VghrC0/z+jo00Tv9FYhJ6h2xnbSJF7K389ltI/tqxivW45nbMc6zwwv9n2TJBKsBZ4isAxmO4sM0EOKNzp8D1s0LUqrQsl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjeExjP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC44AC4CEFE;
	Thu, 16 Oct 2025 05:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760593392;
	bh=eIVI8OqgEV3xHp+az9XF8OTJlngtcvHJX8WxH8mJ3xQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cjeExjP46ZUNLmcY7FIHFH8hwwe5PyprJG4sl+TBQKzk+A1GardBEaKZaNA8alXeM
	 Gu967SAsggH42UyYYtUCq1A4L/at5QaeM6drFxlpbMy9Q3uF7PEjcAwjVipIPrpxMu
	 ntENjMeNC1yZlLMQIVk2YYYFWMWzRd/S11/5J9FNVhwG19aojHMZ0TBmqkW+70fnO6
	 pgopi7c4Wb57uRIkw0Kw9zPhSpO1e/gIyMmGGO8CpUnjvEt3H+UR/kc6ntIr55ngYs
	 0HYZAZhnH2frOoL4+/uhdPMPjGaVFIAKjGVzBzc19mMtCggQ0zhszm5DP8KH+XBa72
	 8f2ctTv2EGbzA==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	tzungbi@kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 7/7] platform/chrome: cros_ec_chardev: Secure cros_ec_device via revocable
Date: Thu, 16 Oct 2025 05:42:04 +0000
Message-ID: <20251016054204.1523139-8-tzungbi@kernel.org>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
In-Reply-To: <20251016054204.1523139-1-tzungbi@kernel.org>
References: <20251016054204.1523139-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Miscdevice now supports revocable fops replacement.  Use it to secure
the cros_ec_device.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
PoC patch.

v5:
- No primary changes but modify the API usage accordingly.

v4: https://lore.kernel.org/chrome-platform/20250923075302.591026-8-tzungbi@kernel.org
- New in the series.

 drivers/platform/chrome/cros_ec_chardev.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_chardev.c b/drivers/platform/chrome/cros_ec_chardev.c
index c9d80ad5b57e..01691b023d7e 100644
--- a/drivers/platform/chrome/cros_ec_chardev.c
+++ b/drivers/platform/chrome/cros_ec_chardev.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/fs.h>
+#include <linux/fs_revocable.h>
 #include <linux/miscdevice.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -166,7 +167,6 @@ static int cros_ec_chardev_open(struct inode *inode, struct file *filp)
 	if (!priv)
 		return -ENOMEM;
 
-	priv->ec_dev = ec_dev;
 	priv->cmd_offset = ec->cmd_offset;
 	filp->private_data = priv;
 	INIT_LIST_HEAD(&priv->events);
@@ -370,6 +370,19 @@ static const struct file_operations chardev_fops = {
 #endif
 };
 
+static int cros_ec_chardev_rev_try_access(struct revocable **revs,
+					  size_t num_revs, void *data)
+{
+	struct chardev_priv *priv = data;
+
+	priv->ec_dev = revocable_try_access(revs[0]);
+	return priv->ec_dev ? 0 : -ENODEV;
+}
+
+static const struct fs_revocable_operations cros_ec_chardev_frops = {
+	.try_access = cros_ec_chardev_rev_try_access,
+};
+
 static int cros_ec_chardev_probe(struct platform_device *pdev)
 {
 	struct cros_ec_dev *ec = dev_get_drvdata(pdev->dev.parent);
@@ -386,6 +399,13 @@ static int cros_ec_chardev_probe(struct platform_device *pdev)
 	misc->name = ec_platform->ec_name;
 	misc->parent = pdev->dev.parent;
 
+	misc->rps = devm_kcalloc(&pdev->dev, 1, sizeof(*misc->rps), GFP_KERNEL);
+	if (!misc->rps)
+		return -ENOMEM;
+	misc->rps[0] = ec->ec_dev->revocable_provider;
+	misc->num_rps = 1;
+	misc->frops = &cros_ec_chardev_frops;
+
 	dev_set_drvdata(&pdev->dev, misc);
 
 	return misc_register(misc);
-- 
2.51.0.788.g6d19910ace-goog


