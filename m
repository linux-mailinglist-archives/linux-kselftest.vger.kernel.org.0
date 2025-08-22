Return-Path: <linux-kselftest+bounces-39759-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C52B32491
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 23:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44A1C1CE3FCA
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 21:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCEE2BE03E;
	Fri, 22 Aug 2025 21:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iXKH4OtP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5934A352075
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 21:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755898013; cv=none; b=azSMsdY65Y7jkqlkda548cm02F0Vui2GoZJbK5NXVvC/OLDd4Z1+ZZuRRCTqAGhNLf88ee0W72yxm9qEeBbst5VoJZI/2AVs085r7D9YfLXU+T3ESf3cbfbWE7Fimv8T+Vnmj68NLjzS41vbb0h+KHzIkVbJMXWVHTkJu3Z0U60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755898013; c=relaxed/simple;
	bh=ORXTErqqB4DmbI89xyv34RudsW5tUZ5TTzmyHAF30TI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K2JxXpyVU0ZFe89cvQZqpqmfQooOlgfT14mRVssDodHfvu3DG4CjcZJmcA8t0bXGZWF4uTeo5P26VffCh6JltF9O2I5Wqt+lwPIAUge89B5byvzo1igWyX13A/V3HdYXaO5QjeMP97E4ArXIHOTGRe8lBJnyhvibaEiN4t8eefE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iXKH4OtP; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24458345f5dso29359225ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 14:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755898011; x=1756502811; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5/y+08Y91el8usC6Oa7Aec1WtbMW/glvMEpAK3RGK4A=;
        b=iXKH4OtPEMCP4rZIr5f2jPLd6ApVplmLIGl3TZ7yGhC+tgpCA8ehIiYQzRiLacND8t
         bkZMN8a6swe8644J7/2K+A2RJEnmgQp2o6ojwgfYxRYzFdvzQ1cRKkTyD9C/mS4rQBo3
         l3dhHo80Dptihfp1KiDs9pxsqVq5Oj7G2Y2sCVE9ROpRa9xYcm+m4m58kI/ZWuB22YJp
         S+CQtP0C/nYUlGv/1X0ciqLiuV6tMJn0YexLH5ivJ6FFAy1BanSZFcrnIljpokMVFApG
         4WR7qMd7NXWj3/dZaLi8ill33r1kOsn1pbRPN1sFzwWITwsqrm2R6VMrVvcRttFR8bTp
         sqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755898011; x=1756502811;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5/y+08Y91el8usC6Oa7Aec1WtbMW/glvMEpAK3RGK4A=;
        b=vEyEXFmZZ3ON3jZoVq3Qj06uHN6DBDmPgi1g81qDyVe7oVgXqP5092MqNoCG5eNNss
         Axd8O1UW6vwV8FSWVbAaGvaIoLz54LFJuJby7A1AQpTG6SKpVYHSHZrTTMCtI/gifXYN
         kcUeN1EiBO3Zzan3Kw/8wyNnwQOD77QXiiQ7+2DImRCxFsxcpw8wE0eyAl18cQhdxzsN
         FcjPGGDu8CaCzL8T5idbEJVKlat2FDKBSnq59z+qLYJsqAbs6K2aC+JbENHHknTYhMoT
         B+4Vn+IyVhht+fcuiglAvWpljPwkJ1DmQtZBuQv4u8lGuSP13U198JtMJA2LzTO2iJqg
         3Ykw==
X-Forwarded-Encrypted: i=1; AJvYcCU/dAjDp9eNfPjf8wmvoEhcZp7BLYCbZKrWOAYNmwbHVBDGznDr9pIsTGKyxkO76MIiHQKNo9FFCF0cG7Z355U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy45ulAgFwQIeOwIBFkpe4XorE4wcJnm3Ff/ZCB2ACArW8EyAI6
	PiOcW/6E2nSvBs/0Eccq2EEQOYdoOREOtF5yecFmXavKfFrBnhGxe3k00ZkTXs9GDl85XCtBX4k
	8oZ+qdw5RIYdF7g==
X-Google-Smtp-Source: AGHT+IGw862lt6N/isYUMpyYXJ9U0KlvNH39wY+L4S5hLvepkObR7ToC9JxOErjrqS8dIue05w0alBAWoPoIsg==
X-Received: from pjh3.prod.google.com ([2002:a17:90b:3f83:b0:314:d44:4108])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:943:b0:240:2efe:c384 with SMTP id d9443c01a7336-2462ee8b6e4mr65377685ad.19.1755898010823;
 Fri, 22 Aug 2025 14:26:50 -0700 (PDT)
Date: Fri, 22 Aug 2025 21:25:15 +0000
In-Reply-To: <20250822212518.4156428-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822212518.4156428-1-dmatlack@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822212518.4156428-29-dmatlack@google.com>
Subject: [PATCH v2 28/30] vfio: selftests: Add iommufd mode
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Aaron Lewis <aaronlewis@google.com>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Dan Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	David Matlack <dmatlack@google.com>, dmaengine@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Joel Granados <joel.granados@kernel.org>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	"Yury Norov [NVIDIA]" <yury.norov@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

Add a new IOMMU mode for using iommufd directly. In this mode userspace
opens /dev/iommu and binds it to a device FD acquired through
/dev/vfio/devices/vfioX.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>
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
2.51.0.rc2.233.g662b1ed5c5-goog


