Return-Path: <linux-kselftest+bounces-1229-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9408066B3
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 06:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 607511C20924
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 05:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46073107A2;
	Wed,  6 Dec 2023 05:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OdsGSgaE"
X-Original-To: linux-kselftest@vger.kernel.org
X-Greylist: delayed 98521 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Dec 2023 21:51:27 PST
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ac])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6560418F
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Dec 2023 21:51:27 -0800 (PST)
Message-ID: <ed2792de-24cc-4037-9ee1-966cc07df57a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701841885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e+Nb0tBoQoiS/tFR6SlHDArREnKO3yhwjbw0NiKzxkg=;
	b=OdsGSgaEr39MFcHduCH8/7yVtY4QLZN8PDRM+2Pja32SU7/eUyyzxQznLTrw+fUNPE51D+
	5VABs4QHWDzFxdfVu/Nv6IdhoKBlhmfncmgWw+fHaQNt3NZTYF7BD8l9Ihh/haErFNamND
	uNpIiFsJW7Put2b+DQKFbkCLChlckFc=
Date: Wed, 6 Dec 2023 13:51:17 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v8 6/6] zswap: shrinks zswap pool based on memory pressure
Content-Language: en-US
To: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org
Cc: hannes@cmpxchg.org, cerasuolodomenico@gmail.com, yosryahmed@google.com,
 sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
 muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
 kernel-team@meta.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, shuah@kernel.org
References: <20231130194023.4102148-1-nphamcs@gmail.com>
 <20231130194023.4102148-7-nphamcs@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20231130194023.4102148-7-nphamcs@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2023/12/1 03:40, Nhat Pham wrote:
