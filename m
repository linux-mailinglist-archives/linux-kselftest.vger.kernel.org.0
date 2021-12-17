Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1004789F8
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 12:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbhLQLdr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 06:33:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58401 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235464AbhLQLdq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 06:33:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639740825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5QROTR0DNwNeGtld/DWtRhC9lgRjF4ZhB5ZKs8M3xpY=;
        b=TzAmR81d4AuIcXfpQXzQVWMSvlizOjH/tRMCkXYB2jRPKX987QlQvEbgEgXKAVeicMq1fe
        EXh8qNGuc5Qrw9vJnjOIgXJNDDIP6T55muMakr7TK9J92vZ0PoUSMdAQEbomTjuplT6qBZ
        CTY1hK8NokqVrcXmtjYDtXCF/Qx6nRk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-523-AfuQXayyNmuryw_8DqcZug-1; Fri, 17 Dec 2021 06:33:40 -0500
X-MC-Unique: AfuQXayyNmuryw_8DqcZug-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65304801AAB;
        Fri, 17 Dec 2021 11:33:37 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.204])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A036E8D5AC;
        Fri, 17 Dec 2021 11:33:30 +0000 (UTC)
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
Subject: [PATCH v1 03/11] mm: simplify hugetlb and file-THP handling in __page_mapcount()
Date:   Fri, 17 Dec 2021 12:30:41 +0100
Message-Id: <20211217113049.23850-4-david@redhat.com>
In-Reply-To: <20211217113049.23850-1-david@redhat.com>
References: <20211217113049.23850-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Let's return early for hugetlb, which really only relies on the compound
mapcount so far and does not support PageDoubleMap() yet. Use the chance
to cleanup the file-THP case to make it easier to grasp. While at it, use
head_compound_mapcount().

This is a preparation for further changes.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/util.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/util.c b/mm/util.c
index 741ba32a43ac..3239e75c148d 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -732,15 +732,18 @@ int __page_mapcount(struct page *page)
 {
 	int ret;
 
-	ret = atomic_read(&page->_mapcount) + 1;
+	if (PageHuge(page))
+		return compound_mapcount(page);
 	/*
 	 * For file THP page->_mapcount contains total number of mapping
 	 * of the page: no need to look into compound_mapcount.
 	 */
-	if (!PageAnon(page) && !PageHuge(page))
-		return ret;
+	if (!PageAnon(page))
+		return atomic_read(&page->_mapcount) + 1;
+
+	ret = atomic_read(&page->_mapcount) + 1;
 	page = compound_head(page);
-	ret += atomic_read(compound_mapcount_ptr(page)) + 1;
+	ret += head_compound_mapcount(page);
 	if (PageDoubleMap(page))
 		ret--;
 	return ret;
-- 
2.31.1

