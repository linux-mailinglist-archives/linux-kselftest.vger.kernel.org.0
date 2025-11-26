Return-Path: <linux-kselftest+bounces-46581-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9F1C8C526
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 00:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F41A03B7255
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 23:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD8F3451CB;
	Wed, 26 Nov 2025 23:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BzzI7MBg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0B5344024
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 23:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764199072; cv=none; b=BtT4t7EGZw7osUdu4m4v2TBwOtmOFeiAlLwPVeTWaGEpAIjRrXK+7o88mRoUliyhRi8Z/fcZflZp6BlOYlLcO1WJb1qQH1ww2RwkGzG6MIn1AYMs1Bw8UGKwOF8lKEAg7wqyKIuARroCCMHWXjI/aT3h6dt5ZlRvwchyrNcl6xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764199072; c=relaxed/simple;
	bh=4ctcwjOZpYfjhBgr81oa+ZMQJXqIEiQxp8XLN4bP2ys=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DHeRA0lMJbIP/3HiHvSQQj3x92GOwnWNc4/koXh4vZr0XpcB8/NnMV9qgaoDQnEYkklxQ9S0cl2uXPxTIQozdjGKuH1Hv3b3xFTUk2xug5GPVmxxS+ENAU7zwAfuA8MRTsA796j9cRbQpeogqSr+xr2jlRwtFyLpvF6KGIXLLyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BzzI7MBg; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7a432101881so312474b3a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 15:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764199070; x=1764803870; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kbH7teUW9AJZSiPpZ4cl9Q7VSRKbEEWLu0lijd6mElE=;
        b=BzzI7MBgWwYASfwwLTWHS9fKsKlu7yiT9NkgYGbB42x/GqgPbB3XDdccXPVxo6MmU7
         ddhHrcm77no7wbMfeyiidQ/hee9YTP0nOGKAK6K6mScKgK4XrRUPsKFCERG3ozyss3i0
         vaIjjTEXRTUgO+525GVBDLGatY5gwQj1RnV5KMZUCz7z8tSMKvdpL6LdP6qPcqdPt9eZ
         3FJo3gwpVNQF9nE8O5RcxvZZmcHOmKy+Kj11X+KrxZ1LSn/J3Gj0DqxhRdKS5CCWYe2A
         sLvzXdGsbiVQjSAmOfU2e1cUqoawzSgSYyBouacumgc2DiXomUEXSebl8Smfmah95YFx
         TWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764199070; x=1764803870;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kbH7teUW9AJZSiPpZ4cl9Q7VSRKbEEWLu0lijd6mElE=;
        b=IZFW7P9gKb+ylplq3uoMXOc0/w7K1v10pLdVyDYUCtY8Lp1pUGyphAUIvE5af4gb40
         gFtF+sSEyKPxF1P4daGWSwXBt8Gx9Juqd/8JUUH9INWi3EUgAp5spGlW0bz6LuBaXM+t
         esYrEKCOgDZM67JzCklbPyZ8J1yX6r9bgE8QOpIMnvuuQfq6SB+d1waeKSNs+Lh2EMaa
         SmSiBu29eJtGz+VMc7RaJjOlagsJCnPXyq9HvtgW9Uy+y0H3S3m/yir7QkTabsfJdbS5
         n9LaNwjqSCaoFi02JB3Nf+uPwutmCPAbiYNm49TeW8QAqoiLNYjYb+7DD5aAdZghLTFy
         RilA==
X-Forwarded-Encrypted: i=1; AJvYcCXOOgFxXKWxb57y1W3TK+fhKCzJidCvwU0MgSM5eEB6XOZbSlI9LNhXAkZVU9vQS21Egve0K6Myd3hHvwtO+7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz99cGG1YusTzWsBEwJIWin0ZXNcjRL3pzyLP9bSzbL4zCelr5D
	MYUBuO8ieSZ8arOT2AiZgh5yg43lBGNgZv8EzGYaLhhwojFWZdlyiDyhjUK3oZAGSqF9BF6WrgS
	cXA/my/Se7i1EIA==
