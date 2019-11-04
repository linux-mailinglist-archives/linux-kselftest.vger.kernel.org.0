Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6C6EEF88
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2019 23:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389485AbfKDWVt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Nov 2019 17:21:49 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11397 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389327AbfKDWVs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Nov 2019 17:21:48 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dc0a4820000>; Mon, 04 Nov 2019 14:21:54 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 04 Nov 2019 14:21:47 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 04 Nov 2019 14:21:47 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 Nov
 2019 22:21:45 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 4 Nov 2019 22:21:45 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dc0a4790000>; Mon, 04 Nov 2019 14:21:45 -0800
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Shuah Khan" <shuah@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        "Ralph Campbell" <rcampbell@nvidia.com>
Subject: [PATCH v4 1/2] mm/hmm: make full use of walk_page_range()
Date:   Mon, 4 Nov 2019 14:21:40 -0800
Message-ID: <20191104222141.5173-2-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191104222141.5173-1-rcampbell@nvidia.com>
References: <20191104222141.5173-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1572906114; bh=sguLk7hChtGaLxM7UbxWupAo9l0ygCxnDGdx39VaIVQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Type:Content-Transfer-Encoding;
        b=NdT8mdc29bf7hh0pzUIcPKammK2aYBt2p7VR/h0IVjlph7S1TfwLhF3UZfIJ1BfYf
         wsetg4j+OzTpDDiSsD8QenoGq0EMjt2PVGX0tgTqPhWd9CYP4FvjH4iSUf7zqgi+v7
         4queOJ7DZCrNFhtZ/zBqOPfwEMBE3ae8IPV0R6/1ZaNkEjTsQr1VHFuRIy0V8kTwO1
         xAWJgqh4TFwZTlAQES3K1AqWwB9fXIFNVc0sjot+VKVkxAuZiS0btf9eGU0YPivyo/
         U42jyDOFFDEpdD3scDtOdHbEaIZoeFbDfuO4083IrM7c0lNygdjKjFG0VALIYKvIms
         uCZACUsLOrYWA==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

hmm_range_fault() calls find_vma() and walk_page_range() in a loop.
This is unnecessary duplication since walk_page_range() calls find_vma()
in a loop already.
Simplify hmm_range_fault() by defining a walk_test() callback function
to filter unhandled vmas.
This also fixes a bug where hmm_range_fault() was not checking
start >=3D vma->vm_start before checking vma->vm_flags so hmm_range_fault()
could return an error based on the wrong vma for the requested range.
It also fixes a bug when the vma has no read access and the caller did
not request a fault, there shouldn't be any error return code.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Christoph Hellwig <hch@lst.de>
---
 mm/hmm.c | 121 ++++++++++++++++++++++++++-----------------------------
 1 file changed, 58 insertions(+), 63 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 9e9d3f4ea17c..d4984a08ed9b 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -65,18 +65,15 @@ static int hmm_vma_do_fault(struct mm_walk *walk, unsig=
ned long addr,
 	return -EFAULT;
 }
=20
-static int hmm_pfns_bad(unsigned long addr,
-			unsigned long end,
-			struct mm_walk *walk)
+static int hmm_pfns_fill(unsigned long addr, unsigned long end,
+		struct hmm_range *range, enum hmm_pfn_value_e value)
 {
-	struct hmm_vma_walk *hmm_vma_walk =3D walk->private;
-	struct hmm_range *range =3D hmm_vma_walk->range;
 	uint64_t *pfns =3D range->pfns;
 	unsigned long i;
=20
 	i =3D (addr - range->start) >> PAGE_SHIFT;
 	for (; addr < end; addr +=3D PAGE_SIZE, i++)
-		pfns[i] =3D range->values[HMM_PFN_ERROR];
+		pfns[i] =3D range->values[value];
=20
 	return 0;
 }
@@ -403,7 +400,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		}
 		return 0;
 	} else if (!pmd_present(pmd))
