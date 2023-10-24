Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FAD7D5C7F
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 22:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344374AbjJXUd2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 16:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344352AbjJXUdP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 16:33:15 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA1710D3;
        Tue, 24 Oct 2023 13:33:10 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c9e072472bso34355625ad.2;
        Tue, 24 Oct 2023 13:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698179590; x=1698784390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qKeVPLjWvPnKBs3WedCuvvPJRyMgM4Wh5BWftdbSso=;
        b=S1D+nuwK1JxhabUj5OfErt4+kogqgutVsNJZb2BJspeDzcBdkbx8YGRi9F+WJRlO27
         /FBprqNCwOJAgg5zf4K3kz5tq2tONRIYwxD5CxPt5U8r1o+LSitfK74j+I367pb+/cX1
         Xoi2M7TaZElqtoMvhGTJ8a6059Em3hzOWB/pwuWkiC9XNCZ9rzLhWuq7b3DBnKoJCzfH
         I0G0DImo3Lbb9K93BbMhGU25wHfab+OZ3FR6zmgVmCtY73TblgGdSt+98+U4CDvndoAb
         Rk4wCTF1npeBiw29q6X+KBvnSjdegZPWyQseFEs+vsRaryobHMSMgjW1kiptbErZrq51
         1DiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698179590; x=1698784390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qKeVPLjWvPnKBs3WedCuvvPJRyMgM4Wh5BWftdbSso=;
        b=HGO7XjJgumVeYF0zTZoJDvjCyFlc7+A1yYIhMleqKTBatQRnM3MmtS2PBHViEYNYvk
         qogYIi46cL1gwz2QfqNfogqPSH8csa0/sW8ckIJ/DBZO+kHvVupS1J2Jr349F9G6mQ2j
         JgLEtb+UXACzQ/IGZEMDGiyttTS/Q5yP8ETegu3lkaBMs/4RdrjGyYN2J3WtVWqnKBBQ
         KqllatiZpIk0wYH0Qq8tfYqw83ct0eCs4rh7UOcaTHzoj4m4rWoeaS/SiEW19SaNSWMj
         QtyhPgncVHWtQ1IWw/XoJuD3h4xjhlPjvl179dfziZiX/+xW795wh/s9FfTgqEmAuhaN
         fS5g==
X-Gm-Message-State: AOJu0YxleHnOC5CKHolSDTUbwXFqxVN/y7jGGspPyxz0lDyrQ3IfWUsd
        s3mcumQLE/BbnlBcKOEcJxY=
X-Google-Smtp-Source: AGHT+IERx5hzi6G0let1CM31sv7+Us629KVVsLgKquopZJuJHwt3LRp3wcNM3+CzEUJJDXQYdvKu3g==
X-Received: by 2002:a17:902:ce81:b0:1c6:2acc:62ea with SMTP id f1-20020a170902ce8100b001c62acc62eamr12845742plg.57.1698179590064;
        Tue, 24 Oct 2023 13:33:10 -0700 (PDT)
