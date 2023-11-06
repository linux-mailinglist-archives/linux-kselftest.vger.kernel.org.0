Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410477E2E70
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Nov 2023 21:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjKFUy6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Nov 2023 15:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjKFUy6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Nov 2023 15:54:58 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C63D51;
        Mon,  6 Nov 2023 12:54:55 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-35743e88193so19527215ab.3;
        Mon, 06 Nov 2023 12:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699304094; x=1699908894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jx+XsNfbDvildu3tlQOtshcOutyN9/FTZV/cIEDMrB0=;
        b=XjCOiiXRy+KwRa11/w6FhYVnT99N8YylcgF9cUTABS20AkqsQCi+ZjixKiAjxindk6
         8sNYDFcq1miocxt7EobbO90yIMBL/zWb60q/mlgrIzRtBaZf8kBdWpvvTaRy0JACJeJ6
         H00D5utNt9VkVnN436KLR7nT3C4bhOHDss+KN19hxcHP4gGCrZtSif/gmjl8P7CAGVAz
         iz1JWiu9Py2nX7a0kfMLfi17Dsbrraca1rRKPY7SjrqHJNi0mbNjpMhUC4V2mXENHQW7
         tqrULltt30TdzZUXS6mAnoBS3J2RoTQpgBEbKel2O2aXRVPZL4fSHm21t6u3VnpGU6dQ
         P4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699304094; x=1699908894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jx+XsNfbDvildu3tlQOtshcOutyN9/FTZV/cIEDMrB0=;
        b=Zfv5VgTSFER7Ht1zeOtILMWW37mH7ot/QL7MGR4OIKp3cJyPTUHOM18YyEkc7xGf0r
         RxAKuBJYil9LKDJK7wTCtZdhZKX+Jvf9PM1NMlhe6g6H3CoJ8DVxuS01mJDiXw2BIpiO
         eC/E07bKUpz3KUdSFF0h+Uj6K1GFRnetEaWiEqvjpKQRI3sxu9recDjQkYcF+pyh4i17
         /73iJ/aEKZ3n/5zy12suECwAvSFlbVa1fbgR5dN74H/2/mUCJMmWxkudwBPWfhh+tnW5
         hfq87piVC8Wdk1JZu0nZpNlKl83Nm07F+ewTATobFzWN8sAC8uFtnpO4RgRVQbH+Jzjq
         Cuhw==
X-Gm-Message-State: AOJu0YyHX9Gtx8gcd5vDk7DcMA0ehr/2ZrIomXfalbgrvLB6JdEXokjD
        T10oQvXGunjQnscfVjfwkSVAnwyuz1gg7Pf8IYs=
X-Google-Smtp-Source: AGHT+IEt1hDAAg6F23R7Tytq9GfojxV53jHCLY6KgmORMAUO1yr0EbCFtXJNTBdqSeSC90HrzCBWncwJc9awHvdnIbI=
X-Received: by 2002:a05:6e02:1a84:b0:357:a049:91c4 with SMTP id
 k4-20020a056e021a8400b00357a04991c4mr944340ilv.22.1699304094438; Mon, 06 Nov
 2023 12:54:54 -0800 (PST)
MIME-Version: 1.0
References: <20231106183159.3562879-1-nphamcs@gmail.com> <20231106183159.3562879-4-nphamcs@gmail.com>
 <CAJD7tkYcEc03d+6kwkXu8M_fd9ZDzh6B5G+VjmFXx+H09mhfmg@mail.gmail.com>
In-Reply-To: <CAJD7tkYcEc03d+6kwkXu8M_fd9ZDzh6B5G+VjmFXx+H09mhfmg@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Mon, 6 Nov 2023 12:54:43 -0800
Message-ID: <CAKEwX=PU3z7CseAZHE6v-q_yKQn0PtZqtfsfyKy5KOJpnNiE9Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] zswap: make shrinking memcg-aware
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 6, 2023 at 12:26=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Mon, Nov 6, 2023 at 10:32=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wro=
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
> >  include/linux/zswap.h      |   2 +
> >  mm/memcontrol.c            |   2 +
> >  mm/swap.h                  |   3 +-
> >  mm/swap_state.c            |  24 +++-
> >  mm/zswap.c                 | 252 +++++++++++++++++++++++++++++--------
> >  6 files changed, 227 insertions(+), 61 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 55c85f952afd..95f6c9e60ed1 100644
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
> > diff --git a/include/linux/zswap.h b/include/linux/zswap.h
> > index 2a60ce39cfde..e571e393669b 100644
> > --- a/include/linux/zswap.h
> > +++ b/include/linux/zswap.h
> > @@ -15,6 +15,7 @@ bool zswap_load(struct folio *folio);
> >  void zswap_invalidate(int type, pgoff_t offset);
> >  void zswap_swapon(int type);
> >  void zswap_swapoff(int type);
> > +void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg);
> >
> >  #else
> >
> > @@ -31,6 +32,7 @@ static inline bool zswap_load(struct folio *folio)
> >  static inline void zswap_invalidate(int type, pgoff_t offset) {}
> >  static inline void zswap_swapon(int type) {}
> >  static inline void zswap_swapoff(int type) {}
> > +static inline void zswap_memcg_offline_cleanup(struct mem_cgroup *memc=
g) {}
> >
> >  #endif
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 6f7fc0101252..2ef49b471a16 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -5640,6 +5640,8 @@ static void mem_cgroup_css_offline(struct cgroup_=
subsys_state *css)
> >         page_counter_set_min(&memcg->memory, 0);
> >         page_counter_set_low(&memcg->memory, 0);
> >
> > +       zswap_memcg_offline_cleanup(memcg);
>
> I think the "_cleanup" suffix is unnecessary. I guess most calls made
> here are cleanup calls anyway.

