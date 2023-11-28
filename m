Return-Path: <linux-kselftest+bounces-784-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 477857FCA75
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 00:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3691B2174A
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 23:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805BD59B76;
	Tue, 28 Nov 2023 23:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJJUQQcs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F6212C;
	Tue, 28 Nov 2023 15:04:15 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7b3bc70fca5so8734439f.1;
        Tue, 28 Nov 2023 15:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701212655; x=1701817455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2DFhzUwmSAVWyj8UA9HM/5RmuhrapMWgT80OB1ol+pw=;
        b=PJJUQQcsrXQ3FpOex5IFRIz053Tj/fzr7Z2DJs5z6q8okLYPJXx8HagpFCdFdwg4EY
         EzVZTk7K4aG0n8eOYQ2R2R79DpYmc/g23wcKGeVZNPEDRqjuI4wVMCrgqQ6599Br166g
         vcm/GQTBUi/Gc9e2CcB1ahA1HcWdnqJAL6xQExdlQuyll4AQLzwtetJkcHwUXbIlyuwg
         I4F9NCHmuegM6BX78qyJOlb/a9q18sMTDpBinNyJbfr79b3rcdsD4Bk1xEe07S3AK5Xn
         C4cpQEfC31bhvINCXwhUWRr82GOzXYBJP4rNJSQBcW7w7Y5v7xQhI9gtQvyiVdp8+NmL
         5l8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701212655; x=1701817455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2DFhzUwmSAVWyj8UA9HM/5RmuhrapMWgT80OB1ol+pw=;
        b=H7gkbpFIhrxiP6omsCcvPUolSZvZnxfYHUI9EvW3M9yY0jDSOWv3IgPFQBioXqvfmP
         NrIQEvVmM3252JR+FgiR0aiaCAVeIKnkYCbf0lvW9W7PVkI3M0fVk0awkY22NQ2Np6T7
         Zpvtkp2YvV02CrWV+rWKa/CXaX5u9BzRouxz21YptSC1rLICvny+zc5gwS2f3TEaWpUQ
         mqcSORCkIxpr0JDASc55Sep4Rnm7//4QcLAPybJBjW+OZcpsF4wqjf1TnnNRh4exxg2E
         rtVw4k7X+JH7GW/Um39PgJS7w6MjIp8eLwMBSHenFJnCbvp5XNVWuJUegAn3sZbywBe1
         TxQQ==
X-Gm-Message-State: AOJu0YzLGjBqVjhLHNhSll2vTJ9m2E0qn9Hjnib1j/3AR+qK2wBlTgJl
	M2lAuazPGKr2RDXkS7DcC+hOjk4jO3MzktlmKyg=
X-Google-Smtp-Source: AGHT+IHEQbQKDe8LZI8hD3vy2YVk1aTnCS615hOJnwxGT9PKd2Vc2radk/Uw2Cm0lySrjxcR7yiXVY4Tbcgyou67tQ4=
X-Received: by 2002:a6b:e40a:0:b0:7b3:7491:1dee with SMTP id
 u10-20020a6be40a000000b007b374911deemr13877445iog.10.1701212654841; Tue, 28
 Nov 2023 15:04:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127193703.1980089-1-nphamcs@gmail.com> <20231127193703.1980089-7-nphamcs@gmail.com>
 <20231127130055.30c455906d912e09dcb7e79b@linux-foundation.org>
In-Reply-To: <20231127130055.30c455906d912e09dcb7e79b@linux-foundation.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 28 Nov 2023 15:04:03 -0800
Message-ID: <CAKEwX=PCqwUCb+Gm8CYLNkVE2s5KJ-OQq4y3hx+xr=d3y3_RTQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] zswap: shrinks zswap pool based on memory pressure
To: Andrew Morton <akpm@linux-foundation.org>
Cc: hannes@cmpxchg.org, cerasuolodomenico@gmail.com, yosryahmed@google.com, 
	sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com, 
	muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 1:00=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 27 Nov 2023 11:37:03 -0800 Nhat Pham <nphamcs@gmail.com> wrote:
