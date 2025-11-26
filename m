Return-Path: <linux-kselftest+bounces-46592-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C347C8C562
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 00:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB42A4E1D5A
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 23:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BA034B683;
	Wed, 26 Nov 2025 23:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wePGeV1N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FFD33EB15
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 23:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764199091; cv=none; b=WKKOOm4k6C8ZWm45t/UZpbqRJsOQegQIVe92DL50a8mcxfMquygf2S/Asa8ixR9yKLMd+fUfr08EJEVpC0rCwIVEuM/0r/SxOjOuPP+ijNYxfS+Uq0Rs/PMxgsVW170wvmbd+D7pyg/9MIR0n3WAW1FxCm/7ws6cz9geJWo9ejw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764199091; c=relaxed/simple;
	bh=WpySdpWplIFkyFjdRPH8mjnIr8ZWwugcwAyYN9dmoGA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=csxugTNJf/qRYwjni36K6zKQIYkj2PVbIzn34fiaoNEHAojNjg9DrnxcqQ8pSbUwN926iyiURbl0Inwzbm9MN8aIU2Kk0cDkKG3Df2NYSRC5eODKliQbxtMwKCMse3+kvKrltAtqF2yfnXQAKN9fVdYV/xMXG0yQQrgHe6uAJfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wePGeV1N; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7a432101881so312708b3a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 15:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764199088; x=1764803888; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W+pnV+aPRrlLst9nvfnueF4Po9qU0QkYO4ZzZSMG/yA=;
        b=wePGeV1N2xD+JfemPLRC4NW0f3uLCt0Aqy/+wI3XffuXrbwplTY04zEdET/LSxWEBb
         W2N8G6JxjjrppO0zGXyyTDlDuS/j3HvWqpLMb4MPOY49nIzHEHLe/Epx1gak0bF2XwJ5
         6XuDpFHQQ41f891P8kfSwdjANGAwE5x48WGqdR/h8WhjOAIAtO3IxNP/fIIsvyqFMRDX
         RiRJkUNe0e0K6h/KUuEJLc2UxDPGNPk0b7OESwiRYbdSE0cC0Vd3hl38mqK+s40SwH1n
         mGi68gwFQO/YwN5v6I17uG2wm89rdnQFKyz4aqxvbBmmTV6n3AzrYZ+EWlYWLtQa5OIC
         soKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764199088; x=1764803888;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W+pnV+aPRrlLst9nvfnueF4Po9qU0QkYO4ZzZSMG/yA=;
        b=ap5DSSdnzgTmbEMISpcxw3z/2ADajR+8BzJ1xQDx7FkNVAb2sRSiHrUNgfbXuqwPQE
         9GWcKOwHDzak78EU3trEDHjaM8N+sZy3gEa5/7O8Z3WtQlz4J0s6Uxkt/6GcZEv1ePub
         LhHDeqx9CrVSoc2iq/UzobYD6MJGR4kOh6jofuklHoYNmVfHF8errmb+XPTAjNGNHCVh
         nETOq5QoWcENn0ADygY6RwncSJvSLY8VwrsY/kdIUq1jhpv3i+34Sqh2JMJ5mzh+G3PE
         oxZVRHHpYN0j4kzMPbd+5CYnsM+Hv2O6c6uhTuGtJaw11f3zyi7L3ZrahKT2ViyXqWxb
         a9pA==
X-Forwarded-Encrypted: i=1; AJvYcCXCMcDuUvlXx9gz+M3i3MugEkbX2G9ULawE9tKvBPWx09TsxEifknWdNJstPdzcTEK1BEvtjQzWuK3YjvwswPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkVuVHoDUedVTBfOqs39F+ycjz5e0GkSVK6VV0tw6fD1Mxr5t3
	J+AvmAEskV1KPdcSoKai9CYY1O0nVejpzwcQuKhxZuvFHdfRoaeAGO/j6E7MOC2z4RutuenU96X
	/AfdCr2Lv1ynWZw==
X-Google-Smtp-Source: AGHT+IFuic0ctn0G24phSOJnRXkr3T8Tckl/kQVJBgvphMjPTbTwnjLR0jMKiGqJ+NLnuaO7uN+8Wbs7AMCmPA==
X-Received: from pfbfj11.prod.google.com ([2002:a05:6a00:3a0b:b0:7b0:e3d3:f03e])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2e82:b0:7aa:9723:3217 with SMTP id d2e1a72fcca58-7c58e40f6dcmr19685166b3a.25.1764199088215;
 Wed, 26 Nov 2025 15:18:08 -0800 (PST)
Date: Wed, 26 Nov 2025 23:17:32 +0000
In-Reply-To: <20251126231733.3302983-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251126231733.3302983-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251126231733.3302983-18-dmatlack@google.com>
Subject: [PATCH v4 17/18] vfio: selftests: Eliminate INVALID_IOVA
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Alex Mastro <amastro@fb.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Raghavendra Rao Ananta <rananta@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Eliminate INVALID_IOVA as there are platforms where UINT64_MAX is a
valid iova.

