Return-Path: <linux-kselftest+bounces-46346-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40419C7DF9F
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 11:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11EC13AA4B6
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 10:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221E72D323D;
	Sun, 23 Nov 2025 10:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYSK81Np"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99602C15A5;
	Sun, 23 Nov 2025 10:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763893660; cv=none; b=RfHTt3hic/qi1xIB9NpOMB8UIkcyLbw693op9T8nlnJdp4aGVRPzgBc0n/VGwecE+ZCF5/DHvgySiC8d7VcnQxZCfWf0ikG9cGnZJH2fQU1kWPU8L3tEO84/P10T8TULoRk9iPiKH9idrFNb2mQLKTBCuPVPt9B4VEDi1cXUNzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763893660; c=relaxed/simple;
	bh=MXDXjuuhIpZHs+XYyAm2UYANZTzUP59bGHx0lNGyMTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVtzlt0+xEQgguPwEICLQ4u12RkzhtNws0Y9Vaai1hOYeN/0tmEQMSd12afrd1/yM1Q6DjD4aQCCi1PJywQW29qjovrOuw2eKsmLgQOW8noFOubsXUA73ETbWOzuPxVHfqqHw0ZY4qGUDV2oLzguN3JcAXulB73oHTdVD1vgBUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYSK81Np; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2FEC116B1;
	Sun, 23 Nov 2025 10:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763893659;
	bh=MXDXjuuhIpZHs+XYyAm2UYANZTzUP59bGHx0lNGyMTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QYSK81NpxPj/kDa8lMOmb3+46yyatrhh+rNN14oIxkrCYIRITAi/b2OTiIBwhhCAe
	 KvuIOxmtBaiOruzKv4YnQ8Yl73mtzm1ZPpgsYYNidZZRzpZs0D+EppnHN40aka2OWI
	 lEK7xsO1APEy1LR9TPhI9pp0z6QXZ7QlGR3oKwjuI9vF0HOa6cpEfDITH63MUAmuBc
	 yrxOjuoi6YB0ZUHcZt3rztmUddq1h8E7yISE3rT/5hSrsRFKEt5XBQ6rLTQIYHQjAs
	 xLUOu+eDypuj3X6zRq9GTnrVotfkjiqDbESJa6wh8+Boc/YnhARPWO+kEubD6qwfIh
	 LR7yFXyv89ZPA==
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
Subject: [PATCH 4/5] guest_memfd: add support for userfaultfd minor mode
Date: Sun, 23 Nov 2025 12:27:06 +0200
Message-ID: <20251123102707.559422-5-rppt@kernel.org>
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
 virt/kvm/guest_memfd.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index ffadc5ee8e04..bc8337f104ce 100644
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
@@ -390,8 +397,30 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
 	return ret;
 }
 
+#ifdef CONFIG_USERFAULTFD
+static struct folio *kvm_gmem_get_shared_folio(struct inode *inode,
+					       pgoff_t pgoff)
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
+	.get_shared_folio	= kvm_gmem_get_shared_folio,
+#endif
 };
 
 static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
-- 
2.50.1


