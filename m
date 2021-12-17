Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73E34789F4
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 12:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbhLQLdh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 06:33:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:46316 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235447AbhLQLdh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 06:33:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639740816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UTfvPc+jpJw3w8ga8TZ2rx5ThiRLullRxNgQNYf86dk=;
        b=VJYyfW2leLo9iETHR2xo07vl/elK85RGaGrQWYA9gqhq2YmfZ0eIz3ihdWb0zSRB7uTL3p
        SmBeARnEAv4o9PGkY4mBEqfZnOwflrEVXSGYamBzuSwTLWsd6NtDGU5GqYB2Fs0I3O9gdg
        hcZUCw3qQbeeL0pec2tb7HY8Jk+SUL4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-IqsbLDQXOCm4tMXYTw-Yaw-1; Fri, 17 Dec 2021 06:33:33 -0500
X-MC-Unique: IqsbLDQXOCm4tMXYTw-Yaw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 439AB81CCC4;
        Fri, 17 Dec 2021 11:33:30 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.204])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D1B88CB3E;
        Fri, 17 Dec 2021 11:32:48 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 02/11] mm: thp: consolidate mapcount logic on THP split
Date:   Fri, 17 Dec 2021 12:30:40 +0100
Message-Id: <20211217113049.23850-3-david@redhat.com>
In-Reply-To: <20211217113049.23850-1-david@redhat.com>
References: <20211217113049.23850-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Let's consolidate the mapcount logic to make it easier to understand and
to prepare for further changes.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e5483347291c..4751d03947da 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2101,21 +2101,25 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		pte = pte_offset_map(&_pmd, addr);
 		BUG_ON(!pte_none(*pte));
 		set_pte_at(mm, addr, pte, entry);
-		if (!pmd_migration)
-			atomic_inc(&page[i]._mapcount);
 		pte_unmap(pte);
 	}
 
 	if (!pmd_migration) {
+		/* Sub-page mapcount accounting for above small mappings. */
+		int val = 1;
+
 		/*
 		 * Set PG_double_map before dropping compound_mapcount to avoid
 		 * false-negative page_mapped().
+		 *
+		 * The first to set PageDoubleMap() has to increment all
+		 * sub-page mapcounts by one.
 		 */
-		if (compound_mapcount(page) > 1 &&
-		    !TestSetPageDoubleMap(page)) {
-			for (i = 0; i < HPAGE_PMD_NR; i++)
-				atomic_inc(&page[i]._mapcount);
-		}
+		if (compound_mapcount(page) > 1 && !TestSetPageDoubleMap(page))
+			val++;
+
+		for (i = 0; i < HPAGE_PMD_NR; i++)
+			atomic_add(val, &page[i]._mapcount);
 
 		lock_page_memcg(page);
 		if (atomic_add_negative(-1, compound_mapcount_ptr(page))) {
-- 
2.31.1

