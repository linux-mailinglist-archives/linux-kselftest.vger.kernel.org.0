Return-Path: <linux-kselftest+bounces-46546-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B48C8B9CA
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 20:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97C053B9716
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 19:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D98342510;
	Wed, 26 Nov 2025 19:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z3gtCNHc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3861933F8C1
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 19:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764185780; cv=none; b=PFhHnEnzmiF2+xHHZyiLIkiamy1Bd/coMwQ9kgVVIAPtAr5wz6QUQ+1bWbjIcIO4jkDN15+Xy2YnF9tgLhZBO8bTQe7GXmtDTOJaEY4h2wyb5YamtUyc4rcNIr0cT/gM5NNF0xzfRbFTIS8rVvIbGMCs8v+2KkOl152EhzGS3IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764185780; c=relaxed/simple;
	bh=MdHEo5JlzB38kfrUS/yfJXxeBIf14QgYazV3eFOuYps=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Cko+O+mY3NPs/sh0ImNqhCkpkC4AOiA5Ul4jHfaaA/CezXC973h/pPKLF2IRZxtrulK5U4RBdvZjoaSwm6dj9ewa17m0E882wDd+s6/5P0zIhRx5/XYNInWlJ3S3UeKCYKf0roRDwoY0xkZohXeH9L9y34U6N0pLsauJbpyKKNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z3gtCNHc; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7b9321b9312so119507b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 11:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764185777; x=1764790577; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BAvCfHwQMnOs+cOiqWeL0elvv18GHJNsZ1eh/Y/HY0A=;
        b=z3gtCNHcf+fM7LoIsD3FuDVUkbiRFI6nYpU1cqvbOngvIsVwW3x+OZIFk5ANo94SMy
         yYlNgAtL2bsUiT34YMLA6criqC0v6i5Fhe2Sf6QgtQRY47fEeBBzodgDtCnAEHpuQcqT
         C/4Dw2dEVHOZbTSdikhSxybcswAK90d2ZxQ8vTg7kav1qWPkxJ7i0F/iJuvgmrpyOp3M
         0WTbAOqHM4gKLfbgpiEOVU1p3IAEqX5JKUqujVf5Zq2DVLbjH0BJv/+XFyxza8PGr27R
         6V9HjKd4GJNRVtCd8truRTaeZWSiXkYY/vt8vOCx1hX0YqC+X6sW9X9VMZprMoGlKzwJ
         DbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764185777; x=1764790577;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BAvCfHwQMnOs+cOiqWeL0elvv18GHJNsZ1eh/Y/HY0A=;
        b=pObURQfhFtahyIg30SNnmSc8s702xwocJl4rq+1fxDShe2EeUVua9TstXkIqMJ3bcb
         qw0ThzAEJSgW8GEEFPPhd+5FJWJo/hrmCeCGxhY/BvdtyR/R6r5SO2G8BxBkHFBYIV/2
         uP1vBjQVHkaUS5tJOjChSW4MniRnHtagEjeXH+KDHSryH1uHqFqEwYHlF2w+0TKu46EN
         r4okTCFwvWuCfjuZ7lICuS5ZfIKiCHzRKk1N+LsgbaKVgF7CVx7rDMCcGKgaQf8ioofB
         q5cmkt3WrVTVO3Dn3ql7xmljswbGCiy3Oxwd0OrTf1VMYdxuI98CcSidg5JJa8Pdc24t
         v/RA==
X-Forwarded-Encrypted: i=1; AJvYcCUEK4P1t/MC/UD3JFl/4IMn6iBr1am2LFqqGEQsmBRVlNhqAZ+cRyr4sCTf8mg7ZN9+fkgAelquIYvMj/z7zxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRs1JHPUA57dmNvAe9u4dVrXduieJOTS56BuLRrx5W/ZfkBXpH
	J/6HvuDsZoWPC/ToX8JevWLXppwGjbjsVHAYYaEzJeeiF5lMr+Ifjn6kAGBc1PpMD9Q2U8j3P//
	gFgZ9QyIUNPrPGg==
