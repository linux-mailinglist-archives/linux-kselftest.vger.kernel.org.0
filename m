Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9DC21CB826
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 May 2020 21:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbgEHTUh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 May 2020 15:20:37 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:12213 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbgEHTU3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 May 2020 15:20:29 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eb5b0780000>; Fri, 08 May 2020 12:18:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 08 May 2020 12:20:28 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 08 May 2020 12:20:28 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 8 May
 2020 19:20:27 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 8 May 2020 19:20:27 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5eb5b0fa0001>; Fri, 08 May 2020 12:20:26 -0700
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
Subject: [PATCH 5/6] nouveau/hmm: support mapping large sysmem pages
Date:   Fri, 8 May 2020 12:20:08 -0700
Message-ID: <20200508192009.15302-6-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508192009.15302-1-rcampbell@nvidia.com>
References: <20200508192009.15302-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1588965496; bh=uWd7myPPlR4BFACF6z0QTf8ike3cmNHZeCfKWnNxqso=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=GMZsQshNz0qq4WNe8J6+4ssl3jDJjZicTxgjjhdzj/+0KqYjT4dHuwTil/9J9lXSD
         CvgnbMg5ioasutg3zXKP9XfGCmBUY3cMzADG9iiVU5uFKDI+BLpDDedXFDzgrXTXo6
         C3+Che2CmlsZtd7gKL0FGoCC8h4AjfRONXyxCOQMDGjeBPNGRjl74tv9WvgUlvOyya
         WVaP7Aos0dX6nymJuX8SejrE8u5OLT7gNMYmlsGLohieFapuFvUfbUSSOenxEEblWv
         FHK5OYTc9weeV9yJdtpp86nqLwY7XPkI+9VXFRp4eXojfIURP+FLCoUXC6lJpULm0/
         MsX0PCtvCg9fQ==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Nouveau currently only supports mapping PAGE_SIZE sized pages of system
memory when shared virtual memory (SVM) is enabled. Use the new
HMM_PFN_COMPOUND flag that hmm_range_fault() returns to support mapping
system memory pages larger than PAGE_SIZE.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c         | 47 ++++++++++++++-----
 .../gpu/drm/nouveau/nvkm/subdev/mmu/base.c    |  4 ++
 .../gpu/drm/nouveau/nvkm/subdev/mmu/priv.h    |  2 +
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c |  8 ++--
 .../drm/nouveau/nvkm/subdev/mmu/vmmgp100.c    | 29 ++++++++----
 5 files changed, 66 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouvea=
u/nouveau_svm.c
index a87b9347d6ce..f9892e71a960 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -514,38 +514,51 @@ static const struct mmu_interval_notifier_ops nouveau=
_svm_mni_ops =3D {
 };
=20
 static void nouveau_hmm_convert_pfn(struct nouveau_drm *drm,
-				    struct hmm_range *range, u64 *ioctl_addr)
+				    struct hmm_range *range,
+				    struct nouveau_pfnmap_args *args)
 {
 	struct page *page;
=20
 	/*
-	 * The ioctl_addr prepared here is passed through nvif_object_ioctl()
+	 * The address prepared here is passed through nvif_object_ioctl()
 	 * to an eventual DMA map in something like gp100_vmm_pgt_pfn()
 	 *
 	 * This is all just encoding the internal hmm representation into a
 	 * different nouveau internal representation.
 	 */
 	if (!(range->hmm_pfns[0] & HMM_PFN_VALID)) {
-		ioctl_addr[0] =3D 0;
+		args->p.phys[0] =3D 0;
 		return;
 	}
=20
 	page =3D hmm_pfn_to_page(range->hmm_pfns[0]);
+	/*
+	 * Only map compound pages to the GPU if the CPU is also mapping the
+	 * page as a compound page. Otherwise, the PTE protections might not be
+	 * consistent (i.e., CPU only maps part of a compound page).
+	 */
+	if (range->hmm_pfns[0] & HMM_PFN_COMPOUND) {
+		page =3D compound_head(page);
+		args->p.page =3D page_shift(page);
+		args->p.size =3D 1UL << args->p.page;
+		args->p.addr &=3D ~(args->p.size - 1);
+	}
 	if (is_device_private_page(page))
-		ioctl_addr[0] =3D nouveau_dmem_page_addr(page) |
+		args->p.phys[0] =3D nouveau_dmem_page_addr(page) |
 				NVIF_VMM_PFNMAP_V0_V |
 				NVIF_VMM_PFNMAP_V0_VRAM;
 	else
-		ioctl_addr[0] =3D page_to_phys(page) |
+		args->p.phys[0] =3D page_to_phys(page) |
 				NVIF_VMM_PFNMAP_V0_V |
 				NVIF_VMM_PFNMAP_V0_HOST;
 	if (range->hmm_pfns[0] & HMM_PFN_WRITE)
-		ioctl_addr[0] |=3D NVIF_VMM_PFNMAP_V0_W;
+		args->p.phys[0] |=3D NVIF_VMM_PFNMAP_V0_W;
 }
