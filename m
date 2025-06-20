Return-Path: <linux-kselftest+bounces-35522-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3961AAE2661
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 01:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFEE9189D605
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 23:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38954256C88;
	Fri, 20 Jun 2025 23:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iRODPgqI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE3B256C6C
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 23:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750461708; cv=none; b=DZOQ7gQVKiI3MJpJx34JAZPdQcaDBQ1T5WTzuJAkZWGVYmCaKOppDmy2pqeAK7d1O0fzAaQnLckApiquasYoxs9g14iqvLYe/XDY8lhuQ0J71k0B1tuKHKnw4DGv/SCJmH+9e7K5s8XkogM56gYXEBeCNSM6AZcFGp58x+ePeTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750461708; c=relaxed/simple;
	bh=l852Op3lsfvPYg5r5ww2dWkfxSljtNDEJ/f5yO3dvZo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=olAL3Iletl1vwr1XKGmtCtPkvmp8ueJG3sZIg0mTV4SJm+ubePgo1LEtxkx0QxMkPzdQv29QRS6FBeU9/7rdczmmSxVPIKDXiRdDwmM+NMCFO65Q0GXhBkrlFleC9kD+8OWprT/itWG1B2m2tLGmFymSoy/nICxqNNsTppgW8yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iRODPgqI; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-315af0857f2so25629a91.0
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 16:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750461705; x=1751066505; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a8vyvlyj7mOkO0z7B8eC5Av73Y6eOeEySlCgWtiL2/0=;
        b=iRODPgqIwuCg5Y8f0GlEd4wtAlTCg8CXxR0rkMg8JWudWQrXnpiyDRlnquSUK4rXrx
         HJOBZ6lyvPqxequcR/2InQp6lauHWV3l890Wrdoh9Q4UAoh96xrxvfbgsrYjyIctckJ3
         7TR5vRqKG3wRm0LsjLvx/6rSLnwiy+szhWOXJ+IP865H0IaQeMU3GAGsu0UaO0ntqk0F
         GbEeAQki67J7ho5d3RTPGD+DGDB8xrgPTXbZoXOwNyxlvHx9STs328+sEmLSrZuqbDtp
         tPVSctJTht/qEpTMBDoiUDQC3Ra5JUDbiCMVavMaE2673FbJhf00Zrjhk7NdqBz8ArcX
         xjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750461705; x=1751066505;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a8vyvlyj7mOkO0z7B8eC5Av73Y6eOeEySlCgWtiL2/0=;
        b=icoDbjXJQG+mPPwqZBfujaxWjNNXLy00ODU8N/3umgMLxTBs3GmMnQgBrVKG8z2H37
         i6Vy11pocMfSDC699JXMwbwKaBYji8F9aj+5S8BxzfzM+FxWiNwRNG+rLdh5WVTp88TQ
         AiIfP/5bVKppajhzR4KAvF57DgHtmQ9iy0KssYAEg7RvA8EzTctB5lHTF1f1VxKp1iZ4
         lnL5Zrp3LAosg8kf5zo80P+RRrgG3Q4/m1S2rMqdyqPX+HtioFhwyXCw88ZZAO+9onjk
         3QCpadx+GC9aO7DpSKgp4W2mYiWeo5IvRq0A9JNHBH6uprzJsf7YWydGVOCzppkyiJSe
         ZAeA==
X-Forwarded-Encrypted: i=1; AJvYcCVwtL5dBUQUidJIVf5wLtgGHKlqtlILE9xRN1CVFLz9DPzheX0BJeg8HhkfcRlEx9TV0eRHxm1y6P0amRkqohY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaQPhuY4dn03jZX9mfA66VfAXrUtJTG4c4LAGKxsjXBa6YHY1+
	JK+kQJJV/JlP/y8MZWGcmSxYYh9r3RdkTYdrjS0zhjwUyUkbLZyk2CN+qiXMNzZN7NOIT+SpRIC
	QLBhAQwnbhx/YQQ==
X-Google-Smtp-Source: AGHT+IGQdNX/OA8mGI5hTbFoSI7FoTQrRqiTTWNSRpEkRZw4Gw2wQHI8lhQ9EhxH7MjBfIwzsdzNoHO9YNBYiQ==
X-Received: from pjvv5.prod.google.com ([2002:a17:90b:5885:b0:312:187d:382d])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4c11:b0:312:26d9:d5b4 with SMTP id 98e67ed59e1d1-3159d8c7e55mr8426384a91.17.1750461704831;
 Fri, 20 Jun 2025 16:21:44 -0700 (PDT)
