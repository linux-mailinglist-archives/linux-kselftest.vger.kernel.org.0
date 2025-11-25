Return-Path: <linux-kselftest+bounces-46462-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FE5C86AD5
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 19:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B20A4E9E0D
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 18:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7247332EC7;
	Tue, 25 Nov 2025 18:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qm3Cjfzj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896FA332900;
	Tue, 25 Nov 2025 18:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764095953; cv=none; b=HNBoPVuWNwcjLIVzUg89jFN3LL2qcJIotgurxLLfNMQ+GLlSDqCEYW4HrgKeNiZarL3+ffYZwsqWy4KgxiG5TggyKlbWkZzeCDjXNHnPC8aTGq8f3hyqyhgrW272Kw14zZHPNlA88eqO6GZMoUXNK+8V6QihcEAHVCmm/+5IJms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764095953; c=relaxed/simple;
	bh=jqifh5t0Rt8qTazlUsu/nX1gF506d7+nFIH7n1shvtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aT0VM4mChvk+OyZm3J5Jjw0RlN3NRgH5tRdNu4Go4bS07zTgnOpxNYJ6m2yLGmAmAQilLBiacit6eniszRnmrHrVgVM63Ax5FKVhs/Gk7fCxuTG/jSUBthueunonDSl37KrdW3jHidHIiizbRUo5gIsD3e3ATcGjcZRvYvPJZYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qm3Cjfzj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56CAC19421;
	Tue, 25 Nov 2025 18:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764095953;
	bh=jqifh5t0Rt8qTazlUsu/nX1gF506d7+nFIH7n1shvtc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qm3Cjfzj8WChKet9OWJqezTAxzJgADW07+5ssosubSVDSSkVlspT+QzKiUOojaYGg
	 FrjtWZQZHpHKNQlvk5EDdMKuYhjXa/XF0HB+RQPd8t5xxrxsnJsUYgIP+2L4Q0PsxJ
	 3m0YGyHYvUThDC6vLoGXEAGbJVwa6nAkS3DVXWEnngznaYYWOnh+dcM9QG/rp7Dpdu
	 ihtCaL4elNO4E6DfA0X0jEqlk49d463z3baxRPuNTeSwECc5kJ85YBT+JkwCgOQnxT
	 erUYVbOv9PDEjlFyFJeXak/iZqoaV8LqMDeGchQ/r22Zoow3a2UAuqeZ8Ausudg3DV
	 VmIvT0E8NJP6w==
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
Subject: [PATCH v2 4/5] guest_memfd: add support for userfaultfd minor mode
Date: Tue, 25 Nov 2025 20:38:39 +0200
Message-ID: <20251125183840.2368510-5-rppt@kernel.org>
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

userfaultfd notifications about minor page faults used for live migration
and snapshotting of VMs with memory backed by shared hugetlbfs or tmpfs
mappings as described in detail in commit 7677f7fd8be7 ("userfaultfd: add
minor fault registration mode").

To use the same mechanism for VMs that use guest_memfd to map their memory,
guest_memfd should support userfaultfd minor mode.

Extend ->fault() method of guest_memfd with ability to notify core page
fault handler that a page fault requires handle_userfault(VM_UFFD_MINOR) to
complete and add implementation of ->get_shared_folio() to guest_memfd
vm_ops.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 virt/kvm/guest_memfd.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index ffadc5ee8e04..2a2b076293f9 100644
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
+		return VM_FAULT_UFFD_MINOR;
+	}
+
 	if (WARN_ON_ONCE(folio_test_large(folio))) {
 		ret = VM_FAULT_SIGBUS;
 		goto out_folio;
@@ -390,8 +397,29 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
 	return ret;
 }
 
+#ifdef CONFIG_USERFAULTFD
+static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t pgoff)
+{
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
+	.get_folio	= kvm_gmem_get_folio,
+#endif
 };
 
 static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
-- 
2.50.1


