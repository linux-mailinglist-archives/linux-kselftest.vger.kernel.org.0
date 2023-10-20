Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DBE7D16AD
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 21:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjJTT6f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 15:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjJTT6e (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 15:58:34 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6853DD52;
        Fri, 20 Oct 2023 12:58:31 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-35749078a59so4103585ab.3;
        Fri, 20 Oct 2023 12:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697831911; x=1698436711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMaTpdy0i75iy95ltl1vU/e0Nep1hsEs0WMhGjfkl4k=;
        b=dM1k2pA1SIXnjXjKOD/nz+P+B2/eL2F6eevtuMY7QKoTwNmR/lcuyT7iFBFlsdQiNq
         r8jDvdwyww5bb593O4eHrDq9nPDa+dx+CaN5CFKS8KmxIRDP7q9Gy/EII/CZXlI/iUnk
         3/TlB+Wueo9CBJhlKDDdfjyLjjn1CzHmRwB00Q4mqXs6vCNxNAUyJ9Frr6Cknh8xBHzg
         LGkO97iZ9sVzKjHC65es4iB0/Xz83Qul/67N5tB4bEMaE119GDIx3eAudDlxLy6LELAU
         Tj/S8zN/VegqMF1LLzoCCkr/kroSpguUnv3Vu7tID8ekrLkjG0dsLhWUVrriA5N1VtXG
         Cf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697831911; x=1698436711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DMaTpdy0i75iy95ltl1vU/e0Nep1hsEs0WMhGjfkl4k=;
        b=xG7TMi4zjMbZtZrBz3n/IRKH3z+F7wNc6HzvDVOAQ6Y+kFrA4W2fVxaXXsdPxSJdkH
         tJywExb6Ka3VwVCd+Syc1SFDa9ks8ANPXY8lj2oqDbd0rc6iE1LBhapmkt6CxBE9d8a7
         AR25eXROkPhFXryCH2QLhKnmGFX1Rt0qhICa1tb42GzpDc9Q6JMjxIj1cpqVsi7mxTQ0
         HFkhN/PiI6wXtkjhM4eJQgJ1TEtM6Uc1CtFeXQWqs6Vji6UWX139EA7V7e1cRcYm3bNy
         6P6OLYljZdxE8Vy1qe+DBVYMgvwiCj3o6tjuqHSfwmX2kxl/spnsvvyFfpU+f07mIOFG
         0WPA==
X-Gm-Message-State: AOJu0YyFYShaO8K5CbBdBW02YsOGTOUZByTHGzZ8hTmcjH/aeQUaQQ3a
        NvZl4ZOK4ZL5pICpVMub6iaRAQqjZbfnYwRrJ98=
X-Google-Smtp-Source: AGHT+IGR8W7Xi0YQ/7dCUZ2Jb3c+qTsFkmiWPSTao7GyIUJ9F1uL0JV4qYZmZW/AoBcAKMHA3vnqiBBpxyI24w52tdA=
X-Received: by 2002:a92:c26a:0:b0:34f:f2d3:ea70 with SMTP id
 h10-20020a92c26a000000b0034ff2d3ea70mr4009375ild.6.1697831910562; Fri, 20 Oct
 2023 12:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231017232152.2605440-1-nphamcs@gmail.com> <20231017232152.2605440-3-nphamcs@gmail.com>
 <CAJD7tka2aVKBJj6cYutcVzOGzj_6gop6-ytSmWWML=sEe9qHbA@mail.gmail.com>
 <CA+CLi1jiyY3oueWrLtd5JOrtP-aYQ90sPgSCBoWtB2jVL_-FxA@mail.gmail.com> <CAJD7tka_gvNPgu4gim9-dqx0Wf-zdGj+==nwx2yrmOuZoe=oyw@mail.gmail.com>
In-Reply-To: <CAJD7tka_gvNPgu4gim9-dqx0Wf-zdGj+==nwx2yrmOuZoe=oyw@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Fri, 20 Oct 2023 12:58:19 -0700
Message-ID: <CAKEwX=OVcAEnOEmhy2dGwE7Zm-L-y8Mq=bx4BFUeQnTXaAA_FQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] zswap: make shrinking memcg-aware
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        akpm@linux-foundation.org, hannes@cmpxchg.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, mhocko@kernel.org,
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

