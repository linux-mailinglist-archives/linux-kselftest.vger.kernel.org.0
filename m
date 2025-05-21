Return-Path: <linux-kselftest+bounces-33483-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EE5ABFD96
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 21:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C43416FA67
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 19:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FF2235358;
	Wed, 21 May 2025 19:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKzkMDDC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FD112E5D;
	Wed, 21 May 2025 19:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747857355; cv=none; b=W/rPUStg/sRuoiiYpOeDsoKNufvqyy6K3W1e6i4BGYgcSwNLc2tyu295T70lc6u6hYW10YpKAicnt61xbmwICBt2slTjPjPDcMPDKauWNNBWjsBPvQrl52pShLEXw6ByiXxWDOzXOWocElu2SMqhBMIVd7A9RovRUqzd4Dv4IvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747857355; c=relaxed/simple;
	bh=EGfeKn8ImgtOcV91WNAlk8LMF6NPF0d6Cm6uL14hBLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=my1/gCpUuPQ+4vJSR/M35ZRMIjsbQLZgkfRwhrsE3gx0ydLmNoYxWOO1SN8845p54HIoizfzWBpcAgA+I2mLjl2UduvK8d/vG6wChi5NVweNKDNO5/Chy9m5LWY1ka3suMhjg7Za6PUvv9cDc4Ld1cVtyOox4rw68HvtxXO9nmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKzkMDDC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D458C4CEE4;
	Wed, 21 May 2025 19:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747857354;
	bh=EGfeKn8ImgtOcV91WNAlk8LMF6NPF0d6Cm6uL14hBLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PKzkMDDCg/CbBiXIjnlD8GC4AfFKaM28aTKVkuk9dQt/EV4YRMwEH64d29cEIQHeY
	 YZGfSbq0GxPQUKLY3u3cHpKM9emZzvAAJdTbBziLPFxlT5+miWfx6uFkdvt1Lo0JU+
	 3+ZrfIK1N1Na4gML35jBdqBe0uOowYTDXeAOs4FmA2yw6mSot4s3akUYzncag6wGSt
	 ciNQWehFIeUlb0/KtuyZLEg8tkomvmISpxKEgIzMWFk/wtmHqg5xPM3lrmryOC09xJ
	 6JNCAU0zQ8lKWxK3zPm914zzIG2w/EzVbu2KNnmIHgrq0xNFV5NMwqLyxclfc9jm+A
	 LrLunTVBhM3kw==
Date: Wed, 21 May 2025 12:55:52 -0700
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
Subject: Re: [PATCH v4 05/38] perf: Add generic exclude_guest support
Message-ID: <aC4vyIpKk6m2nz8-@google.com>
References: <20250324173121.1275209-1-mizhang@google.com>
 <20250324173121.1275209-6-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250324173121.1275209-6-mizhang@google.com>