Date: Fri, 20 Jun 2025 23:20:26 +0000
In-Reply-To: <20250620232031.2705638-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620232031.2705638-1-dmatlack@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620232031.2705638-29-dmatlack@google.com>
Subject: [PATCH 28/33] vfio: selftests: Add iommufd mode
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Aaron Lewis <aaronlewis@google.com>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Bibo Mao <maobibo@loongson.cn>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, David Matlack <dmatlack@google.com>, dmaengine@vger.kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, James Houghton <jthoughton@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joel Granados <joel.granados@kernel.org>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Pratik R. Sampat" <prsampat@amd.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	Wei Yang <richard.weiyang@gmail.com>, "Yury Norov [NVIDIA]" <yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Add a new IOMMU mode for using iommufd directly. In this mode userspace
opens /dev/iommu and binds it to a device FD acquired through
/dev/vfio/devices/vfioX.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../selftests/vfio/lib/include/vfio_util.h    |   6 +-
 .../selftests/vfio/lib/vfio_pci_device.c      | 175 ++++++++++++++----
 2 files changed, 146 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
index 035ef5b9d678..ed31606e01b7 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -62,7 +62,8 @@ struct vfio_iommu_mode {
 FIXTURE_VARIANT_ADD_IOMMU_MODE(vfio_type1_iommu, ##__VA_ARGS__); \
 FIXTURE_VARIANT_ADD_IOMMU_MODE(vfio_type1v2_iommu, ##__VA_ARGS__); \
 FIXTURE_VARIANT_ADD_IOMMU_MODE(iommufd_compat_type1, ##__VA_ARGS__); \
-FIXTURE_VARIANT_ADD_IOMMU_MODE(iommufd_compat_type1v2, ##__VA_ARGS__)
+FIXTURE_VARIANT_ADD_IOMMU_MODE(iommufd_compat_type1v2, ##__VA_ARGS__); \
+FIXTURE_VARIANT_ADD_IOMMU_MODE(iommufd, ##__VA_ARGS__)
 
 struct vfio_pci_bar {
 	struct vfio_region_info info;
@@ -166,6 +167,9 @@ struct vfio_pci_device {
 	int group_fd;
 	int container_fd;
 
+	int iommufd;
+	u32 ioas_id;
+
 	struct vfio_device_info info;
 	struct vfio_region_info config_space;
 	struct vfio_pci_bar bars[PCI_STD_NUM_BARS];
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index b6fefe2b3ec8..5d8944a37982 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -10,10 +10,12 @@
 #include <sys/ioctl.h>
 #include <sys/mman.h>
 
+#include <uapi/linux/types.h>
 #include <linux/limits.h>
 #include <linux/mman.h>
 #include <linux/types.h>
 #include <linux/vfio.h>
+#include <linux/iommufd.h>
 
 #include "../../../kselftest.h"
 #include <vfio_util.h>
@@ -139,32 +141,80 @@ static void vfio_pci_irq_get(struct vfio_pci_device *device, u32 index,
 	ioctl_assert(device->fd, VFIO_DEVICE_GET_IRQ_INFO, irq_info);
 }
 
-void vfio_pci_dma_map(struct vfio_pci_device *device,
-		      struct vfio_dma_region *region)
+static void vfio_iommu_dma_map(struct vfio_pci_device *device,
+			       struct vfio_dma_region *region)
 {
-	struct vfio_iommu_type1_dma_map map = {
-		.argsz = sizeof(map),
+	struct vfio_iommu_type1_dma_map args = {
+		.argsz = sizeof(args),
 		.flags = VFIO_DMA_MAP_FLAG_READ | VFIO_DMA_MAP_FLAG_WRITE,
 		.vaddr = (u64)region->vaddr,
 		.iova = region->iova,
 		.size = region->size,
 	};
 
-	ioctl_assert(device->container_fd, VFIO_IOMMU_MAP_DMA, &map);
+	ioctl_assert(device->container_fd, VFIO_IOMMU_MAP_DMA, &args);
+}
+
+static void iommufd_dma_map(struct vfio_pci_device *device,
+			    struct vfio_dma_region *region)
+{
+	struct iommu_ioas_map args = {
+		.size = sizeof(args),
+		.flags = IOMMU_IOAS_MAP_READABLE |
+			 IOMMU_IOAS_MAP_WRITEABLE |
+			 IOMMU_IOAS_MAP_FIXED_IOVA,
+		.user_va = (u64)region->vaddr,
+		.iova = region->iova,
+		.length = region->size,
+		.ioas_id = device->ioas_id,
+	};
+
+	ioctl_assert(device->iommufd, IOMMU_IOAS_MAP, &args);
+}
+
+void vfio_pci_dma_map(struct vfio_pci_device *device,
+		      struct vfio_dma_region *region)
+{
+	if (device->iommufd)
+		iommufd_dma_map(device, region);
+	else
+		vfio_iommu_dma_map(device, region);
 
 	list_add(&region->link, &device->dma_regions);
 }
 
-void vfio_pci_dma_unmap(struct vfio_pci_device *device,
-			struct vfio_dma_region *region)
+static void vfio_iommu_dma_unmap(struct vfio_pci_device *device,
+				 struct vfio_dma_region *region)
 {
-	struct vfio_iommu_type1_dma_unmap unmap = {
-		.argsz = sizeof(unmap),
+	struct vfio_iommu_type1_dma_unmap args = {
+		.argsz = sizeof(args),
 		.iova = region->iova,
 		.size = region->size,
 	};
 
-	ioctl_assert(device->container_fd, VFIO_IOMMU_UNMAP_DMA, &unmap);
+	ioctl_assert(device->container_fd, VFIO_IOMMU_UNMAP_DMA, &args);
+}
+
+static void iommufd_dma_unmap(struct vfio_pci_device *device,
+			      struct vfio_dma_region *region)
+{
+	struct iommu_ioas_unmap args = {
+		.size = sizeof(args),
+		.iova = region->iova,
+		.length = region->size,
+		.ioas_id = device->ioas_id,
+	};
+
+	ioctl_assert(device->iommufd, IOMMU_IOAS_UNMAP, &args);
+}
+
+void vfio_pci_dma_unmap(struct vfio_pci_device *device,
+			struct vfio_dma_region *region)
+{
+	if (device->iommufd)
+		iommufd_dma_unmap(device, region);
+	else
+		vfio_iommu_dma_unmap(device, region);
 
 	list_del(&region->link);
 }
@@ -258,18 +308,6 @@ static unsigned int vfio_pci_get_group_from_dev(const char *bdf)
 	return group;
 }
 
-static void vfio_pci_container_setup(struct vfio_pci_device *device)
-{
-	const char *path = device->iommu_mode->container_path;
-	int version;
-
-	device->container_fd = open(path, O_RDWR);
-	VFIO_ASSERT_GE(device->container_fd, 0, "open(%s) failed\n", path);
-
-	version = ioctl(device->container_fd, VFIO_GET_API_VERSION);
-	VFIO_ASSERT_EQ(version, VFIO_API_VERSION);
-}
-
 static void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf)
 {
 	struct vfio_group_status group_status = {
@@ -290,26 +328,34 @@ static void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf
 	ioctl_assert(device->group_fd, VFIO_GROUP_SET_CONTAINER, &device->container_fd);
 }
 
-static void vfio_pci_iommu_setup(struct vfio_pci_device *device)
+static void vfio_pci_container_setup(struct vfio_pci_device *device, const char *bdf)
 {
 	unsigned long iommu_type = device->iommu_mode->iommu_type;
+	const char *path = device->iommu_mode->container_path;
+	int version;
 	int ret;
 
-	INIT_LIST_HEAD(&device->dma_regions);
+	device->container_fd = open(path, O_RDWR);
+	VFIO_ASSERT_GE(device->container_fd, 0, "open(%s) failed\n", path);
+
+	version = ioctl(device->container_fd, VFIO_GET_API_VERSION);
+	VFIO_ASSERT_EQ(version, VFIO_API_VERSION, "Unsupported version: %d\n", version);
+
+	vfio_pci_group_setup(device, bdf);
 
 	ret = ioctl(device->container_fd, VFIO_CHECK_EXTENSION, iommu_type);
 	VFIO_ASSERT_GT(ret, 0, "VFIO IOMMU type %lu not supported\n", iommu_type);
 
 	ioctl_assert(device->container_fd, VFIO_SET_IOMMU, (void *)iommu_type);
+
+	device->fd = ioctl(device->group_fd, VFIO_GROUP_GET_DEVICE_FD, bdf);
+	VFIO_ASSERT_GE(device->fd, 0);
 }
 
-static void vfio_pci_device_setup(struct vfio_pci_device *device, const char *bdf)
+static void vfio_pci_device_setup(struct vfio_pci_device *device)
 {
 	int i;
 
-	device->fd = ioctl(device->group_fd, VFIO_GROUP_GET_DEVICE_FD, bdf);
-	VFIO_ASSERT_GE(device->fd, 0);
-
 	device->info.argsz = sizeof(device->info);
 	ioctl_assert(device->fd, VFIO_DEVICE_GET_INFO, &device->info);
 
@@ -386,6 +432,9 @@ static const struct vfio_iommu_mode iommu_modes[] = {
 		.container_path = "/dev/iommu",
 		.iommu_type = VFIO_TYPE1v2_IOMMU,
 	},
+	{
+		.name = "iommufd",
+	},
 };
 
 const char *default_iommu_mode = "vfio_type1_iommu";
@@ -407,6 +456,57 @@ static const struct vfio_iommu_mode *lookup_iommu_mode(const char *iommu_mode)
 	VFIO_FAIL("Unrecognized IOMMU mode: %s\n", iommu_mode);
 }
 
+static void vfio_device_bind_iommufd(int device_fd, int iommufd)
+{
+	struct vfio_device_bind_iommufd args = {
+		.argsz = sizeof(args),
+		.iommufd = iommufd,
+	};
+
+	ioctl_assert(device_fd, VFIO_DEVICE_BIND_IOMMUFD, &args);
+}
+
+static u32 iommufd_ioas_alloc(int iommufd)
+{
+	struct iommu_ioas_alloc args = {
+		.size = sizeof(args),
+	};
+
+	ioctl_assert(iommufd, IOMMU_IOAS_ALLOC, &args);
+	return args.out_ioas_id;
+}
+
+static void vfio_device_attach_iommufd_pt(int device_fd, u32 pt_id)
+{
+	struct vfio_device_attach_iommufd_pt args = {
+		.argsz = sizeof(args),
+		.pt_id = pt_id,
+	};
+
+	ioctl_assert(device_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &args);
+}
+
+static void vfio_pci_iommufd_setup(struct vfio_pci_device *device, const char *bdf)
+{
+	const char *cdev_path = vfio_pci_get_cdev_path(bdf);
+
+	device->fd = open(cdev_path, O_RDWR);
+	VFIO_ASSERT_GE(device->fd, 0);
+	free((void *)cdev_path);
+
+	/*
+	 * Require device->iommufd to be >0 so that a simple non-0 check can be
+	 * used to check if iommufd is enabled. In practice open() will never
+	 * return 0 unless stdin is closed.
+	 */
+	device->iommufd = open("/dev/iommu", O_RDWR);
+	VFIO_ASSERT_GT(device->iommufd, 0);
+
+	vfio_device_bind_iommufd(device->fd, device->iommufd);
+	device->ioas_id = iommufd_ioas_alloc(device->iommufd);
+	vfio_device_attach_iommufd_pt(device->fd, device->ioas_id);
+}
+
 struct vfio_pci_device *vfio_pci_device_init(const char *bdf, const char *iommu_mode)
 {
 	struct vfio_pci_device *device;
@@ -414,13 +514,16 @@ struct vfio_pci_device *vfio_pci_device_init(const char *bdf, const char *iommu_
 	device = calloc(1, sizeof(*device));
 	VFIO_ASSERT_NOT_NULL(device);
 
+	INIT_LIST_HEAD(&device->dma_regions);
+
 	device->iommu_mode = lookup_iommu_mode(iommu_mode);
 
-	vfio_pci_container_setup(device);
-	vfio_pci_group_setup(device, bdf);
-	vfio_pci_iommu_setup(device);
-	vfio_pci_device_setup(device, bdf);
+	if (device->iommu_mode->container_path)
+		vfio_pci_container_setup(device, bdf);
+	else
+		vfio_pci_iommufd_setup(device, bdf);
 
+	vfio_pci_device_setup(device);
 	vfio_pci_driver_probe(device);
 
 	return device;
@@ -444,8 +547,12 @@ void vfio_pci_device_cleanup(struct vfio_pci_device *device)
 		VFIO_ASSERT_EQ(close(device->msi_eventfds[i]), 0);
 	}
 
-	VFIO_ASSERT_EQ(close(device->group_fd), 0);
-	VFIO_ASSERT_EQ(close(device->container_fd), 0);
+	if (device->iommufd) {
+		VFIO_ASSERT_EQ(close(device->iommufd), 0);
+	} else {
+		VFIO_ASSERT_EQ(close(device->group_fd), 0);
+		VFIO_ASSERT_EQ(close(device->container_fd), 0);
+	}
 
 	free(device);
 }
-- 
2.50.0.rc2.701.gf1e915cc24-goog


