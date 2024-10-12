Return-Path: <linux-kselftest+bounces-19603-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A4A99B441
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 13:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AF091F2378A
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 11:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59438200127;
	Sat, 12 Oct 2024 11:29:48 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA431FF7C9;
	Sat, 12 Oct 2024 11:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732588; cv=none; b=iE2sH7hhX/YJVfKZt642XfxRrqosE9dY/jXp0cOgpJorXaRjQqCOULpOwg7K3tgxwZ7Ii9L1mpMQcFt24vrswHYj0s+4eDbQ2ID5qYQWFsV27TykOHFH+jxphBVyLD6p3ElakLJckNzU9sEK01+pbhABRW1nTG5eKa0TloUWME0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732588; c=relaxed/simple;
	bh=59oUOrp6Ql8ElJOLu7W6wAsHWzXSNy7mBhvK2EX/v+U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZRExqRdawgDqR2Z5KMHCoK/whZqWG6ULFI9asPrVSQQ3bCl4vjqtG6kNyGAxEORm7zSvq57oa2W75k0GVtMu0clz3rWV6MXCi5x6TUiwezREcE3D4aDDMmN0ehX0gFDZapYlDLqR4SxiU7VWY9q7y8HmlpkXc0d9Fsge86nPLEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XQh9M1hfpz1ymy8;
	Sat, 12 Oct 2024 19:29:43 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 2B1021402CC;
	Sat, 12 Oct 2024 19:29:38 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 12 Oct 2024 19:29:37 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, David Howells <dhowells@redhat.com>, Alexander
 Duyck <alexander.duyck@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
	Alexander Duyck <alexanderduyck@fb.com>, Eric Dumazet <edumazet@google.com>,
	Shuah Khan <shuah@kernel.org>, <linux-mm@kvack.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next v21 02/14] mm: move the page fragment allocator from page_alloc into its own file
Date: Sat, 12 Oct 2024 19:23:08 +0800
Message-ID: <20241012112320.2503906-3-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241012112320.2503906-1-linyunsheng@huawei.com>
References: <20241012112320.2503906-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf200006.china.huawei.com (7.185.36.61)

Inspired by [1], move the page fragment allocator from page_alloc
into its own c file and header file, as we are about to make more
change for it to replace another page_frag implementation in
sock.c

As this patchset is going to replace 'struct page_frag' with
'struct page_frag_cache' in sched.h, including page_frag_cache.h
in sched.h has a compiler error caused by interdependence between
mm_types.h and mm.h for asm-offsets.c, see [2]. So avoid the compiler
error by moving 'struct page_frag_cache' to mm_types_task.h as
suggested by Alexander, see [3].

