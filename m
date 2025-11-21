Return-Path: <linux-kselftest+bounces-46276-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E7FC7B46D
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 19:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E50023A5A6B
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 18:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AD6352F90;
	Fri, 21 Nov 2025 18:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="La3pYyVK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC93350D70
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 18:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748909; cv=none; b=DCAeGCDtkRF7ZFKpuCviCKbOcr3JHTvPx4/+W1piaZ0x5KHwzTeWzVBDosHyJcWbgcFXPX4c64ealUxyVDP+h28Tz470p7wZSt+3JRNv+1Ue9xkMwMCxQ6H65+13XbAkHM/SDQPWi4J5VNWmEQfrVJD+oE6uesWEQVhZq9QgWXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748909; c=relaxed/simple;
	bh=Yprpg142+hgqCGbDmnXILCasHIgMClt/HSupou46ano=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o7FhqNH95dTjVRzUMWJFNnpGKPWTfanKNHdlbW1b3Atur9b2dLJjINS1n5I7X6zlI1a12Qkn6/wdBhBk2zbUmUxIiFaSUlhD0BpnXvPeSin+2fW2H0ZoL2tveuKRT2RM5qEUXT2CpgOnvEDRmoOleA5MzXebR/O5PfAcqm5yDB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=La3pYyVK; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-29b760316a8so3738145ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 10:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763748900; x=1764353700; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fX+LIkvch8B4mDhFv2H89PyCx2HInX0x3VrD2k2o7zM=;
        b=La3pYyVKveqPcblV+9EZmqeKzfGtKGLyBUjL/4z6rOetCG8+JC9etHVqHbXJ78oMPr
         8FIfBXAiHcBZphtKlx7kRrW6cqBhNNJVcmIhN8B+gUBK3rbej2G7gy+IlrYrsCVfzgVk
         sJyjN/CCrnwv6+Gy4zSBxGOg8/mIYMeltzVwpJ+SL93UfAjFl4M8+sf21jo8epckRO7b
         oPSVnWKzYLL+QCKkehWFWnUBVSxWILsU0QcsW0RCvYiMWJ5m05VeZnBXiQW8ZJwvbcdz
         vKGL9PvPVy8UrcoFvTqJbagmnhtMTGHzFq5b9T25tHLB45HWQBDzo8yt1w8jNrwKPlxA
         2buw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763748900; x=1764353700;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fX+LIkvch8B4mDhFv2H89PyCx2HInX0x3VrD2k2o7zM=;
        b=b7xd+c+N042SpUZj2qY5pSydhZd358o/90BsG+QtYFKuSi6mNPIZjGaKT4xRe2YhH3
         luck8HNkic8OrKWI+XAmIt1VhXMYyaOIdLv7VsqBE4Qx3W8EYgbSGIbVRwJoPZK/KwRu
         18UdPXoqpE9dJiK/3regJXfUoDrferQRZQMnBX11FIk9D0OaWb0OWBA1EimDBQs/YEb7
         1wl2MJbwjunT/gstSWUr8WL88zpal8kQ6Jod52V3KwvJ8hdajX8lhj4xCVzJNqw4KGhE
         +cd+B6geMrgSUmMKugCVbBrIy9TmEvunbBr2bUVv/Za1JVRcMxASt0u3w+aeHG8+g/Cf
         tQHA==
X-Forwarded-Encrypted: i=1; AJvYcCVl6CQ4cHj/tkZdKXmHK+pETGHvqDn9XVbdJh9kpPA81GAMPUmu4jvYA+5t2E3lbFANqz/fE4DhKMxFuCad3IM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh2ugL1DkwXqqxsRf0md8UnsE4wR7SoczNS9lqck+4llnufNy8
	Ar99QVE5v7hpkOb2W4y1RYE0LKEuHtJWYmQWAICjxQ9z0CKtMXHxp384UgXcJfLEDyaG1rIz6DO
	ktaUxgddoXBgABQ==
