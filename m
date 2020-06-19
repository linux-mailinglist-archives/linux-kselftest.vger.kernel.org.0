Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50486201D96
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jun 2020 23:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgFSV6V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Jun 2020 17:58:21 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2228 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbgFSV5I (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Jun 2020 17:57:08 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eed34a60004>; Fri, 19 Jun 2020 14:56:54 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 19 Jun 2020 14:57:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 19 Jun 2020 14:57:07 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 19 Jun
 2020 21:56:59 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 19 Jun 2020 21:56:59 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5eed34ab000d>; Fri, 19 Jun 2020 14:56:59 -0700
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
Subject: [PATCH 12/16] mm/hmm: optimize migrate_vma_setup() for holes
Date:   Fri, 19 Jun 2020 14:56:45 -0700
Message-ID: <20200619215649.32297-13-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200619215649.32297-1-rcampbell@nvidia.com>
References: <20200619215649.32297-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592603814; bh=axo1qROEDM7hJwmmu8OcpvGAO/8DiPu78Ea49fo3JP8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=NIxcE9Fdl7sawaTciO5YlsjyXWpVEzFy0PbON2Sjk/IyFNSrBJ3Z0/rsrrAxkjrPQ
         Gf9NZudc7Nbt8Zl7jnG+RRXt4NWhRcV1pDwSpZrAuJLTXo3sCmo+0KRW4p1KpP1C2O
         IGlJdkSh1pbgcUuFPE/eHS9ARNZCW+Vct1T3yR8P47uoaS0F8MUoGYnVrVSCAeuAAL
         Wa0mn3fQfKu6brwDG1bL1YBu9wmXB2HDxw8Ozxh5DG7e9SaU/k/qtMIomYAX5KoRsN
         dROV2rrac8AawgKXAEL67b2guP7Gye49n/ClaiscMGrEh5ewh1ZOYWwMOdfQ2WKXZS
         jeiLsbDR/xcHw==
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
the device driver to allocate device private memory and then throwing
it away. Instead, mark the source PFN array entries as not migrating to
avoid this overhead.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 mm/migrate.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 24535281cea3..87c52e0ee580 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2178,9 +2178,13 @@ static int migrate_vma_collect_hole(unsigned long st=
art,
 {
 	struct migrate_vma *migrate =3D walk->private;
 	unsigned long addr;
+	unsigned long flags;
+
+	/* Only allow populating anonymous memory */
+	flags =3D vma_is_anonymous(walk->vma) ? MIGRATE_PFN_MIGRATE : 0;
=20
 	for (addr =3D start; addr < end; addr +=3D PAGE_SIZE) {
-		migrate->src[migrate->npages] =3D MIGRATE_PFN_MIGRATE;
+		migrate->src[migrate->npages] =3D flags;
 		migrate->dst[migrate->npages] =3D 0;
 		migrate->npages++;
 		migrate->cpages++;
@@ -2748,7 +2752,7 @@ static void migrate_vma_insert_page(struct migrate_vm=
a *migrate,
 	pte_t *ptep;
=20
 	/* Only allow populating anonymous memory */
-	if (!vma_is_anonymous(vma))
+	if (WARN_ON_ONCE(!vma_is_anonymous(vma)))
 		goto abort;
=20
 	pgdp =3D pgd_offset(mm, addr);
--=20
2.20.1

