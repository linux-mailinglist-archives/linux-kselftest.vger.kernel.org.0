Return-Path: <linux-kselftest+bounces-17688-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 039599746D2
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 01:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B71D428832D
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 23:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9211C0DF8;
	Tue, 10 Sep 2024 23:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GX8MPKyN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788181C0DD7
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 23:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011919; cv=none; b=CLPP0EDBnyO5Oqvqaq4bOuV9LnczYpsGABcK33KO1TgZXXkJbCI74MiyArbsvl/z6a39xwvGyaEQwTTbpugzzfxDPEWoNbIDCsiXfIqdLjPEADQwEajp2Rh/WHqM5XEjBa5XOdIjTmeo3KhjF8SlBWuX5U9NPQ6fbT7kzAVjPas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011919; c=relaxed/simple;
	bh=YDXLNAYH07lT15zEUgoXIIGg0s3PEPkF7OA5Po/D0S0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QUuKVqdutiCuS6z+hoIpk1OsyEfux8xdD+vD1rRY5eOM/0h3RFgsbYopL3zJZ05EgZzkt5luYPahM0IZgBfdnT6cCXHSNV3TJxx/5HUG9HlqnDHvZ2tGBhkkqkBQuzyItNU/+OQaAOlEU/NH92NRnlPm25Aiwq9ca1kSDWI2svQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GX8MPKyN; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2058ba8562fso111409885ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 16:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726011917; x=1726616717; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dBcAwVvZIYzGXNkByOPNSzS/2ZaPoaCsQUMEIRBg/WU=;
        b=GX8MPKyNCX67aXI3adCgwuHVt5bcsPCVsBvDYfNAJsj22DIUAKopTmlyFVoCu2lwI1
         eQatPRVFraqqnf0qnvhtagXMO4knZdlNXbxbHcbHxbe+tbhexZVsIO8JewjP5C5wVhLa
         WbrMwUdDlJuarYOiAFftXsSFcu3INWF3qYA81ovHXFCfexJ1mZJcPai7SMKa++q1so7v
         paX8qJjqpj4aRM5mgnvwPR5AuDUIxguUM7SISup6nH4PsdCMSUBFHwNqKTKCRpP7EO4q
         xZgNXZAyT22xolrCNEVbwQOlj/kibPiymgRrpMBX+cRWxwCxLMp7NIo8xZYqUkKVdfY7
         mylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726011917; x=1726616717;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dBcAwVvZIYzGXNkByOPNSzS/2ZaPoaCsQUMEIRBg/WU=;
        b=Bx1Be9t6C0GB+pay72g93EDdfM4knJvex8vBESKTvvXfMPObIicC/8B2BNnb8o4Q7r
         EYERthEfoAI05yajpmgNC0K2r+NCKhxsBi2WV9XnBTH3vw1eL2DWWasnMDpueJBSEvo3
         khFEGRCuUSffvxNIs1LzclwMy4EUrtmDTMgEDoS4Lq6ZJEYNxNmw5amvyYtXdwsuL05C
         175iFPrEQJLutulJkSjAfrzs371Vz076YljYAcBe7OUe5tks+kFszaIN8RkzlGR1KQFm
         KNAsm3DX4B7f9E/czFUnAZm6+YN9wOlznx6w1KTqIy1/rHYX81fVgjAN+eGwnwj69dsP
         Il5w==
X-Forwarded-Encrypted: i=1; AJvYcCUgcKTXHpyuUc8uKRNtDnZD6TJfhUb5HAMc+ROZrmgwgKHB2rlhnnhH1WL4QVQvBlo+n2/L6scBiW1mtMOHOEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSeW6BoMfrxA2xq7uXo/0Pl8HnVHxHllqdf35PsAKdvRk+6sZ/
	RY13ZsZ2gWkJiQ0HFGR87vhnUVlf9CFn51S5NTbaGkDQ7Lo0u7DLJ9wHWCcj8vaddCGUuIYeI7S
	xYfHQE5hh8HJmenzqk27bQg==
X-Google-Smtp-Source: AGHT+IHPvqQuW1nzaRxrJX4GIRZi5NgMOC89C+YN+0vpncrauk1fada8rcGXAL5RiJtXK/Fd4loftkEuOb/GRSTx+A==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a17:902:e5c6:b0:205:799f:124f with
 SMTP id d9443c01a7336-2074c5f3b46mr1590105ad.5.1726011916743; Tue, 10 Sep
 2024 16:45:16 -0700 (PDT)