Reviewed-by: Alex Mastro <amastro@fb.com>
Tested-by: Alex Mastro <amastro@fb.com>
Reviewed-by: Raghavendra Rao Ananta <rananta@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../selftests/vfio/lib/include/libvfio/iommu.h     |  3 +--
 .../vfio/lib/include/libvfio/vfio_pci_device.h     |  4 ++--
 tools/testing/selftests/vfio/lib/iommu.c           | 14 +++++++++-----
 .../testing/selftests/vfio/vfio_dma_mapping_test.c |  2 +-
 4 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
index e35f13ed3f3c..5c9b9dc6d993 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
@@ -8,7 +8,6 @@
 #include <libvfio/assert.h>
 
 typedef u64 iova_t;
-#define INVALID_IOVA UINT64_MAX
 
 struct iommu_mode {
 	const char *name;
@@ -57,7 +56,7 @@ static inline void iommu_unmap_all(struct iommu *iommu)
 	VFIO_ASSERT_EQ(__iommu_unmap_all(iommu, NULL), 0);
 }
 
-iova_t __iommu_hva2iova(struct iommu *iommu, void *vaddr);
+int __iommu_hva2iova(struct iommu *iommu, void *vaddr, iova_t *iova);
 iova_t iommu_hva2iova(struct iommu *iommu, void *vaddr);
 
 struct iommu_iova_range *iommu_iova_ranges(struct iommu *iommu, u32 *nranges);
diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index 160e003131d6..2858885a89bb 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -103,9 +103,9 @@ static inline void vfio_pci_msix_disable(struct vfio_pci_device *device)
 	vfio_pci_irq_disable(device, VFIO_PCI_MSIX_IRQ_INDEX);
 }
 
-static inline iova_t __to_iova(struct vfio_pci_device *device, void *vaddr)
+static inline int __to_iova(struct vfio_pci_device *device, void *vaddr, iova_t *iova)
 {
-	return __iommu_hva2iova(device->iommu, vaddr);
+	return __iommu_hva2iova(device->iommu, vaddr, iova);
 }
 
 static inline iova_t to_iova(struct vfio_pci_device *device, void *vaddr)
diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/selftests/vfio/lib/iommu.c
index 52f9cdf5f171..8079d43523f3 100644
--- a/tools/testing/selftests/vfio/lib/iommu.c
+++ b/tools/testing/selftests/vfio/lib/iommu.c
@@ -67,7 +67,7 @@ static const struct iommu_mode *lookup_iommu_mode(const char *iommu_mode)
 	VFIO_FAIL("Unrecognized IOMMU mode: %s\n", iommu_mode);
 }
 
-iova_t __iommu_hva2iova(struct iommu *iommu, void *vaddr)
+int __iommu_hva2iova(struct iommu *iommu, void *vaddr, iova_t *iova)
 {
 	struct dma_region *region;
 
@@ -78,18 +78,22 @@ iova_t __iommu_hva2iova(struct iommu *iommu, void *vaddr)
 		if (vaddr >= region->vaddr + region->size)
 			continue;
 
-		return region->iova + (vaddr - region->vaddr);
+		if (iova)
+			*iova = region->iova + (vaddr - region->vaddr);
+
+		return 0;
 	}
 
-	return INVALID_IOVA;
+	return -ENOENT;
 }
 
 iova_t iommu_hva2iova(struct iommu *iommu, void *vaddr)
 {
 	iova_t iova;
+	int ret;
 
-	iova = __iommu_hva2iova(iommu, vaddr);
-	VFIO_ASSERT_NE(iova, INVALID_IOVA, "%p is not mapped into IOMMU\n", vaddr);
+	ret = __iommu_hva2iova(iommu, vaddr, &iova);
+	VFIO_ASSERT_EQ(ret, 0, "%p is not mapped into the iommu\n", vaddr);
 
 	return iova;
 }
diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
index 213fcd8dcc79..5397822c3dd4 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -199,7 +199,7 @@ TEST_F(vfio_dma_mapping_test, dma_map_unmap)
 	ASSERT_EQ(rc, 0);
 	ASSERT_EQ(unmapped, region.size);
 	printf("Unmapped IOVA 0x%lx\n", region.iova);
-	ASSERT_EQ(INVALID_IOVA, __to_iova(self->device, region.vaddr));
+	ASSERT_NE(0, __to_iova(self->device, region.vaddr, NULL));
 	ASSERT_NE(0, iommu_mapping_get(device_bdf, region.iova, &mapping));
 
 	ASSERT_TRUE(!munmap(region.vaddr, size));
-- 
2.52.0.487.g5c8c507ade-goog


