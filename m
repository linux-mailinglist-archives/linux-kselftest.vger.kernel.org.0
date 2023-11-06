Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB2E7E2BFC
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Nov 2023 19:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbjKFScR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Nov 2023 13:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbjKFScH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Nov 2023 13:32:07 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C41D4D;
        Mon,  6 Nov 2023 10:32:04 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5b99bfca064so3098488a12.3;
        Mon, 06 Nov 2023 10:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699295523; x=1699900323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLPnyP0RaynBJicEAOxae+atCQWtlTDNIjOFc7rQd7s=;
        b=a6w8iggSIX6RYGE/SNMBHDw5ibVVBYbG8rjXYe5mt6fnTZ050W3wrfmmuU3ADTjZyS
         wH1lHJFBJ6ZsBAdeZ2fCAaXLpJ4XAErA556H9PEzxnlgRxdqVf4o510L/A/KsPZOi64W
         Y4qZsLyJNU4w1f62MN568rODgttFlt6CXP2n2Jcd1+ydzL6kMZzqgWN5gb6QaDgQe6Ej
         qM4MCUl6/xmB/pv5/UjeG41Y663+loxLB3yB0NFM/oRKPkGxoiFD4v0cT6Jn9ApC1Ewy
         j3XpJkQwharSbYEDMt6qeqRYP+zQhtMVGM8f+2MDJwB9BodKQYGQvisTBQ6UCQXsqMSq
         F5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699295523; x=1699900323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLPnyP0RaynBJicEAOxae+atCQWtlTDNIjOFc7rQd7s=;
        b=f9nbys5cxssrL2QAUHKcILBt9bXK7aUlfBxT7t49WUWVRqAtbhhIWA4gyXUMd1NfBo
         0WHAcQ6DQou4Vakoa3DGEySFlVRhh6P5dYJ5ZGWRhe1novd7/aKFZFs14zpT1ottCyUl
         v6oHfSd2HFMwB0eJzUwsO4guEG1Ew1Y1fqz5Izbwv7m9fjTTQTilC2Iq0Fh0kRgcFqQL
         BDB3bi+9cH1seJxB0cGdDKNZ2HHN74w2ZoOhR1/c2lHSXz0DJIr9xx4lb9vlY23wMEmt
         MFgvi3eaMt7EgvbVWW4IZpIKlVYumE7qffPP0a9sMpAtzerl7Ldvi5C1BvJuMbzCT2tZ
         xSnA==
X-Gm-Message-State: AOJu0YwwVrM0+O4/Gw09QY6F/jFGA6gQec5tHZKnnv7wpbJsbu5VEnno
        s1DYkywv000xn63TlII2E5A=
X-Google-Smtp-Source: AGHT+IHLadiF672x0FUJEhI9uPXAzFqdH8ZA0VHMO8fhwfSJYioG6QuQm0IBydiy65qnzpPAPUU1IA==
X-Received: by 2002:a17:902:d484:b0:1cc:361b:7b28 with SMTP id c4-20020a170902d48400b001cc361b7b28mr24335746plg.64.1699295523478;
        Mon, 06 Nov 2023 10:32:03 -0800 (PST)
Received: from localhost (fwdproxy-prn-009.fbsv.net. [2a03:2880:ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id u22-20020a1709026e1600b001c5dea67c26sm6357160plk.233.2023.11.06.10.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 10:32:02 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: [PATCH v5 3/6] zswap: make shrinking memcg-aware
Date:   Mon,  6 Nov 2023 10:31:56 -0800
Message-Id: <20231106183159.3562879-4-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106183159.3562879-1-nphamcs@gmail.com>
References: <20231106183159.3562879-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 include/linux/memcontrol.h |   5 +
 include/linux/zswap.h      |   2 +
 mm/memcontrol.c            |   2 +
 mm/swap.h                  |   3 +-
 mm/swap_state.c            |  24 +++-
 mm/zswap.c                 | 252 +++++++++++++++++++++++++++++--------
 6 files changed, 227 insertions(+), 61 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 55c85f952afd..95f6c9e60ed1 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1187,6 +1187,11 @@ static inline struct mem_cgroup *page_memcg_check(struct page *page)
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
diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index 2a60ce39cfde..e571e393669b 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -15,6 +15,7 @@ bool zswap_load(struct folio *folio);
 void zswap_invalidate(int type, pgoff_t offset);
 void zswap_swapon(int type);
 void zswap_swapoff(int type);
+void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg);
 
 #else
 
@@ -31,6 +32,7 @@ static inline bool zswap_load(struct folio *folio)
 static inline void zswap_invalidate(int type, pgoff_t offset) {}
 static inline void zswap_swapon(int type) {}
 static inline void zswap_swapoff(int type) {}
+static inline void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg) {}
 
 #endif
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6f7fc0101252..2ef49b471a16 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5640,6 +5640,8 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	page_counter_set_min(&memcg->memory, 0);
 	page_counter_set_low(&memcg->memory, 0);
 
