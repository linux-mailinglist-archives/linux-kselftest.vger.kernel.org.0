Return-Path: <linux-kselftest+bounces-33711-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4A1AC2C43
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 01:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 828EA541E92
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 23:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C0B220F33;
	Fri, 23 May 2025 23:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hYoTrvGE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0B2221278
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 23:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748043055; cv=none; b=B4OOWQlu14auQgafCqH9d/RjoEatkxxIrZ7IBYKdfPvNp0u+mpv6dUIApPTpOzWQSMdlvYCb6BMIWzzJ3ahIopbmDjRtWWDe4tzDj+nAHu4nycOdCsbIWQpirZ6u3erk63MOdQNHterfH0dWVOIBGG8OfSLmNpALqex976kI00k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748043055; c=relaxed/simple;
	bh=XFB76NABZviJPfOlyXNkP6l4hBM90VO+xbJxdLOUzbU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=km7JmibUJJR7mpCQ651ImU9yclC9yAeugbtIyp7UJfTzkiQzbq9bsfBpd4pQ0LgAo+CxPpbqaxnfbbIBKCrxmyP+FGCJtrVjKMm7sDlxUicN/EhNWNBVtbjKgIAOuMlPYGr8EflBdMZujL9mcNy/jysMh5j9pl5GFVjnwHqwh80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hYoTrvGE; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3110b78e12fso590085a91.1
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 16:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748043053; x=1748647853; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dbvndy14WLmrVseBPD+aXtR7LiVhb8OaSDQ9DBClagk=;
        b=hYoTrvGEn8nib21IojOd8y9qs/KE5gJV6veJXehtxkSI8iOE2+jon5ODo78MF/vZ5k
         oodTJt58gGnq+0h+h2fXlepndIZJoF6LMNr2Bno0Q53SdPoTL94QzsRSw//pOj+a45sV
         7BVEnPfQpXR+DmX39vx3YhWt1zRLJ11mfjOYQgRbFUF5KBk4hCdiL9mhfhJpDpEEflq7
         WipNnxjSGJS2IM9v/zms0DdNW1xOlZNctGwRs5SsRvVrHrIjJQl8E15jf3fZLmLmC8uu
         tpl9AOx45KjzRJGwW/q3oU0yv3zCDhvrz0yxCkHCWvur1p46oPrIh6KbdLgdY7zSu687
         CMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748043053; x=1748647853;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dbvndy14WLmrVseBPD+aXtR7LiVhb8OaSDQ9DBClagk=;
        b=JM6OteHxnYPN1DKuVIrDzBBqNy7bQxTbn9eRyGdeB2K3UGHHj74mo7AYB3vtAqwhoU
         9PK+VSE5mhK+BnQgdvMOjUmlCIcaxW2FjYW2ywqMsh1631DMWMvbfIbB+N2cFs396iDH
         /Ha2/akjXYotlAkvSrCdVDGySsPrVYsmKn+TzQ89GBGXDDD8z3wS+ObJ3K0zhJ3GSWej
         qOvePJEhojGB5JwYp6bCZHrG3O1rX3zLkBaYg721k8dQK7hgnlUU6X3V1Zi9yXFUnuAo
         C2wczgtIdfW/4iDyQUOEvTLegEF/uVRG7mfNasINbz7pCQzCCw6NWfEtbPKZLECz2+Ws
         QFHA==
X-Forwarded-Encrypted: i=1; AJvYcCULViFKIgsjrcBOlV2ENS6WPNV2x7AOWJtjwzBnxRXp7Vu4ptp7v2HUFXL2wKFFhUMO5agCL8fECMglPEiqOTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPy8WYQvSSLhxvdmkyDWs70bhR6JDr6Jj6f6nMt8g8HdNBO594
	rntY6AQNO4Iqe26AixtXBoYx495wji9lSkmSxobwFw1DXJdwD0NGhS7rTbPrRkzrcS75qt1501V
	QY/MvUfKX6V7hbQ==
X-Google-Smtp-Source: AGHT+IFUSbonvQZln+YG7RceYz32gE4GYfwdc7NjF3dvllXwjI/qhzRNNASumvsr8n9B7Vf69CI/WX+p7Y9BAA==
X-Received: from pjf6.prod.google.com ([2002:a17:90b:3f06:b0:2ea:9d23:79a0])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2e0e:b0:2ee:8ea0:6b9c with SMTP id 98e67ed59e1d1-3110f30d550mr1964569a91.12.1748043053008;
 Fri, 23 May 2025 16:30:53 -0700 (PDT)
