Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3707DA22D
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 23:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbjJ0VKb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 17:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJ0VKa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 17:10:30 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E188D6;
        Fri, 27 Oct 2023 14:10:25 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7a67f447bf0so80623439f.2;
        Fri, 27 Oct 2023 14:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698441024; x=1699045824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kr7Z0nfvKnJC5bVkgxEh7/bxFKjMABbImlMsPEW2ERY=;
        b=H3M2PEFqq4Ba6jvLPNXqMsXPPAjhWe+nr41FKWe2lYTvG75kVqB1QgL4RV2dD6e6U/
         xPhxd/ovRB5jTxk3gsKMG5J+xU9Q5Rd9uEIcTHEprUn7SR5m7yvbtfXQxL04cv/V1ueE
         Yts0NYnE1/Sd71JJtuBaB+Rx45Ks73rAhzlp09Cp0jYmS7cWYOs6CnDnpezPJp8KLfV9
         jmgGRAg0slVwkBlAKUlsoFwuwMoDWxPA6g4ps3FVNo+kZIfGuyEWU47IGcg6JXidMsIb
         g2bn8U+pLZCvKFR8bV+6j51qKBmg733GHmIRQ7v459ErY8Y6EGDRlrLntwBXGwZb18LA
         9lqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698441024; x=1699045824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kr7Z0nfvKnJC5bVkgxEh7/bxFKjMABbImlMsPEW2ERY=;
        b=j3JK2hmNSjdzlRG5hK9q1i0mjlGPZgOO0j/Vfag7flz/ZuoaeqXeFRQrjgTPSi85WW
         IpjjocfyvROjrT2c4MYF/uvk1JFCq5hCaXEipFF7Bycr9h7h4NI8qiJqkaJN35GqSvgz
         z2Mx0xjEi5MOhhTZm/oeUyi1HAp1NT9dRG6OEFr7bFMA7rNN6gg+nTJ+ZBnF+49LVKTs
         o30A4y0zVCiOgfseNYEtJD36d5t6mAOaePFRsmWQ4bU0NA9MWXeZmhNNCOAgW983VHbX
         /W93IU4B8G9hBhRWNioH4XLs3PbwXHAJBHb/BeZpuaHwSWDe/Acptq02j1NEpRLk129p
         jb/w==
X-Gm-Message-State: AOJu0YwOyaFt+Qm3tMBk7YHGBYI1JHZbJx0vDdeuwfGr1puRzXsLSNvi
        NDp3MOyzGGpsL7tdx1oKJChZXPS3Zl6kjsHobWM=
X-Google-Smtp-Source: AGHT+IEqF3RntPo36zIPjo2QkVeM550bO6KTQW6lCVg6AHiT5Y2+nCTuwu84YVsHAgxmNc1FFqhM9XQuFsIf++shKKg=
X-Received: by 2002:a05:6602:2ad6:b0:795:183b:1e3 with SMTP id
 m22-20020a0566022ad600b00795183b01e3mr4809258iov.6.1698441024382; Fri, 27 Oct
 2023 14:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231024203302.1920362-1-nphamcs@gmail.com> <20231024203302.1920362-3-nphamcs@gmail.com>
 <CAJD7tkZM4aOAwc4nRiU1PHofxHeZmV-NNGP5-E7X88ivRC7Pgw@mail.gmail.com>
In-Reply-To: <CAJD7tkZM4aOAwc4nRiU1PHofxHeZmV-NNGP5-E7X88ivRC7Pgw@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Fri, 27 Oct 2023 14:10:13 -0700
Message-ID: <CAKEwX=Nr7xJYpL2nE_ob0dWg9rnfoz67OMe_wvGsKjxboo1H+A@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] zswap: make shrinking memcg-aware
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
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

