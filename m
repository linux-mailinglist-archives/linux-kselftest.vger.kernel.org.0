Return-Path: <linux-kselftest+bounces-46587-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE1AC8C53E
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 00:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6CC24E1B34
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 23:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA5C3491D0;
	Wed, 26 Nov 2025 23:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3kiLKW8p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A39534846E
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 23:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764199083; cv=none; b=Im31a9J2cogju3fJh/TxMwOKqYAKzFA93p/YtsFHJHHPkpvj4PWNaW8hJsivzo1LNu5xdV8QU4bOKfMbOBl00p2ZS9Ypn5azc/TJbEkXBnai2N3am75E8morZdT82BbDwa0EmCPOyB8Bxl9YahRschwprAJGs2k+weAriu71+Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764199083; c=relaxed/simple;
	bh=7PVn76b8rX0MxJTUfhyoehbiKMnipdTAASaM5dmOZs0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vEft7i++zSSMUXrk6iQNOPNi5YxfiRSCuHHh/AeF3nHGO/LEtEv7/E8TJGfEF5lWoG7wA0BE+v4DE4vzR4lfcXOoQPYuMN+F5dW8WT6vU8hnb8zQpfkCZdtSP7y4UjpU7SQHYFzbNwTjFztYIWxgmO/9UDtwhKcrsAvWdQzoZFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3kiLKW8p; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7b9c91b814cso649087b3a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 15:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764199081; x=1764803881; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EK277X+oVRo/3waBm9mTxQf5GxrA/dPpZ/zTyzS81bg=;
        b=3kiLKW8pqKLgErADigkgQQZ8ywsz+TYlrJteNXQKO+14WxQTWiykb6HI8rKJ/4xYQ0
         cvja3AMzk+JSNQksyntkiq7Q8eDmxYjFhVqN3DSqHxB0tVYXcaLq+xnKSShtfTT8h+N6
         f9Tb31cORdjWphy3y5+E1UFCdn7HErQcxFmw/YR50elXJD/ioQ53wqPAxD+AmSk7owxH
         SlC6JIzV0qNSMdC5T1tSP7ct9Ep4vGhkm4x5cmhuwl0f1IOUzuIUMctacI+70oGoMukg
         jAKyFuEcwNGR7OF5G9Cn63T5QMlUnbffEC6JpFTRKeY9TzTwLflPFZc6PbUU3K9GrU/f
         Od7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764199081; x=1764803881;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EK277X+oVRo/3waBm9mTxQf5GxrA/dPpZ/zTyzS81bg=;
        b=ULutKWgISaq1uVGJ7idDzMaIdgSNRTZc0UT7m8xvmFJ275VWNcGfLTssyL1aB8TFyz
         RTedhkBz8j4Oy80p6oFHJl+28gmUKTEm0WSe/NFuHmzpMDnphvvQRiA2TtoTqwGI0oaj
         RVpJlxZldGcH4ZxFC3tRtEYCis/4wLkhEqrVjOpfdlIBYwmiprFsza9otXbu1PLE0M+i
         zWB6I6F7baGB1TedpX6fqUFKUCXZhSwNa0Jx3qn3DWa81McnGgKUKmMstrx5XFAeAwb+
         +d4+uv+gQgROYFTSIIKYIB1A9Da5QCKp9dSEk7qn1Wbr96pjaczcFisRDltRoiL0uepM
         czpg==
X-Forwarded-Encrypted: i=1; AJvYcCVMUArCIA7TuXr0bMBCE5D+qR8RaY+GkZHWnbDXhOWgwwNeXwcQfyviCZh9vh2GBB0igFlt5SF5PD6uR9Ls9wU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2xMaYqaRbtl9wwSA45R3RCCTahOyeol+QFFbl24sCm4adhdrf
	MSPqY/LfKVDRVF0nJczeNVfClZWKCREPH8xveXKKPz1rEpdwyo+ClIBxPbQDYw6+lM8KPF6cBox
	LoDsVo6xGFvLx9Q==
