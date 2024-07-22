Return-Path: <linux-kselftest+bounces-13998-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B652593938C
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 20:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C85F281F07
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 18:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A338116F8EB;
	Mon, 22 Jul 2024 18:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DTQgatXS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034E8161306
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Jul 2024 18:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721672532; cv=none; b=oFBg22SHimW6oOGzPOunqM5sRAisBLlc7xNSSTPtD9ZiyxTeD20dHswsbI5gZ4NDdXN28VDV+EVWNOynoN+1mWMp3G6yTVDGMCQnXPUu/cP6uMMacxQ0fBqgPbbzmuprUskFssZqxerS+v+8dnyWxZB0rIEC/mXzFyqqoUo9Pzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721672532; c=relaxed/simple;
	bh=eD/vGSMW9E9yApCd3as75PJvXqdNLbubHQ6IJWLk8as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMiV+XcEPJDOSjaow2Oxxxh+3dIcnN49pUYuO8+Im4c7Lg98eohD9cpjUl6z6Cyj9/tg/XnUrDIKr1UeYIA3bLZrnNM6UruAnjQdpD2t1LnAeTmChYpQatyjJHzOsxlgJfTTF38z/4mV4qJXR+PLhEUFa7SosrW1AZFCIum9O/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DTQgatXS; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: davidf@vimeo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721672528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V7pwB9XrcxVAmUU/h+WiFWkXrU74G5bm5uVjWBQba2o=;
	b=DTQgatXSa6ot1SpRnX6EsaA2vI8YDMfmdZkEPWUzfW6NBaM5RylQlurxK5H0MHiaA9UKQK
	3eE3CR4PwqN/7MUEzcMMPZZM45LYjyeCmNsAfDupxU4A3VwFjaP8EAOkqauJLPZs/AQm2t
	GzqrHqoavVCLLo6ozvU3B0nSr6R7SyQ=
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: tj@kernel.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: core-services@vimeo.com
X-Envelope-To: corbet@lwn.net
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: shuah@kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: lizefan.x@bytedance.com
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: linux-doc@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kselftest@vger.kernel.org
Date: Mon, 22 Jul 2024 18:22:02 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: David Finkel <davidf@vimeo.com>
Cc: Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, core-services@vimeo.com,
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Shuah Khan <shuah@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
Message-ID: <Zp6jSoB14boeGhWH@google.com>
References: <20240722151713.2724855-1-davidf@vimeo.com>
 <20240722151713.2724855-2-davidf@vimeo.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722151713.2724855-2-davidf@vimeo.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jul 22, 2024 at 11:17:13AM -0400, David Finkel wrote:
