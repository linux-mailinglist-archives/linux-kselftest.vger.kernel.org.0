Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52E621A54F
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jul 2020 18:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgGIQ5b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Jul 2020 12:57:31 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7900 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbgGIQ52 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Jul 2020 12:57:28 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f074c6b0000>; Thu, 09 Jul 2020 09:57:15 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 09 Jul 2020 09:57:27 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 09 Jul 2020 09:57:27 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 9 Jul
 2020 16:57:19 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 9 Jul 2020 16:57:19 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f074c6f0004>; Thu, 09 Jul 2020 09:57:19 -0700
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
Subject: [PATCH 1/2] mm/migrate: optimize migrate_vma_setup() for holes
Date:   Thu, 9 Jul 2020 09:57:10 -0700
Message-ID: <20200709165711.26584-2-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200709165711.26584-1-rcampbell@nvidia.com>
References: <20200709165711.26584-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594313835; bh=B2D/nS1wOmFM1BnqXCP74e2MZLq0Kn5AbDcOovgyNoI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=ohj96eQbydmV4kRF027+IYlNfuLSjZlOYmKTmjsLUdErYCgeG6G8GXVP1Ch1NvqKb
         VfQRNMApdYINbV1gCcw6ZXWDH5J2+QkMq6sNFAyjDF9vBnhk+O5aJGcOgeh+fNKaMx
         T3GXHedfsKe/5bYAi55X+WOqB8N7JNB9k4xcuKmYp1JclNurGSFI3Mq0uhgk5+L1qW
         MK4Mn98Zi+NIYIjqp0rG4VeUe2XMUUWdV8rzL12AzXnvYVVOl5t2Ymre5SbnJvIsoI
         Wa7HzIflxlyLka8WbWknLVDVyxq2jC4gMKobdNPT04IKAl8gefMk1ccDGJ+RKCECZG
         h5HrfNG2JVhKg==
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
 mm/migrate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index b0125c082549..8aa434691577 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2204,9 +2204,13 @@ static int migrate_vma_collect_hole(unsigned long st=
art,
 {
 	struct migrate_vma *migrate =3D walk->private;
 	unsigned long addr;
+	unsigned long flags;
+
+	/* Only allow populating anonymous memory. */
+	flags =3D vma_is_anonymous(walk->vma) ? MIGRATE_PFN_MIGRATE : 0;
=20
 	for (addr =3D start; addr < end; addr +=3D PAGE_SIZE) {
-		migrate->src[migrate->npages] =3D MIGRATE_PFN_MIGRATE;
+		migrate->src[migrate->npages] =3D flags;
 		migrate->dst[migrate->npages] =3D 0;
 		migrate->npages++;
 		migrate->cpages++;
--=20
2.20.1

