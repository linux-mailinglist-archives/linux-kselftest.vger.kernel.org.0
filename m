Return-Path: <linux-kselftest+bounces-17693-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB039746E1
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 01:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F4972869B8
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 23:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE11F1C232E;
	Tue, 10 Sep 2024 23:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CX42pobh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BC91C2301
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 23:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011927; cv=none; b=dOBOBcVeC0Y4ySZVHthenWJOsbFt2wrynwL39ELYRNUIXZnGC7YwIy1baP8cNux3knwxvoXleK/RB8DEkikxM3VN2iZ3FqsXjHrCiDlEwkuBLQFFb3EeKprcZrs9rCuiffPi7DYaeNZy01+BoCpsTeB+Xvya7WI+SvLYV7nrNVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011927; c=relaxed/simple;
	bh=bB9BdtkjjVNcS9mxcL5NczC5O+Pq5uAFXDHF0ZiMZ2Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=REzkYl1baJK2Ui2AfvXLwMvia8rV0ZD2TuwvlPrN6cXlGQcTzmnfm5qRyKVPGKgRBrTPqLFFsGlwsgPbqw/QzYn/DjVQ0UoWJTFPmc7pb1bbug9hRQH2V5uFNx1yTZPj6848GCEqze+Y0BG7elAj5c30jTa7wPjWBCOYSA7Lyhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CX42pobh; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d5fccc3548so6667657b3.1
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 16:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726011925; x=1726616725; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v3nxHl/A8XO7B4MgOY4YbNCzyESNqY5WdHlaVGBDG2E=;
        b=CX42pobhdVm6+IyAp8M6oTsOuofj4qZRJtNy1RgQpZZIB2hiaqoYRNP8m+5vF2fB2i
         SVRzah2aT28nPhWSrg+8fuCpMktKaV/rZaaE/s1t4muCESgQKOiRMkly8L4+tgzcXvSm
         I7aUQ8LTEvNP/w054rEwP8UYFffk9ope21s9q1RwU+CiSmgAKyBzm2ee3vto3TNWwYnB
         z3+h+E0H0eOrkboltRoEmZiyxVxJ+QSfJzhj7RTAFtnqy8qQ3JaaLbonvskgDvUeHkb4
         yOWNAILNHEQ6ZvDL8yVrMieqyJCoRv1e9JJjBehzRNExPOuLv/F6HBXsIFaYCDq+ocYv
         QbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726011925; x=1726616725;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v3nxHl/A8XO7B4MgOY4YbNCzyESNqY5WdHlaVGBDG2E=;
        b=VKQU+1yLgo4QlYMQ7fTrFO06ueuzbd1WAReYfa+3PpapEwlKHarQMDPnCd0QSSQqks
         FI9vUWJhAC2nr3925quaeUvSPNAAZUOym543HUOM4LwzOa6XWpVMjtHS0HszEE+L20Hj
         k16hfcVUMMWNqJhBsC/T5B0xoBuzVY9A2FcscTxhKzI2a+X3ZYWf29qs6Upt8+yokcDX
         KAr1iMv2QGVqWQHq1DcVGiQKsph2INQJe22e9Nl8bAqtFZVZ7LyVJpD5/YiaKASJBOai
         g5qcmztnG2X8OHzFGWNpR8zDXYZwniZT7mGp7BNiZgO1np9LWfIjnurcMRBjNgvTcwnz
         gz4g==
X-Forwarded-Encrypted: i=1; AJvYcCU7NPIGi0wYZU6x/huD/cqk21LycvWj5nflw9f0GzVhbeMf2sOwvH7TkSBLJmwZmO1LcvRaSHilT7EkPs4bMNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjQTqveLz5LDhBUi3ZkkFh/Llga5L59U7q09QjuxI9hLIucB4X
	QdUnj75wEU0HiI72UzwCIK8E47zioKrEJJiVK5wN3qn9HAaWtrwwmI7J23XTkJmIDaU/2nSLEl9
	9SOjYLVI2X1JwmsojJ9XwFg==
X-Google-Smtp-Source: AGHT+IHnLEBVmryIC9G4GF4GWQoXu2VnZ3KvRT32M4K9/h8Y/56ASW5COSwM++WZGjik0HMML4LUNHLenr0THNvvKg==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a81:a883:0:b0:6d3:e7e6:8462 with SMTP
 id 00721157ae682-6db952f5ee5mr1095417b3.1.1726011924932; Tue, 10 Sep 2024
 16:45:24 -0700 (PDT)
