Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E662A8BA2
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Nov 2020 01:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732914AbgKFAwO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Nov 2020 19:52:14 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:9222 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732046AbgKFAwL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Nov 2020 19:52:11 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa49e330000>; Thu, 05 Nov 2020 16:52:03 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov
 2020 00:52:00 +0000
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 6 Nov 2020 00:52:00 +0000
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
Subject: [PATCH v3 5/6] mm/hmm/test: add self tests for THP migration
Date:   Thu, 5 Nov 2020 16:51:46 -0800
Message-ID: <20201106005147.20113-6-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201106005147.20113-1-rcampbell@nvidia.com>
References: <20201106005147.20113-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604623923; bh=HJgBSdblmUHzYWUtttEi4tz1xdYgHo7vsmF5EEM5+Fw=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=E7bSiFRGmu5CISMViBZUMnMvuctXWin3uNZNNWQjxzA4oIRFTV/ngTWX/RCjb+p1x
         o67FERDn6fhK8ZlJsO1OPDCwfCD5amaVOI/jzEDQh/J0ClyMr+kWTUice5m08Llk32
         5aL/iZl1LaQ+i4hAKOIIU0P7RLgfvt3FKv49GFLaaTYYW/WRExYIHJtNqVBmo2nnmb
         vDI1/UueKyFgHlKoiATAsfi39eLsumnx90oASooZB/G5da2XZ+UcRGGI3TbG46lITw
         T2ohXPg2rPGUV0FY0E6iaEupyQreKvduFEBfipJLKenLUcerna6+dnfsQYT4h3IQRi
         OlXzsBX8xpbDw==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add some basic stand alone self tests for migrating system memory to device
private memory and back.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 lib/test_hmm.c                         | 437 +++++++++++++++++++++----
 lib/test_hmm_uapi.h                    |   3 +
 tools/testing/selftests/vm/hmm-tests.c | 404 +++++++++++++++++++++++
 3 files changed, 775 insertions(+), 69 deletions(-)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 80a78877bd93..456f1a90bcc3 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -66,6 +66,7 @@ struct dmirror {
 	struct xarray			pt;
 	struct mmu_interval_notifier	notifier;
 	struct mutex			mutex;
+	__u64				flags;
 };
=20
 /*
@@ -91,6 +92,7 @@ struct dmirror_device {
 	unsigned long		calloc;
 	unsigned long		cfree;
 	struct page		*free_pages;
+	struct page		*free_huge_pages;
 	spinlock_t		lock;		/* protects the above */
 };
=20
@@ -450,6 +452,7 @@ static int dmirror_write(struct dmirror *dmirror, struc=
t hmm_dmirror_cmd *cmd)
 }
