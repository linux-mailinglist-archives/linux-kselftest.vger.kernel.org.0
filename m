Return-Path: <linux-kselftest+bounces-21101-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCE29B64AA
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 14:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90841F21F7E
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 13:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CEC1EF095;
	Wed, 30 Oct 2024 13:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="EYnRC2Tl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A461DFD8E;
	Wed, 30 Oct 2024 13:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730296209; cv=none; b=VVJh9lO4+I+wbCXarMKWfQ9gHkk4nZq3AmiZctHPML0/o2x21XUS1mb2BonyP4KUVlNOnd7JZPjQgIjvAvUXxZKoaW5zpWoO7O6aD9fuuJMs+q4IHZ5eAclwAx5/9jzjCO21mDLt0Jvp2XggNWe9wQnIjqy0OJprcbLepAr3rcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730296209; c=relaxed/simple;
	bh=Y9EHdRw8NIyb69Me7Ph1bYHigu48iA/9Qxeksc9ahpo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XSSGDDISLpuZKKGYze9IcNFcm21W85QRbGPHv50XmZp47oNLfdIlYnbwB47zfc0Muyv0hK3p2mBwGAsrviX3ZJf+MF0Y+yoch0VBOfv9ygoeuJ+pU54467IvGrjpzgYUgaBHmYurOfH1a40B80YtSaurydNPy/lPPGHf14okJrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=EYnRC2Tl; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1730296207; x=1761832207;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S8hLaLmpaqH2hbmpwLE9UIqf50NoMS+38eolo/Dz8xQ=;
  b=EYnRC2Tlqwf1avSDimOE7hFGv86ivwZcSCFSrnfifdAMrXXoo2R2z3TI
   FGn0jcC4rUall/ZmRwaXTMOe0kDwK86JH5duQUHoDJz/CP1eEWfPJXLcW
   jGWR8WxB09Xr88WZhqJJzgqe5Do48hmVJ+1mnNcg+i/c9Fw/FNG1SIDV0
   Q=;
X-IronPort-AV: E=Sophos;i="6.11,245,1725321600"; 
   d="scan'208";a="142980599"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 13:50:06 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:54967]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.121:2525] with esmtp (Farcaster)
 id 08c8009f-6d75-4831-aeed-52be2404b382; Wed, 30 Oct 2024 13:50:06 +0000 (UTC)
X-Farcaster-Flow-ID: 08c8009f-6d75-4831-aeed-52be2404b382
Received: from EX19D003UWC002.ant.amazon.com (10.13.138.169) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 30 Oct 2024 13:50:00 +0000
Received: from EX19MTAUWA002.ant.amazon.com (10.250.64.202) by
 EX19D003UWC002.ant.amazon.com (10.13.138.169) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 30 Oct 2024 13:50:00 +0000
Received: from email-imr-corp-prod-pdx-all-2c-8a67eb17.us-west-2.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Wed, 30 Oct 2024 13:50:00 +0000
Received: from ua2d7e1a6107c5b.home (dev-dsk-roypat-1c-dbe2a224.eu-west-1.amazon.com [172.19.88.180])
	by email-imr-corp-prod-pdx-all-2c-8a67eb17.us-west-2.amazon.com (Postfix) with ESMTPS id 8A1224032D;
	Wed, 30 Oct 2024 13:49:50 +0000 (UTC)
From: Patrick Roy <roypat@amazon.co.uk>
To: <tabba@google.com>, <quic_eberman@quicinc.com>, <david@redhat.com>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <jthoughton@google.com>,
	<ackerleytng@google.com>, <vannapurve@google.com>, <rppt@kernel.org>
CC: Patrick Roy <roypat@amazon.co.uk>, <graf@amazon.com>,
	<jgowans@amazon.com>, <derekmn@amazon.com>, <kalyazin@amazon.com>,
	<xmarcalx@amazon.com>, <linux-mm@kvack.org>, <corbet@lwn.net>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <chenhuacai@kernel.org>,
	<kernel@xen0n.name>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <hca@linux.ibm.com>, <gor@linux.ibm.com>,
	<agordeev@linux.ibm.com>, <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
	<gerald.schaefer@linux.ibm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <luto@kernel.org>, <peterz@infradead.org>,
	<rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <shuah@kernel.org>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [RFC PATCH v3 2/6] kvm: gmem: add flag to remove memory from kernel direct map
