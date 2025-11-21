Return-Path: <linux-kselftest+bounces-46270-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D8BC7B44C
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 19:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B03463A64B6
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 18:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D053E354AD3;
	Fri, 21 Nov 2025 18:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vYjuM3/b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E457F3538A9
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 18:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748892; cv=none; b=YrBKmdliyDuVv/BRbRazpA4w9NUmwj3+kjIyWPmMKPjkcslD1OJ0GOUXru8Fs9Au+BLK1Is04KSJzNUYjwhL4BZZqTSFRIrebGNjHwLJDCoL14dIzCL78oMOkGVUiPzOPQoHWqYYlTYLJj0pCAfKhQKullev41I5hlZNLHjgMbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748892; c=relaxed/simple;
	bh=A7jugkRVtYaJCqVnCgi+NM96TSclcnrEQHf/mvPMiX0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TwvpeDm0RKIX+8B/x+cqyQ7a7akm+DcdE0kr9UEBnFL3mLI/tOsXNDd2m/O6zZBaJPDGY2+lElwlIfN4165f/7aeEdmqR15zxUZgLVSkx6MQmqFlCmbpJpJ7bJnTYYxilOFQLf9CcLtfZ0KfIj1/Ko0fVPkAJndkemid/knh2f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vYjuM3/b; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-ba4c6ac8406so1851942a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 10:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763748888; x=1764353688; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rs+v+moIZWOjSmppyXWFm45kengypjO8+D7FGVdC6/c=;
        b=vYjuM3/bUi/hQmTOeEmFy+oTupMsgRNpQo+9R29MXTovIBWb6l1r237mB2MLIWs1Mj
         gjyxYvTRej92UMMNy+9v2/v6cmMqVEovgykHPgX6XwFjOlYnBzhCKPcFwW92YPdaGzwQ
         vROKLQ1pGRmvb64HgzityV2Yw2y1tv/57dIbAXWPPzZohimsx7uqPqgqX8agt592eJqI
         JQqbJrD9xjOVsJGHoi2matswZ2Yb4vm6eFNqh/zd7ULtuuciKbQJSeyYZDS09bv0TXxO
         GaOrdo3d5pdt+hHYvsJXYkrR1mcInakysBYlrhHtCDpjrd9/zgGSG3JTz0/7+yNlpbAe
         XWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763748888; x=1764353688;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rs+v+moIZWOjSmppyXWFm45kengypjO8+D7FGVdC6/c=;
        b=lW47R2vGvHvJk7vGao06QfgYBa5vIk4bhgHyx1UTrw5sLkDa5gg2a0Y++JQxBL6eIQ
         KrZFujy1j6EjS/F9SvKgxD2+Tl5tEwGaLfDpD3jAnlTxj5XZIxoMT/Wru9ZEhPcsJ47B
         jXAde220gsad3sJiLNzZbQ4eeyQdrhB68lDAsYYCm6tdHE1Wmxm1ZZPKbT4YIrURI+lf
         i0AA5AT3XnC03H0iKt02PL1E7Z5kuO9YvJKvKwO3ULrXai5N1dBut0V7EBNOSIWYr63P
         cKbe5f3dVZfblKQTlAiM69cFxtBR3D0i41Z42xKLbylMbUbVyf5d9rvOpC1zhZjyuj76
         9AIg==
X-Forwarded-Encrypted: i=1; AJvYcCV0UmQ1LkGOinD++683jfyln/AxqMBgJnOUGu9jHfljRdCvR/GlRDp3ZmDiQnOikQvvxgt8aYvubuYOD8NH0Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpWtXs8cW4Em8lPRjHS5dUykNCJqhZ7nT1dvZ/iWtvX08tqB0W
	HnukXo7MaicuzbzLQb+YIh4aNOpTFv7pMPi6hiY0HycIA/o6xqsfBNAC0xkTtKQn6baVV17pkno
	KN/s+qbz0RLYUgA==
X-Google-Smtp-Source: AGHT+IE1pATFQF9UdtyFovHguUHLVnsKsnw8gA1QF1TIOikrK50GI0dcsV8Jl8U07yBPnTsmphfuERXXE0EI9g==
X-Received: from plzw11.prod.google.com ([2002:a17:902:904b:b0:295:70a9:9091])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2f10:b0:297:f793:fc7e with SMTP id d9443c01a7336-29b6c3e4c3amr37058345ad.19.1763748888157;
 Fri, 21 Nov 2025 10:14:48 -0800 (PST)