=20
 static bool dmirror_allocate_chunk(struct dmirror_device *mdevice,
+				   bool is_huge,
 				   struct page **ppage)
 {
 	struct dmirror_chunk *devmem;
@@ -503,28 +506,51 @@ static bool dmirror_allocate_chunk(struct dmirror_dev=
ice *mdevice,
=20
 	mutex_unlock(&mdevice->devmem_lock);
=20
-	pr_info("added new %u MB chunk (total %u chunks, %u MB) PFNs [0x%lx 0x%lx=
)\n",
+	pr_info("dev %u added %u MB (total %u chunks, %u MB) PFNs [0x%lx 0x%lx)\n=
",
+		MINOR(mdevice->cdevice.dev),
 		DEVMEM_CHUNK_SIZE / (1024 * 1024),
 		mdevice->devmem_count,
 		mdevice->devmem_count * (DEVMEM_CHUNK_SIZE / (1024 * 1024)),
 		pfn_first, pfn_last);
=20
 	spin_lock(&mdevice->lock);
-	for (pfn =3D pfn_first; pfn < pfn_last; pfn++) {
+	for (pfn =3D pfn_first; pfn < pfn_last; ) {
 		struct page *page =3D pfn_to_page(pfn);
=20
+		if (is_huge && (pfn & (HPAGE_PMD_NR - 1)) =3D=3D 0 &&
+		    pfn + HPAGE_PMD_NR <=3D pfn_last) {
+			prep_transhuge_device_private_page(page);
+			page->zone_device_data =3D mdevice->free_huge_pages;
+			mdevice->free_huge_pages =3D page;
+			pfn +=3D HPAGE_PMD_NR;
+			continue;
+		}
 		page->zone_device_data =3D mdevice->free_pages;
 		mdevice->free_pages =3D page;
+		pfn++;
 	}
 	if (ppage) {
-		*ppage =3D mdevice->free_pages;
-		mdevice->free_pages =3D (*ppage)->zone_device_data;
-		mdevice->calloc++;
+		if (is_huge) {
+			if (!mdevice->free_huge_pages)
+				goto err_unlock;
+			*ppage =3D mdevice->free_huge_pages;
+			mdevice->free_huge_pages =3D (*ppage)->zone_device_data;
+			mdevice->calloc +=3D thp_nr_pages(*ppage);
+		} else if (mdevice->free_pages) {
+			*ppage =3D mdevice->free_pages;
+			mdevice->free_pages =3D (*ppage)->zone_device_data;
+			mdevice->calloc++;
+		} else
+			goto err_unlock;
 	}
 	spin_unlock(&mdevice->lock);
=20
 	return true;
=20
+err_unlock:
+	spin_unlock(&mdevice->lock);
+	return false;
+
 err_release:
 	mutex_unlock(&mdevice->devmem_lock);
 	release_mem_region(devmem->pagemap.range.start, range_len(&devmem->pagema=
p.range));
@@ -534,7 +560,8 @@ static bool dmirror_allocate_chunk(struct dmirror_devic=
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
@@ -549,17 +576,40 @@ static struct page *dmirror_devmem_alloc_page(struct =
dmirror_device *mdevice)
=20
 	spin_lock(&mdevice->lock);
=20
-	if (mdevice->free_pages) {
+	if (is_huge && mdevice->free_huge_pages) {
+		dpage =3D mdevice->free_huge_pages;
+		mdevice->free_huge_pages =3D dpage->zone_device_data;
+		mdevice->calloc +=3D thp_nr_pages(dpage);
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
+		unsigned int nr_pages =3D thp_nr_pages(dpage);
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
@@ -570,22 +620,26 @@ static struct page *dmirror_devmem_alloc_page(struct =
dmirror_device *mdevice)
 	return NULL;
 }
=20
-static void dmirror_migrate_alloc_and_copy(struct migrate_vma *args,
-					   struct dmirror *dmirror)
+static int dmirror_migrate_alloc_and_copy(struct migrate_vma *args,
+					  struct dmirror *dmirror)
 {
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
+		unsigned long write;
+		struct page **tpage;
+		unsigned long endp;
=20
 		if (!(*src & MIGRATE_PFN_MIGRATE))
-			continue;
+			goto next;
=20
 		/*
 		 * Note that spage might be NULL which is OK since it is an
@@ -593,15 +647,39 @@ static void dmirror_migrate_alloc_and_copy(struct mig=
rate_vma *args,
 		 */
 		spage =3D migrate_pfn_to_page(*src);
=20
-		dpage =3D dmirror_devmem_alloc_page(mdevice);
-		if (!dpage)
+		/* This flag is only set if a whole huge page is migrated. */
+		is_huge =3D *src & MIGRATE_PFN_COMPOUND;
+		write =3D (*src & MIGRATE_PFN_WRITE) ? MIGRATE_PFN_WRITE : 0;
+
+		if (dmirror->flags & HMM_DMIRROR_FLAG_FAIL_ALLOC) {
+			dmirror->flags &=3D ~HMM_DMIRROR_FLAG_FAIL_ALLOC;
+			dpage =3D NULL;
+		} else
+			dpage =3D dmirror_devmem_alloc_page(mdevice, is_huge);
+		if (!dpage) {
+			if (!is_huge)
+				return -ENOMEM;
+			/* Try falling back to PAGE_SIZE pages. */
+			endp =3D pfn + HPAGE_PMD_NR;
+			while (pfn < endp) {
+				dpage =3D dmirror_devmem_alloc_page(mdevice,
+								  false);
+				if (!dpage)
+					return -ENOMEM;
+				rpage =3D dpage->zone_device_data;
+				rpage->zone_device_data =3D dmirror;
+				*dst =3D migrate_pfn(page_to_pfn(dpage)) |
+					MIGRATE_PFN_LOCKED | write;
+				if (spage)
+					copy_highpage(rpage, spage++);
+				else
+					clear_highpage(rpage);
+				pfn++;
+				src++;
+				dst++;
+			}
 			continue;
-
-		rpage =3D dpage->zone_device_data;
-		if (spage)
-			copy_highpage(rpage, spage);
-		else
-			clear_highpage(rpage);
+		}
=20
 		/*
 		 * Normally, a device would use the page->zone_device_data to
@@ -609,14 +687,40 @@ static void dmirror_migrate_alloc_and_copy(struct mig=
rate_vma *args,
 		 * the simulated device memory and that page holds the pointer
 		 * to the mirror.
 		 */
+		rpage =3D dpage->zone_device_data;
 		rpage->zone_device_data =3D dmirror;
=20
-		*dst =3D migrate_pfn(page_to_pfn(dpage)) |
-			    MIGRATE_PFN_LOCKED;
-		if ((*src & MIGRATE_PFN_WRITE) ||
-		    (!spage && args->vma->vm_flags & VM_WRITE))
-			*dst |=3D MIGRATE_PFN_WRITE;
+		*dst =3D migrate_pfn(page_to_pfn(dpage)) | MIGRATE_PFN_LOCKED |
+			write;
+
+		if (is_huge) {
+			endp =3D pfn + thp_nr_pages(dpage);
+			*dst |=3D MIGRATE_PFN_COMPOUND;
+			tpage =3D kmap(rpage);
+			while (pfn < endp) {
+				if (spage)
+					copy_highpage(*tpage, spage++);
+				else
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
+	return 0;
 }
=20
 static int dmirror_migrate_finalize_and_map(struct migrate_vma *args,
@@ -627,38 +731,75 @@ static int dmirror_migrate_finalize_and_map(struct mi=
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
+			unsigned long end_pfn =3D pfn + thp_nr_pages(dpage);
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
-			mutex_unlock(&dmirror->mutex);
-			return xa_err(entry);
+			ret =3D xa_err(entry);
+			goto err;
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
@@ -668,8 +809,8 @@ static int dmirror_migrate(struct dmirror *dmirror,
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
@@ -684,6 +825,17 @@ static int dmirror_migrate(struct dmirror *dmirror,
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
@@ -692,7 +844,7 @@ static int dmirror_migrate(struct dmirror *dmirror,
 			ret =3D -EINVAL;
 			goto out;
 		}
-		next =3D min(end, addr + (ARRAY_SIZE(src_pfns) << PAGE_SHIFT));
+		next =3D pmd_addr_end(addr, end);
 		if (next > vma->vm_end)
 			next =3D vma->vm_end;
=20
@@ -702,17 +854,24 @@ static int dmirror_migrate(struct dmirror *dmirror,
 		args.start =3D addr;
 		args.end =3D next;
 		args.pgmap_owner =3D dmirror->mdevice;
-		args.flags =3D MIGRATE_VMA_SELECT_SYSTEM;
+		args.flags =3D MIGRATE_VMA_SELECT_SYSTEM |
+			     MIGRATE_VMA_SELECT_COMPOUND;
 		ret =3D migrate_vma_setup(&args);
 		if (ret)
 			goto out;
=20
-		dmirror_migrate_alloc_and_copy(&args, dmirror);
-		migrate_vma_pages(&args);
-		dmirror_migrate_finalize_and_map(&args, dmirror);
+		ret =3D dmirror_migrate_alloc_and_copy(&args, dmirror);
+		if (!ret) {
+			migrate_vma_pages(&args);
+			dmirror_migrate_finalize_and_map(&args, dmirror);
+		}
 		migrate_vma_finalize(&args);
+		if (ret)
+			goto out;
 	}
 	mmap_read_unlock(mm);
+	kfree(dst_pfns);
+	kfree(src_pfns);
 	mmput(mm);
=20
 	/* Return the migrated data for verification. */
@@ -733,6 +892,10 @@ static int dmirror_migrate(struct dmirror *dmirror,
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
@@ -953,6 +1116,11 @@ static long dmirror_fops_unlocked_ioctl(struct file *=
filp,
 		ret =3D dmirror_snapshot(dmirror, &cmd);
 		break;
=20
+	case HMM_DMIRROR_FLAGS:
+		dmirror->flags =3D cmd.npages;
+		ret =3D 0;
+		break;
+
 	default:
 		return -EINVAL;
 	}
@@ -976,22 +1144,70 @@ static const struct file_operations dmirror_fops =3D=
 {
 static void dmirror_devmem_free(struct page *page)
 {
 	struct page *rpage =3D page->zone_device_data;
+	unsigned int order =3D thp_order(page);
+	unsigned int nr_pages =3D 1U << order;
 	struct dmirror_device *mdevice;
=20
-	if (rpage)
+	VM_BUG_ON_PAGE(PageTail(page), page);
+
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
+static void dmirror_devmem_split(struct page *head, struct page *page)
+{
+	struct page *rpage =3D head->zone_device_data;
+	unsigned long i;
+	struct page **tpage;
+	void *kaddr;
+
+	page->pgmap =3D head->pgmap;
+
+	if (!rpage) {
+		page->zone_device_data =3D NULL;
+		return;
+	}
+
+	kaddr =3D kmap_atomic(rpage);
+	tpage =3D kaddr;
+	i =3D page - head;
+	page->zone_device_data =3D tpage[i];
+	if (i =3D=3D 1) {
+		head->zone_device_data =3D tpage[0];
+		kunmap_atomic(kaddr);
+		__free_page(rpage);
+	} else
+		kunmap_atomic(kaddr);
+}
+
 static vm_fault_t dmirror_devmem_fault_alloc_and_copy(struct migrate_vma *=
args,
-						      struct dmirror *dmirror)
+						      struct dmirror *dmirror,
+						      unsigned long fault_addr)
 {
 	const unsigned long *src =3D args->src;
 	unsigned long *dst =3D args->dst;
@@ -999,25 +1215,71 @@ static vm_fault_t dmirror_devmem_fault_alloc_and_cop=
y(struct migrate_vma *args,
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
+		struct page **tpage;
+		unsigned int i;
=20
 		spage =3D migrate_pfn_to_page(*src);
 		if (!spage || !(*src & MIGRATE_PFN_MIGRATE))
-			continue;
+			goto next;
+		order =3D thp_order(spage);
+		nr_pages =3D 1U << order;
+		/* The source page is the ZONE_DEVICE private page. */
 		spage =3D spage->zone_device_data;
=20
-		dpage =3D alloc_page_vma(GFP_HIGHUSER_MOVABLE, args->vma, addr);
-		if (!dpage)
-			continue;
+		if (dmirror->flags & HMM_DMIRROR_FLAG_FAIL_ALLOC) {
+			dmirror->flags &=3D ~HMM_DMIRROR_FLAG_FAIL_ALLOC;
+			dpage =3D NULL;
+		} else if (order)
+			dpage =3D alloc_transhugepage(args->vma, addr);
+		else
+			dpage =3D alloc_pages_vma(GFP_HIGHUSER_MOVABLE, 0,
+						args->vma, addr,
+						numa_node_id(), false);
+		if (!dpage) {
+			if (!order)
+				return VM_FAULT_OOM;
+			/* Try falling back to PAGE_SIZE pages. */
+			dpage =3D alloc_pages_vma(GFP_HIGHUSER_MOVABLE, 0,
+						args->vma, addr,
+						numa_node_id(), false);
+			if (!dpage)
+				return VM_FAULT_OOM;
+			lock_page(dpage);
+			xa_erase(&dmirror->pt, fault_addr >> PAGE_SHIFT);
+			i =3D (fault_addr - start) >> PAGE_SHIFT;
+			dst[i] =3D migrate_pfn(page_to_pfn(dpage)) | MIGRATE_PFN_LOCKED;
+			if (*src & MIGRATE_PFN_WRITE)
+				dst[i] |=3D MIGRATE_PFN_WRITE;
+			tpage =3D kmap(spage);
+			copy_highpage(dpage, tpage[i]);
+			kunmap(spage);
+			goto next;
+		}
=20
 		lock_page(dpage);
 		xa_erase(&dmirror->pt, addr >> PAGE_SHIFT);
-		copy_highpage(dpage, spage);
 		*dst =3D migrate_pfn(page_to_pfn(dpage)) | MIGRATE_PFN_LOCKED;
 		if (*src & MIGRATE_PFN_WRITE)
 			*dst |=3D MIGRATE_PFN_WRITE;
+		if (order) {
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
@@ -1027,33 +1289,55 @@ static vm_fault_t dmirror_devmem_fault(struct vm_fa=
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
+	page =3D thp_head(vmf->page);
+	order =3D thp_order(page);
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
 	args.pgmap_owner =3D dmirror->mdevice;
-	args.flags =3D MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
+	args.flags =3D MIGRATE_VMA_SELECT_DEVICE_PRIVATE |
+		     MIGRATE_VMA_SELECT_COMPOUND;
=20
-	if (migrate_vma_setup(&args))
-		return VM_FAULT_SIGBUS;
+	if (migrate_vma_setup(&args)) {
+		ret =3D VM_FAULT_SIGBUS;
+		goto error_dst;
+	}
=20
-	ret =3D dmirror_devmem_fault_alloc_and_copy(&args, dmirror);
+	ret =3D dmirror_devmem_fault_alloc_and_copy(&args, dmirror, vmf->address)=
;
 	if (ret)
-		return ret;
+		goto error_fin;
 	migrate_vma_pages(&args);
 	/*
 	 * No device finalize step is needed since
@@ -1061,12 +1345,27 @@ static vm_fault_t dmirror_devmem_fault(struct vm_fa=
ult *vmf)
 	 * invalidated the device page table.
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
 	.page_free	=3D dmirror_devmem_free,
 	.migrate_to_ram	=3D dmirror_devmem_fault,
+	.page_split	=3D dmirror_devmem_split,
 };
=20
 static int dmirror_device_init(struct dmirror_device *mdevice, int id)
@@ -1085,7 +1384,7 @@ static int dmirror_device_init(struct dmirror_device =
*mdevice, int id)
 		return ret;
=20
 	/* Build a list of free ZONE_DEVICE private struct pages */
-	dmirror_allocate_chunk(mdevice, NULL);
+	dmirror_allocate_chunk(mdevice, false, NULL);
=20
 	return 0;
 }
diff --git a/lib/test_hmm_uapi.h b/lib/test_hmm_uapi.h
index 670b4ef2a5b6..39e6ef3b67b9 100644
--- a/lib/test_hmm_uapi.h
+++ b/lib/test_hmm_uapi.h
@@ -33,6 +33,9 @@ struct hmm_dmirror_cmd {
 #define HMM_DMIRROR_WRITE		_IOWR('H', 0x01, struct hmm_dmirror_cmd)
 #define HMM_DMIRROR_MIGRATE		_IOWR('H', 0x02, struct hmm_dmirror_cmd)
 #define HMM_DMIRROR_SNAPSHOT		_IOWR('H', 0x03, struct hmm_dmirror_cmd)
+#define HMM_DMIRROR_FLAGS		_IOWR('H', 0x04, struct hmm_dmirror_cmd)
+
+#define HMM_DMIRROR_FLAG_FAIL_ALLOC	(1ULL << 0)
=20
 /*
  * Values returned in hmm_dmirror_cmd.ptr for HMM_DMIRROR_SNAPSHOT.
diff --git a/tools/testing/selftests/vm/hmm-tests.c b/tools/testing/selftes=
ts/vm/hmm-tests.c
index 5d1ac691b9f4..069c3cc3c89b 100644
--- a/tools/testing/selftests/vm/hmm-tests.c
+++ b/tools/testing/selftests/vm/hmm-tests.c
@@ -1485,4 +1485,408 @@ TEST_F(hmm2, double_map)
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
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	buffer->ptr =3D old_ptr;
+	hmm_buffer_free(buffer);
+}
+
+/*
+ * Migrate private anonymous huge page with allocation errors.
+ */
+TEST_F(hmm, migrate_anon_huge_err)
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
+	buffer->mirror =3D malloc(2 * size);
+	ASSERT_NE(buffer->mirror, NULL);
+	memset(buffer->mirror, 0xFF, 2 * size);
+
+	old_ptr =3D mmap(NULL, 2 * size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, buffer->fd, 0);
+	ASSERT_NE(old_ptr, MAP_FAILED);
+
+	npages =3D size >> self->page_shift;
+	map =3D (void *)ALIGN((uintptr_t)old_ptr, size);
+	ret =3D madvise(map, size, MADV_HUGEPAGE);
+	ASSERT_EQ(ret, 0);
+	buffer->ptr =3D map;
+
+	/* Initialize buffer in system memory. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ptr[i] =3D i;
+
+	/* Migrate memory to device but force a THP allocation error. */
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_FLAGS, buffer,
+			      HMM_DMIRROR_FLAG_FAIL_ALLOC);
+	ASSERT_EQ(ret, 0);
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_MIGRATE, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+
+	/* Check what the device read. */
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	/* Try faulting back a single (PAGE_SIZE) page. */
+	ptr =3D buffer->ptr;
+	ASSERT_EQ(ptr[2048], 2048);
+
+	/* unmap and remap the region to reset things. */
+	ret =3D munmap(old_ptr, 2 * size);
+	ASSERT_EQ(ret, 0);
+	old_ptr =3D mmap(NULL, 2 * size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, buffer->fd, 0);
+	ASSERT_NE(old_ptr, MAP_FAILED);
+	map =3D (void *)ALIGN((uintptr_t)old_ptr, size);
+	ret =3D madvise(map, size, MADV_HUGEPAGE);
+	ASSERT_EQ(ret, 0);
+	buffer->ptr =3D map;
+
+	/* Initialize buffer in system memory. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ptr[i] =3D i;
+
+	/* Migrate THP to device. */
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_MIGRATE, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+
+	/*
+	 * Force an allocation error when faulting back a THP resident in the
+	 * device.
+	 */
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_FLAGS, buffer,
+			      HMM_DMIRROR_FLAG_FAIL_ALLOC);
+	ASSERT_EQ(ret, 0);
+	ptr =3D buffer->ptr;
+	ASSERT_EQ(ptr[2048], 2048);
+
+	buffer->ptr =3D old_ptr;
+	hmm_buffer_free(buffer);
+}
+
+/*
+ * Migrate private anonymous huge zero page with allocation errors.
+ */
+TEST_F(hmm, migrate_anon_huge_zero_err)
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
+	buffer->mirror =3D malloc(2 * size);
+	ASSERT_NE(buffer->mirror, NULL);
+	memset(buffer->mirror, 0xFF, 2 * size);
+
+	old_ptr =3D mmap(NULL, 2 * size, PROT_READ,
+			MAP_PRIVATE | MAP_ANONYMOUS, buffer->fd, 0);
+	ASSERT_NE(old_ptr, MAP_FAILED);
+
+	npages =3D size >> self->page_shift;
+	map =3D (void *)ALIGN((uintptr_t)old_ptr, size);
+	ret =3D madvise(map, size, MADV_HUGEPAGE);
+	ASSERT_EQ(ret, 0);
+	buffer->ptr =3D map;
+
+	/* Migrate memory to device but force a THP allocation error. */
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_FLAGS, buffer,
+			      HMM_DMIRROR_FLAG_FAIL_ALLOC);
+	ASSERT_EQ(ret, 0);
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_MIGRATE, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+
+	/* Check what the device read. */
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], 0);
+
+	/* Try faulting back a single (PAGE_SIZE) page. */
+	ptr =3D buffer->ptr;
+	ASSERT_EQ(ptr[2048], 0);
+
+	/* unmap and remap the region to reset things. */
+	ret =3D munmap(old_ptr, 2 * size);
+	ASSERT_EQ(ret, 0);
+	old_ptr =3D mmap(NULL, 2 * size, PROT_READ,
+			MAP_PRIVATE | MAP_ANONYMOUS, buffer->fd, 0);
+	ASSERT_NE(old_ptr, MAP_FAILED);
+	map =3D (void *)ALIGN((uintptr_t)old_ptr, size);
+	ret =3D madvise(map, size, MADV_HUGEPAGE);
+	ASSERT_EQ(ret, 0);
+	buffer->ptr =3D map;
+
+	/* Initialize buffer in system memory (zero THP page). */
+	ret =3D ptr[0];
+	ASSERT_EQ(ret, 0);
+
+	/* Migrate memory to device but force a THP allocation error. */
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_FLAGS, buffer,
+			      HMM_DMIRROR_FLAG_FAIL_ALLOC);
+	ASSERT_EQ(ret, 0);
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_MIGRATE, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+
+	/* Fault the device memory back and check it. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], 0);
+
+	buffer->ptr =3D old_ptr;
+	hmm_buffer_free(buffer);
+}
+
 TEST_HARNESS_MAIN
--=20
2.20.1

