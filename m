Return-Path: <linux-kselftest+bounces-45455-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924EFC5427A
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 20:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A91E43BC0C8
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 19:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63329354717;
	Wed, 12 Nov 2025 19:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0C1eI0oX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EC535292C
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 19:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975389; cv=none; b=kMJ4vpu666ZuUkGZNoQzgyASOSQsSHUr5MszAPQSLhtLwaFsV75sphOjkPf2YFxw6tcGcK5MiXQ6yhd/1ByhlzZhPymB0Ql4VffYkpQZwpgp1sFw6nN+BUWqjrujHa1av/HR8IydYtYI00h7VMpfrWRCVmCkAHFhACBfIVAdNqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975389; c=relaxed/simple;
	bh=SlxKyy8oGH9AOgazMhe2QdY/23hnybCjV1OgXyTJ4gE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gQxLs+oTmiEntARzdQm7m2pRIB3xL4GKEddmvWWRWz0RZm/QVBTvKxq+Z9tdAOQCh32yT4pFjoNRTvuNtwXgV+4tEMna62ZZ62eJSRMPuxUG1zeer/DMq8PNk52jt+RW2UI5N1UZXP0OscwZYSu34xk9VqpiwCuDY38fnhFbMSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0C1eI0oX; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b471737e673so11845a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 11:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762975386; x=1763580186; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kl4dnG1uPmBI4Dj/q7R4tdouJJ9NgauEmgKL1z09vYo=;
        b=0C1eI0oXtzqLpxewyWg/zvLQ5aCcXtxZgCAGJ/by2f4C23YfbcA95PHzaL5/NzJguy
         9tmpR/jV//F3koY47MxY3oanlnjqKtYAVPSUkoCacNCTkuhjAT4JLc9/B6wo11r3nxm7
         5V3mXsaZ9hp6LK17A2Pyp7+oL2KdvTTKAHfI7a7Ch8qOo7T2gvmcT9CYsDCtyErk88HY
         EIZ8ECHytnWwl45n1t8IkeqSZtQdcJhzNUgwqJqFovB8n+Hd7tOca1obXl1n075PI/87
         YyvDlKGdKvKn8leNOooOS/M0cv836bILlxrt0PsrM7PbqZkfz/UPZd3JZOkWooHpt48r
         GChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975386; x=1763580186;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kl4dnG1uPmBI4Dj/q7R4tdouJJ9NgauEmgKL1z09vYo=;
        b=gxYKUslp8Erb54AnYCcyI8ivUbyCLpE1LYEMBmeUib1CcMtnq2paj53suENJi+s/W9
         lc6/hageRTVdjlDSQs7H8oJLKQwMVXmBDa07uL4KB2jvLANyyu77KSCSFiI88zCsIOsd
         ZiW4BFcF9rPvXVN23clGvDV+zjfF0pwdrD4AqWwegWG4/jkX57D+YpX6/Rrg1FI+yckj
         ic98MkU19ktto/UBuvKP6CA2ggNPF8xCrfoBNlNSpXHNGpedK0BBUwT0v5Y/J2XdVflx
         c7i4BqQ9561GcDxUDHJUN5l40pK6f0cbjoSEnDAuBs7tc7EROo//gbvfbAFLTT6lKFc9
         aB3g==
X-Forwarded-Encrypted: i=1; AJvYcCXaonUNq2a1UvLM0MmdW6eWhbEfakrRs5BevQQil63a5cE7YVJJGcSNjpayQ1wPOzP7wKSAgdnQst5Hu88fen8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcN+TpwGSHj9yxYExhnt2Ocqh6e/ckoUQtdxXsqKwocxJYNEMD
	+wYqVl7SDMxE52kQ3a/NFJyhxGUtlioVH+8sM2N0P8kJvFj1/0reI+w1f3gmIM4hz085R/iZOFX
	GFyT5o2huVSZGcw==
X-Google-Smtp-Source: AGHT+IEZIP9v/Os4raitXR3ccHA+MFQ26VDb0zn4z4lb+kU/9GjiM2FCWiiFc+zk9W9U21/lcYdl5KGclegMGA==
X-Received: from pfhx36.prod.google.com ([2002:a05:6a00:18a4:b0:793:b157:af4f])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:6a05:b0:350:7238:7e2b with SMTP id adf61e73a8af0-35909696a00mr5195916637.16.1762975385707;
 Wed, 12 Nov 2025 11:23:05 -0800 (PST)
Date: Wed, 12 Nov 2025 19:22:28 +0000
In-Reply-To: <20251112192232.442761-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112192232.442761-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251112192232.442761-15-dmatlack@google.com>
Subject: [PATCH v2 14/18] vfio: selftests: Rename vfio_util.h to libvfio.h
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>, 
	David Matlack <dmatlack@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Raghavendra Rao Ananta <rananta@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Rename vfio_util.h to libvfio.h to match the name of libvfio.mk.

No functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c          | 2 +-
 tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c        | 2 +-
 .../selftests/vfio/lib/include/{vfio_util.h => libvfio.h}   | 6 +++---
 tools/testing/selftests/vfio/lib/iommu.c                    | 2 +-
 tools/testing/selftests/vfio/lib/iova_allocator.c           | 2 +-
 tools/testing/selftests/vfio/lib/vfio_pci_device.c          | 2 +-
 tools/testing/selftests/vfio/lib/vfio_pci_driver.c          | 2 +-
 tools/testing/selftests/vfio/vfio_dma_mapping_test.c        | 2 +-
 tools/testing/selftests/vfio/vfio_iommufd_setup_test.c      | 2 +-
 tools/testing/selftests/vfio/vfio_pci_device_test.c         | 2 +-
 tools/testing/selftests/vfio/vfio_pci_driver_test.c         | 2 +-
 11 files changed, 13 insertions(+), 13 deletions(-)
 rename tools/testing/selftests/vfio/lib/include/{vfio_util.h => libvfio.h} (98%)

