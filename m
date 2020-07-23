Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA88D22B979
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jul 2020 00:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgGWWbB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jul 2020 18:31:01 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:13903 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbgGWWaw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jul 2020 18:30:52 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f1a0f5c0000>; Thu, 23 Jul 2020 15:29:48 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 23 Jul 2020 15:30:51 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 23 Jul 2020 15:30:51 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 23 Jul
 2020 22:30:42 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 23 Jul 2020 22:30:42 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f1a0f910004>; Thu, 23 Jul 2020 15:30:42 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        <nouveau@lists.freedesktop.org>, <kvm-ppc@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "Ben Skeggs" <bskeggs@redhat.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        "Ralph Campbell" <rcampbell@nvidia.com>
Subject: [PATCH v4 6/6] mm/migrate: remove range invalidation in migrate_vma_pages()
Date:   Thu, 23 Jul 2020 15:30:04 -0700
Message-ID: <20200723223004.9586-7-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200723223004.9586-1-rcampbell@nvidia.com>
References: <20200723223004.9586-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When migrating the special zero page, migrate_vma_pages() calls
mmu_notifier_invalidate_range_start() before replacing the zero page
PFN in the CPU page tables. This is unnecessary since the range was
invalidated in migrate_vma_setup() and the page table entry is checked
to be sure it hasn't changed between migrate_vma_setup() and
migrate_vma_pages(). Therefore, remove the redundant invalidation.
DKIM-Signature: v a a-sha256; claxed/relaxed; d idia.com; s;
	t95543388; bhqnSzc0udfc4m+P6cziRmRJk5XEGcgDU5ImloLrCuE	h PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
	 Content-Transfer-Encoding:Content-Type;
	b yLVqKU1Kxf67Qz9TIZ2f1lAaP7YxvFgCZR8v0Vw1fwq7aUbMbgfzcF0bd6+XzG6
	 ZHtBRMp/Zu/ZLGRxP6lBqZo4wHMHbuW3fXOvPCrYTD5YsCCLv+Ao4RmreWyec2wBTk
	 uBo3ZylCHJ0ckD85BcjQQxpXyY99cBsvIomZw9wzg6QGm7Ksbq6d+UKSkb0L04d6v8
	 fiRvvLNq3kCbPzrifaBTj3klQcVcKXz34km0XUoRQlSaftlq4BJWopBPX8U7gQtstO
	 OvA7Al9t87sCpKjSnqjE7N1jThU0KzjPrCxJiEHq/0Vf4sqeUA42bOkc+bk/CV1ZSF
	 n9jm36j4kRTUg
Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 mm/migrate.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 96e1f41a991e..36076ba2f51a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2877,9 +2877,7 @@ void migrate_vma_pages(struct migrate_vma *migrate)
 {
 	const unsigned long npages = migrate->npages;
 	const unsigned long start = migrate->start;
-	struct mmu_notifier_range range;
 	unsigned long addr, i;
-	bool notified = false;
 
 	for (i = 0, addr = start; i < npages; addr += PAGE_SIZE, i++) {
 		struct page *newpage = migrate_pfn_to_page(migrate->dst[i]);
@@ -2895,16 +2893,6 @@ void migrate_vma_pages(struct migrate_vma *migrate)
 		if (!page) {
 			if (!(migrate->src[i] & MIGRATE_PFN_MIGRATE))
 				continue;
-			if (!notified) {
-				notified = true;
-
-				mmu_notifier_range_init(&range,
-							MMU_NOTIFY_CLEAR, 0,
-							NULL,
-							migrate->vma->vm_mm,
-							addr, migrate->end);
-				mmu_notifier_invalidate_range_start(&range);
-			}
 			migrate_vma_insert_page(migrate, addr, newpage,
 						&migrate->src[i],
 						&migrate->dst[i]);
@@ -2937,14 +2925,6 @@ void migrate_vma_pages(struct migrate_vma *migrate)
 		if (r != MIGRATEPAGE_SUCCESS)
 			migrate->src[i] &= ~MIGRATE_PFN_MIGRATE;
 	}
-
-	/*
-	 * No need to double call mmu_notifier->invalidate_range() callback as
-	 * the above ptep_clear_flush_notify() inside migrate_vma_insert_page()
-	 * did already call it.
-	 */
-	if (notified)
-		mmu_notifier_invalidate_range_only_end(&range);
 }
 EXPORT_SYMBOL(migrate_vma_pages);
 
-- 
2.20.1