Date: Wed, 30 Oct 2024 13:49:06 +0000
Message-ID: <20241030134912.515725-3-roypat@amazon.co.uk>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030134912.515725-1-roypat@amazon.co.uk>
References: <20241030134912.515725-1-roypat@amazon.co.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

Add a new flag, KVM_GMEM_NO_DIRECT_MAP, to KVM_CREATE_GUEST_MEMFD, which
causes KVM to remove the folios backing this guest_memfd from the direct
map after preparation/population. This flag is only exposed on
architectures that can set the direct map (the notable exception here
being ARM64 if the direct map is not set up at 4K granularity),
otherwise EOPNOTSUPP is returned.

This patch also implements infrastructure for tracking (temporary)
reinsertation of memory ranges into the direct map (more accurately: It
allows recording that specific memory ranges deviate from the default
direct map setup. Currently the default setup is always "direct map
entries removed", but it is trivial to extend this with some
"default_state_for_vm_type" mechanism to cover the pKVM usecase of
memory starting off with directe map entries present). An xarray
tracks this at page granularity, to be compatible with future
hugepages usecases that might require subranges of hugetlb folios to
have direct map entries restored. This xarray holds entries for each
page that has a direct map state deviating from the default, and holes
for all pages whose direct map state matches the default, the idea being
that these "deviations" will be rare.
kvm_gmem_folio_configure_direct_map applies the configuration stored in
the xarray to a given folio, and is called for each new gmem folio after
preparation/population.

Storing direct map state in the gmem inode has two advantages:
1) We can track direct map state at page granularity even for huge
   folios (see also Ackerley's series on hugetlbfs support in
   guest_memfd [1])
2) We can pre-configure the direct map state of not-yet-faulted in
   folios. This would for example be needed if a VMM is receiving a
   virtio buffer that the guest is requested it to fill. In this case,
   the pages backing the guest physical address range of the buffer
   might not be faulted in yet, and thus would be faulted when the VMM
   tries to write to them, and at this point we would need to ensure
   direct map entries are present)

Note that this patch does not include operations for manipulating the
direct map state xarray, or for changing direct map state of already
existing folios. These routines are sketched out in the following patch,
although are not needed in this initial patch series.

When a gmem folio is freed, it is reinserted into the direct map (and
failing this, marked as HWPOISON to avoid any other part of the kernel
accidentally touching folios without complete direct map entries). The
direct map configuration stored in the xarray is _not_ reset when the
folio is freed (although this could be implemented by storing the
reference to the xarray in the folio's private data instead of only the
inode).

[1]: https://lore.kernel.org/kvm/cover.1726009989.git.ackerleytng@google.com/

Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
---
 include/uapi/linux/kvm.h |   2 +
 virt/kvm/guest_memfd.c   | 150 +++++++++++++++++++++++++++++++++++----
 2 files changed, 137 insertions(+), 15 deletions(-)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 637efc0551453..81b0f4a236b8c 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1564,6 +1564,8 @@ struct kvm_create_guest_memfd {
 	__u64 reserved[6];
 };
 
