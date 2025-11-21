Return-Path: <linux-kselftest+bounces-46274-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A6FC7B439
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 19:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7188435D783
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 18:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4C734FF70;
	Fri, 21 Nov 2025 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rrdxpCZ+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272DA3559C9
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 18:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748906; cv=none; b=nW1XTNQLM9YoZ6XtpiryEMyQ6u8cSAjWzUBps0BYywd8d53zZ1Ml7+zXYoZXiEvyfPCrsIQaCuizbATEAtsGhb3Kt0cQYnZ/cs1EP9M2abK25pRmo14i0tTOdlrZ9qQMygp7FqQhHt3VkbrsYAxyeRKB5Akkm9drbtzHcCWvYaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748906; c=relaxed/simple;
	bh=5QWyLHu1phcWI4dhLr8Jv3LrRW7M7BN0y3EZCfr1eDA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SDFO2LWOYCXyKLQFaxqqTUadbB4hvE3rx68r8iA9P3BjZqCh65GgDuwy7i8FV3NMp6rZnpOSzq3L80GhazA0kJVJcAxGYbA8PWMhvmK2eYhZCwNdjb4dW1BpLQGU9tr9hx+xf38YfH+aYLmbG26z9bY+88eWeTKIHtb2oYUjL3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rrdxpCZ+; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7b8b79cbd76so2089738b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 10:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763748896; x=1764353696; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SQv/Eq/kl4rfozPWP7rrCSir/JiYGfabG/viWVLGbWc=;
        b=rrdxpCZ+Noo0uikJ+a5JR8grp3cZv0u4yoCVq81GYswrhBKBuzNWsimnFD4515RJ3Q
         yUJ31TonjWqZZlqJFsjbC4jhaOGUdUfq7Cp9bFYn/VmqgzuJFS+kkweXMReOQNls8FDG
         6vT0I/aMzdIounpHcZWZ96eGjkpLwPtkMz8U8tHwQTqgLHZg40oTFZfkG4OqtAzZDCQ1
         iG75t9tdZIwWcfYhzM7BmtviZiZoqEavqTIIA2XpxOe/JjyzYkbwa3n3iIgeHPMjFa87
         AZfSs4PjYTa9fdpOoiKoIwKflgJKSnJUnHdOABFYZNdhvaD3+enLkKO1SaZ2sufSWRFv
         JiqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763748896; x=1764353696;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SQv/Eq/kl4rfozPWP7rrCSir/JiYGfabG/viWVLGbWc=;
        b=Qe5w0gIoiRzhiS0KUAqc8yM3enG4DoLByVkXp/fxCJv0rasAPtYmclsYUFLuEf94dB
         h7c07i9MD0/j6jfWH+tWyeIkYlH0so+cdV9WZWSrlsmBqyaek/R/U9LT2Cc1EwZcWjyz
         Vh0XOw7Yg4Kh9erqau3yOcyTDkjTSZ/3Q4N6Ja7ZkhJAsBStIaVsSO3R89aTjFAoM/59
         V921F8KvCT9ppPy+P66UowoorpGowof2rCGat+VUyjKdxxyG/JmPhq92NWKFmLjbZa2Y
         04dPKshhDMuB0jHYkXbIy9H16WGUwhb+JSBLRwWO7O8u0r0i5k3CUV0kGUmxJ0kZK2Ye
         4AJA==
X-Forwarded-Encrypted: i=1; AJvYcCXNK5kM49rQ2unSBhOiAUY5aKzXwu+uDGsjnssw1nvCDko6cYFsALC6DA33mNCTyqV5iJEjJdNcGqcnQALVJuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdowWF5WFg8lg1XIeozoopEwkYwtKgJNmdC9IfDOLvZEzWxjHD
	Vn2E23LFp0/HvnzB1QIolx6CkbIvcwgQRjaGTyTjQIK6vWO/HjxLRvowe8vrE93dSZu2PvSaGc4
	S7VDD0pPxUz/Mww==
X-Google-Smtp-Source: AGHT+IEBQSrctqMadwDKwnb6XaPASUJRA04EZtDN8SrspND/WSF8x6bzYrdqWet+djZJrRonPHO3J1eDdgmHpw==
X-Received: from pfny8.prod.google.com ([2002:aa7:8548:0:b0:7ae:309d:349])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:12c3:b0:35e:5055:1ec with SMTP id adf61e73a8af0-3614f4b1871mr4338135637.17.1763748896129;
 Fri, 21 Nov 2025 10:14:56 -0800 (PST)
Date: Fri, 21 Nov 2025 18:14:22 +0000
In-Reply-To: <20251121181429.1421717-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251121181429.1421717-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251121181429.1421717-12-dmatlack@google.com>
Subject: [PATCH v3 11/18] vfio: selftests: Move IOMMU library code into iommu.c
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Alex Mastro <amastro@fb.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Raghavendra Rao Ananta <rananta@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Move all the IOMMU related library code into their own file iommu.c.
This provides a better separation between the vfio_pci_device helper
code and the iommu code.

No function change intended.

Reviewed-by: Alex Mastro <amastro@fb.com>
Tested-by: Alex Mastro <amastro@fb.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../selftests/vfio/lib/include/vfio_util.h    |  74 ++-
 tools/testing/selftests/vfio/lib/iommu.c      | 461 ++++++++++++++++++
 tools/testing/selftests/vfio/lib/libvfio.mk   |   3 +-
 .../selftests/vfio/lib/vfio_pci_device.c      | 442 -----------------
 4 files changed, 527 insertions(+), 453 deletions(-)
 create mode 100644 tools/testing/selftests/vfio/lib/iommu.c

diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
index 7784422116de..f67915d9443e 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -50,6 +50,12 @@
 	VFIO_LOG_AND_EXIT(_fmt, ##__VA_ARGS__);			\
 } while (0)
 
+#define ioctl_assert(_fd, _op, _arg) do {						       \
+	void *__arg = (_arg);								       \
+	int __ret = ioctl((_fd), (_op), (__arg));					       \
+	VFIO_ASSERT_EQ(__ret, 0, "ioctl(%s, %s, %s) returned %d\n", #_fd, #_op, #_arg, __ret); \
+} while (0)
+
 #define dev_info(_dev, _fmt, ...) printf("%s: " _fmt, (_dev)->bdf, ##__VA_ARGS__)
 #define dev_err(_dev, _fmt, ...) fprintf(stderr, "%s: " _fmt, (_dev)->bdf, ##__VA_ARGS__)
 
@@ -223,24 +229,52 @@ extern const char *default_iommu_mode;
 struct iommu *iommu_init(const char *iommu_mode);
 void iommu_cleanup(struct iommu *iommu);
 
+int __iommu_map(struct iommu *iommu, struct dma_region *region);
+
+static inline void iommu_map(struct iommu *iommu, struct dma_region *region)
+{
+	VFIO_ASSERT_EQ(__iommu_map(iommu, region), 0);
+}
+
+int __iommu_unmap(struct iommu *iommu, struct dma_region *region, u64 *unmapped);
+
+static inline void iommu_unmap(struct iommu *iommu, struct dma_region *region)
+{
+	VFIO_ASSERT_EQ(__iommu_unmap(iommu, region, NULL), 0);
+}
+
+int __iommu_unmap_all(struct iommu *iommu, u64 *unmapped);
+
+static inline void iommu_unmap_all(struct iommu *iommu)
+{
+	VFIO_ASSERT_EQ(__iommu_unmap_all(iommu, NULL), 0);
+}
+
+iova_t __iommu_hva2iova(struct iommu *iommu, void *vaddr);
+iova_t iommu_hva2iova(struct iommu *iommu, void *vaddr);
+
+struct iommu_iova_range *iommu_iova_ranges(struct iommu *iommu, u32 *nranges);
+
 struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iommu);
 void vfio_pci_device_cleanup(struct vfio_pci_device *device);
 
 void vfio_pci_device_reset(struct vfio_pci_device *device);
 
-struct iommu_iova_range *vfio_pci_iova_ranges(struct vfio_pci_device *device,
-					      u32 *nranges);
+static inline struct iommu_iova_range *vfio_pci_iova_ranges(struct vfio_pci_device *device,
+							    u32 *nranges)
+{
+	return iommu_iova_ranges(device->iommu, nranges);
+}
 
 struct iova_allocator *iova_allocator_init(struct vfio_pci_device *device);
 void iova_allocator_cleanup(struct iova_allocator *allocator);
 iova_t iova_allocator_alloc(struct iova_allocator *allocator, size_t size);
 
-int __vfio_pci_dma_map(struct vfio_pci_device *device,
-		       struct dma_region *region);
-int __vfio_pci_dma_unmap(struct vfio_pci_device *device,
-			 struct dma_region *region,
-			 u64 *unmapped);
-int __vfio_pci_dma_unmap_all(struct vfio_pci_device *device, u64 *unmapped);
+static inline int __vfio_pci_dma_map(struct vfio_pci_device *device,
+				     struct dma_region *region)
+{
+	return __iommu_map(device->iommu, region);
+}
 
 static inline void vfio_pci_dma_map(struct vfio_pci_device *device,
 				    struct dma_region *region)
@@ -248,12 +282,25 @@ static inline void vfio_pci_dma_map(struct vfio_pci_device *device,
 	VFIO_ASSERT_EQ(__vfio_pci_dma_map(device, region), 0);
 }
 
+static inline int __vfio_pci_dma_unmap(struct vfio_pci_device *device,
+				       struct dma_region *region,
+				       u64 *unmapped)
+{
+	return __iommu_unmap(device->iommu, region, unmapped);
+}
+
 static inline void vfio_pci_dma_unmap(struct vfio_pci_device *device,
 				      struct dma_region *region)
 {
 	VFIO_ASSERT_EQ(__vfio_pci_dma_unmap(device, region, NULL), 0);
 }
 
+static inline int __vfio_pci_dma_unmap_all(struct vfio_pci_device *device,
+					   u64 *unmapped)
+{
+	return __iommu_unmap_all(device->iommu, unmapped);
+}
+
 static inline void vfio_pci_dma_unmap_all(struct vfio_pci_device *device)
 {
 	VFIO_ASSERT_EQ(__vfio_pci_dma_unmap_all(device, NULL), 0);
@@ -319,8 +366,15 @@ static inline void vfio_pci_msix_disable(struct vfio_pci_device *device)
 	vfio_pci_irq_disable(device, VFIO_PCI_MSIX_IRQ_INDEX);
 }
 
