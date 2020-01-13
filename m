Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD268139CDC
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2020 23:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbgAMWrc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jan 2020 17:47:32 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:16396 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbgAMWrT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jan 2020 17:47:19 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1cf3400001>; Mon, 13 Jan 2020 14:46:24 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 13 Jan 2020 14:47:17 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 13 Jan 2020 14:47:17 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 Jan
 2020 22:47:12 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 13 Jan 2020 22:47:12 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e1cf3700000>; Mon, 13 Jan 2020 14:47:12 -0800
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
        <linux-kselftest@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH v6 5/6] nouveau: use new mmu interval notifiers
Date:   Mon, 13 Jan 2020 14:47:02 -0800
Message-ID: <20200113224703.5917-6-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200113224703.5917-1-rcampbell@nvidia.com>
References: <20200113224703.5917-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578955584; bh=fgEYXPzUbpQqXndlAQC6x4Ciedwx9mrvQo4YxSIRLpA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=ZaoVRx4y5nqZZ9eUTs9lSH9d2P9jYrT5bwsMssBu4x8u4vD9F507xqjKYgyHSMgLa
         5T54QS7ZwvVZqT5PU/ZYDaVpHrB2UnaTikZ4jxniU+7bfyST862S6Sz97nVKYHN6Ti
         1p1j9qZWpu2dVzr0DuC0WrtRAPkFK+bYz9TEqXcEhqrPiBw5hx0XXF8gsUHWca3nmi
         mbuyAgfkv7RxtHzIEBDHnHXZzVsqOW9r/nyhRdtwHlBwX0YnikLsGO8TVTwNisz0u1
         bQZcF2OWWPugtNb/84JjUlAGGty201aAun1/EK0ZAyPanV1+ehz89fEijsIAd0Xm8Y
         jg7rh+bV1dhTQ==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Update nouveau to only use the mmu interval notifiers.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 313 +++++++++++++++++---------
 1 file changed, 201 insertions(+), 112 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouvea=
u/nouveau_svm.c
index df9bf1fd1bc0..0343e48d41d7 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -88,7 +88,7 @@ nouveau_ivmm_find(struct nouveau_svm *svm, u64 inst)
 }
