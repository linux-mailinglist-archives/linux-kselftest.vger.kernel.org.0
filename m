Return-Path: <linux-kselftest+bounces-33724-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1771AC2C65
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 01:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E4B6A45C24
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 23:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23CD229B02;
	Fri, 23 May 2025 23:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="smPcrui3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289C1227E82
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 23:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748043071; cv=none; b=ckhkc1iJFSheBVXAyK3gohmhKhTRAD3ptkiZmfizlw5MjjRL1LfFfiGhV8sg28sc00cfoZb1U3bFzfyY/Y9Lry6IMNeS5objbU5IVcQQCknz2tXKcAcRxiXXnRVuUJ9pYc3gBTHAnr84zEu59Ruelxqde+ZAVM3t4V6RHz+M8O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748043071; c=relaxed/simple;
	bh=IOKCE7+RO7ovUk032p44qnwKIVd539sd003FuXa98kk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=leNRjSiGwEUCD8A9Qr/Zuz6MnTNbtBF7zI8xiu++PR2q06lLyTYZg4T3kiT/ycVXR9p6+CT0/X95EdJen1iW7JwWLFKnxtpAqffIk4Z1Av5rTng+Yc8EJUpIMNjhaNKv7m057wECrzT91LMisoPcirsPw+zY2bj5ZAXWw3mTQCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=smPcrui3; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2321207ff20so5745755ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 16:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748043069; x=1748647869; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RaXU8ZJAL8bdK0WGFKgmxKWOZwNS65ViEfA+N7rAGBo=;
        b=smPcrui3rdWfTghUDoNIrBSV1mLGj1B2Ehf3umzroadgQlIdKVjSQOGQrKu+qrW1Se
         zTYoQFctmuHFG8v9KUCFoRgXpZEAtubL9LpsKI3gGJwzbixaLFmvYaq2Texe1m0MKbzH
         +Hhc6/iBpIm3mQLKmn6rbg2BVqWYo7TlGObisY9ZQiRZYu5L0Gz4rtaSDE96GfZOkqYZ
         9wBaXnC9VNsWqf1apl+Hr27I7ucBUkfpCQaVWVbAzE1+K+SX3sDxxWlY1dF1sZx6+0Dw
         wfgefoWbceYefswwZTiEBkhLmHGYCfVjXPgKQiSWzpOhk4MLAawkxUQRUM9j2Ass4uPk
         z/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748043069; x=1748647869;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RaXU8ZJAL8bdK0WGFKgmxKWOZwNS65ViEfA+N7rAGBo=;
        b=cl/AvIdZKn8q5TD8wrnVAgJDT0B0PBn0ETRis36yTLMWOwPC5GlaW7nn0xGs9FTbAP
         VazvraROrHpUf3Dkg12LXUS0oXt0nSUxaCiOnR8aT6UgPQwOe/i4RXXac1AYGeovlsCv
         KVj/6jshjOQzOtyWhUVn08AWYSBmoDNTY+zJBAH+9XSTB7DwMmcz8uCU96whcBEUF2q0
         EWmF47QRvuneZm62HfnXxJIuHJ35qOukeYgydZOeI3bMoCAefhm+lytnndW1bOYhcMlM
         CR2P7bRaFofYmY4mtaUsO/kAuDD+x0H2PN/0McjRkST98/his5h9kdobL73v7VufCIfO
         OTBg==
X-Forwarded-Encrypted: i=1; AJvYcCWDtW8jrHYc2zDa9nbHKoLlaj9BhPVAPLb+tkK4lTWPzwvu+gTmUA+tXmIYWrVMiHG2wIxQZ8hbglMhWrmBTYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfEwbnWN1G+o7vjtHg/kwlAcLHR3b/Bsr87rMKJdM2ntorOeBb
	egozld4/pkAPPxzpnSBOFxDWDEC18R5EmGEyXjaR6csMFG9wk40BOSjECVXjPv/3IFFLpZmYK/G
	gJanKStCZ9O45fg==
X-Google-Smtp-Source: AGHT+IGZ+2all/TatWMC7rY+tjH05Wkynp/YPvkNNW34D0zlHAoFMLJUD1e3dUvKOIiO8ReVKfdg10WwIP9EAA==
X-Received: from pjl13.prod.google.com ([2002:a17:90b:2f8d:b0:2ff:5344:b54])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3e8c:b0:30e:9349:2d93 with SMTP id 98e67ed59e1d1-31111d41d4fmr1320987a91.28.1748043069423;
 Fri, 23 May 2025 16:31:09 -0700 (PDT)
Date: Fri, 23 May 2025 23:30:13 +0000
In-Reply-To: <20250523233018.1702151-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523233018.1702151-1-dmatlack@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523233018.1702151-29-dmatlack@google.com>
Subject: [RFC PATCH 28/33] vfio: selftests: Add iommufd mode
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	David Matlack <dmatlack@google.com>, Vinod Koul <vkoul@kernel.org>, 
	Fenghua Yu <fenghua.yu@intel.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Takashi Iwai <tiwai@suse.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, WangYuli <wangyuli@uniontech.com>, 
	Sean Christopherson <seanjc@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>, 
	Josh Hilke <jrhilke@google.com>, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"

Add a new IOMMU mode for using iommufd directly. In this mode userspace
opens /dev/iommu and binds it to a device FD acquired through
/dev/vfio/devices/vfioX.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../selftests/vfio/lib/include/vfio_util.h    |   3 +
 .../selftests/vfio/lib/vfio_pci_device.c      | 175 ++++++++++++++----
 2 files changed, 144 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
index 9989528c21b9..b03b3d8f5a52 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -155,6 +155,9 @@ struct vfio_pci_device {
 	int group_fd;
 	int container_fd;
 
+	int iommufd;
+	u32 ioas_id;
+
 	struct vfio_device_info info;
 	struct vfio_region_info config_space;
 	struct vfio_pci_bar bars[PCI_STD_NUM_BARS];
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 205bbfb3d54e..d996e012a646 100644
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
@@ -140,32 +142,80 @@ static void vfio_pci_irq_get(struct vfio_pci_device *device, u32 index,
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
@@ -254,18 +304,6 @@ static unsigned int vfio_pci_get_group_from_dev(const char *bdf)
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
@@ -286,26 +324,34 @@ static void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf
 	ioctl_assert(device->group_fd, VFIO_GROUP_SET_CONTAINER, &device->container_fd);
 }
 
-static void vfio_pci_iommu_setup(struct vfio_pci_device *device)
+static void vfio_pci_container_setup(struct vfio_pci_device *device, const char *bdf)
 {
 	unsigned long iommu_type = device->iommu_mode->group_iommu_type;
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
 
@@ -381,6 +427,9 @@ static const struct vfio_iommu_mode iommu_modes[] = {
 		.container_path = "/dev/iommu",
 		.group_iommu_type = VFIO_TYPE1v2_IOMMU,
 	},
+	{
+		.name = "iommufd",
+	},
 };
 
 const char *default_iommu_mode = "vfio_type1_iommu";
@@ -417,6 +466,57 @@ static const struct vfio_iommu_mode *lookup_iommu_mode(const char *iommu_mode)
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
@@ -424,13 +524,16 @@ struct vfio_pci_device *vfio_pci_device_init(const char *bdf, const char *iommu_
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
@@ -454,8 +557,12 @@ void vfio_pci_device_cleanup(struct vfio_pci_device *device)
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
2.49.0.1151.ga128411c76-goog


