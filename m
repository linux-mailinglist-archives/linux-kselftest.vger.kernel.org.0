Return-Path: <linux-kselftest+bounces-1218-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 998BD806336
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 01:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47CD028199D
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 00:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6872360;
	Wed,  6 Dec 2023 00:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSAaQrlT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B5D62F
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Dec 2023 00:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D588C43391
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Dec 2023 00:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701821432;
	bh=O5Z097xTpkMFR7i/h9y3akbHBtSZ7ePxcsKXjyAjQrg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JSAaQrlT8kkmuNEp+5bz4IAi4FY6hePh/LpHxU7CSj5roEuvjz7hW31sZxtlb/tmG
	 dmtNjFjHUiHvmNB4HHXJCuuqltzq3fptTOESbQqGBhwx4gTLxvF1oLTXDSKuT2AM/c
	 qalHTCohz5YIq3LkJPBy5yOaZonLvlMCTZ0pNlOjCzzT0iDuWegC8YzFrMf7rES/75
	 yliJzEIYUrTkewYsbklJvq/nii/jDsTp3Ajk4pckF/gdUd1UTYdK3pby5elH8D56DA
	 Hqu+VZIBeHJBtB5GRFYdu6Lem838W12ctPai3hb+DENqCRLTvRIljRKdrvnd3F4BEk
	 h4BsvwlhsrI6A==
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5c673b01eeeso1949248a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Dec 2023 16:10:32 -0800 (PST)
X-Gm-Message-State: AOJu0YwBHEAIusIkMsUuzeGI7u6gChtuhw4RcgHAcaqtbbLgDeZexl7E
	7TRlrIY9kN4bf/L6Yu2gPG44PBigtAHH3k77kj11aA==
X-Google-Smtp-Source: AGHT+IEOne40Evpc3pHozYdt1o5NJalTwoiUabENcdd5/f9vwgF+QpkXlVhyG1sJl4gvFfryCpnjhmoQ3bUEvh1xYEM=
X-Received: by 2002:a05:6a20:7484:b0:18b:8bf4:6b4a with SMTP id
 p4-20020a056a20748400b0018b8bf46b4amr34495pzd.0.1701821431106; Tue, 05 Dec
 2023 16:10:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130194023.4102148-1-nphamcs@gmail.com> <20231130194023.4102148-4-nphamcs@gmail.com>
In-Reply-To: <20231130194023.4102148-4-nphamcs@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 5 Dec 2023 16:10:19 -0800
X-Gmail-Original-Message-ID: <CAF8kJuP3ka=bPqqcTttFBYqkX1dxVUBBg599wtxk8J7CsH1wsw@mail.gmail.com>
Message-ID: <CAF8kJuP3ka=bPqqcTttFBYqkX1dxVUBBg599wtxk8J7CsH1wsw@mail.gmail.com>
Subject: Re: [PATCH v8 3/6] zswap: make shrinking memcg-aware
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, cerasuolodomenico@gmail.com, 
	yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org, 
	vitaly.wool@konsulko.com, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeelb@google.com, muchun.song@linux.dev, linux-mm@kvack.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nhat,

Still working my way up of your patches series.

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

I think this skip_if_exists is problematic here. You might need to
redesign this.
First of all, the skip_if_exists as the argument name, the meaning to
the caller is not clear. When I saw this, I was wondering, what does
the function return when this condition is triggered? Unlike
"*new_page_allocated", which is a state after the function is
returned. "skip_if_exists" is referring to an internal execution flow.
It does not tell what value the function should return if that
condition is triggered. It will force the caller to look into the
internal of the function __read_swap_cache_async() to reason "should I
pass true or false when I call this function". I wish it had better
abstracted names. Or maybe a function argument documentation block to
explain the usage of this argument.


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

This is very tricky, for the caller that did set "skip_if_exists" to
true. Because the return value is still under race condition.
The following comments describe two race situations, which get cut off
by the patch context. Let me paste it again here:

