Return-Path: <linux-kselftest+bounces-1304-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5217D8075DE
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 17:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6EC1B20C62
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 16:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC256495FA;
	Wed,  6 Dec 2023 16:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aU35HanS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A541B2;
	Wed,  6 Dec 2023 08:56:55 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-35d725ac060so12692295ab.2;
        Wed, 06 Dec 2023 08:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701881815; x=1702486615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIrgXBCmrJsEmx/2lceqqp9Xwm1JeHuqctE9dAlll+0=;
        b=aU35HanSNxKXTrTQ4kjEHWAZLFS/tBF3j+fPpW+VrMq78Cqd6wx6n1ee3jUw3O1rr9
         ALTKgvLZBjgCF7Nde2nUL0mYEAbOqVQYzijEM5FT8tVfvuDICeKsIWmukHSFh8ZzcsYB
         TTfQgRw83idj5raYHzvEgULsDnpjX2V5EAF1oXFxvL9wHxRDKS8hW2v9vj2QfyxdlKBf
         rsjA5qadoS4E07v3YnWJ+MaY+3FkG25dIhXpm5ev3DmJdUr2vvSV3olRavFgr3YjxF74
         C+oFhmdbQl3wR2hCKKOnQSimPiAOHWIlcpR6ktaJ+EZhJXrgozMTAQOd16XCVibcSEd2
         10UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701881815; x=1702486615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yIrgXBCmrJsEmx/2lceqqp9Xwm1JeHuqctE9dAlll+0=;
        b=rduf33fc/QRBnPHX5In1m5A+wNchwJUEESGduvgSWou8BD8oBYAo/jZYE3K2BYsVk7
         e8b1QV3IDa+CtJKZC4JqA+OOvohykW7wFPOO8FzF9+7SPbo/eoMFFv9bkmCSO2DHHb/N
         bj+sW2EytpyNkTVyVT2lNcHBr9bR+kvUabPiNywxh8uEOD2/nb5J4lhZWUeqL85WXngJ
         m8nHlYK9FgQlLeW4/syA3FOeWE/txNzPIO+pwvAaKzkZA8mh8gOxsli/GFnplZvOtsPr
         Zkii0SjRc/mbs6VJF02N6YqLRG1yvRd+B3QiGF1MuyX97Dia25a0DhSlORLHnqEDjv83
         xe9g==
X-Gm-Message-State: AOJu0YzoMkDakOQh5a6D6OwghWcSGJ3zSJCeDp3eb/C9EimcaWJ9/luy
	op5n2ZHrdE/KMGLUpXzPTtf4mN2DFLVavuB9jD8=
X-Google-Smtp-Source: AGHT+IFNq8u43WbI4c01PT05oYMO3aPQSJ6ErYBAcTShuJSw9WrajU+G7etAPmGSFnGOLDah6Qzb1dasQimC9b9ONCQ=
X-Received: by 2002:a05:6e02:1050:b0:35d:59a2:1281 with SMTP id
 p16-20020a056e02105000b0035d59a21281mr1435226ilj.45.1701881814603; Wed, 06
 Dec 2023 08:56:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130194023.4102148-1-nphamcs@gmail.com> <20231130194023.4102148-7-nphamcs@gmail.com>
 <ed2792de-24cc-4037-9ee1-966cc07df57a@linux.dev> <CAJD7tkbiWqXs1PEZjMHO0gj5uSaaB-KNUNCiUz25MuPvzeb=wg@mail.gmail.com>
In-Reply-To: <CAJD7tkbiWqXs1PEZjMHO0gj5uSaaB-KNUNCiUz25MuPvzeb=wg@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 6 Dec 2023 08:56:43 -0800
Message-ID: <CAKEwX=M8YThH8qOdHt5TV1E4PCiw2FSv7815O3fhqXNVMt5ezg@mail.gmail.com>
Subject: Re: [PATCH v8 6/6] zswap: shrinks zswap pool based on memory pressure
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Chengming Zhou <chengming.zhou@linux.dev>, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	cerasuolodomenico@gmail.com, sjenning@redhat.com, ddstreet@ieee.org, 
	vitaly.wool@konsulko.com, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeelb@google.com, muchun.song@linux.dev, chrisl@kernel.org, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 10:00=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> [..]
