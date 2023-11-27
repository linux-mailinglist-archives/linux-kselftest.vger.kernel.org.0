Return-Path: <linux-kselftest+bounces-661-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F117FAA6A
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 20:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2388DB210F5
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 19:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AC24595B;
	Mon, 27 Nov 2023 19:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3cY458S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E739AD5A;
	Mon, 27 Nov 2023 11:37:07 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cf89e31773so31024365ad.0;
        Mon, 27 Nov 2023 11:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701113827; x=1701718627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JsvpM2sicZ1ksZpV1CZVXoYdic5VxaRuqwpzIK01Mo=;
        b=I3cY458SBrKE/XZcvx91b3yGxN95D9Jrs5k6czqT2BZYfnUwLhto/4/791qXMd7pGT
         +eBgeroyJnnCQJV/s4wZHwWNYJV+L2Fd4L3GPp8qzuZROAMC7S96iE6snn3/7BBZfHUH
         VuBwLpiv9cQb466qosieMaERG+CC1UbPaMFVXQy9LCsXutxboFi3T3MS9+hE+Qg6bz8v
         +eMFk0hPvUx2mJkfgVezquVuhZfGaChD+Z+RUrkWOQ/8M3XwfPVa9+bZc6vO8zUAqV/Q
         RA+CrAD391iWz4YGMGYKGke2oTAk+cRKJRrwoDPeR4pHoDNE6ZgqZVUsybyU0quL+Rj2
         lCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701113827; x=1701718627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5JsvpM2sicZ1ksZpV1CZVXoYdic5VxaRuqwpzIK01Mo=;
        b=tk22n1UCxa6YtEY27d3cGaqzFAp31NUmAGYsEpomWd3TJQVRxTnq2cVslXVexkj33c
         l2mtR9WzZ//HyFz4Ge2Dqt15/LzlpN+tAerlOaFW6HakCdhl03wqv3o+pHy3JRjxQjW0
         Z8j07dRV9ZsP7u0XshABZigkAiQE1KnNoiDw4th3/6D4aTR2POCNQmDfdRvveXdBEHE6
         iYE57mxI/0qHaHh1//NHDCP+WtAnuf6SWHi8U5r24hdIbb/XW9vAHc5Pr7MeuNDPeTJO
         +PIO06kU6lRULsVhAOBCt0YVXK/e/MPbCV4drrZrqugf2HzDobJmRZTPHGB4u4HUOJ2s
         deLw==
X-Gm-Message-State: AOJu0YzANWDI7zCsMCcKXvcRQ2K9vM/DiXXV1eO8iqxje5S3Xw8ftgdh
	9pPJD5zmz473siNuULhFXWe1TOvLVcY=
X-Google-Smtp-Source: AGHT+IEYrVmJL31hI65NJSE2/9kkrEVs5x+/KAxcv3YqU4dynNSKT67FqWq3hsRVWHyOjR+/j8P3Ig==
X-Received: by 2002:a17:903:25d1:b0:1cf:5782:7c74 with SMTP id jc17-20020a17090325d100b001cf57827c74mr10365049plb.7.1701113827164;
        Mon, 27 Nov 2023 11:37:07 -0800 (PST)
Received: from localhost (fwdproxy-prn-027.fbsv.net. [2a03:2880:ff:1b::face:b00c])
        by smtp.gmail.com with ESMTPSA id y5-20020a17090322c500b001cf5d0e7e05sm8620148plg.109.2023.11.27.11.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 11:37:06 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	cerasuolodomenico@gmail.com,
	yosryahmed@google.com,
	sjenning@redhat.com,
	ddstreet@ieee.org,
	vitaly.wool@konsulko.com,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeelb@google.com,
	muchun.song@linux.dev,
	chrisl@kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org
Subject: [PATCH v6 3/6] zswap: make shrinking memcg-aware
Date: Mon, 27 Nov 2023 11:37:00 -0800
Message-Id: <20231127193703.1980089-4-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127193703.1980089-1-nphamcs@gmail.com>
References: <20231127193703.1980089-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 mm/zswap.c                 | 248 +++++++++++++++++++++++++++++--------
 6 files changed, 223 insertions(+), 61 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 86adce081a08..83590fd0d6d1 100644
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
index a1f051adaa15..0399aec8c0e3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5617,6 +5617,8 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
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
index 030cc137138f..e441cbcab9a9 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -35,6 +35,7 @@
 #include <linux/writeback.h>
 #include <linux/pagemap.h>
 #include <linux/workqueue.h>
+#include <linux/list_lru.h>
 
 #include "swap.h"
 #include "internal.h"
