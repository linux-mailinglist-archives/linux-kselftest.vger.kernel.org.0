Return-Path: <linux-kselftest+bounces-35508-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4E6AE2631
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 01:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD3735A10BF
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 23:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2283124E008;
	Fri, 20 Jun 2025 23:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fqKIdhlO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7310B24DD0F
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 23:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750461686; cv=none; b=B9+GwuQ4CGvz6L4jqmSXH7ZSAFXNT3lj8XQgMOvdOO6EB2prLUruYwgTFdUSsno6llu19iegyt6ZvyuSo3gSn98BkrpNRFpS+2CY3ks1q38jGVsuxDdtQC4yuWcX4sXUtwbFoAbWBlr5zw92F1tOM+fgkq2C6dIy8NL5JocDOJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750461686; c=relaxed/simple;
	bh=ANMUITQgqa3uv1sGXtXgP4F+4PTYsQJMF21q/xp9JZU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KJL9Xjzz2qRcn3p5ENi5c+Lm4jC2I2SlCSgUoK3o1kORF3DXT0LkOPuGksRHF7AKc+HDtyjJ0vO1ladNrqswDvZVrtnnkN1zPZRhGERoJQ1up5J2qsq7BBW4HwfIk4baY9ea+APxHw+mruQ44fVH4CUlnUNNGd+lCHbvhhq0SB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fqKIdhlO; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2c36951518so2804231a12.2
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 16:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750461684; x=1751066484; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6psXHhTcl9eZgOxRU8loX76pbJzljz2HQYYU3YDEy5w=;
        b=fqKIdhlOnD95uhjgL0bnIBDIQC2cD04v04tAUOTNp43YEuyT8hD14Nfkx1DZU3DT0Q
         xl++n9cdKtwqYXsgjElvFFofVTRQELQGIRdOf3lt8CYRqolROk42VzSBrZ9N104sbPnU
         UMcQOLNLbyvb0I88jQs3q+megOrfLPKONwzbw50cNvBymNVIuluX5DG5hOqq29HgLNLG
         WRZzBi5cE67bGnfKr03CguSt0OTipQEUZF8b0vYt479vmUUYcYxeD2OyFasjltELUqzk
         CZBe1ilnlbJdHFU/41BObasHbFgcVQgNxeTruw66AfCbkzM3W3E+rMrGKC7RLAIgb0Q8
         hsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750461684; x=1751066484;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6psXHhTcl9eZgOxRU8loX76pbJzljz2HQYYU3YDEy5w=;
        b=H3jZt0UVtU9u1WyKmOoci3by6lT8+z7G35LtTg+frimnV9eD/8SYInljjYknBx1iM1
         IklBnMvH4mqFB2z//XuEPz0Wsf/IxXlpSgUop1G3cxdA2iv8YdQTck4dxmZ6dvzCzBnD
         g6pjKRM0yHmn8aKE0T6JTmku/E80pkJXB0CACZXcfctlDjWYws9+opI1mMGLckGRc8qU
         8JlMN7UAPmWx+ayEFekCpRVFslebDp8Yea23rRTwd4jiscvM017qWYPwR2ukZoDT+3KC
         nhwULVwSewz+eqfuWchaK9kPOWxkUXayXw98ygFn9I2sKXxCnGKT1VwtDjiox3gN/BGr
         A5cg==
X-Forwarded-Encrypted: i=1; AJvYcCV9DSHjK8TrM7uHwvWGbHUtZjBQNVq8Sv8uwym1THaoNyDSqSPaiY9YatSBkjBoCeOZtlapbqTRfGLhI7vTRzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2zMNNzv9yN0gU5HrFkOOHZ+u7DUiJ2fDGshpIrT8V6yodfWFw
	4W6acI0furA5cYbmInR6rfce2Ld+i2tGNJ6xpcelb6LaJb17qRYYmhuzxyf/vKs/K8Ek/7+iNv9
	b6rXe/t+XJSfD2A==
X-Google-Smtp-Source: AGHT+IFSisBE6wh4JyqjDqmABTOSeKgB/6rG041dX0X+SJO+nB1oRW8PNQ6iQHqMFNFeuJzk6Ec7rnkKMCJzpw==
X-Received: from pgc14.prod.google.com ([2002:a05:6a02:2f8e:b0:b31:dbad:8412])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:6a07:b0:21f:7525:f537 with SMTP id adf61e73a8af0-22026f1a9efmr7350666637.41.1750461683871;
 Fri, 20 Jun 2025 16:21:23 -0700 (PDT)
Date: Fri, 20 Jun 2025 23:20:12 +0000
In-Reply-To: <20250620232031.2705638-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620232031.2705638-1-dmatlack@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620232031.2705638-15-dmatlack@google.com>
Subject: [PATCH 14/33] vfio: selftests: Keep track of DMA regions mapped into
 the device
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

