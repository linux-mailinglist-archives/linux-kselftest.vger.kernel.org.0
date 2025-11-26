Return-Path: <linux-kselftest+bounces-46586-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A9783C8C532
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 00:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7271B4E13DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 23:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5139E347BD4;
	Wed, 26 Nov 2025 23:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oW1hvqn1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0B534402B
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 23:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764199080; cv=none; b=EDVeLnAv6KJboZtfxoBvJTilp9FaIbNGbuSSfkx7WXBEpVIWmGNFWvYGoHkTG8+3SPGtRS+USzTJW512kxsn4uE3igx7vmSMMpyoxg3JAs5MAhFowTypvr1nFIr419vMp0WJJhTHXqDJzRUMnW3n1y0BK2t1bl7f+slZY6US7yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764199080; c=relaxed/simple;
	bh=5/SCuudTnVJVagXzmpq8FqpR4LPOkZ4AQaSUVZpAyeA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oMWxbWxwpKL7vfrOZjcmnhQFd1ltrIG9HRMltlqg897O8wuVN3vYhyOTgM/YG8fczcYOCtk00XYr/t7zt8pIQ9w2WGiw5Vnglp/dnLz8gklh9/CRk2p/9ckZu1iMv3I04UPRbAbFn9iwDAnhiHPbo5WDh4sqyTmrrsaWm+O8trM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oW1hvqn1; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3436d81a532so386481a91.3
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 15:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764199077; x=1764803877; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2a9D5jJ9FB8GiVn7bo2b0SNxBhehEjQAFnObT7UgTmQ=;
        b=oW1hvqn1a71LL3ffufvUkUSm1WF1QIMuNMroMzuZp4Mg9oOD/kV/6I5O34MHXE4t5v
         WhlvsuI2PubNNuRiBORT2rjCwksbHlMn1K/9KUVkWZjKpYuKe352PqSv0aMmrc5yOzpG
         3HRlbruKsqmHTUP7sqsNFhFqdxwTHFqbaHIsV/ZkUvWLFry0ilgf2i2gz89X0eWLZ1EE
         D2p8KBS8MbgC9hetmfohaplvoEMP78tb9zc+0uVQhDpwlmxCREfi0/20r8cBJdZLZfTg
         9bV8h/AcIXcAYm0QDjeF6nJyI3aesUaaBSbQyP5NEptivNnWNhVXbBleH2TNm3Gl0ilU
         lVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764199077; x=1764803877;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2a9D5jJ9FB8GiVn7bo2b0SNxBhehEjQAFnObT7UgTmQ=;
        b=pIQAUhK7WvKhE918zoTpyFq8ymBPpqQ3XjTLA1AjR+/9SB8l9XD05CjLi6WtQd2yNR
         2TM92EFEBnxn/aYPTjW7vK11OMFAcf0S51tjhdcvYo+6GeRrURnkovrv4wm0OZu1d27K
         pGngugJAHVfHyolp2UsLQ1uEt+st1s8wQirjq5Y+hB3WZFD/180a63lyiXvEQZIeFNub
         gu3QerkQ15pjOc7OrpJA4DnvKcRSLYrEmx862PrsD5UqGCo0n2i5hP8PlQ5CSl+nq5DS
         PbWeqIcukTZUhGJbs1cK08Du/nWimxXS7W7E/iUGnS7RVQRHccdh7RtaiuZIAQyYsUsw
         QV0A==
X-Forwarded-Encrypted: i=1; AJvYcCUvFJVsu0o95okBwgk0diyw1aeOdxfTaC3xE086DLvt3K1fKLqfdR+pB193Asy1a2mJ2S3b0FItcTjpyTsVBN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbDA9/jJ4NcRuKDPCi5x9weZRkOg0rzfmnYxMQvrDQ20v2bZGo
	q3GPrNB2NyaYIFleRIOrg+b0vxnj/jrj0F4JAsHen74c+P9kJe4NwSxPYpyftypcQCINGduL2Q1
	20c61BoIQU+VSfA==
X-Google-Smtp-Source: AGHT+IHuIShD6RC7Uglwv6GJggqqApaqxy3RkM9V/d+JZpaS74r3sOttZlNtCq4H6+fs9d4t2pHOQSUCma4m6Q==
X-Received: from pjbmt14.prod.google.com ([2002:a17:90b:230e:b0:33b:d40a:d93a])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3d85:b0:32d:f352:f764 with SMTP id 98e67ed59e1d1-34733e6caa6mr15630962a91.2.1764199077598;
 Wed, 26 Nov 2025 15:17:57 -0800 (PST)