> Other mechanisms for querying the peak memory usage of either a process
> or v1 memory cgroup allow for resetting the high watermark. Restore
> parity with those mechanisms, but with a less racy API.
> 
> For example:
>  - Any write to memory.max_usage_in_bytes in a cgroup v1 mount resets
>    the high watermark.
>  - writing "5" to the clear_refs pseudo-file in a processes's proc
>    directory resets the peak RSS.
> 
> This change is an evolution of a previous patch, which mostly copied the
> cgroup v1 behavior, however, there were concerns about races/ownership
> issues with a global reset, so instead this change makes the reset
> filedescriptor-local.
> 
> Writing a specific string to the memory.peak and memory.swap.peak
> pseudo-files reset the high watermark to the current usage for
> subsequent reads through that same fd.
> 
> Notably, following Johannes's suggestion, this implementation moves the
> O(fds that have written) behavior onto the fd write(2) path. Instead, on
> the page-allocation path, we simply add one additional watermark to
> conditionally bump per-hierarchy level in the page-counter.
> 
> This behavior is particularly useful for work scheduling systems that
> need to track memory usage of worker processes/cgroups per-work-item.
> Since memory can't be squeezed like CPU can (the OOM-killer has
> opinions), these systems need to track the peak memory usage to compute
> system/container fullness when binpacking workitems.
> 
> Most notably, Vimeo's use-case involves a system that's doing global
> binpacking across many Kubernetes pods/containers, and while we can use
> PSI for some local decisions about overload, we strive to avoid packing
> workloads too tightly in the first place. To facilitate this, we track
> the peak memory usage. However, since we run with long-lived workers (to
> amortize startup costs) we need a way to track the high watermark while
> a work-item is executing. Polling runs the risk of missing short spikes
> that last for timescales below the polling interval, and peak memory
> tracking at the cgroup level is otherwise perfect for this use-case.
> 
> As this data is used to ensure that binpacked work ends up with
> sufficient headroom, this use-case mostly avoids the inaccuracies
> surrounding reclaimable memory.
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: David Finkel <davidf@vimeo.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst       |  26 +-
>  include/linux/cgroup.h                        |   7 +
>  include/linux/memcontrol.h                    |   5 +
>  include/linux/page_counter.h                  |   6 +
>  kernel/cgroup/cgroup-internal.h               |   2 +
>  kernel/cgroup/cgroup.c                        |   7 +
>  mm/memcontrol.c                               | 165 ++++++++++++-
>  mm/page_counter.c                             |   4 +
>  tools/testing/selftests/cgroup/cgroup_util.c  |  22 ++
>  tools/testing/selftests/cgroup/cgroup_util.h  |   2 +
>  .../selftests/cgroup/test_memcontrol.c        | 227 +++++++++++++++++-
>  11 files changed, 448 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 8fbb0519d556..10a2f919128f 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1322,11 +1322,16 @@ PAGE_SIZE multiple when read back.
>  	reclaim induced by memory.reclaim.
>  
>    memory.peak
> -	A read-only single value file which exists on non-root
> -	cgroups.
> +	A read-write single value file which exists on non-root cgroups.
> +
> +	The max memory usage recorded for the cgroup and its descendants since
> +	either the creation of the cgroup or the most recent reset for that fd.
>  
> -	The max memory usage recorded for the cgroup and its
> -	descendants since the creation of the cgroup.
> +	A write of the string "fd_local_reset" to this file resets it to the
> +	current memory usage for subsequent reads through the same

Hi David!

Not a very strong preference, but with the current design, do we really expect
to have a non-local reset? If not, can we agree on a "reset" string instead
for a sake of simplicity?

