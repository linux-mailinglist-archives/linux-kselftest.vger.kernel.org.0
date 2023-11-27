Return-Path: <linux-kselftest+bounces-663-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640177FAA6F
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 20:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 876A41C20CDA
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 19:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894553FB31;
	Mon, 27 Nov 2023 19:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9hhy077"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF7E10CA;
	Mon, 27 Nov 2023 11:37:11 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6cbd24d9557so3302728b3a.1;
        Mon, 27 Nov 2023 11:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701113830; x=1701718630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CFCgQneqAF2pYra6qWTbPztDlTzrhUgQ5xOfrabi7w=;
        b=I9hhy0770C9sAKN//fdZr92CGlzo+HPmLsyqbHHlqrKdBq8HTksh6Xh/8fKIpUOBw1
         FpmkAKxdvX5T1fVU2l/S7KE26W9nAKzMdGSQtirzlmho7XXTsJpHqun6SC4C0LcnVoC6
         wYxVpATijbYB83WI1pWfIiJX76/e1i/Cd66BrcioGkenOgheXD0nS71PUc+FrwV8szpq
         LyvvPkXiy14BsIbtIRY78umcLFMHc/QEYR+UoQWKkFGGj55yiLKdDywyCipfjUWNzgR5
         Gos9EV+SYdbaIHYL/uzaO1JDzZuWWINwHN8NyfuOYHBO7Umbo6Y1joRXP9RJB/3wwiAp
         x1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701113830; x=1701718630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8CFCgQneqAF2pYra6qWTbPztDlTzrhUgQ5xOfrabi7w=;
        b=NKh89el/XjczaOIal5nMAvcqnbShv5Ztp841aEbhFll6vILvk2y9ueP3+TJ06VSWPb
         O/p6RR+4qvVHAq9ef+8Lsy7yYrVYBYB36Xk3CaCp5OzSlKFe2ruavSWNnb+tI35pA1Wa
         21cJ2LNbMHx0Br0OSgA6EcP2YG9uwEvIxBp2xbfeV9BwFi9zW0CO4Hl0sWDuAX+127hR
         fBUFLC4mg47koEynR73N2FkJ8AamHL9rXW6XMxhB0FgHvxW5Gp3H7qJdXFq5Ra3tfXkE
         dMO5tGF3AlFb6f+mCawkz1HcQX4634CZsCmIkTGiHVsChBZfomo65zSL3WeYRZg6jw/H
         b/eA==
X-Gm-Message-State: AOJu0YymFylAoIA4e6T65LTiUKdZas8hOZmFLAYjxOiWHIvS5myjxa2w
	19jQZ2CrAvVcy3xpXYouZv0=
X-Google-Smtp-Source: AGHT+IGlIp4LlP5/NgFKZ0vrR7vDICSEBaQhxXXvac1Z5gfjCxeZfr+2/WUSp8O4EXfnaNqkLcAFTw==
X-Received: by 2002:a05:6a00:2e8b:b0:6cb:4361:773c with SMTP id fd11-20020a056a002e8b00b006cb4361773cmr16698823pfb.5.1701113830376;
        Mon, 27 Nov 2023 11:37:10 -0800 (PST)
Received: from localhost (fwdproxy-prn-024.fbsv.net. [2a03:2880:ff:18::face:b00c])
        by smtp.gmail.com with ESMTPSA id f23-20020a63f117000000b005b3cc663c8csm8045652pgi.21.2023.11.27.11.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 11:37:10 -0800 (PST)
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
Subject: [PATCH v6 6/6] zswap: shrinks zswap pool based on memory pressure
Date: Mon, 27 Nov 2023 11:37:03 -0800
Message-Id: <20231127193703.1980089-7-nphamcs@gmail.com>
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
 mm/zswap.c                             | 177 ++++++++++++++++++++++++-
 6 files changed, 208 insertions(+), 6 deletions(-)

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
index 7b1816450bfc..b23bc5390240 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -22,6 +22,7 @@
 #include <linux/mm_types.h>
 #include <linux/page-flags.h>
 #include <linux/local_lock.h>
+#include <linux/zswap.h>
 #include <asm/page.h>
 
 /* Free memory management - zoned buddy allocator.  */
@@ -641,6 +642,7 @@ struct lruvec {
 #ifdef CONFIG_MEMCG
 	struct pglist_data *pgdat;
 #endif
+	struct zswap_lruvec_state zswap_lruvec_state;
 };
 
 /* Isolate for asynchronous migration */
diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index e571e393669b..cbd373ba88d2 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -5,20 +5,40 @@
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
 void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg);
-
+void zswap_lruvec_state_init(struct lruvec *lruvec);
+void zswap_lruvec_swapin(struct page *page);
 #else
 
+struct zswap_lruvec_state {};
+
 static inline bool zswap_store(struct folio *folio)
 {
 	return false;
@@ -33,7 +53,8 @@ static inline void zswap_invalidate(int type, pgoff_t offset) {}
 static inline void zswap_swapon(int type) {}
 static inline void zswap_swapoff(int type) {}
 static inline void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg) {}
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
index 6c84236382f3..94ed2d508db0 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -687,6 +687,7 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 					&page_allocated, false);
 	if (unlikely(page_allocated))
 		swap_readpage(page, false, NULL);
+	zswap_lruvec_swapin(page);
 	return page;
 }
 
@@ -862,6 +863,7 @@ static struct page *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 					&page_allocated, false);
 	if (unlikely(page_allocated))
 		swap_readpage(page, false, NULL);
