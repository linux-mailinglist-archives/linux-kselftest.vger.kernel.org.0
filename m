Return-Path: <linux-kselftest+bounces-850-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F247FE442
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 00:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB7AF2823C1
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 23:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1345347A6F;
	Wed, 29 Nov 2023 23:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLHBOu9N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1308E10A;
	Wed, 29 Nov 2023 15:44:51 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7b350130c3fso5786139f.3;
        Wed, 29 Nov 2023 15:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701301490; x=1701906290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tOCbkwNSpvGdMwE6tBYjY/uOZ+dKCwcjhdWtFECtR0=;
        b=jLHBOu9NYC+a1uQERP5D+q5+PW2S4rhxggPMBGeTHmDpLmU7ICkZaq2Nz9yTuav1vY
         V+9rtul+fHeULsZIAbw7UZpxlev7WR6kZTWkfGWKnLHw9hfihl4V+TmBV2kcQ+7fWiwB
         ofMLdA29LKMLrfXcx5jx98MiXEIJa3Ka7qyv7Rp1Rc0Rd5dTuaTOdSfeX83aFlj020af
         MZ9hx2b3Vtfj8Gwf/TVCCmclDyZC42s71ks9Zuf1/mYhX7Rn7O4M5XEmb4m4oYt3ABH7
         7/KCwb2nwtfo3qix9fZ4KR1QbN/C2V7o51ybqdFh6nrxsAt+YlLKCBzfZLw5usihbGS/
         FUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701301490; x=1701906290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/tOCbkwNSpvGdMwE6tBYjY/uOZ+dKCwcjhdWtFECtR0=;
        b=Ec6nOsOMvDCRiWMNGXuA8c/ak5vUY2bf0+MhfN21TZBvjw68Fr/RkOHbOHRK4vO/Mf
         oB1a2nXjM8hn47fOAdvUpdj+ewsN5mGiBrZEu4cfip0LA4jmcDYXuY6vuDWle23kAbh1
         momQNBWA/fT76YxcXUatbMUBz0XBlG4eIS73umhX/cevzITvcAZzNl+9bJZr5wJqNRUG
         ahOfzW9M3FLsI5Rs2h3mrNALoQxu8mDdD3stBZSCzJ0oy6erpO66+GsUqC9kh7am+Kob
         wbakivZL4kg4yVAIbc8JWPkGRlELnjeydzodArYfYmKDgUx+s4RGHficwQtxSwyUFNV0
         3I1g==
X-Gm-Message-State: AOJu0Yzr7hrUVOORIvXJjC8ghnH7i0KDQEnTd1huPQhwtt7q+ysl0x3P
	l7sNTXmxQp+peynYXDIiv4uy7G8SyR8YVootuws=
X-Google-Smtp-Source: AGHT+IGFNz6rJ8Zwwfjam9HG7pnWig/mfdY7gdfMqsdCEgtQ8yI+OeC+UmHiGEV3ZBiGcHyD0PvT+3wrYnMZtGMlXNU=
X-Received: by 2002:a05:6e02:eca:b0:35d:fd2:6b3 with SMTP id
 i10-20020a056e020eca00b0035d0fd206b3mr7641812ilk.26.1701301490262; Wed, 29
 Nov 2023 15:44:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127234600.2971029-1-nphamcs@gmail.com> <20231127234600.2971029-7-nphamcs@gmail.com>
 <20231129162150.GE135852@cmpxchg.org>
In-Reply-To: <20231129162150.GE135852@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 29 Nov 2023 15:44:39 -0800
Message-ID: <CAKEwX=M_4W6OhsW-z4GQEAp9bSx9QsFgvv8ngwLB-VRpuetv1Q@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] zswap: shrinks zswap pool based on memory pressure
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: akpm@linux-foundation.org, cerasuolodomenico@gmail.com, 
	yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org, 
	vitaly.wool@konsulko.com, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeelb@google.com, muchun.song@linux.dev, chrisl@kernel.org, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 8:21=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Mon, Nov 27, 2023 at 03:46:00PM -0800, Nhat Pham wrote:
