Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99BE414F60F
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Feb 2020 04:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgBADkf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Jan 2020 22:40:35 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11549 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgBADkf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Jan 2020 22:40:35 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e34f3240000>; Fri, 31 Jan 2020 19:40:20 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 31 Jan 2020 19:40:34 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 31 Jan 2020 19:40:34 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 1 Feb
 2020 03:40:34 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 1 Feb 2020 03:40:33 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e34f3310000>; Fri, 31 Jan 2020 19:40:33 -0800
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
Subject: [PATCH v3 01/12] mm: dump_page(): better diagnostics for compound pages
Date:   Fri, 31 Jan 2020 19:40:18 -0800
Message-ID: <20200201034029.4063170-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200201034029.4063170-1-jhubbard@nvidia.com>
References: <20200201034029.4063170-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580528420; bh=iEHx9VxUswj/Tdrgroo0JwdM/JRuVE7oL68Xhz3dQSA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=PEsKAxArjDtswBzqAgz5af48cL0UI4f9D2NDq60bxbMuvJ2drmwUFCZn7pRQafO+Z
         2yg7FgVo5uMLrBcOb5AsA5Y04DFJTu+V2TMf+3P3z3LCMWRUwwdxVbJ7RfjnFEpCt5
         dhfIaZJ5YW3hAcui5d2gmpKyKzCW5H3vsygO4nRVTTH5HfylruNT26nQtKebTP1Qzv
         EQLH9JaRTbDqIB/Udh1i8ReYrZsbJtxa/JOqflC4QrYY4lEji3oGVMLd8UZhs6/3ti
         xicmmR4iZVJnNpsZdThIpEgT4efffPSsfJ3VmwS2Sl0u3fvuv5vvBnsCPU7O4YxU3f
         hVS+vy5A+IZaA==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A compound page collects the refcount in the head page, while leaving
the refcount of each tail page at zero. Therefore, when debugging a
problem that involves compound pages, it's best to have diagnostics that
reflect that situation. However, dump_page() is oblivious to these
points.

Change dump_page() as follows:

1) For tail pages, print relevant head page information: refcount, in
   particular. But only do this if the page is not corrupted so badly
   that the pointer to the head page is all wrong.

2) Do a separate check to catch any (rare) cases of the tail page's
   refcount being non-zero, and issue a separate, clear pr_warn() if
   that ever happens.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/debug.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/mm/debug.c b/mm/debug.c
index ecccd9f17801..beb1c59d784b 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -42,6 +42,32 @@ const struct trace_print_flags vmaflag_names[] =3D {
 	{0, NULL}
 };
=20
+static void __dump_tail_page(struct page *page, int mapcount)
+{
+	struct page *head =3D compound_head(page);
+
+	if ((page < head) || (page >=3D head + MAX_ORDER_NR_PAGES)) {
+		/*
+		 * Page is hopelessly corrupted, so limit any reporting to
+		 * information about the page itself. Do not attempt to look at
+		 * the head page.
+		 */
+		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px "
+			"index:%#lx (corrupted tail page case)\n",
+			page, page_ref_count(page), mapcount, page->mapping,
+			page_to_pgoff(page));
+	} else {
+		pr_warn("page:%px compound refcount:%d mapcount:%d mapping:%px "
+			"index:%#lx compound_mapcount:%d\n",
+			page, page_ref_count(head), mapcount, head->mapping,
+			page_to_pgoff(head), compound_mapcount(page));
+	}
+
+	if (page_ref_count(page) !=3D 0)
+		pr_warn("page:%px PROBLEM: non-zero refcount (=3D=3D%d) on this "
+			"tail page\n", page, page_ref_count(page));
+}
+
 void __dump_page(struct page *page, const char *reason)
 {
 	struct address_space *mapping;
@@ -75,12 +101,8 @@ void __dump_page(struct page *page, const char *reason)
 	 */
 	mapcount =3D PageSlab(page) ? 0 : page_mapcount(page);
=20
-	if (PageCompound(page))
-		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px "
-			"index:%#lx compound_mapcount: %d\n",
-			page, page_ref_count(page), mapcount,
-			page->mapping, page_to_pgoff(page),
-			compound_mapcount(page));
+	if (PageTail(page))
+		__dump_tail_page(page, mapcount);
 	else
 		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px index:%#lx\n",
 			page, page_ref_count(page), mapcount,
--=20
2.25.0

