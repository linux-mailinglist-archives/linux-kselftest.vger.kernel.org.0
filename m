Return-Path: <linux-kselftest+bounces-17692-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 185EE9746E0
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 01:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAFD82822BE
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 23:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E421C2323;
	Tue, 10 Sep 2024 23:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kkvXkgr/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354261AED43
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 23:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011927; cv=none; b=OiWd09S1Vg89odDV7e+qyeSwZJqGNnOoQzV90R1K4Q8bAmYRS59X9DAa7Hs1IcbLKSnNBteLWRjUloVCF+GxEE3QtDXTMiDi30AN2IPfvpmGIzrIzmOh5O/54ycLpk9jlSVTm4LQUJlf1qcHv/wMGFQl3EnYI71ssHKGQ/CZ2lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011927; c=relaxed/simple;
	bh=E5exUTcHox7ZsBbSugU4kB9L1tXTbIgmGnzZ+uWTAcI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XbDUBi3uGHqM8fD+59CWdd53MYHEC9WYVn/tNSGVtGb/+q6mxuDK1fALMZEH+n0KTVxNsd3IF5X98UPURnWntHsG01hr2UVBNE8gbRo5NLTsqAPMpSt5lx7xexLOhIntKwjRTiSXU5MuZH0v6aSY+XQifQ5X/zoAXoe11UmsZsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kkvXkgr/; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2d626e36d2eso5621822a91.2
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 16:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726011923; x=1726616723; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FjI6cBjR9AW7KizYJRES3kHs2nxbgzqD9PMU12DXiXA=;
        b=kkvXkgr/VVSh+6ffqFLFkQrHLirqCJUIz2CLLG4LBIreXlfxbKEyBtXPDgc57rKgeJ
         41smivW0T1pTZGVhcxkL/MoemqHPzyJP+Q/NAC5eIj54zcLigUFWnTq1eamHC9m+5EZT
         kSTA49px7qb4+TAWYKCLYv5sgKGE9/oUeZFZ/nTyCTOjiD6eK/GLOb8c6xopdvtWZuwM
         DJyxZaDKR79JWE2WdU7aJTKnt0a9tlwa9g2GxGDWmbwSTEQNencTMsxH1OZwlQ0oE4t0
         ccvEXTglDIX+JwpOHGbD7+7cfqzLpNFsXhmDYj9C0OSgcsrkNKV5NVxRQnu+uj+bmQr6
         eMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726011923; x=1726616723;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FjI6cBjR9AW7KizYJRES3kHs2nxbgzqD9PMU12DXiXA=;
        b=CEZc7GtlwoXXWv6FDn4itDuO3zprGyQBCqNFystXTUmznNvKXXttMxe4XX1hh5938Z
         yrxrIUjhDl0ZYxewvocqWGWv+1a3ff6VSC/afcw0hT7GA5eM3qRWZbt1yzynyghWbn1L
         kCXjfJZe18AJaic143U6iqEECOz7H9ChmMdLhDf4WT4IVWQ47eXJBr3ohrrOJguPBHQ+
         R2J5FX8mD5iJU3iYQvvUcrnPYMT/P3x1QL4GfxuYhzwehYe7xqr2rSgF/CK8FTT6jJJ2
         AdGF3kBb0rdCoYNDTqeB0TkORP1uEOKwxED966+YOjdu2lGXuWEJWLEo6b1bBGLdU1dk
         RZkg==
X-Forwarded-Encrypted: i=1; AJvYcCV/BpvvM3uKwNSCq+UGQSFHOr1MYBs3hc2JJaYfZxCQ897d9Jtkcha66hkwWgf4Hrb3044j2SqgbA84uLZYEvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqPX+rAxUY/Jmsewbyfy3FdUYXz3Y+IFW+0b9il6cvfNipXkAI
	WdoS/Rhm6zRITfck25UpPlAZ3C9pKuT7VWpo51G+xmMKi9jPN/EHg4mRc2Sv2Z63LoQZ/GGhK/f
	vlAt25PVdHjsx6v5bqT6pXw==
X-Google-Smtp-Source: AGHT+IHSKJ4yx6H+R6vmjAajFKhOO5Lbm3TP4ppQgPnLaqzbpul3ZYzZk4Z4nMlq9x4ej3kbxbURUt5MTOfpTqRbXQ==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a17:902:c405:b0:207:50e2:f54 with SMTP
 id d9443c01a7336-20750e20f6emr1226925ad.1.1726011923409; Tue, 10 Sep 2024
 16:45:23 -0700 (PDT)