X-Google-Smtp-Source: AGHT+IG+xXSTrXQR9csQs3WCqwSJan5Af+yQylnVLM5oBb0LBhg+2VUH2UWT8kYvjS2p2mBfoZH/ozR1D/SXjA==
X-Received: from pfbna23.prod.google.com ([2002:a05:6a00:3e17:b0:7b9:7dd0:134d])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:17a3:b0:7b8:349:1b24 with SMTP id d2e1a72fcca58-7c58e116e23mr20953003b3a.22.1764185777352;
 Wed, 26 Nov 2025 11:36:17 -0800 (PST)
Date: Wed, 26 Nov 2025 19:35:51 +0000
In-Reply-To: <20251126193608.2678510-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251126193608.2678510-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251126193608.2678510-5-dmatlack@google.com>
Subject: [PATCH 04/21] vfio/pci: Register a file handler with Live Update Orchestrator
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	kvm@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Philipp Stanner <pstanner@redhat.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"

From: Vipin Sharma <vipinsh@google.com>

Register a live update file handler for vfio-pci device files. Add stub
implementations of all required callbacks so that registration does not
fail (i.e. to avoid breaking git-bisect).

This file handler will be extended in subsequent commits to enable a
device bound to vfio-pci to run without interruption while the host is
going through a kexec Live Update.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
Co-Developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 MAINTAINERS                            |  1 +
 drivers/vfio/pci/Makefile              |  1 +
 drivers/vfio/pci/vfio_pci.c            |  9 +++-
 drivers/vfio/pci/vfio_pci_liveupdate.c | 69 ++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_priv.h       | 14 ++++++
 include/linux/kho/abi/vfio_pci.h       | 28 +++++++++++
 6 files changed, 121 insertions(+), 1 deletion(-)
 create mode 100644 drivers/vfio/pci/vfio_pci_liveupdate.c
 create mode 100644 include/linux/kho/abi/vfio_pci.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 2722f98d0ed7..ff50977277c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26933,6 +26933,7 @@ F:	Documentation/ABI/testing/debugfs-vfio
 F:	Documentation/ABI/testing/sysfs-devices-vfio-dev
 F:	Documentation/driver-api/vfio.rst
 F:	drivers/vfio/
+F:	include/linux/kho/abi/vfio_pci.h
 F:	include/linux/vfio.h
 F:	include/linux/vfio_pci_core.h
 F:	include/uapi/linux/vfio.h
diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
index cf00c0a7e55c..929df22c079b 100644
--- a/drivers/vfio/pci/Makefile
+++ b/drivers/vfio/pci/Makefile
@@ -2,6 +2,7 @@
 
 vfio-pci-core-y := vfio_pci_core.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
 vfio-pci-core-$(CONFIG_VFIO_PCI_ZDEV_KVM) += vfio_pci_zdev.o
+vfio-pci-core-$(CONFIG_LIVEUPDATE) += vfio_pci_liveupdate.o
 obj-$(CONFIG_VFIO_PCI_CORE) += vfio-pci-core.o
 
 vfio-pci-y := vfio_pci.o
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index ac10f14417f2..c2fe34a830d8 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -252,6 +252,10 @@ static int __init vfio_pci_init(void)
 	int ret;
 	bool is_disable_vga = true;
 
+	ret = vfio_pci_liveupdate_init();
+	if (ret)
+		return ret;
+
 #ifdef CONFIG_VFIO_PCI_VGA
 	is_disable_vga = disable_vga;
 #endif
@@ -260,8 +264,10 @@ static int __init vfio_pci_init(void)
 
 	/* Register and scan for devices */
 	ret = pci_register_driver(&vfio_pci_driver);
-	if (ret)
+	if (ret) {
+		vfio_pci_liveupdate_cleanup();
 		return ret;
+	}
 
 	vfio_pci_fill_ids();
 
