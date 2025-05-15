Return-Path: <linux-kselftest+bounces-33109-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 530E7AB8F30
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 20:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F08701BA1A46
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 18:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80F42690E0;
	Thu, 15 May 2025 18:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kYJ/zPjj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA19821CA07;
	Thu, 15 May 2025 18:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747334367; cv=none; b=VaXyuYFrbsTpbk+3LIE2Cgc5cbg0Xn9tQp1+or1YOrV5B90Mzlj6f1Z3qV5eML4Jgm4KWSM1qIBG8n9ws4y7GNPcfwUz6cD0vZ3LYXXACny+rHsZOJ4pWh0FAz+2K5zhF7k0wa4yhO/v42XICBkuSrgsJAK58X+m08314ftBooU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747334367; c=relaxed/simple;
	bh=RmNrUco0zxz/y4TKei1Fbe1gISOzYB3qxdMUh9Ndukc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ilvmcjKoxGB6klAAwiF3Jemc5laMXQ7pAz7gRNlQ+ArHXxk3tHKH9J3nTBuWM3ubeUj3Re0iGenKwL9ymPLKWq5CcjO6Gjv39hwYij2B7FRcdd8TcmIJ2ysIh8s1FdG2E1cZ2roe9lgoTQ6Nk88Ps1u9xDadkVGmjPJsWRFC9qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kYJ/zPjj; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747334366; x=1778870366;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RmNrUco0zxz/y4TKei1Fbe1gISOzYB3qxdMUh9Ndukc=;
  b=kYJ/zPjj9cy+GDjpiNTlf85ZBmfjeSyAv/e25Y/Gsyl9WPVkm59wphva
   jE80mvPRK66rFE1SLBZCPwTDiV/5p/nKAkOL+joH+9KrlyhJ7M/mpEeMK
   4L7g3NZXjk9cZsOgHk8H+bjvBoTQmDS0YcYiykdV14JPnKOGNmjCqd8ek
   GdCXSGQmkNOmk/uJuK+WZau7NFpLwayo7DoiotYwRYQbpDJlx7AgmWR77
   eRROqL1a661JRZA9df1caXZ/GZwGZ4o+PUXKjBaqEqbb2pGFObl2BlHWB
   ggQeCXPe8vbUs9Mfq9zMIWeYBYN31qDn1Ite8mVyxnKsZol9rt3wI4Sz1
   w==;
X-CSE-ConnectionGUID: nO+rdsScQamkYaqryIT69w==
X-CSE-MsgGUID: FFLvCVVJQLaCQtYabVs1LA==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="49161438"
X-IronPort-AV: E=Sophos;i="6.15,292,1739865600"; 
   d="scan'208";a="49161438"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 11:39:26 -0700
X-CSE-ConnectionGUID: /hvQEoTZRM68LLzqRtoI+A==
X-CSE-MsgGUID: o/DXloZFTNC8zWnTsiU6xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,292,1739865600"; 
   d="scan'208";a="138354531"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 11:39:24 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 6CF2D20B5736;
	Thu, 15 May 2025 11:39:21 -0700 (PDT)
Message-ID: <4aaf67ab-aa5c-41e6-bced-3cb000172c52@linux.intel.com>
Date: Thu, 15 May 2025 14:39:20 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/38] perf: Add generic exclude_guest support
To: Sean Christopherson <seanjc@google.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Mingwei Zhang <mizhang@google.com>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com,
 "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Yongwei Ma <yongwei.ma@intel.com>,
 Xiong Zhang <xiong.y.zhang@linux.intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Jim Mattson <jmattson@google.com>,
 Sandipan Das <sandipan.das@amd.com>, Zide Chen <zide.chen@intel.com>,
 Eranian Stephane <eranian@google.com>, Shukla Manali
 <Manali.Shukla@amd.com>, Nikunj Dadhania <nikunj.dadhania@amd.com>
References: <20250324173121.1275209-1-mizhang@google.com>
 <20250324173121.1275209-6-mizhang@google.com>
 <20250425111352.GF1166@noisy.programming.kicks-ass.net>
 <aCUlCApeDM9Uy4a0@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <aCUlCApeDM9Uy4a0@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-05-14 7:19 p.m., Sean Christopherson wrote:
