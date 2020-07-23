Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E577522B971
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jul 2020 00:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgGWWaw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jul 2020 18:30:52 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13873 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbgGWWav (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jul 2020 18:30:51 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f1a0f200001>; Thu, 23 Jul 2020 15:28:48 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 23 Jul 2020 15:30:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 23 Jul 2020 15:30:50 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 23 Jul
 2020 22:30:41 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 23 Jul 2020 22:30:40 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f1a0f900001>; Thu, 23 Jul 2020 15:30:40 -0700
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
Subject: [PATCH v4 2/6] mm/migrate: add a flags parameter to migrate_vma
Date:   Thu, 23 Jul 2020 15:30:00 -0700
Message-ID: <20200723223004.9586-3-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200723223004.9586-1-rcampbell@nvidia.com>
References: <20200723223004.9586-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595543328; bh=nIFIBksj2w4f7R+zCtSW146U+29mGvSr6vO7uHKn5WE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=DWAOAVtJZXwt3phjE/GEGLWSBeDjGNkoYm8RbTSF2iji2Yv98QrFdyfMc48OTbqTc
         YA3w5yCghm/iVzluNlgnQ8h6tSx4uUkGgCohpQfw5XWd/lNMXUe5QofLs6JKF/wNf5
         TacFiAzIX2R943mL79MxYwHgisb0HHZr8WNuw7iLySFbgX1TPXxDlPq5hvRQ3dESp/
         5OuPH6+R3NMOuVrcAR7OuCrNpmwyvKdhz5YnhO+ngTTX7ls4wOdWV7Q82nIg9T3NCO
         pkONmMtb52N4dfDlqZNiP8Jfx/inKQHjMpQpFB/u51pEzY86LD3Mxqsh0pf/khfy2h
         vV7NMxOXErQvw==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The src_owner field in struct migrate_vma is being used for two purposes,
it acts as a selection filter for which types of pages are to be migrated
and it identifies device private pages owned by the caller. Split this
into separate parameters so the src_owner field can be used just to
identify device private pages owned by the caller of migrate_vma_setup().
Rename the src_owner field to pgmap_owner to reflect it is now used only
to identify which device private pages to migrate.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Reviewed-by: Bharata B Rao <bharata@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_hv_uvmem.c     |  4 +++-
 drivers/gpu/drm/nouveau/nouveau_dmem.c |  4 +++-
 include/linux/migrate.h                | 13 +++++++++----
 lib/test_hmm.c                         | 15 ++++-----------
 mm/migrate.c                           |  6 ++++--
 5 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_h=
v_uvmem.c
index 09d8119024db..6850bd04bcb9 100644
--- a/arch/powerpc/kvm/book3s_hv_uvmem.c
+++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
@@ -400,6 +400,7 @@ kvmppc_svm_page_in(struct vm_area_struct *vma, unsigned=
 long start,
 	mig.end =3D end;
 	mig.src =3D &src_pfn;
 	mig.dst =3D &dst_pfn;
+	mig.flags =3D MIGRATE_VMA_SELECT_SYSTEM;
=20
 	/*
 	 * We come here with mmap_lock write lock held just for
@@ -577,7 +578,8 @@ kvmppc_svm_page_out(struct vm_area_struct *vma, unsigne=
d long start,
 	mig.end =3D end;
 	mig.src =3D &src_pfn;
 	mig.dst =3D &dst_pfn;
-	mig.src_owner =3D &kvmppc_uvmem_pgmap;
+	mig.pgmap_owner =3D &kvmppc_uvmem_pgmap;
+	mig.flags =3D MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
=20
 	mutex_lock(&kvm->arch.uvmem_lock);
 	/* The requested page is already paged-out, nothing to do */
diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouve=
au/nouveau_dmem.c
index e5c230d9ae24..78b9e3c2a5b3 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -182,7 +182,8 @@ static vm_fault_t nouveau_dmem_migrate_to_ram(struct vm=
_fault *vmf)
 		.end		=3D vmf->address + PAGE_SIZE,
 		.src		=3D &src,
 		.dst		=3D &dst,
-		.src_owner	=3D drm->dev,
+		.pgmap_owner	=3D drm->dev,
+		.flags		=3D MIGRATE_VMA_SELECT_DEVICE_PRIVATE,
 	};
=20
 	/*
@@ -615,6 +616,7 @@ nouveau_dmem_migrate_vma(struct nouveau_drm *drm,
 	struct migrate_vma args =3D {
 		.vma		=3D vma,
 		.start		=3D start,
+		.flags		=3D MIGRATE_VMA_SELECT_SYSTEM,
 	};
 	unsigned long i;
 	u64 *pfns;
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 3e546cbf03dd..aafec0ca7b41 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -180,6 +180,11 @@ static inline unsigned long migrate_pfn(unsigned long =
pfn)
 	return (pfn << MIGRATE_PFN_SHIFT) | MIGRATE_PFN_VALID;
 }
=20
+enum migrate_vma_direction {
+	MIGRATE_VMA_SELECT_SYSTEM         =3D (1UL << 0),
+	MIGRATE_VMA_SELECT_DEVICE_PRIVATE =3D (1UL << 1),
+};
+
 struct migrate_vma {
 	struct vm_area_struct	*vma;
 	/*
@@ -199,11 +204,11 @@ struct migrate_vma {
=20
 	/*
 	 * Set to the owner value also stored in page->pgmap->owner for
-	 * migrating out of device private memory.  If set only device
-	 * private pages with this owner are migrated.  If not set
-	 * device private pages are not migrated at all.
+	 * migrating out of device private memory. The flags also need to
+	 * be set to MIGRATE_VMA_SELECT_DEVICE_PRIVATE.
 	 */
-	void			*src_owner;
+	void			*pgmap_owner;
+	unsigned long		flags;
 };
