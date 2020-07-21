Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07495228B63
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jul 2020 23:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731316AbgGUVbm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Jul 2020 17:31:42 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12490 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731293AbgGUVbg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Jul 2020 17:31:36 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f175eaa0005>; Tue, 21 Jul 2020 14:31:22 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 21 Jul 2020 14:31:35 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 21 Jul 2020 14:31:35 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 Jul
 2020 21:31:25 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 21 Jul 2020 21:31:26 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f175ead0006>; Tue, 21 Jul 2020 14:31:26 -0700
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
Subject: [PATCH v3 5/5] mm/hmm/test: use the new migration invalidation
Date:   Tue, 21 Jul 2020 14:31:19 -0700
Message-ID: <20200721213119.32344-6-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200721213119.32344-1-rcampbell@nvidia.com>
References: <20200721213119.32344-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595367082; bh=dV0F2IGIbSa3UBr9FPynu9ekSSnn2qKSM3AxyUbNMFQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=pfje3ZGPKvbmEuIpiYR54C1oU2sba42jUTPeyo9lQu3WTQThk65+loh+eB+wSoEIh
         N07/umNUYu7CbxQyOsKkfIkuQhuTXVARUPAXP+AmWW92zLGD8Yj3rc+yr2w6p3swkV
         CWx4hst7sJBQwRB81WTcTZmo23MopnU8P+1kXcLN/yuD9FSrdZXgY806Mk3Z330tqb
         YAUeJBuMz9nBMYsSk4hzsmTcWI+tJVwHt5mz/8+8z/c+oDor9rN4dcDuBZhdLA/F8+
         wvOTagUh7sDm0G12wWTYCR1I9bHTmBGmrp+S/GtDZua+EN3PWrsUg3kQZVGsanCUNd
         +iuPWhcB5EhCw==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use the new MMU_NOTIFY_MIGRATE event to skip MMU invalidations of device
private memory and handle the invalidation in the driver as part of
migrating device private memory.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 lib/test_hmm.c                         | 30 +++++++++++++++-----------
 tools/testing/selftests/vm/hmm-tests.c | 18 ++++++++++++----
 2 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 74c6ee66ef15..9abc9ad3140f 100644
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
+	    range->migrate_pgmap_owner =3D=3D dmirror->mdevice)
+		return true;
+
 	if (mmu_notifier_range_blockable(range))
 		mutex_lock(&dmirror->mutex);
 	else if (!mutex_trylock(&dmirror->mutex))
@@ -702,7 +710,7 @@ static int dmirror_migrate(struct dmirror *dmirror,
 		args.dst =3D dst_pfns;
 		args.start =3D addr;
 		args.end =3D next;
-		args.pgmap_owner =3D NULL;
+		args.pgmap_owner =3D dmirror->mdevice;
 		args.flags =3D MIGRATE_VMA_SELECT_SYSTEM;
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
@@ -1060,11 +1060,15 @@ static vm_fault_t dmirror_devmem_fault(struct vm_fa=
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
+	 * invalidated the device page table.
+	 */
 	migrate_vma_finalize(&args);
 	return 0;
 }
diff --git a/tools/testing/selftests/vm/hmm-tests.c b/tools/testing/selftes=
ts/vm/hmm-tests.c
index b533dd08da1d..91d38a29956b 100644
--- a/tools/testing/selftests/vm/hmm-tests.c
+++ b/tools/testing/selftests/vm/hmm-tests.c
@@ -881,8 +881,9 @@ TEST_F(hmm, migrate)
 }
=20
 /*
- * Migrate anonymous memory to device private memory and fault it back to =
system
- * memory.
+ * Migrate anonymous memory to device private memory and fault some of it =
back
+ * to system memory, then try migrating the resulting mix of system and de=
vice
+ * private memory to the device.
  */
 TEST_F(hmm, migrate_fault)
 {
@@ -924,8 +925,17 @@ TEST_F(hmm, migrate_fault)
 	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
 		ASSERT_EQ(ptr[i], i);
=20
-	/* Fault pages back to system memory and check them. */
-	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+	/* Fault half the pages back to system memory and check them. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / (2 * sizeof(*ptr)); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	/* Migrate memory to the device again. */
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_MIGRATE, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+
+	/* Check what the device read. */
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
 		ASSERT_EQ(ptr[i], i);
=20
 	hmm_buffer_free(buffer);
--=20
2.20.1