On Tue, Oct 24, 2023 at 8:17=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Tue, Oct 24, 2023 at 1:33=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wro=
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
> >
> > Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> > Co-developed-by: Nhat Pham <nphamcs@gmail.com>
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > ---
> >  include/linux/memcontrol.h |   5 +
> >  mm/swap.h                  |   3 +-
> >  mm/swap_state.c            |  23 +++--
> >  mm/zswap.c                 | 188 ++++++++++++++++++++++++++-----------
> >  4 files changed, 156 insertions(+), 63 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 6edd3ec4d8d5..c1846e57011b 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -1187,6 +1187,11 @@ static inline struct mem_cgroup *page_memcg_chec=
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
> > index 73c332ee4d91..c0dc73e10e91 100644
> > --- a/mm/swap.h
> > +++ b/mm/swap.h
> > @@ -51,7 +51,8 @@ struct page *read_swap_cache_async(swp_entry_t entry,=
 gfp_t gfp_mask,
> >                                    struct swap_iocb **plug);
> >  struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask=
,
> >                                      struct mempolicy *mpol, pgoff_t il=
x,
> > -                                    bool *new_page_allocated);
> > +                                    bool *new_page_allocated,
> > +                                    bool skip_if_exists);
> >  struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
> >                                     struct mempolicy *mpol, pgoff_t ilx=
);
> >  struct page *swapin_readahead(swp_entry_t entry, gfp_t flag,
> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > index 85d9e5806a6a..040639e1c77e 100644
> > --- a/mm/swap_state.c
> > +++ b/mm/swap_state.c
> > @@ -412,7 +412,8 @@ struct folio *filemap_get_incore_folio(struct addre=
ss_space *mapping,
> >
> >  struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask=
,
> >                                      struct mempolicy *mpol, pgoff_t il=
x,
> > -                                    bool *new_page_allocated)
> > +                                    bool *new_page_allocated,
> > +                                    bool skip_if_exists)
> >  {
> >         struct swap_info_struct *si;
> >         struct folio *folio;
> > @@ -470,6 +471,16 @@ struct page *__read_swap_cache_async(swp_entry_t e=
ntry, gfp_t gfp_mask,
> >                 if (err !=3D -EEXIST)
> >                         goto fail_put_swap;
> >
> > +               /* Protect against a recursive call to __read_swap_cach=
e_async()
>
> nit: insert new line before "Protect", see surrounding comments.
>
> > +                * on the same entry waiting forever here because SWAP_=
HAS_CACHE
> > +                * is set but the folio is not the swap cache yet. This=
 can
> > +                * happen today if mem_cgroup_swapin_charge_folio() bel=
ow
> > +                * triggers reclaim through zswap, which may call
> > +                * __read_swap_cache_async() in the writeback path.
> > +                */
> > +               if (skip_if_exists)
> > +                       goto fail_put_swap;
> > +
> >                 /*
> >                  * We might race against __delete_from_swap_cache(), an=
d
> >                  * stumble across a swap_map entry whose SWAP_HAS_CACHE
> [..]
> > +/*********************************
> > +* lru functions
> > +**********************************/
> > +static bool zswap_lru_add(struct list_lru *list_lru, struct zswap_entr=
y *entry)
> > +{
> > +       struct mem_cgroup *memcg =3D get_mem_cgroup_from_entry(entry);
> > +       int nid =3D entry_to_nid(entry);
> > +       bool added =3D list_lru_add(list_lru, &entry->lru, nid, memcg);
> > +
> > +       mem_cgroup_put(memcg);
>
> Still not fond of the get/put pattern but okay..

Actually, Johannes and I took another look to see if we can replace
the memcg reference getting with just rcu_read_lock().

It seems there might be a race between zswap LRU manipulation
and memcg offlining - not just with the rcu_read_lock() idea, but also
with our current implementation!

I'll shoot another email with more details later when I'm sure of it
one way or another...

>
> > +       return added;
> > +}
> > +
> > +static bool zswap_lru_del(struct list_lru *list_lru, struct zswap_entr=
y *entry)
> > +{
> > +       struct mem_cgroup *memcg =3D get_mem_cgroup_from_entry(entry);
> > +       int nid =3D entry_to_nid(entry);
> > +       bool removed =3D list_lru_del(list_lru, &entry->lru, nid, memcg=
);
> > +
> > +       mem_cgroup_put(memcg);
> > +       return removed;
> > +}
> > +
> >  /*********************************
> >  * rbtree functions
> >  **********************************/
> [..]
> > @@ -652,28 +679,37 @@ static int zswap_reclaim_entry(struct zswap_pool =
*pool)
> >          */
> >         swpoffset =3D swp_offset(entry->swpentry);
> >         tree =3D zswap_trees[swp_type(entry->swpentry)];
> > -       spin_unlock(&pool->lru_lock);
> > +       list_lru_isolate(l, item);
> > +       /*
> > +        * It's safe to drop the lock here because we return either
> > +        * LRU_REMOVED_RETRY or LRU_RETRY.
> > +        */
> > +       spin_unlock(lock);
> >
> >         /* Check for invalidate() race */
> >         spin_lock(&tree->lock);
> > -       if (entry !=3D zswap_rb_search(&tree->rbroot, swpoffset)) {
> > -               ret =3D -EAGAIN;
> > +       if (entry !=3D zswap_rb_search(&tree->rbroot, swpoffset))
> >                 goto unlock;
> > -       }
> > +
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
>
> Can this return NULL? Seems like we don't check the return in most/all pl=
aces.

I believe so, but memcg experts should fact check me on this.
It's roughly the same pattern as zswap charging/uncharging:

obj_cgroup_uncharge_zswap(entry->objcg, entry->length)
-> getting memcg (under rcu_read_lock())

>
> > +               spin_lock(lock);
> > +               /* we cannot use zswap_lru_add here, because it increme=
nts node's lru count */
> > +               list_lru_putback(&entry->pool->list_lru, item, entry_to=
_nid(entry), memcg);
>
> Perhaps we can move this call with the memcg get/put to a helper like
> add/del? (e.g. zswap_lru_putback)
>
> We would need to move get_mem_cgroup_from_entry() into the lock but I
> think that's okay.

We probably could, but that sounds like extra code for not a lot of gains, =
no?

>
> > +               spin_unlock(lock);
> > +               mem_cgroup_put(memcg);
> > +               ret =3D LRU_RETRY;
> >                 goto put_unlock;
> >         }
> > +       zswap_written_back_pages++;
> >
> >         /*
> >          * Writeback started successfully, the page now belongs to the
> > @@ -687,7 +723,34 @@ static int zswap_reclaim_entry(struct zswap_pool *=
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
> > +       /*
> > +        * Skip zombies because their LRUs are reparented and we would =
be
> > +        * reclaiming from the parent instead of the dead memcg.
> > +        */
> > +       if (memcg && !mem_cgroup_online(memcg))
> > +               return -ENOENT;
> > +
> > +       pool =3D zswap_pool_current_get();
> > +       if (!pool)
> > +               return -EINVAL;
> > +
> > +       for_each_node_state(nid, N_NORMAL_MEMORY) {
> > +               unsigned long nr_to_walk =3D 1;
> > +
> > +               shrunk +=3D list_lru_walk_one(&pool->list_lru, nid, mem=
cg,
> > +                                           &shrink_memcg_cb, NULL, &nr=
_to_walk);
> > +       }
> > +       zswap_pool_put(pool);
> > +       return shrunk ? 0 : -EAGAIN;
> >  }
> >
> >  static void shrink_worker(struct work_struct *w)
> > @@ -696,15 +759,17 @@ static void shrink_worker(struct work_struct *w)
> >                                                 shrink_work);
> >         int ret, failures =3D 0;
> >
> > +       /* global reclaim will select cgroup in a round-robin fashion. =
*/
> >         do {
> > -               ret =3D zswap_reclaim_entry(pool);
> > -               if (ret) {
> > -                       zswap_reject_reclaim_fail++;
> > -                       if (ret !=3D -EAGAIN)
> > -                               break;
> > -                       if (++failures =3D=3D MAX_RECLAIM_RETRIES)
> > -                               break;
> > -               }
> > +               pool->next_shrink =3D mem_cgroup_iter(NULL, pool->next_=
shrink, NULL);
>
> I think this can be a problem. We hold a ref to a memcg here until the
> next time we shrink, which can be a long time IIUC. This can cause the
> memcg to linger as a zombie. I understand it is one memcg per-zswap
> pool, but I am still unsure about it.
>
> MGLRU maintains a memcg LRU for global reclaim that gets properly
> cleaned up when a memcg is going away, so that's one option, although
> complicated.
>
> A second option would be to hold a pointer to the objcg instead, which
> should be less problematic (although we are still holding that objcg
> hostage indefinitely). The problem here is that if the objcg gets
> reparented, next time we will start at the parent of the memcg we
> stopped at last time, which tbh doesn't sound bad at all to me.
>
> A third option would be to flag the memcg such that when it is getting
> offlined we can call into zswap to reset pool->next_shrink (or move it
> to the parent) and drop the ref. Although synchronization can get
> hairy when racing with offlining.
>
> Not sure what's the right solution, but I prefer we don't hold any
> memcgs hostages indefinitely. I also think if we end up using
> mem_cgroup_iter() then there should be a mem_cgroup_iter_break()
> somewhere if/when breaking the iteration.
>

I'm not sure if this is that big of a problem in the first place, but
if it is, doing something similar to MGLRU is probably the cleanest:
when the memcg is freed, trigger the zswap_exit_memcg() callback,
which will loop through all the zswap pools and update pool->next_shrink
where appropriate.

Note that we only have one pool per (compression algorithm x allocator)
combinations, so there cannot be that many pools, correct?

Johannes suggests this idea to me (my apologies if I butcher it)
during one of our conversations. That sounds relatively easy IIUC.

> > +
> > +               ret =3D shrink_memcg(pool->next_shrink);
> > +
> > +               if (ret =3D=3D -EINVAL)
> > +                       break;
> > +               if (ret && ++failures =3D=3D MAX_RECLAIM_RETRIES)
> > +                       break;
> > +
> >                 cond_resched();
> >         } while (!zswap_can_accept());
> >         zswap_pool_put(pool);
> [..]
> > @@ -1233,15 +1301,15 @@ bool zswap_store(struct folio *folio)
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
>
> Here we choose to replicate mem_cgroup_put().
>
> > +       }
> >
> >         /* reclaim space if needed */
> >         if (zswap_is_full()) {
> > @@ -1258,7 +1326,7 @@ bool zswap_store(struct folio *folio)
> >         }
> >
> >         /* allocate entry */
> > -       entry =3D zswap_entry_cache_alloc(GFP_KERNEL);
> > +       entry =3D zswap_entry_cache_alloc(GFP_KERNEL, page_to_nid(page)=
);
> >         if (!entry) {
> >                 zswap_reject_kmemcache_fail++;
> >                 goto reject;
> > @@ -1285,6 +1353,15 @@ bool zswap_store(struct folio *folio)
> >         if (!entry->pool)
> >                 goto freepage;
> >
> > +       if (objcg) {
> > +               memcg =3D get_mem_cgroup_from_objcg(objcg);
> > +               lru_alloc_ret =3D memcg_list_lru_alloc(memcg, &entry->p=
ool->list_lru, GFP_KERNEL);
> > +               mem_cgroup_put(memcg);
> > +
> > +               if (lru_alloc_ret)
> > +                       goto put_pool;
> > +       }
>
> Yet here we choose to have a single mem_cgroup_put() and stash the
> output in a variable.
>
> Consistency would be nice.

No strong opinions here, but yeah we should fix it to make it
consistent.

>
> > +
> >         /* compress */
> >         acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> >
> > @@ -1361,9 +1438,8 @@ bool zswap_store(struct folio *folio)
> >                 zswap_invalidate_entry(tree, dupentry);
> >         }
> >         if (entry->length) {
> > -               spin_lock(&entry->pool->lru_lock);
> > -               list_add(&entry->lru, &entry->pool->lru);
> > -               spin_unlock(&entry->pool->lru_lock);
> > +               INIT_LIST_HEAD(&entry->lru);
> > +               zswap_lru_add(&entry->pool->list_lru, entry);
> >         }
> >         spin_unlock(&tree->lock);
> >
> > @@ -1376,6 +1452,7 @@ bool zswap_store(struct folio *folio)
> >
> >  put_dstmem:
> >         mutex_unlock(acomp_ctx->mutex);
> > +put_pool:
> >         zswap_pool_put(entry->pool);
> >  freepage:
> >         zswap_entry_cache_free(entry);
> > @@ -1470,9 +1547,8 @@ bool zswap_load(struct folio *folio)
> >                 zswap_invalidate_entry(tree, entry);
> >                 folio_mark_dirty(folio);
> >         } else if (entry->length) {
> > -               spin_lock(&entry->pool->lru_lock);
> > -               list_move(&entry->lru, &entry->pool->lru);
> > -               spin_unlock(&entry->pool->lru_lock);
> > +               zswap_lru_del(&entry->pool->list_lru, entry);
> > +               zswap_lru_add(&entry->pool->list_lru, entry);
>
> Can we use list_move_tail() here? (perhaps wrapped in a helper if needed)=
.

Maybe zswap_lru_move_tail()? :)

FWIW, list_lru() interface does not have a move_tail function, (weird, I kn=
ow).
So this seems to be the common pattern for LRU rotation with list_lru.

>
> >         }
> >         zswap_entry_put(tree, entry);
> >         spin_unlock(&tree->lock);
> > --
> > 2.34.1