Received: from localhost (fwdproxy-prn-001.fbsv.net. [2a03:2880:ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902e74700b001c7453fae33sm7731487plf.280.2023.10.24.13.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 13:33:09 -0700 (PDT)
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
Subject: [PATCH v4 5/5] zswap: shrinks zswap pool based on memory pressure
Date:   Tue, 24 Oct 2023 13:33:02 -0700
Message-Id: <20231024203302.1920362-6-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024203302.1920362-1-nphamcs@gmail.com>
References: <20231024203302.1920362-1-nphamcs@gmail.com>
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

Currently, we only shrink the zswap pool when the user-defined limit is
hit. This means that if we set the limit too high, cold data that are
unlikely to be used again will reside in the pool, wasting precious
memory. It is hard to predict how much zswap space will be needed ahead
of time, as this depends on the workload (specifically, on factors such
as memory access patterns and compressibility of the memory pages).

This patch implements a memcg- and NUMA-aware shrinker for zswap, that
is initiated when there is memory pressure. The shrinker does not
have any parameter that must be tuned by the user, and can be opted in
or out on a per-memcg basis.

Furthermore, to make it more robust for many workloads and prevent
overshrinking (i.e evicting warm pages that might be refaulted into
memory), we build in the following heuristics:

* Estimate the number of warm pages residing in zswap, and attempt to
  protect this region of the zswap LRU.
* Scale the number of freeable objects by an estimate of the memory
  saving factor. The better zswap compresses the data, the fewer pages
  we will evict to swap (as we will otherwise incur IO for relatively
  small memory saving).
* During reclaim, if the shrinker encounters a page that is also being
  brought into memory, the shrinker will cautiously terminate its
  shrinking action, as this is a sign that it is touching the warmer
  region of the zswap LRU.

As a proof of concept, we ran the following synthetic benchmark:
build the linux kernel in a memory-limited cgroup, and allocate some
cold data in tmpfs to see if the shrinker could write them out and
improved the overall performance. Depending on the amount of cold data
generated, we observe from 14% to 35% reduction in kernel CPU time used
in the kernel builds.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 Documentation/admin-guide/mm/zswap.rst |   7 +
 include/linux/mmzone.h                 |   2 +
 include/linux/zswap.h                  |  25 +++-
 mm/mmzone.c                            |   1 +
 mm/swap_state.c                        |   2 +
 mm/zswap.c                             | 178 ++++++++++++++++++++++++-
 6 files changed, 208 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation/admin-guide/mm/zswap.rst
index 45b98390e938..522ae22ccb84 100644
--- a/Documentation/admin-guide/mm/zswap.rst
+++ b/Documentation/admin-guide/mm/zswap.rst
@@ -153,6 +153,13 @@ attribute, e. g.::
 
 Setting this parameter to 100 will disable the hysteresis.
 
+When there is a sizable amount of cold memory residing in the zswap pool, it
+can be advantageous to proactively write these cold pages to swap and reclaim
+the memory for other use cases. By default, the zswap shrinker is disabled.
+User can enable it as follows:
+
+  echo Y > /sys/module/zswap/parameters/shrinker_enabled
+
 A debugfs interface is provided for various statistic about pool size, number
 of pages stored, same-value filled pages and various counters for the reasons
 pages are rejected.
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 12f31633be05..633afdb96c40 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -22,6 +22,7 @@
 #include <linux/mm_types.h>
 #include <linux/page-flags.h>
 #include <linux/local_lock.h>
+#include <linux/zswap.h>
 #include <asm/page.h>
 
 /* Free memory management - zoned buddy allocator.  */
@@ -637,6 +638,7 @@ struct lruvec {
 #ifdef CONFIG_MEMCG
 	struct pglist_data *pgdat;
 #endif
+	struct zswap_lruvec_state zswap_lruvec_state;
 };
 
 /* Isolate for asynchronous migration */
diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index 2a60ce39cfde..64d0c3644185 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -5,19 +5,39 @@
 #include <linux/types.h>
 #include <linux/mm_types.h>
 
+struct lruvec;
+
 extern u64 zswap_pool_total_size;
 extern atomic_t zswap_stored_pages;
 
 #ifdef CONFIG_ZSWAP
 
+struct zswap_lruvec_state {
+	/*
+	 * Number of pages in zswap that should be protected from the shrinker.
+	 * This number is an estimate of the following counts:
+	 *
+	 * a) Recent page faults.
+	 * b) Recent insertion to the zswap LRU. This includes new zswap stores,
+	 *    as well as recent zswap LRU rotations.
+	 *
+	 * These pages are likely to be warm, and might incur IO if the are written
+	 * to swap.
+	 */
+	atomic_long_t nr_zswap_protected;
+};
+
 bool zswap_store(struct folio *folio);
 bool zswap_load(struct folio *folio);
 void zswap_invalidate(int type, pgoff_t offset);
 void zswap_swapon(int type);
 void zswap_swapoff(int type);
-
+void zswap_lruvec_state_init(struct lruvec *lruvec);
+void zswap_lruvec_swapin(struct page *page);
 #else
 
+struct zswap_lruvec_state {};
+
 static inline bool zswap_store(struct folio *folio)
 {
 	return false;
@@ -31,7 +51,8 @@ static inline bool zswap_load(struct folio *folio)
 static inline void zswap_invalidate(int type, pgoff_t offset) {}
 static inline void zswap_swapon(int type) {}
 static inline void zswap_swapoff(int type) {}
-
+static inline void zswap_lruvec_init(struct lruvec *lruvec) {}
+static inline void zswap_lruvec_swapin(struct page *page) {}
 #endif
 
 #endif /* _LINUX_ZSWAP_H */
diff --git a/mm/mmzone.c b/mm/mmzone.c
index b594d3f268fe..c01896eca736 100644
--- a/mm/mmzone.c
+++ b/mm/mmzone.c
@@ -78,6 +78,7 @@ void lruvec_init(struct lruvec *lruvec)
 
 	memset(lruvec, 0, sizeof(struct lruvec));
 	spin_lock_init(&lruvec->lru_lock);
+	zswap_lruvec_state_init(lruvec);
 
 	for_each_lru(lru)
 		INIT_LIST_HEAD(&lruvec->lists[lru]);
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 040639e1c77e..38ce9981b0be 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -686,6 +686,7 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 					&page_allocated, false);
 	if (unlikely(page_allocated))
 		swap_readpage(page, false, NULL);
+	zswap_lruvec_swapin(page);
 	return page;
 }
 
@@ -861,6 +862,7 @@ static struct page *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 					&page_allocated, false);
 	if (unlikely(page_allocated))
 		swap_readpage(page, false, NULL);