X-Google-Smtp-Source: AGHT+IEFlzr2Td3psN+QJgedrluhlVDDDTHozKIhSTplt1gl924EQ0xmzvjfDA6b402qfqYTaUsYtgj1UeAT2A==
X-Received: from plbjx13.prod.google.com ([2002:a17:903:138d:b0:298:60f:680f])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2ad0:b0:295:4d97:84dd with SMTP id d9443c01a7336-29b6c6b87d3mr39046725ad.51.1763748899917;
 Fri, 21 Nov 2025 10:14:59 -0800 (PST)
Date: Fri, 21 Nov 2025 18:14:24 +0000
In-Reply-To: <20251121181429.1421717-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251121181429.1421717-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251121181429.1421717-14-dmatlack@google.com>
Subject: [PATCH v3 13/18] vfio: selftests: Stop passing device for IOMMU operations
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Alex Mastro <amastro@fb.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Raghavendra Rao Ananta <rananta@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Drop the struct vfio_pci_device wrappers for IOMMU map/unmap functions
and require tests to directly call iommu_map(), iommu_unmap(), etc. This
results in more concise code, and also makes it clear the map operations
are happening on a struct iommu, not necessarily on a specific device,
especially when multi-device tests are introduced.

Do the same for iova_allocator_init() as that function only needs the
struct iommu, not struct vfio_pci_device.

Reviewed-by: Alex Mastro <amastro@fb.com>
Tested-by: Alex Mastro <amastro@fb.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../selftests/vfio/lib/include/vfio_util.h    | 44 +------------------
 .../selftests/vfio/lib/iova_allocator.c       |  4 +-
 .../selftests/vfio/vfio_dma_mapping_test.c    | 20 ++++-----
 .../selftests/vfio/vfio_pci_driver_test.c     | 19 ++++----
 4 files changed, 22 insertions(+), 65 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
index f67915d9443e..5224808201fe 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -260,52 +260,10 @@ void vfio_pci_device_cleanup(struct vfio_pci_device *device);
 
 void vfio_pci_device_reset(struct vfio_pci_device *device);
 
-static inline struct iommu_iova_range *vfio_pci_iova_ranges(struct vfio_pci_device *device,
-							    u32 *nranges)
-{
-	return iommu_iova_ranges(device->iommu, nranges);
-}
-
-struct iova_allocator *iova_allocator_init(struct vfio_pci_device *device);
+struct iova_allocator *iova_allocator_init(struct iommu *iommu);
 void iova_allocator_cleanup(struct iova_allocator *allocator);
 iova_t iova_allocator_alloc(struct iova_allocator *allocator, size_t size);
 
-static inline int __vfio_pci_dma_map(struct vfio_pci_device *device,
-				     struct dma_region *region)
-{
-	return __iommu_map(device->iommu, region);
-}
-
-static inline void vfio_pci_dma_map(struct vfio_pci_device *device,
-				    struct dma_region *region)
-{
-	VFIO_ASSERT_EQ(__vfio_pci_dma_map(device, region), 0);
-}
-
-static inline int __vfio_pci_dma_unmap(struct vfio_pci_device *device,
-				       struct dma_region *region,
-				       u64 *unmapped)
-{
-	return __iommu_unmap(device->iommu, region, unmapped);
-}
-
-static inline void vfio_pci_dma_unmap(struct vfio_pci_device *device,
-				      struct dma_region *region)
-{
-	VFIO_ASSERT_EQ(__vfio_pci_dma_unmap(device, region, NULL), 0);
-}
-
-static inline int __vfio_pci_dma_unmap_all(struct vfio_pci_device *device,
-					   u64 *unmapped)
-{
-	return __iommu_unmap_all(device->iommu, unmapped);
-}
-
-static inline void vfio_pci_dma_unmap_all(struct vfio_pci_device *device)
-{
-	VFIO_ASSERT_EQ(__vfio_pci_dma_unmap_all(device, NULL), 0);
-}
-
 void vfio_pci_config_access(struct vfio_pci_device *device, bool write,
 			    size_t config, size_t size, void *data);
 
