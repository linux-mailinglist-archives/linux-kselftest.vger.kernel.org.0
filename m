Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121641CB820
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 May 2020 21:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgEHTU3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 May 2020 15:20:29 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17055 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbgEHTU2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 May 2020 15:20:28 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eb5b0ef0000>; Fri, 08 May 2020 12:20:15 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 08 May 2020 12:20:28 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 08 May 2020 12:20:28 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 8 May
 2020 19:20:26 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 8 May 2020 19:20:26 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5eb5b0f90000>; Fri, 08 May 2020 12:20:25 -0700
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
Subject: [PATCH 4/6] mm/hmm: add output flag for compound page mapping
Date:   Fri, 8 May 2020 12:20:07 -0700
Message-ID: <20200508192009.15302-5-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508192009.15302-1-rcampbell@nvidia.com>
References: <20200508192009.15302-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1588965615; bh=VWezLqS4HMRVGScQgCLLJAXh7u1icGGGw3VQK/+GVjs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=Bb2vO5A2hOIdj0cSUnCngCJ1jAZCVlZ/f3ExAGu4jfMOHizJfCs7hcwT8TggEKy71
         FSGEMOJa6qeJFBqoGrxDNGS/8XBOjVLERYDg7fQ50phKtSk9EAI8M7jGdc4fIaTrEP
         gmQPmqMsAssiwj6YgVNCEElyN6cYU3BlxMXzYLAHcFuScGOU5uZ87xdsWfACk5VVaG
         a9eIBYmwaBYuZNNVfQUt4WOLHoYwsNxhVtXNuvhXGOIcNaq9TeKaJTtlfOAvzQoEMe
         NIz5JRSlDyEk+6reB/J+5FEc13yx67WZcYjmt0oO1i2EWO/9j5C9Y+3hX2M2o32rxH
         cfcJSWIcVJJbw==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

hmm_range_fault() returns an array of page frame numbers and flags for
how the pages are mapped in the requested process' page tables. The PFN
can be used to get the struct page with hmm_pfn_to_page() and the page size
order can be determined with compound_order(page) but if the page is larger
than order 0 (PAGE_SIZE), there is no indication that the page is mapped
using a larger page size. To be fully general, hmm_range_fault() would need
to return the mapping size to handle cases like a 1GB compound page being
mapped with 2MB PMD entries. However, the most common case is the mapping
size the same as the underlying compound page size.
Add a new output flag to indicate this so that callers know it is safe to
use a large device page table mapping if one is available.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 include/linux/hmm.h |  4 +++-
 mm/hmm.c            | 10 +++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index e912b9dc4633..f2d38af421e7 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -41,12 +41,14 @@ enum hmm_pfn_flags {
 	HMM_PFN_VALID =3D 1UL << (BITS_PER_LONG - 1),
 	HMM_PFN_WRITE =3D 1UL << (BITS_PER_LONG - 2),
 	HMM_PFN_ERROR =3D 1UL << (BITS_PER_LONG - 3),
+	HMM_PFN_COMPOUND =3D 1UL << (BITS_PER_LONG - 4),
=20
 	/* Input flags */
 	HMM_PFN_REQ_FAULT =3D HMM_PFN_VALID,
 	HMM_PFN_REQ_WRITE =3D HMM_PFN_WRITE,
=20
-	HMM_PFN_FLAGS =3D HMM_PFN_VALID | HMM_PFN_WRITE | HMM_PFN_ERROR,
+	HMM_PFN_FLAGS =3D HMM_PFN_VALID | HMM_PFN_WRITE | HMM_PFN_ERROR |
+			HMM_PFN_COMPOUND,
 };
=20
 /*
diff --git a/mm/hmm.c b/mm/hmm.c
index 41673a6d8d46..a9dd06e190a1 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -170,7 +170,9 @@ static inline unsigned long pmd_to_hmm_pfn_flags(struct=
 hmm_range *range,
 {
 	if (pmd_protnone(pmd))
 		return 0;
-	return pmd_write(pmd) ? (HMM_PFN_VALID | HMM_PFN_WRITE) : HMM_PFN_VALID;
+	return pmd_write(pmd) ?
+			(HMM_PFN_VALID | HMM_PFN_COMPOUND | HMM_PFN_WRITE) :
+			(HMM_PFN_VALID | HMM_PFN_COMPOUND);
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
+			(HMM_PFN_VALID | HMM_PFN_COMPOUND | HMM_PFN_WRITE) :
+			(HMM_PFN_VALID | HMM_PFN_COMPOUND);
 }
=20
 static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned lon=
g end,
@@ -484,7 +488,7 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsig=
ned long hmask,
=20
 	pfn =3D pte_pfn(entry) + ((start & ~hmask) >> PAGE_SHIFT);
 	for (; addr < end; addr +=3D PAGE_SIZE, i++, pfn++)
-		range->hmm_pfns[i] =3D pfn | cpu_flags;
+		range->hmm_pfns[i] =3D pfn | cpu_flags | HMM_PFN_COMPOUND;
=20
 	spin_unlock(ptl);
 	return 0;
--=20
2.20.1

