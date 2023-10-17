Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437EE7CD05A
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 01:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344307AbjJQXV7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 19:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344288AbjJQXV5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 19:21:57 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABF6C4;
        Tue, 17 Oct 2023 16:21:55 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-3573e6dd79bso24309505ab.2;
        Tue, 17 Oct 2023 16:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697584915; x=1698189715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0yR7t4chcx/GxJlONbCjqRh/QEv995Kpd4l2i4wMTc=;
        b=TPwoyqic1o/ZRAljL4naDxOvkXIafEFLaEtyCFtKTS53/3/rBIfJDGYhZBc0gPM789
         2W4uKNOZAteFM9uRP54PDUv+1QavI52MVhAhEFa3F2Rn5dmR4BK4q1PnpKJ1Fb4/pkir
         g7EDziWNbjoa4ve4p2rPSeLZcBu1PWrAejWoXtJWxSpG/HlusmVhW5TG6Ondgf2wJFAB
         X3fYs4Y1XPtxZe3b5zzukv+UGzWyqaHaEVo2DAsJkMbADQ0rPAbD29lHImAhdbPclkPQ
         D7gNMRQGh93sqwilVl88R8ka2JuH67XuHhiI3BhcZosht2GZZ+TGKrc3TDeKOX+FKD2d
         w4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697584915; x=1698189715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0yR7t4chcx/GxJlONbCjqRh/QEv995Kpd4l2i4wMTc=;
        b=oTQ0S7l1BReQPwQ9otvzD5tL1du012mn3zEpqcKImy0g3ChB8dH/7hGrJ01M8uTRTo
         uaRil3mSRGQOnSOfUwncJvq+ehmUrW3YSBZm3LXvcDzrZ+S4VsgwVIPTMUIO87r5fBZw
         fvirBEn7Skt4QTsd/6AaxNnxmM6v5/qcg5F25CCrVU3M+rm0eaBy3nUV+G5BkoK2tQjg
         q8OWVU6qhcPm70Xl8c59pErJJHJMXLyiZrOIaqvvVfptmLLj4eMM/wyGU2rP7hi+zRTM
         pD1TYHoxlcvqVfLoFg+TdKz9i8H6EDPFxJzrOeMqopl9WHBDck33hSmrvXg78/w/ZACi
         Vt1w==
X-Gm-Message-State: AOJu0YxWrKs/hrfRk8OD8Wjc/fT6/8BRUX4adZemLaELSHE2TIdaC2UD
        xbEXCfcPoZd0gv9/JX/ZUnA=
X-Google-Smtp-Source: AGHT+IF492rntMEFZ92EzcGGf1iZwzrZ31rvADEXJ0KEnNifROSUNX57VqMh/sKZSN/YXQBPQRvKtQ==
X-Received: by 2002:a05:6e02:1b82:b0:34f:70ec:d4cf with SMTP id h2-20020a056e021b8200b0034f70ecd4cfmr4908802ili.8.1697584914772;
        Tue, 17 Oct 2023 16:21:54 -0700 (PDT)
Received: from localhost (fwdproxy-prn-012.fbsv.net. [2a03:2880:ff:c::face:b00c])
        by smtp.gmail.com with ESMTPSA id k125-20020a632483000000b005742092c211sm430376pgk.64.2023.10.17.16.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 16:21:54 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [PATCH v3 2/5] zswap: make shrinking memcg-aware
Date:   Tue, 17 Oct 2023 16:21:49 -0700
Message-Id: <20231017232152.2605440-3-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017232152.2605440-1-nphamcs@gmail.com>
References: <20231017232152.2605440-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Domenico Cerasuolo <cerasuolodomenico@gmail.com>

Currently, we only have a single global LRU for zswap. This makes it
impossible to perform worload-specific shrinking - an memcg cannot
determine which pages in the pool it owns, and often ends up writing
pages from other memcgs. This issue has been previously observed in
practice and mitigated by simply disabling memcg-initiated shrinking:

https://lore.kernel.org/all/20230530232435.3097106-1-nphamcs@gmail.com/T/#u

This patch fully resolves the issue by replacing the global zswap LRU
with memcg- and NUMA-specific LRUs, and modify the reclaim logic:

a) When a store attempt hits an memcg limit, it now triggers a
   synchronous reclaim attempt that, if successful, allows the new
   hotter page to be accepted by zswap.
