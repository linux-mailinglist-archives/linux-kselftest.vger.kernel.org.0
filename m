Return-Path: <linux-kselftest+bounces-45453-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 352E8C54204
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 20:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1FD924E9785
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 19:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172B235388D;
	Wed, 12 Nov 2025 19:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e9GX4Siu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42618352F9F
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 19:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975385; cv=none; b=CY8h3SlVEW7y1hu8KcH/gaT0/TJoXBa9VEanoBlnRaLMCeAXciwKHpk+T+/g1uFADCJF/5RJOYAkoo3sltdMp5snZa4K++MNapjhNj5g5d9BhU+6IKat43qS/eKECCwA59+JoYu3/Odts3k5BEUkdhHo5dFdrPL4HrdR4iva2zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975385; c=relaxed/simple;
	bh=CkyC4vEq22xK1S2P6qHF080PFKlKoHtyS9Y4y4gmwns=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SfRJwf3O5l+5Fa3061bxAheoraAKWqujUPZWBYMfM5Q40ByG/JhCXO6x9u2uSDYDqeJ/v4lwrbl6fgzodp78steL5F8k7wtB8B+W4VjDuIJFJGf8poDFmP2MgP7xZzHQ7q+W2GoLfYnv751z6RtKClG/fBYOJB8YL13ZyM/uAr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e9GX4Siu; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7a153ba0009so2436279b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 11:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762975382; x=1763580182; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/x7TxElv1Y0m6LMl9OrnCN+PJlJwFyshUcn1NViYdY8=;
        b=e9GX4SiuGpZ4KxxJdYuGGOkaUUkaYN4xL7f8kfZCChu4R2M9EMBb59YHdacXF2+glJ
         dPSkd8dzYKrAv7psurVDQ3EGTaRZNyGtGOiqmxsJeQhwa4jbD6l1nnT5aYwkA6mePugj
         SI4vTakuP4t5aJnLFQMOBNaNqjJzHyYe8m1OlBoDmiIFtPh6o+UqIl2tCHPMWe6nsxVX
         mD5PzUYMe3aBsz/xBnTfpZvZn0ZbIB/xuXs16Re6LHg9tpbOeu1vkRGNOKauvvBipjmn
         tqDrqGGXe+XYIHWsubrzfTHXHG/T86NBWJhZoDoipCQ+iFSMvQYcsP+gNECVIw8c+uL/
         LhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975382; x=1763580182;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/x7TxElv1Y0m6LMl9OrnCN+PJlJwFyshUcn1NViYdY8=;
        b=vrTImdCArev4C/puuf1MNZAiQ6Ev9zPt7AXsr3DNfASvL8dHXqs57ZLhsQyqmJX4d2
         EUIl2T+2ck1dnwchnyG2OSIQgB9/4Me08QLdtYF+7zUj7b6MbHs0FUGQxIWmovH8zfKe
         /iwSgSEH7QTYbr0UIUX89MSafFZDMUoxsw7kfhYu2+WuI+6ceXKidZHKZ9zC8/6uIpic
         3PJjMGa9IMgb7jVralkT85hzt/MVoW85gMdmhPiLkyf+8Qcf9RXLZ+vycagf/pAHw+X5
         wL7cCApw2MFPrD6868Xiy9g6ucYCR9Nx7Eu+nN1i4pDX19pH7qvj/3ZZo1sezIFdJ/lu
         RluQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+DGgHU/C9l9TmHF+sV7GEGrilF5T3x+V5kCJ987L/4sPD0lm6xVUp6bSDA+sIbbFIXKjvaCZTVEm0vB5RHrA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy1nFb4ikv6+7aE0P1NC+abEg1zFGAeD7YwReWmg0hAKfKABZc
	3GZE0zyiwZCDXdCpI4Y5lh+dCXhhfDWXUTycZwBczzCL56YyztmF6mfEclgHI6Gt8XC+MwTMEld
	pdhcwLfl6DqX5Kw==
X-Google-Smtp-Source: AGHT+IHlexuAvDhnFGtg1cjQs73mJGUfm4wmIrjXrh2KvcJRouRaW+y+oFum0/DZIEri+Qoz+nn0V8NIBFvvdQ==
X-Received: from pfoc3.prod.google.com ([2002:aa7:8803:0:b0:781:1533:32ab])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1491:b0:792:5db2:73ac with SMTP id d2e1a72fcca58-7b7a23b3a68mr5122550b3a.7.1762975382516;
 Wed, 12 Nov 2025 11:23:02 -0800 (PST)
Date: Wed, 12 Nov 2025 19:22:26 +0000
In-Reply-To: <20251112192232.442761-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112192232.442761-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251112192232.442761-13-dmatlack@google.com>
Subject: [PATCH v2 12/18] vfio: selftests: Move IOVA allocator into iova_allocator.c
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>, 
	David Matlack <dmatlack@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Raghavendra Rao Ananta <rananta@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Move the IOVA allocator into its own file, to provide better separation
between the allocator and the struct vfio_pci_device helper code.

The allocator could go into iommu.c, but it is standalone enough that a
separate file seems cleaner. This also continues the trend of having a
.c for every major object in VFIO selftests (vfio_pci_device.c,
vfio_pci_driver.c, iommu.c, and now iova_allocator.c).

No functional change intended.

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
index 5e0de10df04e..a59c86797897 100644
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
2.52.0.rc1.455.g30608eb744-goog


