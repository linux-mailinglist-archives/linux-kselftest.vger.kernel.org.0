Return-Path: <linux-kselftest+bounces-1225-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB31D806561
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 04:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FDDA2825DC
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 03:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F232D6D22;
	Wed,  6 Dec 2023 03:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kokTxh7L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97681B1;
	Tue,  5 Dec 2023 19:03:18 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-35d725ac060so10179365ab.2;
        Tue, 05 Dec 2023 19:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701831798; x=1702436598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXtYIF9mDzAw2nmZ5sAQTh9n5ch5MmeRp+/MaZCXAPA=;
        b=kokTxh7LPHmpCSaS7lorpOwngonriX6Fnq3EU+i1wlEOyjc8vNfHtXFRHwTDVz8FPv
         m+Gla+UmXJXoNFBdgTRHO4I9soIFJz6spK0oOak7szxozXbO7Y8FukdPcmJGsf98oPvp
         MyfjhsmjEzaaYt0xf8hUIrL7NvcojbgJ93NR3MaENmfbEjmZpE9sokDvGqBXHNZ+R+Jq
         KU6vN7sm9gbuLVsh7OfSPTO16sndW0yl0TVUTQYALhtdmsFnpSuJpI4d6Sr1TlI0vfia
         MnsPfOXPmIBw06U0ufQudO5cx2nWlMq2NsWj0uCexl96oQnn1g6oN6YAIH5TNePg7ZuU
         2otQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701831798; x=1702436598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXtYIF9mDzAw2nmZ5sAQTh9n5ch5MmeRp+/MaZCXAPA=;
        b=vYAHnlhGLrBTgUMcgaHx8RQ1vyInsjJ4Igpfw/enD7fm3+rcKmZM70Be9GRx2lnAay
         L5rtVDg24gNhHLBf/SBbwooofWE8cFs0TL6G1iQE6p4HahHKhC5+euIxMGU/0R6wyCWy
         I7QflLavjhP1qToXE3b1D4FE+gN+iN+s4EN2c7nQ9RIzpDGKZIERRRYA6wFqJZxMvuEZ
         jDQfRCzBV77CfoTjZiHFLrqOOilSHb8JWxJA3GjYz+j+JQ7OeIbsY343xUSt3Q9kSVCP
         cAl53z+VLRuI2GRIlR5y8//yxrrkZ1xYYG7sWmLrPPS3OOJQ2Vrch2OVQcWlZBlrJyMC
         azxQ==
X-Gm-Message-State: AOJu0Ywg7H7su1PvX7JKhyylt4YWuydjCi3CImMgzAlnz6VER8ZW4CFT
	gVcH/xQ5ZXp9e/qWHts+PTa1TulNXzBvRxJm2NE=
X-Google-Smtp-Source: AGHT+IG8IbUJhmurGx42aO4Y6bKD97oCS5MfxKmBymUoqPbJqMDhqT3T83yHZNKtFxKbNnveCAckh0K+TZNBSeU6NcM=
X-Received: by 2002:a92:c60a:0:b0:35d:59a2:128d with SMTP id
 p10-20020a92c60a000000b0035d59a2128dmr331888ilm.57.1701831797740; Tue, 05 Dec
 2023 19:03:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130194023.4102148-1-nphamcs@gmail.com> <20231130194023.4102148-4-nphamcs@gmail.com>
In-Reply-To: <20231130194023.4102148-4-nphamcs@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 5 Dec 2023 19:03:06 -0800
Message-ID: <CAKEwX=NQujx29=+bbs2A8wQ-JJ=-9=SmdzEKAUyn6uN2KJt0Eg@mail.gmail.com>
Subject: Re: [PATCH v8 3/6] zswap: make shrinking memcg-aware
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org, cerasuolodomenico@gmail.com, yosryahmed@google.com, 
	sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com, 
	muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 11:40=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> From: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
