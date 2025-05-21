Return-Path: <linux-kselftest+bounces-33486-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1C0ABFDB4
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 22:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24F7F1B64F2E
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 20:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CF328FA96;
	Wed, 21 May 2025 20:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NthqHSec"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97859221FB3;
	Wed, 21 May 2025 20:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747858342; cv=none; b=dFPJOcbzwrKNhxH5MiZI6P1jIcAH2Hi0Gb8ckeflDirN6vnry1kUrWcAFaXF75Pl+NbMWA4o5GTHqeHApho6XGZhS8G4TzbwFnEJoywKrJfVGiftXCpHY0plMoBbevsBg8/Yhw6wdvv2////2hB9VN/BGBYKA66lkZDtpy6edqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747858342; c=relaxed/simple;
	bh=Ti/jGpIFtUi/Ap6FZTb/37u6XnIEqTk/wXTVcbJXyF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UOzYNl1DI7wOjFgHFkpoP2LRXzd71iTuqtTqjuhPvyIGxIycF5hiBzfvy/WPbZjy95qaNwharae3w63ymY1mKeouSUwfG5de9Esc4yGOd/K/xKBbKzfKdOwtWNjWNQsgJIJCCdH0B9hU1EIlGsBvbyGVlsNH+EUjrKAkpVWOAzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NthqHSec; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747858341; x=1779394341;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ti/jGpIFtUi/Ap6FZTb/37u6XnIEqTk/wXTVcbJXyF0=;
  b=NthqHSec6BrAqmPNf8f0VYMpd5UbHjcl1bPTIe8CIUnP0v7yOxexbujG
   ekffz12UBi3XqqGDpbKqz2ByzbxUQvY9AGT4SYYssRFx5q3XW/6gh41gi
   qheMj3IvC+nT2QQfNAg8cb9joRIgH72+wC+8U8cRdqh1rcJp9JkE2Kdlz
   T64iwnTxNQAoWPlaXiYJUbrRFEOmAKGhEPY8nuFYh6EWYuZNGNXzV5WX2
   madXj2rNVwd8dXtnWBpD9Gc/3Pjxgty3JyM5NbA8RDwarX72J5fMIJU8R
   QJuEr0Ja+Q3+FWk5MfWhJygu0JYe4ERstuYAB86DH7X3kjw98gWBmaBKK
   g==;
X-CSE-ConnectionGUID: vOCerZ0xS1qpcsS+w9DwgQ==
X-CSE-MsgGUID: TuZ6HsbRQpqCm4blGBkAJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="49844469"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="49844469"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 13:12:20 -0700
X-CSE-ConnectionGUID: iBZeE0jgTUi2pFpSYutiDA==
X-CSE-MsgGUID: mLWseC/HRF2HgQ3nC46w+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="140078715"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 13:12:19 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 19EBE20B5736;
	Wed, 21 May 2025 13:12:17 -0700 (PDT)
Message-ID: <1513350b-7de3-405a-b6c5-fcaf9efebf3b@linux.intel.com>
Date: Wed, 21 May 2025 16:12:15 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/38] perf: Add generic exclude_guest support
To: Namhyung Kim <namhyung@kernel.org>, Mingwei Zhang <mizhang@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
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
 <20250324173121.1275209-6-mizhang@google.com> <aC4vyIpKk6m2nz8-@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <aC4vyIpKk6m2nz8-@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-05-21 3:55 p.m., Namhyung Kim wrote:
> On Mon, Mar 24, 2025 at 05:30:45PM +0000, Mingwei Zhang wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Only KVM knows the exact time when a guest is entering/exiting. Expose
>> two interfaces to KVM to switch the ownership of the PMU resources.
>>
>> All the pinned events must be scheduled in first. Extend the
>> perf_event_sched_in() helper to support extra flag, e.g., EVENT_GUEST.
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> Signed-off-by: Mingwei Zhang <mizhang@google.com>
>> ---
>>  include/linux/perf_event.h |  4 ++
>>  kernel/events/core.c       | 80 ++++++++++++++++++++++++++++++++++----
>>  2 files changed, 77 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index 7bda1e20be12..37187ee8e226 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -1822,6 +1822,8 @@ extern int perf_event_period(struct perf_event *event, u64 value);
>>  extern u64 perf_event_pause(struct perf_event *event, bool reset);
>>  int perf_get_mediated_pmu(void);
>>  void perf_put_mediated_pmu(void);
>> +void perf_guest_enter(void);
>> +void perf_guest_exit(void);
>>  #else /* !CONFIG_PERF_EVENTS: */
>>  static inline void *
>>  perf_aux_output_begin(struct perf_output_handle *handle,
>> @@ -1919,6 +1921,8 @@ static inline int perf_get_mediated_pmu(void)
>>  }
>>  
>>  static inline void perf_put_mediated_pmu(void)			{ }
>> +static inline void perf_guest_enter(void)			{ }
>> +static inline void perf_guest_exit(void)			{ }
>>  #endif
>>  
>>  #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 7a2115b2c5c1..d05487d465c9 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -2827,14 +2827,15 @@ static void task_ctx_sched_out(struct perf_event_context *ctx,
>>  
>>  static void perf_event_sched_in(struct perf_cpu_context *cpuctx,
>>  				struct perf_event_context *ctx,
>> -				struct pmu *pmu)
>> +				struct pmu *pmu,
>> +				enum event_type_t event_type)
>>  {
>> -	ctx_sched_in(&cpuctx->ctx, pmu, EVENT_PINNED);
>> +	ctx_sched_in(&cpuctx->ctx, pmu, EVENT_PINNED | event_type);
>>  	if (ctx)
>> -		 ctx_sched_in(ctx, pmu, EVENT_PINNED);
>> -	ctx_sched_in(&cpuctx->ctx, pmu, EVENT_FLEXIBLE);
>> +		ctx_sched_in(ctx, pmu, EVENT_PINNED | event_type);
>> +	ctx_sched_in(&cpuctx->ctx, pmu, EVENT_FLEXIBLE | event_type);
>>  	if (ctx)
>> -		 ctx_sched_in(ctx, pmu, EVENT_FLEXIBLE);
>> +		ctx_sched_in(ctx, pmu, EVENT_FLEXIBLE | event_type);
>>  }
>>  
>>  /*
>> @@ -2890,7 +2891,7 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
>>  	else if (event_type & EVENT_PINNED)
>>  		ctx_sched_out(&cpuctx->ctx, pmu, EVENT_FLEXIBLE);
>>  
>> -	perf_event_sched_in(cpuctx, task_ctx, pmu);
>> +	perf_event_sched_in(cpuctx, task_ctx, pmu, 0);
>>  
>>  	for_each_epc(epc, &cpuctx->ctx, pmu, 0)
>>  		perf_pmu_enable(epc->pmu);
>> @@ -4188,7 +4189,7 @@ static void perf_event_context_sched_in(struct task_struct *task)
>>  		ctx_sched_out(&cpuctx->ctx, NULL, EVENT_FLEXIBLE);
>>  	}
>>  
>> -	perf_event_sched_in(cpuctx, ctx, NULL);
>> +	perf_event_sched_in(cpuctx, ctx, NULL, 0);
>>  
>>  	perf_ctx_sched_task_cb(cpuctx->task_ctx, true);
>>  
>> @@ -6040,6 +6041,71 @@ void perf_put_mediated_pmu(void)
>>  }
>>  EXPORT_SYMBOL_GPL(perf_put_mediated_pmu);
>>  
>> +static inline void perf_host_exit(struct perf_cpu_context *cpuctx)
>> +{
>> +	perf_ctx_disable(&cpuctx->ctx, EVENT_GUEST);
>> +	ctx_sched_out(&cpuctx->ctx, NULL, EVENT_GUEST);
>> +	perf_ctx_enable(&cpuctx->ctx, EVENT_GUEST);
>> +	if (cpuctx->task_ctx) {
>> +		perf_ctx_disable(cpuctx->task_ctx, EVENT_GUEST);
>> +		task_ctx_sched_out(cpuctx->task_ctx, NULL, EVENT_GUEST);
>> +		perf_ctx_enable(cpuctx->task_ctx, EVENT_GUEST);
>> +	}
>> +}
> 
> Cpu context and task context may have events in the same PMU.
> How about this?
> 
> 	perf_ctx_disable(&cpuctx->ctx, EVENT_GUEST);
> 	if (cpuctx->task_ctx)
> 		perf_ctx_disable(cpuctx->task_ctx, EVENT_GUEST);
> 
> 	ctx_sched_out(&cpuctx->ctx, NULL, EVENT_GUEST);
> 	if (cpuctx->task_ctx)
> 		task_ctx_sched_out(cpuctx->task_ctx, NULL, EVENT_GUEST);
> 
> 	if (cpuctx->task_ctx)
> 		perf_ctx_enable(cpuctx->task_ctx, EVENT_GUEST);
> 	perf_ctx_enable(&cpuctx->ctx, EVENT_GUEST);
> 

Yes, this is what has to be fixed in V4.

No matter for load context or put context, I think the below steps have
to be followed.
- Disable both cpuctx->ctx and cpuctx->task_ctx
- schedule in/out host counters and load/put guest countext
- Enable both cpuctx->ctx and cpuctx->task_ctx

A similar proposed can be found at
https://lore.kernel.org/lkml/4aaf67ab-aa5c-41e6-bced-3cb000172c52@linux.intel.com/

Thanks,
Kan