+#define KVM_GMEM_NO_DIRECT_MAP			(1ULL << 0)
+
 #define KVM_PRE_FAULT_MEMORY	_IOWR(KVMIO, 0xd5, struct kvm_pre_fault_memory)
 
 struct kvm_pre_fault_memory {
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 47a9f68f7b247..50ffc2ad73eda 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -4,6 +4,7 @@
 #include <linux/kvm_host.h>
 #include <linux/pagemap.h>
 #include <linux/anon_inodes.h>
+#include <linux/set_memory.h>
 
 #include "kvm_mm.h"
 
@@ -13,6 +14,88 @@ struct kvm_gmem {
 	struct list_head entry;
 };
 
+struct kvm_gmem_inode_private {
+	unsigned long long flags;
+
+	/*
+	 * direct map configuration of the gmem instance this private data
+	 * is associated with. present indices indicate a desired direct map
+	 * configuration deviating from default_direct_map_state (e.g. if
+	 * default_direct_map_state is false/not present, then the xarray
+	 * contains all indices for which direct map entries are restored).
+	 */
+	struct xarray direct_map_state;
+	bool default_direct_map_state;
+};
+
+static bool kvm_gmem_test_no_direct_map(struct kvm_gmem_inode_private *gmem_priv)
+{
+	return ((unsigned long)gmem_priv->flags & KVM_GMEM_NO_DIRECT_MAP) != 0;
+}
+
+/*
+ * Configure the direct map present/not present state of @folio based on
+ * the xarray stored in the associated inode's private data.
+ *
+ * Assumes the folio lock is held.
+ */
+static int kvm_gmem_folio_configure_direct_map(struct folio *folio)
+{
+	struct inode *inode = folio_inode(folio);
+	struct kvm_gmem_inode_private *gmem_priv = inode->i_private;
+	bool default_state = gmem_priv->default_direct_map_state;
+
+	pgoff_t start = folio_index(folio);
+	pgoff_t last = start + folio_nr_pages(folio) - 1;
+
+	struct xarray *xa = &gmem_priv->direct_map_state;
+	unsigned long index;
+	void *entry;
+
+	pgoff_t range_start = start;
+	unsigned long npages = 1;
+	int r = 0;
+
+	if (!kvm_gmem_test_no_direct_map(gmem_priv))
+		goto out;
+
+	r = set_direct_map_valid_noflush(folio_page(folio, 0), folio_nr_pages(folio),
+					 default_state);
+	if (r)
+		goto out;
+
+	if (!xa_find_after(xa, &range_start, last, XA_PRESENT))
+		goto out_flush;
+
+	xa_for_each_range(xa, index, entry, range_start, last) {
+		++npages;
+
+		if (index == range_start + npages)
+			continue;
+
+		r = set_direct_map_valid_noflush(folio_file_page(folio, range_start), npages - 1,
+						 !default_state);
+		if (r)
+			goto out_flush;
+
+		range_start = index;
+		npages = 1;
+	}
+
+	r = set_direct_map_valid_noflush(folio_file_page(folio, range_start), npages,
+					 !default_state);
+
+out_flush:
+	/*
+	 * Use PG_private to track that this folio has had potentially some of
+	 * its direct map entries modified, so that we can restore them in free_folio.
+	 */
+	folio_set_private(folio);
+	flush_tlb_kernel_range(start, start + folio_size(folio));
+out:
+	return r;
+}
+
 /**
  * folio_file_pfn - like folio_file_page, but return a pfn.
  * @folio: The folio which contains this index.
@@ -42,9 +125,19 @@ static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slo
 	return 0;
 }
 
-static inline void kvm_gmem_mark_prepared(struct folio *folio)
+
+static inline int kvm_gmem_finalize_folio(struct folio *folio)
 {
+	int r = kvm_gmem_folio_configure_direct_map(folio);
+
+	/*
+	 * Parts of the direct map might have been punched out, mark this folio
+	 * as prepared even in the error case to avoid touching parts without
+	 * direct map entries in a potential re-preparation.
+	 */
 	folio_mark_uptodate(folio);
+
+	return r;
 }
 
 /*
@@ -82,11 +175,10 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
 	index = ALIGN_DOWN(index, 1 << folio_order(folio));
 	r = __kvm_gmem_prepare_folio(kvm, slot, index, folio);
 	if (!r)
-		kvm_gmem_mark_prepared(folio);
+		r = kvm_gmem_finalize_folio(folio);
 
 	return r;
 }
-
 /*
  * Returns a locked folio on success.  The caller is responsible for
  * setting the up-to-date flag before the memory is mapped into the guest.
@@ -249,6 +341,7 @@ static long kvm_gmem_fallocate(struct file *file, int mode, loff_t offset,
 static int kvm_gmem_release(struct inode *inode, struct file *file)
 {
 	struct kvm_gmem *gmem = file->private_data;
+	struct kvm_gmem_inode_private *gmem_priv;
 	struct kvm_memory_slot *slot;
 	struct kvm *kvm = gmem->kvm;
 	unsigned long index;
@@ -279,13 +372,17 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
 
 	list_del(&gmem->entry);
 
+	gmem_priv = inode->i_private;
+
 	filemap_invalidate_unlock(inode->i_mapping);
 
 	mutex_unlock(&kvm->slots_lock);
-
 	xa_destroy(&gmem->bindings);
 	kfree(gmem);
 
+	xa_destroy(&gmem_priv->direct_map_state);
+	kfree(gmem_priv);
+
 	kvm_put_kvm(kvm);
 
 	return 0;
@@ -357,24 +454,37 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
 	return MF_DELAYED;
 }
 
-#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
 static void kvm_gmem_free_folio(struct folio *folio)
 {
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
 	struct page *page = folio_page(folio, 0);
 	kvm_pfn_t pfn = page_to_pfn(page);
 	int order = folio_order(folio);
 
 	kvm_arch_gmem_invalidate(pfn, pfn + (1ul << order));
-}
 #endif
 
+	if (folio_test_private(folio)) {
+		unsigned long start = (unsigned long)folio_address(folio);
+
+		int r = set_direct_map_valid_noflush(folio_page(folio, 0), folio_nr_pages(folio),
+						     true);
+		/*
+		 * There might be holes left in the folio, better make sure
+		 * nothing tries to touch it again.
+		 */
+		if (r)
+			folio_set_hwpoison(folio);
+
+		flush_tlb_kernel_range(start, start + folio_size(folio));
+	}
+}
+
 static const struct address_space_operations kvm_gmem_aops = {
 	.dirty_folio = noop_dirty_folio,
 	.migrate_folio	= kvm_gmem_migrate_folio,
 	.error_remove_folio = kvm_gmem_error_folio,
-#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
 	.free_folio = kvm_gmem_free_folio,
-#endif
 };
 
 static int kvm_gmem_getattr(struct mnt_idmap *idmap, const struct path *path,
@@ -401,6 +511,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 {
 	const char *anon_name = "[kvm-gmem]";
 	struct kvm_gmem *gmem;
+	struct kvm_gmem_inode_private *gmem_priv;
 	struct inode *inode;
 	struct file *file;
 	int fd, err;
@@ -409,11 +520,14 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 	if (fd < 0)
 		return fd;
 
+	err = -ENOMEM;
 	gmem = kzalloc(sizeof(*gmem), GFP_KERNEL);
-	if (!gmem) {
-		err = -ENOMEM;
+	if (!gmem)
+		goto err_fd;
+
+	gmem_priv = kzalloc(sizeof(*gmem_priv), GFP_KERNEL);
+	if (!gmem_priv)
 		goto err_fd;
-	}
 
 	file = anon_inode_create_getfile(anon_name, &kvm_gmem_fops, gmem,
 					 O_RDWR, NULL);
@@ -427,7 +541,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 	inode = file->f_inode;
 	WARN_ON(file->f_mapping != inode->i_mapping);
 
-	inode->i_private = (void *)(unsigned long)flags;
+	inode->i_private = gmem_priv;
 	inode->i_op = &kvm_gmem_iops;
 	inode->i_mapping->a_ops = &kvm_gmem_aops;
 	inode->i_mode |= S_IFREG;
@@ -442,6 +556,9 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 	xa_init(&gmem->bindings);
 	list_add(&gmem->entry, &inode->i_mapping->i_private_list);
 
+	xa_init(&gmem_priv->direct_map_state);
+	gmem_priv->flags = flags;
+
 	fd_install(fd, file);
 	return fd;
 
@@ -456,11 +573,14 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
 {
 	loff_t size = args->size;
 	u64 flags = args->flags;
-	u64 valid_flags = 0;
+	u64 valid_flags = KVM_GMEM_NO_DIRECT_MAP;
 
 	if (flags & ~valid_flags)
 		return -EINVAL;
 
+	if ((flags & KVM_GMEM_NO_DIRECT_MAP) && !can_set_direct_map())
+		return -EOPNOTSUPP;
+
 	if (size <= 0 || !PAGE_ALIGNED(size))
 		return -EINVAL;
 
@@ -679,7 +799,6 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src, long
 			break;
 		}
 
-		folio_unlock(folio);
 		WARN_ON(!IS_ALIGNED(gfn, 1 << max_order) ||
 			(npages - i) < (1 << max_order));
 
@@ -695,7 +814,8 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src, long
 		p = src ? src + i * PAGE_SIZE : NULL;
 		ret = post_populate(kvm, gfn, pfn, p, max_order, opaque);
 		if (!ret)
-			kvm_gmem_mark_prepared(folio);
+			ret = kvm_gmem_finalize_folio(folio);
+		folio_unlock(folio);
 
 put_folio_and_exit:
 		folio_put(folio);
-- 
2.47.0


