Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7451F25B284
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Sep 2020 19:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgIBRBE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Sep 2020 13:01:04 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12897 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbgIBQ6j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Sep 2020 12:58:39 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4fcf2e0003>; Wed, 02 Sep 2020 09:58:22 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 02 Sep 2020 09:58:36 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 02 Sep 2020 09:58:36 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Sep
 2020 16:58:35 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 2 Sep 2020 16:58:35 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f4fcf3b0005>; Wed, 02 Sep 2020 09:58:35 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>, <nouveau@lists.freedesktop.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Ben Skeggs <bskeggs@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH v2 2/7] mm/migrate: move migrate_vma_collect_skip()
Date:   Wed, 2 Sep 2020 09:58:25 -0700
Message-ID: <20200902165830.5367-3-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200902165830.5367-1-rcampbell@nvidia.com>
References: <20200902165830.5367-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599065902; bh=oATABFM4AEF4PG+JY10uewS8j4geL66qhQa5ZF2kPD8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=B77jHf3y79/2XEe/LYHBFYAuS7tNokE/fPkCaOiD2Zzy/OfnFzHxs8qES48AKO200
         AFdxhEIGisWoadUewWILipVMHr8CChvUPlE7/bE3g908d1bNfESUMYGblvJsKruIOZ
         E8DH3bdqqhleXqqcRXIajrrf5dfd3+jeSzTtO55EtCP2ja+Ptjyb8uE62VWXaeWxY/
         YifNhlvTBxLDaoCskQThXbxSKHv9rlNuTU4whUznLptJsH+NL0w0tnR7XjF1wbtdFt
         +jStmy9f267ONZ/jgCJlXupvNqXFuDsKMEOHnHvYdpdnAUPiRtG+8nwipElzH+T27t
         NTP5Yp3jPxpjQ==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Move the definition of migrate_vma_collect_skip() to make it callable
by migrate_vma_collect_hole(). This helps make the next patch easier
to read.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 mm/migrate.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 4f89360d9e77..ce16ed3deab6 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2254,6 +2254,21 @@ int migrate_misplaced_transhuge_page(struct mm_struc=
t *mm,
 #endif /* CONFIG_NUMA */
=20
 #ifdef CONFIG_DEVICE_PRIVATE
+static int migrate_vma_collect_skip(unsigned long start,
+				    unsigned long end,
+				    struct mm_walk *walk)
+{
+	struct migrate_vma *migrate =3D walk->private;
+	unsigned long addr;
+
+	for (addr =3D start; addr < end; addr +=3D PAGE_SIZE) {
+		migrate->dst[migrate->npages] =3D 0;
+		migrate->src[migrate->npages++] =3D 0;
+	}
+
+	return 0;
+}
+
 static int migrate_vma_collect_hole(unsigned long start,
 				    unsigned long end,
 				    __always_unused int depth,
@@ -2282,21 +2297,6 @@ static int migrate_vma_collect_hole(unsigned long st=
art,
 	return 0;
 }
=20
-static int migrate_vma_collect_skip(unsigned long start,
-				    unsigned long end,
-				    struct mm_walk *walk)
-{
-	struct migrate_vma *migrate =3D walk->private;
-	unsigned long addr;
-
-	for (addr =3D start; addr < end; addr +=3D PAGE_SIZE) {
-		migrate->dst[migrate->npages] =3D 0;
-		migrate->src[migrate->npages++] =3D 0;
-	}
-
-	return 0;
-}
-
 static int migrate_vma_collect_pmd(pmd_t *pmdp,
 				   unsigned long start,
 				   unsigned long end,
--=20
2.20.1

