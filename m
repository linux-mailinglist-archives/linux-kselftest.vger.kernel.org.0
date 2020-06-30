Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBD120FD3B
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jun 2020 21:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgF3T6g (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Jun 2020 15:58:36 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19065 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728878AbgF3T6Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Jun 2020 15:58:16 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efb994b0002>; Tue, 30 Jun 2020 12:58:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 30 Jun 2020 12:58:16 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 30 Jun 2020 12:58:16 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jun
 2020 19:58:07 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 30 Jun 2020 19:58:07 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5efb994f0005>; Tue, 30 Jun 2020 12:58:07 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        <nouveau@lists.freedesktop.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "Ben Skeggs" <bskeggs@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH v2 4/5] nouveau/hmm: support mapping large sysmem pages
Date:   Tue, 30 Jun 2020 12:57:36 -0700
Message-ID: <20200630195737.8667-5-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200630195737.8667-1-rcampbell@nvidia.com>
References: <20200630195737.8667-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593547083; bh=7qlIBxbPrc7M3JXyfs1Htqr6J6ShZakoC7ZHT1YKlL8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=a2zWMBsDgWIHEcX+M/I5wg93dCADlyviRBsZwFMCENdVWSRZpx0oGj0aHqtzoqy65
         oEQ2XmoR/VrVpPIufHUI4YcRNM4w1ZR4G4gAQN7hsLx5NoRa9s+SR/JUhdku/moADT
         E2LdXrOG7hBdd8jdNKkiGJLEXSezbp5RB2px0wgmWQ2/Ec07HYsVeKGARQ7PFhihqR
         fluehRmUmTJQmnL0pWkKMw4kH4ZOP3iIjSL+46a4vT2v+h2T9hE45hHCkCzTkZQlKo
         OxzrSQQLXWLI1iHr+qjddK9/TTM4ZR4cFHVKxTPP4IwoPTwh10rg6OL2Kktgj9jEwU
         Az0YWiKgVK1Ug==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Nouveau currently only supports mapping PAGE_SIZE sized pages of system
memory when shared virtual memory (SVM) is enabled. Use the new
HMM_PFN_PMD flag that hmm_range_fault() returns to support mapping
system memory pages that are PMD_SIZE.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 57 +++++++++++++++++++++------
 1 file changed, 44 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouvea=
u/nouveau_svm.c
index 665dede69bd1..891b6a180447 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -514,38 +514,61 @@ static const struct mmu_interval_notifier_ops nouveau=
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
+	 * consistent (e.g., CPU only maps part of a compound page).
+	 * Note that the underlying page might still be larger than the
+	 * CPU mapping (e.g., a PUD sized compound page partially mapped with
+	 * a PMD sized page table entry).
+	 */
+	if (range->hmm_pfns[0] & (HMM_PFN_PMD | HMM_PFN_PUD)) {
+		unsigned long addr =3D args->p.addr;
+
+		/*
+		 * For now, only map using PMD sized pages.
+		 * FIXME: need to handle 512MB GPU PTEs with 1GB PUD sized
+		 * pages.
+		 */
+		args->p.page =3D PMD_SHIFT;
+		args->p.size =3D 1UL << args->p.page;
+		args->p.addr &=3D ~(args->p.size - 1);
+		page -=3D (addr - args->p.addr) >> PAGE_SHIFT;
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
@@ -585,10 +608,10 @@ static int nouveau_range_fault(struct nouveau_svmm *s=
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
@@ -717,12 +740,13 @@ nouveau_svm_fault(struct nvif_notify *notify)
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
@@ -730,9 +754,16 @@ nouveau_svm_fault(struct nvif_notify *notify)
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
--=20
2.20.1

