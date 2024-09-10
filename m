Return-Path: <linux-kselftest+bounces-17689-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A369746D5
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 01:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 986C91F275AB
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 23:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385C71C1732;
	Tue, 10 Sep 2024 23:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TWnEg+ha"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D5A1C0DFB
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 23:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011921; cv=none; b=ZbPhRnahOJIbxRqKGKSDWn9t7qn3bZw/2dRYmjcYS77N0uhFFzkJC7zuoYtFAmTk/QkK5EZy7uwYpambEfI/3Ax57jfru+8aVubg//ZZVcY3siAaLXILwfEvfhFv2YC/hpFFFQ5jveTIFh443NbJK0Cl2+LOJC8KVRMavmuMIYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011921; c=relaxed/simple;
	bh=OYgGvX0hYL3mGQHZcgbKQoTaViWJ4HoiAFWlcJhpcoQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QW+zkw8ei5Lxvj1yURREzSeza3pdUJMlgCG6IxhLCfRDkut2mfuxEGqwlCWxlVbZa92uRIzDDMYRabaTkBdtqlEzwZXEICNXgJuuafrx34kGIwY4mWEo4Tvn2jPEtoibg8zLFFseetAz6F0cHNanu10+QZHWmQ8KRShKbxQgKFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TWnEg+ha; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-69a0536b23aso179502037b3.3
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 16:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726011918; x=1726616718; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tJq0MqYSe34io4UmOdJbczSi4Mtmt5uxlF7QPZDIEdU=;
        b=TWnEg+haf1eLvMdkzMcC9xC5gy3LKA7p5jQVamv+1lxQIaPHUFJ3d0TPTGcfXH0j03
         1oMejKuzzl4EEhNrKgtdWc87G84fxHtXG7ALfU219YXtn7Q+uMHodcwCOIqdiR8jAYFu
         Gif3VgoEX5yVrIafdddBIIKYxglFaDR7XGAQYK6bsWeqtNQ5M3BZTTSa86tzJMGrJHAk
         5dHr5KpAHlTUX/TNvXzJEneKk2Va6gvKAMCoRNidyqeTO7XxO3cc0wg5rRtpX/6g2dGx
         ikf/Idfa5VgDUf+KxX0vR9hdinqV5rSITVsHGoYrRIytWv+2IC2QreMLaYoO4gn+OYpo
         sPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726011918; x=1726616718;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tJq0MqYSe34io4UmOdJbczSi4Mtmt5uxlF7QPZDIEdU=;
        b=NZaqrpaKkrN/6hjRV37tBE3eYG+dEsTSTz9KaPelLfdAO3TvF9UCTXGoXJB5g7xveG
         D1pNTb7AEWtLwBH8FRgIno+6QmKEO94mpS0gwJyYdHukEQP75WOKWaP7QICcMAJ2iFoj
         TT33GdrIt0taCjjmm+E5lxCELHpYfX6I8NG1TJj8rZHCj+Q9nQP3kK2fwKedmzI4kOdp
         rbtYPdryj6C9to/Jh2JUTBNRyohIlw/DhQz7ibd0YFyavESl+RvkHBRchFvKWL8TX3c2
         8TLvMBJxUXaXqwWTXQYrkMmO1OzlayiICVyBhC6MMlFaWVPr9kAqZATzhqYsJooTfA4r
         P6dA==
X-Forwarded-Encrypted: i=1; AJvYcCXJluxZmV1MiqhX2GlEDvofs+HKOvKVsD9qoxvm1T8T4x+rYYPgoF89szRjuPzk1SQtMAOXdGk1KpG59ipDJiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc7Xz89tjo7r4MhJWs3mHKV21fwVdW5w8yXBuGm3ihJV+VAIJ4
	Y/dtJ+4f7JX1ODEoSUqIWyBIezSiuzWsB4DfWCMC34HtxiZrfWGjfBqRyF7+CQztav071a12nhZ
	tZTFtSmOsDIdIBBrziU+HwQ==
X-Google-Smtp-Source: AGHT+IGSLUm8oBiaMD+q3wklbXJeQqiWR8FYu/x3IcQqY2JhzZy9eAY0OzQzZWTZkFFReNAsglf+owucD34Qou3lfw==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a05:690c:38c:b0:6af:623c:7694 with
 SMTP id 00721157ae682-6db44a5d200mr10772047b3.0.1726011918533; Tue, 10 Sep
 2024 16:45:18 -0700 (PDT)
