Return-Path: <linux-kselftest+bounces-31633-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEE5A9C6C5
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 13:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAE6517FD48
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 11:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BCD23FC49;
	Fri, 25 Apr 2025 11:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uUI+Jwgx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4205183CC3;
	Fri, 25 Apr 2025 11:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745579589; cv=none; b=bApfgaiNxwiBHv5XL6sUEY49Z5Se89Ar3zqX8QffIIsrM2dn0Smv8fmiBA8puirxJudwTTStkT2nOIqMbbMLoMDX/fj0mkKx7AtUNaQJX94eLj1zus48OLLQ4Evof3dtTZr2f7RGacOBSFe+LUdu6ucIxPERWqfLIaA9i2a9VfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745579589; c=relaxed/simple;
	bh=BQZ1WZa9i63LV1fgRsPMTvGEzDqSt6xk/3q7eL5JIvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUCPrkjYOtlKMpckeEjjKESJK4w+3FtyxyzB6adV1p5/L7+2DfyIn8m0ClyTSrVRXfih4uOgB6578PumtfCeTPJFddE0bIUDa5UtdH7wmcs+bXXfrRH5734w8ujnefqDQrq7mGory4LKw1oATPsskJ/PADk6x0TLGedAktJukS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uUI+Jwgx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7pkDfdxdw7o8CU4rwyMhmAqybwgwSXlsx2/t9ooZeJQ=; b=uUI+Jwgx74okaceFngtxWhItZA
	J+hhe+lJ2oYZtIQZh5aHpbmkWr4kP5pj7yXN570zp1wrvVjwVXDgPhE8miXXhMxzCt2toN6O0nkvG
	rAmc5z5q0XUm7L63Io52NWCc4pyj0fmVrGCQXBqtsHuwTMlIaFB8egLS55ueWPplFzc4oLLCpmmPv
	UnRNJTz1BkFoeFiVaDKf61BJJmihuoEXiUHXWDAhNai+GZqDpjxG8cPePY7ycHquFR8xo6RNvY+AF
	CaR9oxmzOYfFBLoGDy3rOutayP0Iv+t57nssL8jWMtdt35iHySvdmhWLFwWjuj9Pojf+CAPtAftxG
	1yhDghSA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8GzJ-0000000ENXM-1nQU;
	Fri, 25 Apr 2025 11:12:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C4AEA3003C4; Fri, 25 Apr 2025 13:12:56 +0200 (CEST)
Date: Fri, 25 Apr 2025 13:12:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mingwei Zhang <mizhang@google.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
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
Subject: Re: [PATCH v4 09/38] perf: Add switch_guest_ctx() interface
Message-ID: <20250425111256.GE1166@noisy.programming.kicks-ass.net>
References: <20250324173121.1275209-1-mizhang@google.com>
 <20250324173121.1275209-10-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324173121.1275209-10-mizhang@google.com>

On Mon, Mar 24, 2025 at 05:30:49PM +0000, Mingwei Zhang wrote:

> @@ -1822,7 +1835,7 @@ extern int perf_event_period(struct perf_event *event, u64 value);
>  extern u64 perf_event_pause(struct perf_event *event, bool reset);
>  int perf_get_mediated_pmu(void);
>  void perf_put_mediated_pmu(void);
> -void perf_guest_enter(void);
> +void perf_guest_enter(u32 guest_lvtpc);
>  void perf_guest_exit(void);
>  #else /* !CONFIG_PERF_EVENTS: */
>  static inline void *
> @@ -1921,7 +1934,7 @@ static inline int perf_get_mediated_pmu(void)
>  }
>  
>  static inline void perf_put_mediated_pmu(void)			{ }
> -static inline void perf_guest_enter(void)			{ }
> +static inline void perf_guest_enter(u32 guest_lvtpc)		{ }
>  static inline void perf_guest_exit(void)			{ }
>  #endif
>  
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index d05487d465c9..406b86641f02 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -451,6 +451,7 @@ static inline bool is_include_guest_event(struct perf_event *event)
>  static LIST_HEAD(pmus);
>  static DEFINE_MUTEX(pmus_lock);
>  static struct srcu_struct pmus_srcu;
> +static DEFINE_PER_CPU(struct mediated_pmus_list, mediated_pmus);
>  static cpumask_var_t perf_online_mask;
>  static cpumask_var_t perf_online_core_mask;
>  static cpumask_var_t perf_online_die_mask;
> @@ -6053,8 +6054,26 @@ static inline void perf_host_exit(struct perf_cpu_context *cpuctx)
>  	}
>  }
>  
> +static void perf_switch_guest_ctx(bool enter, u32 guest_lvtpc)
> +{
> +	struct mediated_pmus_list *pmus = this_cpu_ptr(&mediated_pmus);
> +	struct perf_cpu_pmu_context *cpc;
> +	struct pmu *pmu;
> +
> +	lockdep_assert_irqs_disabled();
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(cpc, &pmus->list, mediated_entry) {
> +		pmu = cpc->epc.pmu;
> +
> +		if (pmu->switch_guest_ctx)
> +			pmu->switch_guest_ctx(enter, (void *)&guest_lvtpc);
> +	}
> +	rcu_read_unlock();
> +}
> +
>  /* When entering a guest, schedule out all exclude_guest events. */
> -void perf_guest_enter(void)
> +void perf_guest_enter(u32 guest_lvtpc)
>  {
>  	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
>  
> @@ -6067,6 +6086,8 @@ void perf_guest_enter(void)
>  
>  	perf_host_exit(cpuctx);
>  
> +	perf_switch_guest_ctx(true, guest_lvtpc);
> +
>  	__this_cpu_write(perf_in_guest, true);
>  
>  unlock:

This, I'm still utterly hating on that lvtpc argument. That doesn't
belong here. Make it go away.


