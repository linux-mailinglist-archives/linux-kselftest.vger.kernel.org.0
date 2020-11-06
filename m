Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91BC02A8B94
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Nov 2020 01:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732776AbgKFAwC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Nov 2020 19:52:02 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8415 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732766AbgKFAwC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Nov 2020 19:52:02 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa49e330002>; Thu, 05 Nov 2020 16:52:03 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov
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
        Ben Skeggs <bskeggs@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Ralph Campbell" <rcampbell@nvidia.com>
Subject: [PATCH v3 6/6] nouveau: support THP migration to private memory
Date:   Thu, 5 Nov 2020 16:51:47 -0800
Message-ID: <20201106005147.20113-7-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201106005147.20113-1-rcampbell@nvidia.com>
References: <20201106005147.20113-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604623923; bh=ZURvnxKXlfn5GsZ+q5+KDP7pZmcv+fM/nm5QHJ+NNZY=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=IwR2UL5UT8pvS6dhzzKAoW8aqK9cQQEY//RqZLxc4WMmMuYWfRwN24rkT0afqbM3K
         fdAsxWfVsjU7321sELUmXiEHjDkJZA2zM775Fygz758dyiKREnSP6XxsGBoxLp1AVG
         UifL1OZr+qr3Wxj7ARl+AySqoMjGxInQ1m2LPbboAF53QW8C3oCUygv94njc5W4vsL
         bk2cvc3drrmfr6G22AJO6ceDtdYeeNokaTKBpM166h1NaEJ3PtavedCCRtcEgDCF9N
         0Ixt9B8b5v2eh8LNKm3YulSTv+ypx2NNlwH286NE5LOaYJiYmetKnJKFplLo25+lYo
         rG4ZZ0BNdZyQQ==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add support for migrating transparent huge pages to and from device
private memory.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c | 289 ++++++++++++++++++-------
 drivers/gpu/drm/nouveau/nouveau_svm.c  |  11 +-
 drivers/gpu/drm/nouveau/nouveau_svm.h  |   3 +-
 3 files changed, 215 insertions(+), 88 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouve=
au/nouveau_dmem.c
index 92987daa5e17..93eea8e9d987 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -82,6 +82,7 @@ struct nouveau_dmem {
 	struct list_head chunks;
 	struct mutex mutex;
 	struct page *free_pages;
+	struct page *free_huge_pages;
 	spinlock_t lock;
 };
=20
@@ -112,8 +113,13 @@ static void nouveau_dmem_page_free(struct page *page)
 	struct nouveau_dmem *dmem =3D chunk->drm->dmem;
=20
 	spin_lock(&dmem->lock);
-	page->zone_device_data =3D dmem->free_pages;
-	dmem->free_pages =3D page;
+	if (PageHead(page)) {
+		page->zone_device_data =3D dmem->free_huge_pages;
+		dmem->free_huge_pages =3D page;
+	} else {
+		page->zone_device_data =3D dmem->free_pages;
+		dmem->free_pages =3D page;
+	}
=20
 	WARN_ON(!chunk->callocated);
 	chunk->callocated--;