diff --git a/tools/testing/selftests/vfio/lib/iova_allocator.c b/tools/testing/selftests/vfio/lib/iova_allocator.c
index f03648361ba2..b3b6b27f5d1e 100644
--- a/tools/testing/selftests/vfio/lib/iova_allocator.c
+++ b/tools/testing/selftests/vfio/lib/iova_allocator.c
@@ -21,13 +21,13 @@
 
 #include <vfio_util.h>
 
-struct iova_allocator *iova_allocator_init(struct vfio_pci_device *device)
+struct iova_allocator *iova_allocator_init(struct iommu *iommu)
 {
 	struct iova_allocator *allocator;
 	struct iommu_iova_range *ranges;
 	u32 nranges;
 
-	ranges = vfio_pci_iova_ranges(device, &nranges);
+	ranges = iommu_iova_ranges(iommu, &nranges);
 	VFIO_ASSERT_NOT_NULL(ranges);
 
 	allocator = malloc(sizeof(*allocator));
diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
index 289af4665803..c4c2fc36c7b3 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -122,7 +122,7 @@ FIXTURE_SETUP(vfio_dma_mapping_test)
 {
 	self->iommu = iommu_init(variant->iommu_mode);
 	self->device = vfio_pci_device_init(device_bdf, self->iommu);
-	self->iova_allocator = iova_allocator_init(self->device);
+	self->iova_allocator = iova_allocator_init(self->iommu);
 }
 
 FIXTURE_TEARDOWN(vfio_dma_mapping_test)
@@ -153,7 +153,7 @@ TEST_F(vfio_dma_mapping_test, dma_map_unmap)
 	region.iova = iova_allocator_alloc(self->iova_allocator, size);
 	region.size = size;
 
-	vfio_pci_dma_map(self->device, &region);
+	iommu_map(self->iommu, &region);
 	printf("Mapped HVA %p (size 0x%lx) at IOVA 0x%lx\n", region.vaddr, size, region.iova);
 
 	ASSERT_EQ(region.iova, to_iova(self->device, region.vaddr));
@@ -195,7 +195,7 @@ TEST_F(vfio_dma_mapping_test, dma_map_unmap)
 	}
 
 unmap:
-	rc = __vfio_pci_dma_unmap(self->device, &region, &unmapped);
+	rc = __iommu_unmap(self->iommu, &region, &unmapped);
 	ASSERT_EQ(rc, 0);
 	ASSERT_EQ(unmapped, region.size);
 	printf("Unmapped IOVA 0x%lx\n", region.iova);
@@ -245,7 +245,7 @@ FIXTURE_SETUP(vfio_dma_map_limit_test)
 			     MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
 	ASSERT_NE(region->vaddr, MAP_FAILED);
 
-	ranges = vfio_pci_iova_ranges(self->device, &nranges);
+	ranges = iommu_iova_ranges(self->iommu, &nranges);
 	VFIO_ASSERT_NOT_NULL(ranges);
 	last_iova = ranges[nranges - 1].last;
 	free(ranges);
@@ -268,10 +268,10 @@ TEST_F(vfio_dma_map_limit_test, unmap_range)
 	u64 unmapped;
 	int rc;
 
-	vfio_pci_dma_map(self->device, region);
+	iommu_map(self->iommu, region);
 	ASSERT_EQ(region->iova, to_iova(self->device, region->vaddr));
 
-	rc = __vfio_pci_dma_unmap(self->device, region, &unmapped);
+	rc = __iommu_unmap(self->iommu, region, &unmapped);
 	ASSERT_EQ(rc, 0);
 	ASSERT_EQ(unmapped, region->size);
 }
@@ -282,10 +282,10 @@ TEST_F(vfio_dma_map_limit_test, unmap_all)
 	u64 unmapped;
 	int rc;
 
