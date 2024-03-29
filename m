Return-Path: <linux-kselftest+bounces-6818-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18ACE890F91
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 01:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49C4C1C2AE3B
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 00:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12B3446B5;
	Fri, 29 Mar 2024 00:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="HpBeEPh3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CF042073;
	Fri, 29 Mar 2024 00:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671871; cv=none; b=TQ1Q4YlJDL9ppR6pSyDCMimOb2fHk15s6phxxJPu8gP4PRomUWcHSLHX7OtbbEHPBbpGTKML6+EkypgMlfFgfz7q6EjWmJUGs+5bRx3or7KkS0TanChs3Z/dyp/kiuCILLNh5WrPMcviH13SfGoqnL86Tn80TWV1a4k7SCY0Ov0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671871; c=relaxed/simple;
	bh=UXKmd/tB5MoVcAQ9w02fckyfMxcSHRdyv+iPNlCu+YA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFAkrZ2pH6W+fCnTNHnofzfZDmjaOmPNQ0GUAE5c2qsMgfxlC/dWYf8EPjl1TQoJ2/gKrBIgmaxTwFPcVgdHkaqxwF8QOmgZe+Euzz0apXxt0n3IxMv6VBejdVvwOqhQyqgXwsjdaUQXWKX4vI1nKYLH8Qajpuj9IiMeY5AaxFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=HpBeEPh3; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=/i5nF4410gEXNHjyrEQSUz30K2sNvrn0R5ExzpIN3gw=; b=HpBeEPh3oi4kKFCyJo5hcDq2FL
	7U8V7n9Ar6Nq8TpmR1ahqKP3IZ0dmBA9aC5AXORmHQKv7cZIm4BL1C5+j79VZ7wuUVUdHtcO+pOQ2
	CARQq/rpZQ9z6UckzvTteOERGEE3x3JTALWwptZhk7t6KcwXAXL3aGILfyoE3qD5yYCTt0VQLGqzL
	EnjVLnw19BWHsulsfkVzPq1eT+VyLB9pcXNnEJO+GOiZT+bw17izYfM3FgcYjSpTiN7ZRyfsmsF6J
	U7ikSGg4vw/Tkw2H4V1GzeHis0cTxID2U9vQ9wcUE0gy+CAsXe/NEZj3w/cH7vGPhZeB9ic8i82Eo
	qMM+QzLQ==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rpzlL-000iik-30;
	Thu, 28 Mar 2024 19:06:27 -0500
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	wine-devel@winehq.org,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Elizabeth Figura <zfigura@codeweavers.com>
Subject: [PATCH v3 01/30] ntsync: Introduce the ntsync driver and character device.
Date: Thu, 28 Mar 2024 19:05:52 -0500
Message-ID: <20240329000621.148791-2-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329000621.148791-1-zfigura@codeweavers.com>
References: <20240329000621.148791-1-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntsync uses a misc device as the simplest and least intrusive uAPI interface.

Each file description on the device represents an isolated NT instance, intended
to correspond to a single NT virtual machine.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/Kconfig  | 11 +++++++++
 drivers/misc/Makefile |  1 +
 drivers/misc/ntsync.c | 52 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+)
 create mode 100644 drivers/misc/ntsync.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 4fb291f0bf7c..801ed229ed7d 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -506,6 +506,17 @@ config OPEN_DICE
 
 	  If unsure, say N.
 
+config NTSYNC
+	tristate "NT synchronization primitive emulation"
+	help
+	  This module provides kernel support for emulation of Windows NT
+	  synchronization primitives. It is not a hardware driver.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ntsync.
+
+	  If unsure, say N.
+
 config VCPU_STALL_DETECTOR
 	tristate "Guest vCPU stall detector"
 	depends on OF && HAS_IOMEM
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index ea6ea5bbbc9c..153a3f4837e8 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_PVPANIC)   	+= pvpanic/
 obj-$(CONFIG_UACCE)		+= uacce/
 obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
 obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
+obj-$(CONFIG_NTSYNC)		+= ntsync.o
 obj-$(CONFIG_HI6421V600_IRQ)	+= hi6421v600-irq.o
 obj-$(CONFIG_OPEN_DICE)		+= open-dice.o
 obj-$(CONFIG_GP_PCI1XXXX)	+= mchp_pci1xxxx/
diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
new file mode 100644
index 000000000000..bd76e653d83e
--- /dev/null
+++ b/drivers/misc/ntsync.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ntsync.c - Kernel driver for NT synchronization primitives
+ *
+ * Copyright (C) 2024 Elizabeth Figura <zfigura@codeweavers.com>
+ */
+
+#include <linux/fs.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+
+#define NTSYNC_NAME	"ntsync"
+
+static int ntsync_char_open(struct inode *inode, struct file *file)
+{
+	return nonseekable_open(inode, file);
+}
+
+static int ntsync_char_release(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+static long ntsync_char_ioctl(struct file *file, unsigned int cmd,
+			      unsigned long parm)
+{
+	switch (cmd) {
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+
+static const struct file_operations ntsync_fops = {
+	.owner		= THIS_MODULE,
+	.open		= ntsync_char_open,
+	.release	= ntsync_char_release,
+	.unlocked_ioctl	= ntsync_char_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
+	.llseek		= no_llseek,
+};
+
+static struct miscdevice ntsync_misc = {
+	.minor		= MISC_DYNAMIC_MINOR,
+	.name		= NTSYNC_NAME,
+	.fops		= &ntsync_fops,
+};
+
+module_misc_device(ntsync_misc);
+
+MODULE_AUTHOR("Elizabeth Figura <zfigura@codeweavers.com>");
+MODULE_DESCRIPTION("Kernel driver for NT synchronization primitives");
+MODULE_LICENSE("GPL");
-- 
2.43.0