X-Google-Smtp-Source: AGHT+IEs/72sCxSAjVsycUAtS0UnnCUVTdlRwBfkbycI/Oud/l4DJ5rvVGzu5Cvo4BL3ofWvpQOSijID+Ehxfg==
X-Received: from pfht15.prod.google.com ([2002:a62:ea0f:0:b0:77f:68a4:6770])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:998b:b0:34f:ec81:bc3a with SMTP id adf61e73a8af0-36150f05ca6mr25468146637.28.1764199069736;
 Wed, 26 Nov 2025 15:17:49 -0800 (PST)
Date: Wed, 26 Nov 2025 23:17:20 +0000
In-Reply-To: <20251126231733.3302983-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251126231733.3302983-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251126231733.3302983-6-dmatlack@google.com>
Subject: [PATCH v4 05/18] vfio: selftests: Introduce struct iommu
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Alex Mastro <amastro@fb.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Raghavendra Rao Ananta <rananta@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce struct iommu, which logically represents either a VFIO
container or an iommufd IOAS, depending on which IOMMU mode is used by
the test.

This will be used in a subsequent commit to allow devices to be added to
the same container/iommufd.

Reviewed-by: Alex Mastro <amastro@fb.com>
Tested-by: Alex Mastro <amastro@fb.com>
Reviewed-by: Raghavendra Rao Ananta <rananta@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../selftests/vfio/lib/include/vfio_util.h    | 16 ++--
 .../selftests/vfio/lib/vfio_pci_device.c      | 75 ++++++++++---------
 2 files changed, 49 insertions(+), 42 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
index 2f5555138d7f..3160f2d1ea6d 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -163,15 +163,19 @@ struct vfio_pci_driver {
 	int msi;
 };
 
