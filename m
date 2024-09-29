Return-Path: <linux-kselftest+bounces-18554-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE654989807
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Sep 2024 23:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56C51F213CE
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Sep 2024 21:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FF4183094;
	Sun, 29 Sep 2024 21:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="QHRy5NPu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6827346D;
	Sun, 29 Sep 2024 21:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727646473; cv=none; b=hzVVAOD+SmMZwsHhAvmRMRCci1lNWRYNREeiM2s3xHsHA+mkBxbfmo98xk/a350E2x3cR1WO7cfgDhnNASuTDAJLO1+xaz3xqeCz5eZURdU5TnxjY2ROhr2g9H2pB/tIZ6+r1ofHaE7Qt36kL0NsvhOJDU2pLH8oSkR3pFPJVt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727646473; c=relaxed/simple;
	bh=2joTg9n3pFsrGMI75n766a/8WHAgaUxkWPplo5U8Xrw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RMeSjUPu/CvKU17n+LgqfZVexjRqAJcGKT8Ye6/qqmVAnCOdz6kfhsCHulig4rjvhlGwq8tHRc5D2jgaEn3+ei7QvItq3mUsVswbDtlYx7pF//d0AH8NbpvCcZFpImoo31dpxjaxn5ph1KWn7TaZipp1MeeDFoTh5xi+QgUwcQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=QHRy5NPu; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1727646464;
	bh=2joTg9n3pFsrGMI75n766a/8WHAgaUxkWPplo5U8Xrw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QHRy5NPugoOAP0ZBYGf6jNGXwRaDTNqLYpk/GbdfYkuWoNd2pnKVzBZ1n7IvjKqwa
	 mnxknStXms2/Q70Zv/6pjvNE5yJwyPXleZcXlYNX8QSREF5smO5Jh3VRu1WEcSkQDc
	 VdmyBH1Msv6gmpISeX5/uGq+AadfiukCuBysACCY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 29 Sep 2024 23:47:36 +0200
Subject: [PATCH 1/5] drivers/virt: introduce csky_exit system poweroff
 driver
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240929-nolibc-csky-v1-1-bb28031a73b0@weissschuh.net>
References: <20240929-nolibc-csky-v1-0-bb28031a73b0@weissschuh.net>
In-Reply-To: <20240929-nolibc-csky-v1-0-bb28031a73b0@weissschuh.net>
To: Guo Ren <guoren@kernel.org>, Willy Tarreau <w@1wt.eu>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727646464; l=3761;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=2joTg9n3pFsrGMI75n766a/8WHAgaUxkWPplo5U8Xrw=;
 b=EoJZ0xJNKUTDAhAgaDW1XtW6lSt34IP8BGf6n6Hk/0whDaOrVruBUBvvZ5bEfYD0TWFiXH2Ii
 cenyIMPvF9zC4u0l/cU0tfxRHDI/cGgW+5jpAYNMbzebyVQGQwxhAOW
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The C-SKY architecture does not support ACPI and no other standardized
mechanism for system poweroff.
On QEMU a virtual device "csky_exit" is available which can be used for
poweroff.
Add a driver for this virtual device.

There are more features provided by the device but these are not
required at this time and therefore not supported yet.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

---
The OF compatible will never show up in a DTS file, it is synthesized by
QEMU. Therefore I think it doesn't need explicit documentation.
---
 drivers/virt/Kconfig     | 11 ++++++++++
 drivers/virt/Makefile    |  1 +
 drivers/virt/csky_exit.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+)

diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index d8c848cf09a6afad65b28be20f5fd7e90a0c5307..652546c52d2e00138a782b949672d47c5f5d2189 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -41,6 +41,17 @@ config FSL_HV_MANAGER
           4) A kernel interface for receiving callbacks when a managed
 	     partition shuts down.
 
+config CSKY_EXIT
+	tristate "C-SKY QEMU shutdown driver"
+	depends on OF
+	depends on CSKY || COMPILE_TEST
+	help
+	  This driver supports system shutdown via the virtual csky_exit device
+	  provided by QEMU.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called csky_exit.
+
 source "drivers/virt/vboxguest/Kconfig"
 
 source "drivers/virt/nitro_enclaves/Kconfig"
diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
index f29901bd782058d3552cdec2c2128ad47ce6fe27..5c62db9fbfa501a31c87c4902f835db91633daeb 100644
--- a/drivers/virt/Makefile
+++ b/drivers/virt/Makefile
@@ -3,6 +3,7 @@
 # Makefile for drivers that support virtualization
 #
 
+obj-$(CONFIG_CSKY_EXIT)		+= csky_exit.o
 obj-$(CONFIG_FSL_HV_MANAGER)	+= fsl_hypervisor.o
 obj-$(CONFIG_VMGENID)		+= vmgenid.o
 obj-y				+= vboxguest/
diff --git a/drivers/virt/csky_exit.c b/drivers/virt/csky_exit.c
new file mode 100644
index 0000000000000000000000000000000000000000..6f42eb74071ab9ac1b7e9ef03b32f9ba0ef2cf26
--- /dev/null
+++ b/drivers/virt/csky_exit.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * C-SKY QEMU shutdown driver
+ *
+ *  Copyright (C) 2024 Thomas Weißschuh <linux@weissschuh.net>
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/types.h>
+
+#define CSKY_EXIT_COMMAND_EXIT	0
+
+static void csky_exit_command(void __iomem *base, u32 command, u64 value)
+{
+	writew(value, base + command);
+}
+
+static int csky_exit_poweroff(struct sys_off_data *data)
+{
+	csky_exit_command(data->cb_data, CSKY_EXIT_COMMAND_EXIT, 0);
+	return 0;
+}
+
+static int csky_exit_probe(struct platform_device *pdev)
+{
+	void __iomem *base;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	return devm_register_sys_off_handler(&pdev->dev, SYS_OFF_MODE_POWER_OFF,
+					     SYS_OFF_PRIO_PLATFORM + 1,
+					     csky_exit_poweroff, base);
+}
+
+static const struct of_device_id csky_exit_match[] = {
+	{ .compatible = "csky,qemu-exit" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, csky_exit_match);
+
+static struct platform_driver csky_exit_driver = {
+	.driver.name = "csky_exit",
+	.driver.of_match_table = csky_exit_match,
+	.probe = csky_exit_probe,
+};
+module_platform_driver(csky_exit_driver);
+
+MODULE_AUTHOR("Thomas Weißschuh <linux@weissschuh.net>");
+MODULE_DESCRIPTION("C-SKY QEMU shutdown driver");
+MODULE_LICENSE("GPL");

-- 
2.46.2


