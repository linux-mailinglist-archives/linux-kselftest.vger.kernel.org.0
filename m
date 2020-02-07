Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8876D15512F
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2020 04:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgBGDiO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Feb 2020 22:38:14 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4794 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727571AbgBGDhl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Feb 2020 22:37:41 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3cdb460000>; Thu, 06 Feb 2020 19:36:38 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 06 Feb 2020 19:37:37 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 06 Feb 2020 19:37:37 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Feb
 2020 03:37:37 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 7 Feb 2020 03:37:36 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e3cdb800007>; Thu, 06 Feb 2020 19:37:36 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v5 05/12] mm/gup: pass gup flags to two more routines
Date:   Thu, 6 Feb 2020 19:37:28 -0800
Message-ID: <20200207033735.308000-6-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207033735.308000-1-jhubbard@nvidia.com>
References: <20200207033735.308000-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581046598; bh=+TuU8OOcGV+ejGVFCndVV6S1iiJ5m64AX+o6oBv/wIw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=LUxasBJoN7P30/xAEnxWVKJg6G6A361EKR/cysoA4VHWOyt9C/Pc0l/xBI0VHnJPm
         3rfu7+Rw25fCotPP2iyg5IkmU1y/7CyHH7WIRmIPAcyY2h1deS4FsJpZtZJTjdm1Sd
         WHewDvSSvtqkNyPqBhU9GJMLe3hEz0uKqJa5USBT42Lpu9JmUrq1Seg4KLgnrrDWXY
         hbA2TdjTcYFIcDT5VfNi0KJb+Y3Lxa7a8IZH+W86x9QPFzcddFI5AFIPovKdYnYUas
         kYPv4lMZoStKZkZNc6P2NTBoIRshoitEDkeeAKr8g0mSmVuSGNyWO7w68EA900sIQO
         OsUJZcIVSt9vw==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In preparation for an upcoming patch, send gup flags args to two more
routines: put_compound_head(), and undo_dev_pagemap().

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/gup.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 9e117998274c..e5f75e886663 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1870,6 +1870,7 @@ static inline pte_t gup_get_pte(pte_t *ptep)
 #endif /* CONFIG_GUP_GET_PTE_LOW_HIGH */
=20
 static void __maybe_unused undo_dev_pagemap(int *nr, int nr_start,
+					    unsigned int flags,
 					    struct page **pages)
 {
 	while ((*nr) - nr_start) {
@@ -1909,7 +1910,7 @@ static int gup_pte_range(pmd_t pmd, unsigned long add=
r, unsigned long end,
=20
 			pgmap =3D get_dev_pagemap(pte_pfn(pte), pgmap);
 			if (unlikely(!pgmap)) {
-				undo_dev_pagemap(nr, nr_start, pages);
+				undo_dev_pagemap(nr, nr_start, flags, pages);
 				goto pte_unmap;
 			}
 		} else if (pte_special(pte))
@@ -1974,7 +1975,7 @@ static int __gup_device_huge(unsigned long pfn, unsig=
ned long addr,
=20
 		pgmap =3D get_dev_pagemap(pfn, pgmap);
 		if (unlikely(!pgmap)) {
-			undo_dev_pagemap(nr, nr_start, pages);
+			undo_dev_pagemap(nr, nr_start, flags, pages);
 			return 0;
 		}
 		SetPageReferenced(page);
@@ -2001,7 +2002,7 @@ static int __gup_device_huge_pmd(pmd_t orig, pmd_t *p=
mdp, unsigned long addr,
 		return 0;
=20
 	if (unlikely(pmd_val(orig) !=3D pmd_val(*pmdp))) {
-		undo_dev_pagemap(nr, nr_start, pages);
+		undo_dev_pagemap(nr, nr_start, flags, pages);
 		return 0;
 	}
 	return 1;
@@ -2019,7 +2020,7 @@ static int __gup_device_huge_pud(pud_t orig, pud_t *p=
udp, unsigned long addr,
 		return 0;
=20
 	if (unlikely(pud_val(orig) !=3D pud_val(*pudp))) {
-		undo_dev_pagemap(nr, nr_start, pages);
+		undo_dev_pagemap(nr, nr_start, flags, pages);
 		return 0;
 	}
 	return 1;
@@ -2053,7 +2054,7 @@ static int record_subpages(struct page *page, unsigne=
d long addr,
 	return nr;
 }
=20
-static void put_compound_head(struct page *page, int refs)
+static void put_compound_head(struct page *page, int refs, unsigned int fl=
ags)
 {
 	VM_BUG_ON_PAGE(page_ref_count(page) < refs, page);
 	/*
@@ -2103,7 +2104,7 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz,=
 unsigned long addr,
 		return 0;
=20
 	if (unlikely(pte_val(pte) !=3D pte_val(*ptep))) {
-		put_compound_head(head, refs);
+		put_compound_head(head, refs, flags);
 		return 0;
 	}
=20
@@ -2163,7 +2164,7 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsi=
gned long addr,
 		return 0;
=20
 	if (unlikely(pmd_val(orig) !=3D pmd_val(*pmdp))) {
-		put_compound_head(head, refs);
+		put_compound_head(head, refs, flags);
 		return 0;
 	}
=20
@@ -2197,7 +2198,7 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsi=
gned long addr,
 		return 0;
=20
 	if (unlikely(pud_val(orig) !=3D pud_val(*pudp))) {
-		put_compound_head(head, refs);
+		put_compound_head(head, refs, flags);
 		return 0;
 	}
=20
@@ -2226,7 +2227,7 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsi=
gned long addr,
 		return 0;
=20
 	if (unlikely(pgd_val(orig) !=3D pgd_val(*pgdp))) {
-		put_compound_head(head, refs);
+		put_compound_head(head, refs, flags);
 		return 0;
 	}
=20
--=20
2.25.0

