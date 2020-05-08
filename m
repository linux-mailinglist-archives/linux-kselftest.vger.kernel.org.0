Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557081CB81A
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 May 2020 21:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgEHTUY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 May 2020 15:20:24 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:12179 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgEHTUY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 May 2020 15:20:24 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eb5b0730000>; Fri, 08 May 2020 12:18:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 08 May 2020 12:20:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 08 May 2020 12:20:23 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 8 May
 2020 19:20:22 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 8 May 2020 19:20:21 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5eb5b0f50002>; Fri, 08 May 2020 12:20:21 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <nouveau@lists.freedesktop.org>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Ben Skeggs" <bskeggs@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@linuxfoundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH 1/6] nouveau/hmm: map pages after migration
Date:   Fri, 8 May 2020 12:20:04 -0700
Message-ID: <20200508192009.15302-2-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508192009.15302-1-rcampbell@nvidia.com>
References: <20200508192009.15302-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1588965491; bh=vLuVQ9M113BbmyP+rGSUUkFSbuwtcCONl7c0TMMZCiI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Type:Content-Transfer-Encoding;
        b=FPmKRoqsJcuAhRo1ALZxuRV0elsE6l1HxO6iH/ZoS8nbviHozYvtTitwhRWctD36W
         D0ISoVSjGu0B7KxaBL262CGKA3qmrKQfQ7CrO4eDgLJSN+EYRnwiBg0UvjZKiEhRHC
         tLOa3EqE8k6hxCiRlArC8QSwCe4RRdaOKRWG3jQy9vc1Goe+GDAPXCn1exWlFa0fJy
         DuUFcI55n7vAA7thSCThwyKqqhp1xyznbccszbNebOhdiZgvS5cXgeWgPDda/zFJ3+
         x0iXNOMyslqAptbz0oDJ7ZwOFBn+e/rvb8UBzbRhoOljD9ZtQd8pC1iNDfIczlu8l5
         XNrAKUt6tXY2Q==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When memory is migrated to the GPU, it is likely to be accessed by GPU
code soon afterwards. Instead of waiting for a GPU fault, map the
migrated memory into the GPU page tables with the same access permissions
as the source CPU page table entries. This preserves copy on write
semantics.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
Cc: Ben Skeggs <bskeggs@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c | 46 +++++++++++++-------
 drivers/gpu/drm/nouveau/nouveau_dmem.h |  2 +
 drivers/gpu/drm/nouveau/nouveau_svm.c  | 59 +++++++++++++++++++++++++-
 drivers/gpu/drm/nouveau/nouveau_svm.h  |  5 +++
 4 files changed, 95 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouve=
au/nouveau_dmem.c
index 3364904eccff..b29b01a56d07 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -25,12 +25,14 @@
 #include "nouveau_dma.h"
 #include "nouveau_mem.h"
 #include "nouveau_bo.h"
+#include "nouveau_svm.h"
=20
 #include <nvif/class.h>
 #include <nvif/object.h>
 #include <nvif/if000c.h>
 #include <nvif/if500b.h>
 #include <nvif/if900b.h>
+#include <nvif/if000c.h>
=20
 #include <linux/sched/mm.h>
 #include <linux/hmm.h>
@@ -561,10 +563,11 @@ nouveau_dmem_init(struct nouveau_drm *drm)
 }
=20
 static unsigned long nouveau_dmem_migrate_copy_one(struct nouveau_drm *drm=
,
-		unsigned long src, dma_addr_t *dma_addr)
+		unsigned long src, dma_addr_t *dma_addr, u64 *pfn)
 {
 	struct device *dev =3D drm->dev->dev;
 	struct page *dpage, *spage;
+	unsigned long paddr;
=20
 	spage =3D migrate_pfn_to_page(src);
 	if (!spage || !(src & MIGRATE_PFN_MIGRATE))
@@ -572,17 +575,21 @@ static unsigned long nouveau_dmem_migrate_copy_one(st=
ruct nouveau_drm *drm,
=20
 	dpage =3D nouveau_dmem_page_alloc_locked(drm);
 	if (!dpage)
-		return 0;
+		goto out;
=20
 	*dma_addr =3D dma_map_page(dev, spage, 0, PAGE_SIZE, DMA_BIDIRECTIONAL);
 	if (dma_mapping_error(dev, *dma_addr))
 		goto out_free_page;
=20
+	paddr =3D nouveau_dmem_page_addr(dpage);
 	if (drm->dmem->migrate.copy_func(drm, 1, NOUVEAU_APER_VRAM,
-			nouveau_dmem_page_addr(dpage), NOUVEAU_APER_HOST,
-			*dma_addr))
+			paddr, NOUVEAU_APER_HOST, *dma_addr))
 		goto out_dma_unmap;