b) If the store attempt instead hits the global zswap limit, it will
   trigger an asynchronous reclaim attempt, in which an memcg is
   selected for reclaim in a round-robin-like fashion.

Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Co-developed-by: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/memcontrol.h |   5 ++
 mm/swap.h                  |   3 +-
 mm/swap_state.c            |  17 +++-
 mm/zswap.c                 | 179 ++++++++++++++++++++++++++-----------
 4 files changed, 147 insertions(+), 57 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 031102ac9311..3de10fabea0f 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1179,6 +1179,11 @@ static inline struct mem_cgroup *page_memcg_check(struct page *page)
 	return NULL;
 }
 
+static inline struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
+{
+	return NULL;
+}
+
 static inline bool folio_memcg_kmem(struct folio *folio)
 {
 	return false;
diff --git a/mm/swap.h b/mm/swap.h
index 8a3c7a0ace4f..bbd6ce661a20 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -50,7 +50,8 @@ struct page *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 				     struct vm_area_struct *vma,
 				     unsigned long addr,
-				     bool *new_page_allocated);
+				     bool *new_page_allocated,
+				     bool fail_if_exists);
 struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
 				    struct vm_fault *vmf);
 struct page *swapin_readahead(swp_entry_t entry, gfp_t flag,
diff --git a/mm/swap_state.c b/mm/swap_state.c
index b3b14bd0dd64..0356df52b06a 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -411,7 +411,7 @@ struct folio *filemap_get_incore_folio(struct address_space *mapping,
 
 struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 			struct vm_area_struct *vma, unsigned long addr,
-			bool *new_page_allocated)
+			bool *new_page_allocated, bool fail_if_exists)
 {
 	struct swap_info_struct *si;
 	struct folio *folio;
@@ -468,6 +468,15 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		if (err != -EEXIST)
 			goto fail_put_swap;
 
+		/*
+		 * This check guards against a state that happens if a call
+		 * to __read_swap_cache_async triggers a reclaim, if the
+		 * reclaimer (zswap's writeback as of now) then decides to
+		 * reclaim that same entry, then the subsequent call to
+		 * __read_swap_cache_async would get stuck in this loop.
+		 */
+		if (fail_if_exists && err == -EEXIST)
+			goto fail_put_swap;
 		/*
 		 * We might race against __delete_from_swap_cache(), and
 		 * stumble across a swap_map entry whose SWAP_HAS_CACHE
@@ -530,7 +539,7 @@ struct page *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 {
 	bool page_was_allocated;
 	struct page *retpage = __read_swap_cache_async(entry, gfp_mask,
-			vma, addr, &page_was_allocated);
+			vma, addr, &page_was_allocated, false);
 
 	if (page_was_allocated)
 		swap_readpage(retpage, false, plug);
@@ -649,7 +658,7 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 		/* Ok, do the async read-ahead now */
 		page = __read_swap_cache_async(
 			swp_entry(swp_type(entry), offset),
-			gfp_mask, vma, addr, &page_allocated);
+			gfp_mask, vma, addr, &page_allocated, false);
 		if (!page)
 			continue;
 		if (page_allocated) {
@@ -815,7 +824,7 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 		pte_unmap(pte);
 		pte = NULL;
 		page = __read_swap_cache_async(entry, gfp_mask, vma,
-					       addr, &page_allocated);
+					       addr, &page_allocated, false);
 		if (!page)
 			continue;
 		if (page_allocated) {
diff --git a/mm/zswap.c b/mm/zswap.c
index 083c693602b8..d2989ad11814 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -34,6 +34,7 @@
 #include <linux/writeback.h>
 #include <linux/pagemap.h>
 #include <linux/workqueue.h>
+#include <linux/list_lru.h>
 
 #include "swap.h"
 #include "internal.h"
@@ -171,8 +172,8 @@ struct zswap_pool {
 	struct work_struct shrink_work;
 	struct hlist_node node;
 	char tfm_name[CRYPTO_MAX_ALG_NAME];
-	struct list_head lru;
-	spinlock_t lru_lock;
+	struct list_lru list_lru;
+	struct mem_cgroup *next_shrink;
 };
 
 /*
@@ -288,15 +289,25 @@ static void zswap_update_total_size(void)
 	zswap_pool_total_size = total;
 }
 
+static inline struct mem_cgroup *get_mem_cgroup_from_entry(struct zswap_entry *entry)
+{
+	return entry->objcg ? get_mem_cgroup_from_objcg(entry->objcg) : NULL;
+}
+
+static inline int entry_to_nid(struct zswap_entry *entry)
+{
+	return page_to_nid(virt_to_page(entry));
+}
+
 /*********************************
 * zswap entry functions
 **********************************/
 static struct kmem_cache *zswap_entry_cache;
 
-static struct zswap_entry *zswap_entry_cache_alloc(gfp_t gfp)
+static struct zswap_entry *zswap_entry_cache_alloc(gfp_t gfp, int nid)
 {
 	struct zswap_entry *entry;
-	entry = kmem_cache_alloc(zswap_entry_cache, gfp);
+	entry = kmem_cache_alloc_node(zswap_entry_cache, gfp, nid);
 	if (!entry)
 		return NULL;
 	entry->refcount = 1;
@@ -309,6 +320,27 @@ static void zswap_entry_cache_free(struct zswap_entry *entry)
 	kmem_cache_free(zswap_entry_cache, entry);
 }
 
+/*********************************
+* lru functions
+**********************************/
+static bool zswap_lru_add(struct list_lru *list_lru, struct zswap_entry *entry)
+{
+	struct mem_cgroup *memcg = get_mem_cgroup_from_entry(entry);
+	bool added = __list_lru_add(list_lru, &entry->lru, entry_to_nid(entry), memcg);
+
+	mem_cgroup_put(memcg);
+	return added;
+}
+
+static bool zswap_lru_del(struct list_lru *list_lru, struct zswap_entry *entry)
+{
+	struct mem_cgroup *memcg = get_mem_cgroup_from_entry(entry);
+	bool removed = __list_lru_del(list_lru, &entry->lru, entry_to_nid(entry), memcg);
+
+	mem_cgroup_put(memcg);
+	return removed;
+}
+
 /*********************************
 * rbtree functions
 **********************************/
@@ -393,9 +425,7 @@ static void zswap_free_entry(struct zswap_entry *entry)
 	if (!entry->length)
 		atomic_dec(&zswap_same_filled_pages);
 	else {
-		spin_lock(&entry->pool->lru_lock);
-		list_del(&entry->lru);
-		spin_unlock(&entry->pool->lru_lock);
+		zswap_lru_del(&entry->pool->list_lru, entry);
 		zpool_free(zswap_find_zpool(entry), entry->handle);
 		zswap_pool_put(entry->pool);
 	}
@@ -629,21 +659,16 @@ static void zswap_invalidate_entry(struct zswap_tree *tree,
 		zswap_entry_put(tree, entry);
 }
 
-static int zswap_reclaim_entry(struct zswap_pool *pool)
+static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_one *l,
+				       spinlock_t *lock, void *arg)
 {
-	struct zswap_entry *entry;
+	struct zswap_entry *entry = container_of(item, struct zswap_entry, lru);
+	struct mem_cgroup *memcg;
 	struct zswap_tree *tree;
 	pgoff_t swpoffset;
-	int ret;
+	enum lru_status ret = LRU_REMOVED_RETRY;
+	int writeback_result;
 
-	/* Get an entry off the LRU */
-	spin_lock(&pool->lru_lock);
-	if (list_empty(&pool->lru)) {
-		spin_unlock(&pool->lru_lock);
-		return -EINVAL;
-	}
-	entry = list_last_entry(&pool->lru, struct zswap_entry, lru);
-	list_del_init(&entry->lru);
 	/*
 	 * Once the lru lock is dropped, the entry might get freed. The
 	 * swpoffset is copied to the stack, and entry isn't deref'd again
@@ -651,28 +676,33 @@ static int zswap_reclaim_entry(struct zswap_pool *pool)
 	 */
 	swpoffset = swp_offset(entry->swpentry);
 	tree = zswap_trees[swp_type(entry->swpentry)];
-	spin_unlock(&pool->lru_lock);
+	list_lru_isolate(l, item);
+	spin_unlock(lock);
 
 	/* Check for invalidate() race */
 	spin_lock(&tree->lock);
 	if (entry != zswap_rb_search(&tree->rbroot, swpoffset)) {
-		ret = -EAGAIN;
 		goto unlock;
 	}
 	/* Hold a reference to prevent a free during writeback */
 	zswap_entry_get(entry);
 	spin_unlock(&tree->lock);
 
-	ret = zswap_writeback_entry(entry, tree);
+	writeback_result = zswap_writeback_entry(entry, tree);
 
 	spin_lock(&tree->lock);
-	if (ret) {
-		/* Writeback failed, put entry back on LRU */
-		spin_lock(&pool->lru_lock);
-		list_move(&entry->lru, &pool->lru);
-		spin_unlock(&pool->lru_lock);
+	if (writeback_result) {
+		zswap_reject_reclaim_fail++;
+		memcg = get_mem_cgroup_from_entry(entry);
+		spin_lock(lock);
+		/* we cannot use zswap_lru_add here, because it increments node's lru count */
+		list_lru_putback(&entry->pool->list_lru, item, entry_to_nid(entry), memcg);
+		spin_unlock(lock);
+		mem_cgroup_put(memcg);
+		ret = LRU_RETRY;
 		goto put_unlock;
 	}
+	zswap_written_back_pages++;
 
 	/*
 	 * Writeback started successfully, the page now belongs to the
@@ -686,7 +716,36 @@ static int zswap_reclaim_entry(struct zswap_pool *pool)
 	zswap_entry_put(tree, entry);
 unlock:
 	spin_unlock(&tree->lock);
-	return ret ? -EAGAIN : 0;
+	spin_lock(lock);
+	return ret;
+}
+
+static int shrink_memcg(struct mem_cgroup *memcg)
+{
+	struct zswap_pool *pool;
+	int nid, shrunk = 0;
+
+	pool = zswap_pool_current_get();
+	if (!pool)
+		return -EINVAL;
+
+	/*
+	 * Skip zombies because their LRUs are reparented and we would be
+	 * reclaiming from the parent instead of the dead memcgroup.
+	 */
+	if (memcg && !mem_cgroup_online(memcg))
+		goto out;
+
+	for_each_node_state(nid, N_NORMAL_MEMORY) {
+		unsigned long nr_to_walk = 1;
+
+		if (list_lru_walk_one(&pool->list_lru, nid, memcg, &shrink_memcg_cb,
+				      NULL, &nr_to_walk))
+			shrunk++;
+	}
+out:
+	zswap_pool_put(pool);
+	return shrunk ? 0 : -EAGAIN;
 }
 
 static void shrink_worker(struct work_struct *w)
@@ -695,10 +754,13 @@ static void shrink_worker(struct work_struct *w)
 						shrink_work);
 	int ret, failures = 0;
 
