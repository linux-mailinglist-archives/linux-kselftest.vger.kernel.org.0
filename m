Return-Path: <linux-kselftest+bounces-28056-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 780F3A4C200
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 14:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6159D1627D9
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 13:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D693821322F;
	Mon,  3 Mar 2025 13:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rXnVLjtr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F80211491;
	Mon,  3 Mar 2025 13:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741008681; cv=none; b=aHwnm1gniDT1hjGzk3Ok4FTjM0dGw/lqvkNqcU3kMKjw2KvDdnQug1XP42Vs2vNzojBDB2Ck+oprSmMjxSlUyVDEJDII63Hx6wxH5hCZ5s+BGtSDbAkVrbT0wgodqAxgZBP/0dmdngKDb4//aa0QN7wTcrfU1URI2PhX4vPzVIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741008681; c=relaxed/simple;
	bh=OkqqRo0IbFH81I+Mj1ghNzX9j1deQ4VMO3aCHBD6vkw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gF83RWIIKsu1H/USxzkgCeVlB/aZqDGz+qFKSkqtx1OFbqCKb8cswpW/zp6t0RwZXfa5arZbu/CBi2wR3qmlDzNbMyUPOrT6R1VNgBjub47a8aziqDL9mJsiECVOiGBrEzzMlwuIYFl9VuEkLnevUiTXa/FCGbtd1dhkMtRT2lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=rXnVLjtr; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741008680; x=1772544680;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JIXEK8fZmfp3pTHcHhhnyrOSlMvjIkeSF6WjbQ+OQL4=;
  b=rXnVLjtrQ3ZiAxemifjuboxOG4rjR6dO0H5uwAlhAHHHfod337Hvf1mJ
   gzCBNlgNp0pF2AmFL8MmXW3iGYXyhKUFq0Lw/PeTpMbLxzhxk3ZWL8ltf
   2eg54ktUP5tWb8bF5dQbnyMWlQFvbFiTKXub00RYpAnMA5AFQp5633ql2
   g=;
X-IronPort-AV: E=Sophos;i="6.13,329,1732579200"; 
   d="scan'208";a="174959912"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 13:31:17 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:29532]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.9.61:2525] with esmtp (Farcaster)
 id 1338de01-a28d-410f-a789-9dc43131ae5f; Mon, 3 Mar 2025 13:31:16 +0000 (UTC)
X-Farcaster-Flow-ID: 1338de01-a28d-410f-a789-9dc43131ae5f
Received: from EX19D003UWB004.ant.amazon.com (10.13.138.24) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 3 Mar 2025 13:31:08 +0000
Received: from EX19MTAUWC002.ant.amazon.com (10.250.64.143) by
 EX19D003UWB004.ant.amazon.com (10.13.138.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 3 Mar 2025 13:31:07 +0000
Received: from email-imr-corp-prod-pdx-all-2c-785684ef.us-west-2.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 13:31:07 +0000
Received: from dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com (dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com [172.19.103.116])
	by email-imr-corp-prod-pdx-all-2c-785684ef.us-west-2.amazon.com (Postfix) with ESMTPS id 27701A1025;
	Mon,  3 Mar 2025 13:31:05 +0000 (UTC)
From: Nikita Kalyazin <kalyazin@amazon.com>
To: <akpm@linux-foundation.org>, <pbonzini@redhat.com>, <shuah@kernel.org>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<lorenzo.stoakes@oracle.com>, <david@redhat.com>, <ryan.roberts@arm.com>,
	<quic_eberman@quicinc.com>, <jthoughton@google.com>, <peterx@redhat.com>,
	<graf@amazon.de>, <jgowans@amazon.com>, <roypat@amazon.co.uk>,
	<derekmn@amazon.com>, <nsaenz@amazon.es>, <xmarcalx@amazon.com>,
	<kalyazin@amazon.com>
Subject: [RFC PATCH 4/5] mm: userfaultfd: support continue for guest_memfd
Date: Mon, 3 Mar 2025 13:30:10 +0000
Message-ID: <20250303133011.44095-5-kalyazin@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250303133011.44095-1-kalyazin@amazon.com>
References: <20250303133011.44095-1-kalyazin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

When userspace receives a page missing event, it is supposed to populate
the missing page in guest_memfd pagecache via the write syscall and
unblock the faulting process via UFFDIO_CONTINUE.

Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
---
 mm/userfaultfd.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index af3dfc3633db..aaff66a7f15b 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -19,6 +19,10 @@
 #include <asm/tlb.h>
 #include "internal.h"
 
+#ifdef CONFIG_KVM_PRIVATE_MEM
+bool kvm_gmem_vma_is_gmem(struct vm_area_struct *vma);
+#endif
+
 static __always_inline
 bool validate_dst_vma(struct vm_area_struct *dst_vma, unsigned long dst_end)
 {
@@ -391,6 +395,16 @@ static int mfill_atomic_pte_continue(pmd_t *dst_pmd,
 	struct page *page;
 	int ret;
 
+#ifdef CONFIG_KVM_PRIVATE_MEM
+	if (kvm_gmem_vma_is_gmem(dst_vma)) {
+		ret = 0;
+		folio = filemap_get_entry(inode->i_mapping, pgoff);
+		if (IS_ERR(folio))
+			ret = PTR_ERR(folio);
+		else
+			folio_lock(folio);
+	} else
+#endif
 	ret = shmem_get_folio(inode, pgoff, 0, &folio, SGP_NOALLOC);
 	/* Our caller expects us to return -EFAULT if we failed to find folio */
 	if (ret == -ENOENT)
@@ -769,9 +783,16 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 		return  mfill_atomic_hugetlb(ctx, dst_vma, dst_start,
 					     src_start, len, flags);
 
-	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
+	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma)
+#ifdef CONFIG_KVM_PRIVATE_MEM
+		&& !kvm_gmem_vma_is_gmem(dst_vma)
+#endif
+	)
 		goto out_unlock;
 	if (!vma_is_shmem(dst_vma) &&
+#ifdef CONFIG_KVM_PRIVATE_MEM
+		!kvm_gmem_vma_is_gmem(dst_vma) &&
+#endif
 	    uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
 		goto out_unlock;
 
-- 
2.47.1