Date: Tue, 10 Sep 2024 23:44:00 +0000
In-Reply-To: <cover.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <f4ca1711a477a3b56406c05d125dce3d7403b936.1726009989.git.ackerleytng@google.com>
Subject: [RFC PATCH 29/39] KVM: Handle conversions in the SET_MEMORY_ATTRIBUTES
 ioctl
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

The key steps for a private to shared conversion are:

1. Unmap from guest page tables
2. Set pages associated with requested range in memslot to be
   faultable
3. Update kvm->mem_attr_array

The key steps for a shared to private conversion are:

1. Check and disallow set_memory_attributes if any page in the range
   is still mapped or pinned, by
   a. Updating guest_memfd's faultability to prevent future faulting
   b. Returning -EINVAL if any pages are still pinned.
2. Update kvm->mem_attr_array

Userspace VMM must ensure shared pages are not in use, since any
faults racing with this call will get a SIGBUS.

Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>

---
 include/linux/kvm_host.h |   1 +
 virt/kvm/guest_memfd.c   | 207 +++++++++++++++++++++++++++++++++++++++
 virt/kvm/kvm_main.c      |  15 +++
 virt/kvm/kvm_mm.h        |   9 ++
 4 files changed, 232 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 79a6b1a63027..10993cd33e34 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2476,6 +2476,7 @@ typedef int (*kvm_gmem_populate_cb)(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 
 long kvm_gmem_populate(struct kvm *kvm, gfn_t gfn, void __user *src, long npages,
 		       kvm_gmem_populate_cb post_populate, void *opaque);
+
 #endif
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 1d4dfe0660ad..110c4bbb004b 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -1592,4 +1592,211 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src, long
 	return ret && !i ? ret : i;
 }
 EXPORT_SYMBOL_GPL(kvm_gmem_populate);
+
+/**
+ * Returns true if pages in range [@start, @end) in inode @inode have no
+ * userspace mappings.
+ */
+static bool kvm_gmem_no_mappings_range(struct inode *inode, pgoff_t start, pgoff_t end)
+{
+	pgoff_t index;
+	bool checked_indices_unmapped;
+
+	filemap_invalidate_lock_shared(inode->i_mapping);
+
+	/* TODO: replace iteration with filemap_get_folios() for efficiency. */
+	checked_indices_unmapped = true;
+	for (index = start; checked_indices_unmapped && index < end;) {
+		struct folio *folio;
+
+		/* Don't use kvm_gmem_get_folio to avoid allocating */
+		folio = filemap_lock_folio(inode->i_mapping, index);
+		if (IS_ERR(folio)) {
+			++index;
+			continue;
+		}
+
+		if (folio_mapped(folio) || folio_maybe_dma_pinned(folio))
+			checked_indices_unmapped = false;
+		else
+			index = folio_next_index(folio);
+
+		folio_unlock(folio);
+		folio_put(folio);
+	}
+
+	filemap_invalidate_unlock_shared(inode->i_mapping);
+	return checked_indices_unmapped;
+}
+
+/**
+ * Returns true if pages in range [@start, @end) in memslot @slot have no
+ * userspace mappings.
+ */
+static bool kvm_gmem_no_mappings_slot(struct kvm_memory_slot *slot,
+				      gfn_t start, gfn_t end)
+{
+	pgoff_t offset_start;
+	pgoff_t offset_end;
+	struct file *file;
+	bool ret;
+
+	offset_start = start - slot->base_gfn + slot->gmem.pgoff;
+	offset_end = end - slot->base_gfn + slot->gmem.pgoff;
+
+	file = kvm_gmem_get_file(slot);
+	if (!file)
+		return false;
+
+	ret = kvm_gmem_no_mappings_range(file_inode(file), offset_start, offset_end);
+
+	fput(file);
+
+	return ret;
+}
+
+/**
+ * Returns true if pages in range [@start, @end) have no host userspace mappings.
+ */
+static bool kvm_gmem_no_mappings(struct kvm *kvm, gfn_t start, gfn_t end)
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
+			if (iter.slot->flags & KVM_MEM_GUEST_MEMFD &&
+			    !kvm_gmem_no_mappings_slot(iter.slot, gfn_start, gfn_end))
+				return false;
+		}
+	}
+
+	return true;
+}
+
+/**
+ * Set faultability of given range of gfns [@start, @end) in memslot @slot to
+ * @faultable.
+ */
+static void kvm_gmem_set_faultable_slot(struct kvm_memory_slot *slot, gfn_t start,
+					gfn_t end, bool faultable)
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
+	WARN_ON(kvm_gmem_set_faultable(file_inode(file), start_offset, end_offset,
+				       faultable));
+
+	fput(file);
+}
+
+/**
+ * Set faultability of given range of gfns [@start, @end) in memslot @slot to
+ * @faultable.
+ */
+static void kvm_gmem_set_faultable_vm(struct kvm *kvm, gfn_t start, gfn_t end,
+				      bool faultable)
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
+			if (iter.slot->flags & KVM_MEM_GUEST_MEMFD) {
+				kvm_gmem_set_faultable_slot(slot, gfn_start,
+							    gfn_end, faultable);
+			}
+		}
+	}
+}
+
+/**
+ * Returns true if guest_memfd permits setting range [@start, @end) to PRIVATE.
+ *
+ * If memory is faulted in to host userspace and a request was made to set the
+ * memory to PRIVATE, the faulted in pages must not be pinned for the request to
+ * be permitted.
+ */
+static int kvm_gmem_should_set_attributes_private(struct kvm *kvm, gfn_t start,
+						  gfn_t end)
+{
+	kvm_gmem_set_faultable_vm(kvm, start, end, false);
+
+	if (kvm_gmem_no_mappings(kvm, start, end))
+		return 0;
+
+	kvm_gmem_set_faultable_vm(kvm, start, end, true);
+	return -EINVAL;
+}
+
+/**
+ * Returns true if guest_memfd permits setting range [@start, @end) to SHARED.
+ *
+ * Because this allows pages to be faulted in to userspace, this must only be
+ * called after the pages have been invalidated from guest page tables.
+ */
+static int kvm_gmem_should_set_attributes_shared(struct kvm *kvm, gfn_t start,
+						 gfn_t end)
+{
+	/* Always okay to set shared, hence set range faultable here. */
+	kvm_gmem_set_faultable_vm(kvm, start, end, true);
+
+	return 0;
+}
+
+/**
+ * Returns 0 if guest_memfd permits setting attributes @attrs for range [@start,
+ * @end) or negative error otherwise.
+ *
+ * If memory is faulted in to host userspace and a request was made to set the
+ * memory to PRIVATE, the faulted in pages must not be pinned for the request to
+ * be permitted.
+ *
+ * Because this may allow pages to be faulted in to userspace when requested to
+ * set attributes to shared, this must only be called after the pages have been
+ * invalidated from guest page tables.
+ */
+int kvm_gmem_should_set_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
+				   unsigned long attrs)
+{
+	if (attrs & KVM_MEMORY_ATTRIBUTE_PRIVATE)
+		return kvm_gmem_should_set_attributes_private(kvm, start, end);
+	else
+		return kvm_gmem_should_set_attributes_shared(kvm, start, end);
+}
+
 #endif
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 92901656a0d4..1a7bbcc31b7e 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2524,6 +2524,13 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 		.on_lock = kvm_mmu_invalidate_end,
 		.may_block = true,
 	};