>
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
> >
> > ...
> >
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -22,6 +22,7 @@
> >  #include <linux/mm_types.h>
> >  #include <linux/page-flags.h>
> >  #include <linux/local_lock.h>
> > +#include <linux/zswap.h>
> >  #include <asm/page.h>
> >
> >  /* Free memory management - zoned buddy allocator.  */
> > @@ -641,6 +642,7 @@ struct lruvec {
> >  #ifdef CONFIG_MEMCG
> >       struct pglist_data *pgdat;
> >  #endif
> > +     struct zswap_lruvec_state zswap_lruvec_state;
>
> Normally we'd put this in #ifdef CONFIG_ZSWAP.
>
> > --- a/include/linux/zswap.h
> > +++ b/include/linux/zswap.h
> > @@ -5,20 +5,40 @@
> >  #include <linux/types.h>
> >  #include <linux/mm_types.h>
> >
> > +struct lruvec;
> > +
> >  extern u64 zswap_pool_total_size;
> >  extern atomic_t zswap_stored_pages;
> >
> >  #ifdef CONFIG_ZSWAP
> >
> > +struct zswap_lruvec_state {
> > +     /*
> > +      * Number of pages in zswap that should be protected from the shr=
inker.
> > +      * This number is an estimate of the following counts:
> > +      *
> > +      * a) Recent page faults.
> > +      * b) Recent insertion to the zswap LRU. This includes new zswap =
stores,
> > +      *    as well as recent zswap LRU rotations.
> > +      *
> > +      * These pages are likely to be warm, and might incur IO if the a=
re written
> > +      * to swap.
> > +      */
> > +     atomic_long_t nr_zswap_protected;
> > +};
> > +
> >  bool zswap_store(struct folio *folio);
> >  bool zswap_load(struct folio *folio);
> >  void zswap_invalidate(int type, pgoff_t offset);
> >  void zswap_swapon(int type);
> >  void zswap_swapoff(int type);
> >  void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg);
> > -
> > +void zswap_lruvec_state_init(struct lruvec *lruvec);
> > +void zswap_lruvec_swapin(struct page *page);
> >  #else
> >
> > +struct zswap_lruvec_state {};
>
> But instead you made it an empty struct in this case.
>
> That's a bit funky, but I guess OK.  It does send a careful reader of
> struct lruvec over to look at the zswap_lruvec_state definition to
> understand what's going on.

I agree.

Originally, I included the fields in struct lruvec itself, guarded by
a #ifdef CONFIG_ZSWAP as you pointed out here. Yosry gave me this
suggestion to hide the zswap-specific states and details from ordinary
lruvec user, and direct people who care and/or need to know about
details towards the zswap codebase, which is good IMHO.

It is a bit weird I admit, but in this case I think it works out.

>
> >  static inline bool zswap_store(struct folio *folio)
> >  {
> >       return false;
> > @@ -33,7 +53,8 @@ static inline void zswap_invalidate(int type, pgoff_t=
 offset) {}
> >  static inline void zswap_swapon(int type) {}
> >  static inline void zswap_swapoff(int type) {}
> >  static inline void zswap_memcg_offline_cleanup(struct mem_cgroup *memc=
g) {}
> > -
> > +static inline void zswap_lruvec_init(struct lruvec *lruvec) {}
> > +static inline void zswap_lruvec_swapin(struct page *page) {}
>
> Needed this build fix:
>
> --- a/include/linux/zswap.h~zswap-shrinks-zswap-pool-based-on-memory-pres=
sure-fix
> +++ a/include/linux/zswap.h
> @@ -54,6 +54,7 @@ static inline void zswap_swapon(int type
>  static inline void zswap_swapoff(int type) {}
>  static inline void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)=
 {}
>  static inline void zswap_lruvec_init(struct lruvec *lruvec) {}
> +static inline void zswap_lruvec_state_init(struct lruvec *lruvec) {}
>  static inline void zswap_lruvec_swapin(struct page *page) {}
>  #endif
>
> _
>

Yeah that looks like a typo on my part. My bad. v7 includes this fix.

