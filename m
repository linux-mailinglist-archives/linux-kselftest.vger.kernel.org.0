Return-Path: <linux-kselftest+bounces-14083-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C727793A2BF
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 16:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E46C283EAB
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 14:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C924154BE0;
	Tue, 23 Jul 2024 14:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="MVW7s8Vu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94535154449
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Jul 2024 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721744999; cv=none; b=ffwLUUFUBVCzA4UnUELKuykq6CQXbZtXnZ5nhonVNHwuo7rLTolHpO6YN6u83KDHSqPgvn4eYXMX2hM4Wv0+gzRne6aqZE/6jkQe2ZIygau3rJCvm41kk7QOh4WEI5oo8lICRi2VzEgP6P0PCrMXBnn5w2gW50ZsrW/9np+C9lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721744999; c=relaxed/simple;
	bh=E5EM6Cguo14Xt7RDH+bDU+nKhuhaz+MtYEJdPW2niJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhTZ8jgOGz2i2yYqJwdFskaEJXFkZrY1xidh9Vkj8lkSUKf2kxNgD/kWP+HC7uB3ty6If9G5VWaXExwOZhAmjlehKiDmpla4VRa0BOtVv7GRs1TqffaZKNj4Up341C4sXkjqyJnZY37t2wRwTmPtkea55jNexZ9IaU8eIuOBd3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=MVW7s8Vu; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-703631c4930so2872924a34.1
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jul 2024 07:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1721744995; x=1722349795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pOAklqx8oFvo8x3kYelMrVZA/e8PS7D7KCs7XOSGQQg=;
        b=MVW7s8VuKJvaDigTkER4KTtAnSou56eSU+aHewQ6UpgRFasXGMd5hFkwMLd2tiKrwR
         9cirn8qyX6n+OMOBTtdr4AuhVcTK0yQQvY/ciu5w+iK/ANLfB0iaQ9c5Yf8m5EiKXRba
         tzQbD4YDYpEdDnVk9qUhTcpoqT0lq37sC+0yRVwlPQTdX8XgC/Uqtc6y6huUnu2b2Y79
         WNi5fWxbJNz+kNN91vkvhvGii34MauBQ2Y1BQ7u2Ry3rEh1ZjFDhjsuP/a4NjrdopsPJ
         ii+zMjxzY4gUA02e+4DwDSBfqVrHrlnCyVNO5ODueaFZwsRc764vny5EUqgWa/qCEqHb
         MBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721744995; x=1722349795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOAklqx8oFvo8x3kYelMrVZA/e8PS7D7KCs7XOSGQQg=;
        b=KqB6Fe9E4z3IwGpBo4Vwvoy+ls6MtARKPSCc82DfiHN0cG6g4Eeeq+7YjQ8CRs/TAy
         RKSZjFN9jOwt09dPA1WNpEbwza02r9rVd/QEpIx/3AbCgSceTHfTS3+M99b8zHCwr64P
         f4e5T8JsNI+VWfrpHnXNVX+t2btQffVGGnpCy8Mjuf/azvP3F2AZuv/NusyyGfrB45oO
         hSbXPq2xFuMP3jm/b7QS4gmtU6DUcdq6dPVsUyQfXg1E8e0KFAIX3HYnJVgfknyyUsjm
         R/IespZ3tKvEYSCYJc0HSy+4IlEaxe1mJAUtWz8W23iblv3IYSIyFe3xe6+5UHbeaA5i
         6a0g==
X-Forwarded-Encrypted: i=1; AJvYcCUbnzUQSuBrY7FOC4FWOKjZqUQYzYt/PFscI7+9Xaj3pswxJyZLK18NET10b1MSxVRnhekK/qf8Q9A3HNGZdOu0oujNcOi61rY0O9KMKoP5
X-Gm-Message-State: AOJu0YzgrOxfSLVB9HnjM2DWwdlxr18eLTpm2vwy2PkDPMmi4mwSFtHk
	CHpZ6w6MlEmB42QzMSFTic19HwAF6P6/piGi7m+pMJxl1uphkacyDgFOd7kT1SI=
