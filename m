Return-Path: <linux-kselftest+bounces-33002-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C029AB7B05
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 03:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D0233A6E25
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 01:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99C52698BC;
	Thu, 15 May 2025 01:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nrIQ3ubH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BBCC120;
	Thu, 15 May 2025 01:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747273082; cv=none; b=s35kf+K8sl+KJDnqpMi5jtfLmiCYISWiaaPX5vxE7j/1NZzj10meIS35BA7StkKcWy5MzY4HyJKGVp0V6xKxNACfdbMNnRJylae9rQiDiWlGo1I7B0KCtcuMMJCqJyHh+ObUwP1VV40yGAxTHNCtr6mkc/+n3g19sbc8PFa9jzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747273082; c=relaxed/simple;
	bh=xOSeYrXau29zTx6zUm7b4zJoapK6+0FTr9IlmoOkFKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bE+oLDfe0QoK5DUJ26+QH+h7GuxHqTX4AviZnHqajIMLNkntreIg31eK1gJbQd4aeL2RYDL0iem1JwRv95LQYRljJ7tT2YGrdAE9RI6n9/lg/exP3D3JTeda+ith/7D4JLhOLadfUOsZIrd4LouE1Et9rSoTQUrxxLqnWdXufvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nrIQ3ubH; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747273081; x=1778809081;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xOSeYrXau29zTx6zUm7b4zJoapK6+0FTr9IlmoOkFKE=;
  b=nrIQ3ubHeq366E/YpHgM6L5kyH27DnMWnKq6SkZOQQ3Gd7STtueHbM4v
   W8Va4KRkFBa4BxFgREvS0YuYblzCXvw9BBsAm69o7IKMm/kJuQD/eWP/a
   EqV61hxJoaLi1D40oiaSOzoXJaPoy0o56nTry3DrdqWbtUlwIQo3EmNpw
   vsjT7IZXbNMwCdYhn+8z1OHlRljbXQdOBl30fq3CpAU0layYmMnnzk23h
   z8o6D8iU25+gkU1ZPw1rgiLSQyUzXavmUAyh62i0T1O/yZ4IhhmKr3v2f
   eh24mQK54DLDLQsOPdV/mNVRgOffEVcOZE027df7kmI1KjoIWUiPyzEG9
   w==;
X-CSE-ConnectionGUID: jl2Ew/dXTAGU7Rs7PMoeVQ==
X-CSE-MsgGUID: MK5LL6+GSgudRV/xCqmhtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49091931"
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; 
   d="scan'208";a="49091931"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 18:38:00 -0700
X-CSE-ConnectionGUID: isVL1dxrT4+0bmq8Mooq2Q==
X-CSE-MsgGUID: 18S5v3y8RFqWX4ndHRYyOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; 
   d="scan'208";a="138085046"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 18:37:53 -0700
Message-ID: <18c9faf4-82ca-4ab3-9a63-4ac553d7b23c@linux.intel.com>
Date: Thu, 15 May 2025 09:37:51 +0800
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
 Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Yongwei Ma <yongwei.ma@intel.com>,
 Xiong Zhang <xiong.y.zhang@linux.intel.com>,
 Jim Mattson <jmattson@google.com>, Sandipan Das <sandipan.das@amd.com>,
 Zide Chen <zide.chen@intel.com>, Eranian Stephane <eranian@google.com>,
 Shukla Manali <Manali.Shukla@amd.com>,
 Nikunj Dadhania <nikunj.dadhania@amd.com>
References: <20250324173121.1275209-1-mizhang@google.com>
 <20250324173121.1275209-6-mizhang@google.com>
 <20250425111352.GF1166@noisy.programming.kicks-ass.net>
 <aCUlCApeDM9Uy4a0@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aCUlCApeDM9Uy4a0@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/15/2025 7:19 AM, Sean Christopherson wrote:
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
>> This naming is confusing on purpose? Pick either guest/host and stick
>> with it.
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
> unlock:
> 	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
> }
> EXPORT_SYMBOL_GPL(perf_put_guest_context);

I'm fine with the name. Thanks.


>