Date: Tue, 10 Sep 2024 23:44:01 +0000
In-Reply-To: <cover.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <24cf7a9b1ee499c4ca4da76e9945429072014d1e.1726009989.git.ackerleytng@google.com>
Subject: [RFC PATCH 30/39] KVM: guest_memfd: Handle folio preparation for
 guest_memfd mmap
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

Since guest_memfd now supports mmap(), folios have to be prepared
before they are faulted into userspace.

When memory attributes are switched between shared and private, the
up-to-date flags will be cleared.

Use the folio's up-to-date flag to indicate being ready for the guest
usage and can be used to mark whether the folio is ready for shared OR
private use.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>

---
 virt/kvm/guest_memfd.c | 131 ++++++++++++++++++++++++++++++++++++++++-
 virt/kvm/kvm_main.c    |   2 +
 virt/kvm/kvm_mm.h      |   7 +++
 3 files changed, 139 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 110c4bbb004b..fb292e542381 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -129,13 +129,29 @@ static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slo
 }
 
 /**
- * Use the uptodate flag to indicate that the folio is prepared for KVM's usage.
+ * Use folio's up-to-date flag to indicate that this folio is prepared for usage
+ * by the guest.
+ *
+ * This flag can be used whether the folio is prepared for PRIVATE or SHARED
+ * usage.
  */
 static inline void kvm_gmem_mark_prepared(struct folio *folio)
 {
 	folio_mark_uptodate(folio);
 }
 
+/**
+ * Use folio's up-to-date flag to indicate that this folio is not yet prepared for
+ * usage by the guest.
+ *
+ * This flag can be used whether the folio is prepared for PRIVATE or SHARED
+ * usage.
+ */
+static inline void kvm_gmem_clear_prepared(struct folio *folio)
+{
+	folio_clear_uptodate(folio);
+}
+
 /*
  * Process @folio, which contains @gfn, so that the guest can use it.
  * The folio must be locked and the gfn must be contained in @slot.
@@ -148,6 +164,12 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
 	pgoff_t index;
 	int r;
 
+	/*
+	 * Defensively zero folio to avoid leaking kernel memory in
+	 * uninitialized pages. This is important since pages can now be mapped
+	 * into userspace, where hardware (e.g. TDX) won't be clearing those
+	 * pages.
+	 */
 	if (folio_test_hugetlb(folio)) {
 		folio_zero_user(folio, folio->index << PAGE_SHIFT);
 	} else {
@@ -1017,6 +1039,7 @@ static vm_fault_t kvm_gmem_fault(struct vm_fault *vmf)
 {
 	struct inode *inode;
 	struct folio *folio;
+	bool is_prepared;
 
 	inode = file_inode(vmf->vma->vm_file);
 	if (!kvm_gmem_is_faultable(inode, vmf->pgoff))
@@ -1026,6 +1049,31 @@ static vm_fault_t kvm_gmem_fault(struct vm_fault *vmf)
 	if (!folio)
 		return VM_FAULT_SIGBUS;
 
+	is_prepared = folio_test_uptodate(folio);
+	if (!is_prepared) {
+		unsigned long nr_pages;
+		unsigned long i;
+
+		if (folio_test_hugetlb(folio)) {
+			folio_zero_user(folio, folio->index << PAGE_SHIFT);
+		} else {
+			/*
+			 * Defensively zero folio to avoid leaking kernel memory in
+			 * uninitialized pages. This is important since pages can now be
+			 * mapped into userspace, where hardware (e.g. TDX) won't be
+			 * clearing those pages.
+			 *
+			 * Will probably need a version of kvm_gmem_prepare_folio() to
+			 * prepare the page for SHARED use.
+			 */
+			nr_pages = folio_nr_pages(folio);
+			for (i = 0; i < nr_pages; i++)
+				clear_highpage(folio_page(folio, i));
+		}
+
+		kvm_gmem_mark_prepared(folio);
+	}
+
 	vmf->page = folio_file_page(folio, vmf->pgoff);
 	return VM_FAULT_LOCKED;
 }
@@ -1593,6 +1641,87 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src, long
 }
 EXPORT_SYMBOL_GPL(kvm_gmem_populate);
 