=20
 static int nouveau_range_fault(struct nouveau_svmm *svmm,
-			       struct nouveau_drm *drm, void *data, u32 size,
-			       u64 *ioctl_addr, unsigned long hmm_flags,
+			       struct nouveau_drm *drm,
+			       struct nouveau_pfnmap_args *args, u32 size,
+			       unsigned long hmm_flags,
 			       struct svm_notifier *notifier)
 {
 	unsigned long timeout =3D
@@ -585,10 +598,10 @@ static int nouveau_range_fault(struct nouveau_svmm *s=
vmm,
 		break;
 	}
=20
-	nouveau_hmm_convert_pfn(drm, &range, ioctl_addr);
+	nouveau_hmm_convert_pfn(drm, &range, args);
=20
 	svmm->vmm->vmm.object.client->super =3D true;
-	ret =3D nvif_object_ioctl(&svmm->vmm->vmm.object, data, size, NULL);
+	ret =3D nvif_object_ioctl(&svmm->vmm->vmm.object, args, size, NULL);
 	svmm->vmm->vmm.object.client->super =3D false;
 	mutex_unlock(&svmm->mutex);
=20
@@ -716,12 +729,13 @@ nouveau_svm_fault(struct nvif_notify *notify)
 						   args.i.p.addr, args.i.p.size,
 						   &nouveau_svm_mni_ops);
 		if (!ret) {
-			ret =3D nouveau_range_fault(svmm, svm->drm, &args,
-				sizeof(args), args.phys, hmm_flags, &notifier);
+			ret =3D nouveau_range_fault(svmm, svm->drm, &args.i,
+				sizeof(args), hmm_flags, &notifier);
 			mmu_interval_notifier_remove(&notifier.notifier);
 		}
 		mmput(mm);
=20
+		limit =3D args.i.p.addr + args.i.p.size;
 		for (fn =3D fi; ++fn < buffer->fault_nr; ) {
 			/* It's okay to skip over duplicate addresses from the
 			 * same SVMM as faults are ordered by access type such
@@ -729,9 +743,16 @@ nouveau_svm_fault(struct nvif_notify *notify)
 			 *
 			 * ie. WRITE faults appear first, thus any handling of
 			 * pending READ faults will already be satisfied.
+			 * But if a large page is mapped, make sure subsequent
+			 * fault addresses have sufficient access permission.
 			 */
 			if (buffer->fault[fn]->svmm !=3D svmm ||
-			    buffer->fault[fn]->addr >=3D limit)
+			    buffer->fault[fn]->addr >=3D limit ||
+			    (buffer->fault[fi]->access =3D=3D 0 /* READ. */ &&
+			     !(args.phys[0] & NVIF_VMM_PFNMAP_V0_V)) ||
+			    (buffer->fault[fi]->access !=3D 0 /* READ. */ &&
+			     buffer->fault[fi]->access !=3D 3 /* PREFETCH. */ &&
+			     !(args.phys[0] & NVIF_VMM_PFNMAP_V0_W)))
 				break;
 		}
