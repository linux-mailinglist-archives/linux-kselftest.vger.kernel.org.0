Return-Path: <linux-kselftest+bounces-46275-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED15C7B4B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 19:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B20074E69F1
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 18:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB6027FB34;
	Fri, 21 Nov 2025 18:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TVM8pyJe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F60351FA0
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 18:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748909; cv=none; b=HliKu7mpb8pxANKAZ4EM4L/JBdeyZAOXdvmLZ6a99mifUfiP5bGvT4+kbxiQv4xRqntnKXHeezBS8VLA/sx4pD0VKoMmkrAlnE2PoBxBQcAnbUdOT11bZvfhoVP4GNCiL3EhUvubqnmudk3ma/9n8trEL13vDGy2m+a+S3jmeZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748909; c=relaxed/simple;
	bh=KYSZvwIYuGqWONSGyW/cf+OrbkOd5CohW/aJh2gqPA4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J9jl2CXOqZrZ5fhJf4RUjy0fhZTauMCj9n6HF9jOktuHKYZq8nmVRuLVSann7cLDyc4InGGp4f577xEATgLkpGqflt0uWMrmzmCWhskJbd1R8jl5CX7U0XGzAid3zyk04EAXY3LfiVWjG+RwNzEZyjljSKSo5m+o8InuJt7FRW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TVM8pyJe; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7aa9f595688so4407795b3a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 10:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763748898; x=1764353698; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P6NpR6v3M9pBWa8mqzX9JiTE9lvDMmHIPBrLIUR3fl0=;
        b=TVM8pyJeWP4jICSK4W32NS0AZtf/rlYi1R944/LImVOYN1UKdxAxCuEEmbWhH6drrN
         IeFHqPLqnsz5wKzqczhNWlmWI4kRsGg1SeGJQ+8q5WlsYOYsA+EoHDZoWrFd68xzn/bh
         Nt6JcCqWWTcQin8jNVC9+nCtfgX5MXx1PE2rOSMaw34z7IaOvHOxOGneGsbRDDaBsIMJ
         aHtfuoXDZf1DzKdldMcRtCopaAntTbRreuP/4Q3zAN6fxLl2vcMyuQLD/ZH2ibrKFAFf
         6muyXnPCw2+wIRSpBAnj4KMUWk2TBd3F69Gnl+KWF+cH1CH31EnzOXzfI/VFmPcY+jJ7
         5Asw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763748898; x=1764353698;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P6NpR6v3M9pBWa8mqzX9JiTE9lvDMmHIPBrLIUR3fl0=;
        b=mJPZxMNsTDtx99Q6/UjOUG6vXaQ1TgVMX4kVZ89Hds0m3F6ldbOQZoBnY+TFIgzPb1
         FcEK0VNdupMRKW3dQ8hRVw01P7FMcJt+fQmEa/VAqEDxtG3QwJBFESoo9gpxvYnaRO1V
         tC4mSTEqAOH1qpSYZJwbKDKEOyn+5Dr71/26DiY3NTCmneMiNxh7WbMEixmbGdki/+yC
         7UQIEhwMI42Ccwkw2+wX162dVWu5ONcV2ZEB75wMxu89jzzHgIAiY1m19NoWKMHYAK5j
         gcm99fTb2ak6VfRGxudW5SSmAgOdpxdgZW/JToJUB2zsKDl1r52vCeQHHMkkoJkEaP1c
         vEEA==
X-Forwarded-Encrypted: i=1; AJvYcCVA/ff1u7gVfqvM0n8fPye6DqlStfLtvVXgW1AZwosu6h9WxyVHqXJTnmawaVsUKSfO+Y4Cz74VPhCJXjXMEcU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx8UZ/yvnGLrDw+528UQ4VBdVMxb5Z6uROGZpTM46eTOKQFsN5
	U5ew1AjUQuF6OhOyUzFDr8wgQsJ9Ut2sPN0PUNR08es3a/dEYLIcU/odSeumnXI40AIsCOrOfuB
	ZmInZSO5P02/6ZQ==
X-Google-Smtp-Source: AGHT+IGaxmIgScgBNXnSMh0Y/1HTLLgh3WxboedX5JBI9DISIv1p1rfPRqF9Eq05K/1531C61+/6sE2AMWZStw==
X-Received: from pfee15.prod.google.com ([2002:a05:6a00:bc8f:b0:7a3:23d4:f5f9])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:9186:b0:350:1a0e:7fc5 with SMTP id adf61e73a8af0-3614eeb0d8emr4019398637.60.1763748898201;
 Fri, 21 Nov 2025 10:14:58 -0800 (PST)
Date: Fri, 21 Nov 2025 18:14:23 +0000
In-Reply-To: <20251121181429.1421717-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251121181429.1421717-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251121181429.1421717-13-dmatlack@google.com>
Subject: [PATCH v3 12/18] vfio: selftests: Move IOVA allocator into iova_allocator.c
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
2.52.0.rc2.455.g230fcf2819-goog