+static void kvm_gmem_clear_prepared_range(struct inode *inode, pgoff_t start,
+					  pgoff_t end)
+{
+	pgoff_t index;
+
+	filemap_invalidate_lock_shared(inode->i_mapping);
+
+	/* TODO: replace iteration with filemap_get_folios() for efficiency. */
+	for (index = start; index < end;) {
+		struct folio *folio;
+
+		/* Don't use kvm_gmem_get_folio to avoid allocating */
+		folio = filemap_lock_folio(inode->i_mapping, index);
+		if (IS_ERR(folio)) {
+			++index;
+			continue;
+		}
+
+		kvm_gmem_clear_prepared(folio);
+
+		index = folio_next_index(folio);
+		folio_unlock(folio);
+		folio_put(folio);
+	}
+
+	filemap_invalidate_unlock_shared(inode->i_mapping);
+}
+
+/**
+ * Clear the prepared flag for all folios in gfn range [@start, @end) in memslot
+ * @slot.
+ */
+static void kvm_gmem_clear_prepared_slot(struct kvm_memory_slot *slot, gfn_t start,
+					 gfn_t end)
+{
+	pgoff_t start_offset;
+	pgoff_t end_offset;
+	struct file *file;
+
+	file = kvm_gmem_get_file(slot);
+	if (!file)
+		return;
+
+	start_offset = start - slot->base_gfn + slot->gmem.pgoff;
+	end_offset = end - slot->base_gfn + slot->gmem.pgoff;
+
+	kvm_gmem_clear_prepared_range(file_inode(file), start_offset, end_offset);
+
+	fput(file);
+}
+
+/**
+ * Clear the prepared flag for all folios for any slot in gfn range
+ * [@start, @end) in @kvm.
+ */
+void kvm_gmem_clear_prepared_vm(struct kvm *kvm, gfn_t start, gfn_t end)
+{
+	int i;
+
+	lockdep_assert_held(&kvm->slots_lock);
+
+	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
+		struct kvm_memslot_iter iter;
+		struct kvm_memslots *slots;
+
+		slots = __kvm_memslots(kvm, i);
+		kvm_for_each_memslot_in_gfn_range(&iter, slots, start, end) {
+			struct kvm_memory_slot *slot;
+			gfn_t gfn_start;
+			gfn_t gfn_end;
+
+			slot = iter.slot;
+			gfn_start = max(start, slot->base_gfn);
+			gfn_end = min(end, slot->base_gfn + slot->npages);
+
+			if (iter.slot->flags & KVM_MEM_GUEST_MEMFD)
+				kvm_gmem_clear_prepared_slot(iter.slot, gfn_start, gfn_end);
+		}
+	}
+}
+
 /**
  * Returns true if pages in range [@start, @end) in inode @inode have no
  * userspace mappings.
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 1a7bbcc31b7e..255d27df7f5c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2565,6 +2565,8 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 		KVM_BUG_ON(r, kvm);
 	}
 
+	kvm_gmem_clear_prepared_vm(kvm, start, end);
+
 	kvm_handle_gfn_range(kvm, &post_set_range);
 
 out_unlock:
diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
index d8ff2b380d0e..25fd0d9f66cc 100644
--- a/virt/kvm/kvm_mm.h
+++ b/virt/kvm/kvm_mm.h
@@ -43,6 +43,7 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 void kvm_gmem_unbind(struct kvm_memory_slot *slot);
 int kvm_gmem_should_set_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 				   unsigned long attrs);
+void kvm_gmem_clear_prepared_vm(struct kvm *kvm, gfn_t start, gfn_t end);
 #else
 static inline void kvm_gmem_init(struct module *module)
 {
@@ -68,6 +69,12 @@ static inline int kvm_gmem_should_set_attributes(struct kvm *kvm, gfn_t start,
 	return 0;
 }
 
+static inline void kvm_gmem_clear_prepared_slots(struct kvm *kvm,
+						 gfn_t start, gfn_t end)
+{
+	WARN_ON_ONCE(1);
+}
+
 #endif /* CONFIG_KVM_PRIVATE_MEM */
 
 #endif /* __KVM_MM_H__ */
-- 
2.46.0.598.g6f2099f65c-goog


