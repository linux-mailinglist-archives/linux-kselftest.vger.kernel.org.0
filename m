Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B02120FD32
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jun 2020 21:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgF3T6Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Jun 2020 15:58:16 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4434 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbgF3T6Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Jun 2020 15:58:16 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efb98f40000>; Tue, 30 Jun 2020 12:56:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 30 Jun 2020 12:58:15 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 30 Jun 2020 12:58:15 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jun
 2020 19:58:07 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 30 Jun 2020 19:58:07 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5efb994f0002>; Tue, 30 Jun 2020 12:58:07 -0700
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
Subject: [PATCH v2 1/5] nouveau/hmm: fault one page at a time
Date:   Tue, 30 Jun 2020 12:57:33 -0700
Message-ID: <20200630195737.8667-2-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200630195737.8667-1-rcampbell@nvidia.com>
References: <20200630195737.8667-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593546996; bh=2WyHYZcAAd5j4j8YMKEb9Xnebvu/ReeLnPA7IJpaPHY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=r0AhEB3uF+5wNNtM0mmIB01SZmgLqLlmHnepBFQmHzf4tRP0UTxTQs9DPBBRuI0FP
         zqjRwmgP1abIaPUC7nsZvRET4KZmg+f9mjYRi59+5CTjpP8xRc37YbBvC94qcxixKo
         GMJGXam43JhMVk8m5Yr87K0qbRDzfBHuBQrOSeE8UpsCAWiClRlr/h4Ic38BqYsWk2
         YONZNtzbM1atRj0HZuCSqgCkGm/atkoVDj66ClPR00F8p/EFuu3Fr0O4ndlzdir4wp
         3mFRc3Xa3s/yv1B7CTJDLEX2naf8jt7Yni2zry2JH1TX5u4ZVOUlejHE8/he4/MtPP
         o+cnDyb/dc/XQ==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The SVM page fault handler groups faults into a range of contiguous
virtual addresses and requests hmm_range_fault() to populate and
return the page frame number of system memory mapped by the CPU.
In preparation for supporting large pages to be mapped by the GPU,
process faults one page at a time. In addition, use the hmm_range
default_flags to fix a corner case where the input hmm_pfns array
is not reinitialized after hmm_range_fault() returns -EBUSY and must
be called again.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 199 +++++++++-----------------
 1 file changed, 66 insertions(+), 133 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouvea=
