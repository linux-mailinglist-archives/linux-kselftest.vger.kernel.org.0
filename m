Return-Path: <linux-kselftest+bounces-45454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE1CC542B2
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 20:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E9AF3B84F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 19:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96613538BB;
	Wed, 12 Nov 2025 19:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DjMejYYJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ABA3538A6
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 19:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975387; cv=none; b=YZA2NoGpkoEao/+BvhNVxeBYEoxS2yCN9lX3uVGX2sSN/uS0ysKTSJQiVyg8JCBCowAmzY2TpJJzwGtxSdcQusjFO3SOJUk/vNXMmNgJ1Ju7dr6z+ke0W5rs6f6UYj7dlxrirgSRZcG5P5Mp+lk5bwWzZwKLohZatyDYVvIvUFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975387; c=relaxed/simple;
	bh=ziyqjUHtKMrKVd0zgnNDhJCsoHFy7brURyeLh0BmOG4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JI8p0swybcE2qqgWFReh80xTqSxQ0yxK7B/wJtpZ58AnZ6znRSWr+3tNGwqVnkkSFDiSasOhyjvTgpPfd6ecTVrWxH0xl9CVvhOdQPxz/ez74whiplggx1NvhCQ1/DjGQ2HBNmMcKK5OLT3/O6v3VLoNlSWKEhGmIeDBREoF7BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DjMejYYJ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7b0e73b0f52so2384087b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 11:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762975384; x=1763580184; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QDUM2NK15b4A5lvtiNxBQOB3nHinOOh+D9L4COyosKw=;
        b=DjMejYYJ7ivyQLPWl+f8/P4SKUQ6KHoS7WtzrCJYB31srMxFI0Qgtj1YtlwT3JcyqY
         jGIBCqjfx5s9QOYGlaTsI1GDhjWPtAC1+u56m5ghbuU/hHPHG0sF+LUX7pNTpZk2tMyl
         5JgVBoZFRi5gyXk0XIclqoGr4PEwuejfTFzlitgztPIR5Jp8oHgzj7k6FB3M7p6EnOl9
         WBorFGzCUsmeHrfAfpf79JeMxz2AHlJqagjW9Dt6RHZHLzNt6hKCeHqv/PNayqbqh43N
         UusQsJO6YLY+1CESTev90v0SZ5hk2LvFD3ZA/jDapkAu6n4YgufF8rYQVFS5EfMgM9Cb
         eTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975384; x=1763580184;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QDUM2NK15b4A5lvtiNxBQOB3nHinOOh+D9L4COyosKw=;
        b=FTdHIybJqoj3qTw4cQmAz2H+TxoLa5Oa9sMslx9rqFUSzYEpYP2rubRudAcaVZVPtU
         I8U7wlMgpc5OEy62en5Yn2tx7bxhkykD/tyKOqhWbWl+k43KO0+3ZyOkd/xbYtJ5Rcky
         7CMOa4vq1NusKqjuhqRg6/CPI8HfHvXSfP7Y7ZCQAZ0UHHnkrIX3zvWVGPYtc8dMmk0a
         gU6GKqUGlqnMnsRS/4OWLrv4Bc5rRSrUjCB7yO56k9zZ/3l9+k16eXMw3Ppngiks8vB5
         KuZRO0VVTWeWSDbCWJJTgcM+pM33y+4hwWhk+EdeR9uFCn+xGEvna2DKPIHURk476rtU
         avMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeXyJ60bdDaByWOjlkjVsQSYJvyyxDMRXilM38utorSKgYPm5+VZAEcVcKp6T8ILqMAGLSMCX8hl9WGJnhQYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyzcKC8dUwbkm7xj5B98rBtKGI0ZIAwggqj3tgG5CQHpzAOW5w
	67aTQYgbGou/0w6T0Af9j2BbGqItXGlhtqWmMryaOLv75cxnA4SupXmmokrS2PlSFORygBYDSqQ
	CoXKvaF1HOJKIKQ==
X-Google-Smtp-Source: AGHT+IEMXPRZlnocl6XkYY/pmIh7xcdwjbJWrd6xHc+Z+8UgXczaFCv9IRoJlhqyQP3H4kW5w1K5ojzUHkCJZw==
X-Received: from pfuf34.prod.google.com ([2002:a05:6a00:b22:b0:77c:6e29:42af])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7346:b0:343:3d3c:4685 with SMTP id adf61e73a8af0-3590988af94mr5335213637.18.1762975384015;
 Wed, 12 Nov 2025 11:23:04 -0800 (PST)
Date: Wed, 12 Nov 2025 19:22:27 +0000
In-Reply-To: <20251112192232.442761-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112192232.442761-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251112192232.442761-14-dmatlack@google.com>
Subject: [PATCH v2 13/18] vfio: selftests: Stop passing device for IOMMU operations
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>, 
	David Matlack <dmatlack@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Raghavendra Rao Ananta <rananta@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Drop the struct vfio_pci_device wrappers for IOMMU map/unmap functions
and require tests to directly call iommu_map(), iommu_unmap(), etc. This
results in more concise code, and also makes it clear the map operations
are happening on a struct iommu, not necessarily on a specific device,
especially when multi-device tests are introduced.

Do the same for iova_allocator_init() as that function only needs the
struct iommu, not struct vfio_pci_device.

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
2.52.0.rc1.455.g30608eb744-goog