+	zswap_lruvec_swapin(page);
 	return page;
 }
 
diff --git a/mm/zswap.c b/mm/zswap.c
index b87311e48de9..c40697f07ba3 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -146,6 +146,10 @@ module_param_named(exclusive_loads, zswap_exclusive_loads_enabled, bool, 0644);
 /* Number of zpools in zswap_pool (empirically determined for scalability) */
 #define ZSWAP_NR_ZPOOLS 32
 
+/* Enable/disable memory pressure-based shrinker. */
+static bool zswap_shrinker_enabled;
+module_param_named(shrinker_enabled, zswap_shrinker_enabled, bool, 0644);
+
 /*********************************
 * data structures
 **********************************/
@@ -175,6 +179,8 @@ struct zswap_pool {
 	char tfm_name[CRYPTO_MAX_ALG_NAME];
 	struct list_lru list_lru;
 	struct mem_cgroup *next_shrink;
+	struct shrinker *shrinker;
+	atomic_t nr_stored;
 };
 
 /*
@@ -273,17 +279,26 @@ static bool zswap_can_accept(void)
 			DIV_ROUND_UP(zswap_pool_total_size, PAGE_SIZE);
 }
 
+static u64 get_zswap_pool_size(struct zswap_pool *pool)
+{
+	u64 pool_size = 0;
+	int i;
+
+	for (i = 0; i < ZSWAP_NR_ZPOOLS; i++)
+		pool_size += zpool_get_total_size(pool->zpools[i]);
+
+	return pool_size;
+}
+
 static void zswap_update_total_size(void)
 {
 	struct zswap_pool *pool;
 	u64 total = 0;
-	int i;
 
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(pool, &zswap_pools, list)
-		for (i = 0; i < ZSWAP_NR_ZPOOLS; i++)
-			total += zpool_get_total_size(pool->zpools[i]);
+		total += get_zswap_pool_size(pool);
 
 	rcu_read_unlock();
 
@@ -321,6 +336,24 @@ static void zswap_entry_cache_free(struct zswap_entry *entry)
 	kmem_cache_free(zswap_entry_cache, entry);
 }
 
+/*********************************
+* zswap lruvec functions
+**********************************/
+void zswap_lruvec_state_init(struct lruvec *lruvec)
+{
+	atomic_long_set(&lruvec->zswap_lruvec_state.nr_zswap_protected, 0);
+}
+
+void zswap_lruvec_swapin(struct page *page)
+{
+	struct lruvec *lruvec;
+
+	if (page) {
+		lruvec = folio_lruvec(page_folio(page));
+		atomic_long_inc(&lruvec->zswap_lruvec_state.nr_zswap_protected);
+	}
+}
+
 /*********************************
 * lru functions
 **********************************/
