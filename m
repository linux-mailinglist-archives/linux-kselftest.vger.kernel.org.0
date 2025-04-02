Return-Path: <linux-kselftest+bounces-30019-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C74A792AA
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 18:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C4537A3774
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 16:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F43158524;
	Wed,  2 Apr 2025 16:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nt75byU7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51481922C4;
	Wed,  2 Apr 2025 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743610064; cv=none; b=JDm7AXH6tODimv4eItWXBUaNoXhXX3xjaosHfyyz1uWSQ2tzFyJI8zXl59EpCoEfgSPi1V/vcvFYc0BtXqBfCcKn6Pq4RvsaEJhaYsfKj1HSrm0qwBte1qQZDt9LfEIGV7BxV8m5s2bvZ9s18jvMioArClzOxjQPOJqHWzGUGwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743610064; c=relaxed/simple;
	bh=Lv7wVjoRO8spVCCWXvdtS2iBrd7Df3Sl6qr/50zKPLM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s4YMSit695jf/f+Lw6t8qXObQNDr1RJrlf68ORMYVAaIWU0FbRJhidpOGyX4bz/5XacBrkDTs+IJHdvlXOrBDcBKRM36PCbnl8R//UjyxyfWHFSUmMjdHoMwo6qka1fgwojVqJ39qvGatxlne37Je5fa05XuCoU7IkmmWaM27aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=nt75byU7; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743610063; x=1775146063;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5WJu5FXIQjlvFzc2S3oagYQCTjwqOt8Vj/HqIU2A0PE=;
  b=nt75byU7TlWEwJNfmEK8CqCFlS+SDu9Z9ikr30VbtOLD3WsGrUxEztnU
   3NtU260SDi6CXCyOxnyilArqjuBG1pz8OiMbR0rIWgJZhewG+FjurR6fK
   bZgcLRQqc3D4hZkqjtj7pwL/G58VEQEcsGqvK6e5mN1jCO/+2ll8mJ9W+
   M=;
X-IronPort-AV: E=Sophos;i="6.15,182,1739836800"; 
   d="scan'208";a="710490762"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 16:07:38 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.10.100:19931]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.36.151:2525] with esmtp (Farcaster)
 id 5d4c3ca3-5bf6-48b9-9c8f-8b474d7042db; Wed, 2 Apr 2025 16:07:37 +0000 (UTC)
