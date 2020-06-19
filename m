Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCFE201D64
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jun 2020 23:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgFSV5M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Jun 2020 17:57:12 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2209 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbgFSV5I (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Jun 2020 17:57:08 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eed34a50004>; Fri, 19 Jun 2020 14:56:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 19 Jun 2020 14:57:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 19 Jun 2020 14:57:06 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 19 Jun
 2020 21:57:00 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 19 Jun 2020 21:57:00 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5eed34ac0001>; Fri, 19 Jun 2020 14:57:00 -0700
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
Subject: [PATCH 15/16] mm/hmm/test: add self tests for THP migration
Date:   Fri, 19 Jun 2020 14:56:48 -0700
Message-ID: <20200619215649.32297-16-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200619215649.32297-1-rcampbell@nvidia.com>
References: <20200619215649.32297-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592603814; bh=Xgn70Okdl66oUYqpFdQohcN21D9gVK82f7P1nbUvqWE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=ryn4YSsgiOpEDJ1K/UnAEoCNS92WWuMDJ/8bqbwQBdSR9OBEHS3IbRjR/gFp8vyjP
         15qRt5n4h1q+J4q40Ykaag/Qm7XY4WsKce/c4u0Q6E4qi659aXyHrkCKAJecxnEcka
         qOzAszQhd37ELI7UTjQWjTqWHj7zQAlPEZhI1yhyq95h6bqgNdfmKo71iifR09O7JO
         gXHMtTC/nrSXBujCOUafK7vCiIEq8cd01n4UK0ISwBcb5GxgIJNTYGgNqA/RCcg1vx
         I+wvJ4vmHQnRptndjhNHkku2EQMqUka+W6n5tmMOiGWa/MS6Oohr0YsnbiZaV2xSqU
         z34AMuloX6tTw==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add some basic stand alone self tests for migrating system memory to device
private memory and back.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 lib/test_hmm.c                         | 323 ++++++++++++++++++++-----
 tools/testing/selftests/vm/hmm-tests.c | 292 ++++++++++++++++++++++
 2 files changed, 560 insertions(+), 55 deletions(-)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index db5d2e8d7420..f4e2e8731366 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -92,6 +92,7 @@ struct dmirror_device {
 	unsigned long		calloc;
 	unsigned long		cfree;
 	struct page		*free_pages;
+	struct page		*free_huge_pages;
 	spinlock_t		lock;		/* protects the above */
 };
=20
@@ -443,6 +444,7 @@ static int dmirror_write(struct dmirror *dmirror, struc=
t hmm_dmirror_cmd *cmd)
 }
