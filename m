Return-Path: <linux-kselftest+bounces-39740-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8535BB3243A
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 23:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5CB3B67307
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 21:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7527734A305;
	Fri, 22 Aug 2025 21:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wQUsPG20"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841F13451B0
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 21:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755897984; cv=none; b=NRIy6wq3fak7lyw0Dpu1gXIzB+ZBb20QORKsEPfNYwgSjolLAHDL3gxBMOLP2VKkuOITPi62txPfK7QFJGWqoSps/AuPzAUw9BYzvle1nvjS8O/bmjekvOq4xx2YV68QXiZJpW334Bfk1wCrKk7NDCgAIj3J1WArfb3by9vTf6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755897984; c=relaxed/simple;
	bh=viIj7nBDLYKadwUM0xbSDydrlKrdGDZyvE8jEMitn1w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K3JQzQ168jCcrw4e/XKBg9+aIYLkhh2skDEe7kIT7zreQenXO/JmgjPuD1TQPSciD00euPRR9KsoG3ecN6ouax53Gm2KlU76JkjFu8e2Un5cFeYvT7hJv9IpgoqRzoH0ST8tMmp0PPWeyn9vMt4ye0WFuAQw6rz2BV5Ww+bMyuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wQUsPG20; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-324e41e946eso4779211a91.0
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 14:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755897982; x=1756502782; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UPA+PwewYS8+Q8uCILWL6+Br5YS0UgFCMUzmbl5NWvU=;
        b=wQUsPG205d0jBat686nYHc9WyUU+XYuc4UNPp92U/a2eJGEV1ihDiZjnziRhNKhSle
         wMTr5bsAKwnMflAXrc2k8ukvvrqhZdl1JGd5pTZLIQ2lapejtDv/N4jChhlbEeg7n1FW
         eh28UooPcc3g/RDmRa3Q+GLM3AdaNXPzuTD8oII9isQq9V291rz+wh8X/xRxj/Vg9BTK
         OkaBmMZ87BDyaPhC2AG4jNMHHyuNV7AFrB5sguDOdxkkAmhdjR5Kq9ckvyACIhjsVe6F
         KmP79nKD8EJlB/NyMzIjNeJUmbdHofcJHFMifzVwlQahdNaaszUMk35UethFqiCviuA5
         oemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755897982; x=1756502782;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UPA+PwewYS8+Q8uCILWL6+Br5YS0UgFCMUzmbl5NWvU=;
        b=pYXgelAapjhQaleSlT7kpecTWMMY6Bn6RARe/qQhGxw3M5ZVOPyWJFfbOwMLKO+HSP
         OsP/5KOfh8kvZszicZiyn9RSe0WBd/YRLvHn8MBkMM7Z/tQZWCvhqysOTC3gmtpE+0Rj
         utMhyrNzbVusu49D4hJBdaaFpwKOC11PjgskC33qJXsAEIcU6I9tQQNyEfmRqc8HipNY
         YtTDPRH+JyCuhCV+9u9BmgUVADOKWOmCZ/ziYBwQv0kP3p/KJeNsfE/8CdSvhUrBiDne
         twl+A5sHINOf5TD3xkl+SbmOo0TkWvjKbOpJWv7cBAlI1wVGFnbRWc/iGA/r9w12u5pf
         dIEw==
X-Forwarded-Encrypted: i=1; AJvYcCU6NoYl8At6OQS3W9nM9cwc1mFGYKLHVDhF4n/MW2cuWR+sxDDZydypJSt8EG7iglLFORaPYV462peAwJ+Cod0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDMl3wt1CM3V19MP75ojFDrRZWeXOSDXNSX++EXp+naw5BXLyH
	FQD44Wt0jbI+AzQK+Jsx7nDu4j8/xQtgDrDTVuOPmAAGdEqvEb2sYjX5PL6/QoblM98wZryOMbe
	E3V1siiLxSycfOA==
X-Google-Smtp-Source: AGHT+IH6FN3m+8AsP4Yr1fs51qpn+36lUQWWOw73mi/WeDKVT4PQCbismToESXKqAuCrkJq7YvdVPfCb7EN4FA==
X-Received: from pjbsw5.prod.google.com ([2002:a17:90b:2c85:b0:311:485b:d057])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3d8b:b0:31f:16ee:5dcc with SMTP id 98e67ed59e1d1-32515e527b3mr6324435a91.14.1755897981897;
 Fri, 22 Aug 2025 14:26:21 -0700 (PDT)