> > > @@ -526,6 +582,102 @@ static struct zswap_entry *zswap_entry_find_get=
(struct rb_root *root,
> > >       return entry;
> > >  }
> > >
> > > +/*********************************
> > > +* shrinker functions
> > > +**********************************/
> > > +static enum lru_status shrink_memcg_cb(struct list_head *item, struc=
t list_lru_one *l,
> > > +                                    spinlock_t *lock, void *arg);
> > > +
> > > +static unsigned long zswap_shrinker_scan(struct shrinker *shrinker,
> > > +             struct shrink_control *sc)
> > > +{
> > > +     struct lruvec *lruvec =3D mem_cgroup_lruvec(sc->memcg, NODE_DAT=
A(sc->nid));
> > > +     unsigned long shrink_ret, nr_protected, lru_size;
> > > +     struct zswap_pool *pool =3D shrinker->private_data;
> > > +     bool encountered_page_in_swapcache =3D false;
> > > +
> > > +     nr_protected =3D
> > > +             atomic_long_read(&lruvec->zswap_lruvec_state.nr_zswap_p=
rotected);
> > > +     lru_size =3D list_lru_shrink_count(&pool->list_lru, sc);
> > > +
> > > +     /*
> > > +      * Abort if the shrinker is disabled or if we are shrinking int=
o the
> > > +      * protected region.
> > > +      *
> > > +      * This short-circuiting is necessary because if we have too ma=
ny multiple
> > > +      * concurrent reclaimers getting the freeable zswap object coun=
ts at the
> > > +      * same time (before any of them made reasonable progress), the=
 total
> > > +      * number of reclaimed objects might be more than the number of=
 unprotected
> > > +      * objects (i.e the reclaimers will reclaim into the protected =
area of the
> > > +      * zswap LRU).
> > > +      */
> > > +     if (!zswap_shrinker_enabled || nr_protected >=3D lru_size - sc-=
>nr_to_scan) {
> > > +             sc->nr_scanned =3D 0;
> > > +             return SHRINK_STOP;
> > > +     }
> > > +
> > > +     shrink_ret =3D list_lru_shrink_walk(&pool->list_lru, sc, &shrin=
k_memcg_cb,
> > > +             &encountered_page_in_swapcache);
> > > +
> > > +     if (encountered_page_in_swapcache)
> > > +             return SHRINK_STOP;
> > > +
> > > +     return shrink_ret ? shrink_ret : SHRINK_STOP;
> > > +}
> > > +
> > > +static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
> > > +             struct shrink_control *sc)
> > > +{
> > > +     struct zswap_pool *pool =3D shrinker->private_data;
> > > +     struct mem_cgroup *memcg =3D sc->memcg;
> > > +     struct lruvec *lruvec =3D mem_cgroup_lruvec(memcg, NODE_DATA(sc=
->nid));
> > > +     unsigned long nr_backing, nr_stored, nr_freeable, nr_protected;
> > > +
> > > +#ifdef CONFIG_MEMCG_KMEM
> > > +     cgroup_rstat_flush(memcg->css.cgroup);
> > > +     nr_backing =3D memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PAGE_S=
HIFT;
> > > +     nr_stored =3D memcg_page_state(memcg, MEMCG_ZSWAPPED);
> > > +#else
> > > +     /* use pool stats instead of memcg stats */
> > > +     nr_backing =3D get_zswap_pool_size(pool) >> PAGE_SHIFT;
> > > +     nr_stored =3D atomic_read(&pool->nr_stored);
> > > +#endif
> > > +
> > > +     if (!zswap_shrinker_enabled || !nr_stored)
> > When I tested with this series, with !zswap_shrinker_enabled in the def=
ault case,
> > I found the performance is much worse than that without this patch.
> >
> > Testcase: memory.max=3D2G, zswap enabled, kernel build -j32 in a tmpfs =
directory.
> >
> > The reason seems the above cgroup_rstat_flush(), caused much rstat lock=
 contention
> > to the zswap_store() path. And if I put the "zswap_shrinker_enabled" ch=
eck above
> > the cgroup_rstat_flush(), the performance become much better.
> >
> > Maybe we can put the "zswap_shrinker_enabled" check above cgroup_rstat_=
flush()?
>
> Yes, we should do nothing if !zswap_shrinker_enabled. We should also
> use mem_cgroup_flush_stats() here like other places unless accuracy is
> crucial, which I doubt given that reclaim uses
> mem_cgroup_flush_stats().

Ah, good points on both suggestions. We should not do extra work for
non-user. And, this is a best-effort approximation of the memory
saving factor, so as long as it is not *too* far off I think it's
acceptable.

>
> mem_cgroup_flush_stats() has some thresholding to make sure we don't
> do flushes unnecessarily, and I have a pending series in mm-unstable
> that makes that thresholding per-memcg. Keep in mind that adding a
> call to mem_cgroup_flush_stats() will cause a conflict in mm-unstable,
> because the series there adds a memcg argument to
> mem_cgroup_flush_stats(). That should be easily amenable though, I can
> post a fixlet for my series to add the memcg argument there on top of
> users if needed.

Hmm so how should we proceed from here? How about this:

a) I can send a fixlet to move the enablement check above the stats
flushing + use mem_cgroup_flush_stats
b) Then maybe, you can send a fixlet to update this new callsite?

Does that sound reasonable?

>
> >
> > Thanks!
> >
> > > +             return 0;
> > > +
> > > +     nr_protected =3D
> > > +             atomic_long_read(&lruvec->zswap_lruvec_state.nr_zswap_p=
rotected);
> > > +     nr_freeable =3D list_lru_shrink_count(&pool->list_lru, sc);
> > > +     /*
> > > +      * Subtract the lru size by an estimate of the number of pages
> > > +      * that should be protected.
> > > +      */
> > > +     nr_freeable =3D nr_freeable > nr_protected ? nr_freeable - nr_p=
rotected : 0;
> > > +
> > > +     /*
> > > +      * Scale the number of freeable pages by the memory saving fact=
or.
> > > +      * This ensures that the better zswap compresses memory, the fe=
wer
> > > +      * pages we will evict to swap (as it will otherwise incur IO f=
or
> > > +      * relatively small memory saving).
> > > +      */
> > > +     return mult_frac(nr_freeable, nr_backing, nr_stored);
> > > +}
> > > +
> > > +static void zswap_alloc_shrinker(struct zswap_pool *pool)
> > > +{
> > > +     pool->shrinker =3D
> > > +             shrinker_alloc(SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWA=
RE, "mm-zswap");
> > > +     if (!pool->shrinker)
> > > +             return;
> > > +
> > > +     pool->shrinker->private_data =3D pool;
> > > +     pool->shrinker->scan_objects =3D zswap_shrinker_scan;
> > > +     pool->shrinker->count_objects =3D zswap_shrinker_count;
> > > +     pool->shrinker->batch =3D 0;
> > > +     pool->shrinker->seeks =3D DEFAULT_SEEKS;
> > > +}
> > > +
> > >  /*********************************
> > >  * per-cpu code
> > >  **********************************/
> [..]