+	zswap_memcg_offline_cleanup(memcg);
+
 	memcg_offline_kmem(memcg);
 	reparent_shrinker_deferred(memcg);
 	wb_memcg_offline(memcg);
diff --git a/mm/swap.h b/mm/swap.h
index 73c332ee4d91..c0dc73e10e91 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -51,7 +51,8 @@ struct page *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 				   struct swap_iocb **plug);
 struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 				     struct mempolicy *mpol, pgoff_t ilx,
-				     bool *new_page_allocated);
+				     bool *new_page_allocated,
+				     bool skip_if_exists);
 struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
 				    struct mempolicy *mpol, pgoff_t ilx);
 struct page *swapin_readahead(swp_entry_t entry, gfp_t flag,
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 85d9e5806a6a..6c84236382f3 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -412,7 +412,8 @@ struct folio *filemap_get_incore_folio(struct address_space *mapping,
 
 struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 				     struct mempolicy *mpol, pgoff_t ilx,
-				     bool *new_page_allocated)
+				     bool *new_page_allocated,
+				     bool skip_if_exists)
 {
 	struct swap_info_struct *si;
 	struct folio *folio;
@@ -470,6 +471,17 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		if (err != -EEXIST)
 			goto fail_put_swap;
 
+		/*
+		 * Protect against a recursive call to __read_swap_cache_async()
+		 * on the same entry waiting forever here because SWAP_HAS_CACHE
+		 * is set but the folio is not the swap cache yet. This can
+		 * happen today if mem_cgroup_swapin_charge_folio() below
+		 * triggers reclaim through zswap, which may call
+		 * __read_swap_cache_async() in the writeback path.
+		 */
+		if (skip_if_exists)
+			goto fail_put_swap;
+
 		/*
 		 * We might race against __delete_from_swap_cache(), and
 		 * stumble across a swap_map entry whose SWAP_HAS_CACHE
@@ -537,7 +549,7 @@ struct page *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 
 	mpol = get_vma_policy(vma, addr, 0, &ilx);
 	page = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
-					&page_allocated);
+					&page_allocated, false);
 	mpol_cond_put(mpol);
 
 	if (page_allocated)
@@ -654,7 +666,7 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 		/* Ok, do the async read-ahead now */
 		page = __read_swap_cache_async(
 				swp_entry(swp_type(entry), offset),
-				gfp_mask, mpol, ilx, &page_allocated);
+				gfp_mask, mpol, ilx, &page_allocated, false);
 		if (!page)
 			continue;
 		if (page_allocated) {
@@ -672,7 +684,7 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 skip:
 	/* The page was likely read above, so no need for plugging here */
 	page = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
-					&page_allocated);
+					&page_allocated, false);
 	if (unlikely(page_allocated))
 		swap_readpage(page, false, NULL);
 	return page;
@@ -827,7 +839,7 @@ static struct page *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 		pte_unmap(pte);
 		pte = NULL;
 		page = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
-						&page_allocated);
+						&page_allocated, false);
 		if (!page)
 			continue;
 		if (page_allocated) {
@@ -847,7 +859,7 @@ static struct page *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 skip:
 	/* The page was likely read above, so no need for plugging here */
 	page = __read_swap_cache_async(targ_entry, gfp_mask, mpol, targ_ilx,
-					&page_allocated);
+					&page_allocated, false);
 	if (unlikely(page_allocated))
 		swap_readpage(page, false, NULL);
 	return page;
