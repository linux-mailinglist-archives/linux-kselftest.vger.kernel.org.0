Return-Path: <linux-kselftest+bounces-33413-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDB3ABE226
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 19:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45E181BA57CB
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 17:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B2525A347;
	Tue, 20 May 2025 17:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkIyRNNh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA38C1AF4C1;
	Tue, 20 May 2025 17:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747763473; cv=none; b=ct0NX46HTJSKtXGFbujgcQOdXvQf2asSBcRfeJr472wp38QRKRw/fvpKI4M9pk29o/e+JH7azzJLrG+SrSwQzBI1tqO1Crup9RvY67XqobVxdXvkEN4/qBbSJ/F+PkgXCGL0jhoE2ZFLdAJeU5G+6GTRBaZXp03t+XjFEDnD7ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747763473; c=relaxed/simple;
	bh=icRIMGCFwUf4PYy3gJtfYBs3gR3d+hyDymY7inwBUeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mygj8s69wI5ynR7HMASTbRimtQS2SSOoJ/vU9QMxCM1KWvN1CJ3cO/pLBwl2rHKlQo7dpQdp6nqwnDpgYiaomhC5WYiPWzBv6wh1aOKYRtZJhE9ezuob79CVYdmpot7GNFIakGslbcviuHcKcuuGVIDEIWZXUOuUW4pvVd/tTBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkIyRNNh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C784C4CEE9;
	Tue, 20 May 2025 17:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747763472;
	bh=icRIMGCFwUf4PYy3gJtfYBs3gR3d+hyDymY7inwBUeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SkIyRNNhGBsDKUiWoHaivlBQphpYJi7aQKRy/VJKSIfguHWVO6PTxYCIsDWi66Ns1
	 d0RGW3mg7+8SGO6BFlIlClwvjNhD5cArIvX7h+kLRhQ1gRyAWI+9dFD0tLOVynS5U6
	 HGNvEfzt/mQM0D3Xs+QqQa7onZscGLRKNGyxpMlQ14Eg7YXe4FZcjgvfpnlCHHwOSk
	 BM9c+VCHhFA/QfwTxORFi/UmR5MgBi031AzwyhQlWTzSpUT7sRWRgC1BH0Nc+bJZk8
	 JVzuhUPpHvAoWsh2tN78doXvEZJfJqk/hDQDdRhCXEV445YD5mpucLtweA7ngS8nch
	 +C8mtQKLz498A==
Date: Tue, 20 May 2025 10:51:09 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Mingwei Zhang <mizhang@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com,
	"H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Yongwei Ma <yongwei.ma@intel.com>,
	Xiong Zhang <xiong.y.zhang@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Jim Mattson <jmattson@google.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Zide Chen <zide.chen@intel.com>,
	Eranian Stephane <eranian@google.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Nikunj Dadhania <nikunj.dadhania@amd.com>
Subject: Re: [PATCH v4 04/38] perf: Add a EVENT_GUEST flag
Message-ID: <aCzBDaHdELjiKHfc@google.com>
References: <20250324173121.1275209-1-mizhang@google.com>
 <20250324173121.1275209-5-mizhang@google.com>
 <aCrWqhaID9-b_jmr@google.com>
 <09ed8cb5-707d-4b13-b230-cff4fab02b72@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <09ed8cb5-707d-4b13-b230-cff4fab02b72@linux.intel.com>

