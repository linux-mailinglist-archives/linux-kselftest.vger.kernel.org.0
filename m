Return-Path: <linux-kselftest+bounces-14124-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD9D93AAC2
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 03:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD33B1F2343B
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 01:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA73DC8E9;
	Wed, 24 Jul 2024 01:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GMLJ9w7H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40C93D6A
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jul 2024 01:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721786137; cv=none; b=ioielgqRsHtzwxlx2kDZg34AWOWyI3gZ9BQ50+ifP90N2LA/bIWqi6rEHsGogVCTW5xizTzheuUyCyNKiu/tKbb530S+s8EsgmlbwOEBNavRA9MwMuvSW9eVrRQZw26SSXiW77IcuiWrdl4UVdi++hMT/k0QNPh7kRtWGEo5Eo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721786137; c=relaxed/simple;
	bh=YSV3AELW940LblRqbQXsJeV1QEzWEgmgn7ba9H+77h4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rKQFzV7MvTP0fv1efxxlrTRz2IWB5srkB0w8AN+wcr/9ePJt6+V7hhDBFSl20PdS7EqsDzfm4AMT4Nr2JnNeQPKg7BFDC4NuvqGX3JOIlOOvbcrzXWdcM+ZP8Xev9gR7jdfUX/68Mgwd7qeaQgc2duF9RVspoYHsGLHAXCKd/lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GMLJ9w7H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721786134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K5OU1tlVEf37yozw1Jzdh4onEtDz5GT0HzAdLDY6Fx4=;
	b=GMLJ9w7HYNE1WA/Ihl3pUrRhRLLWfKx3xRR0X3LwB8J6Ft0kMwpF+2RPV3QmMwuIm/bFE4
	CuQxEY7kQXw91f9yIh8FkrZotdHR6b6wz5G8gkOQNrTLFtcXyaRpzTWVg+wfVyZbwawssn
	x9hQUMMFe01pntDhMl07M3uQ/Qu58hU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-E8C6fW20MqeJSXc84qJx1g-1; Tue,
 23 Jul 2024 21:55:30 -0400
X-MC-Unique: E8C6fW20MqeJSXc84qJx1g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1466E1955EA7;
	Wed, 24 Jul 2024 01:55:24 +0000 (UTC)
Received: from [10.22.33.107] (unknown [10.22.33.107])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5239F1955DCD;
	Wed, 24 Jul 2024 01:55:20 +0000 (UTC)
Message-ID: <22a95c76-4e9e-482e-b95d-cb0f01971d98@redhat.com>
Date: Tue, 23 Jul 2024 21:55:19 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm, memcg: cg2 memory{.swap,}.peak write handlers
To: David Finkel <davidf@vimeo.com>, Muchun Song <muchun.song@linux.dev>,
 Tejun Heo <tj@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: core-services@vimeo.com, Jonathan Corbet <corbet@lwn.net>,
 Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Shuah Khan <shuah@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
References: <20240723233149.3226636-1-davidf@vimeo.com>
 <20240723233149.3226636-2-davidf@vimeo.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240723233149.3226636-2-davidf@vimeo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 7/23/24 19:31, David Finkel wrote:
> Other mechanisms for querying the peak memory usage of either a process
> or v1 memory cgroup allow for resetting the high watermark. Restore
> parity with those mechanisms, but with a less racy API.
>
> For example:
>   - Any write to memory.max_usage_in_bytes in a cgroup v1 mount resets
>     the high watermark.
>   - writing "5" to the clear_refs pseudo-file in a processes's proc
>     directory resets the peak RSS.
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
> Additionally, this takes Longman's suggestion of nesting the
> page-charging-path checks for the two watermarks to reduce the number of
> common-case comparisons.
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
> Suggested-by: Waiman Long <longman@redhat.com>
> Signed-off-by: David Finkel <davidf@vimeo.com>
> ---
>   Documentation/admin-guide/cgroup-v2.rst |  26 ++++--
>   include/linux/cgroup-defs.h             |   5 +
>   include/linux/cgroup.h                  |   3 +
>   include/linux/memcontrol.h              |   5 +
>   include/linux/page_counter.h            |   6 +-
>   kernel/cgroup/cgroup-internal.h         |   2 +
>   kernel/cgroup/cgroup.c                  |   7 ++
>   mm/memcontrol.c                         | 117 ++++++++++++++++++++++--
>   mm/page_counter.c                       |  30 ++++--
>   9 files changed, 174 insertions(+), 27 deletions(-)
Could you use the "-v <n>" option of git-format-patch to add a version 
number to the patch title? Without that, it can be confusing as to 
whether the patch is new or a resend of the previous one.
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 86311c2907cd3..01554cf6e55b4 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1333,11 +1333,16 @@ The following nested keys are defined.
>   	all the existing limitations and potential future extensions.
>   
>     memory.peak
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
>   
>     memory.oom.group
>   	A read-write single value file which exists on non-root
> @@ -1663,11 +1668,16 @@ The following nested keys are defined.
>   	Healthy workloads are not expected to reach this limit.
>   
>     memory.swap.peak
> -	A read-only single value file which exists on non-root
> -	cgroups.
> +	A read-write single value file which exists on non-root cgroups.
> +
> +	The max swap usage recorded for the cgroup and its descendants since
> +	the creation of the cgroup or the most recent reset for that FD.
>   
> -	The max swap usage recorded for the cgroup and its
> -	descendants since the creation of the cgroup.
> +	A write of the string "reset" to this file resets it to the
> +	current memory usage for subsequent reads through the same
> +	file descriptor.
> +	Attempts to write any other non-empty string will return EINVAL
> +	(modulo leading and trailing whitespace).
>   
>     memory.swap.max
>   	A read-write single value file which exists on non-root
> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index ae04035b6cbe5..2188ea76ab327 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -775,6 +775,11 @@ struct cgroup_subsys {
>   
>   extern struct percpu_rw_semaphore cgroup_threadgroup_rwsem;
>   
> +struct cgroup_of_peak {
> +	long			value;
> +	struct list_head	list;
> +};
The name "cgroup_of_peak" is kind of confusing. Maybe local_peak?
> +This structure is used to store the initial page counter value when the reset command is issue
>   /**
>    * cgroup_threadgroup_change_begin - threadgroup exclusion for cgroups
>    * @tsk: target task
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index c60ba0ab14627..3e0563753cc3e 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -11,6 +11,7 @@
>   
>   #include <linux/sched.h>
>   #include <linux/nodemask.h>
> +#include <linux/list.h>
Doubly linked list is very commonly used data structure in the kernel. 
It is implicitly included in a lot of headers. So I don't believe you 
need to explicitly include it here.
>   #include <linux/rculist.h>
>   #include <linux/cgroupstats.h>
>   #include <linux/fs.h>
> @@ -854,4 +855,6 @@ static inline void cgroup_bpf_put(struct cgroup *cgrp) {}
>   
>   struct cgroup *task_get_cgroup1(struct task_struct *tsk, int hierarchy_id);
>   
> +struct cgroup_of_peak *of_peak(struct kernfs_open_file *of);
> +
>   #endif /* _LINUX_CGROUP_H */
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 7e2eb091049a0..4fa4f0e931d26 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -192,6 +192,11 @@ struct mem_cgroup {
>   		struct page_counter memsw;	/* v1 only */
>   	};
>   
> +	/* registered local peak watchers */
> +	struct list_head memory_peaks;
> +	struct list_head swap_peaks;
> +	spinlock_t	 peaks_lock;
> +
>   	/* Range enforcement for interrupt charges */
>   	struct work_struct high_work;
>   
> diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
> index 904c52f97284f..860f313182e77 100644
> --- a/include/linux/page_counter.h
> +++ b/include/linux/page_counter.h
> @@ -26,6 +26,7 @@ struct page_counter {
>   	atomic_long_t children_low_usage;
>   
>   	unsigned long watermark;
> +	unsigned long local_watermark; /* track min of fd-local resets */
track "min"? I thought it is used to track local maximum after a reset.
>   	unsigned long failcnt;
>   
>   	/* Keep all the read most fields in a separete cacheline. */
> @@ -78,7 +79,10 @@ int page_counter_memparse(const char *buf, const char *max,
>   
>   static inline void page_counter_reset_watermark(struct page_counter *counter)
>   {
> -	counter->watermark = page_counter_read(counter);
> +	unsigned long usage = page_counter_read(counter);
> +
> +	counter->watermark = usage;
> +	counter->local_watermark = usage;
>   }
>   

Could you set the local_watermark first before setting watermark? There 
is a very small time window that the invariant "local_watermark <= 
watermark" is not true.

>   void page_counter_calculate_protection(struct page_counter *root,
> diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
> index 520b90dd97eca..c964dd7ff967a 100644
> --- a/kernel/cgroup/cgroup-internal.h
> +++ b/kernel/cgroup/cgroup-internal.h
> @@ -81,6 +81,8 @@ struct cgroup_file_ctx {
>   	struct {
>   		struct cgroup_pidlist	*pidlist;
>   	} procs1;
> +
> +	struct cgroup_of_peak peak;
>   };
>   
>   /*
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index c8e4b62b436a4..0a97cb2ef1245 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -1972,6 +1972,13 @@ static int cgroup2_parse_param(struct fs_context *fc, struct fs_parameter *param
>   	return -EINVAL;
>   }
>   
> +struct cgroup_of_peak *of_peak(struct kernfs_open_file *of)
> +{
> +	struct cgroup_file_ctx *ctx = of->priv;
> +
> +	return &ctx->peak;
> +}
> +
>   static void apply_cgroup_root_flags(unsigned int root_flags)
>   {
>   	if (current->nsproxy->cgroup_ns == &init_cgroup_ns) {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 9603717886877..2176a2da1aa83 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -25,6 +25,7 @@
>    * Copyright (C) 2020 Alibaba, Inc, Alex Shi
>    */
>   
> +#include <linux/cgroup-defs.h>
>   #include <linux/page_counter.h>
>   #include <linux/memcontrol.h>
>   #include <linux/cgroup.h>
> @@ -41,6 +42,7 @@
>   #include <linux/rcupdate.h>
>   #include <linux/limits.h>
>   #include <linux/export.h>
> +#include <linux/list.h>
>   #include <linux/mutex.h>
>   #include <linux/rbtree.h>
>   #include <linux/slab.h>
> @@ -3558,6 +3560,9 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
>   
>   	INIT_WORK(&memcg->high_work, high_work_func);
>   	vmpressure_init(&memcg->vmpressure);
> +	INIT_LIST_HEAD(&memcg->memory_peaks);
> +	INIT_LIST_HEAD(&memcg->swap_peaks);
> +	spin_lock_init(&memcg->peaks_lock);
>   	memcg->socket_pressure = jiffies;
>   	memcg1_memcg_init(memcg);
>   	memcg->kmemcg_id = -1;
> @@ -3950,12 +3955,90 @@ static u64 memory_current_read(struct cgroup_subsys_state *css,
>   	return (u64)page_counter_read(&memcg->memory) * PAGE_SIZE;
>   }
>   
> -static u64 memory_peak_read(struct cgroup_subsys_state *css,
> -			    struct cftype *cft)
> +static int peak_show(struct seq_file *sf, void *v, struct page_counter *pc)
>   {
> -	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
> +	struct cgroup_of_peak *ofp = of_peak(sf->private);
> +	s64 fd_peak = ofp->value, peak;
> +
> +	/* User wants global or local peak? */
> +	if (fd_peak == -1)
> +		peak = pc->watermark;
> +	else
> +		peak = max(fd_peak, (s64)pc->local_watermark);
Should you save the local_watermark value into ofp->value if 
local_watermark is bigger? This will ensure that each successive read of 
the fd is monotonically increasing. Otherwise the value may go up or 
down if there are multiple resets in between.

Cheers,
Longman