-	vfio_pci_dma_map(self->device, region);
+	iommu_map(self->iommu, region);
 	ASSERT_EQ(region->iova, to_iova(self->device, region->vaddr));
 
-	rc = __vfio_pci_dma_unmap_all(self->device, &unmapped);
+	rc = __iommu_unmap_all(self->iommu, &unmapped);
 	ASSERT_EQ(rc, 0);
 	ASSERT_EQ(unmapped, region->size);
 }
@@ -298,10 +298,10 @@ TEST_F(vfio_dma_map_limit_test, overflow)
 	region->iova = ~(iova_t)0 & ~(region->size - 1);
 	region->size = self->mmap_size;
 
-	rc = __vfio_pci_dma_map(self->device, region);
+	rc = __iommu_map(self->iommu, region);
 	ASSERT_EQ(rc, -EOVERFLOW);
 
-	rc = __vfio_pci_dma_unmap(self->device, region, NULL);
+	rc = __iommu_unmap(self->iommu, region, NULL);
 	ASSERT_EQ(rc, -EOVERFLOW);
 }
 
diff --git a/tools/testing/selftests/vfio/vfio_pci_driver_test.c b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
index 057aa9bbe13e..229e932a06f8 100644
--- a/tools/testing/selftests/vfio/vfio_pci_driver_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
@@ -18,7 +18,7 @@ static const char *device_bdf;
 	ASSERT_EQ(EAGAIN, errno);			\
 } while (0)
 
-static void region_setup(struct vfio_pci_device *device,
+static void region_setup(struct iommu *iommu,
 			 struct iova_allocator *iova_allocator,
 			 struct dma_region *region, u64 size)
 {
@@ -33,13 +33,12 @@ static void region_setup(struct vfio_pci_device *device,
 	region->iova = iova_allocator_alloc(iova_allocator, size);
 	region->size = size;
 
-	vfio_pci_dma_map(device, region);
+	iommu_map(iommu, region);
 }
 
-static void region_teardown(struct vfio_pci_device *device,
-			    struct dma_region *region)
+static void region_teardown(struct iommu *iommu, struct dma_region *region)
 {
-	vfio_pci_dma_unmap(device, region);
+	iommu_unmap(iommu, region);
 	VFIO_ASSERT_EQ(munmap(region->vaddr, region->size), 0);
 }
 
@@ -76,12 +75,12 @@ FIXTURE_SETUP(vfio_pci_driver_test)
 
 	self->iommu = iommu_init(variant->iommu_mode);
 	self->device = vfio_pci_device_init(device_bdf, self->iommu);
-	self->iova_allocator = iova_allocator_init(self->device);
+	self->iova_allocator = iova_allocator_init(self->iommu);
 
 	driver = &self->device->driver;
 
-	region_setup(self->device, self->iova_allocator, &self->memcpy_region, SZ_1G);
-	region_setup(self->device, self->iova_allocator, &driver->region, SZ_2M);
+	region_setup(self->iommu, self->iova_allocator, &self->memcpy_region, SZ_1G);
+	region_setup(self->iommu, self->iova_allocator, &driver->region, SZ_2M);
 
 	/* Any IOVA that doesn't overlap memcpy_region and driver->region. */
 	self->unmapped_iova = iova_allocator_alloc(self->iova_allocator, SZ_1G);
@@ -110,8 +109,8 @@ FIXTURE_TEARDOWN(vfio_pci_driver_test)
 
 	vfio_pci_driver_remove(self->device);
 
-	region_teardown(self->device, &self->memcpy_region);
-	region_teardown(self->device, &driver->region);
+	region_teardown(self->iommu, &self->memcpy_region);
+	region_teardown(self->iommu, &driver->region);
 
 	iova_allocator_cleanup(self->iova_allocator);
 	vfio_pci_device_cleanup(self->device);
-- 
2.52.0.rc2.455.g230fcf2819-goog