+struct iommu {
+	const struct iommu_mode *mode;
+	int container_fd;
+	int iommufd;
+	u32 ioas_id;
+	struct list_head dma_regions;
+};
+
 struct vfio_pci_device {
 	int fd;
-
-	const struct iommu_mode *iommu_mode;
 	int group_fd;
-	int container_fd;
 
-	int iommufd;
-	u32 ioas_id;
+	struct iommu *iommu;
 
 	struct vfio_device_info info;
 	struct vfio_region_info config_space;
@@ -180,8 +184,6 @@ struct vfio_pci_device {
 	struct vfio_irq_info msi_info;
 	struct vfio_irq_info msix_info;
 
-	struct list_head dma_regions;
-
 	/* eventfds for MSI and MSI-x interrupts */
 	int msi_eventfds[PCI_MSIX_FLAGS_QSIZE + 1];
 
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 4a021ff4fc40..e47f3ccf6d49 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -277,7 +277,7 @@ iova_t __to_iova(struct vfio_pci_device *device, void *vaddr)
 {
 	struct vfio_dma_region *region;
 
-	list_for_each_entry(region, &device->dma_regions, link) {
+	list_for_each_entry(region, &device->iommu->dma_regions, link) {
 		if (vaddr < region->vaddr)
 			continue;
 
@@ -397,7 +397,7 @@ static int vfio_iommu_dma_map(struct vfio_pci_device *device,
 		.size = region->size,
 	};
 
-	if (ioctl(device->container_fd, VFIO_IOMMU_MAP_DMA, &args))
+	if (ioctl(device->iommu->container_fd, VFIO_IOMMU_MAP_DMA, &args))
 		return -errno;
 
 	return 0;
@@ -414,10 +414,10 @@ static int iommufd_dma_map(struct vfio_pci_device *device,
 		.user_va = (u64)region->vaddr,
 		.iova = region->iova,
 		.length = region->size,
-		.ioas_id = device->ioas_id,
+		.ioas_id = device->iommu->ioas_id,
 	};
 
-	if (ioctl(device->iommufd, IOMMU_IOAS_MAP, &args))
+	if (ioctl(device->iommu->iommufd, IOMMU_IOAS_MAP, &args))
 		return -errno;
 
 	return 0;
@@ -428,7 +428,7 @@ int __vfio_pci_dma_map(struct vfio_pci_device *device,
 {
 	int ret;
 
-	if (device->iommufd)
+	if (device->iommu->iommufd)
 		ret = iommufd_dma_map(device, region);
 	else
 		ret = vfio_iommu_dma_map(device, region);
@@ -436,7 +436,7 @@ int __vfio_pci_dma_map(struct vfio_pci_device *device,
 	if (ret)
 		return ret;
 
-	list_add(&region->link, &device->dma_regions);
+	list_add(&region->link, &device->iommu->dma_regions);
 
 	return 0;
 }
@@ -484,13 +484,14 @@ int __vfio_pci_dma_unmap(struct vfio_pci_device *device,
 {
 	int ret;
 
-	if (device->iommufd)
-		ret = iommufd_dma_unmap(device->iommufd, region->iova,
-					region->size, device->ioas_id,
+	if (device->iommu->iommufd)
+		ret = iommufd_dma_unmap(device->iommu->iommufd, region->iova,
+					region->size, device->iommu->ioas_id,
 					unmapped);
 	else
-		ret = vfio_iommu_dma_unmap(device->container_fd, region->iova,
-					   region->size, 0, unmapped);
+		ret = vfio_iommu_dma_unmap(device->iommu->container_fd,
+					   region->iova, region->size, 0,
+					   unmapped);
 
 	if (ret)
 		return ret;
@@ -505,17 +506,17 @@ int __vfio_pci_dma_unmap_all(struct vfio_pci_device *device, u64 *unmapped)
 	int ret;
 	struct vfio_dma_region *curr, *next;
 
-	if (device->iommufd)
-		ret = iommufd_dma_unmap(device->iommufd, 0, UINT64_MAX,
-					device->ioas_id, unmapped);
+	if (device->iommu->iommufd)
+		ret = iommufd_dma_unmap(device->iommu->iommufd, 0, UINT64_MAX,
+					device->iommu->ioas_id, unmapped);
 	else
-		ret = vfio_iommu_dma_unmap(device->container_fd, 0, 0,
+		ret = vfio_iommu_dma_unmap(device->iommu->container_fd, 0, 0,
 					   VFIO_DMA_UNMAP_FLAG_ALL, unmapped);
 
 	if (ret)
 		return ret;
 
-	list_for_each_entry_safe(curr, next, &device->dma_regions, link)
+	list_for_each_entry_safe(curr, next, &device->iommu->dma_regions, link)
 		list_del_init(&curr->link);
 
 	return 0;
@@ -627,28 +628,28 @@ static void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf
 	ioctl_assert(device->group_fd, VFIO_GROUP_GET_STATUS, &group_status);
 	VFIO_ASSERT_TRUE(group_status.flags & VFIO_GROUP_FLAGS_VIABLE);
 
-	ioctl_assert(device->group_fd, VFIO_GROUP_SET_CONTAINER, &device->container_fd);
+	ioctl_assert(device->group_fd, VFIO_GROUP_SET_CONTAINER, &device->iommu->container_fd);
 }
 
 static void vfio_pci_container_setup(struct vfio_pci_device *device, const char *bdf)
 {
-	unsigned long iommu_type = device->iommu_mode->iommu_type;
-	const char *path = device->iommu_mode->container_path;
+	unsigned long iommu_type = device->iommu->mode->iommu_type;
+	const char *path = device->iommu->mode->container_path;
 	int version;
 	int ret;
 
-	device->container_fd = open(path, O_RDWR);
-	VFIO_ASSERT_GE(device->container_fd, 0, "open(%s) failed\n", path);
+	device->iommu->container_fd = open(path, O_RDWR);
+	VFIO_ASSERT_GE(device->iommu->container_fd, 0, "open(%s) failed\n", path);
 
-	version = ioctl(device->container_fd, VFIO_GET_API_VERSION);
+	version = ioctl(device->iommu->container_fd, VFIO_GET_API_VERSION);
 	VFIO_ASSERT_EQ(version, VFIO_API_VERSION, "Unsupported version: %d\n", version);
 
 	vfio_pci_group_setup(device, bdf);
 
-	ret = ioctl(device->container_fd, VFIO_CHECK_EXTENSION, iommu_type);
+	ret = ioctl(device->iommu->container_fd, VFIO_CHECK_EXTENSION, iommu_type);
 	VFIO_ASSERT_GT(ret, 0, "VFIO IOMMU type %lu not supported\n", iommu_type);
 
-	ioctl_assert(device->container_fd, VFIO_SET_IOMMU, (void *)iommu_type);
+	ioctl_assert(device->iommu->container_fd, VFIO_SET_IOMMU, (void *)iommu_type);
 
 	device->fd = ioctl(device->group_fd, VFIO_GROUP_GET_DEVICE_FD, bdf);
 	VFIO_ASSERT_GE(device->fd, 0);
@@ -801,12 +802,12 @@ static void vfio_pci_iommufd_setup(struct vfio_pci_device *device, const char *b
 	 * used to check if iommufd is enabled. In practice open() will never
 	 * return 0 unless stdin is closed.
 	 */
-	device->iommufd = open("/dev/iommu", O_RDWR);
-	VFIO_ASSERT_GT(device->iommufd, 0);
+	device->iommu->iommufd = open("/dev/iommu", O_RDWR);
+	VFIO_ASSERT_GT(device->iommu->iommufd, 0);
 
-	vfio_device_bind_iommufd(device->fd, device->iommufd);
-	device->ioas_id = iommufd_ioas_alloc(device->iommufd);
-	vfio_device_attach_iommufd_pt(device->fd, device->ioas_id);
+	vfio_device_bind_iommufd(device->fd, device->iommu->iommufd);
+	device->iommu->ioas_id = iommufd_ioas_alloc(device->iommu->iommufd);
+	vfio_device_attach_iommufd_pt(device->fd, device->iommu->ioas_id);
 }
 
 struct vfio_pci_device *vfio_pci_device_init(const char *bdf, const char *iommu_mode)
@@ -816,11 +817,14 @@ struct vfio_pci_device *vfio_pci_device_init(const char *bdf, const char *iommu_
 	device = calloc(1, sizeof(*device));
 	VFIO_ASSERT_NOT_NULL(device);
 
-	INIT_LIST_HEAD(&device->dma_regions);
+	device->iommu = calloc(1, sizeof(*device->iommu));
+	VFIO_ASSERT_NOT_NULL(device->iommu);
+
+	INIT_LIST_HEAD(&device->iommu->dma_regions);
 
-	device->iommu_mode = lookup_iommu_mode(iommu_mode);
+	device->iommu->mode = lookup_iommu_mode(iommu_mode);
 
-	if (device->iommu_mode->container_path)
+	if (device->iommu->mode->container_path)
 		vfio_pci_container_setup(device, bdf);
 	else
 		vfio_pci_iommufd_setup(device, bdf);
@@ -849,13 +853,14 @@ void vfio_pci_device_cleanup(struct vfio_pci_device *device)
 		VFIO_ASSERT_EQ(close(device->msi_eventfds[i]), 0);
 	}
 
-	if (device->iommufd) {
-		VFIO_ASSERT_EQ(close(device->iommufd), 0);
+	if (device->iommu->iommufd) {
+		VFIO_ASSERT_EQ(close(device->iommu->iommufd), 0);
 	} else {
 		VFIO_ASSERT_EQ(close(device->group_fd), 0);
-		VFIO_ASSERT_EQ(close(device->container_fd), 0);
+		VFIO_ASSERT_EQ(close(device->iommu->container_fd), 0);
 	}
 
+	free(device->iommu);
 	free(device);
 }
 
-- 
2.52.0.487.g5c8c507ade-goog