=20
 struct nouveau_svmm {
-	struct mmu_notifier notifier;
+	struct mm_struct *mm;
 	struct nouveau_vmm *vmm;
 	struct {
 		unsigned long start;
@@ -98,6 +98,13 @@ struct nouveau_svmm {
 	struct mutex mutex;
 };
=20
+struct svmm_interval {
+	struct mmu_interval_notifier notifier;
+	struct nouveau_svmm *svmm;
+};
+
+static const struct mmu_interval_notifier_ops nouveau_svm_mni_ops;
+
 #define SVMM_DBG(s,f,a...)                                                =
     \
 	NV_DEBUG((s)->vmm->cli->drm, "svm-%p: "f"\n", (s), ##a)
 #define SVMM_ERR(s,f,a...)                                                =
     \
@@ -236,6 +243,8 @@ nouveau_svmm_join(struct nouveau_svmm *svmm, u64 inst)
 static void
 nouveau_svmm_invalidate(struct nouveau_svmm *svmm, u64 start, u64 limit)
 {
+	SVMM_DBG(svmm, "invalidate %016llx-%016llx", start, limit);
+
 	if (limit > start) {
 		bool super =3D svmm->vmm->vmm.object.client->super;
 		svmm->vmm->vmm.object.client->super =3D true;
@@ -248,58 +257,25 @@ nouveau_svmm_invalidate(struct nouveau_svmm *svmm, u6=
4 start, u64 limit)
 	}
 }
=20
-static int
-nouveau_svmm_invalidate_range_start(struct mmu_notifier *mn,
-				    const struct mmu_notifier_range *update)
-{
-	struct nouveau_svmm *svmm =3D
-		container_of(mn, struct nouveau_svmm, notifier);
-	unsigned long start =3D update->start;
-	unsigned long limit =3D update->end;
-
-	if (!mmu_notifier_range_blockable(update))
-		return -EAGAIN;
-
-	SVMM_DBG(svmm, "invalidate %016lx-%016lx", start, limit);
-
-	mutex_lock(&svmm->mutex);
-	if (unlikely(!svmm->vmm))
-		goto out;
-
-	if (limit > svmm->unmanaged.start && start < svmm->unmanaged.limit) {
-		if (start < svmm->unmanaged.start) {
-			nouveau_svmm_invalidate(svmm, start,
-						svmm->unmanaged.limit);
-		}
-		start =3D svmm->unmanaged.limit;
-	}
-
-	nouveau_svmm_invalidate(svmm, start, limit);
-
-out:
-	mutex_unlock(&svmm->mutex);
-	return 0;
-}
-
-static void nouveau_svmm_free_notifier(struct mmu_notifier *mn)
-{
-	kfree(container_of(mn, struct nouveau_svmm, notifier));
-}
-
-static const struct mmu_notifier_ops nouveau_mn_ops =3D {
-	.invalidate_range_start =3D nouveau_svmm_invalidate_range_start,
-	.free_notifier =3D nouveau_svmm_free_notifier,
-};
-
 void
 nouveau_svmm_fini(struct nouveau_svmm **psvmm)
 {
 	struct nouveau_svmm *svmm =3D *psvmm;
+	struct mmu_interval_notifier *mni;
+
 	if (svmm) {
 		mutex_lock(&svmm->mutex);
+		while (true) {
+			mni =3D mmu_interval_notifier_find(svmm->mm,
+					&nouveau_svm_mni_ops, 0UL, ~0UL);
+			if (!mni)
+				break;
+			mmu_interval_notifier_put(mni);
+		}
 		svmm->vmm =3D NULL;
 		mutex_unlock(&svmm->mutex);
-		mmu_notifier_put(&svmm->notifier);
+		mmdrop(svmm->mm);
+		kfree(svmm);
 		*psvmm =3D NULL;
 	}
 }
@@ -343,11 +319,12 @@ nouveau_svmm_init(struct drm_device *dev, void *data,
 		goto out_free;
=20
 	down_write(&current->mm->mmap_sem);
-	svmm->notifier.ops =3D &nouveau_mn_ops;
-	ret =3D __mmu_notifier_register(&svmm->notifier, current->mm);
+	ret =3D __mmu_notifier_register(NULL, current->mm);
 	if (ret)
 		goto out_mm_unlock;
-	/* Note, ownership of svmm transfers to mmu_notifier */
+
+	mmgrab(current->mm);
+	svmm->mm =3D current->mm;
=20
 	cli->svm.svmm =3D svmm;
 	cli->svm.cli =3D cli;
@@ -482,65 +459,212 @@ nouveau_svm_fault_cache(struct nouveau_svm *svm,
 		fault->inst, fault->addr, fault->access);
 }
=20
-struct svm_notifier {
-	struct mmu_interval_notifier notifier;
-	struct nouveau_svmm *svmm;
-};
+static struct svmm_interval *nouveau_svmm_new_interval(
+					struct nouveau_svmm *svmm,
+					unsigned long start,
+					unsigned long last)
+{
+	struct svmm_interval *smi;
+	int ret;
+
+	smi =3D kmalloc(sizeof(*smi), GFP_ATOMIC);
+	if (!smi)
+		return NULL;
+
+	smi->svmm =3D svmm;
+
+	ret =3D mmu_interval_notifier_insert_safe(&smi->notifier, svmm->mm,
+				start, last - start + 1, &nouveau_svm_mni_ops);
+	if (ret) {
+		kfree(smi);
+		return NULL;
+	}
+
+	return smi;
+}
+
+static void nouveau_svmm_do_unmap(struct mmu_interval_notifier *mni,
+				 const struct mmu_notifier_range *range)
+{
+	struct svmm_interval *smi =3D
+		container_of(mni, struct svmm_interval, notifier);
+	struct nouveau_svmm *svmm =3D smi->svmm;
+	unsigned long start =3D mmu_interval_notifier_start(mni);
+	unsigned long last =3D mmu_interval_notifier_last(mni);
+
+	if (start >=3D range->start) {
+		/* Remove the whole interval or keep the right-hand part. */
+		if (last <=3D range->end)
+			mmu_interval_notifier_put(mni);
+		else
+			mmu_interval_notifier_update(mni, range->end, last);
+		return;
+	}
+
+	/* Keep the left-hand part of the interval. */
+	mmu_interval_notifier_update(mni, start, range->start - 1);
+
+	/* If a hole is created, create an interval for the right-hand part. */
+	if (last >=3D range->end) {
+		smi =3D nouveau_svmm_new_interval(svmm, range->end, last);
+		/*
+		 * If we can't allocate an interval, we won't get invalidation
+		 * callbacks so clear the mapping and rely on faults to reload
+		 * the mappings if needed.
+		 */
+		if (!smi)
+			nouveau_svmm_invalidate(svmm, range->end, last + 1);
+	}
+}
=20
-static bool nouveau_svm_range_invalidate(struct mmu_interval_notifier *mni=
,
-					 const struct mmu_notifier_range *range,
-					 unsigned long cur_seq)
+static bool nouveau_svmm_interval_invalidate(struct mmu_interval_notifier =
*mni,
+				const struct mmu_notifier_range *range,
+				unsigned long cur_seq)
 {
-	struct svm_notifier *sn =3D
-		container_of(mni, struct svm_notifier, notifier);
+	struct svmm_interval *smi =3D
+		container_of(mni, struct svmm_interval, notifier);
+	struct nouveau_svmm *svmm =3D smi->svmm;
=20
 	/*
-	 * serializes the update to mni->invalidate_seq done by caller and
+	 * Serializes the update to mni->invalidate_seq done by the caller and
 	 * prevents invalidation of the PTE from progressing while HW is being
-	 * programmed. This is very hacky and only works because the normal
-	 * notifier that does invalidation is always called after the range
-	 * notifier.
+	 * programmed.
 	 */
 	if (mmu_notifier_range_blockable(range))
-		mutex_lock(&sn->svmm->mutex);
-	else if (!mutex_trylock(&sn->svmm->mutex))
+		mutex_lock(&svmm->mutex);
+	else if (!mutex_trylock(&svmm->mutex))
 		return false;
+
 	mmu_interval_set_seq(mni, cur_seq);
-	mutex_unlock(&sn->svmm->mutex);
+	nouveau_svmm_invalidate(svmm, range->start, range->end);
+
+	/* Stop tracking the range if it is an unmap. */
+	if (range->event =3D=3D MMU_NOTIFY_UNMAP)
+		nouveau_svmm_do_unmap(mni, range);
+
+	mutex_unlock(&svmm->mutex);
 	return true;
 }
=20
+static void nouveau_svmm_interval_release(struct mmu_interval_notifier *mn=
i)
+{
+	struct svmm_interval *smi =3D
+		container_of(mni, struct svmm_interval, notifier);
+
+	kfree(smi);
+}
+
 static const struct mmu_interval_notifier_ops nouveau_svm_mni_ops =3D {
-	.invalidate =3D nouveau_svm_range_invalidate,
+	.invalidate =3D nouveau_svmm_interval_invalidate,
+	.release =3D nouveau_svmm_interval_release,
 };
=20
+/*
+ * Find or create a mmu_interval_notifier for the given range.
+ * Although mmu_interval_notifier_insert_safe() can handle overlapping
+ * intervals, we only create non-overlapping intervals, shrinking the hmm_=
range
+ * if it spans more than one svmm_interval.
+ */
+static int nouveau_svmm_interval_find(struct nouveau_svmm *svmm,
+				 struct hmm_range *range)
+{
+	struct mmu_interval_notifier *mni;
+	struct svmm_interval *smi;
+	struct vm_area_struct *vma;
+	unsigned long start =3D range->start;
+	unsigned long last =3D range->end - 1;
+	int ret;
+
+	mutex_lock(&svmm->mutex);
+	mni =3D mmu_interval_notifier_find(svmm->mm, &nouveau_svm_mni_ops, start,
+					 last);
+	if (mni) {
+		if (start >=3D mmu_interval_notifier_start(mni)) {
+			smi =3D container_of(mni, struct svmm_interval, notifier);
+			if (last > mmu_interval_notifier_last(mni))
+				range->end =3D
+					mmu_interval_notifier_last(mni) + 1;
+			goto found;
+		}
+		WARN_ON(last <=3D mmu_interval_notifier_start(mni));
+		range->end =3D mmu_interval_notifier_start(mni);
+		last =3D range->end - 1;
+	}
+	/*
+	 * Might as well create an interval covering the underlying VMA to
+	 * avoid having to create a bunch of small intervals.
+	 */
+	vma =3D find_vma(svmm->mm, range->start);
+	if (!vma || start < vma->vm_start) {
+		ret =3D -ENOENT;
+		goto err;
+	}
+	if (range->end > vma->vm_end) {
+		range->end =3D vma->vm_end;
+		last =3D range->end - 1;
+	} else if (!mni) {
+		/* Anything registered on the right part of the vma? */
+		mni =3D mmu_interval_notifier_find(svmm->mm, &nouveau_svm_mni_ops,
+						 range->end, vma->vm_end - 1);
+		if (mni)
+			last =3D mmu_interval_notifier_start(mni) - 1;
+		else
+			last =3D vma->vm_end - 1;
+	}
+	/* Anything registered on the left part of the vma? */
+	mni =3D mmu_interval_notifier_find(svmm->mm, &nouveau_svm_mni_ops,
+					 vma->vm_start, start - 1);
+	if (mni)
+		start =3D mmu_interval_notifier_last(mni) + 1;
+	else
+		start =3D vma->vm_start;
+	smi =3D nouveau_svmm_new_interval(svmm, start, last);
+	if (!smi) {
+		ret =3D -ENOMEM;
+		goto err;
+	}
+
+found:
+	range->notifier =3D &smi->notifier;
+	mutex_unlock(&svmm->mutex);
+	return 0;
+
+err:
+	mutex_unlock(&svmm->mutex);
+	return ret;
+}
+
 static int nouveau_range_fault(struct nouveau_svmm *svmm,
 			       struct nouveau_drm *drm, void *data, u32 size,
-			       u64 *pfns, struct svm_notifier *notifier)
+			       u64 *pfns, u64 start, u64 end)
 {
 	unsigned long timeout =3D
 		jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
 	/* Have HMM fault pages within the fault window to the GPU. */
 	struct hmm_range range =3D {
-		.notifier =3D &notifier->notifier,
-		.start =3D notifier->notifier.interval_tree.start,
-		.end =3D notifier->notifier.interval_tree.last + 1,
+		.start =3D start,
+		.end =3D end,
 		.pfns =3D pfns,
 		.flags =3D nouveau_svm_pfn_flags,
 		.values =3D nouveau_svm_pfn_values,
+		.default_flags =3D 0,
+		.pfn_flags_mask =3D ~0UL,
 		.pfn_shift =3D NVIF_VMM_PFNMAP_V0_ADDR_SHIFT,
 	};
-	struct mm_struct *mm =3D notifier->notifier.mm;
+	struct mm_struct *mm =3D svmm->mm;
 	long ret;
=20
 	while (true) {
 		if (time_after(jiffies, timeout))
 			return -EBUSY;
=20
-		range.notifier_seq =3D mmu_interval_read_begin(range.notifier);
-		range.default_flags =3D 0;
-		range.pfn_flags_mask =3D -1UL;
 		down_read(&mm->mmap_sem);
+		ret =3D nouveau_svmm_interval_find(svmm, &range);
+		if (ret) {
+			up_read(&mm->mmap_sem);
+			return ret;
+		}
+		range.notifier_seq =3D mmu_interval_read_begin(range.notifier);
 		ret =3D hmm_range_fault(&range, 0);
 		up_read(&mm->mmap_sem);
 		if (ret <=3D 0) {
@@ -585,7 +709,6 @@ nouveau_svm_fault(struct nvif_notify *notify)
 		} i;
 		u64 phys[16];
 	} args;
-	struct vm_area_struct *vma;
 	u64 inst, start, limit;
 	int fi, fn, pi, fill;
 	int replay =3D 0, ret;
@@ -640,7 +763,6 @@ nouveau_svm_fault(struct nvif_notify *notify)
 	args.i.p.version =3D 0;
=20
 	for (fi =3D 0; fn =3D fi + 1, fi < buffer->fault_nr; fi =3D fn) {
-		struct svm_notifier notifier;
 		struct mm_struct *mm;
=20
 		/* Cancel any faults from non-SVM channels. */
@@ -662,36 +784,12 @@ nouveau_svm_fault(struct nvif_notify *notify)
 			start =3D max_t(u64, start, svmm->unmanaged.limit);
 		SVMM_DBG(svmm, "wndw %016llx-%016llx", start, limit);
=20
-		mm =3D svmm->notifier.mm;
+		mm =3D svmm->mm;
 		if (!mmget_not_zero(mm)) {
 			nouveau_svm_fault_cancel_fault(svm, buffer->fault[fi]);
 			continue;
 		}
=20
-		/* Intersect fault window with the CPU VMA, cancelling
-		 * the fault if the address is invalid.
-		 */
-		down_read(&mm->mmap_sem);
-		vma =3D find_vma_intersection(mm, start, limit);
-		if (!vma) {
-			SVMM_ERR(svmm, "wndw %016llx-%016llx", start, limit);
-			up_read(&mm->mmap_sem);
-			mmput(mm);
-			nouveau_svm_fault_cancel_fault(svm, buffer->fault[fi]);
-			continue;
-		}
-		start =3D max_t(u64, start, vma->vm_start);
-		limit =3D min_t(u64, limit, vma->vm_end);
-		up_read(&mm->mmap_sem);
-		SVMM_DBG(svmm, "wndw %016llx-%016llx", start, limit);
-
-		if (buffer->fault[fi]->addr !=3D start) {
-			SVMM_ERR(svmm, "addr %016llx", buffer->fault[fi]->addr);
-			mmput(mm);
-			nouveau_svm_fault_cancel_fault(svm, buffer->fault[fi]);
-			continue;
-		}
-
 		/* Prepare the GPU-side update of all pages within the
 		 * fault window, determining required pages and access
 		 * permissions based on pending faults.
@@ -743,18 +841,9 @@ nouveau_svm_fault(struct nvif_notify *notify)
 			 args.i.p.addr,
 			 args.i.p.addr + args.i.p.size, fn - fi);
=20
-		notifier.svmm =3D svmm;
-		ret =3D mmu_interval_notifier_insert(&notifier.notifier,
-						   svmm->notifier.mm,
-						   args.i.p.addr, args.i.p.size,
-						   &nouveau_svm_mni_ops);
-		if (!ret) {
-			ret =3D nouveau_range_fault(
-				svmm, svm->drm, &args,
-				sizeof(args.i) + pi * sizeof(args.phys[0]),
-				args.phys, &notifier);
-			mmu_interval_notifier_remove(&notifier.notifier);
-		}
+		ret =3D nouveau_range_fault(svmm, svm->drm, &args,
+			sizeof(args.i) + pi * sizeof(args.phys[0]), args.phys,
+			start, start + args.i.p.size);
 		mmput(mm);
=20
 		/* Cancel any faults in the window whose pages didn't manage
--=20
2.20.1