diff --git a/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c b/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
index 0afbab0d82de..c75045bcab79 100644
--- a/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
+++ b/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
@@ -9,7 +9,7 @@
 #include <linux/pci_ids.h>
 #include <linux/sizes.h>
 
-#include <vfio_util.h>
+#include <libvfio.h>
 
 #include "registers.h"
 
diff --git a/tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c b/tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c
index c6db311ce64d..a871b935542b 100644
--- a/tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c
+++ b/tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c
@@ -7,7 +7,7 @@
 #include <linux/pci_ids.h>
 #include <linux/sizes.h>
 
-#include <vfio_util.h>
+#include <libvfio.h>
 
 #include "hw.h"
 #include "registers.h"
diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/libvfio.h
similarity index 98%
rename from tools/testing/selftests/vfio/lib/include/vfio_util.h
rename to tools/testing/selftests/vfio/lib/include/libvfio.h
index 5224808201fe..3027af15e316 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-#ifndef SELFTESTS_VFIO_LIB_INCLUDE_VFIO_UTIL_H
-#define SELFTESTS_VFIO_LIB_INCLUDE_VFIO_UTIL_H
+#ifndef SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_H
+#define SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_H
 
 #include <fcntl.h>
 #include <string.h>
@@ -352,4 +352,4 @@ void vfio_pci_driver_memcpy_start(struct vfio_pci_device *device,
 int vfio_pci_driver_memcpy_wait(struct vfio_pci_device *device);
 void vfio_pci_driver_send_msi(struct vfio_pci_device *device);
 
-#endif /* SELFTESTS_VFIO_LIB_INCLUDE_VFIO_UTIL_H */
+#endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_H */
diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/selftests/vfio/lib/iommu.c
index 3933079fc419..52f9cdf5f171 100644
--- a/tools/testing/selftests/vfio/lib/iommu.c
+++ b/tools/testing/selftests/vfio/lib/iommu.c
@@ -19,7 +19,7 @@
 #include <linux/iommufd.h>
 
 #include "../../../kselftest.h"
-#include <vfio_util.h>
+#include <libvfio.h>
 
 const char *default_iommu_mode = "iommufd";
 
diff --git a/tools/testing/selftests/vfio/lib/iova_allocator.c b/tools/testing/selftests/vfio/lib/iova_allocator.c
index b3b6b27f5d1e..a12b0a51e9e6 100644
--- a/tools/testing/selftests/vfio/lib/iova_allocator.c
+++ b/tools/testing/selftests/vfio/lib/iova_allocator.c
@@ -19,7 +19,7 @@
 #include <linux/types.h>
 #include <linux/vfio.h>
 
-#include <vfio_util.h>
+#include <libvfio.h>
 
 struct iova_allocator *iova_allocator_init(struct iommu *iommu)
 {
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index a59c86797897..282c14bbdd00 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -20,7 +20,7 @@
 #include <linux/vfio.h>
 
 #include "../../../kselftest.h"
-#include <vfio_util.h>
+#include <libvfio.h>
 
 #define PCI_SYSFS_PATH	"/sys/bus/pci/devices"
 
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
index abb7a62a03ea..ca0e25efbfa1 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include "../../../kselftest.h"
-#include <vfio_util.h>
+#include <libvfio.h>
 
 #ifdef __x86_64__
 extern struct vfio_pci_driver_ops dsa_ops;
diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
index c4c2fc36c7b3..213fcd8dcc79 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -10,7 +10,7 @@
 #include <linux/sizes.h>
 #include <linux/vfio.h>
 
-#include <vfio_util.h>
+#include <libvfio.h>
 
 #include "../kselftest_harness.h"
 
diff --git a/tools/testing/selftests/vfio/vfio_iommufd_setup_test.c b/tools/testing/selftests/vfio/vfio_iommufd_setup_test.c
index 3655106b912d..caf1c6291f3d 100644
--- a/tools/testing/selftests/vfio/vfio_iommufd_setup_test.c
+++ b/tools/testing/selftests/vfio/vfio_iommufd_setup_test.c
@@ -10,7 +10,7 @@
 #include <sys/ioctl.h>
 #include <unistd.h>
 
-#include <vfio_util.h>
+#include <libvfio.h>
 #include "../kselftest_harness.h"
 
 static const char iommu_dev_path[] = "/dev/iommu";
diff --git a/tools/testing/selftests/vfio/vfio_pci_device_test.c b/tools/testing/selftests/vfio/vfio_pci_device_test.c
index e95217933c6b..ecbb669b3765 100644
--- a/tools/testing/selftests/vfio/vfio_pci_device_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_device_test.c
@@ -10,7 +10,7 @@
 #include <linux/sizes.h>
 #include <linux/vfio.h>
 
-#include <vfio_util.h>
+#include <libvfio.h>
 
 #include "../kselftest_harness.h"
 
diff --git a/tools/testing/selftests/vfio/vfio_pci_driver_test.c b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
index 229e932a06f8..f0ca8310d6a8 100644
--- a/tools/testing/selftests/vfio/vfio_pci_driver_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
@@ -5,7 +5,7 @@
 #include <linux/sizes.h>
 #include <linux/vfio.h>
 
-#include <vfio_util.h>
+#include <libvfio.h>
 
 #include "../kselftest_harness.h"
 
-- 
2.52.0.rc1.455.g30608eb744-goog


