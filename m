Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C20620FD2A
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jun 2020 21:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgF3T6W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Jun 2020 15:58:22 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17426 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbgF3T6S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Jun 2020 15:58:18 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efb99270001>; Tue, 30 Jun 2020 12:57:28 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 30 Jun 2020 12:58:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 30 Jun 2020 12:58:17 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jun
 2020 19:58:07 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 30 Jun 2020 19:58:07 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5efb994f0003>; Tue, 30 Jun 2020 12:58:07 -0700
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
Subject: [PATCH v2 2/5] mm/hmm: add output flags for PMD/PUD page mapping
Date:   Tue, 30 Jun 2020 12:57:34 -0700
Message-ID: <20200630195737.8667-3-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200630195737.8667-1-rcampbell@nvidia.com>
References: <20200630195737.8667-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593547048; bh=0Gy+XSChjYh71LXJAnrVVY2NnvyyYPvv/32KOnrPX5s=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=HjN6nXF89xGcKeoZLwjKDMJYjXbwTJzRkVyWMlqxhseoWA/4C4+uR6vMXwDXwT5rh
         uH/IeASStaqCHyXavpRH1OfUeqins7+jPIrz/tsVXj7hxcTE26+dwnBaEoHu15rmBu
         bBtqX/knwmc+tLV5Qi3y7NkHJWMEzqECCmwWcwBvz9pWJqUI8fDHM1Wk7lhQqigTI5
         msCuO9V7uekppOCUjVIF43HxeHax+7oIGU2GD3P+E/QKQ5ARaSwVK2bkXvMPHNzXAd
         Wf61VVxM46PcYexh6Ri5wT+hagoIU7vx26sW8kVKAKW+3PaDc1TZWomv3OJexZtBGc
         SLmbEST4YbvQQ==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

hmm_range_fault() returns an array of page frame numbers and flags for
how the pages are mapped in the requested process' page tables. The PFN
can be used to get the struct page with hmm_pfn_to_page() and the page
size order can be determined with compound_order(page) but if the page
is larger than order 0 (PAGE_SIZE), there is no indication that a
compound page is mapped by the CPU using a larger page size. Without
this information, the caller can't safely use a large device PTE to map
the compound page because the CPU might be using smaller PTEs with
different read/write permissions.

Add two new output flags to indicate the mapping size (PMD or PUD sized)
so that callers know the pages are being mapped with consistent permissions
and a large device page table mapping can be used if one is available.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 include/linux/hmm.h | 11 ++++++++++-
 mm/hmm.c            | 13 +++++++++++--
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index f4a09ed223ac..bd250edc7048 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -28,6 +28,12 @@
  * HMM_PFN_WRITE - if the page memory can be written to (requires HMM_PFN_=
VALID)
  * HMM_PFN_ERROR - accessing the pfn is impossible and the device should
  *                 fail. ie poisoned memory, special pages, no vma, etc
+ * HMM_PFN_PMD   - if HMM_PFN_VALID is set, the page is at least of size
+ *                 PMD_SIZE and fully mapped by the CPU with consistent
+ *                 protection (e.g., all writeable if HMM_PFN_WRITE is set=
).
+ * HMM_PFN_PUD   - if HMM_PFN_VALID is set, the page is at least of size
+ *                 PUD_SIZE and fully mapped by the CPU with consistent
+ *                 protection (e.g., all writeable if HMM_PFN_WRITE is set=
).
  *
  * On input:
  * 0                 - Return the current state of the page, do not fault =
it.
@@ -41,12 +47,15 @@ enum hmm_pfn_flags {
 	HMM_PFN_VALID =3D 1UL << (BITS_PER_LONG - 1),
 	HMM_PFN_WRITE =3D 1UL << (BITS_PER_LONG - 2),
 	HMM_PFN_ERROR =3D 1UL << (BITS_PER_LONG - 3),
+	HMM_PFN_PMD =3D 1UL << (BITS_PER_LONG - 4),
+	HMM_PFN_PUD =3D 1UL << (BITS_PER_LONG - 5),
=20
 	/* Input flags */
 	HMM_PFN_REQ_FAULT =3D HMM_PFN_VALID,
 	HMM_PFN_REQ_WRITE =3D HMM_PFN_WRITE,
=20
-	HMM_PFN_FLAGS =3D HMM_PFN_VALID | HMM_PFN_WRITE | HMM_PFN_ERROR,
+	HMM_PFN_FLAGS =3D HMM_PFN_VALID | HMM_PFN_WRITE | HMM_PFN_ERROR |
+			HMM_PFN_PMD | HMM_PFN_PUD,
 };
=20
 /*
diff --git a/mm/hmm.c b/mm/hmm.c
index e9a545751108..d9de95450be3 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -170,7 +170,9 @@ static inline unsigned long pmd_to_hmm_pfn_flags(struct=
 hmm_range *range,
 {
 	if (pmd_protnone(pmd))
 		return 0;
-	return pmd_write(pmd) ? (HMM_PFN_VALID | HMM_PFN_WRITE) : HMM_PFN_VALID;
+	return pmd_write(pmd) ?
+			(HMM_PFN_VALID | HMM_PFN_PMD | HMM_PFN_WRITE) :
+			(HMM_PFN_VALID | HMM_PFN_PMD);
 }
=20
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -389,7 +391,9 @@ static inline unsigned long pud_to_hmm_pfn_flags(struct=
 hmm_range *range,
 {
 	if (!pud_present(pud))
 		return 0;
-	return pud_write(pud) ? (HMM_PFN_VALID | HMM_PFN_WRITE) : HMM_PFN_VALID;
+	return pud_write(pud) ?
+			(HMM_PFN_VALID | HMM_PFN_PUD | HMM_PFN_WRITE) :
+			(HMM_PFN_VALID | HMM_PFN_PUD);
 }
=20
 static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned lon=
g end,
@@ -468,6 +472,7 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsig=
ned long hmask,
 	unsigned long cpu_flags;
 	spinlock_t *ptl;
 	pte_t entry;
+	unsigned int hshift =3D huge_page_shift(hstate_vma(vma));
=20
 	ptl =3D huge_pte_lock(hstate_vma(vma), walk->mm, pte);
 	entry =3D huge_ptep_get(pte);
@@ -475,6 +480,10 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsi=
gned long hmask,
 	i =3D (start - range->start) >> PAGE_SHIFT;
 	pfn_req_flags =3D range->hmm_pfns[i];
 	cpu_flags =3D pte_to_hmm_pfn_flags(range, entry);
+	if (hshift >=3D PUD_SHIFT)
+		cpu_flags |=3D HMM_PFN_PUD;
+	else if (hshift >=3D PMD_SHIFT)
+		cpu_flags |=3D HMM_PFN_PMD;
 	required_fault =3D
 		hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, cpu_flags);
 	if (required_fault) {
--=20
2.20.1

