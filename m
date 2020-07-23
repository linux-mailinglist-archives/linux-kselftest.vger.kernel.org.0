Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF8322B984
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jul 2020 00:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgGWWat (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jul 2020 18:30:49 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13854 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbgGWWat (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jul 2020 18:30:49 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f1a0f1e0000>; Thu, 23 Jul 2020 15:28:46 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 23 Jul 2020 15:30:48 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 23 Jul 2020 15:30:48 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 23 Jul
 2020 22:30:41 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 23 Jul 2020 22:30:41 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f1a0f900004>; Thu, 23 Jul 2020 15:30:41 -0700
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
Subject: [PATCH v4 3/6] mm/notifier: add migration invalidation type
Date:   Thu, 23 Jul 2020 15:30:01 -0700
Message-ID: <20200723223004.9586-4-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200723223004.9586-1-rcampbell@nvidia.com>
References: <20200723223004.9586-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595543326; bh=YxemRVSG9j1xekTjy+tk+YO7UYs97J+WY0eBPs1d0Nk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=DEe/zZsq6Wgo/kfUjDkBDQP1LV+ZwlKp6wdNvZgj58qjUbNPggPMyL6wRdCBQ63M1
         mcaRtS9hWBXfPZeN4b4T279qT6ulJ9zu0aacX9z1xR44Gc+TBA4PIcNcidvBrIjSNq
         UsQIyqmeS6JIpfwvLwYpdbbK2AiY4ok0p/y56JpDtbxtgB0/25Ar9A6ZbUzIlfomRY
         8HnVtPG/mcT8exm4A7yGUVGwmZ9PPsugcRPn883JWr7PNX86cujvx3pa8yQnFo/jD+
         XK79h0uPtK1G5oWI6CUjXW5gCnwwdLNV1YQcgcIW+jF27X9L9CYYgi95tinBrp3OTc
         xT4Sna8EGkocw==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently migrate_vma_setup() calls mmu_notifier_invalidate_range_start()
which flushes all device private page mappings whether or not a page
is being migrated to/from device private memory. In order to not disrupt
device mappings that are not being migrated, shift the responsibility
for clearing device private mappings to the device driver and leave
CPU page table unmapping handled by migrate_vma_setup(). To support
this, the caller of migrate_vma_setup() should always set struct
migrate_vma::pgmap_owner to a non NULL value that matches the device
private page->pgmap->owner. This value is then passed to the struct
mmu_notifier_range with a new event type which the driver's invalidation
function can use to avoid device MMU invalidations.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 include/linux/migrate.h      | 3 +++
 include/linux/mmu_notifier.h | 7 +++++++
 mm/migrate.c                 | 8 +++++++-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index aafec0ca7b41..4cc7097d0271 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -206,6 +206,9 @@ struct migrate_vma {
 	 * Set to the owner value also stored in page->pgmap->owner for
 	 * migrating out of device private memory. The flags also need to
 	 * be set to MIGRATE_VMA_SELECT_DEVICE_PRIVATE.
+	 * The caller should always set this field when using mmu notifier
+	 * callbacks to avoid device MMU invalidations for device private
+	 * pages that are not being migrated.
 	 */
 	void			*pgmap_owner;
 	unsigned long		flags;
diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index fc68f3570e19..1921fcf6be5b 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -38,6 +38,10 @@ struct mmu_interval_notifier;
  *
  * @MMU_NOTIFY_RELEASE: used during mmu_interval_notifier invalidate to si=
gnal
  * that the mm refcount is zero and the range is no longer accessible.
+ *
+ * @MMU_NOTIFY_MIGRATE: used during migrate_vma_collect() invalidate to si=
gnal
+ * a device driver to possibly ignore the invalidation if the
+ * migrate_pgmap_owner field matches the driver's device private pgmap own=
er.
  */
 enum mmu_notifier_event {
 	MMU_NOTIFY_UNMAP =3D 0,
@@ -46,6 +50,7 @@ enum mmu_notifier_event {
 	MMU_NOTIFY_PROTECTION_PAGE,
 	MMU_NOTIFY_SOFT_DIRTY,
 	MMU_NOTIFY_RELEASE,
+	MMU_NOTIFY_MIGRATE,
 };
=20
 #define MMU_NOTIFIER_RANGE_BLOCKABLE (1 << 0)
@@ -264,6 +269,7 @@ struct mmu_notifier_range {
 	unsigned long end;
 	unsigned flags;
 	enum mmu_notifier_event event;
+	void *migrate_pgmap_owner;
 };
=20
 static inline int mm_has_notifiers(struct mm_struct *mm)
@@ -513,6 +519,7 @@ static inline void mmu_notifier_range_init(struct mmu_n=
otifier_range *range,
 	range->start =3D start;
 	range->end =3D end;
 	range->flags =3D flags;
+	range->migrate_pgmap_owner =3D NULL;
 }
=20
 #define ptep_clear_flush_young_notify(__vma, __address, __ptep)		\
diff --git a/mm/migrate.c b/mm/migrate.c
index e3ea68e3a08b..96e1f41a991e 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2392,8 +2392,14 @@ static void migrate_vma_collect(struct migrate_vma *=
migrate)
 {
 	struct mmu_notifier_range range;
=20
-	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, NULL,
+	/*
+	 * Note that the pgmap_owner is passed to the mmu notifier callback so
+	 * that the registered device driver can skip invalidating device
+	 * private page mappings that won't be migrated.
+	 */
+	mmu_notifier_range_init(&range, MMU_NOTIFY_MIGRATE, 0, migrate->vma,
 			migrate->vma->vm_mm, migrate->start, migrate->end);
+	range.migrate_pgmap_owner =3D migrate->pgmap_owner;
 	mmu_notifier_invalidate_range_start(&range);
=20
 	walk_page_range(migrate->vma->vm_mm, migrate->start, migrate->end,
--=20
2.20.1