X-Farcaster-Flow-ID: 5d4c3ca3-5bf6-48b9-9c8f-8b474d7042db
Received: from EX19D022EUA001.ant.amazon.com (10.252.50.125) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 2 Apr 2025 16:07:36 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D022EUA001.ant.amazon.com (10.252.50.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 2 Apr 2025 16:07:36 +0000
Received: from email-imr-corp-prod-iad-all-1b-8410187a.us-east-1.amazon.com
 (10.43.8.6) by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Wed, 2 Apr 2025 16:07:36 +0000
Received: from dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com (dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com [172.19.103.116])
	by email-imr-corp-prod-iad-all-1b-8410187a.us-east-1.amazon.com (Postfix) with ESMTPS id 706BE40536;
	Wed,  2 Apr 2025 16:07:34 +0000 (UTC)
From: Nikita Kalyazin <kalyazin@amazon.com>
To: <akpm@linux-foundation.org>, <pbonzini@redhat.com>, <shuah@kernel.org>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<lorenzo.stoakes@oracle.com>, <david@redhat.com>, <ryan.roberts@arm.com>,
	<quic_eberman@quicinc.com>, <jthoughton@google.com>, <peterx@redhat.com>,
	<graf@amazon.de>, <jgowans@amazon.com>, <roypat@amazon.co.uk>,
	<derekmn@amazon.com>, <nsaenz@amazon.es>, <xmarcalx@amazon.com>,
	<kalyazin@amazon.com>
Subject: [PATCH v2 1/5] mm: userfaultfd: generic continue for non hugetlbfs
Date: Wed, 2 Apr 2025 16:07:17 +0000
Message-ID: <20250402160721.97596-2-kalyazin@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402160721.97596-1-kalyazin@amazon.com>
References: <20250402160721.97596-1-kalyazin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

Remove shmem-specific code from UFFDIO_CONTINUE implementation for
non-huge pages by calling vm_ops->fault().  A new VMF flag,
FAULT_FLAG_NO_USERFAULT_MINOR, is introduced to avoid recursive call to
handle_userfault().

Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
---
 include/linux/mm_types.h |  3 +++
 mm/hugetlb.c             |  2 +-
 mm/shmem.c               |  3 ++-
 mm/userfaultfd.c         | 25 ++++++++++++++++++-------
 4 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 0234f14f2aa6..91a00f2cd565 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1429,6 +1429,8 @@ enum tlb_flush_reason {
  * @FAULT_FLAG_ORIG_PTE_VALID: whether the fault has vmf->orig_pte cached.
  *                        We should only access orig_pte if this flag set.
  * @FAULT_FLAG_VMA_LOCK: The fault is handled under VMA lock.
+ * @FAULT_FLAG_NO_USERFAULT_MINOR: The fault handler must not call userfaultfd
+ *                                 minor handler.
  *
  * About @FAULT_FLAG_ALLOW_RETRY and @FAULT_FLAG_TRIED: we can specify
  * whether we would allow page faults to retry by specifying these two
@@ -1467,6 +1469,7 @@ enum fault_flag {
 	FAULT_FLAG_UNSHARE =		1 << 10,
 	FAULT_FLAG_ORIG_PTE_VALID =	1 << 11,
 	FAULT_FLAG_VMA_LOCK =		1 << 12,
+	FAULT_FLAG_NO_USERFAULT_MINOR = 1 << 13,
 };
 
 typedef unsigned int __bitwise zap_flags_t;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 97930d44d460..ba90d48144fc 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6228,7 +6228,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 		}
 
 		/* Check for page in userfault range. */
-		if (userfaultfd_minor(vma)) {
+		if (userfaultfd_minor(vma) && !(vmf->flags & FAULT_FLAG_NO_USERFAULT_MINOR)) {
 			folio_unlock(folio);
 			folio_put(folio);
 			/* See comment in userfaultfd_missing() block above */
diff --git a/mm/shmem.c b/mm/shmem.c
index 1ede0800e846..5e1911e39dec 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2467,7 +2467,8 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 	fault_mm = vma ? vma->vm_mm : NULL;
 
 	folio = filemap_get_entry(inode->i_mapping, index);
-	if (folio && vma && userfaultfd_minor(vma)) {
+	if (folio && vma && userfaultfd_minor(vma) &&
+	    !(vmf->flags & FAULT_FLAG_NO_USERFAULT_MINOR)) {
 		if (!xa_is_value(folio))
 			folio_put(folio);
 		*fault_type = handle_userfault(vmf, VM_UFFD_MINOR);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index d06453fa8aba..68a995216789 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -386,24 +386,35 @@ static int mfill_atomic_pte_continue(pmd_t *dst_pmd,
 				     unsigned long dst_addr,
 				     uffd_flags_t flags)
 {
-	struct inode *inode = file_inode(dst_vma->vm_file);
-	pgoff_t pgoff = linear_page_index(dst_vma, dst_addr);
 	struct folio *folio;
 	struct page *page;
 	int ret;
+	struct vm_fault vmf = {
+		.vma = dst_vma,
+		.address = dst_addr,
+		.flags = FAULT_FLAG_WRITE | FAULT_FLAG_REMOTE |
+		    FAULT_FLAG_NO_USERFAULT_MINOR,
+		.pte = NULL,
+		.page = NULL,
+		.pgoff = linear_page_index(dst_vma, dst_addr),
+	};
+
+	if (!dst_vma->vm_ops || !dst_vma->vm_ops->fault)
+		return -EINVAL;
 
-	ret = shmem_get_folio(inode, pgoff, 0, &folio, SGP_NOALLOC);
-	/* Our caller expects us to return -EFAULT if we failed to find folio */
-	if (ret == -ENOENT)
+	ret = dst_vma->vm_ops->fault(&vmf);
+	if (ret & VM_FAULT_ERROR) {
 		ret = -EFAULT;
-	if (ret)
 		goto out;
+	}
+
+	page = vmf.page;
+	folio = page_folio(page);
 	if (!folio) {
 		ret = -EFAULT;
 		goto out;
 	}
 
-	page = folio_file_page(folio, pgoff);
 	if (PageHWPoison(page)) {
 		ret = -EIO;
 		goto out_release;
-- 
2.47.1