@@ -275,6 +281,7 @@ module_init(vfio_pci_init);
 static void __exit vfio_pci_cleanup(void)
 {
 	pci_unregister_driver(&vfio_pci_driver);
+	vfio_pci_liveupdate_cleanup();
 }
 module_exit(vfio_pci_cleanup);
 
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
new file mode 100644
index 000000000000..b84e63c0357b
--- /dev/null
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Vipin Sharma <vipinsh@google.com>
+ * David Matlack <dmatlack@google.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kho/abi/vfio_pci.h>
+#include <linux/liveupdate.h>
+#include <linux/errno.h>
+
+#include "vfio_pci_priv.h"
+
+static bool vfio_pci_liveupdate_can_preserve(struct liveupdate_file_handler *handler,
+					     struct file *file)
+{
+	return false;
+}
+
+static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
+{
+	return -EOPNOTSUPP;
+}
+
+static void vfio_pci_liveupdate_unpreserve(struct liveupdate_file_op_args *args)
+{
+}
+
+static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
+{
+	return -EOPNOTSUPP;
+}
+
+static void vfio_pci_liveupdate_finish(struct liveupdate_file_op_args *args)
+{
+}
+
+static const struct liveupdate_file_ops vfio_pci_liveupdate_file_ops = {
+	.can_preserve = vfio_pci_liveupdate_can_preserve,
+	.preserve = vfio_pci_liveupdate_preserve,
+	.unpreserve = vfio_pci_liveupdate_unpreserve,
+	.retrieve = vfio_pci_liveupdate_retrieve,
+	.finish = vfio_pci_liveupdate_finish,
+	.owner = THIS_MODULE,
+};
+
+static struct liveupdate_file_handler vfio_pci_liveupdate_fh = {
+	.ops = &vfio_pci_liveupdate_file_ops,
+	.compatible = VFIO_PCI_LUO_FH_COMPATIBLE,
+};
+
+int __init vfio_pci_liveupdate_init(void)
+{
+	if (!liveupdate_enabled())
+		return 0;
+
+	return liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
+}
+
+void vfio_pci_liveupdate_cleanup(void)
+{
+	if (!liveupdate_enabled())
+		return;
+
+	liveupdate_unregister_file_handler(&vfio_pci_liveupdate_fh);
+}
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index a9972eacb293..b9f7c4e2b4df 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -107,4 +107,18 @@ static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
 	return (pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA;
 }
 
+#ifdef CONFIG_LIVEUPDATE
+int __init vfio_pci_liveupdate_init(void);
+void vfio_pci_liveupdate_cleanup(void);
+#else
+static inline int vfio_pci_liveupdate_init(void)
+{
+	return 0;
+}
+
+static inline void vfio_pci_liveupdate_cleanup(void)
+{
+}
+#endif /* CONFIG_LIVEUPDATE */
+
 #endif
diff --git a/include/linux/kho/abi/vfio_pci.h b/include/linux/kho/abi/vfio_pci.h
new file mode 100644
index 000000000000..37a845eed972
--- /dev/null
+++ b/include/linux/kho/abi/vfio_pci.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Vipin Sharma <vipinsh@google.com>
+ * David Matlack <dmatlack@google.com>
+ */
+
+#ifndef _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H
+#define _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H
+
+/**
+ * DOC: VFIO PCI Live Update ABI
+ *
+ * This header defines the ABI for preserving the state of a VFIO PCI device
+ * files across a kexec reboot using LUO.
+ *
+ * Device metadata is serialized into memory which is then handed to the next
+ * kernel via KHO.
+ *
+ * This interface is a contract. Any modification to any of the serialization
+ * structs defined here constitutes a breaking change. Such changes require
+ * incrementing the version number in the VFIO_PCI_LUO_FH_COMPATIBLE string.
+ */
+
+#define VFIO_PCI_LUO_FH_COMPATIBLE "vfio-pci-v1"
+
+#endif /* _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H */
-- 
2.52.0.487.g5c8c507ade-goog