Keep track of the list of DMA regions that are mapped into the device
using a linked list and a new struct vfio_dma_region and use that to add
{__,}to_iova() for converting host virtual addresses into IOVAs.

This will be used in a subsequent commit to map multiple DMA regions
into a device that are then used by drivers.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../selftests/vfio/lib/include/vfio_util.h    | 23 +++++++--
 .../selftests/vfio/lib/vfio_pci_device.c      | 49 ++++++++++++++++---
 .../selftests/vfio/vfio_dma_mapping_test.c    | 21 +++++---
 3 files changed, 75 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
index 234403b442af..db08646c2819 100644
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
@@ -85,9 +98,10 @@ struct vfio_pci_device *vfio_pci_device_init(const char *bdf, int iommu_type);
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
@@ -138,4 +152,7 @@ static inline void vfio_pci_msix_disable(struct vfio_pci_device *device)
 	vfio_pci_irq_disable(device, VFIO_PCI_MSIX_IRQ_INDEX);
 }
 
+iova_t __to_iova(struct vfio_pci_device *device, void *vaddr);
+iova_t to_iova(struct vfio_pci_device *device, void *vaddr);
+
 #endif /* SELFTESTS_VFIO_LIB_INCLUDE_VFIO_UTIL_H */
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 98cce0a6ecd7..36b4b30b75cf 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -26,6 +26,33 @@
 	VFIO_ASSERT_EQ(__ret, 0, "ioctl(%s, %s, %s) returned %d\n", #_fd, #_op, #_arg, __ret); \
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
@@ -112,28 +139,34 @@ static void vfio_pci_irq_get(struct vfio_pci_device *device, u32 index,
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
@@ -260,6 +293,8 @@ static void vfio_pci_iommu_setup(struct vfio_pci_device *device, unsigned long i
 {
 	int ret;
 
+	INIT_LIST_HEAD(&device->dma_regions);
+
 	ret = ioctl(device->container_fd, VFIO_CHECK_EXTENSION, iommu_type);
 	VFIO_ASSERT_GT(ret, 0, "VFIO IOMMU type %lu not supported\n", iommu_type);
 
diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
index 9cdf25b293c5..8cec09ba8ec3 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -128,21 +128,25 @@ TEST_F(vfio_dma_mapping_test, dma_map_unmap)
 {
 	const u64 size = variant->size ?: getpagesize();
 	const int flags = variant->mmap_flags;
+	struct vfio_dma_region region;
 	struct iommu_mapping mapping;
 	const u64 iova = 0;
-	void *mem;
 	int rc;
 
-	mem = mmap(NULL, size, PROT_READ | PROT_WRITE, flags, -1, 0);
+	region.iova = iova;
+	region.size = size;
+	region.vaddr = mmap(NULL, size, PROT_READ | PROT_WRITE, flags, -1, 0);
 
 	/* Skip the test if there aren't enough HugeTLB pages available. */
-	if (flags & MAP_HUGETLB && mem == MAP_FAILED)
+	if (flags & MAP_HUGETLB && region.vaddr == MAP_FAILED)
 		SKIP(return, "mmap() failed: %s (%d)\n", strerror(errno), errno);
 	else
-		ASSERT_NE(mem, MAP_FAILED);
+		ASSERT_NE(region.vaddr, MAP_FAILED);
 
-	vfio_pci_dma_map(self->device, iova, size, mem);
-	printf("Mapped HVA %p (size 0x%lx) at IOVA 0x%lx\n", mem, size, iova);
+	vfio_pci_dma_map(self->device, &region);
+	printf("Mapped HVA %p (size 0x%lx) at IOVA 0x%lx\n", region.vaddr, size, iova);
+
+	ASSERT_EQ(iova, to_iova(self->device, region.vaddr));
 
 	rc = iommu_mapping_get(device_bdf, iova, &mapping);
 	if (rc == -EOPNOTSUPP)
@@ -174,11 +178,12 @@ TEST_F(vfio_dma_mapping_test, dma_map_unmap)
 	}
 
 unmap:
-	vfio_pci_dma_unmap(self->device, iova, size);
+	vfio_pci_dma_unmap(self->device, &region);
 	printf("Unmapped IOVA 0x%lx\n", iova);
+	ASSERT_EQ(INVALID_IOVA, __to_iova(self->device, region.vaddr));
 	ASSERT_NE(0, iommu_mapping_get(device_bdf, iova, &mapping));
 
-	ASSERT_TRUE(!munmap(mem, size));
+	ASSERT_TRUE(!munmap(region.vaddr, size));
 }
 
 int main(int argc, char *argv[])
-- 
2.50.0.rc2.701.gf1e915cc24-goog