=20
 static bool dmirror_allocate_chunk(struct dmirror_device *mdevice,
+				   bool is_huge,
 				   struct page **ppage)
 {
 	struct dmirror_chunk *devmem;
@@ -502,16 +504,39 @@ static bool dmirror_allocate_chunk(struct dmirror_dev=
ice *mdevice,
 		pfn_first, pfn_last);
=20
 	spin_lock(&mdevice->lock);
-	for (pfn =3D pfn_first; pfn < pfn_last; pfn++) {
+	for (pfn =3D pfn_first; pfn < pfn_last; ) {
 		struct page *page =3D pfn_to_page(pfn);
=20
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+		/*
+		 * Check for PMD aligned PFN and create a huge page.
+		 * Check for "< pfn_last - 1" so that the last two huge pages
+		 * are used for normal pages.
+		 */
+		if ((pfn & (HPAGE_PMD_NR - 1)) =3D=3D 0 &&
+		    pfn + HPAGE_PMD_NR < pfn_last - 1) {
+			prep_compound_page(page, HPAGE_PMD_ORDER);
+			page->zone_device_data =3D mdevice->free_huge_pages;
+			mdevice->free_huge_pages =3D page;
+			pfn +=3D HPAGE_PMD_NR;
+			percpu_ref_put_many(page->pgmap->ref, HPAGE_PMD_NR - 1);
+			continue;
+		}
+#endif
 		page->zone_device_data =3D mdevice->free_pages;
 		mdevice->free_pages =3D page;
+		pfn++;
 	}
 	if (ppage) {
-		*ppage =3D mdevice->free_pages;
-		mdevice->free_pages =3D (*ppage)->zone_device_data;
-		mdevice->calloc++;
+		if (is_huge) {
+			*ppage =3D mdevice->free_huge_pages;
+			mdevice->free_huge_pages =3D (*ppage)->zone_device_data;
+			mdevice->calloc +=3D 1UL << compound_order(*ppage);
+		} else {
+			*ppage =3D mdevice->free_pages;
+			mdevice->free_pages =3D (*ppage)->zone_device_data;
+			mdevice->calloc++;
+		}
 	}
 	spin_unlock(&mdevice->lock);
=20
@@ -527,7 +552,8 @@ static bool dmirror_allocate_chunk(struct dmirror_devic=
e *mdevice,
 	return false;
 }
=20
-static struct page *dmirror_devmem_alloc_page(struct dmirror_device *mdevi=
ce)
+static struct page *dmirror_devmem_alloc_page(struct dmirror_device *mdevi=
ce,
+					      bool is_huge)
 {
 	struct page *dpage =3D NULL;
 	struct page *rpage;
@@ -542,17 +568,40 @@ static struct page *dmirror_devmem_alloc_page(struct =
dmirror_device *mdevice)
=20
 	spin_lock(&mdevice->lock);
=20
-	if (mdevice->free_pages) {
+	if (is_huge && mdevice->free_huge_pages) {
+		dpage =3D mdevice->free_huge_pages;
+		mdevice->free_huge_pages =3D dpage->zone_device_data;
+		mdevice->calloc +=3D 1UL << compound_order(dpage);
+		spin_unlock(&mdevice->lock);
+	} else if (!is_huge && mdevice->free_pages) {
 		dpage =3D mdevice->free_pages;
 		mdevice->free_pages =3D dpage->zone_device_data;
 		mdevice->calloc++;
 		spin_unlock(&mdevice->lock);
 	} else {
 		spin_unlock(&mdevice->lock);
-		if (!dmirror_allocate_chunk(mdevice, &dpage))
+		if (!dmirror_allocate_chunk(mdevice, is_huge, &dpage))
 			goto error;
 	}
=20
+	if (is_huge) {
+		unsigned int nr_pages =3D 1U << compound_order(dpage);
+		unsigned int i;
+		struct page **tpage;
+
+		tpage =3D kmap(rpage);
+		for (i =3D 0; i < nr_pages; i++, tpage++) {
+			*tpage =3D alloc_page(GFP_HIGHUSER);
+			if (!*tpage) {
+				while (i--)
+					__free_page(*--tpage);
+				kunmap(rpage);
+				goto error;
+			}
+		}
+		kunmap(rpage);
+	}
+
 	dpage->zone_device_data =3D rpage;
 	get_page(dpage);
 	lock_page(dpage);
@@ -569,16 +618,17 @@ static void dmirror_migrate_alloc_and_copy(struct mig=
rate_vma *args,
 	struct dmirror_device *mdevice =3D dmirror->mdevice;
 	const unsigned long *src =3D args->src;
 	unsigned long *dst =3D args->dst;
-	unsigned long addr;
+	unsigned long end_pfn =3D args->end >> PAGE_SHIFT;
+	unsigned long pfn;
=20
-	for (addr =3D args->start; addr < args->end; addr +=3D PAGE_SIZE,
-						   src++, dst++) {
+	for (pfn =3D args->start >> PAGE_SHIFT; pfn < end_pfn; ) {
 		struct page *spage;
 		struct page *dpage;
 		struct page *rpage;
+		bool is_huge;
=20
 		if (!(*src & MIGRATE_PFN_MIGRATE))
-			continue;
+			goto next;
=20
 		/*
 		 * Note that spage might be NULL which is OK since it is an
@@ -595,7 +645,6 @@ static void dmirror_migrate_alloc_and_copy(struct migra=
te_vma *args,
 		 * In this case, repopulate our page table.
 		 */
 		if (spage && is_zone_device_page(spage)) {
-			unsigned long pfn =3D addr >> PAGE_SHIFT;
 			void *entry;
=20
 			mutex_lock(&dmirror->mutex);
@@ -604,18 +653,14 @@ static void dmirror_migrate_alloc_and_copy(struct mig=
rate_vma *args,
 				entry =3D xa_tag_pointer(entry, DPT_XA_TAG_WRITE);
 			xa_store(&dmirror->pt, pfn, entry, GFP_ATOMIC);
 			mutex_unlock(&dmirror->mutex);
-			continue;
+			goto next;
 		}
=20
-		dpage =3D dmirror_devmem_alloc_page(mdevice);
+		/* This flag is only set if a whole huge page is migrated. */
+		is_huge =3D *src & MIGRATE_PFN_COMPOUND;
+		dpage =3D dmirror_devmem_alloc_page(mdevice, is_huge);
 		if (!dpage)
-			continue;
-
-		rpage =3D dpage->zone_device_data;
-		if (spage)
-			copy_highpage(rpage, spage);
-		else
-			clear_highpage(rpage);
+			goto next;
=20
 		/*
 		 * Normally, a device would use the page->zone_device_data to
@@ -623,6 +668,7 @@ static void dmirror_migrate_alloc_and_copy(struct migra=
te_vma *args,
 		 * the simulated device memory and that page holds the pointer
 		 * to the mirror.
 		 */
+		rpage =3D dpage->zone_device_data;
 		rpage->zone_device_data =3D dmirror;
=20
 		*dst =3D migrate_pfn(page_to_pfn(dpage)) |
@@ -630,6 +676,37 @@ static void dmirror_migrate_alloc_and_copy(struct migr=
ate_vma *args,
 		if ((*src & MIGRATE_PFN_WRITE) ||
 		    (!spage && args->vma->vm_flags & VM_WRITE))
 			*dst |=3D MIGRATE_PFN_WRITE;
+
+		if (is_huge) {
+			struct page **tpage;
+			unsigned int order =3D compound_order(dpage);
+			unsigned long endp =3D pfn + (1UL << order);
+
+			*dst |=3D MIGRATE_PFN_COMPOUND;
+			tpage =3D kmap(rpage);
+			while (pfn < endp) {
+				if (spage) {
+					copy_highpage(*tpage, spage);
+					spage++;
+				} else
+					clear_highpage(*tpage);
+				tpage++;
+				pfn++;
+				src++;
+				dst++;
+			}
+			kunmap(rpage);
+			continue;
+		}
+
+		if (spage)
+			copy_highpage(rpage, spage);
+		else
+			clear_highpage(rpage);
+next:
+		pfn++;
+		src++;
+		dst++;
 	}
 }
=20
@@ -641,38 +718,76 @@ static int dmirror_migrate_finalize_and_map(struct mi=
grate_vma *args,
 	const unsigned long *src =3D args->src;
 	const unsigned long *dst =3D args->dst;
 	unsigned long pfn;
+	int ret =3D 0;
=20
 	/* Map the migrated pages into the device's page tables. */
 	mutex_lock(&dmirror->mutex);
=20
-	for (pfn =3D start >> PAGE_SHIFT; pfn < (end >> PAGE_SHIFT); pfn++,
-								src++, dst++) {
+	for (pfn =3D start >> PAGE_SHIFT; pfn < (end >> PAGE_SHIFT); ) {
+		unsigned long mpfn;
 		struct page *dpage;
+		struct page *rpage;
 		void *entry;
=20
 		if (!(*src & MIGRATE_PFN_MIGRATE))
-			continue;
+			goto next;
=20
-		dpage =3D migrate_pfn_to_page(*dst);
+		mpfn =3D *dst;
+		dpage =3D migrate_pfn_to_page(mpfn);
 		if (!dpage)
-			continue;
+			goto next;
=20
 		/*
 		 * Store the page that holds the data so the page table
 		 * doesn't have to deal with ZONE_DEVICE private pages.
 		 */
-		entry =3D dpage->zone_device_data;
-		if (*dst & MIGRATE_PFN_WRITE)
+		rpage =3D dpage->zone_device_data;
+		if (mpfn & MIGRATE_PFN_COMPOUND) {
+			struct page **tpage;
+			unsigned int order =3D compound_order(dpage);
+			unsigned long end_pfn =3D pfn + (1UL << order);
+
+			ret =3D 0;
+			tpage =3D kmap(rpage);
+			while (pfn < end_pfn) {
+				entry =3D *tpage;
+				if (mpfn & MIGRATE_PFN_WRITE)
+					entry =3D xa_tag_pointer(entry,
+							DPT_XA_TAG_WRITE);
+				entry =3D xa_store(&dmirror->pt, pfn, entry,
+						 GFP_KERNEL);
+				if (xa_is_err(entry)) {
+					ret =3D xa_err(entry);
+					break;
+				}
+				tpage++;
+				pfn++;
+				src++;
+				dst++;
+			}
+			kunmap(rpage);
+			if (ret)
+				goto err;
+			continue;
+		}
+
+		entry =3D rpage;
+		if (mpfn & MIGRATE_PFN_WRITE)
 			entry =3D xa_tag_pointer(entry, DPT_XA_TAG_WRITE);
 		entry =3D xa_store(&dmirror->pt, pfn, entry, GFP_ATOMIC);
 		if (xa_is_err(entry)) {
 			mutex_unlock(&dmirror->mutex);
 			return xa_err(entry);
 		}
+next:
+		pfn++;
+		src++;
+		dst++;
 	}
=20
+err:
 	mutex_unlock(&dmirror->mutex);
-	return 0;
+	return ret;
 }
=20
 static int dmirror_migrate(struct dmirror *dmirror,
@@ -682,8 +797,8 @@ static int dmirror_migrate(struct dmirror *dmirror,
 	unsigned long size =3D cmd->npages << PAGE_SHIFT;
 	struct mm_struct *mm =3D dmirror->notifier.mm;
 	struct vm_area_struct *vma;
-	unsigned long src_pfns[64];
-	unsigned long dst_pfns[64];
+	unsigned long *src_pfns;
+	unsigned long *dst_pfns;
 	struct dmirror_bounce bounce;
 	struct migrate_vma args;
 	unsigned long next;
@@ -698,6 +813,17 @@ static int dmirror_migrate(struct dmirror *dmirror,
 	if (!mmget_not_zero(mm))
 		return -EINVAL;
=20
+	src_pfns =3D kmalloc_array(PTRS_PER_PTE, sizeof(*src_pfns), GFP_KERNEL);
+	if (!src_pfns) {
+		ret =3D -ENOMEM;
+		goto out_put;
+	}
+	dst_pfns =3D kmalloc_array(PTRS_PER_PTE, sizeof(*dst_pfns), GFP_KERNEL);
+	if (!dst_pfns) {
+		ret =3D -ENOMEM;
+		goto out_free_src;
+	}
+
 	mmap_read_lock(mm);
 	for (addr =3D start; addr < end; addr =3D next) {
 		vma =3D find_vma(mm, addr);
@@ -706,7 +832,7 @@ static int dmirror_migrate(struct dmirror *dmirror,
 			ret =3D -EINVAL;
 			goto out;
 		}
-		next =3D min(end, addr + (ARRAY_SIZE(src_pfns) << PAGE_SHIFT));
+		next =3D min(end, addr + (PTRS_PER_PTE << PAGE_SHIFT));
 		if (next > vma->vm_end)
 			next =3D vma->vm_end;
=20
@@ -725,6 +851,8 @@ static int dmirror_migrate(struct dmirror *dmirror,
 		dmirror_migrate_finalize_and_map(&args, dmirror);
 		migrate_vma_finalize(&args);
 	}
+	kfree(dst_pfns);
+	kfree(src_pfns);
 	mmap_read_unlock(mm);
 	mmput(mm);
=20
@@ -746,6 +874,10 @@ static int dmirror_migrate(struct dmirror *dmirror,
=20
 out:
 	mmap_read_unlock(mm);
+	kfree(dst_pfns);
+out_free_src:
+	kfree(src_pfns);
+out_put:
 	mmput(mm);
 	return ret;
 }
@@ -986,18 +1118,37 @@ static const struct file_operations dmirror_fops =3D=
 {
=20
 static void dmirror_devmem_free(struct page *page)
 {
-	struct page *rpage =3D page->zone_device_data;
+	struct page *rpage =3D compound_head(page)->zone_device_data;
+	unsigned int order =3D compound_order(page);
+	unsigned int nr_pages =3D 1U << order;
 	struct dmirror_device *mdevice;
=20
-	if (rpage)
+	if (rpage) {
+		if (order) {
+			unsigned int i;
+			struct page **tpage;
+			void *kaddr;
+
+			kaddr =3D kmap_atomic(rpage);
+			tpage =3D kaddr;
+			for (i =3D 0; i < nr_pages; i++, tpage++)
+				__free_page(*tpage);
+			kunmap_atomic(kaddr);
+		}
 		__free_page(rpage);
+	}
=20
 	mdevice =3D dmirror_page_to_device(page);
=20
 	spin_lock(&mdevice->lock);
-	mdevice->cfree++;
-	page->zone_device_data =3D mdevice->free_pages;
-	mdevice->free_pages =3D page;
+	if (order) {
+		page->zone_device_data =3D mdevice->free_huge_pages;
+		mdevice->free_huge_pages =3D page;
+	} else {
+		page->zone_device_data =3D mdevice->free_pages;
+		mdevice->free_pages =3D page;
+	}
+	mdevice->cfree +=3D nr_pages;
 	spin_unlock(&mdevice->lock);
 }
=20
@@ -1010,24 +1161,51 @@ static vm_fault_t dmirror_devmem_fault_alloc_and_co=
py(struct migrate_vma *args,
 	unsigned long end =3D args->end;
 	unsigned long addr;
=20
-	for (addr =3D start; addr < end; addr +=3D PAGE_SIZE,
-				       src++, dst++) {
-		struct page *dpage, *spage;
+	for (addr =3D start; addr < end; ) {
+		struct page *spage, *dpage;
+		unsigned int order =3D 0;
+		unsigned int nr_pages =3D 1;
+		unsigned int i;
=20
 		spage =3D migrate_pfn_to_page(*src);
 		if (!spage || !(*src & MIGRATE_PFN_MIGRATE))
-			continue;
+			goto next;
+		order =3D compound_order(spage);
+		nr_pages =3D 1U << order;
+		/* The source page is the ZONE_DEVICE private page. */
 		spage =3D spage->zone_device_data;
=20
-		dpage =3D alloc_page_vma(GFP_HIGHUSER_MOVABLE, args->vma, addr);
-		if (!dpage)
-			continue;
+		if (order)
+			dpage =3D alloc_transhugepage(args->vma, addr);
+		else
+			dpage =3D alloc_pages_vma(GFP_HIGHUSER_MOVABLE, 0,
+						args->vma, addr,
+						numa_node_id(), false);
+
+		if (!dpage || compound_order(dpage) !=3D order)
+			return VM_FAULT_OOM;
=20
 		lock_page(dpage);
-		copy_highpage(dpage, spage);
 		*dst =3D migrate_pfn(page_to_pfn(dpage)) | MIGRATE_PFN_LOCKED;
 		if (*src & MIGRATE_PFN_WRITE)
 			*dst |=3D MIGRATE_PFN_WRITE;
+		if (order) {
+			struct page **tpage;
+
+			*dst |=3D MIGRATE_PFN_COMPOUND;
+			tpage =3D kmap(spage);
+			for (i =3D 0; i < nr_pages; i++) {
+				copy_highpage(dpage, *tpage);
+				tpage++;
+				dpage++;
+			}
+			kunmap(spage);
+		} else
+			copy_highpage(dpage, spage);
+next:
+		addr +=3D PAGE_SIZE << order;
+		src +=3D nr_pages;
+		dst +=3D nr_pages;
 	}
 	return 0;
 }
@@ -1037,39 +1215,74 @@ static vm_fault_t dmirror_devmem_fault(struct vm_fa=
ult *vmf)
 	struct migrate_vma args;
 	unsigned long src_pfns;
 	unsigned long dst_pfns;
+	struct page *page;
 	struct page *rpage;
+	unsigned int order;
 	struct dmirror *dmirror;
 	vm_fault_t ret;
=20
+	page =3D compound_head(vmf->page);
+	order =3D compound_order(page);
+
 	/*
 	 * Normally, a device would use the page->zone_device_data to point to
 	 * the mirror but here we use it to hold the page for the simulated
 	 * device memory and that page holds the pointer to the mirror.
 	 */
-	rpage =3D vmf->page->zone_device_data;
+	rpage =3D page->zone_device_data;
 	dmirror =3D rpage->zone_device_data;
=20
-	/* FIXME demonstrate how we can adjust migrate range */
+	if (order) {
+		args.start =3D vmf->address & (PAGE_MASK << order);
+		args.end =3D args.start + (PAGE_SIZE << order);
+		args.src =3D kcalloc(PTRS_PER_PTE, sizeof(*args.src),
+				   GFP_KERNEL);
+		if (!args.src)
+			return VM_FAULT_OOM;
+		args.dst =3D kcalloc(PTRS_PER_PTE, sizeof(*args.dst),
+				   GFP_KERNEL);
+		if (!args.dst) {
+			ret =3D VM_FAULT_OOM;
+			goto error_src;
+		}
+	} else {
+		args.start =3D vmf->address;
+		args.end =3D args.start + PAGE_SIZE;
+		args.src =3D &src_pfns;
+		args.dst =3D &dst_pfns;
+	}
 	args.vma =3D vmf->vma;
-	args.start =3D vmf->address;
-	args.end =3D args.start + PAGE_SIZE;
-	args.src =3D &src_pfns;
-	args.dst =3D &dst_pfns;
 	args.src_owner =3D dmirror->mdevice;
=20
-	if (migrate_vma_setup(&args))
-		return VM_FAULT_SIGBUS;
+	if (migrate_vma_setup(&args)) {
+		ret =3D VM_FAULT_SIGBUS;
+		goto error_dst;
+	}
=20
 	ret =3D dmirror_devmem_fault_alloc_and_copy(&args, dmirror->mdevice);
 	if (ret)
-		return ret;
+		goto error_fin;
 	migrate_vma_pages(&args);
 	/*
 	 * No device finalize step is needed since migrate_vma_setup() will
 	 * have already invalidated the device page table.
 	 */
 	migrate_vma_finalize(&args);
+	if (order) {
+		kfree(args.dst);
+		kfree(args.src);
+	}
 	return 0;
+
+error_fin:
+	migrate_vma_finalize(&args);
+error_dst:
+	if (args.dst !=3D &dst_pfns)
+		kfree(args.dst);
+error_src:
+	if (args.src !=3D &src_pfns)
+		kfree(args.src);
+	return ret;
 }
=20
 static const struct dev_pagemap_ops dmirror_devmem_ops =3D {
@@ -1093,7 +1306,7 @@ static int dmirror_device_init(struct dmirror_device =
*mdevice, int id)
 		return ret;
=20
 	/* Build a list of free ZONE_DEVICE private struct pages */
-	dmirror_allocate_chunk(mdevice, NULL);
+	dmirror_allocate_chunk(mdevice, false, NULL);
=20
 	return 0;
 }
diff --git a/tools/testing/selftests/vm/hmm-tests.c b/tools/testing/selftes=
ts/vm/hmm-tests.c
index e0fa864d03fa..d58a6f5280b7 100644
--- a/tools/testing/selftests/vm/hmm-tests.c
+++ b/tools/testing/selftests/vm/hmm-tests.c
@@ -1442,4 +1442,296 @@ TEST_F(hmm2, double_map)
 	hmm_buffer_free(buffer);
 }
=20
+/*
+ * Migrate private anonymous huge empty page.
+ */
+TEST_F(hmm, migrate_anon_huge_empty)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	void *old_ptr;
+	void *map;
+	int *ptr;
+	int ret;
+
+	size =3D TWOMEG;
+
+	buffer =3D malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd =3D -1;
+	buffer->size =3D 2 * size;
+	buffer->mirror =3D malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+	memset(buffer->mirror, 0xFF, size);
+
+	buffer->ptr =3D mmap(NULL, 2 * size,
+			   PROT_READ,
+			   MAP_PRIVATE | MAP_ANONYMOUS,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	npages =3D size >> self->page_shift;
+	map =3D (void *)ALIGN((uintptr_t)buffer->ptr, size);
+	ret =3D madvise(map, size, MADV_HUGEPAGE);
+	ASSERT_EQ(ret, 0);
+	old_ptr =3D buffer->ptr;
+	buffer->ptr =3D map;
+
+	/* Migrate memory to device. */
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_MIGRATE, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+
+	/* Check what the device read. */
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], 0);
+
+	buffer->ptr =3D old_ptr;
+	hmm_buffer_free(buffer);
+}
+
+/*
+ * Migrate private anonymous huge zero page.
+ */
+TEST_F(hmm, migrate_anon_huge_zero)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	void *old_ptr;
+	void *map;
+	int *ptr;
+	int ret;
+	int val;
+
+	size =3D TWOMEG;
+
+	buffer =3D malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd =3D -1;
+	buffer->size =3D 2 * size;
+	buffer->mirror =3D malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+	memset(buffer->mirror, 0xFF, size);
+
+	buffer->ptr =3D mmap(NULL, 2 * size,
+			   PROT_READ,
+			   MAP_PRIVATE | MAP_ANONYMOUS,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	npages =3D size >> self->page_shift;
+	map =3D (void *)ALIGN((uintptr_t)buffer->ptr, size);
+	ret =3D madvise(map, size, MADV_HUGEPAGE);
+	ASSERT_EQ(ret, 0);
+	old_ptr =3D buffer->ptr;
+	buffer->ptr =3D map;
+
+	/* Initialize a read-only zero huge page. */
+	val =3D *(int *)buffer->ptr;
+	ASSERT_EQ(val, 0);
+
+	/* Migrate memory to device. */
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_MIGRATE, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+
+	/* Check what the device read. */
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], 0);
+
+	/* Fault pages back to system memory and check them. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i) {
+		ASSERT_EQ(ptr[i], 0);
+		/* If it asserts once, it probably will 500,000 times */
+		if (ptr[i] !=3D 0)
+			break;
+	}
+
+	buffer->ptr =3D old_ptr;
+	hmm_buffer_free(buffer);
+}
+
+/*
+ * Migrate private anonymous huge page.
+ */
+TEST_F(hmm, migrate_anon_huge)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	void *old_ptr;
+	void *map;
+	int *ptr;
+	int ret;
+
+	size =3D TWOMEG;
+
+	buffer =3D malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd =3D -1;
+	buffer->size =3D 2 * size;
+	buffer->mirror =3D malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+	memset(buffer->mirror, 0xFF, size);
+
+	buffer->ptr =3D mmap(NULL, 2 * size,
+			   PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE | MAP_ANONYMOUS,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	npages =3D size >> self->page_shift;
+	map =3D (void *)ALIGN((uintptr_t)buffer->ptr, size);
+	ret =3D madvise(map, size, MADV_HUGEPAGE);
+	ASSERT_EQ(ret, 0);
+	old_ptr =3D buffer->ptr;
+	buffer->ptr =3D map;
+
+	/* Initialize buffer in system memory. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ptr[i] =3D i;
+
+	/* Migrate memory to device. */
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_MIGRATE, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+
+	/* Check what the device read. */
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	buffer->ptr =3D old_ptr;
+	hmm_buffer_free(buffer);
+}
+
+/*
+ * Migrate private anonymous huge page and free.
+ */
+TEST_F(hmm, migrate_anon_huge_free)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	void *old_ptr;
+	void *map;
+	int *ptr;
+	int ret;
+
+	size =3D TWOMEG;
+
+	buffer =3D malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd =3D -1;
+	buffer->size =3D 2 * size;
+	buffer->mirror =3D malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+	memset(buffer->mirror, 0xFF, size);
+
+	buffer->ptr =3D mmap(NULL, 2 * size,
+			   PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE | MAP_ANONYMOUS,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	npages =3D size >> self->page_shift;
+	map =3D (void *)ALIGN((uintptr_t)buffer->ptr, size);
+	ret =3D madvise(map, size, MADV_HUGEPAGE);
+	ASSERT_EQ(ret, 0);
+	old_ptr =3D buffer->ptr;
+	buffer->ptr =3D map;
+
+	/* Initialize buffer in system memory. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ptr[i] =3D i;
+
+	/* Migrate memory to device. */
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_MIGRATE, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+
+	/* Check what the device read. */
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	/* Try freeing it. */
+	ret =3D madvise(map, size, MADV_FREE);
+	ASSERT_EQ(ret, 0);
+
+	buffer->ptr =3D old_ptr;
+	hmm_buffer_free(buffer);
+}
+
+/*
+ * Migrate private anonymous huge page and fault back to sysmem.
+ */
+TEST_F(hmm, migrate_anon_huge_fault)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	void *old_ptr;
+	void *map;
+	int *ptr;
+	int ret;
+
+	size =3D TWOMEG;
+
+	buffer =3D malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd =3D -1;
+	buffer->size =3D 2 * size;
+	buffer->mirror =3D malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+	memset(buffer->mirror, 0xFF, size);
+
+	buffer->ptr =3D mmap(NULL, 2 * size,
+			   PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE | MAP_ANONYMOUS,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	npages =3D size >> self->page_shift;
+	map =3D (void *)ALIGN((uintptr_t)buffer->ptr, size);
+	ret =3D madvise(map, size, MADV_HUGEPAGE);
+	ASSERT_EQ(ret, 0);
+	old_ptr =3D buffer->ptr;
+	buffer->ptr =3D map;
+
+	/* Initialize buffer in system memory. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ptr[i] =3D i;
+
+	/* Migrate memory to device. */
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_MIGRATE, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+
+	/* Check what the device read. */
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	/* Fault pages back to system memory and check them. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i) {
+		ASSERT_EQ(ptr[i], i);
+		/* If it asserts once, it probably will 500,000 times */
+		if (ptr[i] !=3D i)
+			break;
+	}
+
+	buffer->ptr =3D old_ptr;
+	hmm_buffer_free(buffer);
+}
+
 TEST_HARNESS_MAIN
--=20
2.20.1

