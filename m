Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F129B21DE78
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jul 2020 19:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbgGMRWL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jul 2020 13:22:11 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:3772 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730454AbgGMRWL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jul 2020 13:22:11 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0c97d20000>; Mon, 13 Jul 2020 10:20:18 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 Jul 2020 10:22:10 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 Jul 2020 10:22:10 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 Jul
 2020 17:22:00 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 13 Jul 2020 17:22:00 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f0c98370005>; Mon, 13 Jul 2020 10:22:00 -0700
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
Subject: [PATCH v2 3/5] mm/notifier: add migration invalidation type
Date:   Mon, 13 Jul 2020 10:21:47 -0700
Message-ID: <20200713172149.2310-4-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200713172149.2310-1-rcampbell@nvidia.com>
References: <20200713172149.2310-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594660818; bh=U/xcm6Lo9aADndFIpE59fzJXl6/Z/hJZ8D48vc+tKDk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=kOtLcclgt4z3D8y5W3+84XQjgX8HH893PgCInOGLot5P09WWKK4bZRwlnl0y9Bm/4
         s3yatnp1LZ13Wl32s+hv8/jwao5hwk07rHMNqyRWpYgaohBlqJMYWCGW7gCkqPhm+q
         0OrJ0Qd6ogB0k6uJuTbCR15n29aej9QDDWZir2Pf1WWx/yAdlfu2eJaFJMhSJzqfG4
         CS66JzcI1332DdQRruGHxrOQqEu/EYdAQaNYKvnPLWtTFQ9FHmNaymMBuwnd5FViut
         842hB1Ipm1bDIZl6SS9C2JIDC3ZxFuPWyTtNQLVXNUMfckbmJV3XdTDjeDCGYzz7zA
         XYAlTzgCdHp4g==
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
migrate_vma::src_owner to a non NULL value that matches the device
private page->pgmap->owner. This value is then passed to the struct
mmu_notifier_range with a new event type which the driver's invalidation
function can use to avoid device MMU invalidations.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 include/linux/mmu_notifier.h | 7 +++++++
 mm/migrate.c                 | 8 +++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

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
index 2bbc5c4c672e..9b3dcb81be5f 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2391,8 +2391,14 @@ static void migrate_vma_collect(struct migrate_vma *=
migrate)
 {
 	struct mmu_notifier_range range;
=20
-	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, NULL,
+	/*
+	 * Note that the src_owner is passed to the mmu notifier callback so
+	 * that the registered device driver can skip invalidating device
+	 * private page mappings that won't be migrated.
+	 */
+	mmu_notifier_range_init(&range, MMU_NOTIFY_MIGRATE, 0, migrate->vma,
 			migrate->vma->vm_mm, migrate->start, migrate->end);
+	range.migrate_pgmap_owner =3D migrate->src_owner;
 	mmu_notifier_invalidate_range_start(&range);
=20
 	walk_page_range(migrate->vma->vm_mm, migrate->start, migrate->end,
--=20
2.20.1

