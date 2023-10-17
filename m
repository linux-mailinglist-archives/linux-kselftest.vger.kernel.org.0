Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF097CD05F
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 01:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344339AbjJQXWD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 19:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344322AbjJQXWA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 19:22:00 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62553F5;
        Tue, 17 Oct 2023 16:21:58 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-581e92f615fso438661eaf.2;
        Tue, 17 Oct 2023 16:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697584917; x=1698189717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ro07mZ3GzpatL4RIMfSbqQAjjCCYLlk3KQix1gJEHqQ=;
        b=eh3faz0/3gJH+G995J9cEEIot0dx6VPKBZ/P0fSar3SvJzWbiMES5XtubkL6UypOZk
         7L0E4xNzn8QHwSZxv+ZHavJEh8p1b8ITHSqaTTDdWlPn2jc/w1QcmDOc6NYTp6pwWkNC
         TPpYTVuggkJgx9b/7Ia/z1iYs7aDJAyR1r3/GbMtsOCVsUN0vhUtsej85bH9FGYmiOJ/
         4xABNPl1XZshEUe7hPJjeLZiJ7XF03itMlJ2fx8/GhThgpVjmL5asb2bpzjc0ibNGOWb
         pWWhpDbUUsHLzzmvaTrsCZH4swyG4XR7jkSmWw09ryTacodya2OT0AtXr7Yw9NC0Mwxm
         8B/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697584917; x=1698189717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ro07mZ3GzpatL4RIMfSbqQAjjCCYLlk3KQix1gJEHqQ=;
        b=R/W93STvk9ail7PvioQW6NisxAxr41UpGHI03YJfviXRiuox1PAeUF+dA7++pdj/BK
         BUqyGV7BbPyKjvgTvdO92hliP6HTnhllCOudzY+OmcFyDusjnxOKBWe+6K7caZNEazbl
         2S3DrMhJx+ci+G+VGjwn/ZFZnNRwyVAg9K4hf4HZAQx8jTX4sQXEyUr5bzn4OLq7LUYB
         hs6yJaUNEj1pH1qBfiMn1Ot7Bbq9I1XI9bSBV74nVizFZtxdXZU92/V6pt0WPPkfUO5c
         bbat/d+8R2lRXSk/5VPCt1MkIPF3EI0a9GdWu2vp4b1j1JyZcKqSb6oX2fKZzsjAr0Fs
         3XPg==
X-Gm-Message-State: AOJu0YwuksC3ZoP5EPvEb0x2ZpGKYxmpIDuNaCyW1nfSJTZK23YeOGMp
        PVmMmI3QKqYS9ot+6VM5jA0=
X-Google-Smtp-Source: AGHT+IF9RySE5g3TTjODlRtS6qpmjP5uh+vqX8oME1qqvf1cc6S8YM5AyaCTqDlrKiXC/CT2Gir9GA==
X-Received: by 2002:a05:6359:2ea3:b0:166:cae0:6e19 with SMTP id rp35-20020a0563592ea300b00166cae06e19mr3977722rwb.3.1697584917455;
        Tue, 17 Oct 2023 16:21:57 -0700 (PDT)
Received: from localhost (fwdproxy-prn-001.fbsv.net. [2a03:2880:ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id z5-20020aa79f85000000b0068bc6a75848sm1983031pfr.156.2023.10.17.16.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 16:21:57 -0700 (PDT)
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
Subject: [PATCH v3 5/5] zswap: shrinks zswap pool based on memory pressure
Date:   Tue, 17 Oct 2023 16:21:52 -0700
Message-Id: <20231017232152.2605440-6-nphamcs@gmail.com>
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
 Documentation/admin-guide/mm/zswap.rst |   7 ++
 include/linux/mmzone.h                 |  14 +++
 mm/mmzone.c                            |   3 +
 mm/swap_state.c                        |  21 +++-
 mm/zswap.c                             | 161 +++++++++++++++++++++++--
 5 files changed, 196 insertions(+), 10 deletions(-)

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
index 486587fcd27f..8947a1bfbe9c 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -637,6 +637,20 @@ struct lruvec {
 #ifdef CONFIG_MEMCG
 	struct pglist_data *pgdat;
 #endif
+#ifdef CONFIG_ZSWAP
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
+#endif
 };
 
 /* Isolate for asynchronous migration */
diff --git a/mm/mmzone.c b/mm/mmzone.c
index 68e1511be12d..4137f3ac42cd 100644
--- a/mm/mmzone.c
+++ b/mm/mmzone.c
@@ -78,6 +78,9 @@ void lruvec_init(struct lruvec *lruvec)
 
 	memset(lruvec, 0, sizeof(struct lruvec));
 	spin_lock_init(&lruvec->lru_lock);
+#ifdef CONFIG_ZSWAP
+	atomic_long_set(&lruvec->nr_zswap_protected, 0);
+#endif
 
 	for_each_lru(lru)
 		INIT_LIST_HEAD(&lruvec->lists[lru]);
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 0356df52b06a..a60197b55a28 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -676,7 +676,15 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	lru_add_drain();	/* Push any new pages onto the LRU now */
 skip:
 	/* The page was likely read above, so no need for plugging here */
-	return read_swap_cache_async(entry, gfp_mask, vma, addr, NULL);
+	page = read_swap_cache_async(entry, gfp_mask, vma, addr, NULL);
+#ifdef CONFIG_ZSWAP
+	if (page) {
+		struct lruvec *lruvec = folio_lruvec(page_folio(page));
+
+		atomic_long_inc(&lruvec->nr_zswap_protected);
+	}
+#endif
+	return page;
 }
 
 int init_swap_address_space(unsigned int type, unsigned long nr_pages)
@@ -843,8 +851,15 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 	lru_add_drain();
 skip:
 	/* The page was likely read above, so no need for plugging here */
-	return read_swap_cache_async(fentry, gfp_mask, vma, vmf->address,
-				     NULL);
+	page = read_swap_cache_async(fentry, gfp_mask, vma, vmf->address, NULL);
+#ifdef CONFIG_ZSWAP
+	if (page) {
+		struct lruvec *lruvec = folio_lruvec(page_folio(page));
+
+		atomic_long_inc(&lruvec->nr_zswap_protected);
+	}
+#endif
+	return page;
 }
 
 /**
diff --git a/mm/zswap.c b/mm/zswap.c
index 15485427e3fa..1d1fe75a5237 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -145,6 +145,10 @@ module_param_named(exclusive_loads, zswap_exclusive_loads_enabled, bool, 0644);
 /* Number of zpools in zswap_pool (empirically determined for scalability) */
 #define ZSWAP_NR_ZPOOLS 32
 
