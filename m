Return-Path: <linux-kselftest+bounces-45737-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A5CC63ECA
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 12:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A4943B09DD
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 11:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E90532C321;
	Mon, 17 Nov 2025 11:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rf/8XkGu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F1832B98E;
	Mon, 17 Nov 2025 11:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763380017; cv=none; b=bOyYkEb0jM43Jf3NXku0qd3XMF8e8CwAgMI/PNwrXDdmRfIaU2yGGHz7lbmtJed+EIPT5hSCuHzO6L2oKE6UUPWMf1obTdZG4qUgYNO+q36eEelkJ/yT/2XTZHtbLGwl4p9d0e1fDpGLtgqgFrMkLT0TGU5iJuddqLw+mhb1g5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763380017; c=relaxed/simple;
	bh=tJnQnmAt6Wvr+31OW1+YrQRyI6HqICukDnZlnmjRypc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KBBe4FrJ3XejrwMi/bCQ+5fMZ7XG48Xi4I0jcYEO8GhdVcERE87TshHvttow8hyLzynGW23XPgejYzNVVubF01x3ghGbUB8P/CxbhlyZLbNDxKlAXFTBHKV65UC9wQ/FcdBODDDZm5LaNJbXX3HvK1O/GrEOTD/9OXk4V/jfvhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rf/8XkGu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC696C19424;
	Mon, 17 Nov 2025 11:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763380016;
	bh=tJnQnmAt6Wvr+31OW1+YrQRyI6HqICukDnZlnmjRypc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rf/8XkGuM+tcAn7TrAR0d2+5u5uqFi1D2E8h6j3T7SAafDrHya+wVSKsW2gDh1b5y
	 K2+2fvSNEgBJHtSSo8PvpHFVe0MRhtZLUgUDyM5oiLcdphrXC9eA/jZDjbPZAaTrRo
	 rDSRA5Fyu+Mc6vvW0F485NTJQU5MHTAXSiDwm8yfmUXEags6P5SK3CBc6Bq3cLDWM1
	 x3SoyKBJLLxA5hA/COB0/KXlRKgglY6gJt1CaBK5SHXRz5JwsqEW3ruUzmlPsYRe4g
	 rCHLAeIKpe0YthRimRzIIgMr1b2m69ExF0wnE+iXlAn+vU8WTSITB0irmna3kmD7K1
	 20YszAdK1urcw==
From: Mike Rapoport <rppt@kernel.org>
To: linux-mm@kvack.org
Cc: Andrea Arcangeli <aarcange@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 3/4] userfaultfd, guest_memfd: support userfault minor mode in guest_memfd
Date: Mon, 17 Nov 2025 13:46:30 +0200
Message-ID: <20251117114631.2029447-4-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251117114631.2029447-1-rppt@kernel.org>
References: <20251117114631.2029447-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

* Export handle_userfault() for KVM module so that fault() handler in
  guest_memfd would be able to notify userspace about page faults in its
  address space.
* Implement get_pagecache_folio() for guest_memfd.
* And finally, introduce UFFD_FEATURE_MINOR_GENERIC that will allow
  using userfaultfd minor mode with memory types other than shmem and
  hugetlb provided they are allowed to call handle_userfault() and
  implement get_pagecache_folio().

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 fs/userfaultfd.c                 |  4 +++-
 include/uapi/linux/userfaultfd.h |  8 +++++++-
 virt/kvm/guest_memfd.c           | 30 ++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 54c6cc7fe9c6..964fa2662d5c 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -537,6 +537,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 out:
 	return ret;
 }
+EXPORT_SYMBOL_FOR_MODULES(handle_userfault, "kvm");
 
 static void userfaultfd_event_wait_completion(struct userfaultfd_ctx *ctx,
 					      struct userfaultfd_wait_queue *ewq)
@@ -1978,7 +1979,8 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 	uffdio_api.features = UFFD_API_FEATURES;
 #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
 	uffdio_api.features &=