> On Fri, Apr 25, 2025, Peter Zijlstra wrote:
>> On Mon, Mar 24, 2025 at 05:30:45PM +0000, Mingwei Zhang wrote:
>>
>>> @@ -6040,6 +6041,71 @@ void perf_put_mediated_pmu(void)
>>>  }
>>>  EXPORT_SYMBOL_GPL(perf_put_mediated_pmu);
>>>  
>>> +static inline void perf_host_exit(struct perf_cpu_context *cpuctx)
>>> +{
>>> +	perf_ctx_disable(&cpuctx->ctx, EVENT_GUEST);
>>> +	ctx_sched_out(&cpuctx->ctx, NULL, EVENT_GUEST);
>>> +	perf_ctx_enable(&cpuctx->ctx, EVENT_GUEST);
>>> +	if (cpuctx->task_ctx) {
>>> +		perf_ctx_disable(cpuctx->task_ctx, EVENT_GUEST);
>>> +		task_ctx_sched_out(cpuctx->task_ctx, NULL, EVENT_GUEST);
>>> +		perf_ctx_enable(cpuctx->task_ctx, EVENT_GUEST);
>>> +	}
>>> +}
>>> +
>>> +/* When entering a guest, schedule out all exclude_guest events. */
>>> +void perf_guest_enter(void)
>>> +{
>>> +	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
>>> +
>>> +	lockdep_assert_irqs_disabled();
>>> +
>>> +	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
>>> +
>>> +	if (WARN_ON_ONCE(__this_cpu_read(perf_in_guest)))
>>> +		goto unlock;
>>> +
>>> +	perf_host_exit(cpuctx);
>>> +
>>> +	__this_cpu_write(perf_in_guest, true);
>>> +
>>> +unlock:
>>> +	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
>>> +}
>>> +EXPORT_SYMBOL_GPL(perf_guest_enter);
>>> +
>>> +static inline void perf_host_enter(struct perf_cpu_context *cpuctx)
>>> +{
>>> +	perf_ctx_disable(&cpuctx->ctx, EVENT_GUEST);
>>> +	if (cpuctx->task_ctx)
>>> +		perf_ctx_disable(cpuctx->task_ctx, EVENT_GUEST);
>>> +
>>> +	perf_event_sched_in(cpuctx, cpuctx->task_ctx, NULL, EVENT_GUEST);
>>> +
>>> +	if (cpuctx->task_ctx)
>>> +		perf_ctx_enable(cpuctx->task_ctx, EVENT_GUEST);
>>> +	perf_ctx_enable(&cpuctx->ctx, EVENT_GUEST);
>>> +}
>>> +
>>> +void perf_guest_exit(void)
>>> +{
>>> +	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
>>> +
>>> +	lockdep_assert_irqs_disabled();
>>> +
>>> +	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
>>> +
>>> +	if (WARN_ON_ONCE(!__this_cpu_read(perf_in_guest)))
>>> +		goto unlock;
>>> +
>>> +	perf_host_enter(cpuctx);
>>> +
>>> +	__this_cpu_write(perf_in_guest, false);
>>> +unlock:
>>> +	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
>>> +}
>>> +EXPORT_SYMBOL_GPL(perf_guest_exit);
>>
>> This naming is confusing on purpose? Pick either guest/host and stick
>> with it.
> 
> +1.  I also think the inner perf_host_{enter,exit}() helpers are superflous.
> These flows
> 
> After a bit of hacking, and with a few spoilers, this is what I ended up with
> (not anywhere near fully tested).  I like following KVM's kvm_xxx_{load,put}()
> nomenclature to tie everything together, so I went with "guest" instead of "host"
> even though the majority of work being down is to shedule out/in host context.
> 
> /* When loading a guest's mediated PMU, schedule out all exclude_guest events. */
> void perf_load_guest_context(unsigned long data)
> {
> 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
> 
> 	lockdep_assert_irqs_disabled();
> 
> 	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
> 
> 	if (WARN_ON_ONCE(__this_cpu_read(guest_ctx_loaded)))
> 		goto unlock;
> 
> 	perf_ctx_disable(&cpuctx->ctx, EVENT_GUEST);
> 	ctx_sched_out(&cpuctx->ctx, NULL, EVENT_GUEST);
> 	perf_ctx_enable(&cpuctx->ctx, EVENT_GUEST);
> 	if (cpuctx->task_ctx) {
> 		perf_ctx_disable(cpuctx->task_ctx, EVENT_GUEST);
> 		task_ctx_sched_out(cpuctx->task_ctx, NULL, EVENT_GUEST);
> 		perf_ctx_enable(cpuctx->task_ctx, EVENT_GUEST);
> 	}
> 
> 	arch_perf_load_guest_context(data);
> 
> 	__this_cpu_write(guest_ctx_loaded, true);
> 
> unlock:
> 	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
> }
> EXPORT_SYMBOL_GPL(perf_load_guest_context);
> 
> void perf_put_guest_context(void)
> {
> 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
> 
> 	lockdep_assert_irqs_disabled();
> 
> 	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
> 
> 	if (WARN_ON_ONCE(!__this_cpu_read(guest_ctx_loaded)))
> 		goto unlock;
> 
> 	arch_perf_put_guest_context();

It will set the guest_ctx_loaded to false.
The update_context_time() invoked in the perf_event_sched_in() will not
get a chance to update the guest time.

I think something as below should work.

- Disable all in the PMU (disable global control)
- schedule in the host counters (but not run yet since the global
control of the PMU is disabled)
- arch_perf_put_guest_context()
- Enable all in the PMU (Enable global control. The host counters now start)

void perf_put_guest_context(void)
{
	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);

	lockdep_assert_irqs_disabled();

	perf_ctx_lock(cpuctx, cpuctx->task_ctx);

	if (WARN_ON_ONCE(!__this_cpu_read(guest_ctx_loaded)))
		goto unlock;

	perf_ctx_disable(&cpuctx->ctx, EVENT_GUEST);
	if (cpuctx->task_ctx)
		perf_ctx_disable(cpuctx->task_ctx, EVENT_GUEST);

	perf_event_sched_in(cpuctx, cpuctx->task_ctx, NULL, EVENT_GUEST);

	arch_perf_put_guest_context();

	if (cpuctx->task_ctx)
		perf_ctx_enable(cpuctx->task_ctx, EVENT_GUEST);
	perf_ctx_enable(&cpuctx->ctx, EVENT_GUEST);

unlock:
	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
}



