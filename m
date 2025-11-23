Return-Path: <linux-kselftest+bounces-46345-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41092C7DFA2
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 11:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18F154E4673
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 10:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6420F2D3A70;
	Sun, 23 Nov 2025 10:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBrZFSOb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E002C15A5;
	Sun, 23 Nov 2025 10:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763893654; cv=none; b=tt92Ut4pDiTTytPc945sDtEs1i1su6bSeWGZii9yrRhX9ViN6YrGMLcnTT0AcPPvuMDlwoliRtv6b3pOXFVogx4rI0OgtufrV7G9Qm8l+hS+OxcoUA3syEHkTc77KLSVMN/oQ6I15LxNQnvJSG8TKPb/pvNHV57kYv03ieC0gJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763893654; c=relaxed/simple;
	bh=TGp6vvbLTdhwYnCuBgb7XJ6N0yTp/sgeTzqO6gH5CkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUl7oikWjC6WmU8GXbmyQXHK5x8b0J7rK9QyDeObA/ybFFukI43ADyoJhq18FcNxD+NMhdskRAj7p+U+A6j5j8IMiRV77RBcVSyKOVxoF6C/71WWhnBLedeadovaaLGFbFWzr8/uQhSSlmJOvPbMgS60Q9D+YxdJd61z/lslVsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBrZFSOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B67C113D0;
	Sun, 23 Nov 2025 10:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763893653;
	bh=TGp6vvbLTdhwYnCuBgb7XJ6N0yTp/sgeTzqO6gH5CkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OBrZFSObtudrp9MGuTQx1JbCUW5/SlKmBilfqqt7cVta7+2osmrx6ZyWfiBxv7L+S
	 mv/oSxzGa9Pj5oyj6UeFbBqXqa/DnMTvwBT/sA1csuz0mHlB89qW61bP7HwGxsGmg9
	 F0BrGRGIL6+ooQN6dT1CUYLo5WiQmeqG2J4vOJ4YlPKml3KDHUbncQtw2KIOgD+gK3
	 n33A0tSjubrO9zwq2egBfRT0z9/XLeBTBTRDwuZmtjoAnb2WM7jM2hA1KBwKkJzB8+
	 tuj7yk1fsO69UQ/8E3JifeiIs6M9V5DAx1SDwyL5RS6CqOcD86pyfDzyQs5eYwe59O
	 xR3EW4IXNx/xw==
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
Subject: [PATCH 3/5] mm: introduce VM_FAULT_UFFD_MINOR fault reason
Date: Sun, 23 Nov 2025 12:27:05 +0200
Message-ID: <20251123102707.559422-4-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251123102707.559422-1-rppt@kernel.org>
References: <20251123102707.559422-1-rppt@kernel.org>
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

Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/mm_types.h | 3 +++
 mm/memory.c              | 2 ++
 mm/shmem.c               | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 90e5790c318f..eb135369940f 100644
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
@@ -1540,6 +1542,7 @@ enum vm_fault_reason {
 	VM_FAULT_DONE_COW       = (__force vm_fault_t)0x001000,
 	VM_FAULT_NEEDDSYNC      = (__force vm_fault_t)0x002000,
 	VM_FAULT_COMPLETED      = (__force vm_fault_t)0x004000,
+	VM_FAULT_UFFD_MINOR	= (__force vm_fault_t)0x008000,
 	VM_FAULT_HINDEX_MASK    = (__force vm_fault_t)0x0f0000,
 };
 
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
index aaa21bb60f51..6dcb73b52bcc 100644
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