diff --git a/mm/zswap.c b/mm/zswap.c
index 2e691cd1a466..2654b0d214cc 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -35,6 +35,7 @@
 #include <linux/writeback.h>
 #include <linux/pagemap.h>
 #include <linux/workqueue.h>
+#include <linux/list_lru.h>
 
 #include "swap.h"
 #include "internal.h"
@@ -172,8 +173,9 @@ struct zswap_pool {
 	struct work_struct shrink_work;
 	struct hlist_node node;
 	char tfm_name[CRYPTO_MAX_ALG_NAME];
-	struct list_head lru;
-	spinlock_t lru_lock;
+	struct list_lru list_lru;
+	spinlock_t next_shrink_lock;
+	struct mem_cgroup *next_shrink;
 };
 
 /*
@@ -289,15 +291,42 @@ static void zswap_update_total_size(void)
 	zswap_pool_total_size = total;
 }
 
+/* should be called under RCU */
+static inline struct mem_cgroup *get_mem_cgroup_from_entry(struct zswap_entry *entry)
+{
+	return entry->objcg ? obj_cgroup_memcg(entry->objcg) : NULL;
+}
+
+static inline int entry_to_nid(struct zswap_entry *entry)
+{
+	return page_to_nid(virt_to_page(entry));
+}
+
+void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
+{
+	struct zswap_pool *pool;
+
+	/* lock out zswap pools list modification */
+	spin_lock(&zswap_pools_lock);
+	list_for_each_entry(pool, &zswap_pools, list) {
+		spin_lock(&pool->next_shrink_lock);
+		if (pool->next_shrink == memcg)
+			pool->next_shrink =
+				mem_cgroup_iter(NULL, pool->next_shrink, NULL, true);
+		spin_unlock(&pool->next_shrink_lock);
+	}
+	spin_unlock(&zswap_pools_lock);
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
@@ -310,6 +339,61 @@ static void zswap_entry_cache_free(struct zswap_entry *entry)
 	kmem_cache_free(zswap_entry_cache, entry);
 }
 
+/*********************************
+* lru functions
+**********************************/
+static void zswap_lru_add(struct list_lru *list_lru, struct zswap_entry *entry)
+{
+	int nid = entry_to_nid(entry);
+	struct mem_cgroup *memcg;
+
+	/*
+	 * Note that it is safe to use rcu_read_lock() here, even in the face of
+	 * concurrent memcg offlining. Thanks to the memcg->kmemcg_id indirection
+	 * used in list_lru lookup, only two scenarios are possible:
+	 *
+	 * 1. list_lru_add() is called before memcg->kmemcg_id is updated. The
+	 *    new entry will be reparented to memcg's parent's list_lru.
+	 * 2. list_lru_add() is called after memcg->kmemcg_id is updated. The
+	 *    new entry will be added directly to memcg's parent's list_lru.
+	 *
+	 * Similar reasoning holds for list_lru_del() and list_lru_putback().
+	 */
+	rcu_read_lock();
+	memcg = get_mem_cgroup_from_entry(entry);
+	/* will always succeed */
+	list_lru_add(list_lru, &entry->lru, nid, memcg);
+	rcu_read_unlock();
+}
+
+static void zswap_lru_del(struct list_lru *list_lru, struct zswap_entry *entry)
+{
+	int nid = entry_to_nid(entry);
+	struct mem_cgroup *memcg;
+
+	rcu_read_lock();
+	memcg = get_mem_cgroup_from_entry(entry);
+	/* will always succeed */
+	list_lru_del(list_lru, &entry->lru, nid, memcg);
+	rcu_read_unlock();
+}
+
+static void zswap_lru_putback(struct list_lru *list_lru,
+		struct zswap_entry *entry)
+{
+	int nid = entry_to_nid(entry);
+	spinlock_t *lock = &list_lru->node[nid].lock;
+	struct mem_cgroup *memcg;
+
+	rcu_read_lock();
+	memcg = get_mem_cgroup_from_entry(entry);
+	spin_lock(lock);
+	/* we cannot use list_lru_add here, because it increments node's lru count */
+	list_lru_putback(list_lru, &entry->lru, nid, memcg);
+	spin_unlock(lock);
+	rcu_read_unlock();
+}
+
 /*********************************
 * rbtree functions
 **********************************/
