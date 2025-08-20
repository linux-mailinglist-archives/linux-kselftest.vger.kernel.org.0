Return-Path: <linux-kselftest+bounces-39356-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45924B2D5FB
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 10:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4490F165627
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 08:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B8E2DA74D;
	Wed, 20 Aug 2025 08:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0e2KWhX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE922D9EF8;
	Wed, 20 Aug 2025 08:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755677853; cv=none; b=cfLW3hq307VGw2whNG8Q3c38I5A40FGDPJzPfUJx4toic2Tj/za/bQ2DYWpLQYD90DB4GKO2+d6xr5oqs26tyYyojNv6LTZ959cQXqXIAU1r+8e7SHiDBTLe0uP0jk4ZLx4WOncKMHPk7aDf8iHlIh9Y12dEwIpj0tyde1E/zX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755677853; c=relaxed/simple;
	bh=7fsMezvoDQEYp2ae8oSLemUvrmjXu6gJVUF5jYa8vMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JPmMrVc9tGrigMVt0OHmxZMtz12zHdI+2+srw9jSXvNbr39CoWUsM5iBtn6mrjWNeNG8FYnXI9dgBKvnPtukb9ZiwrglAXg0Ec2UtltaIOTYqTVjU/ebyyE9t5VIL8Lxd7sDBIAI8NiJrAGFqe3x7ItgPU13LRB8mTLaaNEVGs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0e2KWhX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95987C113D0;
	Wed, 20 Aug 2025 08:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755677853;
	bh=7fsMezvoDQEYp2ae8oSLemUvrmjXu6gJVUF5jYa8vMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R0e2KWhXHtI1VnTHl1Fsv57y9Ww9+SKlB3nGZM6pSL3YwAMPT8McXEO95tHkLq2Op
	 /iPfv6auBcQxG49322bKL+ngXCmjs0yXnh32/eUkQ0X6FKF9yJDAZR49il2UnE/1jD
	 UAqUu0MPttMzasmpozO66zsy60OuZOgaKVcUT8Dg8PBfHWHb/bBVJ5gov+C5ktDLDB
	 A72KVVim2068GkQAznQ3vsxA99zdNN9LyOyIMZNJwbb4KTD/sYu50fDWSQRBJAJubj
	 RvdtSGsjfg8aTHFA4Au1TJa1WLDFkZB1c3Rqqn5JRZzXJuQYZrWhZKBvFQW8VRXAWY
	 apgMxufqMcEWA==
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
	tzungbi@kernel.org
Subject: [PATCH v2 4/5] platform/chrome: Protect cros_ec_device lifecycle with revocable
Date: Wed, 20 Aug 2025 08:16:44 +0000
Message-ID: <20250820081645.847919-5-tzungbi@kernel.org>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
In-Reply-To: <20250820081645.847919-1-tzungbi@kernel.org>
References: <20250820081645.847919-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cros_ec_device can be unregistered when the underlying device is
removed.  Other kernel drivers that interact with the EC may hold a
pointer to the cros_ec_device, creating a risk of a use-after-free
error if the EC device is removed while still being referenced.

To prevent this, leverage the revocable and convert the underlying
device drivers to resource providers of cros_ec_device.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
v2:
- Rename "ref_proxy" -> "revocable".

v1: https://lore.kernel.org/chrome-platform/20250814091020.1302888-3-tzungbi@kernel.org

 drivers/platform/chrome/cros_ec_i2c.c       | 5 +++++
 drivers/platform/chrome/cros_ec_ishtp.c     | 5 +++++
 drivers/platform/chrome/cros_ec_lpc.c       | 5 +++++
 drivers/platform/chrome/cros_ec_rpmsg.c     | 5 +++++
 drivers/platform/chrome/cros_ec_spi.c       | 4 ++++
 drivers/platform/chrome/cros_ec_uart.c      | 5 +++++
 include/linux/platform_data/cros_ec_proto.h | 4 ++++
 7 files changed, 33 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_i2c.c b/drivers/platform/chrome/cros_ec_i2c.c
index 38af97cdaab2..68a8d2c65ca3 100644
--- a/drivers/platform/chrome/cros_ec_i2c.c
+++ b/drivers/platform/chrome/cros_ec_i2c.c
@@ -12,6 +12,7 @@
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_device.h>
+#include <linux/revocable.h>
 #include <linux/slab.h>
 
 #include "cros_ec.h"
@@ -296,6 +297,10 @@ static int cros_ec_i2c_probe(struct i2c_client *client)
 	if (!ec_dev)
 		return -ENOMEM;
 
+	ec_dev->revocable_provider = devm_revocable_provider_alloc(dev, ec_dev);
+	if (!ec_dev->revocable_provider)
+		return -ENOMEM;
+
 	i2c_set_clientdata(client, ec_dev);
 	ec_dev->dev = dev;
 	ec_dev->priv = client;
diff --git a/drivers/platform/chrome/cros_ec_ishtp.c b/drivers/platform/chrome/cros_ec_ishtp.c
index 7e7190b30cbb..3467b4e9ceb5 100644
--- a/drivers/platform/chrome/cros_ec_ishtp.c
+++ b/drivers/platform/chrome/cros_ec_ishtp.c
@@ -12,6 +12,7 @@
 #include <linux/pci.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
