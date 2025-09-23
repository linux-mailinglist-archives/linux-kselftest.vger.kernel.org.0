Return-Path: <linux-kselftest+bounces-42137-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CE9B94E0B
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 09:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CAF22E30A6
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E482931D397;
	Tue, 23 Sep 2025 07:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBH9eflq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B256031815E;
	Tue, 23 Sep 2025 07:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758614057; cv=none; b=gVMO/od8DYDFFm9o8kAxv2looy0fg77YH+x9X2uHIeVXkIFnSgGtSg4qffHSMcAMYiuWKI+92rOvpWZgKW7vddUj8tDdca0w23L9zQPZ2eJjpPMzpuvtqx0isYLRYfjltSaYE39mDm4hYNMbO8QsonBEGmxvjQ+sbVvDzgEEs44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758614057; c=relaxed/simple;
	bh=THUGc4v7Y/ExVXfzj7FTsIjB1vKSzxAYZTfacIndzW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQSBEC7LL52HNDK8nfAYo5AV4wGEZa/uIhtiGFFsMEZvuWOEUP9i9nlPCymmLmfNidC5Havo/rDMqvFdgwoONbjN6lGqe6Efdyi5jlHLcZcFZhepVNh9zD3NFuDpqvq2efv3OdSShXtIwx5xt2M0+IuRSikdGjBTkfjRNZDmmEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBH9eflq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024E3C4CEF5;
	Tue, 23 Sep 2025 07:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758614055;
	bh=THUGc4v7Y/ExVXfzj7FTsIjB1vKSzxAYZTfacIndzW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dBH9eflqvX69Gc/sheG0eTn6ugFiZVZPhb2LUZybOnl/zbPvNzfMydO2GTa0AmSlB
	 ZnFebMRH0FHuotgfIO/NuRbyDRyaRi58XLjNFlKpc3wy9WQMSFKWMZQVXcftP52GJw
	 RZSPHekjTmFR39pkhMO4+2QXKTPvk8BHjiTIiLXleoIX0EMl1EXmVq4Fzu/oUCRlyw
	 RKypsQh12fJoN4nDsWbQC7B9haZYA83v8D3UJIVXLuBRWz6+J++VI5jNl66cQuO/Iz
	 Qg2z50E8yQ1u39O5PUucYuZP7V1LzmUorS3YOwsEfPewSqjXOu67ckQq4IzK22vkgm
	 rIj0249SSQRlg==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Dawid Niedzwiecki <dawidn@google.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	tzungbi@kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v4 7/7] platform/chrome: cros_ec_chardev: Secure cros_ec_device via revocable
Date: Tue, 23 Sep 2025 07:53:02 +0000
Message-ID: <20250923075302.591026-8-tzungbi@kernel.org>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
In-Reply-To: <20250923075302.591026-1-tzungbi@kernel.org>
References: <20250923075302.591026-1-tzungbi@kernel.org>
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

v4:
- New in the series.

 drivers/platform/chrome/cros_ec_chardev.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_chardev.c b/drivers/platform/chrome/cros_ec_chardev.c
index c9d80ad5b57e..cacc73635d6b 100644
--- a/drivers/platform/chrome/cros_ec_chardev.c
+++ b/drivers/platform/chrome/cros_ec_chardev.c
@@ -166,7 +166,6 @@ static int cros_ec_chardev_open(struct inode *inode, struct file *filp)
 	if (!priv)
 		return -ENOMEM;
 
-	priv->ec_dev = ec_dev;
 	priv->cmd_offset = ec->cmd_offset;
 	filp->private_data = priv;
 	INIT_LIST_HEAD(&priv->events);
@@ -370,6 +369,18 @@ static const struct file_operations chardev_fops = {
 #endif
 };
 
+static int cros_ec_chardev_rev_try_access(struct revocable *rev, void *data)
+{
+	struct chardev_priv *priv = data;
+
+	priv->ec_dev = revocable_try_access(rev);
+	return priv->ec_dev ? 0 : -ENODEV;
+}
+
+static const struct revocable_operations cros_ec_chardev_rops = {
+	.try_access = cros_ec_chardev_rev_try_access,
+};
+
 static int cros_ec_chardev_probe(struct platform_device *pdev)
 {
 	struct cros_ec_dev *ec = dev_get_drvdata(pdev->dev.parent);
@@ -385,6 +396,8 @@ static int cros_ec_chardev_probe(struct platform_device *pdev)
 	misc->fops = &chardev_fops;
 	misc->name = ec_platform->ec_name;
 	misc->parent = pdev->dev.parent;
+	misc->rp = ec->ec_dev->revocable_provider;
+	misc->rops = &cros_ec_chardev_rops;
 
 	dev_set_drvdata(&pdev->dev, misc);
 
-- 
2.51.0.534.gc79095c0ca-goog