u/nouveau_svm.c
index ba9f9359c30e..665dede69bd1 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -516,7 +516,7 @@ static const struct mmu_interval_notifier_ops nouveau_s=
vm_mni_ops =3D {
 static void nouveau_hmm_convert_pfn(struct nouveau_drm *drm,
 				    struct hmm_range *range, u64 *ioctl_addr)
 {
-	unsigned long i, npages;
+	struct page *page;
=20
 	/*
 	 * The ioctl_addr prepared here is passed through nvif_object_ioctl()
@@ -525,42 +525,38 @@ static void nouveau_hmm_convert_pfn(struct nouveau_dr=
m *drm,
 	 * This is all just encoding the internal hmm representation into a
 	 * different nouveau internal representation.
 	 */
-	npages =3D (range->end - range->start) >> PAGE_SHIFT;
-	for (i =3D 0; i < npages; ++i) {
-		struct page *page;
-
-		if (!(range->hmm_pfns[i] & HMM_PFN_VALID)) {
-			ioctl_addr[i] =3D 0;
-			continue;
-		}
-
-		page =3D hmm_pfn_to_page(range->hmm_pfns[i]);
-		if (is_device_private_page(page))
-			ioctl_addr[i] =3D nouveau_dmem_page_addr(page) |
-					NVIF_VMM_PFNMAP_V0_V |
-					NVIF_VMM_PFNMAP_V0_VRAM;
-		else
-			ioctl_addr[i] =3D page_to_phys(page) |
-					NVIF_VMM_PFNMAP_V0_V |
-					NVIF_VMM_PFNMAP_V0_HOST;
-		if (range->hmm_pfns[i] & HMM_PFN_WRITE)
-			ioctl_addr[i] |=3D NVIF_VMM_PFNMAP_V0_W;
+	if (!(range->hmm_pfns[0] & HMM_PFN_VALID)) {
+		ioctl_addr[0] =3D 0;
+		return;
 	}
+
+	page =3D hmm_pfn_to_page(range->hmm_pfns[0]);
+	if (is_device_private_page(page))
+		ioctl_addr[0] =3D nouveau_dmem_page_addr(page) |
+				NVIF_VMM_PFNMAP_V0_V |
+				NVIF_VMM_PFNMAP_V0_VRAM;
+	else
+		ioctl_addr[0] =3D page_to_phys(page) |
+				NVIF_VMM_PFNMAP_V0_V |
+				NVIF_VMM_PFNMAP_V0_HOST;
+	if (range->hmm_pfns[0] & HMM_PFN_WRITE)
+		ioctl_addr[0] |=3D NVIF_VMM_PFNMAP_V0_W;
 }
=20
 static int nouveau_range_fault(struct nouveau_svmm *svmm,
 			       struct nouveau_drm *drm, void *data, u32 size,
-			       unsigned long hmm_pfns[], u64 *ioctl_addr,
+			       u64 *ioctl_addr, unsigned long hmm_flags,
 			       struct svm_notifier *notifier)
 {
 	unsigned long timeout =3D
 		jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
 	/* Have HMM fault pages within the fault window to the GPU. */
+	unsigned long hmm_pfns[1];
 	struct hmm_range range =3D {
 		.notifier =3D &notifier->notifier,
 		.start =3D notifier->notifier.interval_tree.start,
 		.end =3D notifier->notifier.interval_tree.last + 1,
-		.pfn_flags_mask =3D HMM_PFN_REQ_FAULT | HMM_PFN_REQ_WRITE,
+		.default_flags =3D hmm_flags,
 		.hmm_pfns =3D hmm_pfns,
 	};
 	struct mm_struct *mm =3D notifier->notifier.mm;
@@ -575,11 +571,6 @@ static int nouveau_range_fault(struct nouveau_svmm *sv=
mm,
 		ret =3D hmm_range_fault(&range);
 		mmap_read_unlock(mm);
 		if (ret) {
-			/*
-			 * FIXME: the input PFN_REQ flags are destroyed on
-			 * -EBUSY, we need to regenerate them, also for the
-			 * other continue below
-			 */
 			if (ret =3D=3D -EBUSY)
 				continue;
 			return ret;
@@ -614,17 +605,12 @@ nouveau_svm_fault(struct nvif_notify *notify)
 	struct nvif_object *device =3D &svm->drm->client.device.object;
 	struct nouveau_svmm *svmm;
 	struct {
-		struct {
-			struct nvif_ioctl_v0 i;
-			struct nvif_ioctl_mthd_v0 m;
-			struct nvif_vmm_pfnmap_v0 p;
-		} i;
-		u64 phys[16];
+		struct nouveau_pfnmap_args i;
+		u64 phys[1];
 	} args;
-	unsigned long hmm_pfns[ARRAY_SIZE(args.phys)];
-	struct vm_area_struct *vma;
+	unsigned long hmm_flags;
 	u64 inst, start, limit;
-	int fi, fn, pi, fill;
+	int fi, fn;
 	int replay =3D 0, ret;
=20
 	/* Parse available fault buffer entries into a cache, and update
@@ -691,66 +677,53 @@ nouveau_svm_fault(struct nvif_notify *notify)
 		 * window into a single update.
 		 */
 		start =3D buffer->fault[fi]->addr;
-		limit =3D start + (ARRAY_SIZE(args.phys) << PAGE_SHIFT);
+		limit =3D start + PAGE_SIZE;
 		if (start < svmm->unmanaged.limit)
 			limit =3D min_t(u64, limit, svmm->unmanaged.start);
-		SVMM_DBG(svmm, "wndw %016llx-%016llx", start, limit);
=20
-		mm =3D svmm->notifier.mm;
-		if (!mmget_not_zero(mm)) {
-			nouveau_svm_fault_cancel_fault(svm, buffer->fault[fi]);
-			continue;
-		}
-
-		/* Intersect fault window with the CPU VMA, cancelling
-		 * the fault if the address is invalid.
+		/*
+		 * Prepare the GPU-side update of all pages within the
+		 * fault window, determining required pages and access
+		 * permissions based on pending faults.
 		 */
-		mmap_read_lock(mm);
-		vma =3D find_vma_intersection(mm, start, limit);
-		if (!vma) {
-			SVMM_ERR(svmm, "wndw %016llx-%016llx", start, limit);
-			mmap_read_unlock(mm);
-			mmput(mm);
-			nouveau_svm_fault_cancel_fault(svm, buffer->fault[fi]);
-			continue;
+		args.i.p.addr =3D start;
+		args.i.p.page =3D PAGE_SHIFT;
+		args.i.p.size =3D PAGE_SIZE;
+		/*
+		 * Determine required permissions based on GPU fault
+		 * access flags.
+		 * XXX: atomic?
+		 */
+		switch (buffer->fault[fi]->access) {
+		case 0: /* READ. */
+			hmm_flags =3D HMM_PFN_REQ_FAULT;
+			break;
+		case 3: /* PREFETCH. */
+			hmm_flags =3D 0;
+			break;
+		default:
+			hmm_flags =3D HMM_PFN_REQ_FAULT | HMM_PFN_REQ_WRITE;
+			break;
 		}
-		start =3D max_t(u64, start, vma->vm_start);
-		limit =3D min_t(u64, limit, vma->vm_end);
-		mmap_read_unlock(mm);
-		SVMM_DBG(svmm, "wndw %016llx-%016llx", start, limit);
=20
-		if (buffer->fault[fi]->addr !=3D start) {
-			SVMM_ERR(svmm, "addr %016llx", buffer->fault[fi]->addr);
-			mmput(mm);
+		mm =3D svmm->notifier.mm;
+		if (!mmget_not_zero(mm)) {
 			nouveau_svm_fault_cancel_fault(svm, buffer->fault[fi]);
 			continue;
 		}
=20
-		/* Prepare the GPU-side update of all pages within the
-		 * fault window, determining required pages and access
-		 * permissions based on pending faults.
-		 */
-		args.i.p.page =3D PAGE_SHIFT;
-		args.i.p.addr =3D start;
-		for (fn =3D fi, pi =3D 0;;) {
-			/* Determine required permissions based on GPU fault
-			 * access flags.
-			 *XXX: atomic?
-			 */
-			switch (buffer->fault[fn]->access) {
-			case 0: /* READ. */
-				hmm_pfns[pi++] =3D HMM_PFN_REQ_FAULT;
-				break;
-			case 3: /* PREFETCH. */
-				hmm_pfns[pi++] =3D 0;
-				break;
-			default:
-				hmm_pfns[pi++] =3D HMM_PFN_REQ_FAULT |
-						 HMM_PFN_REQ_WRITE;
-				break;
-			}
-			args.i.p.size =3D pi << PAGE_SHIFT;
+		notifier.svmm =3D svmm;
+		ret =3D mmu_interval_notifier_insert(&notifier.notifier, mm,
+						   args.i.p.addr, args.i.p.size,
+						   &nouveau_svm_mni_ops);
+		if (!ret) {
+			ret =3D nouveau_range_fault(svmm, svm->drm, &args,
+				sizeof(args), args.phys, hmm_flags, &notifier);
+			mmu_interval_notifier_remove(&notifier.notifier);
+		}
+		mmput(mm);
=20
+		for (fn =3D fi; ++fn < buffer->fault_nr; ) {
 			/* It's okay to skip over duplicate addresses from the
 			 * same SVMM as faults are ordered by access type such
 			 * that only the first one needs to be handled.
@@ -758,61 +731,21 @@ nouveau_svm_fault(struct nvif_notify *notify)
 			 * ie. WRITE faults appear first, thus any handling of
 			 * pending READ faults will already be satisfied.
 			 */
-			while (++fn < buffer->fault_nr &&
-			       buffer->fault[fn]->svmm =3D=3D svmm &&
-			       buffer->fault[fn    ]->addr =3D=3D
-			       buffer->fault[fn - 1]->addr);
-
-			/* If the next fault is outside the window, or all GPU
-			 * faults have been dealt with, we're done here.
-			 */
-			if (fn >=3D buffer->fault_nr ||
-			    buffer->fault[fn]->svmm !=3D svmm ||
+			if (buffer->fault[fn]->svmm !=3D svmm ||
 			    buffer->fault[fn]->addr >=3D limit)
 				break;
-
-			/* Fill in the gap between this fault and the next. */
-			fill =3D (buffer->fault[fn    ]->addr -
-				buffer->fault[fn - 1]->addr) >> PAGE_SHIFT;
-			while (--fill)
-				hmm_pfns[pi++] =3D 0;
 		}
=20
-		SVMM_DBG(svmm, "wndw %016llx-%016llx covering %d fault(s)",
-			 args.i.p.addr,
-			 args.i.p.addr + args.i.p.size, fn - fi);
-
-		notifier.svmm =3D svmm;
-		ret =3D mmu_interval_notifier_insert(&notifier.notifier,
-						   svmm->notifier.mm,
-						   args.i.p.addr, args.i.p.size,
-						   &nouveau_svm_mni_ops);
-		if (!ret) {
-			ret =3D nouveau_range_fault(
-				svmm, svm->drm, &args,
-				sizeof(args.i) + pi * sizeof(args.phys[0]),
-				hmm_pfns, args.phys, &notifier);
-			mmu_interval_notifier_remove(&notifier.notifier);
-		}
-		mmput(mm);
+		/* If handling failed completely, cancel all faults. */
+		if (ret) {
+			while (fi < fn) {
+				struct nouveau_svm_fault *fault =3D
+					buffer->fault[fi++];
=20
-		/* Cancel any faults in the window whose pages didn't manage
-		 * to keep their valid bit, or stay writeable when required.
-		 *
-		 * If handling failed completely, cancel all faults.
-		 */
-		while (fi < fn) {
-			struct nouveau_svm_fault *fault =3D buffer->fault[fi++];
-			pi =3D (fault->addr - args.i.p.addr) >> PAGE_SHIFT;
-			if (ret ||
-			     !(args.phys[pi] & NVIF_VMM_PFNMAP_V0_V) ||
-			    (!(args.phys[pi] & NVIF_VMM_PFNMAP_V0_W) &&
-			     fault->access !=3D 0 && fault->access !=3D 3)) {
 				nouveau_svm_fault_cancel_fault(svm, fault);
-				continue;
 			}
+		} else
 			replay++;
-		}
 	}
=20
 	/* Issue fault replay to the GPU. */
--=20
2.20.1