> +	file descriptor.
> +	Attempts to write any other string will return EINVAL
> +	(modulo leading and trailing whitespace).
>  
>    memory.oom.group
>  	A read-write single value file which exists on non-root
> @@ -1652,11 +1657,16 @@ PAGE_SIZE multiple when read back.
>  	Healthy workloads are not expected to reach this limit.
>  
>    memory.swap.peak
> -	A read-only single value file which exists on non-root
> -	cgroups.
> +	A read-write single value file which exists on non-root cgroups.
> +
> +	The max swap usage recorded for the cgroup and its descendants since
> +	the creation of the cgroup or the most recent reset for that fd.
>  
> -	The max swap usage recorded for the cgroup and its
> -	descendants since the creation of the cgroup.
> +	A write of the string "fd_local_reset" to this file resets it to the
> +	current memory usage for subsequent reads through the same
> +	file descriptor.
> +	Attempts to write any other string will return EINVAL
> +	(modulo leading and trailing whitespace).
>  
>    memory.swap.max
>  	A read-write single value file which exists on non-root
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index 2150ca60394b..9bda441227ea 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -855,4 +855,11 @@ static inline void cgroup_bpf_put(struct cgroup *cgrp) {}
>  
>  struct cgroup *task_get_cgroup1(struct task_struct *tsk, int hierarchy_id);
>  
> +struct memcg_peak_mem_ctx {
> +	long				local_watermark;
> +	struct memcg_peak_mem_ctx	*next, *prev;

Please, take a look at include/linux/list.h and use it instead of
re-implementing list operations from scratch.

> +};
> +
> +struct memcg_peak_mem_ctx *memcg_extract_peak_mem_ctx(struct kernfs_open_file *of);
> +
>  #endif /* _LINUX_CGROUP_H */
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 030d34e9d117..6be7507c6fd3 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -198,6 +198,11 @@ struct mem_cgroup {
>  	struct page_counter kmem;		/* v1 only */
>  	struct page_counter tcpmem;		/* v1 only */
>  
> +	/* lists of memcg peak watching contexts on swap and memory */
> +	struct memcg_peak_mem_ctx *peak_memory_local_watermark_watchers;
> +	struct memcg_peak_mem_ctx *peak_swap_local_watermark_watchers;
> +	spinlock_t pagecounter_peak_watchers_lock;
> +
>  	/* Range enforcement for interrupt charges */
>  	struct work_struct high_work;
>  
> diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
> index 8cd858d912c4..047ceaece258 100644
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
> @@ -81,4 +82,9 @@ static inline void page_counter_reset_watermark(struct page_counter *counter)
>  	counter->watermark = page_counter_read(counter);
>  }
>  
> +static inline void page_counter_reset_local_watermark(struct page_counter *counter)
> +{
> +	counter->local_watermark = page_counter_read(counter);
> +}
> +
>  #endif /* _LINUX_PAGE_COUNTER_H */
> diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
> index 520b90dd97ec..5a97ba08e976 100644
> --- a/kernel/cgroup/cgroup-internal.h
> +++ b/kernel/cgroup/cgroup-internal.h
> @@ -81,6 +81,8 @@ struct cgroup_file_ctx {
>  	struct {
>  		struct cgroup_pidlist	*pidlist;
>  	} procs1;
> +
> +	struct memcg_peak_mem_ctx peak;
>  };
>  
>  /*
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index e32b6972c478..38b935ffa6cf 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -1964,6 +1964,13 @@ static int cgroup2_parse_param(struct fs_context *fc, struct fs_parameter *param
>  	return -EINVAL;
>  }
>  
> +struct memcg_peak_mem_ctx *memcg_extract_peak_mem_ctx(struct kernfs_open_file *of)
> +{
> +	struct cgroup_file_ctx *ctx = of->priv;
> +
> +	return &ctx->peak;
> +}
> +
>  static void apply_cgroup_root_flags(unsigned int root_flags)
>  {
>  	if (current->nsproxy->cgroup_ns == &init_cgroup_ns) {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 8f2f1bb18c9c..eb6614236371 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -25,6 +25,7 @@
>   * Copyright (C) 2020 Alibaba, Inc, Alex Shi
>   */
>  
> +#include <linux/cgroup-defs.h>
>  #include <linux/page_counter.h>
>  #include <linux/memcontrol.h>
>  #include <linux/cgroup.h>
> @@ -5745,6 +5746,7 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
>  	vmpressure_init(&memcg->vmpressure);
>  	INIT_LIST_HEAD(&memcg->event_list);
>  	spin_lock_init(&memcg->event_list_lock);
> +	spin_lock_init(&memcg->pagecounter_peak_watchers_lock);
>  	memcg->socket_pressure = jiffies;
>  #ifdef CONFIG_MEMCG_KMEM
>  	memcg->kmemcg_id = -1;
> @@ -6907,12 +6909,130 @@ static u64 memory_current_read(struct cgroup_subsys_state *css,
>  	return (u64)page_counter_read(&memcg->memory) * PAGE_SIZE;
>  }
>  
> -static u64 memory_peak_read(struct cgroup_subsys_state *css,
> -			    struct cftype *cft)
> +static struct page_counter *memcg_memory_extract_page_counter(struct mem_cgroup *memcg)
>  {
> +	return &memcg->memory;
> +}
> +
> +static struct memcg_peak_mem_ctx **memcg_memory_extract_peak_watchers(struct mem_cgroup *memcg)
> +{
> +	return &memcg->peak_memory_local_watermark_watchers;
> +}
> +
> +inline int swap_memory_peak_show(
> +	struct seq_file *sf, void *v,
> +	struct page_counter *(*extract_pc)(struct mem_cgroup *memcg))
> +{
> +	struct cgroup_subsys_state *css = seq_css(sf);
>  	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
> +	struct page_counter *pc = extract_pc(memcg);
> +
> +	struct kernfs_open_file *of = sf->private;
> +	struct memcg_peak_mem_ctx *ctx = memcg_extract_peak_mem_ctx(of);
> +	s64 fd_peak = ctx->local_watermark;
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
> +
> +static int memory_peak_show(struct seq_file *sf, void *v)
> +{
> +	return swap_memory_peak_show(sf, v, memcg_memory_extract_page_counter);

I think it's really too complex. Why not pass a single boolean argument
which will define to use memory page_counter or swap page_counter?
It will eliminate a need to pass pointers to functions and also eliminate
a need for introducing these helper functions in general.

> +}
> +
> +static int swap_memory_peak_open(struct kernfs_open_file *of)
> +{
> +	struct memcg_peak_mem_ctx *ctx = memcg_extract_peak_mem_ctx(of);
> +
> +	ctx->local_watermark = -1;
> +	return 0;
> +}
> +
> +inline void swap_memory_peak_release(
> +	struct kernfs_open_file *of,
> +	struct memcg_peak_mem_ctx **(*extract_watchers)(struct mem_cgroup *memcg))
> +{
> +	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
> +	struct memcg_peak_mem_ctx *ctx = memcg_extract_peak_mem_ctx(of);
> +
> +	if (ctx->local_watermark == -1) {
> +		/* fast path (no writes on this fd)*/
> +		return;
> +	}
> +	spin_lock(&memcg->pagecounter_peak_watchers_lock);
> +	if (ctx->next) {
> +		ctx->next->prev = ctx->prev;
> +	}
> +	if (ctx->prev) {
> +		ctx->prev->next = ctx->next;
> +	} else {
> +		struct memcg_peak_mem_ctx **watchers = extract_watchers(memcg);
> +
> +		*watchers = ctx->next;
> +	}
> +	spin_unlock(&memcg->pagecounter_peak_watchers_lock);
> +}
>  
> -	return (u64)memcg->memory.watermark * PAGE_SIZE;
> +static void memory_peak_release(struct kernfs_open_file *of)
> +{
> +	swap_memory_peak_release(of, memcg_memory_extract_peak_watchers);
> +}
> +
> +inline ssize_t swap_memory_peak_write(
> +	struct kernfs_open_file *of,
> +	char *buf, size_t nbytes, loff_t off,
> +	struct page_counter* (*extract_pc)(struct mem_cgroup *memcg),
> +	struct memcg_peak_mem_ctx **(*extract_watchers)(struct mem_cgroup *memcg))
> +{
> +	buf = strstrip(buf);
> +	/* Only allow "fd_local_reset" to keep the API clear */
> +	if (strcmp(buf, "fd_local_reset"))
> +		return -EINVAL;
> +	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
> +	struct memcg_peak_mem_ctx *ctx = memcg_extract_peak_mem_ctx(of);

Please, don't mix variable definitions and code. Also, please, use
scripts/checkpatch.pl for checking the code before submission. I guess
it will raise several issues in this patch.

> +
> +	spin_lock(&memcg->pagecounter_peak_watchers_lock);
> +
> +	struct page_counter *pc = extract_pc(memcg);
> +
> +	page_counter_reset_local_watermark(pc);
> +	const unsigned long cur = pc->local_watermark;
> +	struct memcg_peak_mem_ctx **watchers = extract_watchers(memcg);
> +	struct memcg_peak_mem_ctx *peer_ctx;
> +
> +	for (peer_ctx = *watchers; peer_ctx; peer_ctx = peer_ctx->next) {
> +		if (cur > peer_ctx->local_watermark)
> +			peer_ctx->local_watermark = cur;
> +	}
> +	if (ctx->local_watermark == -1) {
> +		/* only append to the list if we're not already there */
> +		if (peer_ctx) {
> +			ctx->prev = peer_ctx;
> +			peer_ctx->next = ctx;
> +		} else {
> +			*watchers = ctx;
> +		}
> +	}
> +	ctx->local_watermark = cur;
> +	spin_unlock(&memcg->pagecounter_peak_watchers_lock);
> +
> +	return nbytes;
> +}
> +
> +static ssize_t memory_peak_write(struct kernfs_open_file *of, char *buf,
> +				 size_t nbytes, loff_t off)
> +{
> +	return swap_memory_peak_write(of, buf, nbytes, off,
> +				      memcg_memory_extract_page_counter,
> +				      memcg_memory_extract_peak_watchers);
>  }
>  
>  static int memory_min_show(struct seq_file *m, void *v)
> @@ -7231,7 +7351,10 @@ static struct cftype memory_files[] = {
>  	{
>  		.name = "peak",
>  		.flags = CFTYPE_NOT_ON_ROOT,
> -		.read_u64 = memory_peak_read,
> +		.open = swap_memory_peak_open,
> +		.release = memory_peak_release,
> +		.seq_show = memory_peak_show,
> +		.write = memory_peak_write,
>  	},
>  	{
>  		.name = "min",
> @@ -8193,14 +8316,35 @@ static u64 swap_current_read(struct cgroup_subsys_state *css,
>  	return (u64)page_counter_read(&memcg->swap) * PAGE_SIZE;
>  }
>  
> -static u64 swap_peak_read(struct cgroup_subsys_state *css,
> -			  struct cftype *cft)
> +
> +static struct page_counter *memcg_swap_extract_page_counter(struct mem_cgroup *memcg)
> +{
> +	return &memcg->swap;
> +}
> +
> +static struct memcg_peak_mem_ctx **memcg_swap_extract_peak_watchers(struct mem_cgroup *memcg)
>  {
> -	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
> +	return &memcg->peak_swap_local_watermark_watchers;
> +}
> +
> +static int swap_peak_show(struct seq_file *sf, void *v)
> +{
> +	return swap_memory_peak_show(sf, v, memcg_swap_extract_page_counter);
> +}
>  
> -	return (u64)memcg->swap.watermark * PAGE_SIZE;
> +static ssize_t swap_peak_write(struct kernfs_open_file *of, char *buf,
> +			       size_t nbytes, loff_t off)
> +{
> +	return swap_memory_peak_write(of, buf, nbytes, off,
> +				      memcg_swap_extract_page_counter,
> +				      memcg_swap_extract_peak_watchers);
> +}
> +static void swap_peak_release(struct kernfs_open_file *of)
> +{
> +	swap_memory_peak_release(of, memcg_swap_extract_peak_watchers);
>  }
>  
> +
>  static int swap_high_show(struct seq_file *m, void *v)
>  {
>  	return seq_puts_memcg_tunable(m,
> @@ -8282,7 +8426,10 @@ static struct cftype swap_files[] = {
>  	{
>  		.name = "swap.peak",
>  		.flags = CFTYPE_NOT_ON_ROOT,
> -		.read_u64 = swap_peak_read,
> +		.open = swap_memory_peak_open,
> +		.release = swap_peak_release,
> +		.seq_show = swap_peak_show,
> +		.write = swap_peak_write,
>  	},
>  	{
>  		.name = "swap.events",
> diff --git a/mm/page_counter.c b/mm/page_counter.c
> index db20d6452b71..40d5f4990218 100644
> --- a/mm/page_counter.c
> +++ b/mm/page_counter.c
> @@ -82,6 +82,8 @@ void page_counter_charge(struct page_counter *counter, unsigned long nr_pages)
>  		 */
>  		if (new > READ_ONCE(c->watermark))
>  			WRITE_ONCE(c->watermark, new);
> +		if (new > READ_ONCE(c->local_watermark))
> +			WRITE_ONCE(c->local_watermark, new);

Hm, can't we have a single comparison on the hot path?
Also, we read and write c->local_watermark speculatively here, Idk if it's still
acceptable with an ability to reset watermarks "locally". Maybe it is, but
it definitely deserves at least a comment with an explanation.

And btw thank you for including tests into the commit, it's really great to see.
I'd suggest you to extract them into a separate commit and post it as a series.

Thank you!