Date: Tue, 10 Sep 2024 23:43:57 +0000
In-Reply-To: <cover.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <bd163de3118b626d1005aa88e71ef2fb72f0be0f.1726009989.git.ackerleytng@google.com>
Subject: [RFC PATCH 26/39] KVM: guest_memfd: Track faultability within a
 struct kvm_gmem_private
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

The faultability xarray is stored on the inode since faultability is a
property of the guest_memfd's memory contents.

In this RFC, presence of an entry in the xarray indicates faultable,
but this could be flipped so that presence indicates unfaultable. For
flexibility, a special value "FAULT" is used instead of a simple
boolean.

However, at some stages of a VM's lifecycle there could be more
private pages, and at other stages there could be more shared pages.

This is likely to be replaced by a better data structure in a future
revision to better support ranges.

Also store struct kvm_gmem_hugetlb in struct kvm_gmem_hugetlb as a
pointer. inode->i_mapping->i_private_data.

Co-developed-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Fuad Tabba <tabba@google.com>
Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>

---
 virt/kvm/guest_memfd.c | 105 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 94 insertions(+), 11 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 8151df2c03e5..b603518f7b62 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -26,11 +26,21 @@ struct kvm_gmem_hugetlb {
 	struct hugepage_subpool *spool;
 };
 
-static struct kvm_gmem_hugetlb *kvm_gmem_hgmem(struct inode *inode)
+struct kvm_gmem_inode_private {
+	struct xarray faultability;
+	struct kvm_gmem_hugetlb *hgmem;
+};
+
+static struct kvm_gmem_inode_private *kvm_gmem_private(struct inode *inode)
 {
 	return inode->i_mapping->i_private_data;
 }
 
+static struct kvm_gmem_hugetlb *kvm_gmem_hgmem(struct inode *inode)
+{
+	return kvm_gmem_private(inode)->hgmem;
+}
+
 static bool is_kvm_gmem_hugetlb(struct inode *inode)
 {
 	u64 flags = (u64)inode->i_private;
@@ -38,6 +48,57 @@ static bool is_kvm_gmem_hugetlb(struct inode *inode)
 	return flags & KVM_GUEST_MEMFD_HUGETLB;
 }
 
+#define KVM_GMEM_FAULTABILITY_VALUE 0x4641554c54  /* FAULT */
+
+/**
+ * Set faultability of given range of inode indices [@start, @end) to
+ * @faultable. Return 0 if attributes were successfully updated or negative
+ * errno on error.
+ */
+static int kvm_gmem_set_faultable(struct inode *inode, pgoff_t start, pgoff_t end,
+				  bool faultable)
+{
+	struct xarray *faultability;
+	void *val;
+	pgoff_t i;
+
+	/*
+	 * The expectation is that fewer pages are faultable, hence save memory
+	 * entries are created for faultable pages as opposed to creating
+	 * entries for non-faultable pages.
+	 */
+	val = faultable ? xa_mk_value(KVM_GMEM_FAULTABILITY_VALUE) : NULL;
+	faultability = &kvm_gmem_private(inode)->faultability;
+
+	/*
+	 * TODO replace this with something else (maybe interval
+	 * tree?). store_range doesn't quite do what we expect if overlapping
+	 * ranges are specified: if we store_range(5, 10, val) and then
+	 * store_range(7, 12, NULL), the entire range [5, 12] will be NULL.  For
+	 * now, use the slower xa_store() to store individual entries on indices
+	 * to avoid this.
+	 */
+	for (i = start; i < end; i++) {
+		int r;
+
+		r = xa_err(xa_store(faultability, i, val, GFP_KERNEL_ACCOUNT));
+		if (r)
+			return r;
+	}
+
+	return 0;
+}
+
+/**
+ * Return true if the page at @index is allowed to be faulted in.
+ */
+static bool kvm_gmem_is_faultable(struct inode *inode, pgoff_t index)
+{
+	struct xarray *faultability = &kvm_gmem_private(inode)->faultability;
+
+	return xa_to_value(xa_load(faultability, index)) == KVM_GMEM_FAULTABILITY_VALUE;
+}
+
 /**
  * folio_file_pfn - like folio_file_page, but return a pfn.
  * @folio: The folio which contains this index.
@@ -895,11 +956,21 @@ static void kvm_gmem_hugetlb_teardown(struct inode *inode)
 
 static void kvm_gmem_evict_inode(struct inode *inode)
 {
+	struct kvm_gmem_inode_private *private = kvm_gmem_private(inode);
+
+	/*
+	 * .evict_inode can be called before faultability is set up if there are
+	 * issues during inode creation.
+	 */
+	if (private)
+		xa_destroy(&private->faultability);
+
 	if (is_kvm_gmem_hugetlb(inode))
 		kvm_gmem_hugetlb_teardown(inode);
 	else
 		truncate_inode_pages_final(inode->i_mapping);
 