X-Google-Smtp-Source: AGHT+IF3YHQUIJ8+SrZCGjkIAJzBT6BuX2rBtMjYzpxW0sLMa2dAZBOXVVA0gqNSq/4rVrK8BpqhKQ==
X-Received: by 2002:a05:6830:6681:b0:703:884d:2fc7 with SMTP id 46e09a7af769-7091817df13mr4552774a34.24.1721744995346;
        Tue, 23 Jul 2024 07:29:55 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7acb07fd0sm47602486d6.130.2024.07.23.07.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 07:29:54 -0700 (PDT)
Date: Tue, 23 Jul 2024 10:29:50 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: David Finkel <davidf@vimeo.com>
Cc: Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, core-services@vimeo.com,
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Shuah Khan <shuah@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 1/2] mm, memcg: cg2 memory{.swap,}.peak write handlers
Message-ID: <20240723142950.GA389003@cmpxchg.org>
References: <20240722235554.2911971-1-davidf@vimeo.com>
 <20240722235554.2911971-2-davidf@vimeo.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722235554.2911971-2-davidf@vimeo.com>

Hi David,

thanks for pursuing this! A couple of comments below.

On Mon, Jul 22, 2024 at 07:55:53PM -0400, David Finkel wrote:
> @@ -1322,11 +1322,16 @@ PAGE_SIZE multiple when read back.
>  	reclaim induced by memory.reclaim.
>  
>    memory.peak
> -	A read-only single value file which exists on non-root
> -	cgroups.
> +	A read-write single value file which exists on non-root cgroups.
> +
> +	The max memory usage recorded for the cgroup and its descendants since
> +	either the creation of the cgroup or the most recent reset for that FD.
>  
> -	The max memory usage recorded for the cgroup and its
> -	descendants since the creation of the cgroup.
> +	A write of the string "reset" to this file resets it to the
> +	current memory usage for subsequent reads through the same
> +	file descriptor.
> +	Attempts to write any other non-empty string will return EINVAL
> +	(modulo leading and trailing whitespace).

Why not allow any write to reset? This makes it harder to use, and I'm
not sure accidental writes are a likely mistake to make.

> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index 2150ca60394b..7001ed74e339 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -12,6 +12,7 @@
>  #include <linux/sched.h>
>  #include <linux/cpumask.h>
>  #include <linux/nodemask.h>
> +#include <linux/list.h>
>  #include <linux/rculist.h>
>  #include <linux/cgroupstats.h>
>  #include <linux/fs.h>
> @@ -855,4 +856,11 @@ static inline void cgroup_bpf_put(struct cgroup *cgrp) {}
>  
>  struct cgroup *task_get_cgroup1(struct task_struct *tsk, int hierarchy_id);
>  
> +struct memcg_peak_mem_ctx {
> +	long				local_watermark;
> +	struct list_head		peers;
> +};

Since this is generic cgroup code, and can be conceivably used by
other controllers, let's keep the naming generic as well. How about:

struct cgroup_of_peak {
	long			value;
	struct list_head	list;
};

cgroup-defs.h would be a better place for it.

> +struct memcg_peak_mem_ctx *memcg_extract_peak_mem_ctx(struct kernfs_open_file *of);

of_peak()

> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 030d34e9d117..cbc390234605 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -198,6 +198,11 @@ struct mem_cgroup {
>  	struct page_counter kmem;		/* v1 only */
>  	struct page_counter tcpmem;		/* v1 only */
>  
> +	/* lists of memcg peak watching contexts on swap and memory */
> +	struct list_head peak_memory_local_watermark_watchers;
> +	struct list_head peak_swap_local_watermark_watchers;
> +	spinlock_t swap_memory_peak_watchers_lock;

These names are too long. How about:

	/* Registered local usage peak watchers */
	struct list_head	memory_peaks;
	struct list_head	swap_peaks;
	spinlock_t		peaks_lock;

> diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
> index 8cd858d912c4..06bb84218960 100644
> --- a/include/linux/page_counter.h
> +++ b/include/linux/page_counter.h
> @@ -26,6 +26,7 @@ struct page_counter {
>  	atomic_long_t children_low_usage;
>  
>  	unsigned long watermark;
> +	unsigned long local_watermark; /* track min of fd-local resets */
>  	unsigned long failcnt;
>  
>  	/* Keep all the read most fields in a separete cacheline. */
> @@ -78,7 +79,15 @@ int page_counter_memparse(const char *buf, const char *max,
>  
>  static inline void page_counter_reset_watermark(struct page_counter *counter)
>  {
> -	counter->watermark = page_counter_read(counter);
> +	unsigned long cur = page_counter_read(counter);

cur -> usage

> @@ -6907,12 +6912,109 @@ static u64 memory_current_read(struct cgroup_subsys_state *css,
>  	return (u64)page_counter_read(&memcg->memory) * PAGE_SIZE;
>  }
>  
> -static u64 memory_peak_read(struct cgroup_subsys_state *css,
> -			    struct cftype *cft)
> +inline int swap_memory_peak_show(
> +	struct seq_file *sf, void *v, bool swap_cg)
>  {

Leave inlining to the compiler. Just static int.

The name can be simply peak_show().

Customary coding style is to line wrap at the last parameter that
fits. Don't wrap if the line fits within 80 cols.

static int peak_show(struct seq_file *sf, void *v, ...,
		     ...)
{
	...
}

> +	struct cgroup_subsys_state *css = seq_css(sf);
>  	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
> +	struct page_counter *pc;
> +	struct kernfs_open_file *of = sf->private;
> +	struct memcg_peak_mem_ctx *ctx = memcg_extract_peak_mem_ctx(of);
> +	s64 fd_peak = ctx->local_watermark;
>  
> -	return (u64)memcg->memory.watermark * PAGE_SIZE;
> +	if (swap_cg)
> +		pc = &memcg->swap;
> +	else
> +		pc = &memcg->memory;
> +
> +	if (fd_peak == -1) {
> +		seq_printf(sf, "%llu\n", (u64)pc->watermark * PAGE_SIZE);
> +		return 0;
> +	}
> +
> +	s64 pc_peak = pc->local_watermark;
> +	s64 wm = fd_peak > pc_peak ? fd_peak : pc_peak;
> +
> +	seq_printf(sf, "%lld\n", wm * PAGE_SIZE);
> +	return 0;
> +}

As per Roman's feedback, don't mix decls and code.

You can simplify it by extracting css and memcg in the callers, then
pass the right struct page counter *pc directly.

That should eliminate most local variables as well.

static int peak_show(struct seq_file *sf, void *v, struct page_counter *pc)
{
	struct cgroup_of_peak *ofp = of_peak(sf->private);
	u64 peak;

	/* User wants global or local peak? */
	if (ofp->value == -1)
		peak = pc->watermark;
	else
		peak = max(ofp->value, pc->local_watermark);

	seq_printf(sf, "%lld\n", peak * PAGE_SIZE);
}

> +static int memory_peak_show(struct seq_file *sf, void *v)
> +{
> +	return swap_memory_peak_show(sf, v, false);

And then do:

	struct mem_cgroup *memcg = mem_cgroup_from_css(seq_css(sf));

	return peak_show(sf, v, &memcg->memory);

Then do the same with ... &memcg->swap.

> +inline ssize_t swap_memory_peak_write(
> +	struct kernfs_open_file *of,
> +	char *buf, size_t nbytes, loff_t off, bool swap_cg)
> +{

Same feedback as above. Please don't inline explicitly (unless it
really is measurably a performance improvement in a critical path),
and stick to surrounding coding style.

Here too, pass page_counter directly and save the branches.

> +	unsigned long cur;
> +	struct memcg_peak_mem_ctx *peer_ctx;
> +	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
> +	struct memcg_peak_mem_ctx *ctx = memcg_extract_peak_mem_ctx(of);
> +	struct page_counter *pc;
> +	struct list_head *watchers, *pos;
> +
> +	buf = strstrip(buf);
> +	/* Only allow "reset" to keep the API clear */
> +	if (strcmp(buf, "reset"))
> +		return -EINVAL;
> +
> +	if (swap_cg) {
> +		pc = &memcg->swap;
> +		watchers = &memcg->peak_swap_local_watermark_watchers;
> +	} else {
> +		pc = &memcg->memory;
> +		watchers = &memcg->peak_memory_local_watermark_watchers;
> +	}
> +
> +	spin_lock(&memcg->swap_memory_peak_watchers_lock);
> +
> +	page_counter_reset_local_watermark(pc);
> +	cur = pc->local_watermark;
> +
> +	list_for_each(pos, watchers) {

	list_for_each_entry()

> +		peer_ctx = list_entry(pos, typeof(*ctx), peers);
> +		if (cur > peer_ctx->local_watermark)
> +			peer_ctx->local_watermark = cur;
> +	}

I don't think this is quite right. local_peak could be higher than the
current usage when a new watcher shows up. The other watchers should
retain the higher local_peak, not the current usage.

> +
> +	if (ctx->local_watermark == -1)
> +		/* only append to the list if we're not already there */
> +		list_add_tail(&ctx->peers, watchers);
> +
> +	ctx->local_watermark = cur;

This makes me think that page_counter_reset_local_watermark() is not a
good helper. It obscures what's going on. Try without it.

AFAICS the list ordering doesn't matter, so keep it simple and use a
plain list_add().

	/*
	 * A new local peak is being tracked in pc->local_watermark.
	 * Save current local peak in all watchers.
	 */
	list_for_each_entry(pos, ...)
		if (pc->local_watermark > pos->value)
			pos->value = pc->local_watermark;

	pc->local_watermark = page_counter_read(pc);

	/* Initital write, register watcher */
	if (ofp->value == -1)
		list_add()

	ofp->value = pc->local_watermark;

> diff --git a/mm/page_counter.c b/mm/page_counter.c
> index db20d6452b71..724d31508664 100644
> --- a/mm/page_counter.c
> +++ b/mm/page_counter.c
> @@ -79,9 +79,22 @@ void page_counter_charge(struct page_counter *counter, unsigned long nr_pages)
>  		/*
>  		 * This is indeed racy, but we can live with some
>  		 * inaccuracy in the watermark.
> +		 *
> +		 * Notably, we have two watermarks to allow for both a globally
> +		 * visible peak and one that can be reset at a smaller scope.
> +		 *
> +		 * Since we reset both watermarks when the global reset occurs,
> +		 * we can guarantee that watermark >= local_watermark, so we
> +		 * don't need to do both comparisons every time.
> +		 *
> +		 * On systems with branch predictors, the inner condition should
> +		 * be almost free.
>  		 */
> -		if (new > READ_ONCE(c->watermark))
> -			WRITE_ONCE(c->watermark, new);
> +		if (new > READ_ONCE(c->local_watermark)) {
> +			WRITE_ONCE(c->local_watermark, new);
> +			if (new > READ_ONCE(c->watermark))
> +				WRITE_ONCE(c->watermark, new);
> +		}
>  	}
>  }
>  
> @@ -131,10 +144,23 @@ bool page_counter_try_charge(struct page_counter *counter,
>  		propagate_protected_usage(c, new);
>  		/*
>  		 * Just like with failcnt, we can live with some
> -		 * inaccuracy in the watermark.
> +		 * inaccuracy in the watermarks.
> +		 *
> +		 * Notably, we have two watermarks to allow for both a globally
> +		 * visible peak and one that can be reset at a smaller scope.
> +		 *
> +		 * Since we reset both watermarks when the global reset occurs,
> +		 * we can guarantee that watermark >= local_watermark, so we
> +		 * don't need to do both comparisons every time.
> +		 *
> +		 * On systems with branch predictors, the inner condition should
> +		 * be almost free.

		/* See comment in page_counter_charge() */

> diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
> index 432db923bced..1e2d46636a0c 100644
> --- a/tools/testing/selftests/cgroup/cgroup_util.c
> +++ b/tools/testing/selftests/cgroup/cgroup_util.c
> @@ -141,6 +141,16 @@ long cg_read_long(const char *cgroup, const char *control)
>  	return atol(buf);
>  }

This should be in patch #2.

