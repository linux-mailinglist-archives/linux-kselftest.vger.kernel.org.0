Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78BBF216181
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jul 2020 00:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgGFWYK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Jul 2020 18:24:10 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1770 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbgGFWYJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Jul 2020 18:24:09 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f03a4530002>; Mon, 06 Jul 2020 15:23:15 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 06 Jul 2020 15:24:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 06 Jul 2020 15:24:08 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Jul
 2020 22:23:58 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 6 Jul 2020 22:23:58 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f03a47e0009>; Mon, 06 Jul 2020 15:23:58 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        <nouveau@lists.freedesktop.org>, <kvm-ppc@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "Ben Skeggs" <bskeggs@redhat.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        "Ralph Campbell" <rcampbell@nvidia.com>
Subject: [PATCH 5/5] mm/hmm/test: use the new migration invalidation
Date:   Mon, 6 Jul 2020 15:23:47 -0700
Message-ID: <20200706222347.32290-6-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200706222347.32290-1-rcampbell@nvidia.com>
References: <20200706222347.32290-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594074195; bh=kgnsv7iVAI/kXfctFPCsW2QnU6XTpmeohMoPVouzWVs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=oObkPYI+R1CqoLcqZa2YtQ3GzSAl0oyJCPs20fvcCYe0RShZ4D6Fz1RZ7TlTc7a5R
         f/qeoM7GIcjjIPYpw+vehCbgVbgHryq1qA5E77uP6+eToA2HrHkmwX7I1lEuErOV1F
         MAP9uoTwWP98pOC+Lpq39BpxzJBOhfhYLDaXIeiQYH2pTZyfUvUh9jxDUBOikB7GWl
         qHzh9TOjDaVXS7bdXO15v0twfFSMWIjPbtj/WfyQ6SH/Fj7PenVdj2y6wd2zPXFxS2
         BUS9tgWbx9FnMHABfyPxACGypj9j5Js++ovrOSNLK3dAkds/oabG1sArzxUhNLi4gz
         ne59VYb+JBBGQ==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use the new MMU_NOTIFY_MIGRATE event to skip MMU invalidations of device
private memory and handle the invalidation in the driver as part of
migrating device private memory.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 lib/test_hmm.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 1bd60cfb5a25..a170e5f7fb2e 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -214,6 +214,14 @@ static bool dmirror_interval_invalidate(struct mmu_int=
erval_notifier *mni,
 {
 	struct dmirror *dmirror =3D container_of(mni, struct dmirror, notifier);
=20
+	/*
+	 * Ignore invalidation callbacks for device private pages since
+	 * the invalidation is handled as part of the migration process.
+	 */
+	if (range->event =3D=3D MMU_NOTIFY_MIGRATE &&
+	    range->data =3D=3D dmirror->mdevice)
+		return true;
+
 	if (mmu_notifier_range_blockable(range))
 		mutex_lock(&dmirror->mutex);
 	else if (!mutex_trylock(&dmirror->mutex))
@@ -702,7 +710,7 @@ static int dmirror_migrate(struct dmirror *dmirror,
 		args.dst =3D dst_pfns;
 		args.start =3D addr;
 		args.end =3D next;
-		args.src_owner =3D NULL;
+		args.src_owner =3D dmirror->mdevice;
 		args.dir =3D MIGRATE_VMA_FROM_SYSTEM;
 		ret =3D migrate_vma_setup(&args);
 		if (ret)
@@ -992,7 +1000,7 @@ static void dmirror_devmem_free(struct page *page)
 }
=20
 static vm_fault_t dmirror_devmem_fault_alloc_and_copy(struct migrate_vma *=
args,
-						struct dmirror_device *mdevice)
+						      struct dmirror *dmirror)
 {
 	const unsigned long *src =3D args->src;
 	unsigned long *dst =3D args->dst;
@@ -1014,6 +1022,7 @@ static vm_fault_t dmirror_devmem_fault_alloc_and_copy=
(struct migrate_vma *args,
 			continue;
=20
 		lock_page(dpage);
+		xa_erase(&dmirror->pt, addr >> PAGE_SHIFT);
 		copy_highpage(dpage, spage);
 		*dst =3D migrate_pfn(page_to_pfn(dpage)) | MIGRATE_PFN_LOCKED;
 		if (*src & MIGRATE_PFN_WRITE)
@@ -1022,15 +1031,6 @@ static vm_fault_t dmirror_devmem_fault_alloc_and_cop=
y(struct migrate_vma *args,
 	return 0;
 }
=20
-static void dmirror_devmem_fault_finalize_and_map(struct migrate_vma *args=
,
-						  struct dmirror *dmirror)
-{
-	/* Invalidate the device's page table mapping. */
-	mutex_lock(&dmirror->mutex);
-	dmirror_do_update(dmirror, args->start, args->end);
-	mutex_unlock(&dmirror->mutex);
-}
-
 static vm_fault_t dmirror_devmem_fault(struct vm_fault *vmf)
 {
 	struct migrate_vma args;
@@ -1060,11 +1060,16 @@ static vm_fault_t dmirror_devmem_fault(struct vm_fa=
ult *vmf)
 	if (migrate_vma_setup(&args))
 		return VM_FAULT_SIGBUS;
=20
-	ret =3D dmirror_devmem_fault_alloc_and_copy(&args, dmirror->mdevice);
+	ret =3D dmirror_devmem_fault_alloc_and_copy(&args, dmirror);
 	if (ret)
 		return ret;
 	migrate_vma_pages(&args);
-	dmirror_devmem_fault_finalize_and_map(&args, dmirror);
+	/*
+	 * No device finalize step is needed since
+	 * dmirror_devmem_fault_alloc_and_copy() will have already
+	 * invalidated the device page table. We could reinstate device MMU
+	 * entries for pages that didn't migrate but that should be rare.
+	 */
 	migrate_vma_finalize(&args);
 	return 0;
 }
--=20
2.20.1