+               /*
                 * We might race against __delete_from_swap_cache(), and
                 * stumble across a swap_map entry whose SWAP_HAS_CACHE
                 * has not yet been cleared.  Or race against another
                 * __read_swap_cache_async(), which has set SWAP_HAS_CACHE
                 * in swap_map, but not yet added its page to swap cache.
                 */
                schedule_timeout_uninterruptible(1);
        }

Basically, it has two kinds of race conditions. First is the race to
delete the swap cache entry. The second one is to add the swap cache
entry. Your added comment block for  "if (skip_if_exists)" only
describes the first kind of race. That begs the question, what if the
race is the second case, how does the caller handle that?

Let me paste the caller here:

       page =3D __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
-                               NO_INTERLEAVE_INDEX, &page_was_allocated);
+                               NO_INTERLEAVE_INDEX, &page_was_allocated, t=
rue);
        if (!page) {
                ret =3D -ENOMEM;
                goto fail;
        }

The caller will return -ENOMEM if the second race condition (adding to
the swap cache) was triggered. It will return ENOMEM while the page is
being added to the swap cache. That feels incorrect to me. Am I
missing anything?

A control flow modification to the racing path is very tricky. Need
more eyes for review.

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

This removes the memcg from pool->next_shrink if the first pool
next_shrink matches.
Please help me understand why only the first next_shrink, what if the
memcg matches on the follow up next_shrink entries?
What am I missing here?

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

I do see a pattern here where you want to use long and descriptive
local variable names. It is in other patches as well. Therefore, I
want to make a point here.
According to the Linux coding style document.
https://www.kernel.org/doc/html/latest/process/coding-style.html

LOCAL variable names should be short, and to the point. If you have
some random integer loop counter, it should probably be called i.
Calling it loop_counter is non-productive, if there is no chance of it
being mis-understood. Similarly, tmp can be just about any type of
variable that is used to hold a temporary value.

I see you have a different return value for LRU status now so you want
to use ret for that. Just the "writeback_result" is a bit long as a
local variable.

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
If the zswap_rb_search() encounters the invalide race.
Goto unlock will return LRU_REMOVED_RETRY.
Can you help me understand how the list_lru_walk_one() interacts with
the invalid race here?
I am very scared of changing the handle of race conditions, we need
more eyeballs to review it.

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

Does this mean the writeback failed for whatever reason, the order of
the entry in the LRU changed? Seems a bit odd, the application did not
request this page, this access is purely internal behavior of zswap
write back. It should not impact how likely applications are going to
use this page.

> +               ret =3D LRU_RETRY;
>                 goto put_unlock;
>         }
> +       zswap_written_back_pages++;

Why do you move the "zswap_written_back_pages" counter here rather
than in the zswap_writeback_entry() which is closer to the original
code?
It seems to me that the write back result already determines which
counter to update, so this counter update and
"zswap_reject_reclaim_fail++;" should move into
zswap_writeback_entry().

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

What about the other pools that are not the current, do they shrink
somehow as well?

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

Wouldn't it be useful to know how much actual pages get writeback here
as indicator of how useful it is to shrink it?

One idea is that we can use some kind of shrink control struct and
pass it down here. The shrink count can be a member of the shrink
control struct.
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

If we have the shrink control struct, it can be easier to move to more
fancy control of how the shrink performs to each memcg. We will likely
move away from the round robin once we move to the MGLRU world of
shrinking zswap entries. Maybe for a later patch.

>         do {
> -               ret =3D zswap_reclaim_entry(pool);
> -               if (ret) {
> -                       zswap_reject_reclaim_fail++;
> -                       if (ret !=3D -EAGAIN)
> +               spin_lock(&zswap_pools_lock);
> +               pool->next_shrink =3D mem_cgroup_iter(NULL, pool->next_sh=
rink, NULL);
> +               memcg =3D pool->next_shrink;

I am still a bit fuzzy about the data structure on the
pool->next_shrink.  Is this store the current memcg that is iterating
on? After each walk of the memcg, next_shrink is pointed to the next
memcg in the list. After all the memcg is consumed,  when does
next_shrink point back to the beginning of the list?

Chris

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
>

