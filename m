Return-Path: <linux-kselftest+bounces-33482-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 171E4ABFD83
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 21:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298CA189E82A
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 19:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2898322E3FC;
	Wed, 21 May 2025 19:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpZgLqQh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DF11DB366;
	Wed, 21 May 2025 19:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747856822; cv=none; b=gsNzh7n0wmM/bxEK/pmUuwPiQ3XeqPqI0/yQG9ct6e8QfSbpISDqcGbgr3SGLNRUj3tYcq/74G/6AVPr2yj2ciBrcVERAMdkDlEM5z76Lg0GusjfSjnWgpvbrNI+CNhso1Mj2VX4/b1Xl7yMBqURiwfpMxqOCDW2BUPp4Vx+a/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747856822; c=relaxed/simple;
	bh=KxpWvHTalFPpk1hq7k7Wbo/HtUjiTpk6l+sdAkRIWhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lj1O85uRVOvg8zJ/hMq14A60M0UzhAatHnRhxy8XS5sc3HIGeFO7Fa5AG5e2TbwaJ2+1N3VinPRswr41Rh3/ko9GCvaSKZcu5kEwNBNgt/xVnXnqUC5ZQdt+FQZRJbrhZkJSScVTm9bVWxAT+AvS7mQfKugAPtI0Jn/I2gEgqGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpZgLqQh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4B9C4CEE4;
	Wed, 21 May 2025 19:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747856821;
	bh=KxpWvHTalFPpk1hq7k7Wbo/HtUjiTpk6l+sdAkRIWhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JpZgLqQhf9Gd3fgj4H32L1DV7Ehmo+s9ISIGTeT8abVqeACe68Tb8B+Fh3OkLwG4Y
	 OAuU3Y/kqJVEJAfMR3uSEMSLYo+CHg0Io2c7j3ZJE3ag+N8+UbJ988ttLsO64/vHXk
	 P0VVh8DZzPild9O2L49j3wlFNKsUw4BO34/yZ65euEjZYv9zHDl4Rh9TLlm42W6oPb
	 XmZz0/gPTQgjJqOBc+ZtgwnR/fiJHAc5/KMyKb03Y92fWZVUdBKbHzZdG9Txj3q0dL
	 sW9E/ub3hLENJI6RwV7NJ3/e/MkTmkCWEAmIibj+zFEgHb+6u85FLslk6gSUB0SVJb
	 wc0jjc5wpUiug==
Date: Wed, 21 May 2025 12:46:59 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Mingwei Zhang <mizhang@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com,
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Yongwei Ma <yongwei.ma@intel.com>,
	Xiong Zhang <xiong.y.zhang@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Jim Mattson <jmattson@google.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Zide Chen <zide.chen@intel.com>,
	Eranian Stephane <eranian@google.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Nikunj Dadhania <nikunj.dadhania@amd.com>
Subject: Re: [PATCH v4 04/38] perf: Add a EVENT_GUEST flag
Message-ID: <aC4ts1M2srhVTpP1@google.com>
References: <20250324173121.1275209-1-mizhang@google.com>
 <20250324173121.1275209-5-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250324173121.1275209-5-mizhang@google.com>