@@ -139,51 +145,100 @@ static void nouveau_dmem_fence_done(struct nouveau_f=
ence **fence)
=20
 static vm_fault_t nouveau_dmem_fault_copy_one(struct nouveau_drm *drm,
 		struct vm_fault *vmf, struct migrate_vma *args,
-		dma_addr_t *dma_addr)
+		struct page *spage, bool is_huge, dma_addr_t *dma_addr)
 {
+	struct nouveau_svmm *svmm =3D spage->zone_device_data;
 	struct device *dev =3D drm->dev->dev;
-	struct page *dpage, *spage;
-	struct nouveau_svmm *svmm;
-
-	spage =3D migrate_pfn_to_page(args->src[0]);
-	if (!spage || !(args->src[0] & MIGRATE_PFN_MIGRATE))
-		return 0;
+	struct page *dpage;
+	unsigned int i;
=20
-	dpage =3D alloc_page_vma(GFP_HIGHUSER, vmf->vma, vmf->address);
+	if (is_huge)
+		dpage =3D alloc_transhugepage(vmf->vma, args->start);
+	else
+		dpage =3D alloc_page_vma(GFP_HIGHUSER, vmf->vma, vmf->address);
 	if (!dpage)
-		return VM_FAULT_SIGBUS;
-	lock_page(dpage);
+		return VM_FAULT_OOM;
+	WARN_ON_ONCE(thp_order(spage) !=3D thp_order(dpage));
=20
-	*dma_addr =3D dma_map_page(dev, dpage, 0, PAGE_SIZE, DMA_BIDIRECTIONAL);
+	*dma_addr =3D dma_map_page(dev, dpage, 0, page_size(dpage),
+				 DMA_BIDIRECTIONAL);
 	if (dma_mapping_error(dev, *dma_addr))
 		goto error_free_page;
=20
-	svmm =3D spage->zone_device_data;
+	lock_page(dpage);
+	i =3D (vmf->address - args->start) >> PAGE_SHIFT;
+	spage +=3D i;
 	mutex_lock(&svmm->mutex);
 	nouveau_svmm_invalidate(svmm, args->start, args->end);
-	if (drm->dmem->migrate.copy_func(drm, 1, NOUVEAU_APER_HOST, *dma_addr,
-			NOUVEAU_APER_VRAM, nouveau_dmem_page_addr(spage)))
+	if (drm->dmem->migrate.copy_func(drm, thp_nr_pages(dpage),
+			NOUVEAU_APER_HOST, *dma_addr, NOUVEAU_APER_VRAM,
+			nouveau_dmem_page_addr(spage)))
 		goto error_dma_unmap;
 	mutex_unlock(&svmm->mutex);
=20
-	args->dst[0] =3D migrate_pfn(page_to_pfn(dpage)) | MIGRATE_PFN_LOCKED;
+	args->dst[i] =3D migrate_pfn(page_to_pfn(dpage)) | MIGRATE_PFN_LOCKED;
+	if (is_huge)
+		args->dst[i] |=3D MIGRATE_PFN_COMPOUND;
 	return 0;
=20
 error_dma_unmap:
 	mutex_unlock(&svmm->mutex);
-	dma_unmap_page(dev, *dma_addr, PAGE_SIZE, DMA_BIDIRECTIONAL);
+	unlock_page(dpage);
+	dma_unmap_page(dev, *dma_addr, page_size(dpage), DMA_BIDIRECTIONAL);
 error_free_page:
 	__free_page(dpage);
 	return VM_FAULT_SIGBUS;
 }