On Mon, Mar 24, 2025 at 05:30:45PM +0000, Mingwei Zhang wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Only KVM knows the exact time when a guest is entering/exiting. Expose
> two interfaces to KVM to switch the ownership of the PMU resources.
> 
> All the pinned events must be scheduled in first. Extend the
> perf_event_sched_in() helper to support extra flag, e.g., EVENT_GUEST.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---
>  include/linux/perf_event.h |  4 ++
>  kernel/events/core.c       | 80 ++++++++++++++++++++++++++++++++++----
>  2 files changed, 77 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 7bda1e20be12..37187ee8e226 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1822,6 +1822,8 @@ extern int perf_event_period(struct perf_event *event, u64 value);
>  extern u64 perf_event_pause(struct perf_event *event, bool reset);
>  int perf_get_mediated_pmu(void);
>  void perf_put_mediated_pmu(void);
> +void perf_guest_enter(void);
> +void perf_guest_exit(void);
>  #else /* !CONFIG_PERF_EVENTS: */
>  static inline void *
>  perf_aux_output_begin(struct perf_output_handle *handle,
> @@ -1919,6 +1921,8 @@ static inline int perf_get_mediated_pmu(void)
>  }
>  
>  static inline void perf_put_mediated_pmu(void)			{ }
> +static inline void perf_guest_enter(void)			{ }
> +static inline void perf_guest_exit(void)			{ }
>  #endif
>  
>  #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 7a2115b2c5c1..d05487d465c9 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2827,14 +2827,15 @@ static void task_ctx_sched_out(struct perf_event_context *ctx,
>  
>  static void perf_event_sched_in(struct perf_cpu_context *cpuctx,
>  				struct perf_event_context *ctx,
> -				struct pmu *pmu)
> +				struct pmu *pmu,
> +				enum event_type_t event_type)
>  {
> -	ctx_sched_in(&cpuctx->ctx, pmu, EVENT_PINNED);
> +	ctx_sched_in(&cpuctx->ctx, pmu, EVENT_PINNED | event_type);
>  	if (ctx)
> -		 ctx_sched_in(ctx, pmu, EVENT_PINNED);
> -	ctx_sched_in(&cpuctx->ctx, pmu, EVENT_FLEXIBLE);
> +		ctx_sched_in(ctx, pmu, EVENT_PINNED | event_type);
> +	ctx_sched_in(&cpuctx->ctx, pmu, EVENT_FLEXIBLE | event_type);
>  	if (ctx)
> -		 ctx_sched_in(ctx, pmu, EVENT_FLEXIBLE);
> +		ctx_sched_in(ctx, pmu, EVENT_FLEXIBLE | event_type);
>  }
>  
>  /*
> @@ -2890,7 +2891,7 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
>  	else if (event_type & EVENT_PINNED)
>  		ctx_sched_out(&cpuctx->ctx, pmu, EVENT_FLEXIBLE);
>  
> -	perf_event_sched_in(cpuctx, task_ctx, pmu);
> +	perf_event_sched_in(cpuctx, task_ctx, pmu, 0);
>  
>  	for_each_epc(epc, &cpuctx->ctx, pmu, 0)
>  		perf_pmu_enable(epc->pmu);
> @@ -4188,7 +4189,7 @@ static void perf_event_context_sched_in(struct task_struct *task)
>  		ctx_sched_out(&cpuctx->ctx, NULL, EVENT_FLEXIBLE);
>  	}
>  
> -	perf_event_sched_in(cpuctx, ctx, NULL);
> +	perf_event_sched_in(cpuctx, ctx, NULL, 0);
>  
>  	perf_ctx_sched_task_cb(cpuctx->task_ctx, true);
>  
> @@ -6040,6 +6041,71 @@ void perf_put_mediated_pmu(void)
>  }
>  EXPORT_SYMBOL_GPL(perf_put_mediated_pmu);
>  
> +static inline void perf_host_exit(struct perf_cpu_context *cpuctx)
> +{
> +	perf_ctx_disable(&cpuctx->ctx, EVENT_GUEST);
> +	ctx_sched_out(&cpuctx->ctx, NULL, EVENT_GUEST);
> +	perf_ctx_enable(&cpuctx->ctx, EVENT_GUEST);
> +	if (cpuctx->task_ctx) {
> +		perf_ctx_disable(cpuctx->task_ctx, EVENT_GUEST);
> +		task_ctx_sched_out(cpuctx->task_ctx, NULL, EVENT_GUEST);
> +		perf_ctx_enable(cpuctx->task_ctx, EVENT_GUEST);
> +	}
> +}

Cpu context and task context may have events in the same PMU.
How about this?

	perf_ctx_disable(&cpuctx->ctx, EVENT_GUEST);
	if (cpuctx->task_ctx)
		perf_ctx_disable(cpuctx->task_ctx, EVENT_GUEST);

	ctx_sched_out(&cpuctx->ctx, NULL, EVENT_GUEST);
	if (cpuctx->task_ctx)
		task_ctx_sched_out(cpuctx->task_ctx, NULL, EVENT_GUEST);

	if (cpuctx->task_ctx)
		perf_ctx_enable(cpuctx->task_ctx, EVENT_GUEST);
	perf_ctx_enable(&cpuctx->ctx, EVENT_GUEST);

Thanks,
Namhyung

> +
> +/* When entering a guest, schedule out all exclude_guest events. */
> +void perf_guest_enter(void)
> +{
> +	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
> +
> +	lockdep_assert_irqs_disabled();
> +
> +	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
> +
> +	if (WARN_ON_ONCE(__this_cpu_read(perf_in_guest)))
> +		goto unlock;
> +
> +	perf_host_exit(cpuctx);
> +
> +	__this_cpu_write(perf_in_guest, true);
> +
> +unlock:
> +	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
> +}
> +EXPORT_SYMBOL_GPL(perf_guest_enter);
> +
> +static inline void perf_host_enter(struct perf_cpu_context *cpuctx)
> +{
> +	perf_ctx_disable(&cpuctx->ctx, EVENT_GUEST);
> +	if (cpuctx->task_ctx)
> +		perf_ctx_disable(cpuctx->task_ctx, EVENT_GUEST);
> +
> +	perf_event_sched_in(cpuctx, cpuctx->task_ctx, NULL, EVENT_GUEST);
> +
> +	if (cpuctx->task_ctx)
> +		perf_ctx_enable(cpuctx->task_ctx, EVENT_GUEST);
> +	perf_ctx_enable(&cpuctx->ctx, EVENT_GUEST);
> +}
> +
> +void perf_guest_exit(void)
> +{
> +	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
> +
> +	lockdep_assert_irqs_disabled();
> +
> +	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
> +
> +	if (WARN_ON_ONCE(!__this_cpu_read(perf_in_guest)))
> +		goto unlock;
> +
> +	perf_host_enter(cpuctx);
> +
> +	__this_cpu_write(perf_in_guest, false);
> +unlock:
> +	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
> +}
> +EXPORT_SYMBOL_GPL(perf_guest_exit);
> +
>  /*
>   * Holding the top-level event's child_mutex means that any
>   * descendant process that has inherited this event will block
> -- 
> 2.49.0.395.g12beb8f557-goog
> 

