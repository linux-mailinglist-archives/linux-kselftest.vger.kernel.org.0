Return-Path: <linux-kselftest+bounces-17702-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD969746FB
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 01:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B991286241
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 23:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3441A1C578D;
	Tue, 10 Sep 2024 23:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bFaXTy0k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7C31B150A
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 23:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011944; cv=none; b=qSxvasjmln44DFFaSmKy70/1HV8QpFGz0uAsJjIY0kuFvbrl19OtbbHbTCzd8tBWaH1wisvvBUXtDxuDPl9tgRStXcJvwbrq7KxSpb/OGxUlvoCSviiY7UkYDhEf2XdqjVUsZHpKrE+Zi0sGTcEXo7JcIpaoJ62KSHb7wH4OMPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011944; c=relaxed/simple;
	bh=qlWybXpHX73W0c+WoyiK3ZIrz+Xb8gYUp5+RSabhcTs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C+TzIlgJo5iSRg+HvewTMR2HLYjzMukOUbb/WvtddQnWirgoe/FCFh0SfXuZ6OqdqgoeaUMkXcVG2OkZT5QaQZ9gLZZhCiI5pEageZN4Rg210LYxyjH/3s2YYGN9P22hXEC5D0+DwJxnOX35vzeY+kZwUd82sbMNUfpwbLeyogk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bFaXTy0k; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d9e31e66eeso218875967b3.1
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 16:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726011941; x=1726616741; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=plYJYQpQfTnkaDlyMrD3/y2PoxU/BsueDgrxr9NfLVw=;
        b=bFaXTy0kxx6flmBZ1ucQVp4NqXXsQJaCVMo4B0NxBxjiZtG5aZCemOerGrYlntVP06
         rLjIjkCyf84g3cK8BODligtxBBVe2H3bmvQiOnOqsyni3LMB9WSt9UGuI/NLzOyHsi9r
         NqEu/teJdgNOFyJZW4Qv8dOubj7zn1WfAbbYCY0S2qK09dw6OWA2156jiZQo0XL5Y1d+
         EdcGovMrAXg8vR+whNMR+6Q5ma09jpedQ+2vLQKGm35B3OlNgyWrnBKYImd8fxXnaYTD
         G9d8KrR7I3qnoLY/4TIxEFLWNZkRLL/hT1YncKC/ATtwkXruGS9IGNc+BSufCMGipX4Z
         WhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726011941; x=1726616741;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=plYJYQpQfTnkaDlyMrD3/y2PoxU/BsueDgrxr9NfLVw=;
        b=jhU7z4sBemcDOHnfM9z43vA+IN+sIL+hcuRTaYNcV/vuUJmYUAQA9SSNXx2/pNZHl4
         n5Iy04o766MuixXvFMZW7vek04dOgSkJyV6jsarca7BnRdqFRH9fXxBWytTWD2unHbyJ
         Fv871sP5x3T68wBTFxsgV7VN1buXa4lj8QWupI70ZR5XPPe55BchsZ29skd+JPEJY06b
         3vRLwxzahz7LVCUKq7NJjUxRrk2OVwT0Wrkougxri3HZM1fxUwcOe7INQa82xVDciBkQ
         tbGufWYFKJ5lDxPGyRtLcqkjNsxqfXlBfXkSGGiD4laIpFXofD78FhiYZ8G052BHRZtS
         XPZg==
X-Forwarded-Encrypted: i=1; AJvYcCXmldgHjXbBXWo8LK2Z6CMC/BwS9k/MIi5Pynz4JqVr4L6ANGpzKEFgjygru9U3MFZeyKVhDNGG4W81Kp4/VI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsSq9vTVLs2azMJNrQ/rOIuCcVW8dHOCWK27SU3r2R/vCnHuKR
	fAp2EqPbfaypNwugwCHERE1oSEZLeCepnuIUd7tRnJtIPW8u4DZCUfw0zTzdbiC1L/5O/SFqgvS
	XsehmGLRXTmWfKe1RKe6UxA==
X-Google-Smtp-Source: AGHT+IF4JIC3xXL5PcaZmTn+2qPPsXwRjGrvNWXeluzH7gFrLjYhLnR02nFhF2UYLVydi+C+3P7U7SKVduv8ybLF7g==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a05:690c:6703:b0:6d5:df94:b7f2 with
 SMTP id 00721157ae682-6db45163299mr10464137b3.5.1726011940637; Tue, 10 Sep
 2024 16:45:40 -0700 (PDT)
Date: Tue, 10 Sep 2024 23:44:10 +0000
In-Reply-To: <cover.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <38723c5d5e9b530e52f28b9f9f4a6d862ed69bcd.1726009989.git.ackerleytng@google.com>
Subject: [RFC PATCH 39/39] KVM: guest_memfd: Dynamically split/reconstruct
 HugeTLB page
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

