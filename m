Return-Path: <linux-kselftest+bounces-45446-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 51012C541D1
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 20:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BBF54E420F
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 19:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A6334FF66;
	Wed, 12 Nov 2025 19:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LvNj3XxP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5937034EEFD
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 19:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975374; cv=none; b=mtOJoy2PfQcGmY9V1OsvKL4sZDF4srY+EvdMuHzfSA9Ya3iD/Ai7xrENyaVzvXzllcYiqAT+5DSMGThLcXbC5i996sZNmibDaO0pLggrE2wT2e5Dd9qVkFKgIwI5ERhajkMCaBbFn8yGlMEdUrcp2Rer+ZuiW/gaQhFD/LaLQ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975374; c=relaxed/simple;
	bh=8vby+HCEoNmOJeiU/OAmu3QUCbJihz0zFADhsivjBkU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hTCkF6mKro8LZT4xmMFBX4U8waI7QZc1t4R+baxrVv8D6Qix8o3UkeXlIrKMLFog1rVnVmitG7yeRQKozuHzLMnr2N61ARiMZKeGsKSMNiRdWRX3LYls16lx5k4epJVawRagRu7u5EpMVlD2IVPvw2vKE85tKzlqUAXudy/NNFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LvNj3XxP; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7aac981b333so1121860b3a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 11:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762975372; x=1763580172; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zc+91TMBIWOyFgOcp2tX+RcTMQd1o9IFITolzdEG7P4=;
        b=LvNj3XxP+D9aoBpg5amASobrFoaPXZ4G+GSsuohPSC3s4YM5B4OpixKjG/uBrnomTF
         vlhW/U9xnrozZy8wVw6BarH1Oj1J4+jlmN1VqIDMxbZz7mbzmKRfhMmZ3iGzCAkjun7Z
         rKBO5SrjM7MtY+DclrquMuwH3XuX3mqrVHd+1Y+LSLD9lOvF8pc2HD2HUZxNtLhuPkZO
         ru6emMC2WBUXwnSpEqHPggqStSvTOCB8BNtVYzhCMadVuVj3/7FqbXWga+4SUxOTYzB8
         WNocxOBX32yPLcxzu+yVqqwj0Eeq66Epw/zPFJivoNL7qlcpWeMtS9RjIABurdwOSjXS
         Pw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975372; x=1763580172;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zc+91TMBIWOyFgOcp2tX+RcTMQd1o9IFITolzdEG7P4=;
        b=LIbqj8GRm004UewDyE9e52wtHYzKGjBV0nBvtKgIeVBK0Q9NubSwFcPkR0AWPEtD7G
         Ffq9QWiPOTxYXY/nfdGAiinQWWj63P5V0OVpl7jOUmNrfF/VDMqKwcAmwcUTICVWb+rx
         G28EV7U0oZpiN6VERQwbM6tX+XQGTcbRzDTX+Cbr/r/0LkfGAG4wCiiinecjYDBef5sJ
         Vtc++BHqca31wofwF6CsnEmZheNp83UWKXPLuRUdgvqwZ2TDVjSzouNehnzEhQALfJGq
         hRKeBRpa3VbZnJV/23nqqvisi2qfs+jD/Dme3u/y4Vh4WEquk2FI+XcrQPwOnxsrHy85
         itOQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5OcODZ98a4oKmWn4Jna92+Q31dZiUQ5HQ5u9O1OPI/4N6NgXs6ld8uCdRvgWgyDi7/jzQNXP0d63ygUQDQwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBoAxmRcDTHjWtqSMW3yS0ICAuoaMyi7lyjkKMAHS/HMhNaSnX
	rDESCJ6eCQ1qAMcyyNvO79U12lVe1JasKiBPgm9+d+nMvIM4BNjFYDhFfvbpRawC3V/yNG6TK1Y
	PDzUQ9zarJ+/XVw==
X-Google-Smtp-Source: AGHT+IHoMgB+dZbPNWY+JGeNK4aOZ/BFgrRUgHQJ7JHZ3hjF+UZlstjSYC0pPg/1VvgkZyLkN8ffpdm1ZYKVMQ==
X-Received: from pfbfj2.prod.google.com ([2002:a05:6a00:3a02:b0:76b:651e:a69c])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:23c2:b0:7b7:8aad:99cc with SMTP id d2e1a72fcca58-7b7a2a96cfcmr4390935b3a.3.1762975371623;
 Wed, 12 Nov 2025 11:22:51 -0800 (PST)
Date: Wed, 12 Nov 2025 19:22:19 +0000
In-Reply-To: <20251112192232.442761-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112192232.442761-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251112192232.442761-6-dmatlack@google.com>
Subject: [PATCH v2 05/18] vfio: selftests: Introduce struct iommu
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>, 
	David Matlack <dmatlack@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Raghavendra Rao Ananta <rananta@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce struct iommu, which logically represents either a VFIO
container or an iommufd IOAS, depending on which IOMMU mode is used by
the test.

This will be used in a subsequent commit to allow devices to be added to
the same container/iommufd.

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
2.52.0.rc1.455.g30608eb744-goog


