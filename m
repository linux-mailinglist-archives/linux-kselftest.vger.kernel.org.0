Return-Path: <linux-kselftest+bounces-33138-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CC8AB90B7
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 22:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 881FA7A2114
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 20:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC967299933;
	Thu, 15 May 2025 20:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AoH0tVYJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E944620E01E;
	Thu, 15 May 2025 20:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747340327; cv=none; b=JJc0drdqIG/CriEtw01ylytQjDibsXrmrneohuX8lVEjGyuJ5NTXvjnaUJqvtCQX/B9glYLu74Zg3aFVenHvssY8K+Dtn1fDtdQ4QD7joaFv7iq9U2T6BF1BI/DdCJUAWbg7LRJkNqjAqSPlME1hWYDQWQoSGHo+1ownueR04Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747340327; c=relaxed/simple;
	bh=e8VPoJkwXD3AP4H3TxTUB4GInywCmwAIcDUvwqYyTfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FW8iwn1aEFpfHe17bzPbG429DbcBdapAjmyYXeAG/icD7eUhVpvrYwK6u2gsxpYWSoQkySPnEvCrFFdwMon89QxQKp3jfmKlIVXsa+I3zzYlJ61nxnohiExhJMPiurBEaFHmVEdknnz6kuZrBxkrOOoxf6XPRC60Oe5fsSuOFk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AoH0tVYJ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747340326; x=1778876326;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e8VPoJkwXD3AP4H3TxTUB4GInywCmwAIcDUvwqYyTfQ=;
  b=AoH0tVYJ1mXZIJNBtv9F3zv+LadqiNrJlSuAfnfXZYlJKut570CyqFJ5
   oaAIv/bR0RcSFd+d6pjZRlrOZwXRgbTKMKWCM8WEMsrLgvpmIy3xGC7t+
   AMGO+yDLfhLHWMoZJikgds9oNCFcgknD3BxuW/CsWgczusiNkCi+BgPOz
   bbk44ysXdDZUlk36rGQqWLObqmHCL9swPVsaMdVoptdo5AzJSG0TMPwnU
   v0J9WO4rCEijmI69iLJ2SKRoxrK4C03ZOd3w2Y3yqi+qU6fQlPBnHnWgR
   bZvMhu1fKjBlKojKoING/BTDvx7t1yCi59mLqJhmvd+bOdjn9fSABJ3v8
   w==;
X-CSE-ConnectionGUID: 37K0IjaQQJukvHI78Xc5pg==
X-CSE-MsgGUID: 6OvfaBV7Ti2lgCDIMigzEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="49436556"
X-IronPort-AV: E=Sophos;i="6.15,292,1739865600"; 
   d="scan'208";a="49436556"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 13:18:45 -0700
X-CSE-ConnectionGUID: p8mOqcKMRYi6r7cTUhwM8w==
X-CSE-MsgGUID: X5QS9obXTdO+br/+BUZi0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,292,1739865600"; 
   d="scan'208";a="169553526"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 13:18:44 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 8E33720B5736;
	Thu, 15 May 2025 13:18:41 -0700 (PDT)
Message-ID: <dcfdde37-dd39-4151-84f9-c389b897d2fa@linux.intel.com>
Date: Thu, 15 May 2025 16:18:40 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/38] perf: Add generic exclude_guest support
To: Sean Christopherson <seanjc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Mingwei Zhang
 <mizhang@google.com>, Ingo Molnar <mingo@redhat.com>,
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
 <4aaf67ab-aa5c-41e6-bced-3cb000172c52@linux.intel.com>
 <aCY_tkjzxknAbEgq@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <aCY_tkjzxknAbEgq@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-05-15 3:25 p.m., Sean Christopherson wrote:
> On Thu, May 15, 2025, Kan Liang wrote:
>> On 2025-05-14 7:19 p.m., Sean Christopherson wrote:
>>>> This naming is confusing on purpose? Pick either guest/host and stick
>>>> with it.
>>>
>>> +1.  I also think the inner perf_host_{enter,exit}() helpers are superflous.
>>> These flows
>>>
>>> After a bit of hacking, and with a few spoilers, this is what I ended up with
>>> (not anywhere near fully tested).  I like following KVM's kvm_xxx_{load,put}()
>>> nomenclature to tie everything together, so I went with "guest" instead of "host"
>>> even though the majority of work being down is to shedule out/in host context.
>>>
>>> /* When loading a guest's mediated PMU, schedule out all exclude_guest events. */
>>> void perf_load_guest_context(unsigned long data)
>>> {
>>> 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
>>>
>>> 	lockdep_assert_irqs_disabled();
>>>
>>> 	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
>>>
>>> 	if (WARN_ON_ONCE(__this_cpu_read(guest_ctx_loaded)))
>>> 		goto unlock;
>>>
>>> 	perf_ctx_disable(&cpuctx->ctx, EVENT_GUEST);
>>> 	ctx_sched_out(&cpuctx->ctx, NULL, EVENT_GUEST);
>>> 	perf_ctx_enable(&cpuctx->ctx, EVENT_GUEST);
>>> 	if (cpuctx->task_ctx) {
>>> 		perf_ctx_disable(cpuctx->task_ctx, EVENT_GUEST);
>>> 		task_ctx_sched_out(cpuctx->task_ctx, NULL, EVENT_GUEST);
>>> 		perf_ctx_enable(cpuctx->task_ctx, EVENT_GUEST);
>>> 	}
>>>
>>> 	arch_perf_load_guest_context(data);
>>>
>>> 	__this_cpu_write(guest_ctx_loaded, true);
>>>
>>> unlock:
>>> 	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
>>> }
>>> EXPORT_SYMBOL_GPL(perf_load_guest_context);
>>>
>>> void perf_put_guest_context(void)
>>> {
>>> 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
>>>
>>> 	lockdep_assert_irqs_disabled();
>>>
>>> 	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
>>>
>>> 	if (WARN_ON_ONCE(!__this_cpu_read(guest_ctx_loaded)))
>>> 		goto unlock;
>>>
>>> 	arch_perf_put_guest_context();
>>
>> It will set the guest_ctx_loaded to false.
>> The update_context_time() invoked in the perf_event_sched_in() will not
>> get a chance to update the guest time.
> 
> The guest_ctx_loaded in arch/x86/events/core.c is a different variable, it just
> happens to have the same name.
>

Ah, I thought it was the same variable. Then there should be no issue
with the guest time.

But the same variable name may bring confusions. Maybe add a x86_pmu/x86
prefix to the variable in x86 code.
> It's completely gross, but exposing guest_ctx_loaded outside of kernel/events/core.c
> didn't seem like a great alternative.  If we wanted to use a single variable,
> then the writes in arch_perf_{load,put}_guest_context() can simply go away.
> 
Either two variables or a single variable is fine with me, as long as
they can be easily distinguished.

But I think we should put arch_perf_{load,put}_guest_context() and
guest_ctx_loaded between the perf_ctx_disable/enable() pair.
Perf should only update the state when PMU is completely disabled.
It matches the way the rest of the perf code does.
It could also avoid some potential issues, e.g., the state is not
updated completely, but the counter has already been fired.

Thanks,
Kan