>
> Currently, we only have a single global LRU for zswap. This makes it
> impossible to perform worload-specific shrinking - an memcg cannot
> determine which pages in the pool it owns, and often ends up writing
> pages from other memcgs. This issue has been previously observed in
> practice and mitigated by simply disabling memcg-initiated shrinking:
>
> https://lore.kernel.org/all/20230530232435.3097106-1-nphamcs@gmail.com/T/=
#u
>
> This patch fully resolves the issue by replacing the global zswap LRU
> with memcg- and NUMA-specific LRUs, and modify the reclaim logic:
>
> a) When a store attempt hits an memcg limit, it now triggers a
>    synchronous reclaim attempt that, if successful, allows the new
>    hotter page to be accepted by zswap.
> b) If the store attempt instead hits the global zswap limit, it will
>    trigger an asynchronous reclaim attempt, in which an memcg is
>    selected for reclaim in a round-robin-like fashion.
>
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> Co-developed-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  include/linux/memcontrol.h |   5 +
>  include/linux/zswap.h      |   2 +
>  mm/memcontrol.c            |   2 +
>  mm/swap.h                  |   3 +-
>  mm/swap_state.c            |  24 +++-
>  mm/zswap.c                 | 269 +++++++++++++++++++++++++++++--------
>  6 files changed, 245 insertions(+), 60 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 2bd7d14ace78..a308c8eacf20 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1192,6 +1192,11 @@ static inline struct mem_cgroup *page_memcg_check(=
struct page *page)
>         return NULL;
>  }
>
> +static inline struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cg=
roup *objcg)
> +{
> +       return NULL;
> +}
> +
>  static inline bool folio_memcg_kmem(struct folio *folio)
>  {
>         return false;
> diff --git a/include/linux/zswap.h b/include/linux/zswap.h
> index 2a60ce39cfde..e571e393669b 100644
> --- a/include/linux/zswap.h
> +++ b/include/linux/zswap.h
> @@ -15,6 +15,7 @@ bool zswap_load(struct folio *folio);
>  void zswap_invalidate(int type, pgoff_t offset);
>  void zswap_swapon(int type);
>  void zswap_swapoff(int type);
> +void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg);
>
>  #else
>
> @@ -31,6 +32,7 @@ static inline bool zswap_load(struct folio *folio)
>  static inline void zswap_invalidate(int type, pgoff_t offset) {}
>  static inline void zswap_swapon(int type) {}
>  static inline void zswap_swapoff(int type) {}
> +static inline void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)=
 {}