Date: Fri, 21 Nov 2025 18:14:17 +0000
In-Reply-To: <20251121181429.1421717-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251121181429.1421717-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251121181429.1421717-7-dmatlack@google.com>
Subject: [PATCH v3 06/18] vfio: selftests: Support multiple devices in the
 same container/iommufd
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Alex Mastro <amastro@fb.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Raghavendra Rao Ananta <rananta@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Support tests that want to add multiple devices to the same
container/iommufd by decoupling struct vfio_pci_device from
struct iommu.

Multi-devices tests can now put multiple devices in the same
container/iommufd like so:

  iommu = iommu_init(iommu_mode);

  device1 = vfio_pci_device_init(bdf1, iommu);
  device2 = vfio_pci_device_init(bdf2, iommu);
  device3 = vfio_pci_device_init(bdf3, iommu);

  ...

  vfio_pci_device_cleanup(device3);
  vfio_pci_device_cleanup(device2);
  vfio_pci_device_cleanup(device1);

  iommu_cleanup(iommu);

To account for the new separation of vfio_pci_device and iommu, update
existing tests to initialize and cleanup a struct iommu.

Reviewed-by: Alex Mastro <amastro@fb.com>
Tested-by: Alex Mastro <amastro@fb.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../selftests/vfio/lib/include/vfio_util.h    |   6 +-
 .../selftests/vfio/lib/vfio_pci_device.c      | 102 +++++++++++-------
 .../selftests/vfio/vfio_dma_mapping_test.c    |  10 +-
 .../selftests/vfio/vfio_pci_device_test.c     |  10 +-
 .../selftests/vfio/vfio_pci_driver_test.c     |  26 ++++-
 5 files changed, 105 insertions(+), 49 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
index 3160f2d1ea6d..379942dc5357 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -216,8 +216,12 @@ const char *vfio_pci_get_cdev_path(const char *bdf);
 
 extern const char *default_iommu_mode;
 
-struct vfio_pci_device *vfio_pci_device_init(const char *bdf, const char *iommu_mode);
+struct iommu *iommu_init(const char *iommu_mode);
+void iommu_cleanup(struct iommu *iommu);
+
+struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iommu);
 void vfio_pci_device_cleanup(struct vfio_pci_device *device);
