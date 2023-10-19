Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F1E7CF8ED
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Oct 2023 14:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345556AbjJSMaW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Oct 2023 08:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235452AbjJSMaB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Oct 2023 08:30:01 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610EE1BB;
        Thu, 19 Oct 2023 05:29:52 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-27d23f1e3b8so6043208a91.1;
        Thu, 19 Oct 2023 05:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697718592; x=1698323392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1MQg2rRnkvwQSeTM3MsyK7EykEtBpF3vPmkdyJD/m7I=;
        b=gV0g87OiZUXOrCpbIwudwt7B4UFXzOnQsxf5pVT/m63S+oUnfJYFRbuxSs1nshfrv0
         jiw5fTjEG/JHJzN44omkFs3emWU7UGMnwUHb+2sfO6wFXh9WHlPe57/3tC9PLsTgxCbH
         AaPDNELsRZoL/ehW27MQS62pVSqqL0KWzyybcpSCzEpKMvXfeDrBejr5z5lFZytA6VTY
         zoNEZM2OdVPYd2o/03yCWmxRXNVj3vCSfWjkv/9EoS4myhLhUqOCUTXgKVelMKkPbzpz
         I4mvyKRSFR7FaFVmzrmk4hFfP/qqXQXl09h04swdIRQ5dFIY40AOaR4BRR0ZtUDo47sh
         ZXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697718592; x=1698323392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1MQg2rRnkvwQSeTM3MsyK7EykEtBpF3vPmkdyJD/m7I=;
        b=tplr2R9XToAWMzABrQmswK+o8owegE5yKtbS0fooOq2CmiNSt0MzziCLjbXJAH141w
         WKHf0w2u+835FLmN4dMrcu2rPtUSDF91oGFj4S6Lprvv+OfsMWV7BXTmaIBOJWY+Ic3L
         sSGItcyKKEmbOAqiv81k1rgULQEH+4z5lvVpxpoGYR5dwKKqvc5TPm6Bl+xG9KEm7AN0
         rQg/Yfq4biBe+KAW87bA27DUlwg7TPLIX995zmcZi41CZHOCQCvEZhZ/NrzzJ3lZO+lF
         Ei1A3tKyQvfGPB63OWSiiT+e1kIiLMdZb9AkoWS2wUa3T7FlO7TCzflGefCHVKXdV+nF
         fFtw==
X-Gm-Message-State: AOJu0YwB0eVEHsXlar57GXS6gOfdqSzgG5PHPMGiK12oBwKeokR0ioKL
        YpIOvZAfhhD4iuvq/zM+w4Tlyiu8BYRm/ElYBaU=
X-Google-Smtp-Source: AGHT+IFtvKYsf4G9KSZZgn+7pXR2ORHk7JyVeKYkowyjw6StgWH8DP7n/fY2soTYzpun13LnLiKWadtv6D1vUHa/vTs=
X-Received: by 2002:a17:90b:4b49:b0:27d:8d0:713e with SMTP id
 mi9-20020a17090b4b4900b0027d08d0713emr2057374pjb.10.1697718591438; Thu, 19
 Oct 2023 05:29:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231017232152.2605440-1-nphamcs@gmail.com> <20231017232152.2605440-3-nphamcs@gmail.com>
 <CAJD7tka2aVKBJj6cYutcVzOGzj_6gop6-ytSmWWML=sEe9qHbA@mail.gmail.com>