On Mon, Mar 24, 2025 at 05:30:44PM +0000, Mingwei Zhang wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Current perf doesn't explicitly schedule out all exclude_guest events
> while the guest is running. There is no problem with the current
> emulated vPMU. Because perf owns all the PMU counters. It can mask the
> counter which is assigned to an exclude_guest event when a guest is
> running (Intel way), or set the corresponding HOSTONLY bit in evsentsel
> (AMD way). The counter doesn't count when a guest is running.
> 
> However, either way doesn't work with the introduced passthrough vPMU.
> A guest owns all the PMU counters when it's running. The host should not
> mask any counters. The counter may be used by the guest. The evsentsel
> may be overwritten.
> 
> Perf should explicitly schedule out all exclude_guest events to release
> the PMU resources when entering a guest, and resume the counting when
> exiting the guest.
> 
> It's possible that an exclude_guest event is created when a guest is
> running. The new event should not be scheduled in as well.
> 
> The ctx time is shared among different PMUs. The time cannot be stopped
> when a guest is running. It is required to calculate the time for events
> from other PMUs, e.g., uncore events. Add timeguest to track the guest
> run time. For an exclude_guest event, the elapsed time equals
> the ctx time - guest time.
> Cgroup has dedicated times. Use the same method to deduct the guest time
> from the cgroup time as well.
> 
> Co-developed-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---
>  include/linux/perf_event.h |   6 ++
>  kernel/events/core.c       | 209 +++++++++++++++++++++++++++++--------
>  2 files changed, 169 insertions(+), 46 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index a2fd1bdc955c..7bda1e20be12 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -999,6 +999,11 @@ struct perf_event_context {
>  	 */
>  	struct perf_time_ctx		time;
>  
> +	/*
> +	 * Context clock, runs when in the guest mode.
> +	 */
> +	struct perf_time_ctx		timeguest;
> +
>  	/*
>  	 * These fields let us detect when two contexts have both
>  	 * been cloned (inherited) from a common ancestor.
> @@ -1089,6 +1094,7 @@ struct bpf_perf_event_data_kern {
>   */
>  struct perf_cgroup_info {
>  	struct perf_time_ctx		time;
> +	struct perf_time_ctx		timeguest;
>  	int				active;
>  };
>  
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index e38c8b5e8086..7a2115b2c5c1 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -163,7 +163,8 @@ enum event_type_t {
>  	/* see ctx_resched() for details */
>  	EVENT_CPU	= 0x10,
>  	EVENT_CGROUP	= 0x20,
> -	EVENT_FLAGS	= EVENT_CGROUP,
> +	EVENT_GUEST	= 0x40,
> +	EVENT_FLAGS	= EVENT_CGROUP | EVENT_GUEST,
>  	/* compound helpers */
>  	EVENT_ALL         = EVENT_FLEXIBLE | EVENT_PINNED,
>  	EVENT_TIME_FROZEN = EVENT_TIME | EVENT_FROZEN,
> @@ -435,6 +436,7 @@ static atomic_t nr_include_guest_events __read_mostly;
>  
>  static atomic_t nr_mediated_pmu_vms;
>  static DEFINE_MUTEX(perf_mediated_pmu_mutex);
> +static DEFINE_PER_CPU(bool, perf_in_guest);
>  
>  /* !exclude_guest event of PMU with PERF_PMU_CAP_MEDIATED_VPMU */
>  static inline bool is_include_guest_event(struct perf_event *event)
> @@ -738,6 +740,9 @@ static bool perf_skip_pmu_ctx(struct perf_event_pmu_context *pmu_ctx,
>  {
>  	if ((event_type & EVENT_CGROUP) && !pmu_ctx->nr_cgroups)
>  		return true;
> +	if ((event_type & EVENT_GUEST) &&
> +	    !(pmu_ctx->pmu->capabilities & PERF_PMU_CAP_MEDIATED_VPMU))
> +		return true;
>  	return false;
>  }
>  
> @@ -788,6 +793,39 @@ static inline void update_perf_time_ctx(struct perf_time_ctx *time, u64 now, boo
>  	WRITE_ONCE(time->offset, time->time - time->stamp);
>  }
>  
> +static_assert(offsetof(struct perf_event_context, timeguest) -
> +	      offsetof(struct perf_event_context, time) ==
> +	      sizeof(struct perf_time_ctx));
> +
> +#define T_TOTAL		0
> +#define T_GUEST		1
> +
> +static inline u64 __perf_event_time_ctx(struct perf_event *event,
> +					struct perf_time_ctx *times)
> +{
> +	u64 time = times[T_TOTAL].time;
> +
> +	if (event->attr.exclude_guest)
> +		time -= times[T_GUEST].time;
> +
> +	return time;
> +}
> +
> +static inline u64 __perf_event_time_ctx_now(struct perf_event *event,
> +					    struct perf_time_ctx *times,
> +					    u64 now)
> +{
> +	if (event->attr.exclude_guest && __this_cpu_read(perf_in_guest)) {
> +		/*
> +		 * (now + times[total].offset) - (now + times[guest].offset) :=
> +		 * times[total].offset - times[guest].offset
> +		 */
> +		return READ_ONCE(times[T_TOTAL].offset) - READ_ONCE(times[T_GUEST].offset);

So this will remove both time_enabled and time_running.  I think it's
fine as the events are not multiplexed, but some curious users may
wonder why the time_enabled is less than expected. :)


> +	}
> +
> +	return now + READ_ONCE(times[T_TOTAL].offset);
> +}
> +

[SNIP] 
> @@ -6285,23 +6400,25 @@ void perf_event_update_userpage(struct perf_event *event)
>  	if (!rb)
>  		goto unlock;
>  
> -	/*
> -	 * compute total_time_enabled, total_time_running
> -	 * based on snapshot values taken when the event
> -	 * was last scheduled in.
> -	 *
> -	 * we cannot simply called update_context_time()
> -	 * because of locking issue as we can be called in
> -	 * NMI context
> -	 */
> -	calc_timer_values(event, &now, &enabled, &running);
> -
> -	userpg = rb->user_page;
>  	/*
>  	 * Disable preemption to guarantee consistent time stamps are stored to
>  	 * the user page.
>  	 */
>  	preempt_disable();
> +
> +	/*
> +	 * compute total_time_enabled, total_time_running
> +	 * based on snapshot values taken when the event
> +	 * was last scheduled in.
> +	 *
> +	 * we cannot simply called update_context_time()

s/called/call.  I know you just moved the code though. :)

Thanks,
Namhyung


> +	 * because of locking issue as we can be called in
> +	 * NMI context
> +	 */
> +	calc_timer_values(event, &now, &enabled, &running);
> +
> +	userpg = rb->user_page;
> +
>  	++userpg->lock;
>  	barrier();
>  	userpg->index = perf_event_index(event);
> -- 
> 2.49.0.395.g12beb8f557-goog
> 

