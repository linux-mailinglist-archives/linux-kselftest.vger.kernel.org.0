Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23F87CEC2C
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Oct 2023 01:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjJRXhE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Oct 2023 19:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbjJRXhD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Oct 2023 19:37:03 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEC010F
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Oct 2023 16:36:55 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c50305c5c4so92864481fa.1
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Oct 2023 16:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697672214; x=1698277014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCdl45S9H4AQ11Fqx2wEkM1GDi7rPuQpziLq8fsjyNc=;
        b=KiRFaTOtr8E1S/j4KcRKVIL2VrloESOnDhprEzDXbwhhxoagQWGGrMN045uoQjhSoM
         3GsbunfqeMjtbdI409jQLlCv/26BT81/eb3G+gu7A3v/t5P+n9fGwu42r1DzADJREJNd
         PWGsamil0pcB6d7rgNFbgQmUYn0/uOm5p1D7dO6ixRdxj/XmsDz8gzfhd86tfMdKPVG2
         hoXnHgwYHtAMfNOW8qBiCQzRbwaue/bG5gaO4Y3X9Czj8N/9r1I2BBfoVQDMnr/OtauG
         wAYejcQRQXdqoYgSMYJSkuuKPA9WoJXjSGE91Jq87jCin6D9lmyxkdWUFwjdikSZo7um
         vwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697672214; x=1698277014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YCdl45S9H4AQ11Fqx2wEkM1GDi7rPuQpziLq8fsjyNc=;
        b=Nlc0W81qe7P0ri+nsfRDWED9t0vgYxqsLOE3IYX7OYdaJH2d+ToBYSXNKDS/TciGw/
         5Siw1+gTeZIEjfcbCyXU0h1c35vpcX+czCu5QU9xnQgxzZoqOuoFrgCvuWduagkRX7W7
         5CjG/RFN2q6qOLNR4P9YpnNdSz7noqUoaMShaFt2HyGTyAYs683CUQX99icsypaqhhNo
         DeTxbS7oUK0RvLjf1rheCmsuY3k8pALfsCDYc/D9B7PORAqG2pQ6oMAYmVf7HTn+z1q1
         aqO1L/WKAonRDqNz8NlCM/rZ3X5s7o+2J1fkzVyGWw0vkf+ka13bwa5kb7ozQEHatzxm
         dkSQ==
X-Gm-Message-State: AOJu0YwGx4QK2ebV7w5DUZa2zaFS2egiLQtGX5r5DuBWuF/FVDwRdXDa
        SmV5IbjnrV4VNd912AKmRCjtpXrBFpthUYfMKHdrsg==
X-Google-Smtp-Source: AGHT+IFlJ+1B73Stb6fLW/mqLVnZ/n2J7UGsbpKwbMxpwuuJlYHQ0r9e7bipb85/MDK48IK9E+xGtvOcSRfh/jH1LM0=
X-Received: by 2002:a2e:908a:0:b0:2c5:1b01:b67f with SMTP id
 l10-20020a2e908a000000b002c51b01b67fmr239336ljg.52.1697672213609; Wed, 18 Oct
 2023 16:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231017232152.2605440-1-nphamcs@gmail.com> <20231017232152.2605440-6-nphamcs@gmail.com>
In-Reply-To: <20231017232152.2605440-6-nphamcs@gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 18 Oct 2023 16:36:14 -0700
Message-ID: <CAJD7tkZ-jjKpDBbTfR7AyhOsSwE8rMD4474oLe2fqm+iC1=szw@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] zswap: shrinks zswap pool based on memory pressure
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 17, 2023 at 4:21=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
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

I really hope someone with more familiarity with reclaim heuristics
makes sure this makes sense.