@@ -394,9 +478,7 @@ static void zswap_free_entry(struct zswap_entry *entry)
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
@@ -630,21 +712,15 @@ static void zswap_invalidate_entry(struct zswap_tree *tree,
 		zswap_entry_put(tree, entry);
 }
 
-static int zswap_reclaim_entry(struct zswap_pool *pool)
+static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_one *l,
+				       spinlock_t *lock, void *arg)
 {
-	struct zswap_entry *entry;
+	struct zswap_entry *entry = container_of(item, struct zswap_entry, lru);
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
@@ -652,28 +728,32 @@ static int zswap_reclaim_entry(struct zswap_pool *pool)
 	 */
 	swpoffset = swp_offset(entry->swpentry);
 	tree = zswap_trees[swp_type(entry->swpentry)];
-	spin_unlock(&pool->lru_lock);
+	list_lru_isolate(l, item);
+	/*
+	 * It's safe to drop the lock here because we return either
+	 * LRU_REMOVED_RETRY or LRU_RETRY.
+	 */
+	spin_unlock(lock);
 
 	/* Check for invalidate() race */
 	spin_lock(&tree->lock);
-	if (entry != zswap_rb_search(&tree->rbroot, swpoffset)) {
-		ret = -EAGAIN;
+	if (entry != zswap_rb_search(&tree->rbroot, swpoffset))
 		goto unlock;
-	}
+
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
+		zswap_lru_putback(&entry->pool->list_lru, entry);
+		ret = LRU_RETRY;
 		goto put_unlock;
 	}
+	zswap_written_back_pages++;
 
 	/*
 	 * Writeback started successfully, the page now belongs to the
@@ -687,27 +767,76 @@ static int zswap_reclaim_entry(struct zswap_pool *pool)
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
+	/*
+	 * Skip zombies because their LRUs are reparented and we would be
+	 * reclaiming from the parent instead of the dead memcg.
+	 */
+	if (memcg && !mem_cgroup_online(memcg))
+		return -ENOENT;
+
+	pool = zswap_pool_current_get();
+	if (!pool)
+		return -EINVAL;
+
+	for_each_node_state(nid, N_NORMAL_MEMORY) {
+		unsigned long nr_to_walk = 1;
+
+		shrunk += list_lru_walk_one(&pool->list_lru, nid, memcg,
+					    &shrink_memcg_cb, NULL, &nr_to_walk);
+	}
+	zswap_pool_put(pool);
+	return shrunk ? 0 : -EAGAIN;
 }
 
 static void shrink_worker(struct work_struct *w)
 {
 	struct zswap_pool *pool = container_of(w, typeof(*pool),
 						shrink_work);
+	struct mem_cgroup *memcg;
 	int ret, failures = 0;
 
+	/* global reclaim will select cgroup in a round-robin fashion. */
 	do {
-		ret = zswap_reclaim_entry(pool);
-		if (ret) {
-			zswap_reject_reclaim_fail++;
-			if (ret != -EAGAIN)
-				break;
+		spin_lock(&pool->next_shrink_lock);
+		memcg = pool->next_shrink =
+			mem_cgroup_iter(NULL, pool->next_shrink, NULL, true);
+
+		/* full round trip */
+		if (!memcg) {
+			spin_unlock(&pool->next_shrink_lock);
 			if (++failures == MAX_RECLAIM_RETRIES)
 				break;
+
+			goto resched;
 		}
+
+		/*
+		 * Acquire an extra reference to the iterated memcg in case the
+		 * original reference is dropped by the zswap offlining callback.
+		 */
+		css_get(&memcg->css);
+		spin_unlock(&pool->next_shrink_lock);
+
+		ret = shrink_memcg(memcg);
+		mem_cgroup_put(memcg);
+
+		if (ret == -EINVAL)
+			break;
+		if (ret && ++failures == MAX_RECLAIM_RETRIES)
+			break;
+
+resched:
 		cond_resched();
 	} while (!zswap_can_accept());
-	zswap_pool_put(pool);
 }
 
 static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
@@ -765,11 +894,11 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 	 */
 	kref_init(&pool->kref);
 	INIT_LIST_HEAD(&pool->list);
-	INIT_LIST_HEAD(&pool->lru);
-	spin_lock_init(&pool->lru_lock);
+	list_lru_init_memcg(&pool->list_lru, NULL);
 	INIT_WORK(&pool->shrink_work, shrink_worker);
 
 	zswap_pool_debug("created", pool);
+	spin_lock_init(&pool->next_shrink_lock);
 
 	return pool;
 
@@ -832,6 +961,13 @@ static void zswap_pool_destroy(struct zswap_pool *pool)
 
 	cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &pool->node);
 	free_percpu(pool->acomp_ctx);