+
 void vfio_pci_device_reset(struct vfio_pci_device *device);
 
 struct iommu_iova_range *vfio_pci_iova_ranges(struct vfio_pci_device *device,
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index e47f3ccf6d49..57bdd22573d4 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -86,13 +86,13 @@ static struct vfio_iommu_type1_info *vfio_iommu_get_info(struct vfio_pci_device
 		.argsz = sizeof(*info),
 	};
 
-	ioctl_assert(device->container_fd, VFIO_IOMMU_GET_INFO, info);
+	ioctl_assert(device->iommu->container_fd, VFIO_IOMMU_GET_INFO, info);
 	VFIO_ASSERT_GE(info->argsz, sizeof(*info));
 
 	info = realloc(info, info->argsz);
 	VFIO_ASSERT_NOT_NULL(info);
 
-	ioctl_assert(device->container_fd, VFIO_IOMMU_GET_INFO, info);
+	ioctl_assert(device->iommu->container_fd, VFIO_IOMMU_GET_INFO, info);
 	VFIO_ASSERT_GE(info->argsz, sizeof(*info));
 
 	return info;
@@ -142,10 +142,10 @@ static struct iommu_iova_range *iommufd_iova_ranges(struct vfio_pci_device *devi
 
 	struct iommu_ioas_iova_ranges query = {
 		.size = sizeof(query),
-		.ioas_id = device->ioas_id,
+		.ioas_id = device->iommu->ioas_id,
 	};
 
-	ret = ioctl(device->iommufd, IOMMU_IOAS_IOVA_RANGES, &query);
+	ret = ioctl(device->iommu->iommufd, IOMMU_IOAS_IOVA_RANGES, &query);
 	VFIO_ASSERT_EQ(ret, -1);
 	VFIO_ASSERT_EQ(errno, EMSGSIZE);
 	VFIO_ASSERT_GT(query.num_iovas, 0);
@@ -155,7 +155,7 @@ static struct iommu_iova_range *iommufd_iova_ranges(struct vfio_pci_device *devi
 
 	query.allowed_iovas = (uintptr_t)ranges;
 
-	ioctl_assert(device->iommufd, IOMMU_IOAS_IOVA_RANGES, &query);
+	ioctl_assert(device->iommu->iommufd, IOMMU_IOAS_IOVA_RANGES, &query);
 	*nranges = query.num_iovas;
 
 	return ranges;
@@ -180,7 +180,7 @@ struct iommu_iova_range *vfio_pci_iova_ranges(struct vfio_pci_device *device,
 {
 	struct iommu_iova_range *ranges;
 
-	if (device->iommufd)
+	if (device->iommu->iommufd)
 		ranges = iommufd_iova_ranges(device, nranges);
 	else
 		ranges = vfio_iommu_iova_ranges(device, nranges);
@@ -633,23 +633,21 @@ static void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf
 
 static void vfio_pci_container_setup(struct vfio_pci_device *device, const char *bdf)
 {
-	unsigned long iommu_type = device->iommu->mode->iommu_type;
-	const char *path = device->iommu->mode->container_path;
-	int version;
+	struct iommu *iommu = device->iommu;
+	unsigned long iommu_type = iommu->mode->iommu_type;
 	int ret;
 
-	device->iommu->container_fd = open(path, O_RDWR);
-	VFIO_ASSERT_GE(device->iommu->container_fd, 0, "open(%s) failed\n", path);
-
-	version = ioctl(device->iommu->container_fd, VFIO_GET_API_VERSION);
-	VFIO_ASSERT_EQ(version, VFIO_API_VERSION, "Unsupported version: %d\n", version);
-
 	vfio_pci_group_setup(device, bdf);
 
-	ret = ioctl(device->iommu->container_fd, VFIO_CHECK_EXTENSION, iommu_type);
+	ret = ioctl(iommu->container_fd, VFIO_CHECK_EXTENSION, iommu_type);
 	VFIO_ASSERT_GT(ret, 0, "VFIO IOMMU type %lu not supported\n", iommu_type);
 
-	ioctl_assert(device->iommu->container_fd, VFIO_SET_IOMMU, (void *)iommu_type);
+	/*
+	 * Allow multiple threads to race to set the IOMMU type on the
+	 * container. The first will succeed and the rest should fail
+	 * because the IOMMU type is already set.
+	 */
+	(void)ioctl(iommu->container_fd, VFIO_SET_IOMMU, (void *)iommu_type);
 
 	device->fd = ioctl(device->group_fd, VFIO_GROUP_GET_DEVICE_FD, bdf);
 	VFIO_ASSERT_GE(device->fd, 0);
@@ -797,32 +795,53 @@ static void vfio_pci_iommufd_setup(struct vfio_pci_device *device, const char *b
 	VFIO_ASSERT_GE(device->fd, 0);
 	free((void *)cdev_path);
 
-	/*
-	 * Require device->iommufd to be >0 so that a simple non-0 check can be
-	 * used to check if iommufd is enabled. In practice open() will never
-	 * return 0 unless stdin is closed.
-	 */
-	device->iommu->iommufd = open("/dev/iommu", O_RDWR);
-	VFIO_ASSERT_GT(device->iommu->iommufd, 0);
-
 	vfio_device_bind_iommufd(device->fd, device->iommu->iommufd);
-	device->iommu->ioas_id = iommufd_ioas_alloc(device->iommu->iommufd);
 	vfio_device_attach_iommufd_pt(device->fd, device->iommu->ioas_id);
 }
 
-struct vfio_pci_device *vfio_pci_device_init(const char *bdf, const char *iommu_mode)
+struct iommu *iommu_init(const char *iommu_mode)
+{
+	const char *container_path;
+	struct iommu *iommu;
+	int version;
+
+	iommu = calloc(1, sizeof(*iommu));
+	VFIO_ASSERT_NOT_NULL(iommu);
+
+	INIT_LIST_HEAD(&iommu->dma_regions);
+
+	iommu->mode = lookup_iommu_mode(iommu_mode);
+
+	container_path = iommu->mode->container_path;
+	if (container_path) {
+		iommu->container_fd = open(container_path, O_RDWR);
+		VFIO_ASSERT_GE(iommu->container_fd, 0, "open(%s) failed\n", container_path);
+
+		version = ioctl(iommu->container_fd, VFIO_GET_API_VERSION);
+		VFIO_ASSERT_EQ(version, VFIO_API_VERSION, "Unsupported version: %d\n", version);
+	} else {
+		/*
+		 * Require device->iommufd to be >0 so that a simple non-0 check can be
+		 * used to check if iommufd is enabled. In practice open() will never
+		 * return 0 unless stdin is closed.
+		 */
+		iommu->iommufd = open("/dev/iommu", O_RDWR);
+		VFIO_ASSERT_GT(iommu->iommufd, 0);
+
+		iommu->ioas_id = iommufd_ioas_alloc(iommu->iommufd);
+	}
+
+	return iommu;
+}
+
+struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iommu)
 {
 	struct vfio_pci_device *device;
 
 	device = calloc(1, sizeof(*device));
 	VFIO_ASSERT_NOT_NULL(device);
 
-	device->iommu = calloc(1, sizeof(*device->iommu));
-	VFIO_ASSERT_NOT_NULL(device->iommu);
-
-	INIT_LIST_HEAD(&device->iommu->dma_regions);
-
-	device->iommu->mode = lookup_iommu_mode(iommu_mode);
+	device->iommu = iommu;
 
 	if (device->iommu->mode->container_path)
 		vfio_pci_container_setup(device, bdf);
@@ -853,17 +872,22 @@ void vfio_pci_device_cleanup(struct vfio_pci_device *device)
 		VFIO_ASSERT_EQ(close(device->msi_eventfds[i]), 0);
 	}
 
-	if (device->iommu->iommufd) {
-		VFIO_ASSERT_EQ(close(device->iommu->iommufd), 0);
-	} else {
+	if (device->group_fd)
 		VFIO_ASSERT_EQ(close(device->group_fd), 0);
-		VFIO_ASSERT_EQ(close(device->iommu->container_fd), 0);
-	}
 
-	free(device->iommu);
 	free(device);
 }
 
+void iommu_cleanup(struct iommu *iommu)
+{
+	if (iommu->iommufd)
+		VFIO_ASSERT_EQ(close(iommu->iommufd), 0);
+	else
+		VFIO_ASSERT_EQ(close(iommu->container_fd), 0);
+
+	free(iommu);
+}
+
 static bool is_bdf(const char *str)
 {
 	unsigned int s, b, d, f;
diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
index 102603d4407d..4727feb214c8 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -94,6 +94,7 @@ static int iommu_mapping_get(const char *bdf, u64 iova,
 }
 
 FIXTURE(vfio_dma_mapping_test) {
+	struct iommu *iommu;
 	struct vfio_pci_device *device;
 	struct iova_allocator *iova_allocator;
 };
@@ -119,7 +120,8 @@ FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(anonymous_hugetlb_1gb, SZ_1G, MAP_HUGETLB |
 
 FIXTURE_SETUP(vfio_dma_mapping_test)
 {
-	self->device = vfio_pci_device_init(device_bdf, variant->iommu_mode);
+	self->iommu = iommu_init(variant->iommu_mode);
+	self->device = vfio_pci_device_init(device_bdf, self->iommu);
 	self->iova_allocator = iova_allocator_init(self->device);
 }
 
@@ -127,6 +129,7 @@ FIXTURE_TEARDOWN(vfio_dma_mapping_test)
 {
 	iova_allocator_cleanup(self->iova_allocator);
 	vfio_pci_device_cleanup(self->device);
+	iommu_cleanup(self->iommu);
 }
 
 TEST_F(vfio_dma_mapping_test, dma_map_unmap)
@@ -203,6 +206,7 @@ TEST_F(vfio_dma_mapping_test, dma_map_unmap)
 }
 
 FIXTURE(vfio_dma_map_limit_test) {
+	struct iommu *iommu;
 	struct vfio_pci_device *device;
 	struct vfio_dma_region region;
 	size_t mmap_size;
@@ -235,7 +239,8 @@ FIXTURE_SETUP(vfio_dma_map_limit_test)
 	 */
 	self->mmap_size = 2 * region_size;
 
-	self->device = vfio_pci_device_init(device_bdf, variant->iommu_mode);
+	self->iommu = iommu_init(variant->iommu_mode);
+	self->device = vfio_pci_device_init(device_bdf, self->iommu);
 	region->vaddr = mmap(NULL, self->mmap_size, PROT_READ | PROT_WRITE,
 			     MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
 	ASSERT_NE(region->vaddr, MAP_FAILED);
@@ -253,6 +258,7 @@ FIXTURE_SETUP(vfio_dma_map_limit_test)
 FIXTURE_TEARDOWN(vfio_dma_map_limit_test)
 {
 	vfio_pci_device_cleanup(self->device);
+	iommu_cleanup(self->iommu);
 	ASSERT_EQ(munmap(self->region.vaddr, self->mmap_size), 0);
 }
 
diff --git a/tools/testing/selftests/vfio/vfio_pci_device_test.c b/tools/testing/selftests/vfio/vfio_pci_device_test.c
index 7a270698e4d2..e95217933c6b 100644
--- a/tools/testing/selftests/vfio/vfio_pci_device_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_device_test.c
@@ -23,17 +23,20 @@ static const char *device_bdf;
 #define MAX_TEST_MSI 16U
 
 FIXTURE(vfio_pci_device_test) {
+	struct iommu *iommu;
 	struct vfio_pci_device *device;
 };
 
 FIXTURE_SETUP(vfio_pci_device_test)
 {
-	self->device = vfio_pci_device_init(device_bdf, default_iommu_mode);
+	self->iommu = iommu_init(default_iommu_mode);
+	self->device = vfio_pci_device_init(device_bdf, self->iommu);
 }
 
 FIXTURE_TEARDOWN(vfio_pci_device_test)
 {
 	vfio_pci_device_cleanup(self->device);
+	iommu_cleanup(self->iommu);
 }
 
 #define read_pci_id_from_sysfs(_file) ({							\
@@ -99,6 +102,7 @@ TEST_F(vfio_pci_device_test, validate_bars)
 }
 
 FIXTURE(vfio_pci_irq_test) {
+	struct iommu *iommu;
 	struct vfio_pci_device *device;
 };
 
@@ -116,12 +120,14 @@ FIXTURE_VARIANT_ADD(vfio_pci_irq_test, msix) {
 
 FIXTURE_SETUP(vfio_pci_irq_test)
 {
-	self->device = vfio_pci_device_init(device_bdf, default_iommu_mode);
+	self->iommu = iommu_init(default_iommu_mode);
+	self->device = vfio_pci_device_init(device_bdf, self->iommu);
 }
 
 FIXTURE_TEARDOWN(vfio_pci_irq_test)
 {
 	vfio_pci_device_cleanup(self->device);
+	iommu_cleanup(self->iommu);
 }
 
 TEST_F(vfio_pci_irq_test, enable_trigger_disable)
diff --git a/tools/testing/selftests/vfio/vfio_pci_driver_test.c b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
index f69eec8b928d..b0c7d812de1f 100644
--- a/tools/testing/selftests/vfio/vfio_pci_driver_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
@@ -44,6 +44,7 @@ static void region_teardown(struct vfio_pci_device *device,
 }
 
 FIXTURE(vfio_pci_driver_test) {
+	struct iommu *iommu;
 	struct vfio_pci_device *device;
 	struct iova_allocator *iova_allocator;
 	struct vfio_dma_region memcpy_region;
@@ -73,7 +74,8 @@ FIXTURE_SETUP(vfio_pci_driver_test)
 {
 	struct vfio_pci_driver *driver;
 
-	self->device = vfio_pci_device_init(device_bdf, variant->iommu_mode);
+	self->iommu = iommu_init(variant->iommu_mode);
+	self->device = vfio_pci_device_init(device_bdf, self->iommu);
 	self->iova_allocator = iova_allocator_init(self->device);
 
 	driver = &self->device->driver;
@@ -113,6 +115,7 @@ FIXTURE_TEARDOWN(vfio_pci_driver_test)
 
 	iova_allocator_cleanup(self->iova_allocator);
 	vfio_pci_device_cleanup(self->device);
+	iommu_cleanup(self->iommu);
 }
 
 TEST_F(vfio_pci_driver_test, init_remove)
@@ -231,18 +234,31 @@ TEST_F_TIMEOUT(vfio_pci_driver_test, memcpy_storm, 60)
 	ASSERT_NO_MSI(self->msi_fd);
 }
 
-int main(int argc, char *argv[])
+static bool device_has_selftests_driver(const char *bdf)
 {
 	struct vfio_pci_device *device;
+	struct iommu *iommu;
+	bool has_driver;
+
+	iommu = iommu_init(default_iommu_mode);
+	device = vfio_pci_device_init(device_bdf, iommu);
+
+	has_driver = !!device->driver.ops;
+
+	vfio_pci_device_cleanup(device);
+	iommu_cleanup(iommu);
 
+	return has_driver;
+}
+
+int main(int argc, char *argv[])
+{
 	device_bdf = vfio_selftests_get_bdf(&argc, argv);
 
-	device = vfio_pci_device_init(device_bdf, default_iommu_mode);
-	if (!device->driver.ops) {
+	if (!device_has_selftests_driver(device_bdf)) {
 		fprintf(stderr, "No driver found for device %s\n", device_bdf);
 		return KSFT_SKIP;
 	}
-	vfio_pci_device_cleanup(device);
 
 	return test_harness_run(argc, argv);
 }
-- 
2.52.0.rc2.455.g230fcf2819-goog