On Thu, Oct 19, 2023 at 9:15=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> [..]
> > > >
> > > > +/*********************************
> > > > +* lru functions
> > > > +**********************************/
> > > > +static bool zswap_lru_add(struct list_lru *list_lru, struct zswap_=
entry *entry)
> > > > +{
> > > > +       struct mem_cgroup *memcg =3D get_mem_cgroup_from_entry(entr=
y);
> > >
> > > Could we avoid the need for get/put with an rcu_read_lock() instead?
> >
> > I think we can, I'm not entirely sure of the consequences though. By th=
e
> > look of it I'd say it's safe but I wouldn't trust my judgement on this.
>
> It just seems like we have a pattern of short-lived get/put. If RCU
> gives enough protection it should be simpler. IIUC taking a reference
> does not protect against offlining or reparenting, so I am not sure if
> taking a reference here would provide any more protection than
>

I'd keep it for now. Sounds like an optimization to me, which could
always be done as a follow-up :)

Unless of course, if somebody has a really strong opinion regarding
this.

> >
> > >
> [..]
> > > > @@ -686,7 +716,36 @@ static int zswap_reclaim_entry(struct zswap_po=
ol *pool)
> > > >         zswap_entry_put(tree, entry);
> > > >  unlock:
> > > >         spin_unlock(&tree->lock);
> > > > -       return ret ? -EAGAIN : 0;
> > > > +       spin_lock(lock);
> > > > +       return ret;
> > > > +}
> > > > +
> > > > +static int shrink_memcg(struct mem_cgroup *memcg)
> > > > +{
> > > > +       struct zswap_pool *pool;
> > > > +       int nid, shrunk =3D 0;
> > > > +
> > > > +       pool =3D zswap_pool_current_get();
> > > > +       if (!pool)
> > > > +               return -EINVAL;
> > > > +
> > > > +       /*
> > > > +        * Skip zombies because their LRUs are reparented and we wo=
uld be
> > > > +        * reclaiming from the parent instead of the dead memcgroup=
.
> > >
> > > nit: s/memcgroup/memcg.
> > >
> > > > +        */
> > > > +       if (memcg && !mem_cgroup_online(memcg))
> > > > +               goto out;
> > >
> > > If we move this above zswap_pool_current_get(), we can return directl=
y
> > > and remove the label. I noticed we will return -EAGAIN if memcg is
> > > offline. IIUC -EAGAIN for the caller will move on to the next memcg,
> > > but I am wondering if a different errno would be clearer here.
> >
> > True, I remember spending some time staring at error codes but couldn't=
 find a
> > better one. What if we use -EINVAL for retryable errors, and use someth=
ing else
> > for the one where there is no pool? -ENODEV?
>
> Do you mean -EINVAL for non-retryable errors? Perhaps -ENOENT is more
> appropriate as a return for offline memcgs?
>
> >
> > >
> [..]
> > > >  static void shrink_worker(struct work_struct *w)
> > > > @@ -695,10 +754,13 @@ static void shrink_worker(struct work_struct =
*w)
> > > >                                                 shrink_work);
> > > >         int ret, failures =3D 0;
> > > >
> > > > +       /* global reclaim will select cgroup in a round-robin fashi=
on. */
> > > >         do {
> > > > -               ret =3D zswap_reclaim_entry(pool);
> > > > +               pool->next_shrink =3D mem_cgroup_iter(NULL, pool->n=
ext_shrink, NULL);
> > >
> > > Perhaps next_shrink_memcg is a better name here?
> >
> > Will change if you have a strong preference, I'd keep it shorter becaus=
e it's
> > always used in conjunction with a memcg type or function.
>
> I'd rather have the more explicit name unless it causes some annoying
> line breaks or so.
>
> >
> > >
> > > > +
> > > > +               ret =3D shrink_memcg(pool->next_shrink);
> > > > +
> > > >                 if (ret) {
> > > > -                       zswap_reject_reclaim_fail++;
> > > >                         if (ret !=3D -EAGAIN)
> > > >                                 break;
> > > >                         if (++failures =3D=3D MAX_RECLAIM_RETRIES)
> > > > @@ -764,8 +826,7 @@ static struct zswap_pool *zswap_pool_create(cha=
r *type, char *compressor)
> > > >          */
> > > >         kref_init(&pool->kref);
> > > >         INIT_LIST_HEAD(&pool->list);
> > > > -       INIT_LIST_HEAD(&pool->lru);
> > > > -       spin_lock_init(&pool->lru_lock);
> > > > +       list_lru_init_memcg(&pool->list_lru, NULL);
> > > >         INIT_WORK(&pool->shrink_work, shrink_worker);
> > > >
> > > >         zswap_pool_debug("created", pool);
> > > > @@ -831,6 +892,9 @@ static void zswap_pool_destroy(struct zswap_poo=
l *pool)
> > > >
> > > >         cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &po=
ol->node);
> > > >         free_percpu(pool->acomp_ctx);
> > > > +       list_lru_destroy(&pool->list_lru);
> > > > +       if (pool->next_shrink)
> > > > +               mem_cgroup_put(pool->next_shrink);
> > > >         for (i =3D 0; i < ZSWAP_NR_ZPOOLS; i++)
> > > >                 zpool_destroy_pool(pool->zpools[i]);
> > > >         kfree(pool);
> > > > @@ -1076,7 +1140,7 @@ static int zswap_writeback_entry(struct zswap=
_entry *entry,
> > > >
> > > >         /* try to allocate swap cache page */
> > > >         page =3D __read_swap_cache_async(swpentry, GFP_KERNEL, NULL=
, 0,
> > > > -                                      &page_was_allocated);
> > > > +                                      &page_was_allocated, true);
> > > >         if (!page) {
> > > >                 ret =3D -ENOMEM;
> > > >                 goto fail;
> > > > @@ -1142,7 +1206,6 @@ static int zswap_writeback_entry(struct zswap=
_entry *entry,
> > > >         /* start writeback */
> > > >         __swap_writepage(page, &wbc);
> > > >         put_page(page);
> > > > -       zswap_written_back_pages++;
> > > >
> > > >         return ret;
> > > >
> > > > @@ -1199,8 +1262,10 @@ bool zswap_store(struct folio *folio)
> > > >         struct scatterlist input, output;
> > > >         struct crypto_acomp_ctx *acomp_ctx;
> > > >         struct obj_cgroup *objcg =3D NULL;
> > > > +       struct mem_cgroup *memcg =3D NULL;
> > > >         struct zswap_pool *pool;
> > > >         struct zpool *zpool;
> > > > +       int lru_alloc_ret;
> > > >         unsigned int dlen =3D PAGE_SIZE;
> > > >         unsigned long handle, value;
> > > >         char *buf;
> > > > @@ -1230,15 +1295,15 @@ bool zswap_store(struct folio *folio)
> > > >                 zswap_invalidate_entry(tree, dupentry);
> > > >         }
> > > >         spin_unlock(&tree->lock);
> > > > -
> > > > -       /*
> > > > -        * XXX: zswap reclaim does not work with cgroups yet. Witho=
ut a
> > > > -        * cgroup-aware entry LRU, we will push out entries system-=
wide based on
> > > > -        * local cgroup limits.
> > > > -        */
> > > >         objcg =3D get_obj_cgroup_from_folio(folio);
> > > > -       if (objcg && !obj_cgroup_may_zswap(objcg))
> > > > -               goto reject;
> > > > +       if (objcg && !obj_cgroup_may_zswap(objcg)) {
> > > > +               memcg =3D get_mem_cgroup_from_objcg(objcg);
> > > > +               if (shrink_memcg(memcg)) {
> > > > +                       mem_cgroup_put(memcg);
> > > > +                       goto reject;
> > > > +               }
> > > > +               mem_cgroup_put(memcg);
> > > > +       }
> > > >
> > > >         /* reclaim space if needed */
> > > >         if (zswap_is_full()) {
> > > > @@ -1254,10 +1319,15 @@ bool zswap_store(struct folio *folio)
> > > >                         zswap_pool_reached_full =3D false;
> > > >         }
> > > >
> > > > +       pool =3D zswap_pool_current_get();
> > > > +       if (!pool)
> > > > +               goto reject;
> > > > +
> > >
> > > Why do we need to move zswap_pool_current_get() up here?
> >
> > Ah, thanks. This is a leftover from a previous version where the pool w=
as needed
> > to allocate the entry.
> >
> >
> > >
> > > >         /* allocate entry */
> > > > -       entry =3D zswap_entry_cache_alloc(GFP_KERNEL);
> > > > +       entry =3D zswap_entry_cache_alloc(GFP_KERNEL, page_to_nid(p=
age));
> > > >         if (!entry) {
> > > >                 zswap_reject_kmemcache_fail++;
> > > > +               zswap_pool_put(pool);
> > > >                 goto reject;
> > > >         }
> > > >
> > > > @@ -1269,6 +1339,7 @@ bool zswap_store(struct folio *folio)
> > > >                         entry->length =3D 0;
> > > >                         entry->value =3D value;
> > > >                         atomic_inc(&zswap_same_filled_pages);
> > > > +                       zswap_pool_put(pool);
> > > >                         goto insert_entry;
> > > >                 }
> > > >                 kunmap_atomic(src);
> > > > @@ -1278,9 +1349,15 @@ bool zswap_store(struct folio *folio)
> > > >                 goto freepage;
> > > >
> > > >         /* if entry is successfully added, it keeps the reference *=
/
> > > > -       entry->pool =3D zswap_pool_current_get();
> > > > -       if (!entry->pool)
> > > > -               goto freepage;
> > > > +       entry->pool =3D pool;
> > > > +       if (objcg) {
> > > > +               memcg =3D get_mem_cgroup_from_objcg(objcg);
> > > > +               lru_alloc_ret =3D memcg_list_lru_alloc(memcg, &pool=
->list_lru, GFP_KERNEL);
> > > > +               mem_cgroup_put(memcg);
> > > > +
> > > > +               if (lru_alloc_ret)
> > > > +                       goto freepage;
> > > > +       }
> > > >
> > > >         /* compress */
> > > >         acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> > > > @@ -1358,9 +1435,8 @@ bool zswap_store(struct folio *folio)
> > > >                 zswap_invalidate_entry(tree, dupentry);
> > > >         }
> > > >         if (entry->length) {
> > > > -               spin_lock(&entry->pool->lru_lock);
> > > > -               list_add(&entry->lru, &entry->pool->lru);
> > > > -               spin_unlock(&entry->pool->lru_lock);
> > > > +               INIT_LIST_HEAD(&entry->lru);
> > > > +               zswap_lru_add(&pool->list_lru, entry);
> > > >         }
> > > >         spin_unlock(&tree->lock);
> > > >
> > > > @@ -1373,8 +1449,8 @@ bool zswap_store(struct folio *folio)
> > > >
> > > >  put_dstmem:
> > > >         mutex_unlock(acomp_ctx->mutex);
> > > > -       zswap_pool_put(entry->pool);
> > > >  freepage:
> > > > +       zswap_pool_put(entry->pool);
> > > >         zswap_entry_cache_free(entry);
> > > >  reject:
> > > >         if (objcg)
> > > > @@ -1467,9 +1543,8 @@ bool zswap_load(struct folio *folio)
> > > >                 zswap_invalidate_entry(tree, entry);
> > > >                 folio_mark_dirty(folio);
> > > >         } else if (entry->length) {
> > > > -               spin_lock(&entry->pool->lru_lock);
> > > > -               list_move(&entry->lru, &entry->pool->lru);
> > > > -               spin_unlock(&entry->pool->lru_lock);
> > > > +               zswap_lru_del(&entry->pool->list_lru, entry);
> > > > +               zswap_lru_add(&entry->pool->list_lru, entry);
> > > >         }
> > > >         zswap_entry_put(tree, entry);
> > > >         spin_unlock(&tree->lock);
> > > > --
> > > > 2.34.1