In-Reply-To: <CAJD7tka2aVKBJj6cYutcVzOGzj_6gop6-ytSmWWML=sEe9qHbA@mail.gmail.com>
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Date:   Thu, 19 Oct 2023 14:29:40 +0200
Message-ID: <CA+CLi1jiyY3oueWrLtd5JOrtP-aYQ90sPgSCBoWtB2jVL_-FxA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] zswap: make shrinking memcg-aware
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 19, 2023 at 1:20=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Tue, Oct 17, 2023 at 4:21=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wro=
te:
> >
> > From: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> >
> > Currently, we only have a single global LRU for zswap. This makes it
> > impossible to perform worload-specific shrinking - an memcg cannot
> > determine which pages in the pool it owns, and often ends up writing
> > pages from other memcgs. This issue has been previously observed in
> > practice and mitigated by simply disabling memcg-initiated shrinking:
> >
> > https://lore.kernel.org/all/20230530232435.3097106-1-nphamcs@gmail.com/=
T/#u
> >
> > This patch fully resolves the issue by replacing the global zswap LRU
> > with memcg- and NUMA-specific LRUs, and modify the reclaim logic:
> >
> > a) When a store attempt hits an memcg limit, it now triggers a
> >    synchronous reclaim attempt that, if successful, allows the new
> >    hotter page to be accepted by zswap.
> > b) If the store attempt instead hits the global zswap limit, it will
> >    trigger an asynchronous reclaim attempt, in which an memcg is
> >    selected for reclaim in a round-robin-like fashion.
>
> Could you explain the rationale behind the difference in behavior here
> between the global limit and the memcg limit?
>
> >
> > Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> > Co-developed-by: Nhat Pham <nphamcs@gmail.com>
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > ---
> >  include/linux/memcontrol.h |   5 ++
> >  mm/swap.h                  |   3 +-
> >  mm/swap_state.c            |  17 +++-
> >  mm/zswap.c                 | 179 ++++++++++++++++++++++++++-----------
> >  4 files changed, 147 insertions(+), 57 deletions(-)
>
> This is a dense patch, I haven't absorbed all of it yet, but the first
> round of comments below.
>
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 031102ac9311..3de10fabea0f 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -1179,6 +1179,11 @@ static inline struct mem_cgroup *page_memcg_chec=
k(struct page *page)
> >         return NULL;
> >  }
> >
> > +static inline struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_=
cgroup *objcg)
> > +{
> > +       return NULL;
> > +}
> > +
> >  static inline bool folio_memcg_kmem(struct folio *folio)
> >  {
> >         return false;
> > diff --git a/mm/swap.h b/mm/swap.h
> > index 8a3c7a0ace4f..bbd6ce661a20 100644
> > --- a/mm/swap.h
> > +++ b/mm/swap.h
> > @@ -50,7 +50,8 @@ struct page *read_swap_cache_async(swp_entry_t entry,=
 gfp_t gfp_mask,
> >  struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask=
,
> >                                      struct vm_area_struct *vma,
> >                                      unsigned long addr,
> > -                                    bool *new_page_allocated);
> > +                                    bool *new_page_allocated,
> > +                                    bool fail_if_exists);
> >  struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
> >                                     struct vm_fault *vmf);
> >  struct page *swapin_readahead(swp_entry_t entry, gfp_t flag,
> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > index b3b14bd0dd64..0356df52b06a 100644
> > --- a/mm/swap_state.c
> > +++ b/mm/swap_state.c
> > @@ -411,7 +411,7 @@ struct folio *filemap_get_incore_folio(struct addre=
ss_space *mapping,
> >
> >  struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask=
,
> >                         struct vm_area_struct *vma, unsigned long addr,
> > -                       bool *new_page_allocated)
> > +                       bool *new_page_allocated, bool fail_if_exists)
>
> nit: I don't feel like "fail" is the correct word here. Perhaps "skip"?

I really don't have a preference, we can go with "skip".