-iova_t __to_iova(struct vfio_pci_device *device, void *vaddr);
-iova_t to_iova(struct vfio_pci_device *device, void *vaddr);
+static inline iova_t __to_iova(struct vfio_pci_device *device, void *vaddr)
+{
+	return __iommu_hva2iova(device->iommu, vaddr);
+}
+
+static inline iova_t to_iova(struct vfio_pci_device *device, void *vaddr)
+{
+	return iommu_hva2iova(device->iommu, vaddr);
+}
 
 static inline bool vfio_pci_device_match(struct vfio_pci_device *device,
 					 u16 vendor_id, u16 device_id)
diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/selftests/vfio/lib/iommu.c
new file mode 100644
index 000000000000..3933079fc419
--- /dev/null
+++ b/tools/testing/selftests/vfio/lib/iommu.c
@@ -0,0 +1,461 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <dirent.h>
+#include <fcntl.h>
+#include <libgen.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <sys/eventfd.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+
+#include <uapi/linux/types.h>
+#include <linux/limits.h>
+#include <linux/mman.h>
+#include <linux/types.h>
+#include <linux/vfio.h>
+#include <linux/iommufd.h>
+
+#include "../../../kselftest.h"
+#include <vfio_util.h>
+
+const char *default_iommu_mode = "iommufd";
+
+/* Reminder: Keep in sync with FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(). */
+static const struct iommu_mode iommu_modes[] = {
+	{
+		.name = "vfio_type1_iommu",
+		.container_path = "/dev/vfio/vfio",
+		.iommu_type = VFIO_TYPE1_IOMMU,
+	},
+	{
+		.name = "vfio_type1v2_iommu",
+		.container_path = "/dev/vfio/vfio",
+		.iommu_type = VFIO_TYPE1v2_IOMMU,
+	},
+	{
+		.name = "iommufd_compat_type1",
+		.container_path = "/dev/iommu",
+		.iommu_type = VFIO_TYPE1_IOMMU,
+	},
+	{
+		.name = "iommufd_compat_type1v2",
+		.container_path = "/dev/iommu",
+		.iommu_type = VFIO_TYPE1v2_IOMMU,
+	},
+	{
+		.name = "iommufd",
+	},
+};
+
+static const struct iommu_mode *lookup_iommu_mode(const char *iommu_mode)
+{
+	int i;
+
+	if (!iommu_mode)
+		iommu_mode = default_iommu_mode;
+
+	for (i = 0; i < ARRAY_SIZE(iommu_modes); i++) {
+		if (strcmp(iommu_mode, iommu_modes[i].name))
+			continue;
+
+		return &iommu_modes[i];
+	}
+
+	VFIO_FAIL("Unrecognized IOMMU mode: %s\n", iommu_mode);
+}
+
+iova_t __iommu_hva2iova(struct iommu *iommu, void *vaddr)
+{
+	struct dma_region *region;
+
+	list_for_each_entry(region, &iommu->dma_regions, link) {
+		if (vaddr < region->vaddr)
+			continue;
+
+		if (vaddr >= region->vaddr + region->size)
+			continue;
+
+		return region->iova + (vaddr - region->vaddr);
+	}
+
+	return INVALID_IOVA;
+}
+
+iova_t iommu_hva2iova(struct iommu *iommu, void *vaddr)
+{
+	iova_t iova;
+
+	iova = __iommu_hva2iova(iommu, vaddr);
+	VFIO_ASSERT_NE(iova, INVALID_IOVA, "%p is not mapped into IOMMU\n", vaddr);
+
+	return iova;
+}
+
+static int vfio_iommu_map(struct iommu *iommu, struct dma_region *region)
+{
+	struct vfio_iommu_type1_dma_map args = {
+		.argsz = sizeof(args),
+		.flags = VFIO_DMA_MAP_FLAG_READ | VFIO_DMA_MAP_FLAG_WRITE,
+		.vaddr = (u64)region->vaddr,
+		.iova = region->iova,
+		.size = region->size,
+	};
+
+	if (ioctl(iommu->container_fd, VFIO_IOMMU_MAP_DMA, &args))
+		return -errno;
+
+	return 0;
+}
+
+static int iommufd_map(struct iommu *iommu, struct dma_region *region)
+{
+	struct iommu_ioas_map args = {
+		.size = sizeof(args),
+		.flags = IOMMU_IOAS_MAP_READABLE |
+			 IOMMU_IOAS_MAP_WRITEABLE |
+			 IOMMU_IOAS_MAP_FIXED_IOVA,
+		.user_va = (u64)region->vaddr,
+		.iova = region->iova,
+		.length = region->size,
+		.ioas_id = iommu->ioas_id,
+	};
+
+	if (ioctl(iommu->iommufd, IOMMU_IOAS_MAP, &args))
+		return -errno;
+
+	return 0;
+}
+
+int __iommu_map(struct iommu *iommu, struct dma_region *region)
+{
+	int ret;
+
+	if (iommu->iommufd)
+		ret = iommufd_map(iommu, region);
+	else
+		ret = vfio_iommu_map(iommu, region);
+
+	if (ret)
+		return ret;
+
+	list_add(&region->link, &iommu->dma_regions);
+
+	return 0;
+}
+
+static int __vfio_iommu_unmap(int fd, u64 iova, u64 size, u32 flags, u64 *unmapped)
+{
+	struct vfio_iommu_type1_dma_unmap args = {
+		.argsz = sizeof(args),
+		.iova = iova,
+		.size = size,
+		.flags = flags,
+	};
+
+	if (ioctl(fd, VFIO_IOMMU_UNMAP_DMA, &args))
+		return -errno;
+
+	if (unmapped)
+		*unmapped = args.size;
+
+	return 0;
+}
+
+static int vfio_iommu_unmap(struct iommu *iommu, struct dma_region *region,
+			    u64 *unmapped)
+{
+	return __vfio_iommu_unmap(iommu->container_fd, region->iova,
+				  region->size, 0, unmapped);
+}
+
+static int __iommufd_unmap(int fd, u64 iova, u64 length, u32 ioas_id, u64 *unmapped)
+{
+	struct iommu_ioas_unmap args = {
+		.size = sizeof(args),
+		.iova = iova,
+		.length = length,
+		.ioas_id = ioas_id,
+	};
+
+	if (ioctl(fd, IOMMU_IOAS_UNMAP, &args))
+		return -errno;
+
+	if (unmapped)
+		*unmapped = args.length;
+
+	return 0;
+}
+
+static int iommufd_unmap(struct iommu *iommu, struct dma_region *region,
+			 u64 *unmapped)
+{
+	return __iommufd_unmap(iommu->iommufd, region->iova, region->size,
+			       iommu->ioas_id, unmapped);
+}
+
+int __iommu_unmap(struct iommu *iommu, struct dma_region *region, u64 *unmapped)
+{
+	int ret;
+
+	if (iommu->iommufd)
+		ret = iommufd_unmap(iommu, region, unmapped);
+	else
+		ret = vfio_iommu_unmap(iommu, region, unmapped);
+
+	if (ret)
+		return ret;
+
+	list_del_init(&region->link);
+
+	return 0;
+}
+
+int __iommu_unmap_all(struct iommu *iommu, u64 *unmapped)
+{
+	int ret;
+	struct dma_region *curr, *next;
+
+	if (iommu->iommufd)
+		ret = __iommufd_unmap(iommu->iommufd, 0, UINT64_MAX,
+				      iommu->ioas_id, unmapped);
+	else
+		ret = __vfio_iommu_unmap(iommu->container_fd, 0, 0,
+					 VFIO_DMA_UNMAP_FLAG_ALL, unmapped);
+
+	if (ret)
+		return ret;
+
+	list_for_each_entry_safe(curr, next, &iommu->dma_regions, link)
+		list_del_init(&curr->link);
+
+	return 0;
+}
+
+static struct vfio_info_cap_header *next_cap_hdr(void *buf, u32 bufsz,
+						 u32 *cap_offset)
+{
+	struct vfio_info_cap_header *hdr;
+
+	if (!*cap_offset)
+		return NULL;
+
+	VFIO_ASSERT_LT(*cap_offset, bufsz);
+	VFIO_ASSERT_GE(bufsz - *cap_offset, sizeof(*hdr));
+
+	hdr = (struct vfio_info_cap_header *)((u8 *)buf + *cap_offset);
+	*cap_offset = hdr->next;
+
+	return hdr;
+}
+
+static struct vfio_info_cap_header *vfio_iommu_info_cap_hdr(struct vfio_iommu_type1_info *info,
+							    u16 cap_id)
+{
+	struct vfio_info_cap_header *hdr;
+	u32 cap_offset = info->cap_offset;
+	u32 max_depth;
+	u32 depth = 0;
+
+	if (!(info->flags & VFIO_IOMMU_INFO_CAPS))
+		return NULL;
+
+	if (cap_offset)
+		VFIO_ASSERT_GE(cap_offset, sizeof(*info));
+
+	max_depth = (info->argsz - sizeof(*info)) / sizeof(*hdr);
+
+	while ((hdr = next_cap_hdr(info, info->argsz, &cap_offset))) {
+		depth++;
+		VFIO_ASSERT_LE(depth, max_depth, "Capability chain contains a cycle\n");
+
+		if (hdr->id == cap_id)
+			return hdr;
+	}
+
+	return NULL;
+}
+
+/* Return buffer including capability chain, if present. Free with free() */
+static struct vfio_iommu_type1_info *vfio_iommu_get_info(int container_fd)
+{
+	struct vfio_iommu_type1_info *info;
+
+	info = malloc(sizeof(*info));
+	VFIO_ASSERT_NOT_NULL(info);
+
+	*info = (struct vfio_iommu_type1_info) {
+		.argsz = sizeof(*info),
+	};
+
+	ioctl_assert(container_fd, VFIO_IOMMU_GET_INFO, info);
+	VFIO_ASSERT_GE(info->argsz, sizeof(*info));
+
+	info = realloc(info, info->argsz);
+	VFIO_ASSERT_NOT_NULL(info);
+
+	ioctl_assert(container_fd, VFIO_IOMMU_GET_INFO, info);
+	VFIO_ASSERT_GE(info->argsz, sizeof(*info));
+
+	return info;
+}
+
+/*
+ * Return iova ranges for the device's container. Normalize vfio_iommu_type1 to
+ * report iommufd's iommu_iova_range. Free with free().
+ */
+static struct iommu_iova_range *vfio_iommu_iova_ranges(struct iommu *iommu,
+						       u32 *nranges)
+{
+	struct vfio_iommu_type1_info_cap_iova_range *cap_range;
+	struct vfio_iommu_type1_info *info;
+	struct vfio_info_cap_header *hdr;
+	struct iommu_iova_range *ranges = NULL;
+
+	info = vfio_iommu_get_info(iommu->container_fd);
+	hdr = vfio_iommu_info_cap_hdr(info, VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE);
+	VFIO_ASSERT_NOT_NULL(hdr);
+
+	cap_range = container_of(hdr, struct vfio_iommu_type1_info_cap_iova_range, header);
+	VFIO_ASSERT_GT(cap_range->nr_iovas, 0);
+
+	ranges = calloc(cap_range->nr_iovas, sizeof(*ranges));
+	VFIO_ASSERT_NOT_NULL(ranges);
+
+	for (u32 i = 0; i < cap_range->nr_iovas; i++) {
+		ranges[i] = (struct iommu_iova_range){
+			.start = cap_range->iova_ranges[i].start,
+			.last = cap_range->iova_ranges[i].end,
+		};
+	}
+
+	*nranges = cap_range->nr_iovas;
+
+	free(info);
+	return ranges;
+}
+
+/* Return iova ranges of the device's IOAS. Free with free() */
+static struct iommu_iova_range *iommufd_iova_ranges(struct iommu *iommu,
+						    u32 *nranges)
+{
+	struct iommu_iova_range *ranges;
+	int ret;
+
+	struct iommu_ioas_iova_ranges query = {
+		.size = sizeof(query),
+		.ioas_id = iommu->ioas_id,
+	};
+
+	ret = ioctl(iommu->iommufd, IOMMU_IOAS_IOVA_RANGES, &query);
+	VFIO_ASSERT_EQ(ret, -1);
+	VFIO_ASSERT_EQ(errno, EMSGSIZE);
+	VFIO_ASSERT_GT(query.num_iovas, 0);
+
+	ranges = calloc(query.num_iovas, sizeof(*ranges));
+	VFIO_ASSERT_NOT_NULL(ranges);
+
+	query.allowed_iovas = (uintptr_t)ranges;
+
+	ioctl_assert(iommu->iommufd, IOMMU_IOAS_IOVA_RANGES, &query);
+	*nranges = query.num_iovas;
+
+	return ranges;
+}
+
+static int iova_range_comp(const void *a, const void *b)
+{
+	const struct iommu_iova_range *ra = a, *rb = b;
+
+	if (ra->start < rb->start)
+		return -1;
+
+	if (ra->start > rb->start)
+		return 1;
+
+	return 0;
+}
+
+/* Return sorted IOVA ranges of the device. Free with free(). */
+struct iommu_iova_range *iommu_iova_ranges(struct iommu *iommu, u32 *nranges)
+{
+	struct iommu_iova_range *ranges;
+
+	if (iommu->iommufd)
+		ranges = iommufd_iova_ranges(iommu, nranges);
+	else
+		ranges = vfio_iommu_iova_ranges(iommu, nranges);
+
+	if (!ranges)
+		return NULL;
+
+	VFIO_ASSERT_GT(*nranges, 0);
+
+	/* Sort and check that ranges are sane and non-overlapping */
+	qsort(ranges, *nranges, sizeof(*ranges), iova_range_comp);
+	VFIO_ASSERT_LT(ranges[0].start, ranges[0].last);
+
+	for (u32 i = 1; i < *nranges; i++) {
+		VFIO_ASSERT_LT(ranges[i].start, ranges[i].last);
+		VFIO_ASSERT_LT(ranges[i - 1].last, ranges[i].start);
+	}
+
+	return ranges;
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
+void iommu_cleanup(struct iommu *iommu)
+{
+	if (iommu->iommufd)
+		VFIO_ASSERT_EQ(close(iommu->iommufd), 0);
+	else
+		VFIO_ASSERT_EQ(close(iommu->container_fd), 0);
+
+	free(iommu);
+}
diff --git a/tools/testing/selftests/vfio/lib/libvfio.mk b/tools/testing/selftests/vfio/lib/libvfio.mk
index 3c0cdac30cb6..7ecf2ad75c67 100644
--- a/tools/testing/selftests/vfio/lib/libvfio.mk
+++ b/tools/testing/selftests/vfio/lib/libvfio.mk
@@ -3,7 +3,8 @@ ARCH ?= $(SUBARCH)
 
 LIBVFIO_SRCDIR := $(selfdir)/vfio/lib
 
-LIBVFIO_C := vfio_pci_device.c
+LIBVFIO_C := iommu.c
+LIBVFIO_C += vfio_pci_device.c
 LIBVFIO_C += vfio_pci_driver.c
 
 ifeq ($(ARCH:x86_64=x86),x86)
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 877b145cef63..5e0de10df04e 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -24,184 +24,6 @@
 
 #define PCI_SYSFS_PATH	"/sys/bus/pci/devices"
 
-#define ioctl_assert(_fd, _op, _arg) do {						       \
-	void *__arg = (_arg);								       \
-	int __ret = ioctl((_fd), (_op), (__arg));					       \
-	VFIO_ASSERT_EQ(__ret, 0, "ioctl(%s, %s, %s) returned %d\n", #_fd, #_op, #_arg, __ret); \
-} while (0)
-
-static struct vfio_info_cap_header *next_cap_hdr(void *buf, u32 bufsz,
-						 u32 *cap_offset)
-{
-	struct vfio_info_cap_header *hdr;
-
-	if (!*cap_offset)
-		return NULL;
-
-	VFIO_ASSERT_LT(*cap_offset, bufsz);
-	VFIO_ASSERT_GE(bufsz - *cap_offset, sizeof(*hdr));
-
-	hdr = (struct vfio_info_cap_header *)((u8 *)buf + *cap_offset);
-	*cap_offset = hdr->next;
-
-	return hdr;
-}
-
-static struct vfio_info_cap_header *vfio_iommu_info_cap_hdr(struct vfio_iommu_type1_info *info,
-							    u16 cap_id)
-{
-	struct vfio_info_cap_header *hdr;
-	u32 cap_offset = info->cap_offset;
-	u32 max_depth;
-	u32 depth = 0;
-
-	if (!(info->flags & VFIO_IOMMU_INFO_CAPS))
-		return NULL;
-
-	if (cap_offset)
-		VFIO_ASSERT_GE(cap_offset, sizeof(*info));
-
-	max_depth = (info->argsz - sizeof(*info)) / sizeof(*hdr);
-
-	while ((hdr = next_cap_hdr(info, info->argsz, &cap_offset))) {
-		depth++;
-		VFIO_ASSERT_LE(depth, max_depth, "Capability chain contains a cycle\n");
-
-		if (hdr->id == cap_id)
-			return hdr;
-	}
-
-	return NULL;
-}
-
-/* Return buffer including capability chain, if present. Free with free() */
-static struct vfio_iommu_type1_info *vfio_iommu_get_info(struct vfio_pci_device *device)
-{
-	struct vfio_iommu_type1_info *info;
-
-	info = malloc(sizeof(*info));
-	VFIO_ASSERT_NOT_NULL(info);
-
-	*info = (struct vfio_iommu_type1_info) {
-		.argsz = sizeof(*info),
-	};
-
-	ioctl_assert(device->iommu->container_fd, VFIO_IOMMU_GET_INFO, info);
-	VFIO_ASSERT_GE(info->argsz, sizeof(*info));
-
-	info = realloc(info, info->argsz);
-	VFIO_ASSERT_NOT_NULL(info);
-
-	ioctl_assert(device->iommu->container_fd, VFIO_IOMMU_GET_INFO, info);
-	VFIO_ASSERT_GE(info->argsz, sizeof(*info));
-
-	return info;
-}
-
-/*
- * Return iova ranges for the device's container. Normalize vfio_iommu_type1 to
- * report iommufd's iommu_iova_range. Free with free().
- */
-static struct iommu_iova_range *vfio_iommu_iova_ranges(struct vfio_pci_device *device,
-						       u32 *nranges)
-{
-	struct vfio_iommu_type1_info_cap_iova_range *cap_range;
-	struct vfio_iommu_type1_info *info;
-	struct vfio_info_cap_header *hdr;
-	struct iommu_iova_range *ranges = NULL;
-
-	info = vfio_iommu_get_info(device);
-	hdr = vfio_iommu_info_cap_hdr(info, VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE);
-	VFIO_ASSERT_NOT_NULL(hdr);
-
-	cap_range = container_of(hdr, struct vfio_iommu_type1_info_cap_iova_range, header);
-	VFIO_ASSERT_GT(cap_range->nr_iovas, 0);
-
-	ranges = calloc(cap_range->nr_iovas, sizeof(*ranges));
-	VFIO_ASSERT_NOT_NULL(ranges);
-
-	for (u32 i = 0; i < cap_range->nr_iovas; i++) {
-		ranges[i] = (struct iommu_iova_range){
-			.start = cap_range->iova_ranges[i].start,
-			.last = cap_range->iova_ranges[i].end,
-		};
-	}
-
-	*nranges = cap_range->nr_iovas;
-
-	free(info);
-	return ranges;
-}
-
-/* Return iova ranges of the device's IOAS. Free with free() */
-static struct iommu_iova_range *iommufd_iova_ranges(struct vfio_pci_device *device,
-						    u32 *nranges)
-{
-	struct iommu_iova_range *ranges;
-	int ret;
-
-	struct iommu_ioas_iova_ranges query = {
-		.size = sizeof(query),
-		.ioas_id = device->iommu->ioas_id,
-	};
-
-	ret = ioctl(device->iommu->iommufd, IOMMU_IOAS_IOVA_RANGES, &query);
-	VFIO_ASSERT_EQ(ret, -1);
-	VFIO_ASSERT_EQ(errno, EMSGSIZE);
-	VFIO_ASSERT_GT(query.num_iovas, 0);
-
-	ranges = calloc(query.num_iovas, sizeof(*ranges));
-	VFIO_ASSERT_NOT_NULL(ranges);
-
-	query.allowed_iovas = (uintptr_t)ranges;
-
-	ioctl_assert(device->iommu->iommufd, IOMMU_IOAS_IOVA_RANGES, &query);
-	*nranges = query.num_iovas;
-
-	return ranges;
-}
-
-static int iova_range_comp(const void *a, const void *b)
-{
-	const struct iommu_iova_range *ra = a, *rb = b;
-
-	if (ra->start < rb->start)
-		return -1;
-
-	if (ra->start > rb->start)
-		return 1;
-
-	return 0;
-}
-
-/* Return sorted IOVA ranges of the device. Free with free(). */
-struct iommu_iova_range *vfio_pci_iova_ranges(struct vfio_pci_device *device,
-					      u32 *nranges)
-{
-	struct iommu_iova_range *ranges;
-
-	if (device->iommu->iommufd)
-		ranges = iommufd_iova_ranges(device, nranges);
-	else
-		ranges = vfio_iommu_iova_ranges(device, nranges);
-
-	if (!ranges)
-		return NULL;
-
-	VFIO_ASSERT_GT(*nranges, 0);
-
-	/* Sort and check that ranges are sane and non-overlapping */
-	qsort(ranges, *nranges, sizeof(*ranges), iova_range_comp);
-	VFIO_ASSERT_LT(ranges[0].start, ranges[0].last);
-
-	for (u32 i = 1; i < *nranges; i++) {
-		VFIO_ASSERT_LT(ranges[i].start, ranges[i].last);
-		VFIO_ASSERT_LT(ranges[i - 1].last, ranges[i].start);
-	}
-
-	return ranges;
-}
-
 struct iova_allocator *iova_allocator_init(struct vfio_pci_device *device)
 {
 	struct iova_allocator *allocator;
@@ -273,33 +95,6 @@ iova_t iova_allocator_alloc(struct iova_allocator *allocator, size_t size)
 	}
 }
 
