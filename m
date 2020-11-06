Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E61B2A8B99
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Nov 2020 01:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732869AbgKFAwH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Nov 2020 19:52:07 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:9238 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732848AbgKFAwG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Nov 2020 19:52:06 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa49e330002>; Thu, 05 Nov 2020 16:52:03 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov
 2020 00:51:59 +0000
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 6 Nov 2020 00:51:59 +0000
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>, <nouveau@lists.freedesktop.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Zi Yan <ziy@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Ben Skeggs <bskeggs@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH v3 2/6] mm/migrate: move migrate_vma_collect_skip()
Date:   Thu, 5 Nov 2020 16:51:43 -0800
Message-ID: <20201106005147.20113-3-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201106005147.20113-1-rcampbell@nvidia.com>
References: <20201106005147.20113-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604623923; bh=c83dvEU/mNjvQk5n1A2ZnS0Sp2WfXEWJ2edrH1gpMns=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=nYe9/jFxdlLp29PUkK4HpOkntA6n5ED8ryHK5XbwUn+CnvdVFi/TVh2/u/bLVBTLT
         QOYpEEx2Mb0H+tLHRT0UoqvExGSDYi/x0rDMIunDuBVjDymLKY5oipbbtn/Z6BFbUR
         lUmWDwbu+iL4Ls29LM094GkxEqYGbyXY/eBX0+5RRKGRaFGKodTb+JqQ5bUaalXCDc
         cpFgmBKpp+wEmu6QjXCHeNdK0sEC3/Sbrhr7qf4hZqg1E4U8KZp7Pu9YVAdsAdxeCI
         x4FBmXyCayDbSdNxohCtD+QNdp4UcB9e1TYIwqxJRTgncr9+T56iuihU561CEYmQ+G
         2su1h0YLDJ37A==
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
index c1585ec29827..665516319b66 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2253,6 +2253,21 @@ int migrate_misplaced_transhuge_page(struct mm_struc=
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
@@ -2281,21 +2296,6 @@ static int migrate_vma_collect_hole(unsigned long st=
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