>
> As a proof of concept, we ran the following synthetic benchmark:
> build the linux kernel in a memory-limited cgroup, and allocate some
> cold data in tmpfs to see if the shrinker could write them out and
> improved the overall performance. Depending on the amount of cold data
> generated, we observe from 14% to 35% reduction in kernel CPU time used
> in the kernel builds.
>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  Documentation/admin-guide/mm/zswap.rst |   7 ++
>  include/linux/mmzone.h                 |  14 +++
>  mm/mmzone.c                            |   3 +
>  mm/swap_state.c                        |  21 +++-
>  mm/zswap.c                             | 161 +++++++++++++++++++++++--
>  5 files changed, 196 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation/admin=
-guide/mm/zswap.rst
> index 45b98390e938..522ae22ccb84 100644
> --- a/Documentation/admin-guide/mm/zswap.rst
> +++ b/Documentation/admin-guide/mm/zswap.rst
> @@ -153,6 +153,13 @@ attribute, e. g.::
>
>  Setting this parameter to 100 will disable the hysteresis.
>
> +When there is a sizable amount of cold memory residing in the zswap pool=
, it
> +can be advantageous to proactively write these cold pages to swap and re=
claim
> +the memory for other use cases. By default, the zswap shrinker is disabl=
ed.
> +User can enable it as follows:
> +
> +  echo Y > /sys/module/zswap/parameters/shrinker_enabled
> +
>  A debugfs interface is provided for various statistic about pool size, n=
umber
>  of pages stored, same-value filled pages and various counters for the re=
asons
>  pages are rejected.
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 486587fcd27f..8947a1bfbe9c 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -637,6 +637,20 @@ struct lruvec {
>  #ifdef CONFIG_MEMCG
>         struct pglist_data *pgdat;
>  #endif
> +#ifdef CONFIG_ZSWAP
> +       /*
> +        * Number of pages in zswap that should be protected from the shr=
inker.
> +        * This number is an estimate of the following counts:
> +        *
> +        * a) Recent page faults.
> +        * b) Recent insertion to the zswap LRU. This includes new zswap =
stores,
> +        *    as well as recent zswap LRU rotations.
> +        *
> +        * These pages are likely to be warm, and might incur IO if the a=
re written
> +        * to swap.
> +        */
> +       atomic_long_t nr_zswap_protected;
> +#endif

Instead of the ifdef's all over the code, we can define
nr_zswap_protected inside a struct and helpers that
increment/initialize nr_zswap_protected in zswap.h, and have a single
ifdef there. All the code would be oblivious to the existence of
nr_zswap_protected.

Something like:

#ifdef CONFIG_ZSWAP

struct zswap_lruvec_state {
         /* insert large comment */
        atomic_long_t nr_zswap_protected;
};

static inline void zswap_lruvec_init(..)
{
        atomic_long_set(&lruvec->nr_zswap_protected, 0);
}

static inline void zswap_lruvec_swapin(..)
{
       if (page) {
               struct lruvec *lruvec =3D folio_lruvec(page_folio(page));

               atomic_long_inc(&lruvec->nr_zswap_protected);
       }
}

#else

/* empty struct and functions

#endif

>  };
>
>  /* Isolate for asynchronous migration */
> diff --git a/mm/mmzone.c b/mm/mmzone.c
> index 68e1511be12d..4137f3ac42cd 100644
> --- a/mm/mmzone.c
> +++ b/mm/mmzone.c
> @@ -78,6 +78,9 @@ void lruvec_init(struct lruvec *lruvec)
>
>         memset(lruvec, 0, sizeof(struct lruvec));
>         spin_lock_init(&lruvec->lru_lock);
> +#ifdef CONFIG_ZSWAP
> +       atomic_long_set(&lruvec->nr_zswap_protected, 0);
> +#endif
>
>         for_each_lru(lru)
>                 INIT_LIST_HEAD(&lruvec->lists[lru]);
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 0356df52b06a..a60197b55a28 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -676,7 +676,15 @@ struct page *swap_cluster_readahead(swp_entry_t entr=
y, gfp_t gfp_mask,
>         lru_add_drain();        /* Push any new pages onto the LRU now */
>  skip:
>         /* The page was likely read above, so no need for plugging here *=
/
> -       return read_swap_cache_async(entry, gfp_mask, vma, addr, NULL);
> +       page =3D read_swap_cache_async(entry, gfp_mask, vma, addr, NULL);
> +#ifdef CONFIG_ZSWAP
> +       if (page) {
> +               struct lruvec *lruvec =3D folio_lruvec(page_folio(page));
> +
> +               atomic_long_inc(&lruvec->nr_zswap_protected);
> +       }
> +#endif
> +       return page;
>  }
>
>  int init_swap_address_space(unsigned int type, unsigned long nr_pages)
> @@ -843,8 +851,15 @@ static struct page *swap_vma_readahead(swp_entry_t f=
entry, gfp_t gfp_mask,
>         lru_add_drain();
>  skip:
>         /* The page was likely read above, so no need for plugging here *=
/
> -       return read_swap_cache_async(fentry, gfp_mask, vma, vmf->address,
> -                                    NULL);
> +       page =3D read_swap_cache_async(fentry, gfp_mask, vma, vmf->addres=
s, NULL);
> +#ifdef CONFIG_ZSWAP
> +       if (page) {
> +               struct lruvec *lruvec =3D folio_lruvec(page_folio(page));
> +
> +               atomic_long_inc(&lruvec->nr_zswap_protected);
> +       }
> +#endif
> +       return page;
>  }
>
>  /**
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 15485427e3fa..1d1fe75a5237 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -145,6 +145,10 @@ module_param_named(exclusive_loads, zswap_exclusive_=
loads_enabled, bool, 0644);
>  /* Number of zpools in zswap_pool (empirically determined for scalabilit=
y) */
>  #define ZSWAP_NR_ZPOOLS 32
>
> +/* Enable/disable memory pressure-based shrinker. */
> +static bool zswap_shrinker_enabled;
> +module_param_named(shrinker_enabled, zswap_shrinker_enabled, bool, 0644)=
;
> +
>  /*********************************
>  * data structures
>  **********************************/
> @@ -174,6 +178,8 @@ struct zswap_pool {
>         char tfm_name[CRYPTO_MAX_ALG_NAME];
>         struct list_lru list_lru;
>         struct mem_cgroup *next_shrink;
> +       struct shrinker *shrinker;
> +       atomic_t nr_stored;
>  };
>
>  /*
> @@ -272,17 +278,26 @@ static bool zswap_can_accept(void)
>                         DIV_ROUND_UP(zswap_pool_total_size, PAGE_SIZE);
>  }
>
> +static u64 get_zswap_pool_size(struct zswap_pool *pool)
> +{
> +       u64 pool_size =3D 0;
> +       int i;
> +
> +       for (i =3D 0; i < ZSWAP_NR_ZPOOLS; i++)
> +               pool_size +=3D zpool_get_total_size(pool->zpools[i]);
> +
> +       return pool_size;
> +}
> +
>  static void zswap_update_total_size(void)
>  {
>         struct zswap_pool *pool;
>         u64 total =3D 0;
> -       int i;
>
>         rcu_read_lock();
>
>         list_for_each_entry_rcu(pool, &zswap_pools, list)
> -               for (i =3D 0; i < ZSWAP_NR_ZPOOLS; i++)
> -                       total +=3D zpool_get_total_size(pool->zpools[i]);
> +               total +=3D get_zswap_pool_size(pool);
>
>         rcu_read_unlock();
>
> @@ -326,8 +341,24 @@ static void zswap_entry_cache_free(struct zswap_entr=
y *entry)
>  static bool zswap_lru_add(struct list_lru *list_lru, struct zswap_entry =
*entry)
>  {
>         struct mem_cgroup *memcg =3D get_mem_cgroup_from_entry(entry);
> -       bool added =3D __list_lru_add(list_lru, &entry->lru, entry_to_nid=
(entry), memcg);
> -
> +       int nid =3D entry_to_nid(entry);
> +       struct lruvec *lruvec =3D mem_cgroup_lruvec(memcg, NODE_DATA(nid)=
);
> +       bool added =3D __list_lru_add(list_lru, &entry->lru, nid, memcg);
> +       unsigned long lru_size, old, new;
> +
> +       if (added) {
> +               lru_size =3D list_lru_count_one(list_lru, entry_to_nid(en=
try), memcg);
> +               old =3D atomic_long_inc_return(&lruvec->nr_zswap_protecte=
d);
> +
> +               /*
> +                * Decay to avoid overflow and adapt to changing workload=
s.
> +                * This is based on LRU reclaim cost decaying heuristics.
> +                */
> +               do {
> +                       new =3D old > lru_size / 4 ? old / 2 : old;
> +               } while (
> +                       !atomic_long_try_cmpxchg(&lruvec->nr_zswap_protec=
ted, &old, new));
> +       }
>         mem_cgroup_put(memcg);
>         return added;
>  }
> @@ -427,6 +458,7 @@ static void zswap_free_entry(struct zswap_entry *entr=
y)
>         else {
>                 zswap_lru_del(&entry->pool->list_lru, entry);
>                 zpool_free(zswap_find_zpool(entry), entry->handle);
> +               atomic_dec(&entry->pool->nr_stored);
>                 zswap_pool_put(entry->pool);
>         }
>         zswap_entry_cache_free(entry);
> @@ -468,6 +500,93 @@ static struct zswap_entry *zswap_entry_find_get(stru=
ct rb_root *root,
>         return entry;
>  }
>
> +/*********************************
> +* shrinker functions
> +**********************************/
> +static enum lru_status shrink_memcg_cb(struct list_head *item, struct li=
st_lru_one *l,
> +                                      spinlock_t *lock, void *arg);
> +
> +static unsigned long zswap_shrinker_scan(struct shrinker *shrinker,
> +               struct shrink_control *sc)
> +{
> +       struct lruvec *lruvec =3D mem_cgroup_lruvec(sc->memcg, NODE_DATA(=
sc->nid));
> +       unsigned long shrink_ret, nr_protected, lru_size;
> +       struct zswap_pool *pool =3D shrinker->private_data;
> +       bool encountered_page_in_swapcache =3D false;
> +
> +       nr_protected =3D atomic_long_read(&lruvec->nr_zswap_protected);
> +       lru_size =3D list_lru_shrink_count(&pool->list_lru, sc);
> +
> +       /*
> +        * Abort if the shrinker is disabled or if we are shrinking into =
the
> +        * protected region.
> +        */
> +       if (!zswap_shrinker_enabled || nr_protected >=3D lru_size - sc->n=
r_to_scan) {
> +               sc->nr_scanned =3D 0;
> +               return SHRINK_STOP;
> +       }
> +
> +       shrink_ret =3D list_lru_shrink_walk(&pool->list_lru, sc, &shrink_=
memcg_cb,
> +               &encountered_page_in_swapcache);
> +
> +       if (encountered_page_in_swapcache)
> +               return SHRINK_STOP;
> +
> +       return shrink_ret ? shrink_ret : SHRINK_STOP;
> +}
> +
> +static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
> +               struct shrink_control *sc)
> +{
> +       struct zswap_pool *pool =3D shrinker->private_data;
> +       struct mem_cgroup *memcg =3D sc->memcg;
> +       struct lruvec *lruvec =3D mem_cgroup_lruvec(memcg, NODE_DATA(sc->=
nid));
> +       unsigned long nr_backing, nr_stored, nr_freeable, nr_protected;
> +
> +#ifdef CONFIG_MEMCG_KMEM
> +       cgroup_rstat_flush(memcg->css.cgroup);
> +       nr_backing =3D memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PAGE_SHI=
FT;
> +       nr_stored =3D memcg_page_state(memcg, MEMCG_ZSWAPPED);
> +#else
> +       /* use pool stats instead of memcg stats */
> +       nr_backing =3D get_zswap_pool_size(pool) >> PAGE_SHIFT;
> +       nr_stored =3D atomic_read(&pool->nr_stored);
> +#endif
> +
> +       if (!zswap_shrinker_enabled || !nr_stored)
> +               return 0;
> +
> +       nr_protected =3D atomic_long_read(&lruvec->nr_zswap_protected);
> +       nr_freeable =3D list_lru_shrink_count(&pool->list_lru, sc);
> +       /*
> +        * Subtract the lru size by an estimate of the number of pages
> +        * that should be protected.
> +        */
> +       nr_freeable =3D nr_freeable > nr_protected ? nr_freeable - nr_pro=
tected : 0;
> +
> +       /*
> +        * Scale the number of freeable pages by the memory saving factor=
.
> +        * This ensures that the better zswap compresses memory, the fewe=
r
> +        * pages we will evict to swap (as it will otherwise incur IO for
> +        * relatively small memory saving).
> +        */
> +       return mult_frac(nr_freeable, nr_backing, nr_stored);
> +}
> +
> +static void zswap_alloc_shrinker(struct zswap_pool *pool)
> +{
> +       pool->shrinker =3D
> +               shrinker_alloc(SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE=
, "mm-zswap");
> +       if (!pool->shrinker)
> +               return;
> +
> +       pool->shrinker->private_data =3D pool;
> +       pool->shrinker->scan_objects =3D zswap_shrinker_scan;
> +       pool->shrinker->count_objects =3D zswap_shrinker_count;
> +       pool->shrinker->batch =3D 0;
> +       pool->shrinker->seeks =3D DEFAULT_SEEKS;
> +}
> +
>  /*********************************
>  * per-cpu code
>  **********************************/
> @@ -663,8 +782,10 @@ static enum lru_status shrink_memcg_cb(struct list_h=
ead *item, struct list_lru_o
>                                        spinlock_t *lock, void *arg)
>  {
>         struct zswap_entry *entry =3D container_of(item, struct zswap_ent=
ry, lru);
> +       bool *encountered_page_in_swapcache =3D (bool *)arg;
>         struct mem_cgroup *memcg;
>         struct zswap_tree *tree;
> +       struct lruvec *lruvec;
>         pgoff_t swpoffset;
>         enum lru_status ret =3D LRU_REMOVED_RETRY;
>         int writeback_result;
> @@ -698,8 +819,22 @@ static enum lru_status shrink_memcg_cb(struct list_h=
ead *item, struct list_lru_o
>                 /* we cannot use zswap_lru_add here, because it increment=
s node's lru count */
>                 list_lru_putback(&entry->pool->list_lru, item, entry_to_n=
id(entry), memcg);
>                 spin_unlock(lock);
> -               mem_cgroup_put(memcg);
>                 ret =3D LRU_RETRY;
> +
> +               /*
> +                * Encountering a page already in swap cache is a sign th=
at we are shrinking
> +                * into the warmer region. We should terminate shrinking =
(if we're in the dynamic
> +                * shrinker context).
> +                */
> +               if (writeback_result =3D=3D -EEXIST && encountered_page_i=
n_swapcache) {
> +                       ret =3D LRU_SKIP;
> +                       *encountered_page_in_swapcache =3D true;
> +               }
> +               lruvec =3D mem_cgroup_lruvec(memcg, NODE_DATA(entry_to_ni=
d(entry)));
> +               /* Increment the protection area to account for the LRU r=
otation. */
> +               atomic_long_inc(&lruvec->nr_zswap_protected);
> +
> +               mem_cgroup_put(memcg);
>                 goto put_unlock;
>         }
>         zswap_written_back_pages++;
> @@ -822,6 +957,11 @@ static struct zswap_pool *zswap_pool_create(char *ty=
pe, char *compressor)
>                                        &pool->node);
>         if (ret)
>                 goto error;
> +
> +       zswap_alloc_shrinker(pool);
> +       if (!pool->shrinker)
> +               goto error;
> +
>         pr_debug("using %s compressor\n", pool->tfm_name);
>
>         /* being the current pool takes 1 ref; this func expects the
> @@ -829,13 +969,18 @@ static struct zswap_pool *zswap_pool_create(char *t=
ype, char *compressor)
>          */
>         kref_init(&pool->kref);
>         INIT_LIST_HEAD(&pool->list);
> -       list_lru_init_memcg(&pool->list_lru, NULL);
> +       if (list_lru_init_memcg(&pool->list_lru, pool->shrinker))
> +               goto lru_fail;
> +       shrinker_register(pool->shrinker);
>         INIT_WORK(&pool->shrink_work, shrink_worker);
>
>         zswap_pool_debug("created", pool);
>
>         return pool;
>
> +lru_fail:
> +       list_lru_destroy(&pool->list_lru);
> +       shrinker_free(pool->shrinker);
>  error:
>         if (pool->acomp_ctx)
>                 free_percpu(pool->acomp_ctx);
> @@ -893,6 +1038,7 @@ static void zswap_pool_destroy(struct zswap_pool *po=
ol)
>
>         zswap_pool_debug("destroying", pool);
>
> +       shrinker_free(pool->shrinker);
>         cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &pool->no=
de);
>         free_percpu(pool->acomp_ctx);
>         list_lru_destroy(&pool->list_lru);
> @@ -1440,6 +1586,7 @@ bool zswap_store(struct folio *folio)
>         if (entry->length) {
>                 INIT_LIST_HEAD(&entry->lru);
>                 zswap_lru_add(&pool->list_lru, entry);
> +               atomic_inc(&pool->nr_stored);
>         }
>         spin_unlock(&tree->lock);
>
> --
> 2.34.1