+	struct kvm_mmu_notifier_range error_set_range = {
+		.start = start,
+		.end = end,
+		.handler = (void *)kvm_null_fn,
+		.on_lock = kvm_mmu_invalidate_end,
+		.may_block = true,
+	};
 	unsigned long i;
 	void *entry;
 	int r = 0;
@@ -2548,6 +2555,10 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 
 	kvm_handle_gfn_range(kvm, &pre_set_range);
 
+	r = kvm_gmem_should_set_attributes(kvm, start, end, attributes);
+	if (r)
+		goto err;
+
 	for (i = start; i < end; i++) {
 		r = xa_err(xa_store(&kvm->mem_attr_array, i, entry,
 				    GFP_KERNEL_ACCOUNT));
@@ -2560,6 +2571,10 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 	mutex_unlock(&kvm->slots_lock);
 
 	return r;
+
+err:
+	kvm_handle_gfn_range(kvm, &error_set_range);
+	goto out_unlock;
 }
 static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
 					   struct kvm_memory_attributes *attrs)
diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
index 715f19669d01..d8ff2b380d0e 100644
--- a/virt/kvm/kvm_mm.h
+++ b/virt/kvm/kvm_mm.h
@@ -41,6 +41,8 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args);
 int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 		  unsigned int fd, loff_t offset);
 void kvm_gmem_unbind(struct kvm_memory_slot *slot);
+int kvm_gmem_should_set_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
+				   unsigned long attrs);
 #else
 static inline void kvm_gmem_init(struct module *module)
 {
@@ -59,6 +61,13 @@ static inline void kvm_gmem_unbind(struct kvm_memory_slot *slot)
 {
 	WARN_ON_ONCE(1);
 }
+
+static inline int kvm_gmem_should_set_attributes(struct kvm *kvm, gfn_t start,
+						 gfn_t end, unsigned long attrs)
+{
+	return 0;
+}
+
 #endif /* CONFIG_KVM_PRIVATE_MEM */
 
 #endif /* __KVM_MM_H__ */
-- 
2.46.0.598.g6f2099f65c-goog