+/* Enable/disable memory pressure-based shrinker. */
+static bool zswap_shrinker_enabled;
+module_param_named(shrinker_enabled, zswap_shrinker_enabled, bool, 0644);
+
 /*********************************
 * data structures
 **********************************/
@@ -174,6 +178,8 @@ struct zswap_pool {
 	char tfm_name[CRYPTO_MAX_ALG_NAME];
 	struct list_lru list_lru;
 	struct mem_cgroup *next_shrink;
+	struct shrinker *shrinker;
+	atomic_t nr_stored;
 };
 
 /*
@@ -272,17 +278,26 @@ static bool zswap_can_accept(void)
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
 
@@ -326,8 +341,24 @@ static void zswap_entry_cache_free(struct zswap_entry *entry)
 static bool zswap_lru_add(struct list_lru *list_lru, struct zswap_entry *entry)
 {
 	struct mem_cgroup *memcg = get_mem_cgroup_from_entry(entry);
-	bool added = __list_lru_add(list_lru, &entry->lru, entry_to_nid(entry), memcg);
-
+	int nid = entry_to_nid(entry);
+	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
+	bool added = __list_lru_add(list_lru, &entry->lru, nid, memcg);
+	unsigned long lru_size, old, new;
+
+	if (added) {
+		lru_size = list_lru_count_one(list_lru, entry_to_nid(entry), memcg);
+		old = atomic_long_inc_return(&lruvec->nr_zswap_protected);
+
+		/*
+		 * Decay to avoid overflow and adapt to changing workloads.
+		 * This is based on LRU reclaim cost decaying heuristics.
+		 */
+		do {
+			new = old > lru_size / 4 ? old / 2 : old;
+		} while (
+			!atomic_long_try_cmpxchg(&lruvec->nr_zswap_protected, &old, new));
+	}
 	mem_cgroup_put(memcg);
 	return added;
 }
@@ -427,6 +458,7 @@ static void zswap_free_entry(struct zswap_entry *entry)
 	else {
 		zswap_lru_del(&entry->pool->list_lru, entry);
 		zpool_free(zswap_find_zpool(entry), entry->handle);
+		atomic_dec(&entry->pool->nr_stored);
 		zswap_pool_put(entry->pool);
 	}
 	zswap_entry_cache_free(entry);
@@ -468,6 +500,93 @@ static struct zswap_entry *zswap_entry_find_get(struct rb_root *root,
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
+	nr_protected = atomic_long_read(&lruvec->nr_zswap_protected);
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
+	nr_protected = atomic_long_read(&lruvec->nr_zswap_protected);
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
@@ -663,8 +782,10 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
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
@@ -698,8 +819,22 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
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
+		atomic_long_inc(&lruvec->nr_zswap_protected);
+
+		mem_cgroup_put(memcg);
 		goto put_unlock;
 	}
 	zswap_written_back_pages++;
@@ -822,6 +957,11 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
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
@@ -829,13 +969,18 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 	 */
 	kref_init(&pool->kref);
 	INIT_LIST_HEAD(&pool->list);
-	list_lru_init_memcg(&pool->list_lru, NULL);
+	if (list_lru_init_memcg(&pool->list_lru, pool->shrinker))
+		goto lru_fail;
+	shrinker_register(pool->shrinker);
 	INIT_WORK(&pool->shrink_work, shrink_worker);
 
 	zswap_pool_debug("created", pool);
 
 	return pool;
 
+lru_fail:
+	list_lru_destroy(&pool->list_lru);
+	shrinker_free(pool->shrinker);
 error:
 	if (pool->acomp_ctx)
 		free_percpu(pool->acomp_ctx);
@@ -893,6 +1038,7 @@ static void zswap_pool_destroy(struct zswap_pool *pool)
 
 	zswap_pool_debug("destroying", pool);
 
+	shrinker_free(pool->shrinker);
 	cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &pool->node);
 	free_percpu(pool->acomp_ctx);
 	list_lru_destroy(&pool->list_lru);
@@ -1440,6 +1586,7 @@ bool zswap_store(struct folio *folio)
 	if (entry->length) {
 		INIT_LIST_HEAD(&entry->lru);
 		zswap_lru_add(&pool->list_lru, entry);
+		atomic_inc(&pool->nr_stored);
 	}
 	spin_unlock(&tree->lock);
 
-- 
2.34.1