-iova_t __to_iova(struct vfio_pci_device *device, void *vaddr)
-{
-	struct dma_region *region;
-
-	list_for_each_entry(region, &device->iommu->dma_regions, link) {
-		if (vaddr < region->vaddr)
-			continue;
-
-		if (vaddr >= region->vaddr + region->size)
-			continue;
-
-		return region->iova + (vaddr - region->vaddr);
-	}
-
-	return INVALID_IOVA;
-}
-
-iova_t to_iova(struct vfio_pci_device *device, void *vaddr)
-{
-	iova_t iova;
-
-	iova = __to_iova(device, vaddr);
-	VFIO_ASSERT_NE(iova, INVALID_IOVA, "%p is not mapped into device.\n", vaddr);
-
-	return iova;
-}
-
 static void vfio_pci_irq_set(struct vfio_pci_device *device,
 			     u32 index, u32 vector, u32 count, int *fds)
 {
@@ -386,142 +181,6 @@ static void vfio_pci_irq_get(struct vfio_pci_device *device, u32 index,
 	ioctl_assert(device->fd, VFIO_DEVICE_GET_IRQ_INFO, irq_info);
 }
 
-static int vfio_iommu_dma_map(struct vfio_pci_device *device,
-			       struct dma_region *region)
-{
-	struct vfio_iommu_type1_dma_map args = {
-		.argsz = sizeof(args),
-		.flags = VFIO_DMA_MAP_FLAG_READ | VFIO_DMA_MAP_FLAG_WRITE,
-		.vaddr = (u64)region->vaddr,
-		.iova = region->iova,
-		.size = region->size,
-	};
-
-	if (ioctl(device->iommu->container_fd, VFIO_IOMMU_MAP_DMA, &args))
-		return -errno;
-
-	return 0;
-}
-
-static int iommufd_dma_map(struct vfio_pci_device *device,
-			    struct dma_region *region)
-{
-	struct iommu_ioas_map args = {
-		.size = sizeof(args),
-		.flags = IOMMU_IOAS_MAP_READABLE |
-			 IOMMU_IOAS_MAP_WRITEABLE |
-			 IOMMU_IOAS_MAP_FIXED_IOVA,
-		.user_va = (u64)region->vaddr,
-		.iova = region->iova,
-		.length = region->size,
-		.ioas_id = device->iommu->ioas_id,
-	};
-
-	if (ioctl(device->iommu->iommufd, IOMMU_IOAS_MAP, &args))
-		return -errno;
-
-	return 0;
-}
-
-int __vfio_pci_dma_map(struct vfio_pci_device *device,
-		      struct dma_region *region)
-{
-	int ret;
-
-	if (device->iommu->iommufd)
-		ret = iommufd_dma_map(device, region);
-	else
-		ret = vfio_iommu_dma_map(device, region);
-
-	if (ret)
-		return ret;
-
-	list_add(&region->link, &device->iommu->dma_regions);
-
-	return 0;
-}
-
-static int vfio_iommu_dma_unmap(int fd, u64 iova, u64 size, u32 flags,
-				u64 *unmapped)
-{
-	struct vfio_iommu_type1_dma_unmap args = {
-		.argsz = sizeof(args),
-		.iova = iova,
-		.size = size,
-		.flags = flags,
-	};
-
-	if (ioctl(fd, VFIO_IOMMU_UNMAP_DMA, &args))
-		return -errno;
-
-	if (unmapped)
-		*unmapped = args.size;
-
-	return 0;
-}
-
-static int iommufd_dma_unmap(int fd, u64 iova, u64 length, u32 ioas_id,
-			     u64 *unmapped)
-{
-	struct iommu_ioas_unmap args = {
-		.size = sizeof(args),
-		.iova = iova,
-		.length = length,
-		.ioas_id = ioas_id,
-	};
-
-	if (ioctl(fd, IOMMU_IOAS_UNMAP, &args))
-		return -errno;
-
-	if (unmapped)
-		*unmapped = args.length;
-
-	return 0;
-}
-
-int __vfio_pci_dma_unmap(struct vfio_pci_device *device,
-			 struct dma_region *region, u64 *unmapped)
-{
-	int ret;
-
-	if (device->iommu->iommufd)
-		ret = iommufd_dma_unmap(device->iommu->iommufd, region->iova,
-					region->size, device->iommu->ioas_id,
-					unmapped);
-	else
-		ret = vfio_iommu_dma_unmap(device->iommu->container_fd,
-					   region->iova, region->size, 0,
-					   unmapped);
-
-	if (ret)
-		return ret;
-
-	list_del_init(&region->link);
-
-	return 0;
-}
-
-int __vfio_pci_dma_unmap_all(struct vfio_pci_device *device, u64 *unmapped)
-{
-	int ret;
-	struct dma_region *curr, *next;
-
-	if (device->iommu->iommufd)
-		ret = iommufd_dma_unmap(device->iommu->iommufd, 0, UINT64_MAX,
-					device->iommu->ioas_id, unmapped);
-	else
-		ret = vfio_iommu_dma_unmap(device->iommu->container_fd, 0, 0,
-					   VFIO_DMA_UNMAP_FLAG_ALL, unmapped);
-
-	if (ret)
-		return ret;
-
-	list_for_each_entry_safe(curr, next, &device->iommu->dma_regions, link)
-		list_del_init(&curr->link);
-
-	return 0;
-}
-
 static void vfio_pci_region_get(struct vfio_pci_device *device, int index,
 				struct vfio_region_info *info)
 {
@@ -711,52 +370,6 @@ const char *vfio_pci_get_cdev_path(const char *bdf)
 	return cdev_path;
 }
 
-/* Reminder: Keep in sync with FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(). */
-static const struct iommu_mode iommu_modes[] = {
-	{
-		.name = "vfio_type1_iommu",
-		.container_path = "/dev/vfio/vfio",
-		.iommu_type = VFIO_TYPE1_IOMMU,
-	},
-	{
-		.name = "vfio_type1v2_iommu",
-		.container_path = "/dev/vfio/vfio",
-		.iommu_type = VFIO_TYPE1v2_IOMMU,
-	},
-	{
-		.name = "iommufd_compat_type1",
-		.container_path = "/dev/iommu",
-		.iommu_type = VFIO_TYPE1_IOMMU,
-	},
-	{
-		.name = "iommufd_compat_type1v2",
-		.container_path = "/dev/iommu",
-		.iommu_type = VFIO_TYPE1v2_IOMMU,
-	},
-	{
-		.name = "iommufd",
-	},
-};
-
-const char *default_iommu_mode = "iommufd";
-
-static const struct iommu_mode *lookup_iommu_mode(const char *iommu_mode)
-{
-	int i;
-
-	if (!iommu_mode)
-		iommu_mode = default_iommu_mode;
-
-	for (i = 0; i < ARRAY_SIZE(iommu_modes); i++) {
-		if (strcmp(iommu_mode, iommu_modes[i].name))
-			continue;
-
-		return &iommu_modes[i];
-	}
-
-	VFIO_FAIL("Unrecognized IOMMU mode: %s\n", iommu_mode);
-}
-
 static void vfio_device_bind_iommufd(int device_fd, int iommufd)
 {
 	struct vfio_device_bind_iommufd args = {
@@ -767,16 +380,6 @@ static void vfio_device_bind_iommufd(int device_fd, int iommufd)
 	ioctl_assert(device_fd, VFIO_DEVICE_BIND_IOMMUFD, &args);
 }
 
-static u32 iommufd_ioas_alloc(int iommufd)
-{
-	struct iommu_ioas_alloc args = {
-		.size = sizeof(args),
-	};
-
-	ioctl_assert(iommufd, IOMMU_IOAS_ALLOC, &args);
-	return args.out_ioas_id;
-}
-
 static void vfio_device_attach_iommufd_pt(int device_fd, u32 pt_id)
 {
 	struct vfio_device_attach_iommufd_pt args = {
@@ -799,41 +402,6 @@ static void vfio_pci_iommufd_setup(struct vfio_pci_device *device, const char *b
 	vfio_device_attach_iommufd_pt(device->fd, device->iommu->ioas_id);
 }
 
-struct iommu *iommu_init(const char *iommu_mode)
-{
-	const char *container_path;
-	struct iommu *iommu;
-	int version;
-
-	iommu = calloc(1, sizeof(*iommu));
-	VFIO_ASSERT_NOT_NULL(iommu);
-
-	INIT_LIST_HEAD(&iommu->dma_regions);
-
-	iommu->mode = lookup_iommu_mode(iommu_mode);
-
-	container_path = iommu->mode->container_path;
-	if (container_path) {
-		iommu->container_fd = open(container_path, O_RDWR);
-		VFIO_ASSERT_GE(iommu->container_fd, 0, "open(%s) failed\n", container_path);
-
-		version = ioctl(iommu->container_fd, VFIO_GET_API_VERSION);
-		VFIO_ASSERT_EQ(version, VFIO_API_VERSION, "Unsupported version: %d\n", version);
-	} else {
-		/*
-		 * Require device->iommufd to be >0 so that a simple non-0 check can be
-		 * used to check if iommufd is enabled. In practice open() will never
-		 * return 0 unless stdin is closed.
-		 */
-		iommu->iommufd = open("/dev/iommu", O_RDWR);
-		VFIO_ASSERT_GT(iommu->iommufd, 0);
-
-		iommu->ioas_id = iommufd_ioas_alloc(iommu->iommufd);
-	}
-
-	return iommu;
-}
-
 struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iommu)
 {
 	struct vfio_pci_device *device;
@@ -879,16 +447,6 @@ void vfio_pci_device_cleanup(struct vfio_pci_device *device)
 	free(device);
 }
 
-void iommu_cleanup(struct iommu *iommu)
-{
-	if (iommu->iommufd)
-		VFIO_ASSERT_EQ(close(iommu->iommufd), 0);
-	else
-		VFIO_ASSERT_EQ(close(iommu->container_fd), 0);
-
-	free(iommu);
-}
-
 static bool is_bdf(const char *str)
 {
 	unsigned int s, b, d, f;
-- 
2.52.0.rc2.455.g230fcf2819-goog