>
> >  {
> >         struct swap_info_struct *si;
> >         struct folio *folio;
> > @@ -468,6 +468,15 @@ struct page *__read_swap_cache_async(swp_entry_t e=
ntry, gfp_t gfp_mask,
> >                 if (err !=3D -EEXIST)
> >                         goto fail_put_swap;
> >
> > +               /*
> > +                * This check guards against a state that happens if a =
call
> > +                * to __read_swap_cache_async triggers a reclaim, if th=
e
> > +                * reclaimer (zswap's writeback as of now) then decides=
 to
> > +                * reclaim that same entry, then the subsequent call to
> > +                * __read_swap_cache_async would get stuck in this loop=
.
>
> I think this comment needs to first state that it is protecting
> against a recursive call in general, not necessarily in reclaim, as
> __read_swap_cache_async() is not usually called in the context of
> reclaim so this can be confusing. Then it can give the exact example
> we have today. Perhaps something like:
>
> Protect against a recursive call to __read_swap_cache_async() on the
> same entry waiting forever here because SWAP_HAS_CACHE is set but the
> folio is not the swap cache yet. This can happen today if
> mem_cgroup_swapin_charge_folio() below triggers reclaim through zswap,
> which may call __read_swap_cache_async() in the writeback path.
>

Sold.

> > +                */
> > +               if (fail_if_exists && err =3D=3D -EEXIST)
>
> We already made sure  in the preceding condition that err is -EEXIST.
>
> > +                       goto fail_put_swap;
> >                 /*
> >                  * We might race against __delete_from_swap_cache(), an=
d
> >                  * stumble across a swap_map entry whose SWAP_HAS_CACHE
> > @@ -530,7 +539,7 @@ struct page *read_swap_cache_async(swp_entry_t entr=
y, gfp_t gfp_mask,
> >  {
> >         bool page_was_allocated;
> >         struct page *retpage =3D __read_swap_cache_async(entry, gfp_mas=
k,
> > -                       vma, addr, &page_was_allocated);
> > +                       vma, addr, &page_was_allocated, false);
> >
> >         if (page_was_allocated)
> >                 swap_readpage(retpage, false, plug);
> > @@ -649,7 +658,7 @@ struct page *swap_cluster_readahead(swp_entry_t ent=
ry, gfp_t gfp_mask,
> >                 /* Ok, do the async read-ahead now */
> >                 page =3D __read_swap_cache_async(
> >                         swp_entry(swp_type(entry), offset),
> > -                       gfp_mask, vma, addr, &page_allocated);
> > +                       gfp_mask, vma, addr, &page_allocated, false);
> >                 if (!page)
> >                         continue;
> >                 if (page_allocated) {
> > @@ -815,7 +824,7 @@ static struct page *swap_vma_readahead(swp_entry_t =
fentry, gfp_t gfp_mask,
> >                 pte_unmap(pte);
> >                 pte =3D NULL;
> >                 page =3D __read_swap_cache_async(entry, gfp_mask, vma,
> > -                                              addr, &page_allocated);
> > +                                              addr, &page_allocated, f=
alse);
> >                 if (!page)
> >                         continue;
> >                 if (page_allocated) {
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 083c693602b8..d2989ad11814 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -34,6 +34,7 @@
> >  #include <linux/writeback.h>
> >  #include <linux/pagemap.h>
> >  #include <linux/workqueue.h>
> > +#include <linux/list_lru.h>
> >
> >  #include "swap.h"
> >  #include "internal.h"
> > @@ -171,8 +172,8 @@ struct zswap_pool {
> >         struct work_struct shrink_work;
> >         struct hlist_node node;
> >         char tfm_name[CRYPTO_MAX_ALG_NAME];
> > -       struct list_head lru;
> > -       spinlock_t lru_lock;
> > +       struct list_lru list_lru;
> > +       struct mem_cgroup *next_shrink;
> >  };
> >
> >  /*
> > @@ -288,15 +289,25 @@ static void zswap_update_total_size(void)
> >         zswap_pool_total_size =3D total;
> >  }
> >
> > +static inline struct mem_cgroup *get_mem_cgroup_from_entry(struct zswa=
p_entry *entry)
> > +{
> > +       return entry->objcg ? get_mem_cgroup_from_objcg(entry->objcg) :=
 NULL;
> > +}
> > +
> > +static inline int entry_to_nid(struct zswap_entry *entry)
> > +{
> > +       return page_to_nid(virt_to_page(entry));
> > +}
> > +
> >  /*********************************
> >  * zswap entry functions
> >  **********************************/
> >  static struct kmem_cache *zswap_entry_cache;
> >
> > -static struct zswap_entry *zswap_entry_cache_alloc(gfp_t gfp)
> > +static struct zswap_entry *zswap_entry_cache_alloc(gfp_t gfp, int nid)
> >  {
> >         struct zswap_entry *entry;
> > -       entry =3D kmem_cache_alloc(zswap_entry_cache, gfp);
> > +       entry =3D kmem_cache_alloc_node(zswap_entry_cache, gfp, nid);
> >         if (!entry)
> >                 return NULL;
> >         entry->refcount =3D 1;
> > @@ -309,6 +320,27 @@ static void zswap_entry_cache_free(struct zswap_en=
try *entry)
> >         kmem_cache_free(zswap_entry_cache, entry);
> >  }
> >
> > +/*********************************
> > +* lru functions
> > +**********************************/
> > +static bool zswap_lru_add(struct list_lru *list_lru, struct zswap_entr=
y *entry)
> > +{
> > +       struct mem_cgroup *memcg =3D get_mem_cgroup_from_entry(entry);
>
> Could we avoid the need for get/put with an rcu_read_lock() instead?

I think we can, I'm not entirely sure of the consequences though. By the
look of it I'd say it's safe but I wouldn't trust my judgement on this.

>
> > +       bool added =3D __list_lru_add(list_lru, &entry->lru, entry_to_n=
id(entry), memcg);
> > +
> > +       mem_cgroup_put(memcg);
> > +       return added;
> > +}
> > +
> > +static bool zswap_lru_del(struct list_lru *list_lru, struct zswap_entr=
y *entry)
> > +{
> > +       struct mem_cgroup *memcg =3D get_mem_cgroup_from_entry(entry);
> > +       bool removed =3D __list_lru_del(list_lru, &entry->lru, entry_to=
_nid(entry), memcg);
> > +
> > +       mem_cgroup_put(memcg);
> > +       return removed;
> > +}
> > +
> >  /*********************************
> >  * rbtree functions
> >  **********************************/
> > @@ -393,9 +425,7 @@ static void zswap_free_entry(struct zswap_entry *en=
try)
> >         if (!entry->length)
> >                 atomic_dec(&zswap_same_filled_pages);
> >         else {
> > -               spin_lock(&entry->pool->lru_lock);
> > -               list_del(&entry->lru);
> > -               spin_unlock(&entry->pool->lru_lock);
> > +               zswap_lru_del(&entry->pool->list_lru, entry);
> >                 zpool_free(zswap_find_zpool(entry), entry->handle);
> >                 zswap_pool_put(entry->pool);
> >         }
> > @@ -629,21 +659,16 @@ static void zswap_invalidate_entry(struct zswap_t=
ree *tree,
> >                 zswap_entry_put(tree, entry);
> >  }
> >
> > -static int zswap_reclaim_entry(struct zswap_pool *pool)
> > +static enum lru_status shrink_memcg_cb(struct list_head *item, struct =
list_lru_one *l,
> > +                                      spinlock_t *lock, void *arg)
> >  {
> > -       struct zswap_entry *entry;
> > +       struct zswap_entry *entry =3D container_of(item, struct zswap_e=
ntry, lru);
> > +       struct mem_cgroup *memcg;
> >         struct zswap_tree *tree;
> >         pgoff_t swpoffset;
> > -       int ret;
> > +       enum lru_status ret =3D LRU_REMOVED_RETRY;
> > +       int writeback_result;
> >
> > -       /* Get an entry off the LRU */
> > -       spin_lock(&pool->lru_lock);
> > -       if (list_empty(&pool->lru)) {
> > -               spin_unlock(&pool->lru_lock);
> > -               return -EINVAL;
> > -       }
> > -       entry =3D list_last_entry(&pool->lru, struct zswap_entry, lru);
> > -       list_del_init(&entry->lru);
> >         /*
> >          * Once the lru lock is dropped, the entry might get freed. The
> >          * swpoffset is copied to the stack, and entry isn't deref'd ag=
ain
> > @@ -651,28 +676,33 @@ static int zswap_reclaim_entry(struct zswap_pool =
*pool)
> >          */
> >         swpoffset =3D swp_offset(entry->swpentry);
> >         tree =3D zswap_trees[swp_type(entry->swpentry)];
> > -       spin_unlock(&pool->lru_lock);
> > +       list_lru_isolate(l, item);
> > +       spin_unlock(lock);
>
> Perhaps a comment somewhere stating that we only return either
> LRU_REMOVED_RETRY or LRU_RETRY, so it's fine to drop and reacquire the
> lock.
>
> >
> >         /* Check for invalidate() race */
> >         spin_lock(&tree->lock);
> >         if (entry !=3D zswap_rb_search(&tree->rbroot, swpoffset)) {
> > -               ret =3D -EAGAIN;
> >                 goto unlock;
> >         }
>
> nit: braces no longer needed?
>
> >         /* Hold a reference to prevent a free during writeback */
> >         zswap_entry_get(entry);
> >         spin_unlock(&tree->lock);
> >
> > -       ret =3D zswap_writeback_entry(entry, tree);
> > +       writeback_result =3D zswap_writeback_entry(entry, tree);
> >
> >         spin_lock(&tree->lock);
> > -       if (ret) {
> > -               /* Writeback failed, put entry back on LRU */
> > -               spin_lock(&pool->lru_lock);
> > -               list_move(&entry->lru, &pool->lru);
> > -               spin_unlock(&pool->lru_lock);
> > +       if (writeback_result) {
> > +               zswap_reject_reclaim_fail++;
> > +               memcg =3D get_mem_cgroup_from_entry(entry);
> > +               spin_lock(lock);
> > +               /* we cannot use zswap_lru_add here, because it increme=
nts node's lru count */
> > +               list_lru_putback(&entry->pool->list_lru, item, entry_to=
_nid(entry), memcg);
> > +               spin_unlock(lock);
> > +               mem_cgroup_put(memcg);
> > +               ret =3D LRU_RETRY;
> >                 goto put_unlock;
> >         }
> > +       zswap_written_back_pages++;
>
> Why is this moved here from zswap_writeback_entry()? Also why is
> zswap_reject_reclaim_fail incremented here instead of inside
> zswap_writeback_entry()?
>
> >
> >         /*
> >          * Writeback started successfully, the page now belongs to the
> > @@ -686,7 +716,36 @@ static int zswap_reclaim_entry(struct zswap_pool *=
pool)
> >         zswap_entry_put(tree, entry);
> >  unlock:
> >         spin_unlock(&tree->lock);
> > -       return ret ? -EAGAIN : 0;
> > +       spin_lock(lock);
> > +       return ret;
> > +}
> > +
> > +static int shrink_memcg(struct mem_cgroup *memcg)
> > +{
> > +       struct zswap_pool *pool;
> > +       int nid, shrunk =3D 0;
> > +
> > +       pool =3D zswap_pool_current_get();
> > +       if (!pool)
> > +               return -EINVAL;
> > +
> > +       /*
> > +        * Skip zombies because their LRUs are reparented and we would =
be
> > +        * reclaiming from the parent instead of the dead memcgroup.
>
> nit: s/memcgroup/memcg.
>
> > +        */
> > +       if (memcg && !mem_cgroup_online(memcg))
> > +               goto out;
>
> If we move this above zswap_pool_current_get(), we can return directly
> and remove the label. I noticed we will return -EAGAIN if memcg is
> offline. IIUC -EAGAIN for the caller will move on to the next memcg,
> but I am wondering if a different errno would be clearer here.

True, I remember spending some time staring at error codes but couldn't fin=
d a
better one. What if we use -EINVAL for retryable errors, and use something =
else
for the one where there is no pool? -ENODEV?

>
> > +
> > +       for_each_node_state(nid, N_NORMAL_MEMORY) {
> > +               unsigned long nr_to_walk =3D 1;
> > +
> > +               if (list_lru_walk_one(&pool->list_lru, nid, memcg, &shr=
ink_memcg_cb,
> > +                                     NULL, &nr_to_walk))
> > +                       shrunk++;
>
> nit:
> shrunk +=3D list_lru_walk_one(..);
>
> > +       }
> > +out:
> > +       zswap_pool_put(pool);
> > +       return shrunk ? 0 : -EAGAIN;
> >  }
> >
> >  static void shrink_worker(struct work_struct *w)
> > @@ -695,10 +754,13 @@ static void shrink_worker(struct work_struct *w)
> >                                                 shrink_work);
> >         int ret, failures =3D 0;
> >
> > +       /* global reclaim will select cgroup in a round-robin fashion. =
*/
> >         do {
> > -               ret =3D zswap_reclaim_entry(pool);
> > +               pool->next_shrink =3D mem_cgroup_iter(NULL, pool->next_=
shrink, NULL);
>
> Perhaps next_shrink_memcg is a better name here?

Will change if you have a strong preference, I'd keep it shorter because it=
's
always used in conjunction with a memcg type or function.

>
> > +
> > +               ret =3D shrink_memcg(pool->next_shrink);
> > +
> >                 if (ret) {
> > -                       zswap_reject_reclaim_fail++;
> >                         if (ret !=3D -EAGAIN)
> >                                 break;
> >                         if (++failures =3D=3D MAX_RECLAIM_RETRIES)
> > @@ -764,8 +826,7 @@ static struct zswap_pool *zswap_pool_create(char *t=
ype, char *compressor)
> >          */
> >         kref_init(&pool->kref);
> >         INIT_LIST_HEAD(&pool->list);
> > -       INIT_LIST_HEAD(&pool->lru);
> > -       spin_lock_init(&pool->lru_lock);
> > +       list_lru_init_memcg(&pool->list_lru, NULL);
> >         INIT_WORK(&pool->shrink_work, shrink_worker);
> >
> >         zswap_pool_debug("created", pool);
> > @@ -831,6 +892,9 @@ static void zswap_pool_destroy(struct zswap_pool *p=
ool)
> >
> >         cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &pool->=
node);
> >         free_percpu(pool->acomp_ctx);
> > +       list_lru_destroy(&pool->list_lru);
> > +       if (pool->next_shrink)
> > +               mem_cgroup_put(pool->next_shrink);
> >         for (i =3D 0; i < ZSWAP_NR_ZPOOLS; i++)
> >                 zpool_destroy_pool(pool->zpools[i]);
> >         kfree(pool);
> > @@ -1076,7 +1140,7 @@ static int zswap_writeback_entry(struct zswap_ent=
ry *entry,
> >
> >         /* try to allocate swap cache page */
> >         page =3D __read_swap_cache_async(swpentry, GFP_KERNEL, NULL, 0,
> > -                                      &page_was_allocated);
> > +                                      &page_was_allocated, true);
> >         if (!page) {
> >                 ret =3D -ENOMEM;
> >                 goto fail;
> > @@ -1142,7 +1206,6 @@ static int zswap_writeback_entry(struct zswap_ent=
ry *entry,
> >         /* start writeback */
> >         __swap_writepage(page, &wbc);
> >         put_page(page);
> > -       zswap_written_back_pages++;
> >
> >         return ret;
> >
> > @@ -1199,8 +1262,10 @@ bool zswap_store(struct folio *folio)
> >         struct scatterlist input, output;
> >         struct crypto_acomp_ctx *acomp_ctx;
> >         struct obj_cgroup *objcg =3D NULL;
> > +       struct mem_cgroup *memcg =3D NULL;
> >         struct zswap_pool *pool;
> >         struct zpool *zpool;
> > +       int lru_alloc_ret;
> >         unsigned int dlen =3D PAGE_SIZE;
> >         unsigned long handle, value;
> >         char *buf;
> > @@ -1230,15 +1295,15 @@ bool zswap_store(struct folio *folio)
> >                 zswap_invalidate_entry(tree, dupentry);
> >         }
> >         spin_unlock(&tree->lock);
> > -
> > -       /*
> > -        * XXX: zswap reclaim does not work with cgroups yet. Without a
> > -        * cgroup-aware entry LRU, we will push out entries system-wide=
 based on
> > -        * local cgroup limits.
> > -        */
> >         objcg =3D get_obj_cgroup_from_folio(folio);
> > -       if (objcg && !obj_cgroup_may_zswap(objcg))
> > -               goto reject;
> > +       if (objcg && !obj_cgroup_may_zswap(objcg)) {
> > +               memcg =3D get_mem_cgroup_from_objcg(objcg);
> > +               if (shrink_memcg(memcg)) {
> > +                       mem_cgroup_put(memcg);
> > +                       goto reject;
> > +               }
> > +               mem_cgroup_put(memcg);
> > +       }
> >
> >         /* reclaim space if needed */
> >         if (zswap_is_full()) {
> > @@ -1254,10 +1319,15 @@ bool zswap_store(struct folio *folio)
> >                         zswap_pool_reached_full =3D false;
> >         }
> >
> > +       pool =3D zswap_pool_current_get();
> > +       if (!pool)
> > +               goto reject;
> > +
>
> Why do we need to move zswap_pool_current_get() up here?

Ah, thanks. This is a leftover from a previous version where the pool was n=
eeded
to allocate the entry.


>
> >         /* allocate entry */
> > -       entry =3D zswap_entry_cache_alloc(GFP_KERNEL);
> > +       entry =3D zswap_entry_cache_alloc(GFP_KERNEL, page_to_nid(page)=
);
> >         if (!entry) {
> >                 zswap_reject_kmemcache_fail++;
> > +               zswap_pool_put(pool);
> >                 goto reject;
> >         }
> >
> > @@ -1269,6 +1339,7 @@ bool zswap_store(struct folio *folio)
> >                         entry->length =3D 0;
> >                         entry->value =3D value;
> >                         atomic_inc(&zswap_same_filled_pages);
> > +                       zswap_pool_put(pool);
> >                         goto insert_entry;
> >                 }
> >                 kunmap_atomic(src);
> > @@ -1278,9 +1349,15 @@ bool zswap_store(struct folio *folio)
> >                 goto freepage;
> >
> >         /* if entry is successfully added, it keeps the reference */
> > -       entry->pool =3D zswap_pool_current_get();
> > -       if (!entry->pool)
> > -               goto freepage;
> > +       entry->pool =3D pool;
> > +       if (objcg) {
> > +               memcg =3D get_mem_cgroup_from_objcg(objcg);
> > +               lru_alloc_ret =3D memcg_list_lru_alloc(memcg, &pool->li=
st_lru, GFP_KERNEL);
> > +               mem_cgroup_put(memcg);
> > +
> > +               if (lru_alloc_ret)
> > +                       goto freepage;
> > +       }
> >
> >         /* compress */
> >         acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> > @@ -1358,9 +1435,8 @@ bool zswap_store(struct folio *folio)
> >                 zswap_invalidate_entry(tree, dupentry);
> >         }
> >         if (entry->length) {
> > -               spin_lock(&entry->pool->lru_lock);
> > -               list_add(&entry->lru, &entry->pool->lru);
> > -               spin_unlock(&entry->pool->lru_lock);
> > +               INIT_LIST_HEAD(&entry->lru);
> > +               zswap_lru_add(&pool->list_lru, entry);
> >         }
> >         spin_unlock(&tree->lock);
> >
> > @@ -1373,8 +1449,8 @@ bool zswap_store(struct folio *folio)
> >
> >  put_dstmem:
> >         mutex_unlock(acomp_ctx->mutex);
> > -       zswap_pool_put(entry->pool);
> >  freepage:
> > +       zswap_pool_put(entry->pool);
> >         zswap_entry_cache_free(entry);
> >  reject:
> >         if (objcg)
> > @@ -1467,9 +1543,8 @@ bool zswap_load(struct folio *folio)
> >                 zswap_invalidate_entry(tree, entry);
> >                 folio_mark_dirty(folio);
> >         } else if (entry->length) {
> > -               spin_lock(&entry->pool->lru_lock);
> > -               list_move(&entry->lru, &entry->pool->lru);
> > -               spin_unlock(&entry->pool->lru_lock);
> > +               zswap_lru_del(&entry->pool->list_lru, entry);
> > +               zswap_lru_add(&entry->pool->list_lru, entry);
> >         }
> >         zswap_entry_put(tree, entry);
> >         spin_unlock(&tree->lock);
> > --
> > 2.34.1