+#include <linux/revocable.h>
 #include <linux/intel-ish-client-if.h>
 
 #include "cros_ec.h"
@@ -547,6 +548,10 @@ static int cros_ec_dev_init(struct ishtp_cl_data *client_data)
 	if (!ec_dev)
 		return -ENOMEM;
 
+	ec_dev->revocable_provider = devm_revocable_provider_alloc(dev, ec_dev);
+	if (!ec_dev->revocable_provider)
+		return -ENOMEM;
+
 	client_data->ec_dev = ec_dev;
 	dev->driver_data = ec_dev;
 
diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 7d9a78289c96..77bdaf430979 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/printk.h>
 #include <linux/reboot.h>
+#include <linux/revocable.h>
 #include <linux/suspend.h>
 
 #include "cros_ec.h"
@@ -641,6 +642,10 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 	if (!ec_dev)
 		return -ENOMEM;
 
+	ec_dev->revocable_provider = devm_revocable_provider_alloc(dev, ec_dev);
+	if (!ec_dev->revocable_provider)
+		return -ENOMEM;
+
 	platform_set_drvdata(pdev, ec_dev);
 	ec_dev->dev = dev;
 	ec_dev->phys_name = dev_name(dev);
diff --git a/drivers/platform/chrome/cros_ec_rpmsg.c b/drivers/platform/chrome/cros_ec_rpmsg.c
index bc2666491db1..04d886829aa7 100644
--- a/drivers/platform/chrome/cros_ec_rpmsg.c
+++ b/drivers/platform/chrome/cros_ec_rpmsg.c
@@ -10,6 +10,7 @@
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_device.h>
+#include <linux/revocable.h>
 #include <linux/rpmsg.h>
 #include <linux/slab.h>
 
@@ -220,6 +221,10 @@ static int cros_ec_rpmsg_probe(struct rpmsg_device *rpdev)
 	if (!ec_dev)
 		return -ENOMEM;
 
+	ec_dev->revocable_provider = devm_revocable_provider_alloc(dev, ec_dev);
+	if (!ec_dev->revocable_provider)
+		return -ENOMEM;
+
 	ec_rpmsg = devm_kzalloc(dev, sizeof(*ec_rpmsg), GFP_KERNEL);
 	if (!ec_rpmsg)
 		return -ENOMEM;
diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index 8ca0f854e7ac..1b611ec5c9c1 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -10,6 +10,7 @@
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_device.h>
+#include <linux/revocable.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <uapi/linux/sched/types.h>
@@ -752,6 +753,9 @@ static int cros_ec_spi_probe(struct spi_device *spi)
 	ec_dev = devm_kzalloc(dev, sizeof(*ec_dev), GFP_KERNEL);
 	if (!ec_dev)
 		return -ENOMEM;
+	ec_dev->revocable_provider = devm_revocable_provider_alloc(dev, ec_dev);
+	if (!ec_dev->revocable_provider)
+		return -ENOMEM;
 
 	/* Check for any DT properties */
 	cros_ec_spi_dt_probe(ec_spi, dev);
diff --git a/drivers/platform/chrome/cros_ec_uart.c b/drivers/platform/chrome/cros_ec_uart.c
index 19c179d49c90..b234f13a92a9 100644
--- a/drivers/platform/chrome/cros_ec_uart.c
+++ b/drivers/platform/chrome/cros_ec_uart.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_data/cros_ec_proto.h>
+#include <linux/revocable.h>
 #include <linux/serdev.h>
 #include <linux/slab.h>
 #include <uapi/linux/sched/types.h>
@@ -263,6 +264,10 @@ static int cros_ec_uart_probe(struct serdev_device *serdev)
 	if (!ec_dev)
 		return -ENOMEM;
 
+	ec_dev->revocable_provider = devm_revocable_provider_alloc(dev, ec_dev);
+	if (!ec_dev->revocable_provider)
+		return -ENOMEM;
+
 	serdev_device_set_drvdata(serdev, ec_dev);
 	init_waitqueue_head(&ec_uart->response.wait_queue);
 
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 3ec24f445c29..0c3df0bb0aa4 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -12,6 +12,7 @@
 #include <linux/lockdep_types.h>
 #include <linux/mutex.h>
 #include <linux/notifier.h>
+#include <linux/revocable.h>
 
 #include <linux/platform_data/cros_ec_commands.h>
 
@@ -158,6 +159,7 @@ struct cros_ec_command {
  * @pd: The platform_device used by the mfd driver to interface with the
  *      PD behind an EC.
  * @panic_notifier: EC panic notifier.
+ * @revocable_provider: The revocable_provider to this device.
  */
 struct cros_ec_device {
 	/* These are used by other drivers that want to talk to the EC */
@@ -203,6 +205,8 @@ struct cros_ec_device {
 	struct platform_device *pd;
 
 	struct blocking_notifier_head panic_notifier;
+
+	struct revocable_provider *revocable_provider;
 };
 
 /**
-- 
2.51.0.rc1.167.g924127e9c0-goog