Date: Tue, 10 Sep 2024 23:43:56 +0000
In-Reply-To: <cover.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <c488244d78c74992ac1f07564617a4758951e596.1726009989.git.ackerleytng@google.com>
Subject: [RFC PATCH 25/39] KVM: guest_memfd: Split HugeTLB pages for
 guest_memfd use
From: Ackerley Tng <ackerleytng@google.com>
To: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk, 
	jgg@nvidia.com, peterx@redhat.com, david@redhat.com, rientjes@google.com, 
	fvdl@google.com, jthoughton@google.com, seanjc@google.com, 
	pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com, 
	jun.miao@intel.com, isaku.yamahata@intel.com, muchun.song@linux.dev, 
	mike.kravetz@oracle.com
Cc: erdemaktas@google.com, vannapurve@google.com, ackerleytng@google.com, 
	qperret@google.com, jhubbard@nvidia.com, willy@infradead.org, 
	shuah@kernel.org, brauner@kernel.org, bfoster@redhat.com, 
	kent.overstreet@linux.dev, pvorel@suse.cz, rppt@kernel.org, 
	richard.weiyang@gmail.com, anup@brainfault.org, haibo1.xu@intel.com, 
	ajones@ventanamicro.com, vkuznets@redhat.com, maciej.wieczor-retman@intel.com, 
	pgonda@google.com, oliver.upton@linux.dev, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-fsdevel@kvack.org
Content-Type: text/plain; charset="UTF-8"

From: Vishal Annapurve <vannapurve@google.com>

In this patch, newly allocated HugeTLB pages are split to 4K regular
pages before providing them to the requester (fallocate() or KVM).

The pages are then reconstructed/merged to HugeTLB pages before
the HugeTLB pages are returned to HugeTLB.

This is an intermediate step to build page splitting/merging
functionality before allowing guest_memfd files to be mmap()ed.

Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>

---
 virt/kvm/guest_memfd.c | 299 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 281 insertions(+), 18 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index eacbfdb950d1..8151df2c03e5 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -229,31 +229,206 @@ static int kvm_gmem_hugetlb_filemap_add_folio(struct address_space *mapping,
 	return 0;
 }
 