> > Currently, we only shrink the zswap pool when the user-defined limit is
> > hit. This means that if we set the limit too high, cold data that are
> > unlikely to be used again will reside in the pool, wasting precious
> > memory. It is hard to predict how much zswap space will be needed ahead
> > of time, as this depends on the workload (specifically, on factors such
> > as memory access patterns and compressibility of the memory pages).
> >
> > This patch implements a memcg- and NUMA-aware shrinker for zswap, that
> > is initiated when there is memory pressure. The shrinker does not
> > have any parameter that must be tuned by the user, and can be opted in
> > or out on a per-memcg basis.
> >
> > Furthermore, to make it more robust for many workloads and prevent
> > overshrinking (i.e evicting warm pages that might be refaulted into
> > memory), we build in the following heuristics:
> >
> > * Estimate the number of warm pages residing in zswap, and attempt to
> >   protect this region of the zswap LRU.
> > * Scale the number of freeable objects by an estimate of the memory
> >   saving factor. The better zswap compresses the data, the fewer pages
> >   we will evict to swap (as we will otherwise incur IO for relatively
> >   small memory saving).
> > * During reclaim, if the shrinker encounters a page that is also being
> >   brought into memory, the shrinker will cautiously terminate its
> >   shrinking action, as this is a sign that it is touching the warmer
> >   region of the zswap LRU.
> >
> > As a proof of concept, we ran the following synthetic benchmark:
> > build the linux kernel in a memory-limited cgroup, and allocate some
> > cold data in tmpfs to see if the shrinker could write them out and
> > improved the overall performance. Depending on the amount of cold data
> > generated, we observe from 14% to 35% reduction in kernel CPU time used
> > in the kernel builds.
>
> I think this is a really important piece of functionality for zswap.
>
> Memory compression has been around and in use for a long time, but the
> question of zswap vs swap sizing has been in the room since the hybrid
> mode was first proposed. Because depending on the reuse patterns,
> putting zswap with a static size limit in front of an existing swap
> file can be a net negative for performance as it consumes more memory.
>
> It's great to finally see a solution to this which makes zswap *much*
> more general purpose. And something that distributions might want to
> turn on per default when swap is configured.
>
> Actually to the point where I think there should be a config option to
> enable the shrinker per default. Maybe not right away, but in a few
> releases when this feature has racked up some more production time.

Sure thingy - how does everyone feel about this?

>
> > @@ -687,6 +687,7 @@ struct page *swap_cluster_readahead(swp_entry_t ent=
ry, gfp_t gfp_mask,
> >                                       &page_allocated, false);
> >       if (unlikely(page_allocated))
> >               swap_readpage(page, false, NULL);
> > +     zswap_lruvec_swapin(page);
>
> The "lruvec" in the name vs the page parameter is a bit odd.
> zswap_page_swapin() would be slightly better, but it still also sounds
> like it would cause an actual swapin of some sort.
>
> zswap_record_swapin()?

Hmm that sounds good to me. I'm not very good with naming, if that's
not already evident :)

>
> > @@ -520,6 +575,95 @@ static struct zswap_entry *zswap_entry_find_get(st=
ruct rb_root *root,
> >       return entry;
> >  }
> >
> > +/*********************************
> > +* shrinker functions
> > +**********************************/
> > +static enum lru_status shrink_memcg_cb(struct list_head *item, struct =
list_lru_one *l,
> > +                                    spinlock_t *lock, void *arg);
> > +
> > +static unsigned long zswap_shrinker_scan(struct shrinker *shrinker,
> > +             struct shrink_control *sc)
> > +{
> > +     struct lruvec *lruvec =3D mem_cgroup_lruvec(sc->memcg, NODE_DATA(=
sc->nid));
> > +     unsigned long shrink_ret, nr_protected, lru_size;
> > +     struct zswap_pool *pool =3D shrinker->private_data;
> > +     bool encountered_page_in_swapcache =3D false;
> > +
> > +     nr_protected =3D
> > +             atomic_long_read(&lruvec->zswap_lruvec_state.nr_zswap_pro=
tected);
> > +     lru_size =3D list_lru_shrink_count(&pool->list_lru, sc);
> > +
> > +     /*
> > +      * Abort if the shrinker is disabled or if we are shrinking into =
the
> > +      * protected region.
> > +      */
> > +     if (!zswap_shrinker_enabled || nr_protected >=3D lru_size - sc->n=
r_to_scan) {
> > +             sc->nr_scanned =3D 0;
> > +             return SHRINK_STOP;
> > +     }
>
> I'm scratching my head at the protection check. zswap_shrinker_count()
> already factors protection into account, so sc->nr_to_scan should only
> be what is left on the list after excluding the protected area.
>
> Do we even get here if the whole list is protected? Is this to protect
> against concurrent shrinking of the list through multiple shrinkers or
> swapins? If so, a comment would be nice :)

Yep, this is mostly for concurrent shrinkers. Please fact-check me,
but IIUC if we have too many reclaimers all calling upon the zswap
shrinker (before any of them can make substantial progress), we can
have a situation where the total number of objects freed by the
reclaimers will eat into the protection area of the zswap LRU (even if
the number of freeable objects is scaled down by the compression
ratio, and further scaled down internally in the shrinker/vmscan
code). I've observed this tendency when there is a) a lot of worker
threads in my benchmark and b) memory pressure.  This is a crude/racy
way to alleviate the issue.

I think this is actually a wider problem than just zswap and zswap
shrinker - we need better reclaimer throttling logic IMO. Perhaps this
check should be done higher up the stack - something along the lines
of having each reclaimer "register" its intention (number of objects
it wants to reclaim) to a particular shrinker, allowing the shrinker
to deny a reclaimer if there is already a strong reclaim driving
force. Or some other throttling heuristics based on the number of
freeable objects and the reclaimer registration data.

>
> Otherwise, this looks great to me!
>
> Just nitpicks, no show stoppers:
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

