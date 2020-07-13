Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2807E21DE7C
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jul 2020 19:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbgGMRWJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jul 2020 13:22:09 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17663 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbgGMRWI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jul 2020 13:22:08 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0c98070001>; Mon, 13 Jul 2020 10:21:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 Jul 2020 10:22:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 Jul 2020 10:22:08 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 Jul
 2020 17:22:01 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 13 Jul 2020 17:22:01 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f0c98380003>; Mon, 13 Jul 2020 10:22:00 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        <nouveau@lists.freedesktop.org>, <kvm-ppc@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "Ben Skeggs" <bskeggs@redhat.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        "Ralph Campbell" <rcampbell@nvidia.com>
Subject: [PATCH v2 4/5] nouveau/svm: use the new migration invalidation
Date:   Mon, 13 Jul 2020 10:21:48 -0700
Message-ID: <20200713172149.2310-5-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200713172149.2310-1-rcampbell@nvidia.com>
References: <20200713172149.2310-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594660871; bh=Otn21fbrlotjCIOeaNWRTeP+Kh/XYMo4ARZTNQnvhww=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=Syu1yy0970L8A2g9NlvIGxzAFkuUW5LVJClRjNZY9ynf5FP4oXilfjNxAvfomlB3/
         NwaefpgpWIMgVVm9rzXuoK4D9Rf6lyDjr3zdlSX7apuJ13xvb0BxyIfrEpmnLiAaH1
         Oy7vPsfaNBZga1dDNnFQL0YPszsYW2A/Y8IX8uw7fjJQGgqwSAizGNP+5/vwPsIZiW
         gTeU3Ktc8rM02koYiushk3QEmoS6N1/MHvQ6Wb+mE3Y5upkmBqGdIzVlbbNUKu5xeM
         fxMJFD7Mb98qY4UG1iQOECjtCcTAG4U1uu909OLqp4OO8p9dvCxjZgfWY3eFrnwgTN
         0BIpNrQuY2KFg==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use the new MMU_NOTIFY_MIGRATE event to skip GPU MMU invalidations of
device private memory and handle the invalidation in the driver as part
of migrating device private memory.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c | 11 ++++++++---
 drivers/gpu/drm/nouveau/nouveau_svm.c  | 10 +++++++++-
 drivers/gpu/drm/nouveau/nouveau_svm.h  |  1 +
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouve=
au/nouveau_dmem.c
index e5c83b8ee82e..8f2683ebd8c0 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -154,6 +154,8 @@ static vm_fault_t nouveau_dmem_fault_copy_one(struct no=
uveau_drm *drm,
 	if (dma_mapping_error(dev, *dma_addr))
 		goto error_free_page;
=20
+	nouveau_svmm_invalidate(spage->zone_device_data, args->start,
+				args->end);
 	if (drm->dmem->migrate.copy_func(drm, 1, NOUVEAU_APER_HOST, *dma_addr,
 			NOUVEAU_APER_VRAM, nouveau_dmem_page_addr(spage)))
 		goto error_dma_unmap;
@@ -531,7 +533,8 @@ nouveau_dmem_init(struct nouveau_drm *drm)
 }
=20
 static unsigned long nouveau_dmem_migrate_copy_one(struct nouveau_drm *drm=
,
-		unsigned long src, dma_addr_t *dma_addr, u64 *pfn)
+		struct nouveau_svmm *svmm, unsigned long src,
+		dma_addr_t *dma_addr, u64 *pfn)
 {
 	struct device *dev =3D drm->dev->dev;
 	struct page *dpage, *spage;
@@ -561,6 +564,7 @@ static unsigned long nouveau_dmem_migrate_copy_one(stru=
ct nouveau_drm *drm,
 			goto out_free_page;
 	}
=20
+	dpage->zone_device_data =3D svmm;
 	*pfn =3D NVIF_VMM_PFNMAP_V0_V | NVIF_VMM_PFNMAP_V0_VRAM |
 		((paddr >> PAGE_SHIFT) << NVIF_VMM_PFNMAP_V0_ADDR_SHIFT);
 	if (src & MIGRATE_PFN_WRITE)
@@ -584,8 +588,8 @@ static void nouveau_dmem_migrate_chunk(struct nouveau_d=
rm *drm,
 	unsigned long addr =3D args->start, nr_dma =3D 0, i;
=20
 	for (i =3D 0; addr < args->end; i++) {
-		args->dst[i] =3D nouveau_dmem_migrate_copy_one(drm, args->src[i],
-				dma_addrs + nr_dma, pfns + i);
+		args->dst[i] =3D nouveau_dmem_migrate_copy_one(drm, svmm,
+				args->src[i], dma_addrs + nr_dma, pfns + i);
 		if (!dma_mapping_error(drm->dev->dev, dma_addrs[nr_dma]))
 			nr_dma++;
 		addr +=3D PAGE_SIZE;
@@ -616,6 +620,7 @@ nouveau_dmem_migrate_vma(struct nouveau_drm *drm,
 	struct migrate_vma args =3D {
 		.vma		=3D vma,
 		.start		=3D start,
+		.src_owner	=3D drm->dev,
 		.dir		=3D MIGRATE_VMA_FROM_SYSTEM,
 	};
 	unsigned long i;
diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouvea=
u/nouveau_svm.c
index c5f8ca6fb2e3..2ba7a8a2348c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -246,7 +246,7 @@ nouveau_svmm_join(struct nouveau_svmm *svmm, u64 inst)
 }
=20
 /* Invalidate SVMM address-range on GPU. */
-static void
+void
 nouveau_svmm_invalidate(struct nouveau_svmm *svmm, u64 start, u64 limit)
 {
 	if (limit > start) {
@@ -279,6 +279,14 @@ nouveau_svmm_invalidate_range_start(struct mmu_notifie=
r *mn,
 	if (unlikely(!svmm->vmm))
 		goto out;
=20
+	/*
+	 * Ignore invalidation callbacks for device private pages since
+	 * the invalidation is handled as part of the migration process.
+	 */
+	if (update->event =3D=3D MMU_NOTIFY_MIGRATE &&
+	    update->migrate_pgmap_owner =3D=3D svmm->vmm->cli->drm->dev)
+		goto out;
+
 	if (limit > svmm->unmanaged.start && start < svmm->unmanaged.limit) {
 		if (start < svmm->unmanaged.start) {
 			nouveau_svmm_invalidate(svmm, start,
diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.h b/drivers/gpu/drm/nouvea=
u/nouveau_svm.h
index f0fcd1b72e8b..bb2d56e50e0c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.h
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.h
@@ -19,6 +19,7 @@ int nouveau_svmm_join(struct nouveau_svmm *, u64 inst);
 void nouveau_svmm_part(struct nouveau_svmm *, u64 inst);
 int nouveau_svmm_bind(struct drm_device *, void *, struct drm_file *);
=20
+void nouveau_svmm_invalidate(struct nouveau_svmm *svmm, u64 start, u64 lim=
it);
 u64 *nouveau_pfns_alloc(unsigned long npages);
 void nouveau_pfns_free(u64 *pfns);
 void nouveau_pfns_map(struct nouveau_svmm *svmm, struct mm_struct *mm,
--=20
2.20.1