>
>  #endif
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 470821d1ba1a..792ca21c5815 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5614,6 +5614,8 @@ static void mem_cgroup_css_offline(struct cgroup_su=
bsys_state *css)
>         page_counter_set_min(&memcg->memory, 0);
>         page_counter_set_low(&memcg->memory, 0);
>
> +       zswap_memcg_offline_cleanup(memcg);
> +
>         memcg_offline_kmem(memcg);
>         reparent_shrinker_deferred(memcg);
>         wb_memcg_offline(memcg);
> diff --git a/mm/swap.h b/mm/swap.h
> index 73c332ee4d91..c0dc73e10e91 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -51,7 +51,8 @@ struct page *read_swap_cache_async(swp_entry_t entry, g=
fp_t gfp_mask,
>                                    struct swap_iocb **plug);
>  struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>                                      struct mempolicy *mpol, pgoff_t ilx,
> -                                    bool *new_page_allocated);
> +                                    bool *new_page_allocated,
> +                                    bool skip_if_exists);
>  struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
>                                     struct mempolicy *mpol, pgoff_t ilx);
>  struct page *swapin_readahead(swp_entry_t entry, gfp_t flag,
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 85d9e5806a6a..6c84236382f3 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -412,7 +412,8 @@ struct folio *filemap_get_incore_folio(struct address=
_space *mapping,
>
>  struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>                                      struct mempolicy *mpol, pgoff_t ilx,
> -                                    bool *new_page_allocated)
> +                                    bool *new_page_allocated,
> +                                    bool skip_if_exists)
>  {
>         struct swap_info_struct *si;
>         struct folio *folio;
> @@ -470,6 +471,17 @@ struct page *__read_swap_cache_async(swp_entry_t ent=
ry, gfp_t gfp_mask,
>                 if (err !=3D -EEXIST)
>                         goto fail_put_swap;
>
> +               /*
> +                * Protect against a recursive call to __read_swap_cache_=
async()
> +                * on the same entry waiting forever here because SWAP_HA=
S_CACHE
> +                * is set but the folio is not the swap cache yet. This c=
an
> +                * happen today if mem_cgroup_swapin_charge_folio() below
> +                * triggers reclaim through zswap, which may call
> +                * __read_swap_cache_async() in the writeback path.
> +                */
> +               if (skip_if_exists)
> +                       goto fail_put_swap;
> +
>                 /*
>                  * We might race against __delete_from_swap_cache(), and
>                  * stumble across a swap_map entry whose SWAP_HAS_CACHE
> @@ -537,7 +549,7 @@ struct page *read_swap_cache_async(swp_entry_t entry,=
 gfp_t gfp_mask,
>
>         mpol =3D get_vma_policy(vma, addr, 0, &ilx);
>         page =3D __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
> -                                       &page_allocated);
> +                                       &page_allocated, false);
>         mpol_cond_put(mpol);
>
>         if (page_allocated)
> @@ -654,7 +666,7 @@ struct page *swap_cluster_readahead(swp_entry_t entry=
, gfp_t gfp_mask,
>                 /* Ok, do the async read-ahead now */
>                 page =3D __read_swap_cache_async(
>                                 swp_entry(swp_type(entry), offset),
> -                               gfp_mask, mpol, ilx, &page_allocated);
> +                               gfp_mask, mpol, ilx, &page_allocated, fal=
se);
>                 if (!page)
>                         continue;
>                 if (page_allocated) {
> @@ -672,7 +684,7 @@ struct page *swap_cluster_readahead(swp_entry_t entry=
, gfp_t gfp_mask,
>  skip:
>         /* The page was likely read above, so no need for plugging here *=
/
>         page =3D __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
> -                                       &page_allocated);
> +                                       &page_allocated, false);
>         if (unlikely(page_allocated))
>                 swap_readpage(page, false, NULL);
>         return page;
> @@ -827,7 +839,7 @@ static struct page *swap_vma_readahead(swp_entry_t ta=
rg_entry, gfp_t gfp_mask,
>                 pte_unmap(pte);
>                 pte =3D NULL;
>                 page =3D __read_swap_cache_async(entry, gfp_mask, mpol, i=
lx,
> -                                               &page_allocated);
> +                                               &page_allocated, false);
>                 if (!page)
>                         continue;
>                 if (page_allocated) {
> @@ -847,7 +859,7 @@ static struct page *swap_vma_readahead(swp_entry_t ta=
rg_entry, gfp_t gfp_mask,
>  skip:
>         /* The page was likely read above, so no need for plugging here *=
/
>         page =3D __read_swap_cache_async(targ_entry, gfp_mask, mpol, targ=
_ilx,
> -                                       &page_allocated);
> +                                       &page_allocated, false);
>         if (unlikely(page_allocated))
>                 swap_readpage(page, false, NULL);
>         return page;
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 4bdb2d83bb0d..f323e45cbdc7 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -35,6 +35,7 @@
>  #include <linux/writeback.h>
>  #include <linux/pagemap.h>
>  #include <linux/workqueue.h>
> +#include <linux/list_lru.h>
>
>  #include "swap.h"
>  #include "internal.h"
> @@ -174,8 +175,8 @@ struct zswap_pool {
>         struct work_struct shrink_work;
>         struct hlist_node node;
>         char tfm_name[CRYPTO_MAX_ALG_NAME];
> -       struct list_head lru;
> -       spinlock_t lru_lock;
> +       struct list_lru list_lru;
> +       struct mem_cgroup *next_shrink;
>  };
>
>  /*
> @@ -291,15 +292,46 @@ static void zswap_update_total_size(void)
>         zswap_pool_total_size =3D total;
>  }
>
> +/* should be called under RCU */
> +#ifdef CONFIG_MEMCG
> +static inline struct mem_cgroup *mem_cgroup_from_entry(struct zswap_entr=
y *entry)
> +{
> +       return entry->objcg ? obj_cgroup_memcg(entry->objcg) : NULL;
> +}
> +#else
> +static inline struct mem_cgroup *mem_cgroup_from_entry(struct zswap_entr=
y *entry)
> +{
> +       return NULL;
> +}
> +#endif
> +
> +static inline int entry_to_nid(struct zswap_entry *entry)
> +{
> +       return page_to_nid(virt_to_page(entry));
> +}
> +
> +void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
> +{
> +       struct zswap_pool *pool;
> +
> +       /* lock out zswap pools list modification */
> +       spin_lock(&zswap_pools_lock);
> +       list_for_each_entry(pool, &zswap_pools, list) {
> +               if (pool->next_shrink =3D=3D memcg)
> +                       pool->next_shrink =3D mem_cgroup_iter(NULL, pool-=
>next_shrink, NULL);
> +       }
> +       spin_unlock(&zswap_pools_lock);
> +}
> +
>  /*********************************
>  * zswap entry functions
>  **********************************/
>  static struct kmem_cache *zswap_entry_cache;
>
> -static struct zswap_entry *zswap_entry_cache_alloc(gfp_t gfp)
> +static struct zswap_entry *zswap_entry_cache_alloc(gfp_t gfp, int nid)
>  {
>         struct zswap_entry *entry;
> -       entry =3D kmem_cache_alloc(zswap_entry_cache, gfp);
> +       entry =3D kmem_cache_alloc_node(zswap_entry_cache, gfp, nid);
>         if (!entry)
>                 return NULL;
>         entry->refcount =3D 1;
> @@ -312,6 +344,61 @@ static void zswap_entry_cache_free(struct zswap_entr=
y *entry)
>         kmem_cache_free(zswap_entry_cache, entry);
>  }
>
> +/*********************************
> +* lru functions
> +**********************************/
> +static void zswap_lru_add(struct list_lru *list_lru, struct zswap_entry =
*entry)
> +{
> +       int nid =3D entry_to_nid(entry);
> +       struct mem_cgroup *memcg;
> +
> +       /*
> +        * Note that it is safe to use rcu_read_lock() here, even in the =
face of
> +        * concurrent memcg offlining. Thanks to the memcg->kmemcg_id ind=
irection
> +        * used in list_lru lookup, only two scenarios are possible:
> +        *
> +        * 1. list_lru_add() is called before memcg->kmemcg_id is updated=
. The
> +        *    new entry will be reparented to memcg's parent's list_lru.
> +        * 2. list_lru_add() is called after memcg->kmemcg_id is updated.=
 The
> +        *    new entry will be added directly to memcg's parent's list_l=
ru.
> +        *
> +        * Similar reasoning holds for list_lru_del() and list_lru_putbac=
k().
> +        */
> +       rcu_read_lock();
> +       memcg =3D mem_cgroup_from_entry(entry);
> +       /* will always succeed */
> +       list_lru_add(list_lru, &entry->lru, nid, memcg);
> +       rcu_read_unlock();
> +}
> +
> +static void zswap_lru_del(struct list_lru *list_lru, struct zswap_entry =
*entry)
> +{
> +       int nid =3D entry_to_nid(entry);
> +       struct mem_cgroup *memcg;
> +
> +       rcu_read_lock();
> +       memcg =3D mem_cgroup_from_entry(entry);
> +       /* will always succeed */
> +       list_lru_del(list_lru, &entry->lru, nid, memcg);
> +       rcu_read_unlock();
> +}
> +
> +static void zswap_lru_putback(struct list_lru *list_lru,
> +               struct zswap_entry *entry)
> +{
> +       int nid =3D entry_to_nid(entry);
> +       spinlock_t *lock =3D &list_lru->node[nid].lock;
> +       struct mem_cgroup *memcg;
> +
> +       rcu_read_lock();
> +       memcg =3D mem_cgroup_from_entry(entry);
> +       spin_lock(lock);
> +       /* we cannot use list_lru_add here, because it increments node's =
lru count */
> +       list_lru_putback(list_lru, &entry->lru, nid, memcg);
> +       spin_unlock(lock);
> +       rcu_read_unlock();
> +}
> +
>  /*********************************
>  * rbtree functions
>  **********************************/
> @@ -396,9 +483,7 @@ static void zswap_free_entry(struct zswap_entry *entr=
y)
>         if (!entry->length)
>                 atomic_dec(&zswap_same_filled_pages);
>         else {
> -               spin_lock(&entry->pool->lru_lock);
> -               list_del(&entry->lru);
> -               spin_unlock(&entry->pool->lru_lock);
> +               zswap_lru_del(&entry->pool->list_lru, entry);
>                 zpool_free(zswap_find_zpool(entry), entry->handle);
>                 zswap_pool_put(entry->pool);
>         }
> @@ -632,21 +717,15 @@ static void zswap_invalidate_entry(struct zswap_tre=
e *tree,
>                 zswap_entry_put(tree, entry);
>  }
>
> -static int zswap_reclaim_entry(struct zswap_pool *pool)
> +static enum lru_status shrink_memcg_cb(struct list_head *item, struct li=
st_lru_one *l,
> +                                      spinlock_t *lock, void *arg)
>  {
> -       struct zswap_entry *entry;
> +       struct zswap_entry *entry =3D container_of(item, struct zswap_ent=
ry, lru);
>         struct zswap_tree *tree;
>         pgoff_t swpoffset;
> -       int ret;
> +       enum lru_status ret =3D LRU_REMOVED_RETRY;
> +       int writeback_result;
>
> -       /* Get an entry off the LRU */
> -       spin_lock(&pool->lru_lock);
> -       if (list_empty(&pool->lru)) {
> -               spin_unlock(&pool->lru_lock);
> -               return -EINVAL;
> -       }
> -       entry =3D list_last_entry(&pool->lru, struct zswap_entry, lru);
> -       list_del_init(&entry->lru);
>         /*
>          * Once the lru lock is dropped, the entry might get freed. The
>          * swpoffset is copied to the stack, and entry isn't deref'd agai=
n
> @@ -654,28 +733,32 @@ static int zswap_reclaim_entry(struct zswap_pool *p=
ool)
>          */
>         swpoffset =3D swp_offset(entry->swpentry);
>         tree =3D zswap_trees[swp_type(entry->swpentry)];
> -       spin_unlock(&pool->lru_lock);
> +       list_lru_isolate(l, item);
> +       /*
> +        * It's safe to drop the lock here because we return either
> +        * LRU_REMOVED_RETRY or LRU_RETRY.
> +        */
> +       spin_unlock(lock);
>
>         /* Check for invalidate() race */
>         spin_lock(&tree->lock);
> -       if (entry !=3D zswap_rb_search(&tree->rbroot, swpoffset)) {
> -               ret =3D -EAGAIN;
> +       if (entry !=3D zswap_rb_search(&tree->rbroot, swpoffset))
>                 goto unlock;
> -       }
> +
>         /* Hold a reference to prevent a free during writeback */
>         zswap_entry_get(entry);
>         spin_unlock(&tree->lock);
>
> -       ret =3D zswap_writeback_entry(entry, tree);
> +       writeback_result =3D zswap_writeback_entry(entry, tree);
>
>         spin_lock(&tree->lock);
> -       if (ret) {
> -               /* Writeback failed, put entry back on LRU */
> -               spin_lock(&pool->lru_lock);
> -               list_move(&entry->lru, &pool->lru);
> -               spin_unlock(&pool->lru_lock);
> +       if (writeback_result) {
> +               zswap_reject_reclaim_fail++;
> +               zswap_lru_putback(&entry->pool->list_lru, entry);
> +               ret =3D LRU_RETRY;
>                 goto put_unlock;
>         }
> +       zswap_written_back_pages++;
>
>         /*
>          * Writeback started successfully, the page now belongs to the
> @@ -689,27 +772,93 @@ static int zswap_reclaim_entry(struct zswap_pool *p=
ool)
>         zswap_entry_put(tree, entry);
>  unlock:
>         spin_unlock(&tree->lock);
> -       return ret ? -EAGAIN : 0;
> +       spin_lock(lock);
> +       return ret;
> +}
> +
> +static int shrink_memcg(struct mem_cgroup *memcg)
> +{
> +       struct zswap_pool *pool;
> +       int nid, shrunk =3D 0;
> +
> +       /*
> +        * Skip zombies because their LRUs are reparented and we would be
> +        * reclaiming from the parent instead of the dead memcg.
> +        */
> +       if (memcg && !mem_cgroup_online(memcg))
> +               return -ENOENT;
> +
> +       pool =3D zswap_pool_current_get();
> +       if (!pool)
> +               return -EINVAL;
> +
> +       for_each_node_state(nid, N_NORMAL_MEMORY) {
> +               unsigned long nr_to_walk =3D 1;
> +
> +               shrunk +=3D list_lru_walk_one(&pool->list_lru, nid, memcg=
,
> +                                           &shrink_memcg_cb, NULL, &nr_t=
o_walk);
> +       }
> +       zswap_pool_put(pool);
> +       return shrunk ? 0 : -EAGAIN;
>  }
>
>  static void shrink_worker(struct work_struct *w)
>  {
>         struct zswap_pool *pool =3D container_of(w, typeof(*pool),
>                                                 shrink_work);
> +       struct mem_cgroup *memcg;
>         int ret, failures =3D 0;
>
> +       /* global reclaim will select cgroup in a round-robin fashion. */
>         do {
> -               ret =3D zswap_reclaim_entry(pool);
> -               if (ret) {
> -                       zswap_reject_reclaim_fail++;
> -                       if (ret !=3D -EAGAIN)
> +               spin_lock(&zswap_pools_lock);
> +               pool->next_shrink =3D mem_cgroup_iter(NULL, pool->next_sh=
rink, NULL);
> +               memcg =3D pool->next_shrink;
> +
> +               /*
> +                * We need to retry if we have gone through a full round =
trip, or if we
> +                * got an offline memcg (or else we risk undoing the effe=
ct of the
> +                * zswap memcg offlining cleanup callback). This is not c=
atastrophic
> +                * per se, but it will keep the now offlined memcg hostag=
e for a while.
> +                *
> +                * Note that if we got an online memcg, we will keep the =
extra
> +                * reference in case the original reference obtained by m=
em_cgroup_iter
> +                * is dropped by the zswap memcg offlining callback, ensu=
ring that the
> +                * memcg is not killed when we are reclaiming.
> +                */
> +               if (!memcg) {
> +                       spin_unlock(&zswap_pools_lock);
> +                       if (++failures =3D=3D MAX_RECLAIM_RETRIES)
>                                 break;
> +
> +                       goto resched;
> +               }
> +
> +               if (!mem_cgroup_online(memcg)) {
> +                       /* drop the reference from mem_cgroup_iter() */
> +                       mem_cgroup_put(memcg);
> +                       pool->next_shrink =3D NULL;
> +                       spin_unlock(&zswap_pools_lock);
> +
>                         if (++failures =3D=3D MAX_RECLAIM_RETRIES)
>                                 break;
> +
> +                       goto resched;
>                 }
> +               spin_unlock(&zswap_pools_lock);
> +
> +               ret =3D shrink_memcg(memcg);
> +               /* drop the extra reference */
> +               mem_cgroup_put(memcg);
> +
> +               if (ret =3D=3D -EINVAL)
> +                       break;
> +               if (ret && ++failures =3D=3D MAX_RECLAIM_RETRIES)
> +                       break;
> +
> +resched:
>                 cond_resched();
>         } while (!zswap_can_accept());
> -       zswap_pool_put(pool);

Actually, after staring at this code for a bit more - this looks
wrong. This line should not have been removed - this reference putting
pairs with the getting from zswap_store(). Looks like some mishap when
I rebased and cleaned stuff. Lemme send a fixlet to undo this removal
real quick.





>  }
>
>  static struct zswap_pool *zswap_pool_create(char *type, char *compressor=
)
> @@ -767,8 +916,7 @@ static struct zswap_pool *zswap_pool_create(char *typ=
e, char *compressor)
>          */
>         kref_init(&pool->kref);
>         INIT_LIST_HEAD(&pool->list);
> -       INIT_LIST_HEAD(&pool->lru);
> -       spin_lock_init(&pool->lru_lock);
> +       list_lru_init_memcg(&pool->list_lru, NULL);
>         INIT_WORK(&pool->shrink_work, shrink_worker);
>
>         zswap_pool_debug("created", pool);
> @@ -834,6 +982,13 @@ static void zswap_pool_destroy(struct zswap_pool *po=
ol)
>
>         cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &pool->no=
de);
>         free_percpu(pool->acomp_ctx);
> +       list_lru_destroy(&pool->list_lru);
> +
> +       spin_lock(&zswap_pools_lock);
> +       mem_cgroup_put(pool->next_shrink);
> +       pool->next_shrink =3D NULL;
> +       spin_unlock(&zswap_pools_lock);
> +
>         for (i =3D 0; i < ZSWAP_NR_ZPOOLS; i++)
>                 zpool_destroy_pool(pool->zpools[i]);
>         kfree(pool);
> @@ -1081,7 +1236,7 @@ static int zswap_writeback_entry(struct zswap_entry=
 *entry,
>         /* try to allocate swap cache page */
>         mpol =3D get_task_policy(current);
>         page =3D __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
> -                               NO_INTERLEAVE_INDEX, &page_was_allocated)=
;
> +                               NO_INTERLEAVE_INDEX, &page_was_allocated,=
 true);
>         if (!page) {
>                 ret =3D -ENOMEM;
>                 goto fail;
> @@ -1152,7 +1307,6 @@ static int zswap_writeback_entry(struct zswap_entry=
 *entry,
>         /* start writeback */
>         __swap_writepage(page, &wbc);
>         put_page(page);
> -       zswap_written_back_pages++;
>
>         return ret;
>
> @@ -1209,6 +1363,7 @@ bool zswap_store(struct folio *folio)
>         struct scatterlist input, output;
>         struct crypto_acomp_ctx *acomp_ctx;
>         struct obj_cgroup *objcg =3D NULL;
> +       struct mem_cgroup *memcg =3D NULL;
>         struct zswap_pool *pool;
>         struct zpool *zpool;
>         unsigned int dlen =3D PAGE_SIZE;
> @@ -1240,15 +1395,15 @@ bool zswap_store(struct folio *folio)
>                 zswap_invalidate_entry(tree, dupentry);
>         }
>         spin_unlock(&tree->lock);
> -
> -       /*
> -        * XXX: zswap reclaim does not work with cgroups yet. Without a
> -        * cgroup-aware entry LRU, we will push out entries system-wide b=
ased on
> -        * local cgroup limits.
> -        */
>         objcg =3D get_obj_cgroup_from_folio(folio);
> -       if (objcg && !obj_cgroup_may_zswap(objcg))
> -               goto reject;
> +       if (objcg && !obj_cgroup_may_zswap(objcg)) {
> +               memcg =3D get_mem_cgroup_from_objcg(objcg);
> +               if (shrink_memcg(memcg)) {
> +                       mem_cgroup_put(memcg);
> +                       goto reject;
> +               }
> +               mem_cgroup_put(memcg);
> +       }
>
>         /* reclaim space if needed */
>         if (zswap_is_full()) {
> @@ -1265,7 +1420,7 @@ bool zswap_store(struct folio *folio)
>         }
>
>         /* allocate entry */
> -       entry =3D zswap_entry_cache_alloc(GFP_KERNEL);
> +       entry =3D zswap_entry_cache_alloc(GFP_KERNEL, page_to_nid(page));
>         if (!entry) {
>                 zswap_reject_kmemcache_fail++;
>                 goto reject;
> @@ -1292,6 +1447,15 @@ bool zswap_store(struct folio *folio)
>         if (!entry->pool)
>                 goto freepage;
>
> +       if (objcg) {
> +               memcg =3D get_mem_cgroup_from_objcg(objcg);
> +               if (memcg_list_lru_alloc(memcg, &entry->pool->list_lru, G=
FP_KERNEL)) {
> +                       mem_cgroup_put(memcg);
> +                       goto put_pool;
> +               }
> +               mem_cgroup_put(memcg);
> +       }
> +
>         /* compress */
>         acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
>
> @@ -1370,9 +1534,8 @@ bool zswap_store(struct folio *folio)
>                 zswap_invalidate_entry(tree, dupentry);
>         }
>         if (entry->length) {
> -               spin_lock(&entry->pool->lru_lock);
> -               list_add(&entry->lru, &entry->pool->lru);
> -               spin_unlock(&entry->pool->lru_lock);
> +               INIT_LIST_HEAD(&entry->lru);
> +               zswap_lru_add(&entry->pool->list_lru, entry);
>         }
>         spin_unlock(&tree->lock);
>
> @@ -1385,6 +1548,7 @@ bool zswap_store(struct folio *folio)
>
>  put_dstmem:
>         mutex_unlock(acomp_ctx->mutex);
> +put_pool:
>         zswap_pool_put(entry->pool);
>  freepage:
>         zswap_entry_cache_free(entry);
> @@ -1479,9 +1643,8 @@ bool zswap_load(struct folio *folio)
>                 zswap_invalidate_entry(tree, entry);
>                 folio_mark_dirty(folio);
>         } else if (entry->length) {
> -               spin_lock(&entry->pool->lru_lock);
> -               list_move(&entry->lru, &entry->pool->lru);
> -               spin_unlock(&entry->pool->lru_lock);
> +               zswap_lru_del(&entry->pool->list_lru, entry);
> +               zswap_lru_add(&entry->pool->list_lru, entry);
>         }
>         zswap_entry_put(tree, entry);
>         spin_unlock(&tree->lock);
> --
> 2.34.1