@@ -174,8 +175,8 @@ struct zswap_pool {
 	struct work_struct shrink_work;
 	struct hlist_node node;
 	char tfm_name[CRYPTO_MAX_ALG_NAME];
-	struct list_head lru;
-	spinlock_t lru_lock;
+	struct list_lru list_lru;
+	struct mem_cgroup *next_shrink;
 };
 
 /*
@@ -291,15 +292,40 @@ static void zswap_update_total_size(void)
 	zswap_pool_total_size = total;
 }
 
+/* should be called under RCU */
+static inline struct mem_cgroup *mem_cgroup_from_entry(struct zswap_entry *entry)
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
+		if (pool->next_shrink == memcg)
+			pool->next_shrink =
+				mem_cgroup_iter(NULL, pool->next_shrink, NULL, true);
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
@@ -312,6 +338,61 @@ static void zswap_entry_cache_free(struct zswap_entry *entry)
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
+	memcg = mem_cgroup_from_entry(entry);
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
+	memcg = mem_cgroup_from_entry(entry);
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
+	memcg = mem_cgroup_from_entry(entry);
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
@@ -396,9 +477,7 @@ static void zswap_free_entry(struct zswap_entry *entry)
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
@@ -632,21 +711,15 @@ static void zswap_invalidate_entry(struct zswap_tree *tree,
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
@@ -654,28 +727,32 @@ static int zswap_reclaim_entry(struct zswap_pool *pool)
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
@@ -689,27 +766,76 @@ static int zswap_reclaim_entry(struct zswap_pool *pool)
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
+		spin_lock(&zswap_pools_lock);
+		memcg = pool->next_shrink =
+			mem_cgroup_iter(NULL, pool->next_shrink, NULL, true);
+
+		/* full round trip */
+		if (!memcg) {
+			spin_unlock(&zswap_pools_lock);
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
+		spin_unlock(&zswap_pools_lock);
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
@@ -767,8 +893,7 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 	 */
 	kref_init(&pool->kref);
 	INIT_LIST_HEAD(&pool->list);
-	INIT_LIST_HEAD(&pool->lru);
-	spin_lock_init(&pool->lru_lock);
+	list_lru_init_memcg(&pool->list_lru, NULL);
 	INIT_WORK(&pool->shrink_work, shrink_worker);
 
 	zswap_pool_debug("created", pool);
@@ -834,6 +959,13 @@ static void zswap_pool_destroy(struct zswap_pool *pool)
 
 	cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &pool->node);
 	free_percpu(pool->acomp_ctx);
+	list_lru_destroy(&pool->list_lru);
+
+	spin_lock(&zswap_pools_lock);
+	mem_cgroup_put(pool->next_shrink);
+	pool->next_shrink = NULL;
+	spin_unlock(&zswap_pools_lock);
+
 	for (i = 0; i < ZSWAP_NR_ZPOOLS; i++)
 		zpool_destroy_pool(pool->zpools[i]);
 	kfree(pool);
@@ -1081,7 +1213,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	/* try to allocate swap cache page */
 	mpol = get_task_policy(current);
 	page = __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
-				NO_INTERLEAVE_INDEX, &page_was_allocated);
+				NO_INTERLEAVE_INDEX, &page_was_allocated, true);
 	if (!page) {
 		ret = -ENOMEM;
 		goto fail;
@@ -1152,7 +1284,6 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	/* start writeback */
 	__swap_writepage(page, &wbc);
 	put_page(page);
-	zswap_written_back_pages++;
 
 	return ret;
 
@@ -1209,6 +1340,7 @@ bool zswap_store(struct folio *folio)
 	struct scatterlist input, output;
 	struct crypto_acomp_ctx *acomp_ctx;
 	struct obj_cgroup *objcg = NULL;
+	struct mem_cgroup *memcg = NULL;
 	struct zswap_pool *pool;
 	struct zpool *zpool;
 	unsigned int dlen = PAGE_SIZE;
@@ -1240,15 +1372,15 @@ bool zswap_store(struct folio *folio)
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
@@ -1265,7 +1397,7 @@ bool zswap_store(struct folio *folio)
 	}
 
 	/* allocate entry */
-	entry = zswap_entry_cache_alloc(GFP_KERNEL);
+	entry = zswap_entry_cache_alloc(GFP_KERNEL, page_to_nid(page));
 	if (!entry) {
 		zswap_reject_kmemcache_fail++;
 		goto reject;
@@ -1292,6 +1424,15 @@ bool zswap_store(struct folio *folio)
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
 
@@ -1370,9 +1511,8 @@ bool zswap_store(struct folio *folio)
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
 
@@ -1385,6 +1525,7 @@ bool zswap_store(struct folio *folio)
 
 put_dstmem:
 	mutex_unlock(acomp_ctx->mutex);
+put_pool:
 	zswap_pool_put(entry->pool);
 freepage:
 	zswap_entry_cache_free(entry);
@@ -1479,9 +1620,8 @@ bool zswap_load(struct folio *folio)
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

