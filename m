Return-Path: <linux-kselftest+bounces-46757-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2367C94EF1
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 12:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A21D3A4791
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 11:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AF8283FEF;
	Sun, 30 Nov 2025 11:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTEOZ3Eu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A871E27A10F;
	Sun, 30 Nov 2025 11:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764501518; cv=none; b=gqtHnRvOp3BWk7bYMmrd1wb6qmuclilVO1X1h6OR0/nbr6jnM0x4rXADW8QZu5VGMLfNV9QtSOEbqKgHVfV/ytIXjgM5oGPlLa7FZx7/OP3reVMQ+lKs+W21yfr/mdiO7awcMCYtIIWz0hPEp9Volc3iihPzIiH/JcTj3rXHoto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764501518; c=relaxed/simple;
	bh=kn1TtLxUvl6eK2HP+wAu3G67BEAmX/GRyBo9yQ844/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uUVycJU35+Mzq4loUp6vA++lhbXC7CfcJJHAFxztJ6svxTm43or2P/c54AdKueKDx7zOBrilzimBqEn8VIbk98OidprymHBOO4ZK+eA10UCqdSmuhXqUnUIJRBK6eP40NogVy8WxcNItYTpK3UtD3QLty/ZPkPi1GRe3Q1hF5yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTEOZ3Eu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FF8C4CEF8;
	Sun, 30 Nov 2025 11:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764501518;
	bh=kn1TtLxUvl6eK2HP+wAu3G67BEAmX/GRyBo9yQ844/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GTEOZ3Eu7EhOOpw0QceVSQ+bNm50XMZUIp8tcd4Zgvs0pWvWMI60KTlM1/2qOsjs8
	 0QNc7mcCdeh+ZYHJdpxS3KVSQ/SnooeWvfX+xjVwFwOh4Ayxh+9nNH2/z4SVTQ2tru
	 XyufTc0QVGWP4mrQ1s+rWBm3P5+VvAxusEBYIHg43KX0tY4wWgDncOlh2ocwiBSqYe
	 Gj8ZzBLL92wwmYW1GSIbx7rQtkZp+Ed1rAhaF7XuAsqylo7q5xqWa9fqzLfpNrRXho
	 f84MYsqTzz/pbvZL+4dlHYdlYCUFxPVyZXIS9nNk422W47CGVnoXf9AyAZRUfhrIhP
	 +UKoQejLcsRGg==
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
Subject: [PATCH v3 3/5] mm: introduce VM_FAULT_UFFD_MINOR fault reason
Date: Sun, 30 Nov 2025 13:18:10 +0200
Message-ID: <20251130111812.699259-4-rppt@kernel.org>
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

When a VMA is registered with userfaulfd in minor mode, its ->fault()
method should check if a folio exists in the page cache and if yes
->fault() should call handle_userfault(VM_UFFD_MINOR).

Instead of calling handle_userfault() directly from a specific ->fault()
implementation introduce new fault reason VM_FAULT_UFFD_MINOR that will
notify the core page fault handler that it should call
handle_userfaultfd(VM_UFFD_MINOR) to complete a page fault.

Replace a call to handle_userfault(VM_UFFD_MINOR) in shmem and use the
new VM_FAULT_UFFD_MINOR there instead.

For configurations that don't enable CONFIG_USERFAULTFD,
VM_FAULT_UFFD_MINOR is set to 0.

Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/mm_types.h | 10 +++++++++-
 mm/memory.c              |  5 ++++-
 mm/shmem.c               |  2 +-
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 90e5790c318f..c92a52c572c3 100644
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
+	{ VM_FAULT_UFFD_MINOR,		"UFFD_MINOR" }	\
 
 struct vm_special_mapping {
 	const char *name;	/* The name, e.g. "[vdso]". */
diff --git a/mm/memory.c b/mm/memory.c
index b59ae7ce42eb..8d2180ec6933 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5280,8 +5280,11 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
 
 	ret = vma->vm_ops->fault(vmf);
 	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY |
-			    VM_FAULT_DONE_COW)))
+			    VM_FAULT_DONE_COW | VM_FAULT_UFFD_MINOR))) {
+		if (ret & VM_FAULT_UFFD_MINOR)
+			return handle_userfault(vmf, VM_UFFD_MINOR);
 		return ret;
+	}
 
 	folio = page_folio(vmf->page);
 	if (unlikely(PageHWPoison(vmf->page))) {
diff --git a/mm/shmem.c b/mm/shmem.c
index 9f8c54ad0e32..2c32e2398e99 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2460,7 +2460,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 	if (folio && vma && userfaultfd_minor(vma)) {
 		if (!xa_is_value(folio))
 			folio_put(folio);
-		*fault_type = handle_userfault(vmf, VM_UFFD_MINOR);
+		*fault_type = VM_FAULT_UFFD_MINOR;
 		return 0;
 	}
 
-- 
2.51.0