+	/* global reclaim will select cgroup in a round-robin fashion. */
 	do {
-		ret = zswap_reclaim_entry(pool);
+		pool->next_shrink = mem_cgroup_iter(NULL, pool->next_shrink, NULL);
+
+		ret = shrink_memcg(pool->next_shrink);
+
 		if (ret) {
-			zswap_reject_reclaim_fail++;
 			if (ret != -EAGAIN)
 				break;
 			if (++failures == MAX_RECLAIM_RETRIES)
@@ -764,8 +826,7 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 	 */
 	kref_init(&pool->kref);
 	INIT_LIST_HEAD(&pool->list);
-	INIT_LIST_HEAD(&pool->lru);
-	spin_lock_init(&pool->lru_lock);
+	list_lru_init_memcg(&pool->list_lru, NULL);
 	INIT_WORK(&pool->shrink_work, shrink_worker);
 
 	zswap_pool_debug("created", pool);
@@ -831,6 +892,9 @@ static void zswap_pool_destroy(struct zswap_pool *pool)
 
 	cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &pool->node);
 	free_percpu(pool->acomp_ctx);
+	list_lru_destroy(&pool->list_lru);
+	if (pool->next_shrink)
+		mem_cgroup_put(pool->next_shrink);
 	for (i = 0; i < ZSWAP_NR_ZPOOLS; i++)
 		zpool_destroy_pool(pool->zpools[i]);
 	kfree(pool);
@@ -1076,7 +1140,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 
 	/* try to allocate swap cache page */
 	page = __read_swap_cache_async(swpentry, GFP_KERNEL, NULL, 0,
-				       &page_was_allocated);
+				       &page_was_allocated, true);
 	if (!page) {
 		ret = -ENOMEM;
 		goto fail;
@@ -1142,7 +1206,6 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	/* start writeback */
 	__swap_writepage(page, &wbc);
 	put_page(page);
-	zswap_written_back_pages++;
 
 	return ret;
 
@@ -1199,8 +1262,10 @@ bool zswap_store(struct folio *folio)
 	struct scatterlist input, output;
 	struct crypto_acomp_ctx *acomp_ctx;
 	struct obj_cgroup *objcg = NULL;
+	struct mem_cgroup *memcg = NULL;
 	struct zswap_pool *pool;
 	struct zpool *zpool;
+	int lru_alloc_ret;
 	unsigned int dlen = PAGE_SIZE;
 	unsigned long handle, value;
 	char *buf;
@@ -1230,15 +1295,15 @@ bool zswap_store(struct folio *folio)
 		zswap_invalidate_entry(tree, dupentry);
 	}
 	spin_unlock(&tree->lock);
