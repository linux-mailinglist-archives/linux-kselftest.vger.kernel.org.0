Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326434789FB
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 12:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbhLQLdy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 06:33:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27311 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235464AbhLQLdx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 06:33:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639740832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UOrVV2NFx26u84MVGLWI5jLwDTFzF180mJVk+c6k5Rs=;
        b=b3h1DYf8FJmQyhXxN8DyCyrjxglmBWl0trfcWY8kagaD+rH/a2jk8v4dX0DfTc+sBR/EYd
        27u3Yw9w6p23nR9+BCGHxWtw7n6a1ROvHItItVtnccGrmbJlNgDNSmkbk94rJHHtf1UhYM
        grqLjvyFPmXyPgf+dn5mW7LlaYniknU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-272-rZlAI3i2NSemwQWONFDUoA-1; Fri, 17 Dec 2021 06:33:47 -0500
X-MC-Unique: rZlAI3i2NSemwQWONFDUoA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E0C61018723;
        Fri, 17 Dec 2021 11:33:45 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.204])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C61F08ACF7;
        Fri, 17 Dec 2021 11:33:37 +0000 (UTC)
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
Subject: [PATCH v1 04/11] mm: thp: simlify total_mapcount()
Date:   Fri, 17 Dec 2021 12:30:42 +0100
Message-Id: <20211217113049.23850-5-david@redhat.com>
In-Reply-To: <20211217113049.23850-1-david@redhat.com>
References: <20211217113049.23850-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Let's simplify a bit, returning for PageHuge() early and using
head_compound_page() as we are only getting called for HEAD pages.

Note the VM_BUG_ON_PAGE(PageTail(page), page) check at the beginning of
total_mapcount().

This is a preparation for further changes.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4751d03947da..826cabcad11a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2506,12 +2506,11 @@ int total_mapcount(struct page *page)
 
 	if (likely(!PageCompound(page)))
 		return atomic_read(&page->_mapcount) + 1;
+	if (PageHuge(page))
+		return head_compound_mapcount(page);
 
-	compound = compound_mapcount(page);
 	nr = compound_nr(page);
-	if (PageHuge(page))
-		return compound;
-	ret = compound;
+	ret = compound = head_compound_mapcount(page);
 	for (i = 0; i < nr; i++)
 		ret += atomic_read(&page[i]._mapcount) + 1;
 	/* File pages has compound_mapcount included in _mapcount */
-- 
2.31.1

