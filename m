Return-Path: <linux-kselftest+bounces-46273-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 358EEC7B45B
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 19:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEA5D3A4836
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 18:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA143502A0;
	Fri, 21 Nov 2025 18:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f3DXwxhd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F3A350D4D
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 18:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748900; cv=none; b=SkGbvryIgu1vNHe4HLz8v/Bq3C5OaZYxMRJhYCpxdFFtFHYrytNP1wqM5lD/tl7GLpnNvmgMXgrQ76iDDw1kMbsrOBZxlPec0LgRqF3S+c4tkCHWCOMCEBnGRD05jN0Y310UWZlo80Nc4yUsqck5R+sL6cKz0r+vJe+E3nvj+Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748900; c=relaxed/simple;
	bh=5+r9tKht6ww+IqzhMEcI27XtdT+trwXLGUM2y9av5Y4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qat9w6jGIlyqbMSQSTMn24aSv1lyDV+9QjMUf97UShCWVtBWqoNAQJ0oDqOcb2+yhZsLBtRWgfL2091k4pbS5flK5XLUUZQjTKMRVjW+UmlYdSU6843ltT3Vok9WPMEZJRyOqLXH7O6PvmYRhkqMHrKhH6uWUffUi2q0p7GjaTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f3DXwxhd; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3436d81a532so4756952a91.3
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 10:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763748894; x=1764353694; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IcgowuhKD7SZv+r4qHVnhttbmNLzYB67hIpXpmKWxiE=;
        b=f3DXwxhdJQx9hnQIu4jaQDu7vdSIiQxlJNHE77vORU2JFrwpguuexxgB2rMfFXo6sI
         Onmg9PUYZOxb96Y6I6gqWY8EJo906t3agQVqnTD4HKNZW+k1UddzgdtAaQvnPMQsphUA
         kmdRuFKSlNZuo15eqAm49TvGaxv83cHTzLCHqVscYUwfmwbxMzgJyv658LAiVC/MCGhT
         W+f88loqM+zWufhJApmaXf3KvQbtInnYal+uzeTyTfXtAlSbUY2GA7ETOTz1WVPMeRu/
         ASDZSymngCpvFz4A8wfMvx0vXodd2lUorpbKFeZzY86JgzqCqB70ZFotPb9cuwVz94CI
         eBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763748894; x=1764353694;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IcgowuhKD7SZv+r4qHVnhttbmNLzYB67hIpXpmKWxiE=;
        b=b73T5QNlFwIlUG3Qp9M0R2iGuQCCuQU2uiOPHJdfLNenhe5KtBU6HOiS28QxCBv4oV
         lWrDkLvqgU7FjGNDkSrFitt0ZTkUuRnnGU0HpxXcvJJbOU93Bzf76LzxImAr3vw9T3PR
         P3to3uEvPT3awP9VXfG3vXEdLu7WUuhb/unSbM7xqzSro3123KsHHw6Xcd60Cy9UGXU9
         UO1HEaO30nYj0LRnoPaAWJBkLq/B3sftI4KEYp0e6s4YM3xfuD6twGwrhnvFbtw1FMSU
         /ckAeTmUdtowNkuFTsRC1ugDRQIbd8DkhgVVfDE2FRjmD17Fgj/PUtpCXrKzT9l7O5tV
         h9hw==
X-Forwarded-Encrypted: i=1; AJvYcCUyWj/OxmpBHsfQx9zwTlYhVDnW9pZm1j37xMuJk9z1X7d6qCzqX3tKD3j2m+xiDNBfz2aXFHSxYRDiw8jWZcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNXniMKSKc93g9NMB0oovpIFzIZon0J0HEZxYdhmmUVHmS53pE
	ZrZo3p863V/xnr2SdnnJeqpgLdzfrXcTx3VWFLQd/qfFEDZ2gKZbeXiyDKz+eBsZ6xWXhVyAvdT
	X+uSWvnkxpy8MBw==
X-Google-Smtp-Source: AGHT+IEZu3uRBpM789cZ5tqcDrIxej0byI6xLLeXvIL6Few5RFNFFv6w4Lq7+JNtnRLkvoly5g85/4CuFDVoRA==
X-Received: from pjbsk6.prod.google.com ([2002:a17:90b:2dc6:b0:341:7640:eb1e])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3c01:b0:340:cb39:74cd with SMTP id 98e67ed59e1d1-34733f589e8mr3391916a91.32.1763748894507;
 Fri, 21 Nov 2025 10:14:54 -0800 (PST)
Date: Fri, 21 Nov 2025 18:14:21 +0000
In-Reply-To: <20251121181429.1421717-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251121181429.1421717-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251121181429.1421717-11-dmatlack@google.com>
Subject: [PATCH v3 10/18] vfio: selftests: Rename struct vfio_dma_region to dma_region
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
index f3aea724695d..877b145cef63 100644
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
2.52.0.rc2.455.g230fcf2819-goog