-
-	/*
-	 * XXX: zswap reclaim does not work with cgroups yet. Without a
-	 * cgroup-aware entry LRU, we will push out entries system-wide based on
-	 * local cgroup limits.
-	 */
 	objcg = get_obj_cgroup_from_folio(folio);
-	if (objcg && !obj_cgroup_may_zswap(objcg))
-		goto reject;
+	if (objcg && !obj_cgroup_may_zswap(objcg)) {
+		memcg = get_mem_cgroup_from_objcg(objcg);
+		if (shrink_memcg(memcg)) {
+			mem_cgroup_put(memcg);
+			goto reject;
+		}
+		mem_cgroup_put(memcg);
+	}
 
 	/* reclaim space if needed */
 	if (zswap_is_full()) {
@@ -1254,10 +1319,15 @@ bool zswap_store(struct folio *folio)
 			zswap_pool_reached_full = false;
 	}
 
+	pool = zswap_pool_current_get();
+	if (!pool)
+		goto reject;
+
 	/* allocate entry */
-	entry = zswap_entry_cache_alloc(GFP_KERNEL);
+	entry = zswap_entry_cache_alloc(GFP_KERNEL, page_to_nid(page));
 	if (!entry) {
 		zswap_reject_kmemcache_fail++;
+		zswap_pool_put(pool);
 		goto reject;
 	}
 