=20
+	*pfn =3D NVIF_VMM_PFNMAP_V0_V | NVIF_VMM_PFNMAP_V0_VRAM |
+		((paddr >> PAGE_SHIFT) << NVIF_VMM_PFNMAP_V0_ADDR_SHIFT);
+	if (src & MIGRATE_PFN_WRITE)
+		*pfn |=3D NVIF_VMM_PFNMAP_V0_W;
 	return migrate_pfn(page_to_pfn(dpage)) | MIGRATE_PFN_LOCKED;
=20
 out_dma_unmap:
@@ -590,18 +597,20 @@ static unsigned long nouveau_dmem_migrate_copy_one(st=
ruct nouveau_drm *drm,
 out_free_page:
 	nouveau_dmem_page_free_locked(drm, dpage);
 out:
+	*pfn =3D NVIF_VMM_PFNMAP_V0_NONE;
 	return 0;
 }
=20
 static void nouveau_dmem_migrate_chunk(struct nouveau_drm *drm,
-		struct migrate_vma *args, dma_addr_t *dma_addrs)
+		struct nouveau_svmm *svmm, struct migrate_vma *args,
+		dma_addr_t *dma_addrs, u64 *pfns)
 {
 	struct nouveau_fence *fence;
 	unsigned long addr =3D args->start, nr_dma =3D 0, i;
=20
 	for (i =3D 0; addr < args->end; i++) {
 		args->dst[i] =3D nouveau_dmem_migrate_copy_one(drm, args->src[i],
-				dma_addrs + nr_dma);
+				dma_addrs + nr_dma, pfns + i);
 		if (args->dst[i])
 			nr_dma++;
 		addr +=3D PAGE_SIZE;
@@ -610,20 +619,18 @@ static void nouveau_dmem_migrate_chunk(struct nouveau=
_drm *drm,
 	nouveau_fence_new(drm->dmem->migrate.chan, false, &fence);
 	migrate_vma_pages(args);
 	nouveau_dmem_fence_done(&fence);
+	nouveau_pfns_map(svmm, args->vma->vm_mm, args->start, pfns, i);
=20
 	while (nr_dma--) {
 		dma_unmap_page(drm->dev->dev, dma_addrs[nr_dma], PAGE_SIZE,
 				DMA_BIDIRECTIONAL);
 	}
-	/*
-	 * FIXME optimization: update GPU page table to point to newly migrated
-	 * memory.
-	 */
 	migrate_vma_finalize(args);
 }
=20
 int
 nouveau_dmem_migrate_vma(struct nouveau_drm *drm,
+			 struct nouveau_svmm *svmm,
 			 struct vm_area_struct *vma,
 			 unsigned long start,
 			 unsigned long end)
@@ -635,7 +642,8 @@ nouveau_dmem_migrate_vma(struct nouveau_drm *drm,
 		.vma		=3D vma,
 		.start		=3D start,
 	};
-	unsigned long c, i;
+	unsigned long i;
+	u64 *pfns;
 	int ret =3D -ENOMEM;
=20
 	args.src =3D kcalloc(max, sizeof(*args.src), GFP_KERNEL);
@@ -649,19 +657,25 @@ nouveau_dmem_migrate_vma(struct nouveau_drm *drm,
 	if (!dma_addrs)
 		goto out_free_dst;
=20
-	for (i =3D 0; i < npages; i +=3D c) {
-		c =3D min(SG_MAX_SINGLE_ALLOC, npages);
-		args.end =3D start + (c << PAGE_SHIFT);
+	pfns =3D nouveau_pfns_alloc(max);
+	if (!pfns)
+		goto out_free_dma;
+
+	for (i =3D 0; i < npages; i +=3D max) {
+		args.end =3D start + (max << PAGE_SHIFT);
 		ret =3D migrate_vma_setup(&args);
 		if (ret)
-			goto out_free_dma;
+			goto out_free_pfns;
=20
 		if (args.cpages)
-			nouveau_dmem_migrate_chunk(drm, &args, dma_addrs);
+			nouveau_dmem_migrate_chunk(drm, svmm, &args, dma_addrs,
+						   pfns);
 		args.start =3D args.end;
 	}
=20
 	ret =3D 0;
+out_free_pfns:
+	nouveau_pfns_free(pfns);
 out_free_dma:
 	kfree(dma_addrs);
 out_free_dst:
diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.h b/drivers/gpu/drm/nouve=
au/nouveau_dmem.h
index db3b59b210af..64da5d3635c8 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.h
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.h
@@ -25,6 +25,7 @@
 struct drm_device;
 struct drm_file;
 struct nouveau_drm;
+struct nouveau_svmm;
 struct hmm_range;
=20
 #if IS_ENABLED(CONFIG_DRM_NOUVEAU_SVM)
@@ -34,6 +35,7 @@ void nouveau_dmem_suspend(struct nouveau_drm *);
 void nouveau_dmem_resume(struct nouveau_drm *);
=20
 int nouveau_dmem_migrate_vma(struct nouveau_drm *drm,
+			     struct nouveau_svmm *svmm,
 			     struct vm_area_struct *vma,
 			     unsigned long start,
 			     unsigned long end);
diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouvea=
u/nouveau_svm.c
index 407e34a5c0ab..22f054f7ee3e 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -70,6 +70,12 @@ struct nouveau_svm {
 #define SVM_DBG(s,f,a...) NV_DEBUG((s)->drm, "svm: "f"\n", ##a)
 #define SVM_ERR(s,f,a...) NV_WARN((s)->drm, "svm: "f"\n", ##a)
=20
+struct nouveau_pfnmap_args {
+	struct nvif_ioctl_v0 i;
+	struct nvif_ioctl_mthd_v0 m;
+	struct nvif_vmm_pfnmap_v0 p;
+};
+
 struct nouveau_ivmm {
 	struct nouveau_svmm *svmm;
 	u64 inst;
@@ -187,7 +193,8 @@ nouveau_svmm_bind(struct drm_device *dev, void *data,
 		addr =3D max(addr, vma->vm_start);
 		next =3D min(vma->vm_end, end);
 		/* This is a best effort so we ignore errors */
-		nouveau_dmem_migrate_vma(cli->drm, vma, addr, next);
+		nouveau_dmem_migrate_vma(cli->drm, cli->svm.svmm, vma, addr,
+					 next);
 		addr =3D next;
 	}
=20
@@ -814,6 +821,56 @@ nouveau_svm_fault(struct nvif_notify *notify)
 	return NVIF_NOTIFY_KEEP;
 }
=20
+static struct nouveau_pfnmap_args *
+nouveau_pfns_to_args(void *pfns)
+{
+	return container_of(pfns, struct nouveau_pfnmap_args, p.phys);
+}
+
+u64 *
+nouveau_pfns_alloc(unsigned long npages)
+{
+	struct nouveau_pfnmap_args *args;
+
+	args =3D kzalloc(struct_size(args, p.phys, npages), GFP_KERNEL);
+	if (!args)
+		return NULL;
+
+	args->i.type =3D NVIF_IOCTL_V0_MTHD;
+	args->m.method =3D NVIF_VMM_V0_PFNMAP;
+	args->p.page =3D PAGE_SHIFT;
+
+	return args->p.phys;
+}
+
+void
+nouveau_pfns_free(u64 *pfns)
+{
+	struct nouveau_pfnmap_args *args =3D nouveau_pfns_to_args(pfns);
+
+	kfree(args);
+}
+
+void
+nouveau_pfns_map(struct nouveau_svmm *svmm, struct mm_struct *mm,
+		 unsigned long addr, u64 *pfns, unsigned long npages)
+{
+	struct nouveau_pfnmap_args *args =3D nouveau_pfns_to_args(pfns);
+	int ret;
+
+	args->p.addr =3D addr;
+	args->p.size =3D npages << PAGE_SHIFT;
+
+	mutex_lock(&svmm->mutex);
+
+	svmm->vmm->vmm.object.client->super =3D true;
+	ret =3D nvif_object_ioctl(&svmm->vmm->vmm.object, args, sizeof(*args) +
+				npages * sizeof(args->p.phys[0]), NULL);
+	svmm->vmm->vmm.object.client->super =3D false;
+
+	mutex_unlock(&svmm->mutex);
+}
+
 static void
 nouveau_svm_fault_buffer_fini(struct nouveau_svm *svm, int id)
 {
diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.h b/drivers/gpu/drm/nouvea=
u/nouveau_svm.h
index e839d8189461..f0fcd1b72e8b 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.h
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.h
@@ -18,6 +18,11 @@ void nouveau_svmm_fini(struct nouveau_svmm **);
 int nouveau_svmm_join(struct nouveau_svmm *, u64 inst);
 void nouveau_svmm_part(struct nouveau_svmm *, u64 inst);
 int nouveau_svmm_bind(struct drm_device *, void *, struct drm_file *);
+
+u64 *nouveau_pfns_alloc(unsigned long npages);
+void nouveau_pfns_free(u64 *pfns);
+void nouveau_pfns_map(struct nouveau_svmm *svmm, struct mm_struct *mm,
+		      unsigned long addr, u64 *pfns, unsigned long npages);
 #else /* IS_ENABLED(CONFIG_DRM_NOUVEAU_SVM) */
 static inline void nouveau_svm_init(struct nouveau_drm *drm) {}
 static inline void nouveau_svm_fini(struct nouveau_drm *drm) {}
--=20
2.20.1

