Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7F421BE17
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jul 2020 21:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgGJTsy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Jul 2020 15:48:54 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:8953 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgGJTsx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Jul 2020 15:48:53 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f08c5ed0001>; Fri, 10 Jul 2020 12:47:57 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 10 Jul 2020 12:48:52 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 10 Jul 2020 12:48:52 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Jul
 2020 19:48:44 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 10 Jul 2020 19:48:44 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f08c61b0004>; Fri, 10 Jul 2020 12:48:43 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>, <kvm-ppc@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Bharata B Rao" <bharata@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH v2 1/2] mm/migrate: optimize migrate_vma_setup() for holes
Date:   Fri, 10 Jul 2020 12:48:39 -0700
Message-ID: <20200710194840.7602-2-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200710194840.7602-1-rcampbell@nvidia.com>
References: <20200710194840.7602-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594410477; bh=fLw8+ET8EX18iQaLOuhjIJoogqKfyzo8y2yP1A5lMaw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=ga6KBvPWBeVAdpmR/8OGEVWtb6iWJgldqB2dmWrazl0p1FDBkEOWDednMS+wIIoF4
         Ryx27RouC8U2kaNRyiBWcb/xC5ESOundzlKOEPrnnvuHB9Y+3L/0W8wMDwV5iBLDd8
         f6JJ9rbAeB+BM4iAa44NkKzLOcKbj/1O+AqOzPmORHi3rpZ2CDUxgEph+SyMJ6zt2X
         kH46qwF2N8KCa1FrlrW1o2SEzAhfvHUPn3GlVBuI/T3W585/m9CeV9CMeXZnGqQuNW
         I9ZSusRFgaUBeOjyLAF4AZ2gS9kAZxj+0e4EInB2bmXLo9/ESeFwUZ9GUYC/SjlJds
         I6BecbTCZti5A==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When migrating system memory to device private memory, if the source
address range is a valid VMA range and there is no memory or a zero page,
the source PFN array is marked as valid but with no PFN. This lets the
device driver allocate private memory and clear it, then insert the new
device private struct page into the CPU's page tables when
migrate_vma_pages() is called. migrate_vma_pages() only inserts the
new page if the VMA is an anonymous range. There is no point in telling
the device driver to allocate device private memory and then not migrate
the page. Instead, mark the source PFN array entries as not migrating to
avoid this overhead.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 mm/migrate.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index b0125c082549..ec00b7a6ea2a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2205,6 +2205,16 @@ static int migrate_vma_collect_hole(unsigned long st=
art,
 	struct migrate_vma *migrate =3D walk->private;
 	unsigned long addr;
=20
+	/* Only allow populating anonymous memory. */
+	if (!vma_is_anonymous(walk->vma)) {
+		for (addr =3D start; addr < end; addr +=3D PAGE_SIZE) {
+			migrate->src[migrate->npages] =3D 0;
+			migrate->dst[migrate->npages] =3D 0;
+			migrate->npages++;
+		}
+		return 0;
+	}
+
 	for (addr =3D start; addr < end; addr +=3D PAGE_SIZE) {
 		migrate->src[migrate->npages] =3D MIGRATE_PFN_MIGRATE;
 		migrate->dst[migrate->npages] =3D 0;
@@ -2297,8 +2307,10 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 		pte =3D *ptep;
=20
 		if (pte_none(pte)) {
-			mpfn =3D MIGRATE_PFN_MIGRATE;
-			migrate->cpages++;
+			if (vma_is_anonymous(vma)) {
+				mpfn =3D MIGRATE_PFN_MIGRATE;
+				migrate->cpages++;
+			}
 			goto next;
 		}
=20
--=20
2.20.1