1. https://lore.kernel.org/all/20230411160902.4134381-3-dhowells@redhat.com/
2. https://lore.kernel.org/all/15623dac-9358-4597-b3ee-3694a5956920@gmail.com/
3. https://lore.kernel.org/all/CAKgT0UdH1yD=LSCXFJ=YM_aiA4OomD-2wXykO42bizaWMt_HOA@mail.gmail.com/
CC: David Howells <dhowells@redhat.com>
CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Acked-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
---
 include/linux/gfp.h                           |  22 ---
 include/linux/mm_types.h                      |  18 ---
 include/linux/mm_types_task.h                 |  18 +++
 include/linux/page_frag_cache.h               |  31 ++++
 include/linux/skbuff.h                        |   1 +
 mm/Makefile                                   |   1 +
 mm/page_alloc.c                               | 136 ----------------
 mm/page_frag_cache.c                          | 145 ++++++++++++++++++
 .../selftests/mm/page_frag/page_frag_test.c   |   2 +-
 9 files changed, 197 insertions(+), 177 deletions(-)
 create mode 100644 include/linux/page_frag_cache.h
 create mode 100644 mm/page_frag_cache.c

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index a951de920e20..a0a6d25f883f 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -371,28 +371,6 @@ __meminit void *alloc_pages_exact_nid_noprof(int nid, size_t size, gfp_t gfp_mas
 extern void __free_pages(struct page *page, unsigned int order);
 extern void free_pages(unsigned long addr, unsigned int order);
 
-struct page_frag_cache;
-void page_frag_cache_drain(struct page_frag_cache *nc);
-extern void __page_frag_cache_drain(struct page *page, unsigned int count);
-void *__page_frag_alloc_align(struct page_frag_cache *nc, unsigned int fragsz,
-			      gfp_t gfp_mask, unsigned int align_mask);
-
-static inline void *page_frag_alloc_align(struct page_frag_cache *nc,
-					  unsigned int fragsz, gfp_t gfp_mask,
-					  unsigned int align)
-{
-	WARN_ON_ONCE(!is_power_of_2(align));
-	return __page_frag_alloc_align(nc, fragsz, gfp_mask, -align);
-}
-
-static inline void *page_frag_alloc(struct page_frag_cache *nc,
-			     unsigned int fragsz, gfp_t gfp_mask)
-{
-	return __page_frag_alloc_align(nc, fragsz, gfp_mask, ~0u);
-}
-
-extern void page_frag_free(void *addr);
-
 #define __free_page(page) __free_pages((page), 0)
 #define free_page(addr) free_pages((addr), 0)
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6e3bdf8e38bc..92314ef2d978 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -521,9 +521,6 @@ static_assert(sizeof(struct ptdesc) <= sizeof(struct page));
  */
 #define STRUCT_PAGE_MAX_SHIFT	(order_base_2(sizeof(struct page)))
 
-#define PAGE_FRAG_CACHE_MAX_SIZE	__ALIGN_MASK(32768, ~PAGE_MASK)
-#define PAGE_FRAG_CACHE_MAX_ORDER	get_order(PAGE_FRAG_CACHE_MAX_SIZE)
-
 /*
  * page_private can be used on tail pages.  However, PagePrivate is only
  * checked by the VM on the head page.  So page_private on the tail pages
@@ -542,21 +539,6 @@ static inline void *folio_get_private(struct folio *folio)
 	return folio->private;
 }
 
-struct page_frag_cache {
-	void * va;
-#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
-	__u16 offset;
-	__u16 size;
-#else
-	__u32 offset;
-#endif
-	/* we maintain a pagecount bias, so that we dont dirty cache line
-	 * containing page->_refcount every time we allocate a fragment.
-	 */
-	unsigned int		pagecnt_bias;
-	bool pfmemalloc;
-};
-
 typedef unsigned long vm_flags_t;
 
 /*
diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
index bff5706b76e1..0ac6daebdd5c 100644
--- a/include/linux/mm_types_task.h
+++ b/include/linux/mm_types_task.h
@@ -8,6 +8,7 @@
  * (These are defined separately to decouple sched.h from mm_types.h as much as possible.)
  */
 
+#include <linux/align.h>
 #include <linux/types.h>
 
 #include <asm/page.h>
@@ -43,6 +44,23 @@ struct page_frag {
 #endif
 };
 