Date: Wed, 26 Nov 2025 23:17:25 +0000
In-Reply-To: <20251126231733.3302983-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251126231733.3302983-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251126231733.3302983-11-dmatlack@google.com>
Subject: [PATCH v4 10/18] vfio: selftests: Rename struct vfio_dma_region to dma_region
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Alex Mastro <amastro@fb.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Raghavendra Rao Ananta <rananta@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Rename struct vfio_dma_region to dma_region. This is in preparation for
separating the VFIO PCI device library code from the IOMMU library code.
This name change also better reflects the fact that DMA mappings can be
managed by either VFIO or IOMMUFD. i.e. the "vfio_" prefix is
misleading.

Reviewed-by: Alex Mastro <amastro@fb.com>
Tested-by: Alex Mastro <amastro@fb.com>
Reviewed-by: Raghavendra Rao Ananta <rananta@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/lib/include/vfio_util.h | 12 ++++++------
 tools/testing/selftests/vfio/lib/vfio_pci_device.c   | 12 ++++++------
 tools/testing/selftests/vfio/vfio_dma_mapping_test.c | 12 ++++++------
 tools/testing/selftests/vfio/vfio_pci_driver_test.c  |  6 +++---
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
index babbf90688e8..7784422116de 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -80,7 +80,7 @@ typedef u64 iova_t;
 
 #define INVALID_IOVA UINT64_MAX
 