=20
 int migrate_vma_setup(struct migrate_vma *args);
diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 9aa577afc269..e78a1414f58e 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -585,15 +585,6 @@ static void dmirror_migrate_alloc_and_copy(struct migr=
ate_vma *args,
 		 */
 		spage =3D migrate_pfn_to_page(*src);
=20
-		/*
-		 * Don't migrate device private pages from our own driver or
-		 * others. For our own we would do a device private memory copy
-		 * not a migration and for others, we would need to fault the
-		 * other device's page into system memory first.
-		 */
-		if (spage && is_zone_device_page(spage))
-			continue;
-
 		dpage =3D dmirror_devmem_alloc_page(mdevice);
 		if (!dpage)
 			continue;
@@ -702,7 +693,8 @@ static int dmirror_migrate(struct dmirror *dmirror,
 		args.dst =3D dst_pfns;
 		args.start =3D addr;
 		args.end =3D next;
-		args.src_owner =3D NULL;
+		args.pgmap_owner =3D NULL;
+		args.flags =3D MIGRATE_VMA_SELECT_SYSTEM;
 		ret =3D migrate_vma_setup(&args);
 		if (ret)
 			goto out;
@@ -1053,7 +1045,8 @@ static vm_fault_t dmirror_devmem_fault(struct vm_faul=
t *vmf)
 	args.end =3D args.start + PAGE_SIZE;
 	args.src =3D &src_pfns;
 	args.dst =3D &dst_pfns;
-	args.src_owner =3D dmirror->mdevice;
+	args.pgmap_owner =3D dmirror->mdevice;
+	args.flags =3D MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
=20
 	if (migrate_vma_setup(&args))
 		return VM_FAULT_SIGBUS;
diff --git a/mm/migrate.c b/mm/migrate.c
index f37729673558..e3ea68e3a08b 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2287,7 +2287,9 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 				goto next;
=20
 			page =3D device_private_entry_to_page(entry);
-			if (page->pgmap->owner !=3D migrate->src_owner)
+			if (!(migrate->flags &
+				MIGRATE_VMA_SELECT_DEVICE_PRIVATE) ||
+			    page->pgmap->owner !=3D migrate->pgmap_owner)
 				goto next;
=20
 			mpfn =3D migrate_pfn(page_to_pfn(page)) |
@@ -2295,7 +2297,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 			if (is_write_device_private_entry(entry))
 				mpfn |=3D MIGRATE_PFN_WRITE;
 		} else {
-			if (migrate->src_owner)
+			if (!(migrate->flags & MIGRATE_VMA_SELECT_SYSTEM))
 				goto next;
 			pfn =3D pte_pfn(pte);
 			if (is_zero_pfn(pfn)) {
--=20
2.20.1