The faultability of a page is used to determine whether to split or
reconstruct a page.

If there is any page in a folio that is faultable, split the folio. If
all pages in a folio are not faultable, reconstruct the folio.

On truncation, always reconstruct and free regardless of
faultability (as long as a HugeTLB page's worth of pages is
truncated).

Co-developed-by: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>

---
 virt/kvm/guest_memfd.c | 678 +++++++++++++++++++++++++++--------------
 1 file changed, 456 insertions(+), 222 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index fb292e542381..0afc111099c0 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -99,6 +99,23 @@ static bool kvm_gmem_is_faultable(struct inode *inode, pgoff_t index)
 	return xa_to_value(xa_load(faultability, index)) == KVM_GMEM_FAULTABILITY_VALUE;
 }
 
+/**
+ * Return true if any of the @nr_pages beginning at @index is allowed to be
+ * faulted in.
+ */
+static bool kvm_gmem_is_any_faultable(struct inode *inode, pgoff_t index,
+				      int nr_pages)
+{
+	pgoff_t i;
+
+	for (i = index; i < index + nr_pages; ++i) {
+		if (kvm_gmem_is_faultable(inode, i))
+		    return true;
+	}
+
+	return false;
+}
+
 /**
  * folio_file_pfn - like folio_file_page, but return a pfn.
  * @folio: The folio which contains this index.
@@ -312,6 +329,40 @@ static int kvm_gmem_hugetlb_filemap_add_folio(struct address_space *mapping,
 	return 0;
 }
 
+static inline void kvm_gmem_hugetlb_filemap_remove_folio(struct folio *folio)
+{
+	folio_lock(folio);
+
+	folio_clear_dirty(folio);
+	folio_clear_uptodate(folio);
+	filemap_remove_folio(folio);
+
+	folio_unlock(folio);
+}
+
+/*
+ * Locks a block of nr_pages (1 << huge_page_order(h)) pages within @mapping
+ * beginning at @index. Take either this or filemap_invalidate_lock() whenever
+ * the filemap is accessed.
+ */
+static u32 hugetlb_fault_mutex_lock(struct address_space *mapping, pgoff_t index)
+{
+	pgoff_t hindex;
+	u32 hash;
+
+	hindex = index >> huge_page_order(kvm_gmem_hgmem(mapping->host)->h);
+	hash = hugetlb_fault_mutex_hash(mapping, hindex);
+
+	mutex_lock(&hugetlb_fault_mutex_table[hash]);
+
+	return hash;
+}
+
+static void hugetlb_fault_mutex_unlock(u32 hash)
+{
+	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+}
+
 struct kvm_gmem_split_stash {
 	struct {
 		unsigned long _flags_2;
@@ -394,15 +445,136 @@ static int kvm_gmem_hugetlb_reconstruct_folio(struct hstate *h, struct folio *fo
 	}
 
 	__folio_set_hugetlb(folio);
-
-	folio_set_count(folio, 1);
+	hugetlb_folio_list_add(folio, &h->hugepage_activelist);
 
 	hugetlb_vmemmap_optimize_folio(h, folio);
 
+	folio_set_count(folio, 1);
+
 	return 0;
 }
 
-/* Basically folio_set_order(folio, 1) without the checks. */
+/**
+ * Reconstruct a HugeTLB folio out of folio_nr_pages(@first_folio) pages. Will
+ * clean up subfolios from filemap and add back the reconstructed folio. Folios
+ * to be reconstructed must not be locked, and reconstructed folio will not be
+ * locked. Return 0 on success or negative error otherwise.
+ *
+ * hugetlb_fault_mutex_lock() has to be held when calling this function.
+ *
+ * Expects that before this call, the filemap's refcounts are the only refcounts
+ * for the folios in the filemap. After this function returns, the filemap's
+ * refcount will be the only refcount on the reconstructed folio.
+ */
+static int kvm_gmem_reconstruct_folio_in_filemap(struct hstate *h,
+						 struct folio *first_folio)
+{
+	struct address_space *mapping;
+	struct folio_batch fbatch;
+	unsigned long end;
+	pgoff_t index;
+	pgoff_t next;
+	int ret;
+	int i;
+
+	if (folio_order(first_folio) == huge_page_order(h))
+		return 0;
+
+	index = first_folio->index;
+	mapping = first_folio->mapping;
+
+	next = index;
+	end = index + (1UL << huge_page_order(h));
+	folio_batch_init(&fbatch);
+	while (filemap_get_folios(mapping, &next, end - 1, &fbatch)) {
+		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
+			struct folio *folio;
+
+			folio = fbatch.folios[i];
+
+			/*
+			 * Before removing from filemap, take a reference so
+			 * sub-folios don't get freed when removing from
+			 * filemap.
+			 */
+			folio_get(folio);
+
+			kvm_gmem_hugetlb_filemap_remove_folio(folio);
+		}
+		folio_batch_release(&fbatch);
+	}
+
+	ret = kvm_gmem_hugetlb_reconstruct_folio(h, first_folio);
+	if (ret) {
+		/* TODO: handle cleanup properly. */
+		WARN_ON(ret);
+		return ret;
+	}
+
+	kvm_gmem_hugetlb_filemap_add_folio(mapping, first_folio, index,
+					   htlb_alloc_mask(h));
+
+	folio_unlock(first_folio);
+	folio_put(first_folio);
+
+	return ret;
+}
+
+/**
+ * Reconstruct any HugeTLB folios in range [@start, @end), if all the subfolios
+ * are not faultable. Return 0 on success or negative error otherwise.
+ *
+ * Will skip any folios that are already reconstructed.
+ */
+static int kvm_gmem_try_reconstruct_folios_range(struct inode *inode,
+						 pgoff_t start, pgoff_t end)
+{
+	unsigned int nr_pages;
+	pgoff_t aligned_start;
+	pgoff_t aligned_end;
+	struct hstate *h;
+	pgoff_t index;
+	int ret;
+
+	if (!is_kvm_gmem_hugetlb(inode))
+		return 0;
+
+	h = kvm_gmem_hgmem(inode)->h;
+	nr_pages = 1UL << huge_page_order(h);
+
+	aligned_start = round_up(start, nr_pages);
+	aligned_end = round_down(end, nr_pages);
+
+	ret = 0;
+	for (index = aligned_start; !ret && index < aligned_end; index += nr_pages) {
+		struct folio *folio;
+		u32 hash;
+
+		hash = hugetlb_fault_mutex_lock(inode->i_mapping, index);
+
+		folio = filemap_get_folio(inode->i_mapping, index);
+		if (!IS_ERR(folio)) {
+			/*
+			 * Drop refcount because reconstruction expects an equal number
+			 * of refcounts for all subfolios - just keep the refcount taken
+			 * by the filemap.
+			 */
+			folio_put(folio);
+
+			/* Merge only when the entire block of nr_pages is not faultable. */
+			if (!kvm_gmem_is_any_faultable(inode, index, nr_pages)) {
+				ret = kvm_gmem_reconstruct_folio_in_filemap(h, folio);
+				WARN_ON(ret);
+			}
+		}
+
+		hugetlb_fault_mutex_unlock(hash);
+	}
+
+	return ret;
+}
+
+/* Basically folio_set_order() without the checks. */
 static inline void kvm_gmem_folio_set_order(struct folio *folio, unsigned int order)
 {
 	folio->_flags_1 = (folio->_flags_1 & ~0xffUL) | order;
@@ -414,8 +586,8 @@ static inline void kvm_gmem_folio_set_order(struct folio *folio, unsigned int or
 /**
  * Split a HugeTLB @folio of size huge_page_size(@h).
  *
- * After splitting, each split folio has a refcount of 1. There are no checks on
- * refcounts before splitting.
+ * Folio must have refcount of 1 when this function is called. After splitting,
+ * each split folio has a refcount of 1.
  *
  * Return 0 on success and negative error otherwise.
  */
@@ -423,14 +595,18 @@ static int kvm_gmem_hugetlb_split_folio(struct hstate *h, struct folio *folio)
 {
 	int ret;
 
+	VM_WARN_ON_ONCE_FOLIO(folio_ref_count(folio) != 1, folio);
+
+	folio_set_count(folio, 0);
+
 	ret = hugetlb_vmemmap_restore_folio(h, folio);
 	if (ret)
-		return ret;
+		goto out;
 
 	ret = kvm_gmem_hugetlb_stash_metadata(folio);
 	if (ret) {
 		hugetlb_vmemmap_optimize_folio(h, folio);
-		return ret;
+		goto out;
 	}
 
 	kvm_gmem_folio_set_order(folio, 0);
@@ -439,109 +615,183 @@ static int kvm_gmem_hugetlb_split_folio(struct hstate *h, struct folio *folio)
 	__folio_clear_hugetlb(folio);
 
 	/*
-	 * Remove the first folio from h->hugepage_activelist since it is no
+	 * Remove the original folio from h->hugepage_activelist since it is no
 	 * longer a HugeTLB page. The other split pages should not be on any
 	 * lists.
 	 */
 	hugetlb_folio_list_del(folio);
 
-	return 0;
+	ret = 0;
+out:
+	folio_set_count(folio, 1);
+	return ret;
 }
 
-static struct folio *kvm_gmem_hugetlb_alloc_and_cache_folio(struct inode *inode,
-							    pgoff_t index)
+/**
+ * Split a HugeTLB folio into folio_nr_pages(@folio) pages. Will clean up folio
+ * from filemap and add back the split folios. @folio must not be locked, and
+ * all split folios will not be locked. Return 0 on success or negative error
+ * otherwise.
+ *
+ * hugetlb_fault_mutex_lock() has to be held when calling this function.
+ *
+ * Expects that before this call, the filemap's refcounts are the only refcounts
+ * for the folio. After this function returns, the filemap's refcounts will be
+ * the only refcounts on the split folios.
+ */
+static int kvm_gmem_split_folio_in_filemap(struct hstate *h, struct folio *folio)
 {
-	struct folio *allocated_hugetlb_folio;
-	pgoff_t hugetlb_first_subpage_index;
-	struct page *hugetlb_first_subpage;
-	struct kvm_gmem_hugetlb *hgmem;
-	struct page *requested_page;
+	struct address_space *mapping;
+	struct page *first_subpage;
+	pgoff_t index;
 	int ret;
 	int i;
 
-	hgmem = kvm_gmem_hgmem(inode);
-	allocated_hugetlb_folio = kvm_gmem_hugetlb_alloc_folio(hgmem->h, hgmem->spool);
-	if (IS_ERR(allocated_hugetlb_folio))
-		return allocated_hugetlb_folio;
+	if (folio_order(folio) == 0)
+		return 0;
 
-	requested_page = folio_file_page(allocated_hugetlb_folio, index);
-	hugetlb_first_subpage = folio_file_page(allocated_hugetlb_folio, 0);
-	hugetlb_first_subpage_index = index & (huge_page_mask(hgmem->h) >> PAGE_SHIFT);
+	index = folio->index;
+	mapping = folio->mapping;
 
-	ret = kvm_gmem_hugetlb_split_folio(hgmem->h, allocated_hugetlb_folio);
+	first_subpage = folio_page(folio, 0);
+
+	/*
+	 * Take reference so that folio will not be released when removed from
+	 * filemap.
+	 */
+	folio_get(folio);
+
+	kvm_gmem_hugetlb_filemap_remove_folio(folio);
+
+	ret = kvm_gmem_hugetlb_split_folio(h, folio);
 	if (ret) {
-		folio_put(allocated_hugetlb_folio);
-		return ERR_PTR(ret);
+		WARN_ON(ret);
+		kvm_gmem_hugetlb_filemap_add_folio(mapping, folio, index,
+						   htlb_alloc_mask(h));
+		folio_put(folio);
+		return ret;
 	}
 
-	for (i = 0; i < pages_per_huge_page(hgmem->h); ++i) {
-		struct folio *folio = page_folio(nth_page(hugetlb_first_subpage, i));
+	for (i = 0; i < pages_per_huge_page(h); ++i) {
+		struct folio *folio = page_folio(nth_page(first_subpage, i));
 
-		ret = kvm_gmem_hugetlb_filemap_add_folio(inode->i_mapping,
-							 folio,
-							 hugetlb_first_subpage_index + i,
-							 htlb_alloc_mask(hgmem->h));
+		ret = kvm_gmem_hugetlb_filemap_add_folio(mapping, folio,
+							 index + i,
+							 htlb_alloc_mask(h));
 		if (ret) {
 			/* TODO: handle cleanup properly. */
-			pr_err("Handle cleanup properly index=%lx, ret=%d\n",
-			       hugetlb_first_subpage_index + i, ret);
-			dump_page(nth_page(hugetlb_first_subpage, i), "check");
-			return ERR_PTR(ret);
+			WARN_ON(ret);
+			return ret;
 		}
 
+		folio_unlock(folio);
+
 		/*
-		 * Skip unlocking for the requested index since
-		 * kvm_gmem_get_folio() returns a locked folio.
-		 *
-		 * Do folio_put() to drop the refcount that came with the folio,
-		 * from splitting the folio. Splitting the folio has a refcount
-		 * to be in line with hugetlb_alloc_folio(), which returns a
-		 * folio with refcount 1.
-		 *
-		 * Skip folio_put() for requested index since
-		 * kvm_gmem_get_folio() returns a folio with refcount 1.
+		 * Drop reference so that the only remaining reference is the
+		 * one held by the filemap.
 		 */
-		if (hugetlb_first_subpage_index + i != index) {
-			folio_unlock(folio);
-			folio_put(folio);
-		}
+		folio_put(folio);
 	}
 
+	return ret;
+}
+
+/*
+ * Allocates and then caches a folio in the filemap. Returns a folio with
+ * refcount of 2: 1 after allocation, and 1 taken by the filemap.
+ */
+static struct folio *kvm_gmem_hugetlb_alloc_and_cache_folio(struct inode *inode,
+							    pgoff_t index)
+{
+	struct kvm_gmem_hugetlb *hgmem;
+	pgoff_t aligned_index;
+	struct folio *folio;
+	int nr_pages;
+	int ret;
+
+	hgmem = kvm_gmem_hgmem(inode);
+	folio = kvm_gmem_hugetlb_alloc_folio(hgmem->h, hgmem->spool);
+	if (IS_ERR(folio))
+		return folio;
+
+	nr_pages = 1UL << huge_page_order(hgmem->h);
+	aligned_index = round_down(index, nr_pages);
+
+	ret = kvm_gmem_hugetlb_filemap_add_folio(inode->i_mapping, folio,
+						 aligned_index,
+						 htlb_alloc_mask(hgmem->h));
+	WARN_ON(ret);
+
 	spin_lock(&inode->i_lock);
 	inode->i_blocks += blocks_per_huge_page(hgmem->h);
 	spin_unlock(&inode->i_lock);
 
-	return page_folio(requested_page);
+	return folio;
+}
+
+/**
+ * Split @folio if any of the subfolios are faultable. Returns the split
+ * (locked, refcount=2) folio at @index.
+ *
+ * Expects a locked folio with 1 refcount in addition to filemap's refcounts.
+ *
+ * After splitting, the subfolios in the filemap will be unlocked and have
+ * refcount 1 (other than the returned folio, which will be locked and have
+ * refcount 2).
+ */
+static struct folio *kvm_gmem_maybe_split_folio(struct folio *folio, pgoff_t index)
+{
+	pgoff_t aligned_index;
+	struct inode *inode;
+	struct hstate *h;
+	int nr_pages;
+	int ret;
+
+	inode = folio->mapping->host;
+	h = kvm_gmem_hgmem(inode)->h;
+	nr_pages = 1UL << huge_page_order(h);
+	aligned_index = round_down(index, nr_pages);
+
+	if (!kvm_gmem_is_any_faultable(inode, aligned_index, nr_pages))
+		return folio;
+
+	/* Drop lock and refcount in preparation for splitting. */
+	folio_unlock(folio);
+	folio_put(folio);
+
+	ret = kvm_gmem_split_folio_in_filemap(h, folio);
+	if (ret) {
+		kvm_gmem_hugetlb_filemap_remove_folio(folio);
+		return ERR_PTR(ret);
+	}
+
+	/*
+	 * At this point, the filemap has the only reference on the folio. Take
+	 * lock and refcount on folio to align with kvm_gmem_get_folio().
+	 */
+	return filemap_lock_folio(inode->i_mapping, index);
 }
 
 static struct folio *kvm_gmem_get_hugetlb_folio(struct inode *inode,
 						pgoff_t index)
 {
-	struct address_space *mapping;
 	struct folio *folio;
-	struct hstate *h;
-	pgoff_t hindex;
 	u32 hash;
 
-	h = kvm_gmem_hgmem(inode)->h;
-	hindex = index >> huge_page_order(h);
-	mapping = inode->i_mapping;
-
-	/* To lock, we calculate the hash using the hindex and not index. */
-	hash = hugetlb_fault_mutex_hash(mapping, hindex);
-	mutex_lock(&hugetlb_fault_mutex_table[hash]);
+	hash = hugetlb_fault_mutex_lock(inode->i_mapping, index);
 
 	/*
-	 * The filemap is indexed with index and not hindex. Taking lock on
-	 * folio to align with kvm_gmem_get_regular_folio()
+	 * The filemap is indexed with index and not hindex. Take lock on folio
+	 * to align with kvm_gmem_get_regular_folio()
 	 */
-	folio = filemap_lock_folio(mapping, index);
+	folio = filemap_lock_folio(inode->i_mapping, index);
+	if (IS_ERR(folio))
+		folio = kvm_gmem_hugetlb_alloc_and_cache_folio(inode, index);
+
 	if (!IS_ERR(folio))
-		goto out;
+		folio = kvm_gmem_maybe_split_folio(folio, index);
 
-	folio = kvm_gmem_hugetlb_alloc_and_cache_folio(inode, index);
-out:
-	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+	hugetlb_fault_mutex_unlock(hash);
 
 	return folio;
 }
@@ -610,17 +860,6 @@ static void kvm_gmem_invalidate_end(struct kvm_gmem *gmem, pgoff_t start,
 	}
 }
 
-static inline void kvm_gmem_hugetlb_filemap_remove_folio(struct folio *folio)
-{
-	folio_lock(folio);
-
-	folio_clear_dirty(folio);
-	folio_clear_uptodate(folio);
-	filemap_remove_folio(folio);
-
-	folio_unlock(folio);
-}
-
 /**
  * Removes folios in range [@lstart, @lend) from page cache/filemap (@mapping),
  * returning the number of HugeTLB pages freed.
@@ -631,61 +870,30 @@ static int kvm_gmem_hugetlb_filemap_remove_folios(struct address_space *mapping,
 						  struct hstate *h,
 						  loff_t lstart, loff_t lend)
 {
-	const pgoff_t end = lend >> PAGE_SHIFT;
-	pgoff_t next = lstart >> PAGE_SHIFT;
-	LIST_HEAD(folios_to_reconstruct);
-	struct folio_batch fbatch;
-	struct folio *folio, *tmp;
-	int num_freed = 0;
-	int i;
-
-	/*
-	 * TODO: Iterate over huge_page_size(h) blocks to avoid taking and
-	 * releasing hugetlb_fault_mutex_table[hash] lock so often. When
-	 * truncating, lstart and lend should be clipped to the size of this
-	 * guest_memfd file, otherwise there would be too many iterations.
-	 */
-	folio_batch_init(&fbatch);
-	while (filemap_get_folios(mapping, &next, end - 1, &fbatch)) {
-		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
-			struct folio *folio;
-			pgoff_t hindex;
-			u32 hash;
-
-			folio = fbatch.folios[i];
+	loff_t offset;
+	int num_freed;
 
-			hindex = folio->index >> huge_page_order(h);
-			hash = hugetlb_fault_mutex_hash(mapping, hindex);
-			mutex_lock(&hugetlb_fault_mutex_table[hash]);
+	num_freed = 0;
+	for (offset = lstart; offset < lend; offset += huge_page_size(h)) {
+		struct folio *folio;
+		pgoff_t index;
+		u32 hash;
 
-			/*
-			 * Collect first pages of HugeTLB folios for
-			 * reconstruction later.
-			 */
-			if ((folio->index & ~(huge_page_mask(h) >> PAGE_SHIFT)) == 0)
-				list_add(&folio->lru, &folios_to_reconstruct);
+		index = offset >> PAGE_SHIFT;
+		hash = hugetlb_fault_mutex_lock(mapping, index);
 
-			/*
-			 * Before removing from filemap, take a reference so
-			 * sub-folios don't get freed. Don't free the sub-folios
-			 * until after reconstruction.
-			 */
-			folio_get(folio);
+		folio = filemap_get_folio(mapping, index);
+		if (!IS_ERR(folio)) {
+			/* Drop refcount so that filemap holds only reference. */
+			folio_put(folio);
 
+			kvm_gmem_reconstruct_folio_in_filemap(h, folio);
 			kvm_gmem_hugetlb_filemap_remove_folio(folio);
 
-			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+			num_freed++;
 		}
-		folio_batch_release(&fbatch);
-		cond_resched();
-	}
-
-	list_for_each_entry_safe(folio, tmp, &folios_to_reconstruct, lru) {
-		kvm_gmem_hugetlb_reconstruct_folio(h, folio);
-		hugetlb_folio_list_move(folio, &h->hugepage_activelist);
 
-		folio_put(folio);
-		num_freed++;
+		hugetlb_fault_mutex_unlock(hash);
 	}
 
 	return num_freed;
@@ -705,6 +913,10 @@ static void kvm_gmem_hugetlb_truncate_folios_range(struct inode *inode,
 	int gbl_reserve;
 	int num_freed;
 
+	/* No point truncating more than inode size. */
+	lstart = min(lstart, inode->i_size);
+	lend = min(lend, inode->i_size);
+
 	hgmem = kvm_gmem_hgmem(inode);
 	h = hgmem->h;
 
@@ -1042,13 +1254,27 @@ static vm_fault_t kvm_gmem_fault(struct vm_fault *vmf)
 	bool is_prepared;
 
 	inode = file_inode(vmf->vma->vm_file);
-	if (!kvm_gmem_is_faultable(inode, vmf->pgoff))
+
+	/*
+	 * Use filemap_invalidate_lock_shared() to make sure
+	 * kvm_gmem_get_folio() doesn't race with faultability updates.
+	 */
+	filemap_invalidate_lock_shared(inode->i_mapping);
+
+	if (!kvm_gmem_is_faultable(inode, vmf->pgoff)) {
+		filemap_invalidate_unlock_shared(inode->i_mapping);
 		return VM_FAULT_SIGBUS;
+	}
 
 	folio = kvm_gmem_get_folio(inode, vmf->pgoff);
+
+	filemap_invalidate_unlock_shared(inode->i_mapping);
+
 	if (!folio)
 		return VM_FAULT_SIGBUS;
 
+	WARN(folio_test_hugetlb(folio), "should not be faulting in hugetlb folio=%p\n", folio);
+
 	is_prepared = folio_test_uptodate(folio);
 	if (!is_prepared) {
 		unsigned long nr_pages;
@@ -1731,8 +1957,6 @@ static bool kvm_gmem_no_mappings_range(struct inode *inode, pgoff_t start, pgoff
 	pgoff_t index;
 	bool checked_indices_unmapped;
 
-	filemap_invalidate_lock_shared(inode->i_mapping);
-
 	/* TODO: replace iteration with filemap_get_folios() for efficiency. */
 	checked_indices_unmapped = true;
 	for (index = start; checked_indices_unmapped && index < end;) {
@@ -1754,98 +1978,130 @@ static bool kvm_gmem_no_mappings_range(struct inode *inode, pgoff_t start, pgoff
 		folio_put(folio);
 	}
 
-	filemap_invalidate_unlock_shared(inode->i_mapping);
 	return checked_indices_unmapped;
 }
 
 /**
- * Returns true if pages in range [@start, @end) in memslot @slot have no
- * userspace mappings.
+ * Split any HugeTLB folios in range [@start, @end), if any of the offsets in
+ * the folio are faultable. Return 0 on success or negative error otherwise.
+ *
+ * Will skip any folios that are already split.
  */
-static bool kvm_gmem_no_mappings_slot(struct kvm_memory_slot *slot,
-				      gfn_t start, gfn_t end)
+static int kvm_gmem_try_split_folios_range(struct inode *inode,
+					   pgoff_t start, pgoff_t end)
 {
-	pgoff_t offset_start;
-	pgoff_t offset_end;
-	struct file *file;
-	bool ret;
-
-	offset_start = start - slot->base_gfn + slot->gmem.pgoff;
-	offset_end = end - slot->base_gfn + slot->gmem.pgoff;
-
-	file = kvm_gmem_get_file(slot);
-	if (!file)
-		return false;
-
-	ret = kvm_gmem_no_mappings_range(file_inode(file), offset_start, offset_end);
+	unsigned int nr_pages;
+	pgoff_t aligned_start;
+	pgoff_t aligned_end;
+	struct hstate *h;
+	pgoff_t index;
+	int ret;
 
-	fput(file);
+	if (!is_kvm_gmem_hugetlb(inode))
+		return 0;
 
-	return ret;
-}
+	h = kvm_gmem_hgmem(inode)->h;
+	nr_pages = 1UL << huge_page_order(h);
 
-/**
- * Returns true if pages in range [@start, @end) have no host userspace mappings.
- */
-static bool kvm_gmem_no_mappings(struct kvm *kvm, gfn_t start, gfn_t end)
-{
-	int i;
+	aligned_start = round_down(start, nr_pages);
+	aligned_end = round_up(end, nr_pages);
 
-	lockdep_assert_held(&kvm->slots_lock);
+	ret = 0;
+	for (index = aligned_start; !ret && index < aligned_end; index += nr_pages) {
+		struct folio *folio;
+		u32 hash;
 
-	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
-		struct kvm_memslot_iter iter;
-		struct kvm_memslots *slots;
+		hash = hugetlb_fault_mutex_lock(inode->i_mapping, index);
 
-		slots = __kvm_memslots(kvm, i);
-		kvm_for_each_memslot_in_gfn_range(&iter, slots, start, end) {
-			struct kvm_memory_slot *slot;
-			gfn_t gfn_start;
-			gfn_t gfn_end;
-
-			slot = iter.slot;
-			gfn_start = max(start, slot->base_gfn);
-			gfn_end = min(end, slot->base_gfn + slot->npages);
+		folio = filemap_get_folio(inode->i_mapping, index);
+		if (!IS_ERR(folio)) {
+			/*
+			 * Drop refcount so that the only references held are refcounts
+			 * from the filemap.
+			 */
+			folio_put(folio);
 
-			if (iter.slot->flags & KVM_MEM_GUEST_MEMFD &&
-			    !kvm_gmem_no_mappings_slot(iter.slot, gfn_start, gfn_end))
-				return false;
+			if (kvm_gmem_is_any_faultable(inode, index, nr_pages)) {
+				ret = kvm_gmem_split_folio_in_filemap(h, folio);
+				if (ret) {
+					/* TODO cleanup properly. */
+					WARN_ON(ret);
+				}
+			}
 		}
+
+		hugetlb_fault_mutex_unlock(hash);
 	}
 
-	return true;
+	return ret;
 }
 
 /**
- * Set faultability of given range of gfns [@start, @end) in memslot @slot to
- * @faultable.
+ * Returns 0 if guest_memfd permits setting range [@start, @end) with
+ * faultability @faultable within memslot @slot, or negative error otherwise.
+ *
+ * If a request was made to set the memory to PRIVATE (not faultable), the pages
+ * in the range must not be pinned or mapped for the request to be permitted.
+ *
+ * Because this may allow pages to be faulted in to userspace when requested to
+ * set attributes to shared, this must only be called after the pages have been
+ * invalidated from guest page tables.
  */
-static void kvm_gmem_set_faultable_slot(struct kvm_memory_slot *slot, gfn_t start,
-					gfn_t end, bool faultable)
+static int kvm_gmem_try_set_faultable_slot(struct kvm_memory_slot *slot,
+					   gfn_t start, gfn_t end,
+					   bool faultable)
 {
 	pgoff_t start_offset;
+	struct inode *inode;
 	pgoff_t end_offset;
 	struct file *file;
+	int ret;
 
 	file = kvm_gmem_get_file(slot);
 	if (!file)
-		return;
+		return 0;
 
 	start_offset = start - slot->base_gfn + slot->gmem.pgoff;
 	end_offset = end - slot->base_gfn + slot->gmem.pgoff;
 
-	WARN_ON(kvm_gmem_set_faultable(file_inode(file), start_offset, end_offset,
-				       faultable));
+	inode = file_inode(file);
+
+	/*
+	 * Use filemap_invalidate_lock_shared() to make sure
+	 * splitting/reconstruction doesn't race with faultability updates.
+	 */
+	filemap_invalidate_lock(inode->i_mapping);
+
+	kvm_gmem_set_faultable(inode, start_offset, end_offset, faultable);
+
+	if (faultable) {
+		ret = kvm_gmem_try_split_folios_range(inode, start_offset,
+						      end_offset);
+	} else {
+		if (kvm_gmem_no_mappings_range(inode, start_offset, end_offset)) {
+			ret = kvm_gmem_try_reconstruct_folios_range(inode,
+								    start_offset,
+								    end_offset);
+		} else {
+			ret = -EINVAL;
+		}
+	}
+
+	filemap_invalidate_unlock(inode->i_mapping);
 
 	fput(file);
+
+	return ret;
 }
 
 /**
- * Set faultability of given range of gfns [@start, @end) in memslot @slot to
- * @faultable.
+ * Returns 0 if guest_memfd permits setting range [@start, @end) with
+ * faultability @faultable within VM @kvm, or negative error otherwise.
+ *
+ * See kvm_gmem_try_set_faultable_slot() for details.
  */
-static void kvm_gmem_set_faultable_vm(struct kvm *kvm, gfn_t start, gfn_t end,
-				      bool faultable)
+static int kvm_gmem_try_set_faultable_vm(struct kvm *kvm, gfn_t start, gfn_t end,
+					 bool faultable)
 {
 	int i;
 
@@ -1866,43 +2122,15 @@ static void kvm_gmem_set_faultable_vm(struct kvm *kvm, gfn_t start, gfn_t end,
 			gfn_end = min(end, slot->base_gfn + slot->npages);
 
 			if (iter.slot->flags & KVM_MEM_GUEST_MEMFD) {
-				kvm_gmem_set_faultable_slot(slot, gfn_start,
-							    gfn_end, faultable);
+				int ret;
+
+				ret = kvm_gmem_try_set_faultable_slot(slot, gfn_start,
+								      gfn_end, faultable);
+				if (ret)
+					return ret;
 			}
 		}
 	}
-}
-
-/**
- * Returns true if guest_memfd permits setting range [@start, @end) to PRIVATE.
- *
- * If memory is faulted in to host userspace and a request was made to set the
- * memory to PRIVATE, the faulted in pages must not be pinned for the request to
- * be permitted.
- */
-static int kvm_gmem_should_set_attributes_private(struct kvm *kvm, gfn_t start,
-						  gfn_t end)
-{
-	kvm_gmem_set_faultable_vm(kvm, start, end, false);
-
-	if (kvm_gmem_no_mappings(kvm, start, end))
-		return 0;
-
-	kvm_gmem_set_faultable_vm(kvm, start, end, true);
-	return -EINVAL;
-}
-
-/**
- * Returns true if guest_memfd permits setting range [@start, @end) to SHARED.
- *
- * Because this allows pages to be faulted in to userspace, this must only be
- * called after the pages have been invalidated from guest page tables.
- */
-static int kvm_gmem_should_set_attributes_shared(struct kvm *kvm, gfn_t start,
-						 gfn_t end)
-{
-	/* Always okay to set shared, hence set range faultable here. */
-	kvm_gmem_set_faultable_vm(kvm, start, end, true);
 
 	return 0;
 }
@@ -1922,10 +2150,16 @@ static int kvm_gmem_should_set_attributes_shared(struct kvm *kvm, gfn_t start,
 int kvm_gmem_should_set_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 				   unsigned long attrs)
 {
-	if (attrs & KVM_MEMORY_ATTRIBUTE_PRIVATE)
-		return kvm_gmem_should_set_attributes_private(kvm, start, end);
-	else
-		return kvm_gmem_should_set_attributes_shared(kvm, start, end);
+	bool faultable;
+	int ret;
+
+	faultable = !(attrs & KVM_MEMORY_ATTRIBUTE_PRIVATE);
+
+	ret = kvm_gmem_try_set_faultable_vm(kvm, start, end, faultable);
+	if (ret)
+		WARN_ON(kvm_gmem_try_set_faultable_vm(kvm, start, end, !faultable));
+
+	return ret;
 }
 
 #endif
-- 
2.46.0.598.g6f2099f65c-goog


