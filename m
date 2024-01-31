Return-Path: <linux-kselftest+bounces-3787-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24658843342
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 03:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4611F24C80
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 02:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4ECCA7D;
	Wed, 31 Jan 2024 02:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="cqzL2BqK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962C45667;
	Wed, 31 Jan 2024 02:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706667366; cv=none; b=Us8U/eDC+yWj5D1BZFsXAiEmgQ0MvDn8XX/DApZAbDDBg3uEPf8s+XwI//gXhNc/qh3wMryGnTFDCS4jnDPC+fY0LuxRGarECEulJWylmrbuuiNAKQu23HPiHT8gx3sz6CkZp3+y2DkRnRJq+SucZHOgTZ1XekuZKff7jiQEw7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706667366; c=relaxed/simple;
	bh=I4trA2JfrK9wBwFoc8bTAUMVwA5tJ+kKV0vPGN6dfHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOyewLxdo/BDuCfFhGd+V7gFjBHFRUN4kBLft/jiTPvSbmZhsVeK+vF1+acGUFMX+XoZjPOz94W7Fz0TA4zDRBp44RlAbJRjehZ4n17+EMe5V/Yp39xa9FI7lv39K8ElAUUK2vUf00UHtNX7qa74f+5vaa2AQGqO6bH3R8rt9OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=cqzL2BqK; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=X/IZwfYWP9znQfddabnSoi+xBA9zWsqNxvzC3bQDVaM=; b=cqzL2BqKLT0kOzyVTWLpHtAvEn
	CokxLS83003PLTeKCseYL0B7nzWKw6waJ3UDbNRaafYfrc//BhVcx9Zao0981tSm2EeiA0ClrXoxG
	UzExgMJCWcy0ZaNjSWr1qAfxZmiDXDgYfv1vc/X8YPSUqgZALKygghsULFRunHTqpIqrINlJCIGXe
	JvWULanxOUx5Bp0g3zBrhSv640BZBjXxcJcasU4nFf3834DQREf/vub1O67GI9deb+4itk44+5c16
	+C+2O4gpet496MFsBKnzh8i/g2R3KR5WLRE7QdGkJNMFu0scFE8vsRUcnKl5TKmNhRWvEqxeMfr4d
	boR1AvqA==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rV08m-0038Kv-0L;
	Tue, 30 Jan 2024 20:15:52 -0600
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
	Elizabeth Figura <zfigura@codeweavers.com>
Subject: [RFC PATCH v2 01/29] ntsync: Introduce the ntsync driver and character device.
Date: Tue, 30 Jan 2024 20:13:28 -0600
Message-ID: <20240131021356.10322-2-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131021356.10322-1-zfigura@codeweavers.com>
References: <20240131021356.10322-1-zfigura@codeweavers.com>
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
 drivers/misc/Kconfig  |  9 ++++++++
 drivers/misc/Makefile |  1 +
 drivers/misc/ntsync.c | 52 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)
 create mode 100644 drivers/misc/ntsync.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 4fb291f0bf7c..bdd8a71bd853 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -504,6 +504,15 @@ config OPEN_DICE
 	  measured boot flow. Userspace can use CDIs for remote attestation
 	  and sealing.
 
+config NTSYNC
+	tristate "NT synchronization primitive emulation"
+	help
+	  This module provides kernel support for emulation of Windows NT
+	  synchronization primitives. It is not a hardware driver.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ntsync.
+
 	  If unsure, say N.
 
 config VCPU_STALL_DETECTOR
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
index 000000000000..e4969ef90722
--- /dev/null
+++ b/drivers/misc/ntsync.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ntsync.c - Kernel driver for NT synchronization primitives
+ *
+ * Copyright (C) 2024 Elizabeth Figura
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
+MODULE_AUTHOR("Elizabeth Figura");
+MODULE_DESCRIPTION("Kernel driver for NT synchronization primitives");
+MODULE_LICENSE("GPL");
-- 
2.43.0