-struct vfio_dma_region {
+struct dma_region {
 	struct list_head link;
 	void *vaddr;
 	iova_t iova;
@@ -154,7 +154,7 @@ struct vfio_pci_driver {
 	bool memcpy_in_progress;
 
 	/* Region to be used by the driver (e.g. for in-memory descriptors) */
-	struct vfio_dma_region region;
+	struct dma_region region;
 
 	/* The maximum size that can be passed to memcpy_start(). */
 	u64 max_memcpy_size;
@@ -236,20 +236,20 @@ void iova_allocator_cleanup(struct iova_allocator *allocator);
 iova_t iova_allocator_alloc(struct iova_allocator *allocator, size_t size);
 
 int __vfio_pci_dma_map(struct vfio_pci_device *device,
-		       struct vfio_dma_region *region);
+		       struct dma_region *region);
 int __vfio_pci_dma_unmap(struct vfio_pci_device *device,
-			 struct vfio_dma_region *region,
+			 struct dma_region *region,
 			 u64 *unmapped);
 int __vfio_pci_dma_unmap_all(struct vfio_pci_device *device, u64 *unmapped);
 
 static inline void vfio_pci_dma_map(struct vfio_pci_device *device,
-				    struct vfio_dma_region *region)
+				    struct dma_region *region)
 {
 	VFIO_ASSERT_EQ(__vfio_pci_dma_map(device, region), 0);
 }
 
 static inline void vfio_pci_dma_unmap(struct vfio_pci_device *device,
-				      struct vfio_dma_region *region)
+				      struct dma_region *region)
 {
 	VFIO_ASSERT_EQ(__vfio_pci_dma_unmap(device, region, NULL), 0);
 }
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index f0cf18d3de55..422ad8dfad95 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -275,7 +275,7 @@ iova_t iova_allocator_alloc(struct iova_allocator *allocator, size_t size)
 
 iova_t __to_iova(struct vfio_pci_device *device, void *vaddr)
 {
-	struct vfio_dma_region *region;
+	struct dma_region *region;
 
 	list_for_each_entry(region, &device->iommu->dma_regions, link) {
 		if (vaddr < region->vaddr)
@@ -387,7 +387,7 @@ static void vfio_pci_irq_get(struct vfio_pci_device *device, u32 index,
 }
 
 static int vfio_iommu_dma_map(struct vfio_pci_device *device,
-			       struct vfio_dma_region *region)
+			       struct dma_region *region)
 {
 	struct vfio_iommu_type1_dma_map args = {
 		.argsz = sizeof(args),
@@ -404,7 +404,7 @@ static int vfio_iommu_dma_map(struct vfio_pci_device *device,
 }
 
 static int iommufd_dma_map(struct vfio_pci_device *device,
-			    struct vfio_dma_region *region)
+			    struct dma_region *region)
 {
 	struct iommu_ioas_map args = {
 		.size = sizeof(args),
@@ -424,7 +424,7 @@ static int iommufd_dma_map(struct vfio_pci_device *device,
 }
 
 int __vfio_pci_dma_map(struct vfio_pci_device *device,
-		      struct vfio_dma_region *region)
+		      struct dma_region *region)
 {
 	int ret;
 
@@ -480,7 +480,7 @@ static int iommufd_dma_unmap(int fd, u64 iova, u64 length, u32 ioas_id,
 }
 
 int __vfio_pci_dma_unmap(struct vfio_pci_device *device,
-			 struct vfio_dma_region *region, u64 *unmapped)
+			 struct dma_region *region, u64 *unmapped)
 {
 	int ret;
 
@@ -504,7 +504,7 @@ int __vfio_pci_dma_unmap(struct vfio_pci_device *device,
 int __vfio_pci_dma_unmap_all(struct vfio_pci_device *device, u64 *unmapped)
 {
 	int ret;
-	struct vfio_dma_region *curr, *next;
+	struct dma_region *curr, *next;
 
 	if (device->iommu->iommufd)
 		ret = iommufd_dma_unmap(device->iommu->iommufd, 0, UINT64_MAX,
diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
index 4727feb214c8..289af4665803 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -136,7 +136,7 @@ TEST_F(vfio_dma_mapping_test, dma_map_unmap)
 {
 	const u64 size = variant->size ?: getpagesize();
 	const int flags = variant->mmap_flags;
-	struct vfio_dma_region region;
+	struct dma_region region;
 	struct iommu_mapping mapping;
 	u64 mapping_size = size;
 	u64 unmapped;
@@ -208,7 +208,7 @@ TEST_F(vfio_dma_mapping_test, dma_map_unmap)
 FIXTURE(vfio_dma_map_limit_test) {
 	struct iommu *iommu;
 	struct vfio_pci_device *device;
-	struct vfio_dma_region region;
+	struct dma_region region;
 	size_t mmap_size;
 };
 
@@ -227,7 +227,7 @@ FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES();
 
 FIXTURE_SETUP(vfio_dma_map_limit_test)
 {
-	struct vfio_dma_region *region = &self->region;
+	struct dma_region *region = &self->region;
 	struct iommu_iova_range *ranges;
 	u64 region_size = getpagesize();
 	iova_t last_iova;
@@ -264,7 +264,7 @@ FIXTURE_TEARDOWN(vfio_dma_map_limit_test)
 
 TEST_F(vfio_dma_map_limit_test, unmap_range)
 {
-	struct vfio_dma_region *region = &self->region;
+	struct dma_region *region = &self->region;
 	u64 unmapped;
 	int rc;
 
@@ -278,7 +278,7 @@ TEST_F(vfio_dma_map_limit_test, unmap_range)
 
 TEST_F(vfio_dma_map_limit_test, unmap_all)
 {
-	struct vfio_dma_region *region = &self->region;
+	struct dma_region *region = &self->region;
 	u64 unmapped;
 	int rc;
 
@@ -292,7 +292,7 @@ TEST_F(vfio_dma_map_limit_test, unmap_all)
 
 TEST_F(vfio_dma_map_limit_test, overflow)
 {
-	struct vfio_dma_region *region = &self->region;
+	struct dma_region *region = &self->region;
 	int rc;
 
 	region->iova = ~(iova_t)0 & ~(region->size - 1);
diff --git a/tools/testing/selftests/vfio/vfio_pci_driver_test.c b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
index b0c7d812de1f..057aa9bbe13e 100644
--- a/tools/testing/selftests/vfio/vfio_pci_driver_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
@@ -20,7 +20,7 @@ static const char *device_bdf;
 
 static void region_setup(struct vfio_pci_device *device,
 			 struct iova_allocator *iova_allocator,
-			 struct vfio_dma_region *region, u64 size)
+			 struct dma_region *region, u64 size)
 {
 	const int flags = MAP_SHARED | MAP_ANONYMOUS;
 	const int prot = PROT_READ | PROT_WRITE;
@@ -37,7 +37,7 @@ static void region_setup(struct vfio_pci_device *device,
 }
 
 static void region_teardown(struct vfio_pci_device *device,
-			    struct vfio_dma_region *region)
+			    struct dma_region *region)
 {
 	vfio_pci_dma_unmap(device, region);
 	VFIO_ASSERT_EQ(munmap(region->vaddr, region->size), 0);
@@ -47,7 +47,7 @@ FIXTURE(vfio_pci_driver_test) {
 	struct iommu *iommu;
 	struct vfio_pci_device *device;
 	struct iova_allocator *iova_allocator;
-	struct vfio_dma_region memcpy_region;
+	struct dma_region memcpy_region;
 	void *vaddr;
 	int msi_fd;
 
-- 
2.52.0.487.g5c8c507ade-goog