@@ -1269,6 +1339,7 @@ bool zswap_store(struct folio *folio)
 			entry->length = 0;
 			entry->value = value;
 			atomic_inc(&zswap_same_filled_pages);
+			zswap_pool_put(pool);
 			goto insert_entry;
 		}
 		kunmap_atomic(src);
@@ -1278,9 +1349,15 @@ bool zswap_store(struct folio *folio)
 		goto freepage;
 
 	/* if entry is successfully added, it keeps the reference */
-	entry->pool = zswap_pool_current_get();
-	if (!entry->pool)
-		goto freepage;
+	entry->pool = pool;
+	if (objcg) {
+		memcg = get_mem_cgroup_from_objcg(objcg);
+		lru_alloc_ret = memcg_list_lru_alloc(memcg, &pool->list_lru, GFP_KERNEL);
+		mem_cgroup_put(memcg);
+
+		if (lru_alloc_ret)
+			goto freepage;
+	}
 
 	/* compress */
 	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
@@ -1358,9 +1435,8 @@ bool zswap_store(struct folio *folio)
 		zswap_invalidate_entry(tree, dupentry);
 	}
 	if (entry->length) {
-		spin_lock(&entry->pool->lru_lock);
-		list_add(&entry->lru, &entry->pool->lru);
-		spin_unlock(&entry->pool->lru_lock);
+		INIT_LIST_HEAD(&entry->lru);
+		zswap_lru_add(&pool->list_lru, entry);
 	}
 	spin_unlock(&tree->lock);
 
@@ -1373,8 +1449,8 @@ bool zswap_store(struct folio *folio)
 
 put_dstmem:
 	mutex_unlock(acomp_ctx->mutex);
-	zswap_pool_put(entry->pool);
 freepage:
+	zswap_pool_put(entry->pool);
 	zswap_entry_cache_free(entry);
 reject:
 	if (objcg)
@@ -1467,9 +1543,8 @@ bool zswap_load(struct folio *folio)
 		zswap_invalidate_entry(tree, entry);
 		folio_mark_dirty(folio);
 	} else if (entry->length) {
-		spin_lock(&entry->pool->lru_lock);
-		list_move(&entry->lru, &entry->pool->lru);
-		spin_unlock(&entry->pool->lru_lock);
+		zswap_lru_del(&entry->pool->list_lru, entry);
+		zswap_lru_add(&entry->pool->list_lru, entry);
 	}
 	zswap_entry_put(tree, entry);
 	spin_unlock(&tree->lock);
-- 
2.34.1