Date: Fri, 23 May 2025 23:30:01 +0000
In-Reply-To: <20250523233018.1702151-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523233018.1702151-1-dmatlack@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523233018.1702151-17-dmatlack@google.com>
Subject: [RFC PATCH 16/33] vfio: selftests: Keep track of DMA regions mapped
 into the device
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

Keep track of the list of DMA regions that are mapped into the device
using a linked list and a new struct vfio_dma_region and use that to add
{__,}to_iova() for converting host virtual addresses into IOVAs.

This will be used in a subsequent commit to map multiple DMA regions
into a device that are then used by drivers.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../selftests/vfio/lib/include/vfio_util.h    | 23 +++++++--
 .../selftests/vfio/lib/vfio_pci_device.c      | 49 ++++++++++++++++---
 .../selftests/vfio/vfio_dma_mapping_test.c    | 20 +++++---
 3 files changed, 75 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
index 4e5c6d395a12..ab96a6628f0e 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -51,6 +51,17 @@ struct vfio_pci_bar {
 	void *vaddr;
 };
 
+typedef u64 iova_t;
+
+#define INVALID_IOVA UINT64_MAX
+
+struct vfio_dma_region {
+	struct list_head link;
+	void *vaddr;
+	iova_t iova;
+	u64 size;
+};
+
 struct vfio_pci_device {
 	int fd;
 	int group_fd;
@@ -63,6 +74,8 @@ struct vfio_pci_device {
 	struct vfio_irq_info msi_info;
 	struct vfio_irq_info msix_info;
 
+	struct list_head dma_regions;
+
 	/* eventfds for MSI and MSI-x interrupts */
 	int msi_eventfds[PCI_MSIX_FLAGS_QSIZE + 1];
 };
@@ -71,9 +84,10 @@ struct vfio_pci_device *vfio_pci_device_init(const char *bdf, int iommu_type);
 void vfio_pci_device_cleanup(struct vfio_pci_device *device);
 void vfio_pci_device_reset(struct vfio_pci_device *device);
 
-void vfio_pci_dma_map(struct vfio_pci_device *device, u64 iova, u64 size,
-		      void *vaddr);
-void vfio_pci_dma_unmap(struct vfio_pci_device *device, u64 iova, u64 size);
+void vfio_pci_dma_map(struct vfio_pci_device *device,
+		      struct vfio_dma_region *region);
+void vfio_pci_dma_unmap(struct vfio_pci_device *device,
+			struct vfio_dma_region *region);
 
 void vfio_pci_config_access(struct vfio_pci_device *device, bool write,
 			    size_t config, size_t size, void *data);
@@ -124,4 +138,7 @@ static inline void vfio_pci_msix_disable(struct vfio_pci_device *device)
 	vfio_pci_irq_disable(device, VFIO_PCI_MSIX_IRQ_INDEX);
 }
 
+iova_t __to_iova(struct vfio_pci_device *device, void *vaddr);
+iova_t to_iova(struct vfio_pci_device *device, void *vaddr);
+
 #endif /* SELFTESTS_VFIO_LIB_INCLUDE_VFIO_UTIL_H */
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index a2747de9ad69..e823d3ff7f45 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -27,6 +27,33 @@
 		    "ioctl(%s, %s, %s) returned %d\n", #_fd, #_op, #_arg, __ret); \
 } while (0)
 
