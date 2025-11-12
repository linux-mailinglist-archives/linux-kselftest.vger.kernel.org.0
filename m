Return-Path: <linux-kselftest+bounces-45457-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B55C541F2
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 20:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1C43D349338
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 19:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307633557F4;
	Wed, 12 Nov 2025 19:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WQ6bABC/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCCA355033
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 19:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975393; cv=none; b=ROVcpdcsSaMt8hjvYyWXDs5LjTFbP1t2GC8QQWNkNGlj5HdF2HhlhZexFi0Vp4TELTj8A9EbVOsWhQXo6/ELvdVXuRa4qLmCwxNQdZa73rQiXh3DEn/DCvaXNC8o2L6MoD6UcxlB+rOEOWu8B5bnflv6OmDmfDut3+ggarXc6Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975393; c=relaxed/simple;
	bh=rNjCVJoNwWvayt/bmiXSzISNxmpCcsT2tGf1NIUi/4Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GakeJjQaKMv2shzf30tEZaPLwnj0eJZJyEv3WLHBuFvajDJLyyZODBDPxe4VMnrNNsDnuAAkqoqKtX3gMJZhlVYVeREQJPj601KmLx1Px4lkUQ5mchb8kcpMw8KqunC3hxnir1QiFMVWpwPuyUaCe6Ysu/4eYAHdS/DAszkGfgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WQ6bABC/; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7b5d4e1de6dso1314978b3a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 11:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762975390; x=1763580190; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OKdUfWA8VBozuhxSSZUtzJUgC9/JHS2oDYkkS/YkkQc=;
        b=WQ6bABC/a1jngvzP34qzEOQVA/j3LFw5ynsoL1xdyUCTJDBhEpWpmvaUGZC27osVzN
         0zYAlUFSNMR5kzf5HxSjLQIjyvhIS7ssHcMf2iplmgnNWLpa2ZD6rOQ5bO7Tf9U0pVt5
         d0uK73TCjMTrl2jRiffK2WUG4TJntfNcC8kLL9PFPms9cNY/FQqai36ypfD2XL/WRGCa
         uEBkC/zCe4n2FUrQdMev69plSpBbdhpttJ/EwH771q+iM1nRoXwGryHYNZRjZDMOk71i
         mULb5rxiSPV9HqYIf/Q56pWWvpjbvKPOGj7FWQbQwZCrfelkeIAVdPK4JMqDEEC06VfH
         Az6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975390; x=1763580190;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OKdUfWA8VBozuhxSSZUtzJUgC9/JHS2oDYkkS/YkkQc=;
        b=I7Dq2KdjaPXdO+7FOtWCRHtzOub2UFEQ8Z2hJ8hI38z2Wj9GjSd810b0RCxDdlOMeW
         VUJUqjB2CU4tT4tbO9+E1u/QfrKjF3dvzfj7wd0aQ/vSF2eeb5RwCmiTQkeJ6OmmtcCA
         VkI2eLMOJRoW8OpUyhDKCxblFFU1maNcMfL3alKqb+4wEXh1RfUCsrCR4amihM+dri1b
         Zx96Zqc3Snt8+lYXVHBQuqQqpguVaQqHv5fWEmxKJFW4YZUNW/ZuuTUo/PWX/NqvAfC+
         xZpEzjkOT9oGNBEQE3UnC/dRAyRe4iMEZrYzgNu/6kZmSG74Fa+3WtoHhuNh0Tc3LHYC
         R+Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVQ84Lx7ZrmTVcFxAJJJGCzAgT9Pi1V5px73VH0/5clG1zslQFjmsXngV4E4FqVXTNWdZZ7agyerbBsU7ZDA60=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR1ODTHPWvdaloJRv86n8U/dQusg96sBRjyF7436y3wiiGXMUz
	eMNfH8v7Pz3iOcY7/0CUI4TSNd5PWrjTyIGcYDavp0mjgKC+c0m2gOHNU5fHMO1zbdI0YubbLBx
	t3BTJljElrcL+gQ==
X-Google-Smtp-Source: AGHT+IFjHf53fSJAaoMvCAese1c2CReJLQvyP5+luooP4uX3A9bXodM94tdWMuD8m4gMAoe/7TUQGi6B8lf6sg==
X-Received: from pfwo11.prod.google.com ([2002:a05:6a00:1bcb:b0:7ae:55f2:2f4a])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3a20:b0:7ab:39a2:919b with SMTP id d2e1a72fcca58-7b7a48f5738mr4337298b3a.20.1762975390455;
 Wed, 12 Nov 2025 11:23:10 -0800 (PST)
Date: Wed, 12 Nov 2025 19:22:31 +0000
In-Reply-To: <20251112192232.442761-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112192232.442761-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251112192232.442761-18-dmatlack@google.com>
Subject: [PATCH v2 17/18] vfio: selftests: Eliminate INVALID_IOVA
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>, 
	David Matlack <dmatlack@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Raghavendra Rao Ananta <rananta@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Eliminate INVALID_IOVA as there are platforms where UINT64_MAX is a
valid iova.

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
2.52.0.rc1.455.g30608eb744-goog


