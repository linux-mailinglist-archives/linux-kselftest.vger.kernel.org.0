Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D78478A0D
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 12:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbhLQLed (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 06:34:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:38795 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235553AbhLQLec (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 06:34:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639740871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KXmb+mz7gGLUO/1AsI3IaHmA9N+YeaV6BOIe6tD64xE=;
        b=fFhl5/EmL92Prt3kgkmqf/eF5v/UGeYHG7lfk5yHxNLp+8dWYKjo42FOqmWoGAO4mj8s4u
        q6gzvyEsyP2J9La9042LFYyvt561rLr+84fDeVE8echfGEwEyFcE0QRz794m+Iw1sFs1qC
        +bgzkfxVtEBHOAz8lqd8WrLoM3xM3qg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-499-lmA_dabzOyaf-oSTM4FGww-1; Fri, 17 Dec 2021 06:34:28 -0500
X-MC-Unique: lmA_dabzOyaf-oSTM4FGww-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F8D436393;
        Fri, 17 Dec 2021 11:34:25 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.204])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED7FB8ACF7;
        Fri, 17 Dec 2021 11:34:18 +0000 (UTC)
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
Subject: [PATCH v1 10/11] mm: thp: introduce and use page_trans_huge_anon_shared()
Date:   Fri, 17 Dec 2021 12:30:48 +0100
Message-Id: <20211217113049.23850-11-david@redhat.com>
In-Reply-To: <20211217113049.23850-1-david@redhat.com>
References: <20211217113049.23850-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Let's add an optimized way to check "page_trans_huge_mapcount() > 1"
that is allowed to break the loop early.

This commit is based on a prototype patch by Andrea.

Co-developed-by: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/huge_mm.h |  7 +++++++
 mm/gup.c                |  2 +-
 mm/huge_memory.c        | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 44e02d47c65a..3a9d8cf64219 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -361,6 +361,8 @@ static inline void thp_mapcount_unlock(struct page *page,
 	local_irq_restore(irq_flags);
 }
 
+extern bool page_trans_huge_anon_shared(struct page *page);
+
 #else /* CONFIG_TRANSPARENT_HUGEPAGE */
 #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
 #define HPAGE_PMD_MASK ({ BUILD_BUG(); 0; })
@@ -532,6 +534,11 @@ static inline void thp_mapcount_unlock(struct page *page,
 {
 }
 
+static inline bool page_trans_huge_anon_shared(struct page *page)
+{
+	return false;
+}
+
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 /**
diff --git a/mm/gup.c b/mm/gup.c
index 35d1b28e3829..496575ff9ac8 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -70,7 +70,7 @@ bool gup_must_unshare(unsigned int flags, struct page *page, bool is_head)
 		return __page_mapcount(page) > 1;
 	if (is_head) {
 		VM_BUG_ON(!PageTransHuge(page));
-		return page_trans_huge_mapcount(page, NULL) > 1;
+		return page_trans_huge_anon_shared(page);
 	}
 	return page_mapcount(page) > 1;
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 57842e8b13d4..dced82274f1d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1281,6 +1281,40 @@ void huge_pmd_set_accessed(struct vm_fault *vmf)
 	spin_unlock(vmf->ptl);
 }
 
+
+static bool __page_trans_huge_anon_shared(struct page *page)
+{
+	int i, mapcount;
+
+	mapcount = head_compound_mapcount(page);
+	if (mapcount > 1)
+		return true;
+	if (PageDoubleMap(page))
+		mapcount -= 1;
+	for (i = 0; i < thp_nr_pages(page); i++) {
+		if (atomic_read(&page[i]._mapcount) + mapcount + 1 > 1)
+			return true;
+	}
+	return false;
+}
+
+/* A lightweight check corresponding to "page_trans_huge_mapcount() > 1". */
+bool page_trans_huge_anon_shared(struct page *page)
+{
+	unsigned int seqcount;
+	bool shared;
+
+	VM_BUG_ON_PAGE(PageHuge(page) || PageTail(page), page);
+	VM_BUG_ON_PAGE(!PageAnon(page) || !PageTransHuge(page), page);
+
+	do {
+		seqcount = thp_mapcount_read_begin(page);
+		shared = __page_trans_huge_anon_shared(page);
+	} while (thp_mapcount_read_retry(page, seqcount));
+
+	return shared;
+}
+
 vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
-- 
2.31.1

