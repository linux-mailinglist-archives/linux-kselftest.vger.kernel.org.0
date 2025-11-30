Return-Path: <linux-kselftest+bounces-46758-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA810C94EFA
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 12:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC9C54E231D
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 11:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116AB285058;
	Sun, 30 Nov 2025 11:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ha1VpMPt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA76284883;
	Sun, 30 Nov 2025 11:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764501524; cv=none; b=fkPNRrUMHwQ0c1JwjTeLTaELt44x8z+tDXozUOmg8A2m83awWVEPbCoJ4aPw2EfpcOmrn1Iwfm8bwrukudBloU7CqEdKF7n+rcXdMCQPCig/P8sp0ZQV9uEk67vVJ3lrQqewH6tAyPhXkA5NxMJmMr1scRkQUEjbUC2QCJeBMHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764501524; c=relaxed/simple;
	bh=02TV+J21aRh8Y7GHD/quPCqz9iq/kEt5UBYeya9wXbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpwMmBfdoYLpIfkbjlpFF/sS8Up7fXVrveGXmyqGFVp/5x2raiY5/3swy88YUUypYpqntb3+jg13AJK+5CLHx2HDpF34/gun3CmBVPJtN17vf2f7vyeEUGqEJstX/Bpd7ASl6PmtdrKqCXz6KfFDjb1U1B+CJqToxBDXxsGcKRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ha1VpMPt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8BCC116B1;
	Sun, 30 Nov 2025 11:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764501523;
	bh=02TV+J21aRh8Y7GHD/quPCqz9iq/kEt5UBYeya9wXbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ha1VpMPtHwMP3wcPEvYjsA/TXMScV1CPNuo/cC5Lu3DHFteFKJfHohkZUPQKy0KVH
	 Jz15kY7NsoNnb2ifdGn0TVWvzfZyhLUyxG/9gwIiLivBDv2L+6NlrOm5HO7uAQ94VQ
	 W43OZVat768mPtgYQldsGVGP+DmrQ8p0eWovjw7NXQrngRyeR+P0y9W6NokDg6dW8c
	 WIecaNNGhqHcEWomX9JH4q2tcK5gXHSoUMT8n5MUCD6/p4ACgXX3jGubo4z7Y/nL96
	 nIZjMnQQSlLbYLMkRCy4SeLc/cuF1vSR8fRe2LRWKD8ko4jltWC0qCn1GUXPbYN46g
	 CtYKcNVHiSLtg==
From: Mike Rapoport <rppt@kernel.org>
To: linux-mm@kvack.org
Cc: Andrea Arcangeli <aarcange@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	James Houghton <jthoughton@google.com>,
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
Subject: [PATCH v3 4/5] guest_memfd: add support for userfaultfd minor mode
Date: Sun, 30 Nov 2025 13:18:11 +0200
Message-ID: <20251130111812.699259-5-rppt@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251130111812.699259-1-rppt@kernel.org>
References: <20251130111812.699259-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

userfaultfd notifications about minor page faults used for live migration
and snapshotting of VMs with memory backed by shared hugetlbfs or tmpfs
mappings as described in detail in commit 7677f7fd8be7 ("userfaultfd: add
minor fault registration mode").

To use the same mechanism for VMs that use guest_memfd to map their memory,
guest_memfd should support userfaultfd minor mode.

Extend ->fault() method of guest_memfd with ability to notify core page
fault handler that a page fault requires handle_userfault(VM_UFFD_MINOR) to
complete and add implementation of ->get_folio_noalloc() to guest_memfd
vm_ops.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 virt/kvm/guest_memfd.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index ffadc5ee8e04..dca6e373937b 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -4,6 +4,7 @@
 #include <linux/kvm_host.h>
 #include <linux/pagemap.h>
 #include <linux/anon_inodes.h>
+#include <linux/userfaultfd_k.h>
 
 #include "kvm_mm.h"
 
@@ -359,7 +360,15 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
 	if (!((u64)inode->i_private & GUEST_MEMFD_FLAG_INIT_SHARED))
 		return VM_FAULT_SIGBUS;
 
-	folio = kvm_gmem_get_folio(inode, vmf->pgoff);
+	folio = filemap_lock_folio(inode->i_mapping, vmf->pgoff);
+	if (!IS_ERR_OR_NULL(folio) && userfaultfd_minor(vmf->vma)) {
+		ret = VM_FAULT_UFFD_MINOR;
+		goto out_folio;
+	}
+
+	if (PTR_ERR(folio) == -ENOENT)
+		folio = kvm_gmem_get_folio(inode, vmf->pgoff);
+
 	if (IS_ERR(folio)) {
 		int err = PTR_ERR(folio);
 
@@ -390,8 +399,30 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
 	return ret;
 }
 
+#ifdef CONFIG_USERFAULTFD
+static struct folio *kvm_gmem_get_folio_noalloc(struct inode *inode,
+						pgoff_t pgoff)
+{
+	struct folio *folio;
+
+	folio = filemap_lock_folio(inode->i_mapping, pgoff);
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
+	.get_folio_noalloc	= kvm_gmem_get_folio_noalloc,
+#endif
 };
 
 static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
-- 
2.51.0