+	list_lru_destroy(&pool->list_lru);
+
+	spin_lock(&pool->next_shrink_lock);
+	mem_cgroup_put(pool->next_shrink);
+	pool->next_shrink = NULL;
+	spin_unlock(&pool->next_shrink_lock);
+
 	for (i = 0; i < ZSWAP_NR_ZPOOLS; i++)
 		zpool_destroy_pool(pool->zpools[i]);
 	kfree(pool);
@@ -1079,7 +1215,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	/* try to allocate swap cache page */
 	mpol = get_task_policy(current);
 	page = __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
-			NO_INTERLEAVE_INDEX, &page_was_allocated);
+			NO_INTERLEAVE_INDEX, &page_was_allocated, true);
 	if (!page) {
 		ret = -ENOMEM;
 		goto fail;
@@ -1145,7 +1281,6 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	/* start writeback */
 	__swap_writepage(page, &wbc);
 	put_page(page);
-	zswap_written_back_pages++;
 
 	return ret;
 
@@ -1202,6 +1337,7 @@ bool zswap_store(struct folio *folio)
 	struct scatterlist input, output;
 	struct crypto_acomp_ctx *acomp_ctx;
 	struct obj_cgroup *objcg = NULL;
+	struct mem_cgroup *memcg = NULL;
 	struct zswap_pool *pool;
 	struct zpool *zpool;
 	unsigned int dlen = PAGE_SIZE;
@@ -1233,15 +1369,15 @@ bool zswap_store(struct folio *folio)
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
@@ -1258,7 +1394,7 @@ bool zswap_store(struct folio *folio)
 	}
 
 	/* allocate entry */
-	entry = zswap_entry_cache_alloc(GFP_KERNEL);
+	entry = zswap_entry_cache_alloc(GFP_KERNEL, page_to_nid(page));
 	if (!entry) {
 		zswap_reject_kmemcache_fail++;
 		goto reject;
@@ -1285,6 +1421,15 @@ bool zswap_store(struct folio *folio)
 	if (!entry->pool)
 		goto freepage;
 
+	if (objcg) {
+		memcg = get_mem_cgroup_from_objcg(objcg);
+		if (memcg_list_lru_alloc(memcg, &entry->pool->list_lru, GFP_KERNEL)) {
+			mem_cgroup_put(memcg);
+			goto put_pool;
+		}
+		mem_cgroup_put(memcg);
+	}
+
 	/* compress */
 	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
 
@@ -1361,9 +1506,8 @@ bool zswap_store(struct folio *folio)
 		zswap_invalidate_entry(tree, dupentry);
 	}
 	if (entry->length) {
-		spin_lock(&entry->pool->lru_lock);
-		list_add(&entry->lru, &entry->pool->lru);
-		spin_unlock(&entry->pool->lru_lock);
+		INIT_LIST_HEAD(&entry->lru);
+		zswap_lru_add(&entry->pool->list_lru, entry);
 	}
 	spin_unlock(&tree->lock);
 
@@ -1376,6 +1520,7 @@ bool zswap_store(struct folio *folio)
 
 put_dstmem:
 	mutex_unlock(acomp_ctx->mutex);
+put_pool:
 	zswap_pool_put(entry->pool);
 freepage:
 	zswap_entry_cache_free(entry);
@@ -1470,9 +1615,8 @@ bool zswap_load(struct folio *folio)
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
