Return-Path: <linux-kselftest+bounces-46461-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B2FC86AD2
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 19:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD80A3B0ACB
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 18:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F22A332EB6;
	Tue, 25 Nov 2025 18:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+rjAQwX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72240332900;
	Tue, 25 Nov 2025 18:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764095947; cv=none; b=VKeoI9RXXBUK42x5MlFL+Aud4AmwxzBBM7t5k/EoLXM9FYCwYC90EosUGgKnq8/2Al8Px26y17DfQaGcS+ZlTxnbvQqAAetE1XHqaimh0kFbke00ZKdZSdAHFLkbfRZ7Kn9jWpKha1eBtZ0oA+9nqiE04QH09IyhRYUDm4SH6Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764095947; c=relaxed/simple;
	bh=OMs5feUckVCg3jntuqU22gZ/ufy0V9GaFPtJ4+nCsbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QPx1PXRQveFyNznk64KEMzfnD+LaVqjvVn4Lz2+Uh1i1NxjfU6e5eFgThTuYEGCBgdsjjiLihhtt7whCFbiTO5zCyMWEPpXn3f+OGRDisZ/OeK9fy/rJGHmQries7JLWC5zDyFtwiBfQENj6AkqM2vPHoAxL82EQJ0ppSSISvck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+rjAQwX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E139DC19422;
	Tue, 25 Nov 2025 18:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764095947;
	bh=OMs5feUckVCg3jntuqU22gZ/ufy0V9GaFPtJ4+nCsbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k+rjAQwX+9oyD23In9ooJMuiZlgSjVe7F3a6uIEgz1GZ4RWJmAVwRq1A3GX0F11g8
	 WpbUvXAxGYRUz92F99Q31i/6oM4ExJUMNRmsybLKQme98QngVmtlLHeXJ8Td9Av+WA
	 lR1AWyV+or429S5CqW7LTi+L5VVrghZlv+Hv9eOyXNrWjN4+Jv6fllrLCy+6dK4hXc
	 J7LSRDv/TDGREvUaiVhFkFF6O5aSi9KW8pDWeVgykB4wU5N6LDOWfpObOmg2NG3s+h
	 4HxcYX0LT2C8ThnZbwWmQvS81JGFvtbFBrzs9A8Or9xTaLwr1yR1MLPG9UB8ZBlWMc
	 qhMk5fLNWc7mw==
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
	linux-kselftest@vger.kernel.org,
	"David Hildenbrand (Red Hat)" <david@kernel.org>
Subject: [PATCH v2 3/5] mm: introduce VM_FAULT_UFFD_MINOR fault reason
Date: Tue, 25 Nov 2025 20:38:38 +0200
Message-ID: <20251125183840.2368510-4-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251125183840.2368510-1-rppt@kernel.org>
References: <20251125183840.2368510-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

When a VMA is registered with userfaulfd in minor mode, its ->fault()
method should check if a folio exists in the page cache and if yes
->fault() should call handle_userfault(VM_UFFD_MISSING).

Instead of calling handle_userfault() directly from a specific ->fault()
implementation introduce new fault reason VM_FAULT_UFFD_MINOR that will
notify the core page fault handler that it should call
handle_userfaultfd(VM_UFFD_MISSING) to complete a page fault.

Replace a call to handle_userfault(VM_UFFD_MISSING) in shmem and use the
new VM_FAULT_UFFD_MINOR there instead.

For configurations that don't enable CONFIG_USERFAULTFD,
VM_FAULT_UFFD_MINOR is set to 0.

Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/mm_types.h | 10 +++++++++-
 mm/memory.c              |  2 ++
 mm/shmem.c               |  2 +-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 90e5790c318f..df71b057111b 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1523,6 +1523,8 @@ typedef __bitwise unsigned int vm_fault_t;
  *				fsync() to complete (for synchronous page faults
  *				in DAX)
  * @VM_FAULT_COMPLETED:		->fault completed, meanwhile mmap lock released
+ * @VM_FAULT_UFFD_MINOR:	->fault did not modify page tables and needs
+ *				handle_userfault(VM_UFFD_MINOR) to complete
  * @VM_FAULT_HINDEX_MASK:	mask HINDEX value
  *
  */
@@ -1540,6 +1542,11 @@ enum vm_fault_reason {
 	VM_FAULT_DONE_COW       = (__force vm_fault_t)0x001000,
 	VM_FAULT_NEEDDSYNC      = (__force vm_fault_t)0x002000,
 	VM_FAULT_COMPLETED      = (__force vm_fault_t)0x004000,
+#ifdef CONFIG_USERFAULTFD
+	VM_FAULT_UFFD_MINOR	= (__force vm_fault_t)0x008000,
+#else
+	VM_FAULT_UFFD_MINOR	= (__force vm_fault_t)0x000000,
+#endif
 	VM_FAULT_HINDEX_MASK    = (__force vm_fault_t)0x0f0000,
 };
 
@@ -1564,7 +1571,8 @@ enum vm_fault_reason {
 	{ VM_FAULT_FALLBACK,            "FALLBACK" },	\
 	{ VM_FAULT_DONE_COW,            "DONE_COW" },	\
 	{ VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" },	\
-	{ VM_FAULT_COMPLETED,           "COMPLETED" }
+	{ VM_FAULT_COMPLETED,           "COMPLETED" },	\
+	{ VM_FAULT_UFFD_MINOR,		"UFFD_MINOR" },	\
 
 struct vm_special_mapping {
 	const char *name;	/* The name, e.g. "[vdso]". */
diff --git a/mm/memory.c b/mm/memory.c
index b59ae7ce42eb..94acbac8cefb 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5279,6 +5279,8 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
 	}
 
 	ret = vma->vm_ops->fault(vmf);
+	if (unlikely(ret & VM_FAULT_UFFD_MINOR))
+		return handle_userfault(vmf, VM_UFFD_MINOR);
 	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY |
 			    VM_FAULT_DONE_COW)))
 		return ret;
diff --git a/mm/shmem.c b/mm/shmem.c
index e16c7c8c3e1e..a9a31c0b5979 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2461,7 +2461,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 	if (folio && vma && userfaultfd_minor(vma)) {
 		if (!xa_is_value(folio))
 			folio_put(folio);
-		*fault_type = handle_userfault(vmf, VM_UFFD_MINOR);
+		*fault_type = VM_FAULT_UFFD_MINOR;
 		return 0;
 	}
 
-- 
2.50.1