@@ -328,8 +361,24 @@ static bool zswap_lru_add(struct list_lru *list_lru, struct zswap_entry *entry)
 {
 	struct mem_cgroup *memcg = get_mem_cgroup_from_entry(entry);
 	int nid = entry_to_nid(entry);
+	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
 	bool added = list_lru_add(list_lru, &entry->lru, nid, memcg);
+	atomic_long_t *nr_zswap_protected =
+		&lruvec->zswap_lruvec_state.nr_zswap_protected;
+	unsigned long lru_size, old, new;
 
+	if (added) {
+		lru_size = list_lru_count_one(list_lru, nid, memcg);
+		old = atomic_long_inc_return(nr_zswap_protected);
+
+		/*
+		 * Decay to avoid overflow and adapt to changing workloads.
+		 * This is based on LRU reclaim cost decaying heuristics.
+		 */
+		do {
+			new = old > lru_size / 4 ? old / 2 : old;
+		} while (!atomic_long_try_cmpxchg(nr_zswap_protected, &old, new));
+	}
 	mem_cgroup_put(memcg);
 	return added;
 }
@@ -430,6 +479,7 @@ static void zswap_free_entry(struct zswap_entry *entry)
 	else {
 		zswap_lru_del(&entry->pool->list_lru, entry);
 		zpool_free(zswap_find_zpool(entry), entry->handle);
+		atomic_dec(&entry->pool->nr_stored);
 		zswap_pool_put(entry->pool);
 	}
 	zswap_entry_cache_free(entry);
@@ -471,6 +521,95 @@ static struct zswap_entry *zswap_entry_find_get(struct rb_root *root,
 	return entry;
 }
 
+/*********************************
+* shrinker functions
+**********************************/
+static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_one *l,
+				       spinlock_t *lock, void *arg);
+
+static unsigned long zswap_shrinker_scan(struct shrinker *shrinker,
+		struct shrink_control *sc)
+{
+	struct lruvec *lruvec = mem_cgroup_lruvec(sc->memcg, NODE_DATA(sc->nid));
+	unsigned long shrink_ret, nr_protected, lru_size;
+	struct zswap_pool *pool = shrinker->private_data;
+	bool encountered_page_in_swapcache = false;
+
+	nr_protected =
+		atomic_long_read(&lruvec->zswap_lruvec_state.nr_zswap_protected);
+	lru_size = list_lru_shrink_count(&pool->list_lru, sc);
+
+	/*
+	 * Abort if the shrinker is disabled or if we are shrinking into the
+	 * protected region.
+	 */
+	if (!zswap_shrinker_enabled || nr_protected >= lru_size - sc->nr_to_scan) {
+		sc->nr_scanned = 0;
+		return SHRINK_STOP;
+	}
+
+	shrink_ret = list_lru_shrink_walk(&pool->list_lru, sc, &shrink_memcg_cb,
+		&encountered_page_in_swapcache);
+
+	if (encountered_page_in_swapcache)
+		return SHRINK_STOP;
+
+	return shrink_ret ? shrink_ret : SHRINK_STOP;
+}
+
+static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
+		struct shrink_control *sc)
+{
+	struct zswap_pool *pool = shrinker->private_data;
+	struct mem_cgroup *memcg = sc->memcg;
+	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(sc->nid));
+	unsigned long nr_backing, nr_stored, nr_freeable, nr_protected;
+
+#ifdef CONFIG_MEMCG_KMEM
+	cgroup_rstat_flush(memcg->css.cgroup);
+	nr_backing = memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PAGE_SHIFT;
+	nr_stored = memcg_page_state(memcg, MEMCG_ZSWAPPED);
+#else
+	/* use pool stats instead of memcg stats */
+	nr_backing = get_zswap_pool_size(pool) >> PAGE_SHIFT;
+	nr_stored = atomic_read(&pool->nr_stored);
+#endif
+
+	if (!zswap_shrinker_enabled || !nr_stored)
+		return 0;
+
+	nr_protected =
+		atomic_long_read(&lruvec->zswap_lruvec_state.nr_zswap_protected);
+	nr_freeable = list_lru_shrink_count(&pool->list_lru, sc);
+	/*
+	 * Subtract the lru size by an estimate of the number of pages
+	 * that should be protected.
+	 */
+	nr_freeable = nr_freeable > nr_protected ? nr_freeable - nr_protected : 0;
+
+	/*
+	 * Scale the number of freeable pages by the memory saving factor.
+	 * This ensures that the better zswap compresses memory, the fewer
+	 * pages we will evict to swap (as it will otherwise incur IO for
+	 * relatively small memory saving).
+	 */
+	return mult_frac(nr_freeable, nr_backing, nr_stored);
+}
+
+static void zswap_alloc_shrinker(struct zswap_pool *pool)
+{
+	pool->shrinker =
+		shrinker_alloc(SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE, "mm-zswap");
+	if (!pool->shrinker)
+		return;
+
+	pool->shrinker->private_data = pool;
+	pool->shrinker->scan_objects = zswap_shrinker_scan;
+	pool->shrinker->count_objects = zswap_shrinker_count;
+	pool->shrinker->batch = 0;
+	pool->shrinker->seeks = DEFAULT_SEEKS;
+}
+
 /*********************************
 * per-cpu code
 **********************************/