+#define PAGE_FRAG_CACHE_MAX_SIZE	__ALIGN_MASK(32768, ~PAGE_MASK)
+#define PAGE_FRAG_CACHE_MAX_ORDER	get_order(PAGE_FRAG_CACHE_MAX_SIZE)
+struct page_frag_cache {
+	void *va;
+#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
+	__u16 offset;
+	__u16 size;
+#else
+	__u32 offset;
+#endif
+	/* we maintain a pagecount bias, so that we dont dirty cache line
+	 * containing page->_refcount every time we allocate a fragment.
+	 */
+	unsigned int		pagecnt_bias;
+	bool pfmemalloc;
+};
+
 /* Track pages that require TLB flushes */
 struct tlbflush_unmap_batch {
 #ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
new file mode 100644
index 000000000000..67ac8626ed9b
--- /dev/null
+++ b/include/linux/page_frag_cache.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_PAGE_FRAG_CACHE_H
+#define _LINUX_PAGE_FRAG_CACHE_H
+
+#include <linux/log2.h>
+#include <linux/mm_types_task.h>
+#include <linux/types.h>
+
+void page_frag_cache_drain(struct page_frag_cache *nc);
+void __page_frag_cache_drain(struct page *page, unsigned int count);
+void *__page_frag_alloc_align(struct page_frag_cache *nc, unsigned int fragsz,
+			      gfp_t gfp_mask, unsigned int align_mask);
+
+static inline void *page_frag_alloc_align(struct page_frag_cache *nc,
+					  unsigned int fragsz, gfp_t gfp_mask,
+					  unsigned int align)
+{
+	WARN_ON_ONCE(!is_power_of_2(align));
+	return __page_frag_alloc_align(nc, fragsz, gfp_mask, -align);
+}
+
+static inline void *page_frag_alloc(struct page_frag_cache *nc,
+				    unsigned int fragsz, gfp_t gfp_mask)
+{
+	return __page_frag_alloc_align(nc, fragsz, gfp_mask, ~0u);
+}
+
+void page_frag_free(void *addr);
+
+#endif
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 39f1d16f3628..560e2b49f98b 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -31,6 +31,7 @@
 #include <linux/in6.h>
 #include <linux/if_packet.h>
 #include <linux/llist.h>
+#include <linux/page_frag_cache.h>
 #include <net/flow.h>
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
 #include <linux/netfilter/nf_conntrack_common.h>
diff --git a/mm/Makefile b/mm/Makefile
index d5639b036166..dba52bb0da8a 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -65,6 +65,7 @@ page-alloc-$(CONFIG_SHUFFLE_PAGE_ALLOCATOR) += shuffle.o
 memory-hotplug-$(CONFIG_MEMORY_HOTPLUG) += memory_hotplug.o
 
 obj-y += page-alloc.o
+obj-y += page_frag_cache.o
 obj-y += init-mm.o
 obj-y += memblock.o
 obj-y += $(memory-hotplug-y)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8afab64814dc..6ca2abce857b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4836,142 +4836,6 @@ void free_pages(unsigned long addr, unsigned int order)
 
 EXPORT_SYMBOL(free_pages);
 
-/*
- * Page Fragment:
- *  An arbitrary-length arbitrary-offset area of memory which resides
- *  within a 0 or higher order page.  Multiple fragments within that page
- *  are individually refcounted, in the page's reference counter.
- *
- * The page_frag functions below provide a simple allocation framework for
- * page fragments.  This is used by the network stack and network device
- * drivers to provide a backing region of memory for use as either an
- * sk_buff->head, or to be used in the "frags" portion of skb_shared_info.
- */
-static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
-					     gfp_t gfp_mask)
-{
-	struct page *page = NULL;
-	gfp_t gfp = gfp_mask;
-
-#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
-	gfp_mask = (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
-		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
-	page = alloc_pages_node(NUMA_NO_NODE, gfp_mask,
-				PAGE_FRAG_CACHE_MAX_ORDER);
-	nc->size = page ? PAGE_FRAG_CACHE_MAX_SIZE : PAGE_SIZE;
-#endif
-	if (unlikely(!page))
-		page = alloc_pages_node(NUMA_NO_NODE, gfp, 0);
-
-	nc->va = page ? page_address(page) : NULL;
-
-	return page;
-}
-
-void page_frag_cache_drain(struct page_frag_cache *nc)
-{
-	if (!nc->va)
-		return;
-
-	__page_frag_cache_drain(virt_to_head_page(nc->va), nc->pagecnt_bias);
-	nc->va = NULL;
-}
-EXPORT_SYMBOL(page_frag_cache_drain);
-
-void __page_frag_cache_drain(struct page *page, unsigned int count)
-{
-	VM_BUG_ON_PAGE(page_ref_count(page) == 0, page);
-
-	if (page_ref_sub_and_test(page, count))
-		free_unref_page(page, compound_order(page));
-}
-EXPORT_SYMBOL(__page_frag_cache_drain);
-
-void *__page_frag_alloc_align(struct page_frag_cache *nc,
-			      unsigned int fragsz, gfp_t gfp_mask,
-			      unsigned int align_mask)
-{
-	unsigned int size = PAGE_SIZE;
-	struct page *page;
-	int offset;
-
-	if (unlikely(!nc->va)) {
-refill:
-		page = __page_frag_cache_refill(nc, gfp_mask);
-		if (!page)
-			return NULL;
-
-#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
-		/* if size can vary use size else just use PAGE_SIZE */
-		size = nc->size;
-#endif
-		/* Even if we own the page, we do not use atomic_set().
-		 * This would break get_page_unless_zero() users.
-		 */
-		page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
-
-		/* reset page count bias and offset to start of new frag */
-		nc->pfmemalloc = page_is_pfmemalloc(page);
-		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
-		nc->offset = size;
-	}
-
-	offset = nc->offset - fragsz;
-	if (unlikely(offset < 0)) {
-		page = virt_to_page(nc->va);
-
-		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
-			goto refill;
-
-		if (unlikely(nc->pfmemalloc)) {
-			free_unref_page(page, compound_order(page));
-			goto refill;
-		}
-
-#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
-		/* if size can vary use size else just use PAGE_SIZE */
-		size = nc->size;
-#endif
-		/* OK, page count is 0, we can safely set it */
-		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
-
-		/* reset page count bias and offset to start of new frag */
-		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
-		offset = size - fragsz;
-		if (unlikely(offset < 0)) {
-			/*
-			 * The caller is trying to allocate a fragment
-			 * with fragsz > PAGE_SIZE but the cache isn't big
-			 * enough to satisfy the request, this may
-			 * happen in low memory conditions.
-			 * We don't release the cache page because
-			 * it could make memory pressure worse
-			 * so we simply return NULL here.
-			 */
-			return NULL;
-		}
-	}
-
-	nc->pagecnt_bias--;
-	offset &= align_mask;
-	nc->offset = offset;
-
-	return nc->va + offset;
-}
-EXPORT_SYMBOL(__page_frag_alloc_align);
-
-/*
- * Frees a page fragment allocated out of either a compound or order 0 page.
- */
-void page_frag_free(void *addr)
-{
-	struct page *page = virt_to_head_page(addr);
-
-	if (unlikely(put_page_testzero(page)))
-		free_unref_page(page, compound_order(page));
-}
-EXPORT_SYMBOL(page_frag_free);
-
 static void *make_alloc_exact(unsigned long addr, unsigned int order,
 		size_t size)
 {
diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
new file mode 100644
index 000000000000..609a485cd02a
--- /dev/null
+++ b/mm/page_frag_cache.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Page fragment allocator
+ *
+ * Page Fragment:
+ *  An arbitrary-length arbitrary-offset area of memory which resides within a
+ *  0 or higher order page.  Multiple fragments within that page are
+ *  individually refcounted, in the page's reference counter.
+ *
+ * The page_frag functions provide a simple allocation framework for page
+ * fragments.  This is used by the network stack and network device drivers to
+ * provide a backing region of memory for use as either an sk_buff->head, or to
+ * be used in the "frags" portion of skb_shared_info.
+ */
+
+#include <linux/export.h>
+#include <linux/gfp_types.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/page_frag_cache.h>
+#include "internal.h"
+
+static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
+					     gfp_t gfp_mask)
+{
+	struct page *page = NULL;
+	gfp_t gfp = gfp_mask;
+
+#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
+	gfp_mask = (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
+		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
+	page = alloc_pages_node(NUMA_NO_NODE, gfp_mask,
+				PAGE_FRAG_CACHE_MAX_ORDER);
+	nc->size = page ? PAGE_FRAG_CACHE_MAX_SIZE : PAGE_SIZE;
+#endif
+	if (unlikely(!page))
+		page = alloc_pages_node(NUMA_NO_NODE, gfp, 0);
+
+	nc->va = page ? page_address(page) : NULL;
+
+	return page;
+}
+
+void page_frag_cache_drain(struct page_frag_cache *nc)
+{
+	if (!nc->va)
+		return;
+
+	__page_frag_cache_drain(virt_to_head_page(nc->va), nc->pagecnt_bias);
+	nc->va = NULL;
+}
+EXPORT_SYMBOL(page_frag_cache_drain);
+
+void __page_frag_cache_drain(struct page *page, unsigned int count)
+{
+	VM_BUG_ON_PAGE(page_ref_count(page) == 0, page);
+
+	if (page_ref_sub_and_test(page, count))
+		free_unref_page(page, compound_order(page));
+}
+EXPORT_SYMBOL(__page_frag_cache_drain);
+
+void *__page_frag_alloc_align(struct page_frag_cache *nc,
+			      unsigned int fragsz, gfp_t gfp_mask,
+			      unsigned int align_mask)
+{
+	unsigned int size = PAGE_SIZE;
+	struct page *page;
+	int offset;
+
+	if (unlikely(!nc->va)) {
+refill:
+		page = __page_frag_cache_refill(nc, gfp_mask);
+		if (!page)
+			return NULL;
+
+#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
+		/* if size can vary use size else just use PAGE_SIZE */
+		size = nc->size;
+#endif
+		/* Even if we own the page, we do not use atomic_set().
+		 * This would break get_page_unless_zero() users.
+		 */
+		page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
+
+		/* reset page count bias and offset to start of new frag */
+		nc->pfmemalloc = page_is_pfmemalloc(page);
+		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
+		nc->offset = size;
+	}
+
+	offset = nc->offset - fragsz;
+	if (unlikely(offset < 0)) {
+		page = virt_to_page(nc->va);
+
+		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
+			goto refill;
+
+		if (unlikely(nc->pfmemalloc)) {
+			free_unref_page(page, compound_order(page));
+			goto refill;
+		}
+
+#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
+		/* if size can vary use size else just use PAGE_SIZE */
+		size = nc->size;
+#endif
+		/* OK, page count is 0, we can safely set it */
+		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
+
+		/* reset page count bias and offset to start of new frag */
+		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
+		offset = size - fragsz;
+		if (unlikely(offset < 0)) {
+			/*
+			 * The caller is trying to allocate a fragment
+			 * with fragsz > PAGE_SIZE but the cache isn't big
+			 * enough to satisfy the request, this may
+			 * happen in low memory conditions.
+			 * We don't release the cache page because
+			 * it could make memory pressure worse
+			 * so we simply return NULL here.
+			 */
+			return NULL;
+		}
+	}
+
+	nc->pagecnt_bias--;
+	offset &= align_mask;
+	nc->offset = offset;
+
+	return nc->va + offset;
+}
+EXPORT_SYMBOL(__page_frag_alloc_align);
+
+/*
+ * Frees a page fragment allocated out of either a compound or order 0 page.
+ */
+void page_frag_free(void *addr)
+{
+	struct page *page = virt_to_head_page(addr);
+
+	if (unlikely(put_page_testzero(page)))
+		free_unref_page(page, compound_order(page));
+}
+EXPORT_SYMBOL(page_frag_free);
diff --git a/tools/testing/selftests/mm/page_frag/page_frag_test.c b/tools/testing/selftests/mm/page_frag/page_frag_test.c
index 912d97b99107..13c44133e009 100644
--- a/tools/testing/selftests/mm/page_frag/page_frag_test.c
+++ b/tools/testing/selftests/mm/page_frag/page_frag_test.c
@@ -6,12 +6,12 @@
  * Copyright (C) 2024 Yunsheng Lin <linyunsheng@huawei.com>
  */
 
-#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/cpumask.h>
 #include <linux/completion.h>
 #include <linux/ptr_ring.h>
 #include <linux/kthread.h>
+#include <linux/page_frag_cache.h>
 
 #define TEST_FAILED_PREFIX	"page_frag_test failed: "
 
-- 
2.33.0