-		~(UFFD_FEATURE_MINOR_HUGETLBFS | UFFD_FEATURE_MINOR_SHMEM);
+		~(UFFD_FEATURE_MINOR_HUGETLBFS | UFFD_FEATURE_MINOR_SHMEM |
+		  UFFD_FEATURE_MINOR_GENERIC);
 #endif
 #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_WP
 	uffdio_api.features &= ~UFFD_FEATURE_PAGEFAULT_FLAG_WP;
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index 2841e4ea8f2c..c5cbd4a5a26e 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -42,7 +42,8 @@
 			   UFFD_FEATURE_WP_UNPOPULATED |	\
 			   UFFD_FEATURE_POISON |		\
 			   UFFD_FEATURE_WP_ASYNC |		\
-			   UFFD_FEATURE_MOVE)
+			   UFFD_FEATURE_MOVE |			\
+			   UFFD_FEATURE_MINOR_GENERIC)
 #define UFFD_API_IOCTLS				\
 	((__u64)1 << _UFFDIO_REGISTER |		\
 	 (__u64)1 << _UFFDIO_UNREGISTER |	\
@@ -210,6 +211,10 @@ struct uffdio_api {
 	 * UFFD_FEATURE_MINOR_SHMEM indicates the same support as
 	 * UFFD_FEATURE_MINOR_HUGETLBFS, but for shmem-backed pages instead.
 	 *
+	 * UFFD_FEATURE_MINOR_GENERIC indicates that minor faults can be
+	 * intercepted for file-backed memory in case subsystem backing this
+	 * memory supports it.
+	 *
 	 * UFFD_FEATURE_EXACT_ADDRESS indicates that the exact address of page
 	 * faults would be provided and the offset within the page would not be
 	 * masked.
@@ -248,6 +253,7 @@ struct uffdio_api {
 #define UFFD_FEATURE_POISON			(1<<14)
 #define UFFD_FEATURE_WP_ASYNC			(1<<15)
 #define UFFD_FEATURE_MOVE			(1<<16)
+#define UFFD_FEATURE_MINOR_GENERIC		(1<<17)
 	__u64 features;
 
 	__u64 ioctls;
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index fbca8c0972da..5e3c63307fdf 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -4,6 +4,7 @@
 #include <linux/kvm_host.h>
 #include <linux/pagemap.h>
 #include <linux/anon_inodes.h>
+#include <linux/userfaultfd_k.h>
 
 #include "kvm_mm.h"
 
@@ -369,6 +370,12 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
 		return vmf_error(err);
 	}
 
+	if (userfaultfd_minor(vmf->vma)) {
+		folio_unlock(folio);
+		folio_put(folio);
+		return handle_userfault(vmf, VM_UFFD_MINOR);
+	}
+
 	if (WARN_ON_ONCE(folio_test_large(folio))) {
 		ret = VM_FAULT_SIGBUS;
 		goto out_folio;
@@ -390,8 +397,31 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
 	return ret;
 }
 
+#ifdef CONFIG_USERFAULTFD
+static struct folio *kvm_gmem_get_pagecache_folio(struct vm_area_struct *vma,
+						  pgoff_t pgoff)
+{
+	struct inode *inode = file_inode(vma->vm_file);
+	struct folio *folio;
+
+	folio = kvm_gmem_get_folio(inode, pgoff);
+	if (IS_ERR_OR_NULL(folio))
+		return folio;
+
+	if (!folio_test_uptodate(folio)) {
+		clear_highpage(folio_page(folio, 0));
+		kvm_gmem_mark_prepared(folio);
+	}
+
+	return folio;
+}
+#endif
+
 static const struct vm_operations_struct kvm_gmem_vm_ops = {
 	.fault = kvm_gmem_fault_user_mapping,
+#ifdef CONFIG_USERFAULTFD
+	.get_pagecache_folio	= kvm_gmem_get_pagecache_folio,
+#endif
 };
 
 static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
-- 
2.50.1