+	kfree(private);
 	clear_inode(inode);
 }
 
@@ -1028,7 +1099,9 @@ static const struct inode_operations kvm_gmem_iops = {
 	.setattr	= kvm_gmem_setattr,
 };
 
-static int kvm_gmem_hugetlb_setup(struct inode *inode, loff_t size, u64 flags)
+static int kvm_gmem_hugetlb_setup(struct inode *inode,
+				  struct kvm_gmem_inode_private *private,
+				  loff_t size, u64 flags)
 {
 	struct kvm_gmem_hugetlb *hgmem;
 	struct hugepage_subpool *spool;
@@ -1036,6 +1109,10 @@ static int kvm_gmem_hugetlb_setup(struct inode *inode, loff_t size, u64 flags)
 	struct hstate *h;
 	long hpages;
 
+	hgmem = kzalloc(sizeof(*hgmem), GFP_KERNEL);
+	if (!hgmem)
+		return -ENOMEM;
+
 	page_size_log = (flags >> KVM_GUEST_MEMFD_HUGE_SHIFT) & KVM_GUEST_MEMFD_HUGE_MASK;
 	h = hstate_sizelog(page_size_log);
 
@@ -1046,21 +1123,16 @@ static int kvm_gmem_hugetlb_setup(struct inode *inode, loff_t size, u64 flags)
 	if (!spool)
 		goto err;
 
-	hgmem = kzalloc(sizeof(*hgmem), GFP_KERNEL);
-	if (!hgmem)
-		goto err_subpool;
-
 	inode->i_blkbits = huge_page_shift(h);
 
 	hgmem->h = h;
 	hgmem->spool = spool;
-	inode->i_mapping->i_private_data = hgmem;
 
+	private->hgmem = hgmem;
 	return 0;
 
-err_subpool:
-	kfree(spool);
 err:
+	kfree(hgmem);
 	return -ENOMEM;
 }
 
@@ -1068,6 +1140,7 @@ static struct inode *kvm_gmem_inode_make_secure_inode(const char *name,
 						      loff_t size, u64 flags)
 {
 	const struct qstr qname = QSTR_INIT(name, strlen(name));
+	struct kvm_gmem_inode_private *private;
 	struct inode *inode;
 	int err;
 
@@ -1079,12 +1152,20 @@ static struct inode *kvm_gmem_inode_make_secure_inode(const char *name,
 	if (err)
 		goto out;
 
+	err = -ENOMEM;
+	private = kzalloc(sizeof(*private), GFP_KERNEL);
+	if (!private)
+		goto out;
+
 	if (flags & KVM_GUEST_MEMFD_HUGETLB) {
-		err = kvm_gmem_hugetlb_setup(inode, size, flags);
+		err = kvm_gmem_hugetlb_setup(inode, private, size, flags);
 		if (err)
-			goto out;
+			goto free_private;
 	}
 
+	xa_init(&private->faultability);
+	inode->i_mapping->i_private_data = private;
+
 	inode->i_private = (void *)(unsigned long)flags;
 	inode->i_op = &kvm_gmem_iops;
 	inode->i_mapping->a_ops = &kvm_gmem_aops;
@@ -1097,6 +1178,8 @@ static struct inode *kvm_gmem_inode_make_secure_inode(const char *name,
 
 	return inode;
 
+free_private:
+	kfree(private);
 out:
 	iput(inode);
 
-- 
2.46.0.598.g6f2099f65c-goog