> Currently, we only shrink the zswap pool when the user-defined limit is
> hit. This means that if we set the limit too high, cold data that are
> unlikely to be used again will reside in the pool, wasting precious
> memory. It is hard to predict how much zswap space will be needed ahead
> of time, as this depends on the workload (specifically, on factors such
> as memory access patterns and compressibility of the memory pages).
> 
> This patch implements a memcg- and NUMA-aware shrinker for zswap, that
> is initiated when there is memory pressure. The shrinker does not
> have any parameter that must be tuned by the user, and can be opted in
> or out on a per-memcg basis.
> 
> Furthermore, to make it more robust for many workloads and prevent
> overshrinking (i.e evicting warm pages that might be refaulted into
> memory), we build in the following heuristics:
> 
> * Estimate the number of warm pages residing in zswap, and attempt to
>   protect this region of the zswap LRU.
> * Scale the number of freeable objects by an estimate of the memory
>   saving factor. The better zswap compresses the data, the fewer pages
>   we will evict to swap (as we will otherwise incur IO for relatively
>   small memory saving).
> * During reclaim, if the shrinker encounters a page that is also being
>   brought into memory, the shrinker will cautiously terminate its
>   shrinking action, as this is a sign that it is touching the warmer
>   region of the zswap LRU.
> 
> As a proof of concept, we ran the following synthetic benchmark:
> build the linux kernel in a memory-limited cgroup, and allocate some
> cold data in tmpfs to see if the shrinker could write them out and
> improved the overall performance. Depending on the amount of cold data
> generated, we observe from 14% to 35% reduction in kernel CPU time used
> in the kernel builds.
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  Documentation/admin-guide/mm/zswap.rst |  10 ++
>  include/linux/mmzone.h                 |   2 +
>  include/linux/zswap.h                  |  25 +++-
>  mm/Kconfig                             |  14 ++
>  mm/mmzone.c                            |   1 +
>  mm/swap_state.c                        |   2 +
>  mm/zswap.c                             | 185 ++++++++++++++++++++++++-
>  7 files changed, 233 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation/admin-guide/mm/zswap.rst
> index 45b98390e938..62fc244ec702 100644
> --- a/Documentation/admin-guide/mm/zswap.rst
> +++ b/Documentation/admin-guide/mm/zswap.rst
> @@ -153,6 +153,16 @@ attribute, e. g.::
>  
>  Setting this parameter to 100 will disable the hysteresis.
>  
> +When there is a sizable amount of cold memory residing in the zswap pool, it
> +can be advantageous to proactively write these cold pages to swap and reclaim
> +the memory for other use cases. By default, the zswap shrinker is disabled.
> +User can enable it as follows:
> +
> +  echo Y > /sys/module/zswap/parameters/shrinker_enabled
> +
> +This can be enabled at the boot time if ``CONFIG_ZSWAP_SHRINKER_DEFAULT_ON`` is
> +selected.
> +
>  A debugfs interface is provided for various statistic about pool size, number
>  of pages stored, same-value filled pages and various counters for the reasons
>  pages are rejected.
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 7b1816450bfc..b23bc5390240 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -22,6 +22,7 @@
>  #include <linux/mm_types.h>
>  #include <linux/page-flags.h>
>  #include <linux/local_lock.h>
> +#include <linux/zswap.h>
>  #include <asm/page.h>
>  
>  /* Free memory management - zoned buddy allocator.  */
> @@ -641,6 +642,7 @@ struct lruvec {
>  #ifdef CONFIG_MEMCG
>  	struct pglist_data *pgdat;
>  #endif
> +	struct zswap_lruvec_state zswap_lruvec_state;
>  };
>  
>  /* Isolate for asynchronous migration */
> diff --git a/include/linux/zswap.h b/include/linux/zswap.h
> index e571e393669b..08c240e16a01 100644
> --- a/include/linux/zswap.h
> +++ b/include/linux/zswap.h
> @@ -5,20 +5,40 @@
>  #include <linux/types.h>
>  #include <linux/mm_types.h>
>  
> +struct lruvec;
> +
>  extern u64 zswap_pool_total_size;
>  extern atomic_t zswap_stored_pages;
>  
>  #ifdef CONFIG_ZSWAP
>  
> +struct zswap_lruvec_state {
> +	/*
> +	 * Number of pages in zswap that should be protected from the shrinker.
> +	 * This number is an estimate of the following counts:
> +	 *
> +	 * a) Recent page faults.
> +	 * b) Recent insertion to the zswap LRU. This includes new zswap stores,
> +	 *    as well as recent zswap LRU rotations.
> +	 *
> +	 * These pages are likely to be warm, and might incur IO if the are written
> +	 * to swap.
> +	 */
> +	atomic_long_t nr_zswap_protected;
> +};
> +
>  bool zswap_store(struct folio *folio);
>  bool zswap_load(struct folio *folio);
>  void zswap_invalidate(int type, pgoff_t offset);
>  void zswap_swapon(int type);
>  void zswap_swapoff(int type);
>  void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg);
> -
> +void zswap_lruvec_state_init(struct lruvec *lruvec);
> +void zswap_page_swapin(struct page *page);
>  #else
>  
> +struct zswap_lruvec_state {};
> +
>  static inline bool zswap_store(struct folio *folio)
>  {
>  	return false;
> @@ -33,7 +53,8 @@ static inline void zswap_invalidate(int type, pgoff_t offset) {}
>  static inline void zswap_swapon(int type) {}
>  static inline void zswap_swapoff(int type) {}
>  static inline void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg) {}
> -
> +static inline void zswap_lruvec_state_init(struct lruvec *lruvec) {}
> +static inline void zswap_page_swapin(struct page *page) {}
>  #endif
>  
>  #endif /* _LINUX_ZSWAP_H */
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 57cd378c73d6..ca87cdb72f11 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -61,6 +61,20 @@ config ZSWAP_EXCLUSIVE_LOADS_DEFAULT_ON
>  	  The cost is that if the page was never dirtied and needs to be
>  	  swapped out again, it will be re-compressed.
>  
> +config ZSWAP_SHRINKER_DEFAULT_ON
> +	bool "Shrink the zswap pool on memory pressure"
> +	depends on ZSWAP
> +	default n
> +	help
> +	  If selected, the zswap shrinker will be enabled, and the pages
> +	  stored in the zswap pool will become available for reclaim (i.e
> +	  written back to the backing swap device) on memory pressure.
> +
> +	  This means that zswap writeback could happen even if the pool is
> +	  not yet full, or the cgroup zswap limit has not been reached,
> +	  reducing the chance that cold pages will reside in the zswap pool
> +	  and consume memory indefinitely.
> +
>  choice
>  	prompt "Default compressor"
>  	depends on ZSWAP
> diff --git a/mm/mmzone.c b/mm/mmzone.c
> index b594d3f268fe..c01896eca736 100644
> --- a/mm/mmzone.c
> +++ b/mm/mmzone.c
> @@ -78,6 +78,7 @@ void lruvec_init(struct lruvec *lruvec)
>  
>  	memset(lruvec, 0, sizeof(struct lruvec));
>  	spin_lock_init(&lruvec->lru_lock);
> +	zswap_lruvec_state_init(lruvec);
>  
>  	for_each_lru(lru)
>  		INIT_LIST_HEAD(&lruvec->lists[lru]);
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 6c84236382f3..c597cec606e4 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -687,6 +687,7 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
>  					&page_allocated, false);
>  	if (unlikely(page_allocated))
>  		swap_readpage(page, false, NULL);
> +	zswap_page_swapin(page);
>  	return page;
>  }
>  
> @@ -862,6 +863,7 @@ static struct page *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
>  					&page_allocated, false);
>  	if (unlikely(page_allocated))
>  		swap_readpage(page, false, NULL);
> +	zswap_page_swapin(page);
>  	return page;
>  }
>  
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 49b79393e472..0f086ffd7b6a 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -148,6 +148,11 @@ module_param_named(exclusive_loads, zswap_exclusive_loads_enabled, bool, 0644);
>  /* Number of zpools in zswap_pool (empirically determined for scalability) */
>  #define ZSWAP_NR_ZPOOLS 32
>  
> +/* Enable/disable memory pressure-based shrinker. */
> +static bool zswap_shrinker_enabled = IS_ENABLED(
> +		CONFIG_ZSWAP_SHRINKER_DEFAULT_ON);
> +module_param_named(shrinker_enabled, zswap_shrinker_enabled, bool, 0644);
> +
>  /*********************************
>  * data structures
>  **********************************/
> @@ -177,6 +182,8 @@ struct zswap_pool {
>  	char tfm_name[CRYPTO_MAX_ALG_NAME];
>  	struct list_lru list_lru;
>  	struct mem_cgroup *next_shrink;
> +	struct shrinker *shrinker;
> +	atomic_t nr_stored;
>  };
>  
>  /*
> @@ -275,17 +282,26 @@ static bool zswap_can_accept(void)
>  			DIV_ROUND_UP(zswap_pool_total_size, PAGE_SIZE);
>  }
>  
> +static u64 get_zswap_pool_size(struct zswap_pool *pool)
> +{
> +	u64 pool_size = 0;
> +	int i;
> +
> +	for (i = 0; i < ZSWAP_NR_ZPOOLS; i++)
> +		pool_size += zpool_get_total_size(pool->zpools[i]);
> +
> +	return pool_size;
> +}
> +
>  static void zswap_update_total_size(void)
>  {
>  	struct zswap_pool *pool;
>  	u64 total = 0;
> -	int i;
>  
>  	rcu_read_lock();
>  
>  	list_for_each_entry_rcu(pool, &zswap_pools, list)
> -		for (i = 0; i < ZSWAP_NR_ZPOOLS; i++)
> -			total += zpool_get_total_size(pool->zpools[i]);
> +		total += get_zswap_pool_size(pool);
>  
>  	rcu_read_unlock();
>  
> @@ -344,13 +360,34 @@ static void zswap_entry_cache_free(struct zswap_entry *entry)
>  	kmem_cache_free(zswap_entry_cache, entry);
>  }
>  
> +/*********************************
> +* zswap lruvec functions
> +**********************************/
> +void zswap_lruvec_state_init(struct lruvec *lruvec)
> +{
> +	atomic_long_set(&lruvec->zswap_lruvec_state.nr_zswap_protected, 0);
> +}
> +
> +void zswap_page_swapin(struct page *page)
> +{
> +	struct lruvec *lruvec;
> +
> +	if (page) {
> +		lruvec = folio_lruvec(page_folio(page));
> +		atomic_long_inc(&lruvec->zswap_lruvec_state.nr_zswap_protected);
> +	}
> +}
> +
>  /*********************************
>  * lru functions
>  **********************************/
>  static void zswap_lru_add(struct list_lru *list_lru, struct zswap_entry *entry)
>  {
> +	atomic_long_t *nr_zswap_protected;
> +	unsigned long lru_size, old, new;
>  	int nid = entry_to_nid(entry);
>  	struct mem_cgroup *memcg;
> +	struct lruvec *lruvec;
>  
>  	/*
>  	 * Note that it is safe to use rcu_read_lock() here, even in the face of
> @@ -368,6 +405,19 @@ static void zswap_lru_add(struct list_lru *list_lru, struct zswap_entry *entry)
>  	memcg = mem_cgroup_from_entry(entry);
>  	/* will always succeed */
>  	list_lru_add(list_lru, &entry->lru, nid, memcg);
> +
> +	/* Update the protection area */
> +	lru_size = list_lru_count_one(list_lru, nid, memcg);
> +	lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
> +	nr_zswap_protected = &lruvec->zswap_lruvec_state.nr_zswap_protected;
> +	old = atomic_long_inc_return(nr_zswap_protected);
> +	/*
> +	 * Decay to avoid overflow and adapt to changing workloads.
> +	 * This is based on LRU reclaim cost decaying heuristics.
> +	 */
> +	do {
> +		new = old > lru_size / 4 ? old / 2 : old;
> +	} while (!atomic_long_try_cmpxchg(nr_zswap_protected, &old, new));
>  	rcu_read_unlock();
>  }
>  
> @@ -389,6 +439,7 @@ static void zswap_lru_putback(struct list_lru *list_lru,
>  	int nid = entry_to_nid(entry);
>  	spinlock_t *lock = &list_lru->node[nid].lock;
>  	struct mem_cgroup *memcg;
> +	struct lruvec *lruvec;
>  
>  	rcu_read_lock();
>  	memcg = mem_cgroup_from_entry(entry);
> @@ -396,6 +447,10 @@ static void zswap_lru_putback(struct list_lru *list_lru,
>  	/* we cannot use list_lru_add here, because it increments node's lru count */
>  	list_lru_putback(list_lru, &entry->lru, nid, memcg);
>  	spin_unlock(lock);
> +
> +	lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(entry_to_nid(entry)));
> +	/* increment the protection area to account for the LRU rotation. */
> +	atomic_long_inc(&lruvec->zswap_lruvec_state.nr_zswap_protected);
>  	rcu_read_unlock();
>  }
>  
> @@ -485,6 +540,7 @@ static void zswap_free_entry(struct zswap_entry *entry)
>  	else {
>  		zswap_lru_del(&entry->pool->list_lru, entry);
>  		zpool_free(zswap_find_zpool(entry), entry->handle);
> +		atomic_dec(&entry->pool->nr_stored);
>  		zswap_pool_put(entry->pool);
>  	}
>  	zswap_entry_cache_free(entry);
> @@ -526,6 +582,102 @@ static struct zswap_entry *zswap_entry_find_get(struct rb_root *root,
>  	return entry;
>  }
>  
> +/*********************************
> +* shrinker functions
> +**********************************/
> +static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_one *l,
> +				       spinlock_t *lock, void *arg);
> +
> +static unsigned long zswap_shrinker_scan(struct shrinker *shrinker,
> +		struct shrink_control *sc)
> +{
> +	struct lruvec *lruvec = mem_cgroup_lruvec(sc->memcg, NODE_DATA(sc->nid));
> +	unsigned long shrink_ret, nr_protected, lru_size;
> +	struct zswap_pool *pool = shrinker->private_data;
> +	bool encountered_page_in_swapcache = false;
> +
> +	nr_protected =
> +		atomic_long_read(&lruvec->zswap_lruvec_state.nr_zswap_protected);
> +	lru_size = list_lru_shrink_count(&pool->list_lru, sc);
> +
> +	/*
> +	 * Abort if the shrinker is disabled or if we are shrinking into the
> +	 * protected region.
> +	 *
> +	 * This short-circuiting is necessary because if we have too many multiple
> +	 * concurrent reclaimers getting the freeable zswap object counts at the
> +	 * same time (before any of them made reasonable progress), the total
> +	 * number of reclaimed objects might be more than the number of unprotected
> +	 * objects (i.e the reclaimers will reclaim into the protected area of the
> +	 * zswap LRU).
> +	 */
> +	if (!zswap_shrinker_enabled || nr_protected >= lru_size - sc->nr_to_scan) {
> +		sc->nr_scanned = 0;
> +		return SHRINK_STOP;
> +	}
> +
> +	shrink_ret = list_lru_shrink_walk(&pool->list_lru, sc, &shrink_memcg_cb,
> +		&encountered_page_in_swapcache);
> +
> +	if (encountered_page_in_swapcache)
> +		return SHRINK_STOP;
> +
> +	return shrink_ret ? shrink_ret : SHRINK_STOP;
> +}
> +
> +static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
> +		struct shrink_control *sc)
> +{
> +	struct zswap_pool *pool = shrinker->private_data;
> +	struct mem_cgroup *memcg = sc->memcg;
> +	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(sc->nid));
> +	unsigned long nr_backing, nr_stored, nr_freeable, nr_protected;
> +
> +#ifdef CONFIG_MEMCG_KMEM
> +	cgroup_rstat_flush(memcg->css.cgroup);
> +	nr_backing = memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PAGE_SHIFT;
> +	nr_stored = memcg_page_state(memcg, MEMCG_ZSWAPPED);
> +#else
> +	/* use pool stats instead of memcg stats */
> +	nr_backing = get_zswap_pool_size(pool) >> PAGE_SHIFT;
> +	nr_stored = atomic_read(&pool->nr_stored);
> +#endif
> +
> +	if (!zswap_shrinker_enabled || !nr_stored)
When I tested with this series, with !zswap_shrinker_enabled in the default case,
I found the performance is much worse than that without this patch.