On Tue, May 20, 2025 at 12:09:02PM -0400, Liang, Kan wrote:
> 
> 
> On 2025-05-19 2:58 a.m., Namhyung Kim wrote:
> > Hello,
> > 
> > On Mon, Mar 24, 2025 at 05:30:44PM +0000, Mingwei Zhang wrote:
> >> From: Kan Liang <kan.liang@linux.intel.com>
> >>
> >> Current perf doesn't explicitly schedule out all exclude_guest events
> >> while the guest is running. There is no problem with the current
> >> emulated vPMU. Because perf owns all the PMU counters. It can mask the
> >> counter which is assigned to an exclude_guest event when a guest is
> >> running (Intel way), or set the corresponding HOSTONLY bit in evsentsel
> >> (AMD way). The counter doesn't count when a guest is running.
> >>
> >> However, either way doesn't work with the introduced passthrough vPMU.
> >> A guest owns all the PMU counters when it's running. The host should not
> >> mask any counters. The counter may be used by the guest. The evsentsel
> >> may be overwritten.
> >>
> >> Perf should explicitly schedule out all exclude_guest events to release
> >> the PMU resources when entering a guest, and resume the counting when
> >> exiting the guest.
> >>
> >> It's possible that an exclude_guest event is created when a guest is
> >> running. The new event should not be scheduled in as well.
> >>
> >> The ctx time is shared among different PMUs. The time cannot be stopped
> >> when a guest is running. It is required to calculate the time for events
> >> from other PMUs, e.g., uncore events. Add timeguest to track the guest
> >> run time. For an exclude_guest event, the elapsed time equals
> >> the ctx time - guest time.
> >> Cgroup has dedicated times. Use the same method to deduct the guest time
> >> from the cgroup time as well.
> >>
> >> Co-developed-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> >> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> >> ---
> >>  include/linux/perf_event.h |   6 ++
> >>  kernel/events/core.c       | 209 +++++++++++++++++++++++++++++--------
> >>  2 files changed, 169 insertions(+), 46 deletions(-)
> >>
> >> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> >> index a2fd1bdc955c..7bda1e20be12 100644
> >> --- a/include/linux/perf_event.h
> >> +++ b/include/linux/perf_event.h
> >> @@ -999,6 +999,11 @@ struct perf_event_context {
> >>  	 */
> >>  	struct perf_time_ctx		time;
> >>  
> >> +	/*
> >> +	 * Context clock, runs when in the guest mode.
> >> +	 */
> >> +	struct perf_time_ctx		timeguest;
> > 
> > Why not make it an array as you use it later?
> 
> Do you mean
> struct perf_time_ctx	times[2]?

Yep.

> 
> I don't see a big benefit of using times[T_GUEST] VS.timeguest.

No big benefits.  But I just think it's natural to make it an array if
you want to access them as if it's an array. :)

> 
> > 
> >> +
> >>  	/*
> >>  	 * These fields let us detect when two contexts have both
> >>  	 * been cloned (inherited) from a common ancestor.
> >> @@ -1089,6 +1094,7 @@ struct bpf_perf_event_data_kern {
> >>   */
> >>  struct perf_cgroup_info {
> >>  	struct perf_time_ctx		time;
> >> +	struct perf_time_ctx		timeguest;
> >>  	int				active;
> >>  };
> >>  
> >> diff --git a/kernel/events/core.c b/kernel/events/core.c
> >> index e38c8b5e8086..7a2115b2c5c1 100644
> >> --- a/kernel/events/core.c
> >> +++ b/kernel/events/core.c
> >> @@ -163,7 +163,8 @@ enum event_type_t {
> >>  	/* see ctx_resched() for details */
> >>  	EVENT_CPU	= 0x10,
> >>  	EVENT_CGROUP	= 0x20,
> >> -	EVENT_FLAGS	= EVENT_CGROUP,
> >> +	EVENT_GUEST	= 0x40,
> > 
> > It's not clear to me if this flag is for events to include guests or
> > exclude them.  Can you please add a comment?
> > 
> 
> /*
>  * There are guest events. The for_each_epc() iteration can
>  * skip those PMUs which doesn't support guest events via the
>  * MEDIATED_VPMU. It is also used to indicate the start/end of
>  * guest events to calculate the guest running time.
>  */

Thanks for the explanation.  So it's for events with !exclude_guest on
host and to do some operation only for host-only events on mediated
vPMUs.

Thanks,
Namhyung

> > 
> >> +	EVENT_FLAGS	= EVENT_CGROUP | EVENT_GUEST,
> >>  	/* compound helpers */
> >>  	EVENT_ALL         = EVENT_FLEXIBLE | EVENT_PINNED,
> >>  	EVENT_TIME_FROZEN = EVENT_TIME | EVENT_FROZEN,
> >> @@ -435,6 +436,7 @@ static atomic_t nr_include_guest_events __read_mostly;
> >>  
> >>  static atomic_t nr_mediated_pmu_vms;
> >>  static DEFINE_MUTEX(perf_mediated_pmu_mutex);
> >> +static DEFINE_PER_CPU(bool, perf_in_guest);
> >>  
> >>  /* !exclude_guest event of PMU with PERF_PMU_CAP_MEDIATED_VPMU */
> >>  static inline bool is_include_guest_event(struct perf_event *event)
> >> @@ -738,6 +740,9 @@ static bool perf_skip_pmu_ctx(struct perf_event_pmu_context *pmu_ctx,
> >>  {
> >>  	if ((event_type & EVENT_CGROUP) && !pmu_ctx->nr_cgroups)
> >>  		return true;
> >> +	if ((event_type & EVENT_GUEST) &&
> >> +	    !(pmu_ctx->pmu->capabilities & PERF_PMU_CAP_MEDIATED_VPMU))
> >> +		return true;
> >>  	return false;
> >>  }
> >>  
> >> @@ -788,6 +793,39 @@ static inline void update_perf_time_ctx(struct perf_time_ctx *time, u64 now, boo
> >>  	WRITE_ONCE(time->offset, time->time - time->stamp);
> >>  }
> >>  
> >> +static_assert(offsetof(struct perf_event_context, timeguest) -
> >> +	      offsetof(struct perf_event_context, time) ==
> >> +	      sizeof(struct perf_time_ctx));
> >> +
> >> +#define T_TOTAL		0
> >> +#define T_GUEST		1
> >> +
> >> +static inline u64 __perf_event_time_ctx(struct perf_event *event,
> >> +					struct perf_time_ctx *times)
> >> +{
> >> +	u64 time = times[T_TOTAL].time;
> >> +
> >> +	if (event->attr.exclude_guest)
> >> +		time -= times[T_GUEST].time;
> >> +
> >> +	return time;
> >> +}
> >> +
> >> +static inline u64 __perf_event_time_ctx_now(struct perf_event *event,
> >> +					    struct perf_time_ctx *times,
> >> +					    u64 now)
> >> +{
> >> +	if (event->attr.exclude_guest && __this_cpu_read(perf_in_guest)) {
> >> +		/*
> >> +		 * (now + times[total].offset) - (now + times[guest].offset) :=
> >> +		 * times[total].offset - times[guest].offset
> >> +		 */
> >> +		return READ_ONCE(times[T_TOTAL].offset) - READ_ONCE(times[T_GUEST].offset);
> >> +	}
> >> +
> >> +	return now + READ_ONCE(times[T_TOTAL].offset);
> >> +}
> >> +
> >>  #ifdef CONFIG_CGROUP_PERF
> >>  
> >>  static inline bool
> >> @@ -824,12 +862,16 @@ static inline int is_cgroup_event(struct perf_event *event)
> >>  	return event->cgrp != NULL;
> >>  }
> >>  
> >> +static_assert(offsetof(struct perf_cgroup_info, timeguest) -
> >> +	      offsetof(struct perf_cgroup_info, time) ==
> >> +	      sizeof(struct perf_time_ctx));
> >> +
> >>  static inline u64 perf_cgroup_event_time(struct perf_event *event)
> >>  {
> >>  	struct perf_cgroup_info *t;
> >>  
> >>  	t = per_cpu_ptr(event->cgrp->info, event->cpu);
> >> -	return t->time.time;
> >> +	return __perf_event_time_ctx(event, &t->time);
> >>  }
> >>  
> >>  static inline u64 perf_cgroup_event_time_now(struct perf_event *event, u64 now)
> >> @@ -838,9 +880,21 @@ static inline u64 perf_cgroup_event_time_now(struct perf_event *event, u64 now)
> >>  
> >>  	t = per_cpu_ptr(event->cgrp->info, event->cpu);
> >>  	if (!__load_acquire(&t->active))
> >> -		return t->time.time;
> >> -	now += READ_ONCE(t->time.offset);
> >> -	return now;
> >> +		return __perf_event_time_ctx(event, &t->time);
> >> +
> >> +	return __perf_event_time_ctx_now(event, &t->time, now);
> >> +}
> >> +
> >> +static inline void __update_cgrp_guest_time(struct perf_cgroup_info *info, u64 now, bool adv)
> >> +{
> >> +	update_perf_time_ctx(&info->timeguest, now, adv);
> >> +}
> >> +
> >> +static inline void update_cgrp_time(struct perf_cgroup_info *info, u64 now)
> >> +{
> >> +	update_perf_time_ctx(&info->time, now, true);
> >> +	if (__this_cpu_read(perf_in_guest))
> >> +		__update_cgrp_guest_time(info, now, true);
> >>  }
> >>  
> >>  static inline void update_cgrp_time_from_cpuctx(struct perf_cpu_context *cpuctx, bool final)
> >> @@ -856,7 +910,7 @@ static inline void update_cgrp_time_from_cpuctx(struct perf_cpu_context *cpuctx,
> >>  			cgrp = container_of(css, struct perf_cgroup, css);
> >>  			info = this_cpu_ptr(cgrp->info);
> >>  
> >> -			update_perf_time_ctx(&info->time, now, true);
> >> +			update_cgrp_time(info, now);
> >>  			if (final)
> >>  				__store_release(&info->active, 0);
> >>  		}
> >> @@ -879,11 +933,11 @@ static inline void update_cgrp_time_from_event(struct perf_event *event)
> >>  	 * Do not update time when cgroup is not active
> >>  	 */
> >>  	if (info->active)
> >> -		update_perf_time_ctx(&info->time, perf_clock(), true);
> >> +		update_cgrp_time(info, perf_clock());
> >>  }
> >>  
> >>  static inline void
> >> -perf_cgroup_set_timestamp(struct perf_cpu_context *cpuctx)
> >> +perf_cgroup_set_timestamp(struct perf_cpu_context *cpuctx, bool guest)
> >>  {
> >>  	struct perf_event_context *ctx = &cpuctx->ctx;
> >>  	struct perf_cgroup *cgrp = cpuctx->cgrp;
> >> @@ -903,8 +957,12 @@ perf_cgroup_set_timestamp(struct perf_cpu_context *cpuctx)
> >>  	for (css = &cgrp->css; css; css = css->parent) {
> >>  		cgrp = container_of(css, struct perf_cgroup, css);
> >>  		info = this_cpu_ptr(cgrp->info);
> >> -		update_perf_time_ctx(&info->time, ctx->time.stamp, false);
> >> -		__store_release(&info->active, 1);
> >> +		if (guest) {
> >> +			__update_cgrp_guest_time(info, ctx->time.stamp, false);
> >> +		} else {
> >> +			update_perf_time_ctx(&info->time, ctx->time.stamp, false);
> >> +			__store_release(&info->active, 1);
> >> +		}
> >>  	}
> >>  }
> >>  
> >> @@ -1104,7 +1162,7 @@ static inline int perf_cgroup_connect(pid_t pid, struct perf_event *event,
> >>  }
> >>  
> >>  static inline void
> >> -perf_cgroup_set_timestamp(struct perf_cpu_context *cpuctx)
> >> +perf_cgroup_set_timestamp(struct perf_cpu_context *cpuctx, bool guest)
> >>  {
> >>  }
> >>  
> >> @@ -1514,16 +1572,24 @@ static void perf_unpin_context(struct perf_event_context *ctx)
> >>   */
> >>  static void __update_context_time(struct perf_event_context *ctx, bool adv)
> >>  {
> >> -	u64 now = perf_clock();
> >> +	lockdep_assert_held(&ctx->lock);
> >> +
> >> +	update_perf_time_ctx(&ctx->time, perf_clock(), adv);
> >> +}
> >>  
> >> +static void __update_context_guest_time(struct perf_event_context *ctx, bool adv)
> >> +{
> >>  	lockdep_assert_held(&ctx->lock);
> >>  
> >> -	update_perf_time_ctx(&ctx->time, now, adv);
> >> +	/* must be called after __update_context_time(); */
> >> +	update_perf_time_ctx(&ctx->timeguest, ctx->time.stamp, adv);
> >>  }
> >>  
> >>  static void update_context_time(struct perf_event_context *ctx)
> >>  {
> >>  	__update_context_time(ctx, true);
> >> +	if (__this_cpu_read(perf_in_guest))
> >> +		__update_context_guest_time(ctx, true);
> >>  }
> >>  
> >>  static u64 perf_event_time(struct perf_event *event)
> >> @@ -1536,7 +1602,7 @@ static u64 perf_event_time(struct perf_event *event)
> >>  	if (is_cgroup_event(event))
> >>  		return perf_cgroup_event_time(event);
> >>  
> >> -	return ctx->time.time;
> >> +	return __perf_event_time_ctx(event, &ctx->time);
> >>  }
> >>  
> >>  static u64 perf_event_time_now(struct perf_event *event, u64 now)
> >> @@ -1550,10 +1616,9 @@ static u64 perf_event_time_now(struct perf_event *event, u64 now)
> >>  		return perf_cgroup_event_time_now(event, now);
> >>  
> >>  	if (!(__load_acquire(&ctx->is_active) & EVENT_TIME))
> >> -		return ctx->time.time;
> >> +		return __perf_event_time_ctx(event, &ctx->time);
> >>  
> >> -	now += READ_ONCE(ctx->time.offset);
> >> -	return now;
> >> +	return __perf_event_time_ctx_now(event, &ctx->time, now);
> >>  }
> >>  
> >>  static enum event_type_t get_event_type(struct perf_event *event)
> >> @@ -2384,20 +2449,23 @@ group_sched_out(struct perf_event *group_event, struct perf_event_context *ctx)
> >>  }
> >>  
> >>  static inline void
> >> -__ctx_time_update(struct perf_cpu_context *cpuctx, struct perf_event_context *ctx, bool final)
> >> +__ctx_time_update(struct perf_cpu_context *cpuctx, struct perf_event_context *ctx,
> >> +		  bool final, enum event_type_t event_type)
> >>  {
> >>  	if (ctx->is_active & EVENT_TIME) {
> >>  		if (ctx->is_active & EVENT_FROZEN)
> >>  			return;
> >> +
> >>  		update_context_time(ctx);
> >> -		update_cgrp_time_from_cpuctx(cpuctx, final);
> >> +		/* vPMU should not stop time */
> >> +		update_cgrp_time_from_cpuctx(cpuctx, !(event_type & EVENT_GUEST) && final);
> >>  	}
> >>  }
> >>  
> >>  static inline void
> >>  ctx_time_update(struct perf_cpu_context *cpuctx, struct perf_event_context *ctx)
> >>  {
> >> -	__ctx_time_update(cpuctx, ctx, false);
> >> +	__ctx_time_update(cpuctx, ctx, false, 0);
> >>  }
> >>  
> >>  /*
> >> @@ -3405,7 +3473,7 @@ ctx_sched_out(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t
> >>  	 *
> >>  	 * would only update time for the pinned events.
> >>  	 */
> >> -	__ctx_time_update(cpuctx, ctx, ctx == &cpuctx->ctx);
> >> +	__ctx_time_update(cpuctx, ctx, ctx == &cpuctx->ctx, event_type);
> >>  
> >>  	/*
> >>  	 * CPU-release for the below ->is_active store,
> >> @@ -3431,7 +3499,18 @@ ctx_sched_out(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t
> >>  			cpuctx->task_ctx = NULL;
> >>  	}
> >>  
> >> -	is_active ^= ctx->is_active; /* changed bits */
> >> +	if (event_type & EVENT_GUEST) {
> >> +		/*
> >> +		 * Schedule out all exclude_guest events of PMU
> >> +		 * with PERF_PMU_CAP_MEDIATED_VPMU.
> >> +		 */
> >> +		is_active = EVENT_ALL;
> >> +		__update_context_guest_time(ctx, false);
> >> +		perf_cgroup_set_timestamp(cpuctx, true);
> >> +		barrier();
> >> +	} else {
> >> +		is_active ^= ctx->is_active; /* changed bits */
> >> +	}
> >>  
> >>  	for_each_epc(pmu_ctx, ctx, pmu, event_type)
> >>  		__pmu_ctx_sched_out(pmu_ctx, is_active);
> >> @@ -3926,10 +4005,15 @@ static inline void group_update_userpage(struct perf_event *group_event)
> >>  		event_update_userpage(event);
> >>  }
> >>  
> >> +struct merge_sched_data {
> >> +	int can_add_hw;
> >> +	enum event_type_t event_type;
> >> +};
> >> +
> >>  static int merge_sched_in(struct perf_event *event, void *data)
> >>  {
> >>  	struct perf_event_context *ctx = event->ctx;
> >> -	int *can_add_hw = data;
> >> +	struct merge_sched_data *msd = data;
> >>  
> >>  	if (event->state <= PERF_EVENT_STATE_OFF)
> >>  		return 0;
> >> @@ -3937,13 +4021,22 @@ static int merge_sched_in(struct perf_event *event, void *data)
> >>  	if (!event_filter_match(event))
> >>  		return 0;
> >>  
> >> -	if (group_can_go_on(event, *can_add_hw)) {
> >> +	/*
> >> +	 * Don't schedule in any host events from PMU with
> >> +	 * PERF_PMU_CAP_MEDIATED_VPMU, while a guest is running.
> >> +	 */
> >> +	if (__this_cpu_read(perf_in_guest) &&
> >> +	    event->pmu_ctx->pmu->capabilities & PERF_PMU_CAP_MEDIATED_VPMU &&
> >> +	    !(msd->event_type & EVENT_GUEST))
> >> +		return 0;
> >> +
> >> +	if (group_can_go_on(event, msd->can_add_hw)) {
> >>  		if (!group_sched_in(event, ctx))
> >>  			list_add_tail(&event->active_list, get_event_list(event));
> >>  	}
> >>  
> >>  	if (event->state == PERF_EVENT_STATE_INACTIVE) {
> >> -		*can_add_hw = 0;
> >> +		msd->can_add_hw = 0;
> >>  		if (event->attr.pinned) {
> >>  			perf_cgroup_event_disable(event, ctx);
> >>  			perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
> >> @@ -3962,11 +4055,15 @@ static int merge_sched_in(struct perf_event *event, void *data)
> >>  
> >>  static void pmu_groups_sched_in(struct perf_event_context *ctx,
> >>  				struct perf_event_groups *groups,
> >> -				struct pmu *pmu)
> >> +				struct pmu *pmu,
> >> +				enum event_type_t event_type)
> >>  {
> >> -	int can_add_hw = 1;
> >> +	struct merge_sched_data msd = {
> >> +		.can_add_hw = 1,
> >> +		.event_type = event_type,
> >> +	};
> >>  	visit_groups_merge(ctx, groups, smp_processor_id(), pmu,
> >> -			   merge_sched_in, &can_add_hw);
> >> +			   merge_sched_in, &msd);
> >>  }
> >>  
> >>  static void __pmu_ctx_sched_in(struct perf_event_pmu_context *pmu_ctx,
> >> @@ -3975,9 +4072,9 @@ static void __pmu_ctx_sched_in(struct perf_event_pmu_context *pmu_ctx,
> >>  	struct perf_event_context *ctx = pmu_ctx->ctx;
> >>  
> >>  	if (event_type & EVENT_PINNED)
> >> -		pmu_groups_sched_in(ctx, &ctx->pinned_groups, pmu_ctx->pmu);
> >> +		pmu_groups_sched_in(ctx, &ctx->pinned_groups, pmu_ctx->pmu, event_type);
> >>  	if (event_type & EVENT_FLEXIBLE)
> >> -		pmu_groups_sched_in(ctx, &ctx->flexible_groups, pmu_ctx->pmu);
> >> +		pmu_groups_sched_in(ctx, &ctx->flexible_groups, pmu_ctx->pmu, event_type);
> >>  }
> >>  
> >>  static void
> >> @@ -3994,9 +4091,11 @@ ctx_sched_in(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t
> >>  		return;
> >>  
> >>  	if (!(is_active & EVENT_TIME)) {
> >> +		/* EVENT_TIME should be active while the guest runs */
> >> +		WARN_ON_ONCE(event_type & EVENT_GUEST);
> >>  		/* start ctx time */
> >>  		__update_context_time(ctx, false);
> >> -		perf_cgroup_set_timestamp(cpuctx);
> >> +		perf_cgroup_set_timestamp(cpuctx, false);
> >>  		/*
> >>  		 * CPU-release for the below ->is_active store,
> >>  		 * see __load_acquire() in perf_event_time_now()
> >> @@ -4012,7 +4111,23 @@ ctx_sched_in(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t
> >>  			WARN_ON_ONCE(cpuctx->task_ctx != ctx);
> >>  	}
> >>  
> >> -	is_active ^= ctx->is_active; /* changed bits */
> >> +	if (event_type & EVENT_GUEST) {
> >> +		/*
> >> +		 * Schedule in the required exclude_guest events of PMU
> >> +		 * with PERF_PMU_CAP_MEDIATED_VPMU.
> >> +		 */
> >> +		is_active = event_type & EVENT_ALL;
> >> +
> >> +		/*
> >> +		 * Update ctx time to set the new start time for
> >> +		 * the exclude_guest events.
> >> +		 */
> >> +		update_context_time(ctx);
> >> +		update_cgrp_time_from_cpuctx(cpuctx, false);
> >> +		barrier();
> >> +	} else {
> >> +		is_active ^= ctx->is_active; /* changed bits */
> >> +	}
> >>  
> >>  	/*
> >>  	 * First go through the list and put on any pinned groups
> >> @@ -4020,13 +4135,13 @@ ctx_sched_in(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t
> >>  	 */
> >>  	if (is_active & EVENT_PINNED) {
> >>  		for_each_epc(pmu_ctx, ctx, pmu, event_type)
> >> -			__pmu_ctx_sched_in(pmu_ctx, EVENT_PINNED);
> >> +			__pmu_ctx_sched_in(pmu_ctx, EVENT_PINNED | (event_type & EVENT_GUEST));
> >>  	}
> >>  
> >>  	/* Then walk through the lower prio flexible groups */
> >>  	if (is_active & EVENT_FLEXIBLE) {
> >>  		for_each_epc(pmu_ctx, ctx, pmu, event_type)
> >> -			__pmu_ctx_sched_in(pmu_ctx, EVENT_FLEXIBLE);
> >> +			__pmu_ctx_sched_in(pmu_ctx, EVENT_FLEXIBLE | (event_type & EVENT_GUEST));
> >>  	}
> >>  }
> >>  
> >> @@ -6285,23 +6400,25 @@ void perf_event_update_userpage(struct perf_event *event)
> >>  	if (!rb)
> >>  		goto unlock;
> >>  
> >> -	/*
> >> -	 * compute total_time_enabled, total_time_running
> >> -	 * based on snapshot values taken when the event
> >> -	 * was last scheduled in.
> >> -	 *
> >> -	 * we cannot simply called update_context_time()
> >> -	 * because of locking issue as we can be called in
> >> -	 * NMI context
> >> -	 */
> >> -	calc_timer_values(event, &now, &enabled, &running);
> >> -
> >> -	userpg = rb->user_page;
> >>  	/*
> >>  	 * Disable preemption to guarantee consistent time stamps are stored to
> >>  	 * the user page.
> >>  	 */
> >>  	preempt_disable();
> >> +
> >> +	/*
> >> +	 * compute total_time_enabled, total_time_running
> >> +	 * based on snapshot values taken when the event
> >> +	 * was last scheduled in.
> >> +	 *
> >> +	 * we cannot simply called update_context_time()
> >> +	 * because of locking issue as we can be called in
> >> +	 * NMI context
> >> +	 */
> >> +	calc_timer_values(event, &now, &enabled, &running);
> >> +
> >> +	userpg = rb->user_page;
> >> +
> >>  	++userpg->lock;
> >>  	barrier();
> >>  	userpg->index = perf_event_index(event);
> >> -- 
> >> 2.49.0.395.g12beb8f557-goog
> >>
> > 
> 