+	zswap_lruvec_swapin(page);
 	return page;
 }
 
diff --git a/mm/zswap.c b/mm/zswap.c
index 9f5142524d48..943090dfe793 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -148,6 +148,10 @@ module_param_named(exclusive_loads, zswap_exclusive_loads_enabled, bool, 0644);
 /* Number of zpools in zswap_pool (empirically determined for scalability) */
 #define ZSWAP_NR_ZPOOLS 32
 
+/* Enable/disable memory pressure-based shrinker. */
+static bool zswap_shrinker_enabled;
+module_param_named(shrinker_enabled, zswap_shrinker_enabled, bool, 0644);
+
 /*********************************
 * data structures
 **********************************/
@@ -177,6 +181,8 @@ struct zswap_pool {
 	char tfm_name[CRYPTO_MAX_ALG_NAME];
 	struct list_lru list_lru;
 	struct mem_cgroup *next_shrink;
+	struct shrinker *shrinker;
+	atomic_t nr_stored;
 };
 
 /*
@@ -275,17 +281,26 @@ static bool zswap_can_accept(void)
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
 
@@ -338,13 +353,34 @@ static void zswap_entry_cache_free(struct zswap_entry *entry)
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
 static void zswap_lru_add(struct list_lru *list_lru, struct zswap_entry *entry)
 {
+	atomic_long_t *nr_zswap_protected;
+	unsigned long lru_size, old, new;
 	int nid = entry_to_nid(entry);
 	struct mem_cgroup *memcg;
+	struct lruvec *lruvec;
 
 	/*
 	 * Note that it is safe to use rcu_read_lock() here, even in the face of
@@ -362,6 +398,19 @@ static void zswap_lru_add(struct list_lru *list_lru, struct zswap_entry *entry)
 	memcg = mem_cgroup_from_entry(entry);
 	/* will always succeed */
 	list_lru_add(list_lru, &entry->lru, nid, memcg);
+
+	/* Update the protection area */
+	lru_size = list_lru_count_one(list_lru, nid, memcg);
+	lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
+	nr_zswap_protected = &lruvec->zswap_lruvec_state.nr_zswap_protected;
+	old = atomic_long_inc_return(nr_zswap_protected);
+	/*
+	 * Decay to avoid overflow and adapt to changing workloads.
+	 * This is based on LRU reclaim cost decaying heuristics.
+	 */
+	do {
+		new = old > lru_size / 4 ? old / 2 : old;
+	} while (!atomic_long_try_cmpxchg(nr_zswap_protected, &old, new));
 	rcu_read_unlock();
 }
 
@@ -383,6 +432,7 @@ static void zswap_lru_putback(struct list_lru *list_lru,
 	int nid = entry_to_nid(entry);
 	spinlock_t *lock = &list_lru->node[nid].lock;
 	struct mem_cgroup *memcg;
+	struct lruvec *lruvec;
 
 	rcu_read_lock();
 	memcg = mem_cgroup_from_entry(entry);
@@ -390,6 +440,10 @@ static void zswap_lru_putback(struct list_lru *list_lru,
 	/* we cannot use list_lru_add here, because it increments node's lru count */
 	list_lru_putback(list_lru, &entry->lru, nid, memcg);
 	spin_unlock(lock);
+
+	lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(entry_to_nid(entry)));
+	/* increment the protection area to account for the LRU rotation. */
+	atomic_long_inc(&lruvec->zswap_lruvec_state.nr_zswap_protected);
 	rcu_read_unlock();
 }
 
@@ -479,6 +533,7 @@ static void zswap_free_entry(struct zswap_entry *entry)
 	else {
 		zswap_lru_del(&entry->pool->list_lru, entry);
 		zpool_free(zswap_find_zpool(entry), entry->handle);
+		atomic_dec(&entry->pool->nr_stored);
 		zswap_pool_put(entry->pool);
 	}
 	zswap_entry_cache_free(entry);
@@ -520,6 +575,95 @@ static struct zswap_entry *zswap_entry_find_get(struct rb_root *root,
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
@@ -715,6 +859,7 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
 				       spinlock_t *lock, void *arg)
 {
 	struct zswap_entry *entry = container_of(item, struct zswap_entry, lru);
+	bool *encountered_page_in_swapcache = (bool *)arg;
 	struct zswap_tree *tree;
 	pgoff_t swpoffset;
 	enum lru_status ret = LRU_REMOVED_RETRY;
@@ -750,6 +895,17 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
 		zswap_reject_reclaim_fail++;
 		zswap_lru_putback(&entry->pool->list_lru, entry);
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
+
 		goto put_unlock;
 	}
 	zswap_written_back_pages++;
@@ -889,6 +1045,11 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
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
@@ -896,13 +1057,19 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
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
@@ -960,6 +1127,7 @@ static void zswap_pool_destroy(struct zswap_pool *pool)
 
 	zswap_pool_debug("destroying", pool);
 
+	shrinker_free(pool->shrinker);
 	cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &pool->node);
 	free_percpu(pool->acomp_ctx);
 	list_lru_destroy(&pool->list_lru);
@@ -1516,6 +1684,7 @@ bool zswap_store(struct folio *folio)
 	if (entry->length) {
 		INIT_LIST_HEAD(&entry->lru);
 		zswap_lru_add(&entry->pool->list_lru, entry);
+		atomic_inc(&entry->pool->nr_stored);
 	}
 	spin_unlock(&tree->lock);
 
-- 
2.34.1