+struct kvm_gmem_split_stash {
+	struct {
+		unsigned long _flags_2;
+		unsigned long _head_2;
+
+		void *_hugetlb_subpool;
+		void *_hugetlb_cgroup;
+		void *_hugetlb_cgroup_rsvd;
+		void *_hugetlb_hwpoison;
+	};
+	void *hugetlb_private;
+};
+
+static int kvm_gmem_hugetlb_stash_metadata(struct folio *folio)
+{
+	struct kvm_gmem_split_stash *stash;
+
+	stash = kmalloc(sizeof(*stash), GFP_KERNEL);
+	if (!stash)
+		return -ENOMEM;
+
+	stash->_flags_2 = folio->_flags_2;
+	stash->_head_2 = folio->_head_2;
+	stash->_hugetlb_subpool = folio->_hugetlb_subpool;
+	stash->_hugetlb_cgroup = folio->_hugetlb_cgroup;
+	stash->_hugetlb_cgroup_rsvd = folio->_hugetlb_cgroup_rsvd;
+	stash->_hugetlb_hwpoison = folio->_hugetlb_hwpoison;
+	stash->hugetlb_private = folio_get_private(folio);
+
+	folio_change_private(folio, (void *)stash);
+
+	return 0;
+}
+
+static int kvm_gmem_hugetlb_unstash_metadata(struct folio *folio)
+{
+	struct kvm_gmem_split_stash *stash;
+
+	stash = folio_get_private(folio);
+
+	if (!stash)
+		return -EINVAL;
+
+	folio->_flags_2 = stash->_flags_2;
+	folio->_head_2 = stash->_head_2;
+	folio->_hugetlb_subpool = stash->_hugetlb_subpool;
+	folio->_hugetlb_cgroup = stash->_hugetlb_cgroup;
+	folio->_hugetlb_cgroup_rsvd = stash->_hugetlb_cgroup_rsvd;
+	folio->_hugetlb_hwpoison = stash->_hugetlb_hwpoison;
+	folio_change_private(folio, stash->hugetlb_private);
+
+	kfree(stash);
+
+	return 0;
+}
+
+/**
+ * Reconstruct a HugeTLB folio from a contiguous block of folios where the first
+ * of the contiguous folios is @folio.
+ *
+ * The size of the contiguous block is of huge_page_size(@h). All the folios in
+ * the block are checked to have a refcount of 1 before reconstruction. After
+ * reconstruction, the reconstructed folio has a refcount of 1.
+ *
+ * Return 0 on success and negative error otherwise.
+ */
+static int kvm_gmem_hugetlb_reconstruct_folio(struct hstate *h, struct folio *folio)
+{
+	int ret;
+
+	WARN_ON((folio->index & (huge_page_order(h) - 1)) != 0);
+
+	ret = kvm_gmem_hugetlb_unstash_metadata(folio);
+	if (ret)
+		return ret;
+
+	if (!prep_compound_gigantic_folio(folio, huge_page_order(h))) {
+		kvm_gmem_hugetlb_stash_metadata(folio);
+		return -ENOMEM;
+	}
+
+	__folio_set_hugetlb(folio);
+
+	folio_set_count(folio, 1);
+
+	hugetlb_vmemmap_optimize_folio(h, folio);
+
+	return 0;
+}
+
+/* Basically folio_set_order(folio, 1) without the checks. */
+static inline void kvm_gmem_folio_set_order(struct folio *folio, unsigned int order)
+{
+	folio->_flags_1 = (folio->_flags_1 & ~0xffUL) | order;
+#ifdef CONFIG_64BIT
+	folio->_folio_nr_pages = 1U << order;
+#endif
+}
+
+/**
+ * Split a HugeTLB @folio of size huge_page_size(@h).
+ *
+ * After splitting, each split folio has a refcount of 1. There are no checks on
+ * refcounts before splitting.
+ *
+ * Return 0 on success and negative error otherwise.
+ */
+static int kvm_gmem_hugetlb_split_folio(struct hstate *h, struct folio *folio)
+{
+	int ret;
+
+	ret = hugetlb_vmemmap_restore_folio(h, folio);
+	if (ret)
+		return ret;
+
+	ret = kvm_gmem_hugetlb_stash_metadata(folio);
+	if (ret) {
+		hugetlb_vmemmap_optimize_folio(h, folio);
+		return ret;
+	}
+
+	kvm_gmem_folio_set_order(folio, 0);
+
+	destroy_compound_gigantic_folio(folio, huge_page_order(h));
+	__folio_clear_hugetlb(folio);
+
+	/*
+	 * Remove the first folio from h->hugepage_activelist since it is no
+	 * longer a HugeTLB page. The other split pages should not be on any
+	 * lists.
+	 */
+	hugetlb_folio_list_del(folio);
+
+	return 0;
+}
+
 static struct folio *kvm_gmem_hugetlb_alloc_and_cache_folio(struct inode *inode,
 							    pgoff_t index)
 {
+	struct folio *allocated_hugetlb_folio;
+	pgoff_t hugetlb_first_subpage_index;
+	struct page *hugetlb_first_subpage;
 	struct kvm_gmem_hugetlb *hgmem;
-	struct folio *folio;
+	struct page *requested_page;
 	int ret;
+	int i;
 
 	hgmem = kvm_gmem_hgmem(inode);
-	folio = kvm_gmem_hugetlb_alloc_folio(hgmem->h, hgmem->spool);
-	if (IS_ERR(folio))
-		return folio;
+	allocated_hugetlb_folio = kvm_gmem_hugetlb_alloc_folio(hgmem->h, hgmem->spool);
+	if (IS_ERR(allocated_hugetlb_folio))
+		return allocated_hugetlb_folio;
+
+	requested_page = folio_file_page(allocated_hugetlb_folio, index);
+	hugetlb_first_subpage = folio_file_page(allocated_hugetlb_folio, 0);
+	hugetlb_first_subpage_index = index & (huge_page_mask(hgmem->h) >> PAGE_SHIFT);
 
-	/* TODO: Fix index here to be aligned to huge page size. */
-	ret = kvm_gmem_hugetlb_filemap_add_folio(
-		inode->i_mapping, folio, index, htlb_alloc_mask(hgmem->h));
+	ret = kvm_gmem_hugetlb_split_folio(hgmem->h, allocated_hugetlb_folio);
 	if (ret) {
-		folio_put(folio);
+		folio_put(allocated_hugetlb_folio);
 		return ERR_PTR(ret);
 	}
 
+	for (i = 0; i < pages_per_huge_page(hgmem->h); ++i) {
+		struct folio *folio = page_folio(nth_page(hugetlb_first_subpage, i));
+
+		ret = kvm_gmem_hugetlb_filemap_add_folio(inode->i_mapping,
+							 folio,
+							 hugetlb_first_subpage_index + i,
+							 htlb_alloc_mask(hgmem->h));
+		if (ret) {
+			/* TODO: handle cleanup properly. */
+			pr_err("Handle cleanup properly index=%lx, ret=%d\n",
+			       hugetlb_first_subpage_index + i, ret);
+			dump_page(nth_page(hugetlb_first_subpage, i), "check");
+			return ERR_PTR(ret);
+		}
+
+		/*
+		 * Skip unlocking for the requested index since
+		 * kvm_gmem_get_folio() returns a locked folio.
+		 *
+		 * Do folio_put() to drop the refcount that came with the folio,
+		 * from splitting the folio. Splitting the folio has a refcount
+		 * to be in line with hugetlb_alloc_folio(), which returns a
+		 * folio with refcount 1.
+		 *
+		 * Skip folio_put() for requested index since
+		 * kvm_gmem_get_folio() returns a folio with refcount 1.
+		 */
+		if (hugetlb_first_subpage_index + i != index) {
+			folio_unlock(folio);
+			folio_put(folio);
+		}
+	}
+
 	spin_lock(&inode->i_lock);
 	inode->i_blocks += blocks_per_huge_page(hgmem->h);
 	spin_unlock(&inode->i_lock);
 
-	return folio;
+	return page_folio(requested_page);
 }
 
 static struct folio *kvm_gmem_get_hugetlb_folio(struct inode *inode,
@@ -365,7 +540,9 @@ static inline void kvm_gmem_hugetlb_filemap_remove_folio(struct folio *folio)
 
 /**
  * Removes folios in range [@lstart, @lend) from page cache/filemap (@mapping),
- * returning the number of pages freed.
+ * returning the number of HugeTLB pages freed.
+ *
+ * @lend - @lstart must be a multiple of the HugeTLB page size.
  */
 static int kvm_gmem_hugetlb_filemap_remove_folios(struct address_space *mapping,
 						  struct hstate *h,
@@ -373,37 +550,69 @@ static int kvm_gmem_hugetlb_filemap_remove_folios(struct address_space *mapping,
 {
 	const pgoff_t end = lend >> PAGE_SHIFT;
 	pgoff_t next = lstart >> PAGE_SHIFT;
+	LIST_HEAD(folios_to_reconstruct);
 	struct folio_batch fbatch;
+	struct folio *folio, *tmp;
 	int num_freed = 0;
+	int i;
 
+	/*
+	 * TODO: Iterate over huge_page_size(h) blocks to avoid taking and
+	 * releasing hugetlb_fault_mutex_table[hash] lock so often. When
+	 * truncating, lstart and lend should be clipped to the size of this
+	 * guest_memfd file, otherwise there would be too many iterations.
+	 */
 	folio_batch_init(&fbatch);
 	while (filemap_get_folios(mapping, &next, end - 1, &fbatch)) {
-		int i;
 		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
 			struct folio *folio;
 			pgoff_t hindex;
 			u32 hash;
 
 			folio = fbatch.folios[i];
+
 			hindex = folio->index >> huge_page_order(h);
 			hash = hugetlb_fault_mutex_hash(mapping, hindex);
-
 			mutex_lock(&hugetlb_fault_mutex_table[hash]);
+
+			/*
+			 * Collect first pages of HugeTLB folios for
+			 * reconstruction later.
+			 */
+			if ((folio->index & ~(huge_page_mask(h) >> PAGE_SHIFT)) == 0)
+				list_add(&folio->lru, &folios_to_reconstruct);
+
+			/*
+			 * Before removing from filemap, take a reference so
+			 * sub-folios don't get freed. Don't free the sub-folios
+			 * until after reconstruction.
+			 */
+			folio_get(folio);
+
 			kvm_gmem_hugetlb_filemap_remove_folio(folio);
-			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 
-			num_freed++;
+			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		}
 		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 
+	list_for_each_entry_safe(folio, tmp, &folios_to_reconstruct, lru) {
+		kvm_gmem_hugetlb_reconstruct_folio(h, folio);
+		hugetlb_folio_list_move(folio, &h->hugepage_activelist);
+
+		folio_put(folio);
+		num_freed++;
+	}
+
 	return num_freed;
 }
 
 /**
  * Removes folios in range [@lstart, @lend) from page cache of inode, updates
  * inode metadata and hugetlb reservations.
+ *
+ * @lend - @lstart must be a multiple of the HugeTLB page size.
  */
 static void kvm_gmem_hugetlb_truncate_folios_range(struct inode *inode,
 						   loff_t lstart, loff_t lend)
@@ -427,6 +636,56 @@ static void kvm_gmem_hugetlb_truncate_folios_range(struct inode *inode,
 	spin_unlock(&inode->i_lock);
 }
 
+/**
+ * Zeroes offsets [@start, @end) in a folio from @mapping.
+ *
+ * [@start, @end) must be within the same folio.
+ */
+static void kvm_gmem_zero_partial_page(
+	struct address_space *mapping, loff_t start, loff_t end)
+{
+	struct folio *folio;
+	pgoff_t idx = start >> PAGE_SHIFT;
+
+	folio = filemap_lock_folio(mapping, idx);
+	if (IS_ERR(folio))
+		return;
+
+	start = offset_in_folio(folio, start);
+	end = offset_in_folio(folio, end);
+	if (!end)
+		end = folio_size(folio);
+
+	folio_zero_segment(folio, (size_t)start, (size_t)end);
+	folio_unlock(folio);
+	folio_put(folio);
+}
+
+/**
+ * Zeroes all pages in range [@start, @end) in @mapping.
+ *
+ * hugetlb_zero_partial_page() would work if this had been a full page, but is
+ * not suitable since the pages have been split.
+ *
+ * truncate_inode_pages_range() isn't the right function because it removes
+ * pages from the page cache; this function only zeroes the pages.
+ */
+static void kvm_gmem_hugetlb_zero_split_pages(struct address_space *mapping,
+					      loff_t start, loff_t end)
+{
+	loff_t aligned_start;
+	loff_t index;
+
+	aligned_start = round_up(start, PAGE_SIZE);
+
+	kvm_gmem_zero_partial_page(mapping, start, min(aligned_start, end));
+
+	for (index = aligned_start; index < end; index += PAGE_SIZE) {
+		kvm_gmem_zero_partial_page(mapping, index,
+					   min((loff_t)(index + PAGE_SIZE), end));
+	}
+}
+
 static void kvm_gmem_hugetlb_truncate_range(struct inode *inode, loff_t lstart,
 					    loff_t lend)
 {
@@ -442,8 +701,8 @@ static void kvm_gmem_hugetlb_truncate_range(struct inode *inode, loff_t lstart,
 	full_hpage_end = round_down(lend, hsize);
 
 	if (lstart < full_hpage_start) {
-		hugetlb_zero_partial_page(h, inode->i_mapping, lstart,
-					  full_hpage_start);
+		kvm_gmem_hugetlb_zero_split_pages(inode->i_mapping, lstart,
+						  full_hpage_start);
 	}
 
 	if (full_hpage_end > full_hpage_start) {
@@ -452,8 +711,8 @@ static void kvm_gmem_hugetlb_truncate_range(struct inode *inode, loff_t lstart,
 	}
 
 	if (lend > full_hpage_end) {
-		hugetlb_zero_partial_page(h, inode->i_mapping, full_hpage_end,
-					  lend);
+		kvm_gmem_hugetlb_zero_split_pages(inode->i_mapping, full_hpage_end,
+						  lend);
 	}
 }
 
@@ -1060,6 +1319,10 @@ __kvm_gmem_get_pfn(struct file *file, struct kvm_memory_slot *slot,
 
 	if (folio_test_hwpoison(folio)) {
 		folio_unlock(folio);
+		/*
+		 * TODO: this folio may be part of a HugeTLB folio. Perhaps
+		 * reconstruct and then free page?
+		 */
 		folio_put(folio);
 		return ERR_PTR(-EHWPOISON);
 	}
-- 
2.46.0.598.g6f2099f65c-goog


