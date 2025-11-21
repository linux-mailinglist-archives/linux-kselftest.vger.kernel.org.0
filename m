Return-Path: <linux-kselftest+bounces-46279-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED222C7B4BE
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 19:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5229B4F3BBD
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 18:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D74E357705;
	Fri, 21 Nov 2025 18:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s0BiZf0V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439DF34DB5C
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748916; cv=none; b=C+az5+xtZZ6AgNe7IyNxPafeewVpWCcoBdU5B8OZryYD5zXBxm1vzpVGeQceIXgF2HRXhKsnK5s026lCro280rjUXLh2T9UdJGYGyjaMHYQUJEsNYtglDDd3HQUJ2ubsS6CXZS4W8bkuspgv8RNJNIlM/xUjLQnddro4AUC4GKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748916; c=relaxed/simple;
	bh=y9f/Tucry1hsY9LeYUBKujhZ6OwShFYUbS5Y4yU0CCw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ks3j4z8t6hID5yHedrSfudZULlengUFM/BRcidzPk13LHxa6DMoLriaf58IQbCA58LMomw6nDDpHCes4R+h23+3ZKFpLdI+hfRkN0Ul7VqjrcbKuJJb6U5XZNMEQkAQED3LOVTfEBG+UjB5IEWFpLsaL1W7Vv6sh94n1+s7TTZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s0BiZf0V; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7a998ab7f87so4268872b3a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 10:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763748906; x=1764353706; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aImDlLkdwi5IFhoPbJDPVG9tN+ymVEKJWl0wF/tcJUA=;
        b=s0BiZf0VvQIDR1SMSXYDNGd0YEXEc1wZsGzkBk6Rc5zyxmHsPjK82WOKHklE295GKB
         cYdiObuaUwRg3dmpAJMMuC+0GGX1rjShr9VbeL12pR7oDXqsiqU2bzcmg1t09X9mgFx0
         HDm5f2ZCZSdEAazzT2KWBF4SSO+bQyrzbQ4qjxql/1DctV5xVwnNHCP0Z+Az9IAshNYh
         ICadutOgYkiuSuXj9Tm9zZmfZ/cjI+qzfP4XlvENNBmYCbBP/DDcmNojZ6z9Tup+35Si
         mMP+TzkHge6TZGm8oB3+HRWVhi35YZhvVTsK4ej9EV3O9FdVvnfk7nocfJ7krcfp1xxa
         nntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763748906; x=1764353706;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aImDlLkdwi5IFhoPbJDPVG9tN+ymVEKJWl0wF/tcJUA=;
        b=bykwRAkRBAbn49v65VWYp4DdHCpActDGKR+WvnZiyYF6epNLn5w3zErzdXgxbdfz0S
         v7n8X3wbNSqdjCZJWBc4F3DbmBYOUArhtxV56fluWv2oT7dDHBwR/X9+/PM4yYJFsHOr
         KWve4aRI4dow3LtNU3Y2mHT80oLatomtwM3fTsam//bDEUx0wjIxA0XrxwKoKfsgVn18
         /dh5KMxF5SEeLEaFmVxlK8lbBVFHcjglmOk1uBSr7i2po7yrP70vTNm3FGMHfr7Yc8Zh
         cCb8bNahWfcYKnR3bSCN4+7FlUcub+awG7/aGeJHNpzclOnoUMl90b7cBCxc7yfiIAtT
         syjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuG4i/12VA+g4BB+9JB+/kk512sZmB9tETaZ38OgFFIFSCw5MEqbESt4kMcEzqdUGBHjQPZcyDkzVStfzNdH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YySKvbXTO+cryjDZ5jGovHD4Kr3W/55h4mEm68/FJsrDOspSt5x
	gIYsP1bwXLP+THXuJdhVedd0QZ0swyOOOcaDze/Dzecku2lGtoedS1yuQr1jXI+4xHEv+1GWDn+
	5RD37oY1dFUgaAg==
X-Google-Smtp-Source: AGHT+IGZPynVuiLCHAiwBzSdaJErjcxqKMyzgzkXeH80cyVu6Qu3tMgiXJPN+ZnWokCbF5gwN+sv9QgUKOEVQg==
X-Received: from pfbdo11.prod.google.com ([2002:a05:6a00:4a0b:b0:7b8:282e:c971])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:8d4:b0:7b8:ac7f:5968 with SMTP id d2e1a72fcca58-7c58e601f29mr3822571b3a.24.1763748906161;
 Fri, 21 Nov 2025 10:15:06 -0800 (PST)
Date: Fri, 21 Nov 2025 18:14:28 +0000
In-Reply-To: <20251121181429.1421717-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251121181429.1421717-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251121181429.1421717-18-dmatlack@google.com>
Subject: [PATCH v3 17/18] vfio: selftests: Eliminate INVALID_IOVA
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
2.52.0.rc2.455.g230fcf2819-goog