Testcase: memory.max=2G, zswap enabled, kernel build -j32 in a tmpfs directory.

The reason seems the above cgroup_rstat_flush(), caused much rstat lock contention
to the zswap_store() path. And if I put the "zswap_shrinker_enabled" check above
the cgroup_rstat_flush(), the performance become much better.

Maybe we can put the "zswap_shrinker_enabled" check above cgroup_rstat_flush()?

Thanks!

> +		return 0;
> +
> +	nr_protected =
> +		atomic_long_read(&lruvec->zswap_lruvec_state.nr_zswap_protected);
> +	nr_freeable = list_lru_shrink_count(&pool->list_lru, sc);
> +	/*
> +	 * Subtract the lru size by an estimate of the number of pages
> +	 * that should be protected.
> +	 */
> +	nr_freeable = nr_freeable > nr_protected ? nr_freeable - nr_protected : 0;
> +
> +	/*
> +	 * Scale the number of freeable pages by the memory saving factor.
> +	 * This ensures that the better zswap compresses memory, the fewer
> +	 * pages we will evict to swap (as it will otherwise incur IO for
> +	 * relatively small memory saving).
> +	 */
> +	return mult_frac(nr_freeable, nr_backing, nr_stored);
> +}
> +
> +static void zswap_alloc_shrinker(struct zswap_pool *pool)
> +{
> +	pool->shrinker =
> +		shrinker_alloc(SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE, "mm-zswap");
> +	if (!pool->shrinker)
> +		return;
> +
> +	pool->shrinker->private_data = pool;
> +	pool->shrinker->scan_objects = zswap_shrinker_scan;
> +	pool->shrinker->count_objects = zswap_shrinker_count;
> +	pool->shrinker->batch = 0;
> +	pool->shrinker->seeks = DEFAULT_SEEKS;
> +}
> +
>  /*********************************
>  * per-cpu code
>  **********************************/
> @@ -721,6 +873,7 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
>  				       spinlock_t *lock, void *arg)
>  {
>  	struct zswap_entry *entry = container_of(item, struct zswap_entry, lru);
> +	bool *encountered_page_in_swapcache = (bool *)arg;
>  	struct zswap_tree *tree;
>  	pgoff_t swpoffset;
>  	enum lru_status ret = LRU_REMOVED_RETRY;
> @@ -756,6 +909,17 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
>  		zswap_reject_reclaim_fail++;
>  		zswap_lru_putback(&entry->pool->list_lru, entry);
>  		ret = LRU_RETRY;
> +
> +		/*
> +		 * Encountering a page already in swap cache is a sign that we are shrinking
> +		 * into the warmer region. We should terminate shrinking (if we're in the dynamic
> +		 * shrinker context).
> +		 */
> +		if (writeback_result == -EEXIST && encountered_page_in_swapcache) {
> +			ret = LRU_SKIP;
> +			*encountered_page_in_swapcache = true;
> +		}
> +
>  		goto put_unlock;
>  	}
>  	zswap_written_back_pages++;
> @@ -913,6 +1077,11 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
>  				       &pool->node);
>  	if (ret)
>  		goto error;
> +
> +	zswap_alloc_shrinker(pool);
> +	if (!pool->shrinker)
> +		goto error;
> +
>  	pr_debug("using %s compressor\n", pool->tfm_name);
>  
>  	/* being the current pool takes 1 ref; this func expects the
> @@ -920,13 +1089,19 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
>  	 */
>  	kref_init(&pool->kref);
>  	INIT_LIST_HEAD(&pool->list);
> -	list_lru_init_memcg(&pool->list_lru, NULL);
> +	if (list_lru_init_memcg(&pool->list_lru, pool->shrinker))
> +		goto lru_fail;
> +	shrinker_register(pool->shrinker);
>  	INIT_WORK(&pool->shrink_work, shrink_worker);
> +	atomic_set(&pool->nr_stored, 0);
>  
>  	zswap_pool_debug("created", pool);
>  
>  	return pool;
>  
> +lru_fail:
> +	list_lru_destroy(&pool->list_lru);
> +	shrinker_free(pool->shrinker);
>  error:
>  	if (pool->acomp_ctx)
>  		free_percpu(pool->acomp_ctx);
> @@ -984,6 +1159,7 @@ static void zswap_pool_destroy(struct zswap_pool *pool)
>  
>  	zswap_pool_debug("destroying", pool);
>  
> +	shrinker_free(pool->shrinker);
>  	cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &pool->node);
>  	free_percpu(pool->acomp_ctx);
>  	list_lru_destroy(&pool->list_lru);
> @@ -1540,6 +1716,7 @@ bool zswap_store(struct folio *folio)
>  	if (entry->length) {
>  		INIT_LIST_HEAD(&entry->lru);
>  		zswap_lru_add(&entry->pool->list_lru, entry);
> +		atomic_inc(&entry->pool->nr_stored);
>  	}
>  	spin_unlock(&tree->lock);
>  

