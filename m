Return-Path: <linux-kselftest+bounces-27775-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D55A482BD
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 16:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F34B31888959
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 15:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E788425F7B4;
	Thu, 27 Feb 2025 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XJ4ZUnqj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE1025F7A2;
	Thu, 27 Feb 2025 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740669272; cv=none; b=beXBUmx28wzdrbgRjw9T/tziFVNqLClDRIM0GcTRdjDUTR/+pD5LU5GclXLz5eN31+KYjpCt14/79Xn6rQh1tZGzKTVNQGziRvIvugcQToyInybFUDZEc+9oVq1Ln3s8oik03iYa8+Zf4j9tYHJ54jHvtawiCr0vZIXZrT2iPq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740669272; c=relaxed/simple;
	bh=cVSgDCggYpw8xN5dH8v583jJU/1xhO0S9v5k3RuLRuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGrsiM7AzXhcUdq2k7vHK9dURoPZ2wPMxbkDqtYpTRx0MjjWKHL/xzOwtGvGOKlN9N7M0ASOxyaPy1swIvjeJTvVuCcFi2wBZjxUoFTrxFT6/ACBGp4vN/ETj/BD8owwNRaPbQw9j0RnDLnSPdVtunJKsEr1QkUYwOLmI1yeIzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XJ4ZUnqj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZG1Z/AvQvy2Nn3Xs8i93g3gloTg9fkysRZ6eqtmzy+k=; b=XJ4ZUnqjgLZkjeds3l3Ic0yv1U
	ObWbqQi6a6BVYlVNqnxDtt6v37SdHaPvrZ4WvucLlDkmwBNF5rVBaagjMv7SAP5A0VHRZqP8VM4zF
	Ulf9Mu+bTr7XlUC/vk40Z4an/G073wAhtzOI3kWlh6xrJzGQAOB1I7bdtJXWAXjcsnH9kImMFWda0
	KrmcC5e1VfO/+8P8gLZIqGEVHIUmbrTOT51JakD1/1lobLxEbwUx2GLQDYbhkx8B6QhYqjHEJSQNB
	8jULkx0X1hMsTiNPE5nsVuzZKQX4K29Sw1fWklz1jt55EUUyZFnCJ4bl2pEpbS58sJDkcpwJwnkwv
	yL0wZQOA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tnfaO-000000009ty-35Id;
	Thu, 27 Feb 2025 15:14:05 +0000
Date: Thu, 27 Feb 2025 15:14:04 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yu Zhao <yuzhao@google.com>, John Hubbard <jhubbard@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH v9 2/8] mm/huge_memory: add two new (not yet used)
 functions for folio_split()
Message-ID: <Z8CBPF9_gDZuDjED@casper.infradead.org>
References: <20250226210032.2044041-1-ziy@nvidia.com>
 <20250226210032.2044041-3-ziy@nvidia.com>
 <Z7_-XweaPpfdRz1h@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7_-XweaPpfdRz1h@casper.infradead.org>

On Thu, Feb 27, 2025 at 05:55:43AM +0000, Matthew Wilcox wrote:
> On Wed, Feb 26, 2025 at 04:00:25PM -0500, Zi Yan wrote:
> > +static int __split_unmapped_folio(struct folio *folio, int new_order,
> > +		struct page *split_at, struct page *lock_at,
> > +		struct list_head *list, pgoff_t end,
> > +		struct xa_state *xas, struct address_space *mapping,
> > +		bool uniform_split)
> > +{
> [...]
> > +		/* complete memcg works before add pages to LRU */
> > +		split_page_memcg(&folio->page, old_order, split_order);
> > +		split_page_owner(&folio->page, old_order, split_order);
> > +		pgalloc_tag_split(folio, old_order, split_order);
> 
> At least split_page_memcg() needs to become aware of 'uniform_split'.
> 
>         if (folio_memcg_kmem(folio))
>                 obj_cgroup_get_many(__folio_objcg(folio), old_nr / new_nr - 1);
> 
> If we're doing uniform_split, that calculation should be
> 	old_order - new_order - 1

umm, old_order - new_order.  Anyway, here's a patch I've done on top of
your work, but it probably needs to be massaged slightly and placed
before your work?


From 190e13ed77e562eb59fa1fa4bfefdefe5d0416ed Mon Sep 17 00:00:00 2001
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Date: Mon, 28 Oct 2024 16:23:30 -0400
Subject: [PATCH] mm: Separate folio_split_memcg() from split_page_memcg()

Folios always use memcg_data to refer to the mem_cgroup while pages
allocated with GFP_ACCOUNT have a pointer to the obj_cgroup.  Since the
caller already knows what it has, split the function into two and then
we don't need to check.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/memcontrol.h |  7 +++++++
 mm/huge_memory.c           |  6 ++++--
 mm/memcontrol.c            | 18 +++++++++++++++---
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 57664e2a8fb7..155c3f81f4df 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1039,6 +1039,8 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
 }
 
 void split_page_memcg(struct page *head, int old_order, int new_order);
+void folio_split_memcg(struct folio *folio, unsigned old_order,
+		unsigned new_order, bool uniform_split);
 
 static inline u64 cgroup_id_from_mm(struct mm_struct *mm)
 {
@@ -1463,6 +1465,11 @@ static inline void split_page_memcg(struct page *head, int old_order, int new_or
 {
 }
 
+static inline void folio_split_memcg(struct folio *folio, unsigned old_order,
+		unsigned new_order, bool uniform)
+{
+}
+
 static inline u64 cgroup_id_from_mm(struct mm_struct *mm)
 {
 	return 0;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1e45064046a0..75fa9c9d9ec9 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3401,6 +3401,9 @@ static void __split_folio_to_order(struct folio *folio, int new_order)
 			folio_set_young(new_folio);
 		if (folio_test_idle(folio))
 			folio_set_idle(new_folio);
+#ifdef CONFIG_MEMCG
+		new_folio->memcg_data = folio->memcg_data;
+#endif
 
 		folio_xchg_last_cpupid(new_folio, folio_last_cpupid(folio));
 	}
@@ -3529,8 +3532,7 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 			}
 		}
 
-		/* complete memcg works before add pages to LRU */
-		split_page_memcg(&folio->page, old_order, split_order);
+		folio_split_memcg(folio, old_order, split_order, uniform_split);
 		split_page_owner(&folio->page, old_order, split_order);
 		pgalloc_tag_split(folio, old_order, split_order);
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 16f3bdbd37d8..c2d41e1337cb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3064,10 +3064,22 @@ void split_page_memcg(struct page *head, int old_order, int new_order)
 	for (i = new_nr; i < old_nr; i += new_nr)
 		folio_page(folio, i)->memcg_data = folio->memcg_data;
 
-	if (folio_memcg_kmem(folio))
-		obj_cgroup_get_many(__folio_objcg(folio), old_nr / new_nr - 1);
+	obj_cgroup_get_many(__folio_objcg(folio), old_nr / new_nr - 1);
+}
+
+void folio_split_memcg(struct folio *folio, unsigned old_order,
+		unsigned new_order, bool uniform_split)
+{
+	unsigned new_refs;
+
+	if (mem_cgroup_disabled() || !folio_memcg_charged(folio))
+		return;
+
+	if (uniform_split)
+		new_refs = (1 << (old_order - new_order)) - 1;
 	else
-		css_get_many(&folio_memcg(folio)->css, old_nr / new_nr - 1);
+		new_refs = old_order - new_order;
+	css_get_many(&__folio_memcg(folio)->css, new_refs);
 }
 
 unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
-- 
2.47.2


