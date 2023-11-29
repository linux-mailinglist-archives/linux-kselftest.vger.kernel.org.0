Return-Path: <linux-kselftest+bounces-836-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F277FDCE3
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 17:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E1C1C208C2
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 16:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBA13A8EE;
	Wed, 29 Nov 2023 16:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="oczT/7yN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA71BD7F
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Nov 2023 08:21:56 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-67a34fbaf12so23929206d6.3
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Nov 2023 08:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1701274916; x=1701879716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hYHLv9CSAfTThewWoacMTkgj93sBj76qjRtYqdHw6QM=;
        b=oczT/7yNyh2rO2+7Z2ZVrnrrRD6hoAnih2ZVATXEbWprimOauqiUxqBSSikHAUTivz
         qNzZEic2KGFZmNoMXcNva4w1+GHOGVpTsihm5aOpN2xls3bhXDn2c4IlEm2UzuLMzVlF
         /X4VkDvU0oXFoeFNdYCsnxllbNUy79mj/O1p8QW7RzNSnvJ6TA8Hndix9jm8lmYhrE2o
         +lz2X2SCA9qvQuO8xUHF2Epm1wgGHMB1b9t1rHD3+iuQ+sC6mTRTm94Y5dMxl4B8BzUY
         QVdab3hzh0OfMkziuJTW74gffSal0jYV5unfwo++rkSmKFcB1tssNiihW24TIpnPJJUw
         GbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701274916; x=1701879716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYHLv9CSAfTThewWoacMTkgj93sBj76qjRtYqdHw6QM=;
        b=dZRXem7ZsOTLmfklbcch0+aPyEIK9IiehoE/L/m5OK6pXeog8vED59KsDN1QA93hoS
         wnDrNtODbqlKgBKccju0kVYgdIGR5WHEqQ5AQi29FzpWgoPeBlRzPdHVjoqoBz47JgiG
         EwfZmjU8IEqNany6orjkQZ6xJrXuZxVF6havrcNxOvyGtSLAFA5XoHu6bPmkKvTeA7kx
         5PRGRzUGIwDz+Mypd1fWGAGKKAhEXKsgO5v+77wqsXIAc2v6YBwzQ9SK5wh4Nc3YVotU
         Hj3+b/RoZheFveMi+JLuRAeg9zwWRNn3/oCZSP67EdE9+y3JXNrbvLWIhdiOam1TL7JN
         Tglw==
X-Gm-Message-State: AOJu0YxOKFmod6tGCESaFas8dCT6cgDC2rg7TKZiK1Bz5T0JSBQWFtrU
	0ggiCztp0DgWxGj0lWuF9Ax1pQ==
X-Google-Smtp-Source: AGHT+IExE8UXik9bRCJxcJyoMa34oV6Hn3YLIHwRECfowsGDeobteC5UhV2ag8pFjY+6iqyHgOuSyg==
X-Received: by 2002:a05:6214:86:b0:67a:2b0b:c591 with SMTP id n6-20020a056214008600b0067a2b0bc591mr16240106qvr.25.1701274915900;
        Wed, 29 Nov 2023 08:21:55 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id k14-20020ad4450e000000b0067a26d7ce6fsm4550774qvu.55.2023.11.29.08.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 08:21:55 -0800 (PST)
Date: Wed, 29 Nov 2023 11:21:50 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, cerasuolodomenico@gmail.com,
	yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
	vitaly.wool@konsulko.com, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeelb@google.com,
	muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
	kernel-team@meta.com, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v7 6/6] zswap: shrinks zswap pool based on memory pressure
Message-ID: <20231129162150.GE135852@cmpxchg.org>
References: <20231127234600.2971029-1-nphamcs@gmail.com>
 <20231127234600.2971029-7-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127234600.2971029-7-nphamcs@gmail.com>

On Mon, Nov 27, 2023 at 03:46:00PM -0800, Nhat Pham wrote:
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
> 
> As a proof of concept, we ran the following synthetic benchmark:
> build the linux kernel in a memory-limited cgroup, and allocate some
> cold data in tmpfs to see if the shrinker could write them out and
> improved the overall performance. Depending on the amount of cold data
> generated, we observe from 14% to 35% reduction in kernel CPU time used
> in the kernel builds.

I think this is a really important piece of functionality for zswap.

Memory compression has been around and in use for a long time, but the
question of zswap vs swap sizing has been in the room since the hybrid
mode was first proposed. Because depending on the reuse patterns,
putting zswap with a static size limit in front of an existing swap
file can be a net negative for performance as it consumes more memory.

It's great to finally see a solution to this which makes zswap *much*
more general purpose. And something that distributions might want to
turn on per default when swap is configured.

Actually to the point where I think there should be a config option to
enable the shrinker per default. Maybe not right away, but in a few
releases when this feature has racked up some more production time.

> @@ -687,6 +687,7 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
>  					&page_allocated, false);
>  	if (unlikely(page_allocated))
>  		swap_readpage(page, false, NULL);
> +	zswap_lruvec_swapin(page);

The "lruvec" in the name vs the page parameter is a bit odd.
zswap_page_swapin() would be slightly better, but it still also sounds
like it would cause an actual swapin of some sort.

zswap_record_swapin()?

> @@ -520,6 +575,95 @@ static struct zswap_entry *zswap_entry_find_get(struct rb_root *root,
>  	return entry;
>  }
>  
> +/*********************************
> +* shrinker functions
> +**********************************/
> +static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_one *l,
> +				       spinlock_t *lock, void *arg);
> +
> +static unsigned long zswap_shrinker_scan(struct shrinker *shrinker,
> +		struct shrink_control *sc)
> +{
> +	struct lruvec *lruvec = mem_cgroup_lruvec(sc->memcg, NODE_DATA(sc->nid));
> +	unsigned long shrink_ret, nr_protected, lru_size;
> +	struct zswap_pool *pool = shrinker->private_data;
> +	bool encountered_page_in_swapcache = false;
> +
> +	nr_protected =
> +		atomic_long_read(&lruvec->zswap_lruvec_state.nr_zswap_protected);
> +	lru_size = list_lru_shrink_count(&pool->list_lru, sc);
> +
> +	/*
> +	 * Abort if the shrinker is disabled or if we are shrinking into the
> +	 * protected region.
> +	 */
> +	if (!zswap_shrinker_enabled || nr_protected >= lru_size - sc->nr_to_scan) {
> +		sc->nr_scanned = 0;
> +		return SHRINK_STOP;
> +	}

I'm scratching my head at the protection check. zswap_shrinker_count()
already factors protection into account, so sc->nr_to_scan should only
be what is left on the list after excluding the protected area.

Do we even get here if the whole list is protected? Is this to protect
against concurrent shrinking of the list through multiple shrinkers or
swapins? If so, a comment would be nice :)

Otherwise, this looks great to me!

Just nitpicks, no show stoppers:

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

