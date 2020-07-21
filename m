Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B3E228B5F
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jul 2020 23:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731269AbgGUVbe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Jul 2020 17:31:34 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:16128 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731245AbgGUVbd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Jul 2020 17:31:33 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f175e770000>; Tue, 21 Jul 2020 14:30:31 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 21 Jul 2020 14:31:33 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 21 Jul 2020 14:31:33 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 Jul
 2020 21:31:26 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 21 Jul 2020 21:31:26 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f175ead0005>; Tue, 21 Jul 2020 14:31:25 -0700
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
Subject: [PATCH v3 4/5] nouveau/svm: use the new migration invalidation
Date:   Tue, 21 Jul 2020 14:31:18 -0700
Message-ID: <20200721213119.32344-5-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200721213119.32344-1-rcampbell@nvidia.com>
References: <20200721213119.32344-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595367031; bh=inLsVikJBBkWjiEyE8zRFI/DuD2s6zsmXcBd/dKKSw0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=A3lJbrs8bHjXhmqalJD7gP0tT5gkxdjBQQhzW2AbYqvv3csj9f1FQJGvEV9XqPNwh
         OMNG2TKQz7XNSttd2ZCdBtpoFwMSQmYcUVU5Agf72SlZx9nKnFctvZGuq4FMAQ9bzX
         IGwMADuciJwmbjU41feyegY72yKmEqt6LVcpZYLI6L78F7pdauR913oKPpbak9u8XX
         2vtiOe/0fJKkoOi/02+UGthJamKxvbpz5iPluWUsZbP7ldfTYWxkm04kyF+rg5LG6e
         jtYFuCpnDFCiqyaz65s+DQBppE0JeZLW7122l61+ArBEYFkHFxM68f3V8bxCy9WaPj
         mVWqNabg118iw==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use the new MMU_NOTIFY_MIGRATE event to skip GPU MMU invalidations of
device private memory and handle the invalidation in the driver as part
of migrating device private memory.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c | 15 ++++++++++++---
 drivers/gpu/drm/nouveau/nouveau_svm.c  | 21 +++++++++------------
 drivers/gpu/drm/nouveau/nouveau_svm.h  | 13 ++++++++++++-
 3 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouve=
au/nouveau_dmem.c
index 78b9e3c2a5b3..511fe04cd680 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -140,6 +140,7 @@ static vm_fault_t nouveau_dmem_fault_copy_one(struct no=
uveau_drm *drm,
 {
 	struct device *dev =3D drm->dev->dev;
 	struct page *dpage, *spage;
+	struct nouveau_svmm *svmm;
=20
 	spage =3D migrate_pfn_to_page(args->src[0]);
 	if (!spage || !(args->src[0] & MIGRATE_PFN_MIGRATE))
@@ -154,14 +155,19 @@ static vm_fault_t nouveau_dmem_fault_copy_one(struct =
nouveau_drm *drm,
 	if (dma_mapping_error(dev, *dma_addr))
 		goto error_free_page;
=20
+	svmm =3D spage->zone_device_data;
+	mutex_lock(&svmm->mutex);
+	nouveau_svmm_invalidate(svmm, args->start, args->end);
 	if (drm->dmem->migrate.copy_func(drm, 1, NOUVEAU_APER_HOST, *dma_addr,
 			NOUVEAU_APER_VRAM, nouveau_dmem_page_addr(spage)))
 		goto error_dma_unmap;
+	mutex_unlock(&svmm->mutex);
=20
 	args->dst[0] =3D migrate_pfn(page_to_pfn(dpage)) | MIGRATE_PFN_LOCKED;
 	return 0;
=20
 error_dma_unmap:
+	mutex_unlock(&svmm->mutex);
 	dma_unmap_page(dev, *dma_addr, PAGE_SIZE, DMA_BIDIRECTIONAL);
 error_free_page:
 	__free_page(dpage);
@@ -531,7 +537,8 @@ nouveau_dmem_init(struct nouveau_drm *drm)
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
@@ -561,6 +568,7 @@ static unsigned long nouveau_dmem_migrate_copy_one(stru=
ct nouveau_drm *drm,
 			goto out_free_page;
 	}
=20
+	dpage->zone_device_data =3D svmm;
 	*pfn =3D NVIF_VMM_PFNMAP_V0_V | NVIF_VMM_PFNMAP_V0_VRAM |
 		((paddr >> PAGE_SHIFT) << NVIF_VMM_PFNMAP_V0_ADDR_SHIFT);
 	if (src & MIGRATE_PFN_WRITE)
@@ -584,8 +592,8 @@ static void nouveau_dmem_migrate_chunk(struct nouveau_d=
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
@@ -616,6 +624,7 @@ nouveau_dmem_migrate_vma(struct nouveau_drm *drm,
 	struct migrate_vma args =3D {
 		.vma		=3D vma,
 		.start		=3D start,
+		.pgmap_owner	=3D drm->dev,
 		.flags		=3D MIGRATE_VMA_SELECT_SYSTEM,
 	};
 	unsigned long i;
diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouvea=
u/nouveau_svm.c
index c5f8ca6fb2e3..67b068ac57b2 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -93,17 +93,6 @@ nouveau_ivmm_find(struct nouveau_svm *svm, u64 inst)
 	return NULL;
 }
=20
-struct nouveau_svmm {
-	struct mmu_notifier notifier;
-	struct nouveau_vmm *vmm;
-	struct {
-		unsigned long start;
-		unsigned long limit;
-	} unmanaged;
-
-	struct mutex mutex;
-};
-
 #define SVMM_DBG(s,f,a...)                                                =
     \
 	NV_DEBUG((s)->vmm->cli->drm, "svm-%p: "f"\n", (s), ##a)
 #define SVMM_ERR(s,f,a...)                                                =
     \
@@ -246,7 +235,7 @@ nouveau_svmm_join(struct nouveau_svmm *svmm, u64 inst)
 }
=20
 /* Invalidate SVMM address-range on GPU. */
-static void
+void
 nouveau_svmm_invalidate(struct nouveau_svmm *svmm, u64 start, u64 limit)
 {
 	if (limit > start) {
@@ -279,6 +268,14 @@ nouveau_svmm_invalidate_range_start(struct mmu_notifie=
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
index f0fcd1b72e8b..e7d63d7f0c2d 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.h
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.h
@@ -1,11 +1,21 @@
 #ifndef __NOUVEAU_SVM_H__
 #define __NOUVEAU_SVM_H__
 #include <nvif/os.h>
+#include <linux/mmu_notifier.h>
 struct drm_device;
 struct drm_file;
 struct nouveau_drm;
=20
-struct nouveau_svmm;
+struct nouveau_svmm {
+	struct mmu_notifier notifier;
+	struct nouveau_vmm *vmm;
+	struct {
+		unsigned long start;
+		unsigned long limit;
+	} unmanaged;
+
+	struct mutex mutex;
+};
=20
 #if IS_ENABLED(CONFIG_DRM_NOUVEAU_SVM)
 void nouveau_svm_init(struct nouveau_drm *);
@@ -19,6 +29,7 @@ int nouveau_svmm_join(struct nouveau_svmm *, u64 inst);
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