+iova_t __to_iova(struct vfio_pci_device *device, void *vaddr)
+{
+	struct vfio_dma_region *region;
+
+	list_for_each_entry(region, &device->dma_regions, link) {
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
+iova_t to_iova(struct vfio_pci_device *device, void *vaddr)
+{
+	iova_t iova;
+
+	iova = __to_iova(device, vaddr);
+	VFIO_ASSERT_NE(iova, INVALID_IOVA, "%p is not mapped into device.\n", vaddr);
+
+	return iova;
+}
+
 static void vfio_pci_irq_set(struct vfio_pci_device *device,
 			     u32 index, u32 vector, u32 count, int *fds)
 {
@@ -113,28 +140,34 @@ static void vfio_pci_irq_get(struct vfio_pci_device *device, u32 index,
 	ioctl_assert(device->fd, VFIO_DEVICE_GET_IRQ_INFO, irq_info);
 }
 
-void vfio_pci_dma_map(struct vfio_pci_device *device, u64 iova, u64 size, void *vaddr)
+void vfio_pci_dma_map(struct vfio_pci_device *device,
+		      struct vfio_dma_region *region)
 {
 	struct vfio_iommu_type1_dma_map map = {
 		.argsz = sizeof(map),
 		.flags = VFIO_DMA_MAP_FLAG_READ | VFIO_DMA_MAP_FLAG_WRITE,
-		.vaddr = (u64)vaddr,
-		.iova = iova,
-		.size = size,
+		.vaddr = (u64)region->vaddr,
+		.iova = region->iova,
+		.size = region->size,
 	};
 
 	ioctl_assert(device->container_fd, VFIO_IOMMU_MAP_DMA, &map);
+
+	list_add(&region->link, &device->dma_regions);
 }
 
-void vfio_pci_dma_unmap(struct vfio_pci_device *device, u64 iova, u64 size)
+void vfio_pci_dma_unmap(struct vfio_pci_device *device,
+			struct vfio_dma_region *region)
 {
 	struct vfio_iommu_type1_dma_unmap unmap = {
 		.argsz = sizeof(unmap),
-		.iova = iova,
-		.size = size,
+		.iova = region->iova,
+		.size = region->size,
 	};
 
 	ioctl_assert(device->container_fd, VFIO_IOMMU_UNMAP_DMA, &unmap);
+
+	list_del(&region->link);
 }
 
 static void vfio_pci_region_get(struct vfio_pci_device *device, int index,
@@ -256,6 +289,8 @@ static void vfio_pci_iommu_setup(struct vfio_pci_device *device, unsigned long i
 {
 	int ret;
 
+	INIT_LIST_HEAD(&device->dma_regions);
+
 	ret = ioctl(device->container_fd, VFIO_CHECK_EXTENSION, iommu_type);
 	VFIO_ASSERT_GT(ret, 0, "VFIO IOMMU type %lu not supported\n", iommu_type);
 
diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
index c4920267ae42..d85621d165d9 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -117,15 +117,20 @@ TEST_F(vfio_dma_mapping_test, dma_map_unmap)
 	const int prot = PROT_READ | PROT_WRITE;
 	const u64 iova = test_config.iova;
 	const u64 size = test_config.size;
+	struct vfio_dma_region region = {
+		.iova = iova,
+		.size = size,
+	};
 	struct iommu_mapping mapping;
-	void *mem;
 	int rc;
 
-	mem = mmap(NULL, size, prot, test_config.mmap_flags, -1, 0);
-	ASSERT_NE(mem, MAP_FAILED);
+	region.vaddr = mmap(NULL, size, prot, test_config.mmap_flags, -1, 0);
+	ASSERT_NE(region.vaddr, MAP_FAILED);
 
-	vfio_pci_dma_map(self->device, iova, size, mem);
-	printf("Mapped HVA %p (size 0x%lx) at IOVA 0x%lx\n", mem, size, iova);
+	vfio_pci_dma_map(self->device, &region);
+	printf("Mapped HVA %p (size 0x%lx) at IOVA 0x%lx\n", region.vaddr, size, iova);
+
+	ASSERT_EQ(iova, to_iova(self->device, region.vaddr));
 
 	rc = iommu_mapping_get(test_config.bdf, iova, &mapping);
 	if (rc == -EOPNOTSUPP)
@@ -157,11 +162,12 @@ TEST_F(vfio_dma_mapping_test, dma_map_unmap)
 	}
 
 unmap:
-	vfio_pci_dma_unmap(self->device, iova, size);
+	vfio_pci_dma_unmap(self->device, &region);
 	printf("Unmapped IOVA 0x%lx\n", iova);
+	ASSERT_EQ(INVALID_IOVA, __to_iova(self->device, region.vaddr));
 	ASSERT_NE(0, iommu_mapping_get(test_config.bdf, iova, &mapping));
 
-	ASSERT_TRUE(!munmap(mem, size));
+	ASSERT_TRUE(!munmap(region.vaddr, size));
 }
 
 static void help(const char *name)
-- 
2.49.0.1151.ga128411c76-goog