I don't have any strong preference here.

>
> > +
> >         memcg_offline_kmem(memcg);
> >         reparent_shrinker_deferred(memcg);
> >         wb_memcg_offline(memcg);
> > diff --git a/mm/swap.h b/mm/swap.h
> > index 73c332ee4d91..c0dc73e10e91 100644
> > --- a/mm/swap.h
> > +++ b/mm/swap.h
>
> > @@ -289,15 +291,42 @@ static void zswap_update_total_size(void)
> >         zswap_pool_total_size =3D total;
> >  }
> >
> > +/* should be called under RCU */
> > +static inline struct mem_cgroup *get_mem_cgroup_from_entry(struct zswa=
p_entry *entry)
>
> Do not use "get" in the name if we are not actually taking a ref here.
> mem_cgroup_from_entry()?

That works for me.

>
> > +{
> > +       return entry->objcg ? obj_cgroup_memcg(entry->objcg) : NULL;
> > +}
> > +
> > +static inline int entry_to_nid(struct zswap_entry *entry)
> > +{
> > +       return page_to_nid(virt_to_page(entry));
> > +}
> > +
> > +void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
> > +{
> > +       struct zswap_pool *pool;
> > +
> > +       /* lock out zswap pools list modification */
> > +       spin_lock(&zswap_pools_lock);
> > +       list_for_each_entry(pool, &zswap_pools, list) {
> > +               spin_lock(&pool->next_shrink_lock);
>
> This lock is only needed to synchronize updating pool->next_shrink,
> right? Can we just use atomic operations instead? (e.g. cmpxchg()).

I'm not entirely sure. I think in the pool destroy path, we have to also
put the next_shrink memcg, so there's that.

>
> > +               if (pool->next_shrink =3D=3D memcg)
> > +                       pool->next_shrink =3D
> > +                               mem_cgroup_iter(NULL, pool->next_shrink=
, NULL, true);
> > +               spin_unlock(&pool->next_shrink_lock);
> > +       }
> > +       spin_unlock(&zswap_pools_lock);
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
> [..]
> > @@ -1233,15 +1369,15 @@ bool zswap_store(struct folio *folio)
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
> Can we just use RCU here as well? (same around memcg_list_lru_alloc()
> call below).

For memcg_list_lru_alloc(): there's potentially sleeping in that piece of
code I believe? I believe at the very least we'll have to use this gfp_t
flag for it to be rcu-safe:

GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN
not sure the

Same go for this particular place IIRC - there's some sleeping done
in zswap_writeback_entry(), correct?


>
> > +       }
> >
> >         /* reclaim space if needed */
> >         if (zswap_is_full()) {
> > @@ -1258,7 +1394,7 @@ bool zswap_store(struct folio *folio)
> >         }
> >
> >         /* allocate entry */
> > -       entry =3D zswap_entry_cache_alloc(GFP_KERNEL);
> > +       entry =3D zswap_entry_cache_alloc(GFP_KERNEL, page_to_nid(page)=
);
> >         if (!entry) {
> >                 zswap_reject_kmemcache_fail++;
> >                 goto reject;
> > @@ -1285,6 +1421,15 @@ bool zswap_store(struct folio *folio)
> >         if (!entry->pool)
> >                 goto freepage;
> >
> > +       if (objcg) {
> > +               memcg =3D get_mem_cgroup_from_objcg(objcg);
> > +               if (memcg_list_lru_alloc(memcg, &entry->pool->list_lru,=
 GFP_KERNEL)) {
> > +                       mem_cgroup_put(memcg);
> > +                       goto put_pool;
> > +               }
> > +               mem_cgroup_put(memcg);
> > +       }
> > +
> >         /* compress */
> >         acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> >