=20
+static vm_fault_t nouveau_dmem_fault_chunk(struct nouveau_drm *drm,
+		struct vm_fault *vmf, struct migrate_vma *args)
+{
+	struct device *dev =3D drm->dev->dev;
+	struct nouveau_fence *fence;
+	struct page *spage;
+	unsigned long src =3D args->src[0];
+	bool is_huge =3D (src & (MIGRATE_PFN_MIGRATE | MIGRATE_PFN_COMPOUND)) =3D=
=3D
+		(MIGRATE_PFN_MIGRATE | MIGRATE_PFN_COMPOUND);
+	unsigned long dma_page_size;
+	dma_addr_t dma_addr;
+	vm_fault_t ret =3D 0;
+
+	spage =3D migrate_pfn_to_page(src);
+	if (!spage) {
+		ret =3D VM_FAULT_SIGBUS;
+		goto out;
+	}
+	if (is_huge) {
+		dma_page_size =3D PMD_SIZE;
+		ret =3D nouveau_dmem_fault_copy_one(drm, vmf, args, spage, true,
+						  &dma_addr);
+		if (!ret)
+			goto fence;
+		/*
+		 * If we couldn't allocate a huge page, fallback to migrating
+		 * a single page.
+		 */
+	}
+	dma_page_size =3D PAGE_SIZE;
+	ret =3D nouveau_dmem_fault_copy_one(drm, vmf, args, spage, false,
+					  &dma_addr);
+	if (ret)
+		goto out;
+fence:
+	nouveau_fence_new(drm->dmem->migrate.chan, false, &fence);
+	migrate_vma_pages(args);
+	nouveau_dmem_fence_done(&fence);
+	dma_unmap_page(dev, dma_addr, dma_page_size, DMA_BIDIRECTIONAL);
+out:
+	migrate_vma_finalize(args);
+	return ret;
+}
+
 static vm_fault_t nouveau_dmem_migrate_to_ram(struct vm_fault *vmf)
 {
 	struct nouveau_drm *drm =3D page_to_drm(vmf->page);
-	struct nouveau_dmem *dmem =3D drm->dmem;
-	struct nouveau_fence *fence;
 	unsigned long src =3D 0, dst =3D 0;
-	dma_addr_t dma_addr =3D 0;
+	struct page *page;
 	vm_fault_t ret;
 	struct migrate_vma args =3D {
 		.vma		=3D vmf->vma,
@@ -192,39 +247,64 @@ static vm_fault_t nouveau_dmem_migrate_to_ram(struct =
vm_fault *vmf)
 		.src		=3D &src,
 		.dst		=3D &dst,
 		.pgmap_owner	=3D drm->dev,
-		.flags		=3D MIGRATE_VMA_SELECT_DEVICE_PRIVATE,
+		.flags		=3D MIGRATE_VMA_SELECT_DEVICE_PRIVATE |
+				  MIGRATE_VMA_SELECT_COMPOUND,
 	};
=20
+	/*
+	 * If the page was migrated to the GPU as a huge page, try to
+	 * migrate it back the same way.
+	 */
+	page =3D thp_head(vmf->page);
+	if (PageHead(page)) {
+		unsigned int order =3D thp_order(page);
+		unsigned int nr_pages =3D 1U << order;
+
+		args.start &=3D PAGE_MASK << order;
+		args.end =3D args.start + (PAGE_SIZE << order);
+		args.src =3D kmalloc_array(nr_pages, sizeof(*args.src),
+					 GFP_KERNEL);
+		if (!args.src)
+			return VM_FAULT_OOM;
+		args.dst =3D kmalloc_array(nr_pages, sizeof(*args.dst),
+					 GFP_KERNEL);
+		if (!args.dst) {
+			ret =3D VM_FAULT_OOM;
+			goto error_src;
+		}
+	}
+
 	/*
 	 * FIXME what we really want is to find some heuristic to migrate more
 	 * than just one page on CPU fault. When such fault happens it is very
 	 * likely that more surrounding page will CPU fault too.
 	 */
-	if (migrate_vma_setup(&args) < 0)
-		return VM_FAULT_SIGBUS;
-	if (!args.cpages)
-		return 0;
-
-	ret =3D nouveau_dmem_fault_copy_one(drm, vmf, &args, &dma_addr);
-	if (ret || dst =3D=3D 0)
-		goto done;
-
-	nouveau_fence_new(dmem->migrate.chan, false, &fence);
-	migrate_vma_pages(&args);
-	nouveau_dmem_fence_done(&fence);
-	dma_unmap_page(drm->dev->dev, dma_addr, PAGE_SIZE, DMA_BIDIRECTIONAL);
-done:
-	migrate_vma_finalize(&args);
+	if (migrate_vma_setup(&args))
+		ret =3D VM_FAULT_SIGBUS;
+	else
+		ret =3D nouveau_dmem_fault_chunk(drm, vmf, &args);
+	if (args.dst !=3D &dst)
+		kfree(args.dst);
+error_src:
+	if (args.src !=3D &src)
+		kfree(args.src);
 	return ret;
 }