X-Google-Smtp-Source: AGHT+IF4HzJU/io7p5u55ySnDmOnh3kDCjx8YWbt0k4JunTmVTYnjTqHIkASsk3cbqu5Mw+7w80+iyJ1PeJs/w==
X-Received: from pgbdl10.prod.google.com ([2002:a05:6a02:d0a:b0:b6c:f35f:bae9])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:3c8d:b0:35f:84c7:4031 with SMTP id adf61e73a8af0-3637e0d3593mr9350366637.55.1764199080759;
 Wed, 26 Nov 2025 15:18:00 -0800 (PST)
Date: Wed, 26 Nov 2025 23:17:27 +0000
In-Reply-To: <20251126231733.3302983-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251126231733.3302983-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251126231733.3302983-13-dmatlack@google.com>
Subject: [PATCH v4 12/18] vfio: selftests: Move IOVA allocator into iova_allocator.c
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Alex Mastro <amastro@fb.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Raghavendra Rao Ananta <rananta@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Move the IOVA allocator into its own file, to provide better separation
between the allocator and the struct vfio_pci_device helper code.

The allocator could go into iommu.c, but it is standalone enough that a
separate file seems cleaner. This also continues the trend of having a
.c for every major object in VFIO selftests (vfio_pci_device.c,
vfio_pci_driver.c, iommu.c, and now iova_allocator.c).

No functional change intended.

Reviewed-by: Alex Mastro <amastro@fb.com>
Tested-by: Alex Mastro <amastro@fb.com>
Reviewed-by: Raghavendra Rao Ananta <rananta@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../selftests/vfio/lib/iova_allocator.c       | 94 +++++++++++++++++++
 tools/testing/selftests/vfio/lib/libvfio.mk   |  1 +
 .../selftests/vfio/lib/vfio_pci_device.c      | 71 --------------
 3 files changed, 95 insertions(+), 71 deletions(-)
 create mode 100644 tools/testing/selftests/vfio/lib/iova_allocator.c

diff --git a/tools/testing/selftests/vfio/lib/iova_allocator.c b/tools/testing/selftests/vfio/lib/iova_allocator.c
new file mode 100644
index 000000000000..f03648361ba2
--- /dev/null
+++ b/tools/testing/selftests/vfio/lib/iova_allocator.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <dirent.h>
+#include <fcntl.h>
+#include <libgen.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <sys/eventfd.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+
+#include <uapi/linux/types.h>
+#include <linux/iommufd.h>
+#include <linux/limits.h>
+#include <linux/mman.h>
+#include <linux/overflow.h>
+#include <linux/types.h>
+#include <linux/vfio.h>
+
+#include <vfio_util.h>
+
+struct iova_allocator *iova_allocator_init(struct vfio_pci_device *device)
+{
+	struct iova_allocator *allocator;
+	struct iommu_iova_range *ranges;
+	u32 nranges;
+
+	ranges = vfio_pci_iova_ranges(device, &nranges);
+	VFIO_ASSERT_NOT_NULL(ranges);
+
+	allocator = malloc(sizeof(*allocator));
+	VFIO_ASSERT_NOT_NULL(allocator);
+
+	*allocator = (struct iova_allocator){
+		.ranges = ranges,
+		.nranges = nranges,
+		.range_idx = 0,
+		.range_offset = 0,
+	};
+
+	return allocator;
+}
+
+void iova_allocator_cleanup(struct iova_allocator *allocator)
+{
+	free(allocator->ranges);
+	free(allocator);
+}
+
+iova_t iova_allocator_alloc(struct iova_allocator *allocator, size_t size)
+{
+	VFIO_ASSERT_GT(size, 0, "Invalid size arg, zero\n");
+	VFIO_ASSERT_EQ(size & (size - 1), 0, "Invalid size arg, non-power-of-2\n");
+
+	for (;;) {
+		struct iommu_iova_range *range;
+		iova_t iova, last;
+
+		VFIO_ASSERT_LT(allocator->range_idx, allocator->nranges,
+			       "IOVA allocator out of space\n");
+
+		range = &allocator->ranges[allocator->range_idx];
+		iova = range->start + allocator->range_offset;
+
+		/* Check for sufficient space at the current offset */
+		if (check_add_overflow(iova, size - 1, &last) ||
+		    last > range->last)
+			goto next_range;
+
+		/* Align iova to size */
+		iova = last & ~(size - 1);
+
+		/* Check for sufficient space at the aligned iova */
+		if (check_add_overflow(iova, size - 1, &last) ||
+		    last > range->last)
+			goto next_range;
+
+		if (last == range->last) {
+			allocator->range_idx++;
+			allocator->range_offset = 0;
+		} else {
+			allocator->range_offset = last - range->start + 1;
+		}
+
+		return iova;
+
+next_range:
+		allocator->range_idx++;
+		allocator->range_offset = 0;
+	}
+}
+
diff --git a/tools/testing/selftests/vfio/lib/libvfio.mk b/tools/testing/selftests/vfio/lib/libvfio.mk
index 7ecf2ad75c67..f15b966877e9 100644
--- a/tools/testing/selftests/vfio/lib/libvfio.mk
+++ b/tools/testing/selftests/vfio/lib/libvfio.mk
@@ -4,6 +4,7 @@ ARCH ?= $(SUBARCH)
 LIBVFIO_SRCDIR := $(selfdir)/vfio/lib
 
 LIBVFIO_C := iommu.c
