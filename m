Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C49201D82
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jun 2020 23:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgFSV5N (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Jun 2020 17:57:13 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4433 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728256AbgFSV5I (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Jun 2020 17:57:08 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eed34800004>; Fri, 19 Jun 2020 14:56:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 19 Jun 2020 14:57:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 19 Jun 2020 14:57:07 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 19 Jun
 2020 21:56:59 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 19 Jun 2020 21:56:59 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5eed34ab000a>; Fri, 19 Jun 2020 14:56:59 -0700
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
        Shuah Khan <shuah@kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH 09/16] mm/hmm: add output flag for compound page mapping
Date:   Fri, 19 Jun 2020 14:56:42 -0700
Message-ID: <20200619215649.32297-10-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200619215649.32297-1-rcampbell@nvidia.com>
References: <20200619215649.32297-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592603776; bh=JPgQkHIpNzBsyjWBqEqB+kAjfFMrODd+Eb4Y45RUY/w=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=WZIOlNEQWncuTcywertFlHcnMuAxg3zWmP9O70STDKDcbRFB57tRuceh7ta4wz9k+
         CYHdRm/RmK+LnY1pOz8UdaLCLoSkZdQU03Dd0ug+WIvbJsqCszfEPEL/wm9zWiJw0y
         fuB5hh+gv1MgU01BmnKjpRl7s9OP//5ILxDijPEYJPbOEv45V1iJhr+WxJzkQOUaoo
         h3+tQ48LakW8p5M8A9IS6dKTTaQ17xHmqaluKWc6r3+3sVj49DjmsIfhronpIaSRtG
         i8Mr5Uuaxm1HIyAb8v5POXXV9Bkeec4QfJ8I97rzH0SpDXZpnNnJlA2W+Tx7ZWROLW
         vy88FBsN/ROJA==
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
size is the same as the underlying compound page size.
Add a new output flag to indicate this so that callers know it is safe to
use a large device page table mapping if one is available.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 include/linux/hmm.h |  4 +++-
 mm/hmm.c            | 10 +++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index f4a09ed223ac..d0db78025baa 100644
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
index e9a545751108..d145d44256df 100644
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