=20
+static void nouveau_page_split(struct page *head, struct page *page)
+{
+	page->pgmap =3D head->pgmap;
+	page->zone_device_data =3D head->zone_device_data;
+}
+
 static const struct dev_pagemap_ops nouveau_dmem_pagemap_ops =3D {
 	.page_free		=3D nouveau_dmem_page_free,
 	.migrate_to_ram		=3D nouveau_dmem_migrate_to_ram,
+	.page_split		=3D nouveau_page_split,
 };
=20
-static int
-nouveau_dmem_chunk_alloc(struct nouveau_drm *drm, struct page **ppage)
+static int nouveau_dmem_chunk_alloc(struct nouveau_drm *drm, bool is_huge,
+				    struct page **ppage)
 {
 	struct nouveau_dmem_chunk *chunk;
 	struct resource *res;
@@ -278,16 +358,20 @@ nouveau_dmem_chunk_alloc(struct nouveau_drm *drm, str=
uct page **ppage)
 	pfn_first =3D chunk->pagemap.range.start >> PAGE_SHIFT;
 	page =3D pfn_to_page(pfn_first);
 	spin_lock(&drm->dmem->lock);
-	for (i =3D 0; i < DMEM_CHUNK_NPAGES - 1; ++i, ++page) {
-		page->zone_device_data =3D drm->dmem->free_pages;
-		drm->dmem->free_pages =3D page;
-	}
+	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && is_huge)
+		prep_transhuge_device_private_page(page);
+	else
+		for (i =3D 0; i < DMEM_CHUNK_NPAGES - 1; ++i, ++page) {
+			page->zone_device_data =3D drm->dmem->free_pages;
+			drm->dmem->free_pages =3D page;
+		}
 	*ppage =3D page;
 	chunk->callocated++;
 	spin_unlock(&drm->dmem->lock);
=20
-	NV_INFO(drm, "DMEM: registered %ldMB of device memory\n",
-		DMEM_CHUNK_SIZE >> 20);
+	NV_INFO(drm, "DMEM: registered %ldMB of %sdevice memory %lx %lx\n",
+		DMEM_CHUNK_SIZE >> 20, is_huge ? "huge " : "", pfn_first,
+		nouveau_dmem_page_addr(page));
=20
 	return 0;
=20
@@ -304,14 +388,20 @@ nouveau_dmem_chunk_alloc(struct nouveau_drm *drm, str=
uct page **ppage)
 }
=20
 static struct page *