Date: Fri, 22 Aug 2025 21:24:56 +0000
In-Reply-To: <20250822212518.4156428-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822212518.4156428-1-dmatlack@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822212518.4156428-10-dmatlack@google.com>
Subject: [PATCH v2 09/30] vfio: selftests: Keep track of DMA regions mapped
 into the device
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

Keep track of the list of DMA regions that are mapped into the device
using a linked list and a new struct vfio_dma_region and use that to add
{__,}to_iova() for converting host virtual addresses into IOVAs.

This will be used in a subsequent commit to map multiple DMA regions
into a device that are then used by drivers.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../selftests/vfio/lib/include/vfio_util.h    | 23 +++++++--
 .../selftests/vfio/lib/vfio_pci_device.c      | 49 ++++++++++++++++---
 .../selftests/vfio/vfio_dma_mapping_test.c    | 31 ++++++------
 3 files changed, 79 insertions(+), 24 deletions(-)

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
index 2612f0cabea5..4578ee6df0e1 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -128,30 +128,32 @@ TEST_F(vfio_dma_mapping_test, dma_map_unmap)
 {
 	const u64 size = variant->size ?: getpagesize();
 	const int flags = variant->mmap_flags;
+	struct vfio_dma_region region;
 	struct iommu_mapping mapping;
-	void *mem;
-	u64 iova;
 	int rc;
 
-	mem = mmap(NULL, size, PROT_READ | PROT_WRITE, flags, -1, 0);
+	region.vaddr = mmap(NULL, size, PROT_READ | PROT_WRITE, flags, -1, 0);
 
 	/* Skip the test if there aren't enough HugeTLB pages available. */
-	if (flags & MAP_HUGETLB && mem == MAP_FAILED)
+	if (flags & MAP_HUGETLB && region.vaddr == MAP_FAILED)
 		SKIP(return, "mmap() failed: %s (%d)\n", strerror(errno), errno);
 	else
-		ASSERT_NE(mem, MAP_FAILED);
+		ASSERT_NE(region.vaddr, MAP_FAILED);
 
-	iova = (u64)mem;
+	region.iova = (u64)region.vaddr;
+	region.size = size;
 
-	vfio_pci_dma_map(self->device, iova, size, mem);
-	printf("Mapped HVA %p (size 0x%lx) at IOVA 0x%lx\n", mem, size, iova);
+	vfio_pci_dma_map(self->device, &region);
+	printf("Mapped HVA %p (size 0x%lx) at IOVA 0x%lx\n", region.vaddr, size, region.iova);
 
-	rc = iommu_mapping_get(device_bdf, iova, &mapping);
+	ASSERT_EQ(region.iova, to_iova(self->device, region.vaddr));
+
+	rc = iommu_mapping_get(device_bdf, region.iova, &mapping);
 	if (rc == -EOPNOTSUPP)
 		goto unmap;
 
 	ASSERT_EQ(0, rc);
-	printf("Found IOMMU mappings for IOVA 0x%lx:\n", iova);
+	printf("Found IOMMU mappings for IOVA 0x%lx:\n", region.iova);
 	printf("PGD: 0x%016lx\n", mapping.pgd);
 	printf("P4D: 0x%016lx\n", mapping.p4d);
 	printf("PUD: 0x%016lx\n", mapping.pud);
@@ -176,11 +178,12 @@ TEST_F(vfio_dma_mapping_test, dma_map_unmap)
 	}
 
 unmap:
-	vfio_pci_dma_unmap(self->device, iova, size);
-	printf("Unmapped IOVA 0x%lx\n", iova);
-	ASSERT_NE(0, iommu_mapping_get(device_bdf, iova, &mapping));
+	vfio_pci_dma_unmap(self->device, &region);
+	printf("Unmapped IOVA 0x%lx\n", region.iova);
+	ASSERT_EQ(INVALID_IOVA, __to_iova(self->device, region.vaddr));
+	ASSERT_NE(0, iommu_mapping_get(device_bdf, region.iova, &mapping));
 
-	ASSERT_TRUE(!munmap(mem, size));
+	ASSERT_TRUE(!munmap(region.vaddr, size));
 }
 
 int main(int argc, char *argv[])
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