=20
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/base.c b/drivers/gpu/d=
rm/nouveau/nvkm/subdev/mmu/base.c
index de91e9a26172..ecea365d72ad 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/base.c
@@ -94,6 +94,8 @@ nvkm_mmu_ptp_get(struct nvkm_mmu *mmu, u32 size, bool zer=
o)
 	}
 	pt->ptp =3D ptp;
 	pt->sub =3D true;
+	pt->ptei_shift =3D 3;
+	pt->page_shift =3D PAGE_SHIFT;
=20
 	/* Sub-allocate from parent object, removing PTP from cache
 	 * if there's no more free slots left.
@@ -203,6 +205,8 @@ nvkm_mmu_ptc_get(struct nvkm_mmu *mmu, u32 size, u32 al=
ign, bool zero)
 		return NULL;
 	pt->ptc =3D ptc;
 	pt->sub =3D false;
+	pt->ptei_shift =3D 3;
+	pt->page_shift =3D PAGE_SHIFT;
=20
 	ret =3D nvkm_memory_new(mmu->subdev.device, NVKM_MEM_TARGET_INST,
 			      size, align, zero, &pt->memory);
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/priv.h b/drivers/gpu/d=
rm/nouveau/nvkm/subdev/mmu/priv.h
index 479b02344271..f2162bb35bea 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/priv.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/priv.h
@@ -55,6 +55,8 @@ struct nvkm_mmu_pt {
 	struct nvkm_memory *memory;
 	bool sub;
 	u16 base;
+	u8 ptei_shift;
+	u8 page_shift;
 	u64 addr;
 	struct list_head head;
 };
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c b/drivers/gpu/dr=
m/nouveau/nvkm/subdev/mmu/vmm.c
index 67b00dcef4b8..c7581f4f313e 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
@@ -562,6 +562,9 @@ nvkm_vmm_iter(struct nvkm_vmm *vmm, const struct nvkm_v=
mm_page *page,
 		/* Handle PTE updates. */
 		if (!REF_PTES || REF_PTES(&it, pfn, ptei, ptes)) {
 			struct nvkm_mmu_pt *pt =3D pgt->pt[type];
+
+			pt->page_shift =3D page->shift;
+			pt->ptei_shift =3D ilog2(desc->size);
 			if (MAP_PTES || CLR_PTES) {
 				if (MAP_PTES)
 					MAP_PTES(vmm, pt, ptei, ptes, map);
@@ -1204,7 +1207,6 @@ nvkm_vmm_pfn_unmap(struct nvkm_vmm *vmm, u64 addr, u6=
4 size)
 /*TODO:
  * - Avoid PT readback (for dma_unmap etc), this might end up being dealt
  *   with inside HMM, which would be a lot nicer for us to deal with.
- * - Multiple page sizes (particularly for huge page support).
  * - Support for systems without a 4KiB page size.
  */
 int
@@ -1220,8 +1222,8 @@ nvkm_vmm_pfn_map(struct nvkm_vmm *vmm, u8 shift, u64 =
addr, u64 size, u64 *pfn)
 	/* Only support mapping where the page size of the incoming page
 	 * array matches a page size available for direct mapping.
 	 */
-	while (page->shift && page->shift !=3D shift &&
-	       page->desc->func->pfn =3D=3D NULL)
+	while (page->shift && (page->shift !=3D shift ||
+	       page->desc->func->pfn =3D=3D NULL))
 		page++;
=20
 	if (!page->shift || !IS_ALIGNED(addr, 1ULL << shift) ||
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c b/drivers/g=
pu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c
index d86287565542..94507cb2cf75 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c
@@ -39,12 +39,15 @@ gp100_vmm_pfn_unmap(struct nvkm_vmm *vmm,
=20
 	nvkm_kmap(pt->memory);
 	while (ptes--) {
-		u32 datalo =3D nvkm_ro32(pt->memory, pt->base + ptei * 8 + 0);
-		u32 datahi =3D nvkm_ro32(pt->memory, pt->base + ptei * 8 + 4);
+		u32 datalo =3D nvkm_ro32(pt->memory,
+				       pt->base + (ptei << pt->ptei_shift) + 0);
+		u32 datahi =3D nvkm_ro32(pt->memory,
+				       pt->base + (ptei << pt->ptei_shift) + 4);
 		u64 data   =3D (u64)datahi << 32 | datalo;
 		if ((data & (3ULL << 1)) !=3D 0) {
 			addr =3D (data >> 8) << 12;
-			dma_unmap_page(dev, addr, PAGE_SIZE, DMA_BIDIRECTIONAL);
+			dma_unmap_page(dev, addr, 1UL << pt->page_shift,
+					DMA_BIDIRECTIONAL);
 		}
 		ptei++;
 	}
@@ -58,11 +61,14 @@ gp100_vmm_pfn_clear(struct nvkm_vmm *vmm,
 	bool dma =3D false;
 	nvkm_kmap(pt->memory);
 	while (ptes--) {
-		u32 datalo =3D nvkm_ro32(pt->memory, pt->base + ptei * 8 + 0);
-		u32 datahi =3D nvkm_ro32(pt->memory, pt->base + ptei * 8 + 4);
+		u32 datalo =3D nvkm_ro32(pt->memory,
+				       pt->base + (ptei << pt->ptei_shift) + 0);
+		u32 datahi =3D nvkm_ro32(pt->memory,
+				       pt->base + (ptei << pt->ptei_shift) + 4);
 		u64 data   =3D (u64)datahi << 32 | datalo;
 		if ((data & BIT_ULL(0)) && (data & (3ULL << 1)) !=3D 0) {
-			VMM_WO064(pt, vmm, ptei * 8, data & ~BIT_ULL(0));
+			VMM_WO064(pt, vmm, ptei << pt->ptei_shift,
+				  data & ~BIT_ULL(0));
 			dma =3D true;
 		}
 		ptei++;
@@ -87,7 +93,8 @@ gp100_vmm_pgt_pfn(struct nvkm_vmm *vmm, struct nvkm_mmu_p=
t *pt,
 		if (!(*map->pfn & NVKM_VMM_PFN_VRAM)) {
 			addr =3D *map->pfn >> NVKM_VMM_PFN_ADDR_SHIFT;
 			addr =3D dma_map_page(dev, pfn_to_page(addr), 0,
-					    PAGE_SIZE, DMA_BIDIRECTIONAL);
+					    1UL << pt->page_shift,
+					    DMA_BIDIRECTIONAL);
 			if (!WARN_ON(dma_mapping_error(dev, addr))) {
 				data |=3D addr >> 4;
 				data |=3D 2ULL << 1; /* SYSTEM_COHERENT_MEMORY. */
@@ -99,7 +106,7 @@ gp100_vmm_pgt_pfn(struct nvkm_vmm *vmm, struct nvkm_mmu_=
pt *pt,
 			data |=3D BIT_ULL(0); /* VALID. */
 		}
=20
-		VMM_WO064(pt, vmm, ptei++ * 8, data);
+		VMM_WO064(pt, vmm, ptei++ << pt->ptei_shift, data);
 		map->pfn++;
 	}
 	nvkm_done(pt->memory);
@@ -264,6 +271,9 @@ gp100_vmm_desc_pd0 =3D {
 	.sparse =3D gp100_vmm_pd0_sparse,
 	.pde =3D gp100_vmm_pd0_pde,
 	.mem =3D gp100_vmm_pd0_mem,
+	.pfn =3D gp100_vmm_pgt_pfn,
+	.pfn_clear =3D gp100_vmm_pfn_clear,
+	.pfn_unmap =3D gp100_vmm_pfn_unmap,
 };
=20
 static void
@@ -286,6 +296,9 @@ gp100_vmm_desc_pd1 =3D {
 	.unmap =3D gf100_vmm_pgt_unmap,
 	.sparse =3D gp100_vmm_pgt_sparse,
 	.pde =3D gp100_vmm_pd1_pde,
+	.pfn =3D gp100_vmm_pgt_pfn,
+	.pfn_clear =3D gp100_vmm_pfn_clear,
+	.pfn_unmap =3D gp100_vmm_pfn_unmap,
 };
=20
 const struct nvkm_vmm_desc
--=20
2.20.1