-nouveau_dmem_page_alloc_locked(struct nouveau_drm *drm)
+nouveau_dmem_page_alloc_locked(struct nouveau_drm *drm, bool is_huge)
 {
 	struct nouveau_dmem_chunk *chunk;
 	struct page *page =3D NULL;
 	int ret;
=20
 	spin_lock(&drm->dmem->lock);
-	if (drm->dmem->free_pages) {
+	if (is_huge && drm->dmem->free_huge_pages) {
+		page =3D drm->dmem->free_huge_pages;
+		drm->dmem->free_huge_pages =3D page->zone_device_data;
+		chunk =3D nouveau_page_to_chunk(page);
+		chunk->callocated++;
+		spin_unlock(&drm->dmem->lock);
+	} else if (!is_huge && drm->dmem->free_pages) {
 		page =3D drm->dmem->free_pages;
 		drm->dmem->free_pages =3D page->zone_device_data;
 		chunk =3D nouveau_page_to_chunk(page);
@@ -319,7 +409,7 @@ nouveau_dmem_page_alloc_locked(struct nouveau_drm *drm)
 		spin_unlock(&drm->dmem->lock);
 	} else {
 		spin_unlock(&drm->dmem->lock);
-		ret =3D nouveau_dmem_chunk_alloc(drm, &page);
+		ret =3D nouveau_dmem_chunk_alloc(drm, is_huge, &page);
 		if (ret)
 			return NULL;
 	}
@@ -567,31 +657,22 @@ nouveau_dmem_init(struct nouveau_drm *drm)
=20
 static unsigned long nouveau_dmem_migrate_copy_one(struct nouveau_drm *drm=
,
 		struct nouveau_svmm *svmm, unsigned long src,
-		dma_addr_t *dma_addr, u64 *pfn)
+		struct page *spage, bool is_huge, dma_addr_t dma_addr, u64 *pfn)
 {
-	struct device *dev =3D drm->dev->dev;
-	struct page *dpage, *spage;
+	struct page *dpage;
 	unsigned long paddr;
+	unsigned long dst;
=20
-	spage =3D migrate_pfn_to_page(src);
-	if (!(src & MIGRATE_PFN_MIGRATE))
-		goto out;
-
-	dpage =3D nouveau_dmem_page_alloc_locked(drm);
+	dpage =3D nouveau_dmem_page_alloc_locked(drm, is_huge);
 	if (!dpage)
 		goto out;
=20
 	paddr =3D nouveau_dmem_page_addr(dpage);
 	if (spage) {
-		*dma_addr =3D dma_map_page(dev, spage, 0, page_size(spage),
-					 DMA_BIDIRECTIONAL);
-		if (dma_mapping_error(dev, *dma_addr))
+		if (drm->dmem->migrate.copy_func(drm, thp_nr_pages(dpage),
+			NOUVEAU_APER_VRAM, paddr, NOUVEAU_APER_HOST, dma_addr))
 			goto out_free_page;
-		if (drm->dmem->migrate.copy_func(drm, 1,
-			NOUVEAU_APER_VRAM, paddr, NOUVEAU_APER_HOST, *dma_addr))
-			goto out_dma_unmap;
 	} else {
-		*dma_addr =3D DMA_MAPPING_ERROR;
 		if (drm->dmem->migrate.clear_func(drm, page_size(dpage),
 			NOUVEAU_APER_VRAM, paddr))
 			goto out_free_page;
@@ -602,10 +683,11 @@ static unsigned long nouveau_dmem_migrate_copy_one(st=
ruct nouveau_drm *drm,
 		((paddr >> PAGE_SHIFT) << NVIF_VMM_PFNMAP_V0_ADDR_SHIFT);
 	if (src & MIGRATE_PFN_WRITE)
 		*pfn |=3D NVIF_VMM_PFNMAP_V0_W;
-	return migrate_pfn(page_to_pfn(dpage)) | MIGRATE_PFN_LOCKED;
+	dst =3D migrate_pfn(page_to_pfn(dpage)) | MIGRATE_PFN_LOCKED;
+	if (PageHead(dpage))
+		dst |=3D MIGRATE_PFN_COMPOUND;
+	return dst;
=20
-out_dma_unmap:
-	dma_unmap_page(dev, *dma_addr, PAGE_SIZE, DMA_BIDIRECTIONAL);
 out_free_page:
 	nouveau_dmem_page_free_locked(drm, dpage);
 out:
@@ -617,26 +699,64 @@ static void nouveau_dmem_migrate_chunk(struct nouveau=
_drm *drm,
 		struct nouveau_svmm *svmm, struct migrate_vma *args,
 		dma_addr_t *dma_addrs, u64 *pfns)
 {
+	struct device *dev =3D drm->dev->dev;
 	struct nouveau_fence *fence;
 	unsigned long addr =3D args->start, nr_dma =3D 0, i;
+	unsigned int page_shift =3D PAGE_SHIFT;
+	struct page *spage;
+	unsigned long src =3D args->src[0];
+	bool is_huge =3D (src & (MIGRATE_PFN_MIGRATE | MIGRATE_PFN_COMPOUND)) =3D=
=3D
+		(MIGRATE_PFN_MIGRATE | MIGRATE_PFN_COMPOUND);
+	unsigned long dma_page_size =3D is_huge ? PMD_SIZE : PAGE_SIZE;
+
+	if (is_huge) {
+		spage =3D migrate_pfn_to_page(src);
+		if (spage) {
+			dma_addrs[nr_dma] =3D dma_map_page(dev, spage, 0,
+							 page_size(spage),
+							 DMA_BIDIRECTIONAL);
+			if (dma_mapping_error(dev, dma_addrs[nr_dma]))
+				goto out;
+			nr_dma++;
+		}
+		args->dst[0] =3D nouveau_dmem_migrate_copy_one(drm, svmm, src,
+				spage, true, *dma_addrs, pfns);
+		if (args->dst[0] & MIGRATE_PFN_COMPOUND) {
+			page_shift =3D PMD_SHIFT;
+			i =3D 1;
+			goto fence;
+		}
+	}
=20
-	for (i =3D 0; addr < args->end; i++) {
-		args->dst[i] =3D nouveau_dmem_migrate_copy_one(drm, svmm,
-				args->src[i], dma_addrs + nr_dma, pfns + i);
-		if (!dma_mapping_error(drm->dev->dev, dma_addrs[nr_dma]))
+	for (i =3D 0; addr < args->end; i++, addr +=3D PAGE_SIZE) {
+		src =3D args->src[i];
+		if (!(src & MIGRATE_PFN_MIGRATE))
+			continue;
+		spage =3D migrate_pfn_to_page(src);
+		if (spage && !is_huge) {
+			dma_addrs[i] =3D dma_map_page(dev, spage, 0,
+						    page_size(spage),
+						    DMA_BIDIRECTIONAL);
+			if (dma_mapping_error(dev, dma_addrs[i]))
+				break;
 			nr_dma++;
-		addr +=3D PAGE_SIZE;
+		} else if (spage && is_huge && i !=3D 0)
+			dma_addrs[i] =3D dma_addrs[i - 1] + PAGE_SIZE;
+		args->dst[i] =3D nouveau_dmem_migrate_copy_one(drm, svmm, src,
+				spage, false, dma_addrs[i], pfns + i);
 	}
=20
+fence:
 	nouveau_fence_new(drm->dmem->migrate.chan, false, &fence);
 	migrate_vma_pages(args);
 	nouveau_dmem_fence_done(&fence);
-	nouveau_pfns_map(svmm, args->vma->vm_mm, args->start, pfns, i);
+	nouveau_pfns_map(svmm, args->vma->vm_mm, args->start, pfns, i,
+			 page_shift);
=20
-	while (nr_dma--) {
-		dma_unmap_page(drm->dev->dev, dma_addrs[nr_dma], PAGE_SIZE,
-				DMA_BIDIRECTIONAL);
-	}
+	while (nr_dma)
+		dma_unmap_page(drm->dev->dev, dma_addrs[--nr_dma],
+				dma_page_size, DMA_BIDIRECTIONAL);
+out:
 	migrate_vma_finalize(args);
 }
=20
@@ -648,25 +768,25 @@ nouveau_dmem_migrate_vma(struct nouveau_drm *drm,
 			 unsigned long end)
 {
 	unsigned long npages =3D (end - start) >> PAGE_SHIFT;
-	unsigned long max =3D min(SG_MAX_SINGLE_ALLOC, npages);
+	unsigned long max =3D min(1UL << (PMD_SHIFT - PAGE_SHIFT), npages);
 	dma_addr_t *dma_addrs;
 	struct migrate_vma args =3D {
 		.vma		=3D vma,
 		.start		=3D start,
 		.pgmap_owner	=3D drm->dev,
-		.flags		=3D MIGRATE_VMA_SELECT_SYSTEM,
+		.flags		=3D MIGRATE_VMA_SELECT_SYSTEM |
+				  MIGRATE_VMA_SELECT_COMPOUND,
 	};
-	unsigned long i;
 	u64 *pfns;
 	int ret =3D -ENOMEM;
=20
 	if (drm->dmem =3D=3D NULL)
 		return -ENODEV;
=20
-	args.src =3D kcalloc(max, sizeof(*args.src), GFP_KERNEL);
+	args.src =3D kmalloc_array(max, sizeof(*args.src), GFP_KERNEL);
 	if (!args.src)
 		goto out;
-	args.dst =3D kcalloc(max, sizeof(*args.dst), GFP_KERNEL);
+	args.dst =3D kmalloc_array(max, sizeof(*args.dst), GFP_KERNEL);
 	if (!args.dst)
 		goto out_free_src;
=20
@@ -678,8 +798,10 @@ nouveau_dmem_migrate_vma(struct nouveau_drm *drm,
 	if (!pfns)
 		goto out_free_dma;
=20
-	for (i =3D 0; i < npages; i +=3D max) {
-		args.end =3D start + (max << PAGE_SHIFT);
+	for (; args.start < end; args.start =3D args.end) {
+		args.end =3D min(end, ALIGN(args.start, PMD_SIZE));
+		if (args.start =3D=3D args.end)
+			args.end =3D min(end, args.start + PMD_SIZE);
 		ret =3D migrate_vma_setup(&args);
 		if (ret)
 			goto out_free_pfns;
@@ -687,7 +809,6 @@ nouveau_dmem_migrate_vma(struct nouveau_drm *drm,
 		if (args.cpages)
 			nouveau_dmem_migrate_chunk(drm, svmm, &args, dma_addrs,
 						   pfns);
-		args.start =3D args.end;
 	}
=20
 	ret =3D 0;
diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouvea=
u/nouveau_svm.c
index 4f69e4c3dafd..3db0997f21b5 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -681,7 +681,6 @@ nouveau_svm_fault(struct nvif_notify *notify)
 			nouveau_svm_fault_cancel_fault(svm, buffer->fault[fi]);
 			continue;
 		}
-		SVMM_DBG(svmm, "addr %016llx", buffer->fault[fi]->addr);
=20
 		/* We try and group handling of faults within a small
 		 * window into a single update.
@@ -733,6 +732,10 @@ nouveau_svm_fault(struct nvif_notify *notify)
 		}
 		mmput(mm);
=20
+		SVMM_DBG(svmm, "addr %llx %s %c", buffer->fault[fi]->addr,
+			args.phys[0] & NVIF_VMM_PFNMAP_V0_VRAM ?
+			"vram" : "sysmem",
+			args.i.p.size > PAGE_SIZE ? 'H' : 'N');
 		limit =3D args.i.p.addr + args.i.p.size;
 		for (fn =3D fi; ++fn < buffer->fault_nr; ) {
 			/* It's okay to skip over duplicate addresses from the
@@ -804,13 +807,15 @@ nouveau_pfns_free(u64 *pfns)
=20
 void
 nouveau_pfns_map(struct nouveau_svmm *svmm, struct mm_struct *mm,
-		 unsigned long addr, u64 *pfns, unsigned long npages)
+		 unsigned long addr, u64 *pfns, unsigned long npages,
+		 unsigned int page_shift)
 {
 	struct nouveau_pfnmap_args *args =3D nouveau_pfns_to_args(pfns);
 	int ret;
=20
 	args->p.addr =3D addr;
-	args->p.size =3D npages << PAGE_SHIFT;
+	args->p.page =3D page_shift;
+	args->p.size =3D npages << args->p.page;
=20
 	mutex_lock(&svmm->mutex);
=20
diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.h b/drivers/gpu/drm/nouvea=
u/nouveau_svm.h
index e7d63d7f0c2d..3fd78662f17e 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.h
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.h
@@ -33,7 +33,8 @@ void nouveau_svmm_invalidate(struct nouveau_svmm *svmm, u=
64 start, u64 limit);
 u64 *nouveau_pfns_alloc(unsigned long npages);
 void nouveau_pfns_free(u64 *pfns);
 void nouveau_pfns_map(struct nouveau_svmm *svmm, struct mm_struct *mm,
-		      unsigned long addr, u64 *pfns, unsigned long npages);
+		      unsigned long addr, u64 *pfns, unsigned long npages,
+		      unsigned int page_shift);
 #else /* IS_ENABLED(CONFIG_DRM_NOUVEAU_SVM) */
 static inline void nouveau_svm_init(struct nouveau_drm *drm) {}
 static inline void nouveau_svm_fini(struct nouveau_drm *drm) {}
--=20
2.20.1

