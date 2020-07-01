Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCA0211658
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jul 2020 00:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgGAWyQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Jul 2020 18:54:16 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11108 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgGAWyM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Jul 2020 18:54:12 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efd14060000>; Wed, 01 Jul 2020 15:53:58 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 01 Jul 2020 15:54:11 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 01 Jul 2020 15:54:11 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 1 Jul
 2020 22:54:05 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 1 Jul 2020 22:54:04 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5efd140c0003>; Wed, 01 Jul 2020 15:54:04 -0700
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
Subject: [PATCH v3 2/5] mm/hmm: add hmm_mapping order
Date:   Wed, 1 Jul 2020 15:53:49 -0700
Message-ID: <20200701225352.9649-3-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200701225352.9649-1-rcampbell@nvidia.com>
References: <20200701225352.9649-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593644038; bh=QIsEZqbLvhcQoLnMvSAHErQh7jEwxSDePYae1M0TgTw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=qGrw+GXvPSZE4UosuLbuzYzIM8D4t4zlG/ZzYIfBvWR10l0FBWcsRjy6kjA9kU+t6
         tXtxPoyHtQ4oROheBAveLWSbfPQQwdjwh/hIF7eMHI8SBQE5Xw4/bhPc3ddo2xgPvM
         ZyOUqRg9/MVBziDyF3uh+j3Je8hV8btGSbCWXdlUdISCSnh147FfoKAwpQay4LNaJK
         Gv+P3FJIGrD454qZyYMfq7yeqe+bR9gYVCbJ0VvE3uTtdVU+ruy64wK3Gj6QWePMWv
         E1vsWugLL0VYJaEQ71iSLO1qSzT7PLGYC4MSkiML3NTKh0qmOGe+Ki2AK0O1oD8oZi
         aXwasCqj4+2fw==
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

Add a new function hmm_pfn_to_map_order() to return the mapping size
order so that callers know the pages are being mapped with consistent
permissions and a large device page table mapping can be used if one is
available.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 include/linux/hmm.h | 24 ++++++++++++++++++++++--
 mm/hmm.c            | 14 +++++++++++---
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index f4a09ed223ac..e7a21a21f11f 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -37,16 +37,17 @@
  *                     will fail. Must be combined with HMM_PFN_REQ_FAULT.
  */
 enum hmm_pfn_flags {
-	/* Output flags */
+	/* Output fields and flags */
 	HMM_PFN_VALID =3D 1UL << (BITS_PER_LONG - 1),
 	HMM_PFN_WRITE =3D 1UL << (BITS_PER_LONG - 2),
 	HMM_PFN_ERROR =3D 1UL << (BITS_PER_LONG - 3),
+	HMM_PFN_ORDER_SHIFT =3D (BITS_PER_LONG - 8),
=20
 	/* Input flags */
 	HMM_PFN_REQ_FAULT =3D HMM_PFN_VALID,
 	HMM_PFN_REQ_WRITE =3D HMM_PFN_WRITE,
=20
-	HMM_PFN_FLAGS =3D HMM_PFN_VALID | HMM_PFN_WRITE | HMM_PFN_ERROR,
+	HMM_PFN_FLAGS =3D 0xFFUL << HMM_PFN_ORDER_SHIFT,
 };
=20
 /*
@@ -61,6 +62,25 @@ static inline struct page *hmm_pfn_to_page(unsigned long=
 hmm_pfn)
 	return pfn_to_page(hmm_pfn & ~HMM_PFN_FLAGS);
 }
=20
+/*
+ * hmm_pfn_to_map_order() - return the CPU mapping size order
+ *
+ * The hmm_pfn entry returned by hmm_range_fault() is for a PAGE_SIZE
+ * address range. hmm_pfn_to_map_order() lets the caller know that the
+ * underlying physical page order is at least as large as the return value=
 and
+ * that the CPU has mapped that physical range with the same permissions s=
o
+ * that a device MMU mapping of up to the size of the return value can be
+ * used without giving the device more access than the CPU process.
+ *
+ * This must be called under the caller 'user_lock' after a successful
+ * mmu_interval_read_begin(). The caller must have tested for HMM_PFN_VALI=
D
+ * already.
+ */
+static inline unsigned int hmm_pfn_to_map_order(unsigned long hmm_pfn)
+{
+	return (hmm_pfn >> HMM_PFN_ORDER_SHIFT) & 0x1F;
+}
+
 /*
  * struct hmm_range - track invalidation lock on virtual address range
  *
diff --git a/mm/hmm.c b/mm/hmm.c
index e9a545751108..de04bbed47b3 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -170,7 +170,10 @@ static inline unsigned long pmd_to_hmm_pfn_flags(struc=
t hmm_range *range,
 {
 	if (pmd_protnone(pmd))
 		return 0;
-	return pmd_write(pmd) ? (HMM_PFN_VALID | HMM_PFN_WRITE) : HMM_PFN_VALID;
+	return ((unsigned long)(PMD_SHIFT - PAGE_SHIFT) <<
+			HMM_PFN_ORDER_SHIFT) |
+		pmd_write(pmd) ? (HMM_PFN_VALID | HMM_PFN_WRITE) :
+				 HMM_PFN_VALID;
 }
=20
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -389,7 +392,10 @@ static inline unsigned long pud_to_hmm_pfn_flags(struc=
t hmm_range *range,
 {
 	if (!pud_present(pud))
 		return 0;
-	return pud_write(pud) ? (HMM_PFN_VALID | HMM_PFN_WRITE) : HMM_PFN_VALID;
+	return ((unsigned long)(PUD_SHIFT - PAGE_SHIFT) <<
+			HMM_PFN_ORDER_SHIFT) |
+		pud_write(pud) ? (HMM_PFN_VALID | HMM_PFN_WRITE) :
+				 HMM_PFN_VALID;
 }
=20
 static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned lon=
g end,
@@ -468,13 +474,15 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, uns=
igned long hmask,
 	unsigned long cpu_flags;
 	spinlock_t *ptl;
 	pte_t entry;
+	unsigned long horder =3D huge_page_order(hstate_vma(vma));
=20
 	ptl =3D huge_pte_lock(hstate_vma(vma), walk->mm, pte);
 	entry =3D huge_ptep_get(pte);
=20
 	i =3D (start - range->start) >> PAGE_SHIFT;
 	pfn_req_flags =3D range->hmm_pfns[i];
-	cpu_flags =3D pte_to_hmm_pfn_flags(range, entry);
+	cpu_flags =3D pte_to_hmm_pfn_flags(range, entry) |
+			(horder << HMM_PFN_ORDER_SHIFT);
 	required_fault =3D
 		hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, cpu_flags);
 	if (required_fault) {
--=20
2.20.1