-		return hmm_pfns_bad(start, end, walk);
+		return hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
=20
 	if (pmd_devmap(pmd) || pmd_trans_huge(pmd)) {
 		/*
@@ -431,7 +428,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 	 * recover.
 	 */
 	if (pmd_bad(pmd))
-		return hmm_pfns_bad(start, end, walk);
+		return hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
=20
 	ptep =3D pte_offset_map(pmdp, addr);
 	i =3D (addr - range->start) >> PAGE_SHIFT;
@@ -589,13 +586,47 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, uns=
igned long hmask,
 #define hmm_vma_walk_hugetlb_entry NULL
 #endif /* CONFIG_HUGETLB_PAGE */
=20
-static void hmm_pfns_clear(struct hmm_range *range,
-			   uint64_t *pfns,
-			   unsigned long addr,
-			   unsigned long end)
+static int hmm_vma_walk_test(unsigned long start, unsigned long end,
+			     struct mm_walk *walk)
 {
-	for (; addr < end; addr +=3D PAGE_SIZE, pfns++)
-		*pfns =3D range->values[HMM_PFN_NONE];
+	struct hmm_vma_walk *hmm_vma_walk =3D walk->private;
+	struct hmm_range *range =3D hmm_vma_walk->range;
+	struct vm_area_struct *vma =3D walk->vma;
+
+	/*
+	 * Skip vma ranges that don't have struct page backing them or
+	 * map I/O devices directly.
+	 */
+	if (vma->vm_flags & (VM_IO | VM_PFNMAP | VM_MIXEDMAP))
+		return -EFAULT;
+
+	/*
+	 * If the vma does not allow read access, then assume that it does not
+	 * allow write access either. HMM does not support architectures
+	 * that allow write without read.
+	 */
+	if (!(vma->vm_flags & VM_READ)) {
+		bool fault, write_fault;
+
+		/*
+		 * Check to see if a fault is requested for any page in the
+		 * range.
+		 */
+		hmm_range_need_fault(hmm_vma_walk, range->pfns +
+					((start - range->start) >> PAGE_SHIFT),
+					(end - start) >> PAGE_SHIFT,
+					0, &fault, &write_fault);
+		if (fault || write_fault)
+			return -EFAULT;
+
+		hmm_pfns_fill(start, end, range, HMM_PFN_NONE);
+		hmm_vma_walk->last =3D end;
+
+		/* Skip this vma and continue processing the next vma. */
+		return 1;
+	}
+
+	return 0;
 }
=20
 static const struct mm_walk_ops hmm_walk_ops =3D {
@@ -603,6 +634,7 @@ static const struct mm_walk_ops hmm_walk_ops =3D {
 	.pmd_entry	=3D hmm_vma_walk_pmd,
 	.pte_hole	=3D hmm_vma_walk_hole,
 	.hugetlb_entry	=3D hmm_vma_walk_hugetlb_entry,
+	.test_walk	=3D hmm_vma_walk_test,
 };
=20
 /**
@@ -635,11 +667,13 @@ static const struct mm_walk_ops hmm_walk_ops =3D {
  */
 long hmm_range_fault(struct hmm_range *range, unsigned int flags)
 {
-	const unsigned long device_vma =3D VM_IO | VM_PFNMAP | VM_MIXEDMAP;
-	unsigned long start =3D range->start, end;
-	struct hmm_vma_walk hmm_vma_walk;
+	unsigned long start =3D range->start;
+	struct hmm_vma_walk hmm_vma_walk =3D {
+		.range =3D range,
+		.last =3D start,
+		.flags =3D flags,
+	};
 	struct mm_struct *mm =3D range->notifier->mm;
-	struct vm_area_struct *vma;
 	int ret;
=20
 	lockdep_assert_held(&mm->mmap_sem);
@@ -648,52 +682,13 @@ long hmm_range_fault(struct hmm_range *range, unsigne=
d int flags)
 		/* If range is no longer valid force retry. */
 		if (mmu_range_check_retry(range->notifier, range->notifier_seq))
 			return -EBUSY;
+		ret =3D walk_page_range(mm, start, range->end, &hmm_walk_ops,
+				      &hmm_vma_walk);
+		start =3D hmm_vma_walk.last;
+	} while (ret =3D=3D -EBUSY);
=20
-		vma =3D find_vma(mm, start);
-		if (vma =3D=3D NULL || (vma->vm_flags & device_vma))
-			return -EFAULT;
-
-		if (!(vma->vm_flags & VM_READ)) {
-			/*
-			 * If vma do not allow read access, then assume that it
-			 * does not allow write access, either. HMM does not
-			 * support architecture that allow write without read.
-			 */
-			hmm_pfns_clear(range, range->pfns,
-				range->start, range->end);
-			return -EPERM;
-		}
-
-		hmm_vma_walk.pgmap =3D NULL;
-		hmm_vma_walk.last =3D start;
-		hmm_vma_walk.flags =3D flags;
-		hmm_vma_walk.range =3D range;
-		end =3D min(range->end, vma->vm_end);
-
-		walk_page_range(vma->vm_mm, start, end, &hmm_walk_ops,
-				&hmm_vma_walk);
-
-		do {
-			ret =3D walk_page_range(vma->vm_mm, start, end,
-					&hmm_walk_ops, &hmm_vma_walk);
-			start =3D hmm_vma_walk.last;
-
-			/* Keep trying while the range is valid. */
-		} while (ret =3D=3D -EBUSY &&
-			 !mmu_range_check_retry(range->notifier,
-						range->notifier_seq));
-
-		if (ret) {
-			unsigned long i;
-
-			i =3D (hmm_vma_walk.last - range->start) >> PAGE_SHIFT;
-			hmm_pfns_clear(range, &range->pfns[i],
-				hmm_vma_walk.last, range->end);
-			return ret;
-		}
-		start =3D end;
-
-	} while (start < range->end);
+	if (ret)
+		return ret;
=20
 	return (hmm_vma_walk.last - range->start) >> PAGE_SHIFT;
 }
--=20
2.20.1