+LIBVFIO_C += iova_allocator.c
 LIBVFIO_C += vfio_pci_device.c
 LIBVFIO_C += vfio_pci_driver.c
 
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 10fc016a2a3e..aa5b45052c77 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -24,77 +24,6 @@
 
 #define PCI_SYSFS_PATH	"/sys/bus/pci/devices"
 
-struct iova_allocator *iova_allocator_init(struct vfio_pci_device *device)
-{
-	struct iova_allocator *allocator;
-	struct iommu_iova_range *ranges;
-	u32 nranges;
-
-	ranges = vfio_pci_iova_ranges(device, &nranges);
-	VFIO_ASSERT_NOT_NULL(ranges);
-
-	allocator = malloc(sizeof(*allocator));
-	VFIO_ASSERT_NOT_NULL(allocator);
-
-	*allocator = (struct iova_allocator){
-		.ranges = ranges,
-		.nranges = nranges,
-		.range_idx = 0,
-		.range_offset = 0,
-	};
-
-	return allocator;
-}
-
-void iova_allocator_cleanup(struct iova_allocator *allocator)
-{
-	free(allocator->ranges);
-	free(allocator);
-}
-
-iova_t iova_allocator_alloc(struct iova_allocator *allocator, size_t size)
-{
-	VFIO_ASSERT_GT(size, 0, "Invalid size arg, zero\n");
-	VFIO_ASSERT_EQ(size & (size - 1), 0, "Invalid size arg, non-power-of-2\n");
-
-	for (;;) {
-		struct iommu_iova_range *range;
-		iova_t iova, last;
-
-		VFIO_ASSERT_LT(allocator->range_idx, allocator->nranges,
-			       "IOVA allocator out of space\n");
-
-		range = &allocator->ranges[allocator->range_idx];
-		iova = range->start + allocator->range_offset;
-
-		/* Check for sufficient space at the current offset */
-		if (check_add_overflow(iova, size - 1, &last) ||
-		    last > range->last)
-			goto next_range;
-
-		/* Align iova to size */
-		iova = last & ~(size - 1);
-
-		/* Check for sufficient space at the aligned iova */
-		if (check_add_overflow(iova, size - 1, &last) ||
-		    last > range->last)
-			goto next_range;
-
-		if (last == range->last) {
-			allocator->range_idx++;
-			allocator->range_offset = 0;
-		} else {
-			allocator->range_offset = last - range->start + 1;
-		}
-
-		return iova;
-
-next_range:
-		allocator->range_idx++;
-		allocator->range_offset = 0;
-	}
-}
-
 static void vfio_pci_irq_set(struct vfio_pci_device *device,
 			     u32 index, u32 vector, u32 count, int *fds)
 {
-- 
2.52.0.487.g5c8c507ade-goog