@@ -666,8 +805,10 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
 				       spinlock_t *lock, void *arg)
 {
 	struct zswap_entry *entry = container_of(item, struct zswap_entry, lru);
+	bool *encountered_page_in_swapcache = (bool *)arg;
 	struct mem_cgroup *memcg;
 	struct zswap_tree *tree;
+	struct lruvec *lruvec;
 	pgoff_t swpoffset;
 	enum lru_status ret = LRU_REMOVED_RETRY;
 	int writeback_result;
@@ -705,8 +846,22 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
 		/* we cannot use zswap_lru_add here, because it increments node's lru count */
 		list_lru_putback(&entry->pool->list_lru, item, entry_to_nid(entry), memcg);
 		spin_unlock(lock);
-		mem_cgroup_put(memcg);
 		ret = LRU_RETRY;
+
+		/*
+		 * Encountering a page already in swap cache is a sign that we are shrinking
+		 * into the warmer region. We should terminate shrinking (if we're in the dynamic
+		 * shrinker context).
+		 */
+		if (writeback_result == -EEXIST && encountered_page_in_swapcache) {
+			ret = LRU_SKIP;
+			*encountered_page_in_swapcache = true;
+		}
+		lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(entry_to_nid(entry)));
+		/* Increment the protection area to account for the LRU rotation. */
+		atomic_long_inc(&lruvec->zswap_lruvec_state.nr_zswap_protected);
+
+		mem_cgroup_put(memcg);
 		goto put_unlock;
 	}
 	zswap_written_back_pages++;
@@ -826,6 +981,11 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 				       &pool->node);
 	if (ret)
 		goto error;
+
+	zswap_alloc_shrinker(pool);
+	if (!pool->shrinker)
+		goto error;
+
 	pr_debug("using %s compressor\n", pool->tfm_name);
 
 	/* being the current pool takes 1 ref; this func expects the
@@ -833,13 +993,19 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 	 */
 	kref_init(&pool->kref);
 	INIT_LIST_HEAD(&pool->list);
-	list_lru_init_memcg(&pool->list_lru, NULL);
+	if (list_lru_init_memcg(&pool->list_lru, pool->shrinker))
+		goto lru_fail;
+	shrinker_register(pool->shrinker);
 	INIT_WORK(&pool->shrink_work, shrink_worker);
+	atomic_set(&pool->nr_stored, 0);
 
 	zswap_pool_debug("created", pool);
 
 	return pool;
 
+lru_fail:
+	list_lru_destroy(&pool->list_lru);
+	shrinker_free(pool->shrinker);
 error:
 	if (pool->acomp_ctx)
 		free_percpu(pool->acomp_ctx);
@@ -897,6 +1063,7 @@ static void zswap_pool_destroy(struct zswap_pool *pool)
 
 	zswap_pool_debug("destroying", pool);
 
+	shrinker_free(pool->shrinker);
 	cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &pool->node);
 	free_percpu(pool->acomp_ctx);
 	list_lru_destroy(&pool->list_lru);
@@ -1443,6 +1610,7 @@ bool zswap_store(struct folio *folio)
 	if (entry->length) {
 		INIT_LIST_HEAD(&entry->lru);
 		zswap_lru_add(&entry->pool->list_lru, entry);
+		atomic_inc(&entry->pool->nr_stored);
 	}
 	spin_unlock(&tree->lock);
 
-- 
2.34.1