Similar to the perf_load_guest_context().

- Disable all in the PMU (disable global control)
- schedule out all the host counters
- arch_perf_load_guest_context()
- Enable all in the PMU (enable global control)

void perf_load_guest_context(unsigned long data)
{
	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);

	lockdep_assert_irqs_disabled();

	perf_ctx_lock(cpuctx, cpuctx->task_ctx);

	if (WARN_ON_ONCE(__this_cpu_read(guest_ctx_loaded)))
		goto unlock;

	perf_ctx_disable(&cpuctx->ctx, EVENT_GUEST);
	ctx_sched_out(&cpuctx->ctx, NULL, EVENT_GUEST);
	if (cpuctx->task_ctx) {
		perf_ctx_disable(cpuctx->task_ctx, EVENT_GUEST);
		task_ctx_sched_out(cpuctx->task_ctx, NULL, EVENT_GUEST);
	}

	arch_perf_load_guest_context(data);

	perf_ctx_enable(&cpuctx->ctx, EVENT_GUEST);
	if (cpuctx->task_ctx)
		perf_ctx_enable(cpuctx->task_ctx, EVENT_GUEST);
unlock:
	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
}


Thanks,
Kan

> 
> 	perf_ctx_disable(&cpuctx->ctx, EVENT_GUEST);
> 	if (cpuctx->task_ctx)
> 		perf_ctx_disable(cpuctx->task_ctx, EVENT_GUEST);
> 
> 	perf_event_sched_in(cpuctx, cpuctx->task_ctx, NULL, EVENT_GUEST);
> 
> 	if (cpuctx->task_ctx)
> 		perf_ctx_enable(cpuctx->task_ctx, EVENT_GUEST);
> 	perf_ctx_enable(&cpuctx->ctx, EVENT_GUEST);
> 
> 	__this_cpu_write(guest_ctx_loaded, false);
> unlock:> 	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
> }
> EXPORT_SYMBOL_GPL(perf_put_guest_context);


