Return-Path: <linux-kselftest+bounces-33005-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28957AB7B4E
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 03:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C8A54C2B77
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 01:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C8D220F25;
	Thu, 15 May 2025 01:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cgFQjm87"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D971A275;
	Thu, 15 May 2025 01:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747273974; cv=none; b=FeeVQSyb+oLammM7fK2J7Te8nchXCQo1c33f/MWV71IlaASPe9C9t3JkVag70VvueiXGaTHtGFcLJYqEfzMfvGGyqKJlvBQSISNkDYheNkFZT/67Lyfmo/HlXL/B1EiSeelWbDB93tSXRdZ+MnUYjWE0+TghuZ9lvKcHezZhbsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747273974; c=relaxed/simple;
	bh=EkUi/0hwkbLtBsg8lJHQqIelK4wOwnR2ANtJyJmJ4u8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EPbhht3crPDzxDFnwSLzNN+WhB7IMxQPl3tvjgBH1EbZw2kc9CPtWbGEdzRul6/QYuHL7VN3oKG2kzCsnXFWVNBWw96Ux839YS75BrjvqepDsvGBQrPAGJfnH+Skwx7MsiynX1XDwkym/5lhdlii4CX4qgk13xTc0UGo0pSL/H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cgFQjm87; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747273972; x=1778809972;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EkUi/0hwkbLtBsg8lJHQqIelK4wOwnR2ANtJyJmJ4u8=;
  b=cgFQjm87IX9WyFjeYrNJIyEGoM99R5Ffq/qquvpjy4inSHWsU/GOM6rg
   9owB74Frq4i+FWzOgSEircl3synr9jT29x7juRVFwNIdwhD+ZClQtPFXn
   8LRrznGqo39MHLfwHAOR+RrD7yNoJy0ykqva3pi6NGtd2ImzlEUyISiM8
   Hs4uUHjXeVve2aIAybKXntuyvT6bsA4kfA+ZzuI2pEvsnYoeeq9gpxZlY
   PbhA6KA0kiaCSj71l3kZVRHFreEMw3VN049HvXlctl7nsAVYm/lJcc/Jv
   MBP1DOAXhkYoXtsEm+7kI8MUC0Hp5Us2dqi5ep3YNbyDGhIYj3EymNhDy
   g==;
X-CSE-ConnectionGUID: kEBW6c4lRNSQkuqjPsdssw==
X-CSE-MsgGUID: QVTtq1WwSo2meQblLFvebw==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49333268"
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; 
   d="scan'208";a="49333268"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 18:52:51 -0700
X-CSE-ConnectionGUID: FhzMvd8CSJmkzYaz3MrsJQ==
X-CSE-MsgGUID: 16/iMrq3TNaSkcA/KQR65w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; 
   d="scan'208";a="143179303"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 18:52:45 -0700
Message-ID: <bbe43afc-572c-4ae6-825a-9f98d71e46ec@linux.intel.com>
Date: Thu, 15 May 2025 09:52:42 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/38] perf/x86: Forbid PMI handler when guest own PMU
To: Sean Christopherson <seanjc@google.com>,
 Mingwei Zhang <mizhang@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
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
 <20250324173121.1275209-12-mizhang@google.com> <aCUukXIC_9cxHQd3@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aCUukXIC_9cxHQd3@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/15/2025 8:00 AM, Sean Christopherson wrote:
> On Mon, Mar 24, 2025, Mingwei Zhang wrote:
>> If a guest PMI is delivered after VM-exit, the KVM maskable interrupt will
>> be held pending until EFLAGS.IF is set. In the meantime, if the logical
>> processor receives an NMI for any reason at all, perf_event_nmi_handler()
>> will be invoked. If there is any active perf event anywhere on the system,
>> x86_pmu_handle_irq() will be invoked, and it will clear
>> IA32_PERF_GLOBAL_STATUS. By the time KVM's PMI handler is invoked, it will
>> be a mystery which counter(s) overflowed.
>>
>> When LVTPC is using KVM PMI vecotr, PMU is owned by guest, Host NMI let
>> x86_pmu_handle_irq() run, x86_pmu_handle_irq() restore PMU vector to NMI
>> and clear IA32_PERF_GLOBAL_STATUS, this breaks guest vPMU passthrough
>> environment.
>>
>> So modify perf_event_nmi_handler() to check perf_in_guest per cpu variable,
>> and if so, to simply return without calling x86_pmu_handle_irq().
>>
>> Suggested-by: Jim Mattson <jmattson@google.com>
>> Signed-off-by: Mingwei Zhang <mizhang@google.com>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  arch/x86/events/core.c | 27 +++++++++++++++++++++++++--
>>  1 file changed, 25 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index 28161d6ff26d..96a173bbbec2 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
>> @@ -54,6 +54,8 @@ DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events) = {
>>  	.pmu = &pmu,
>>  };
>>  
>> +static DEFINE_PER_CPU(bool, pmi_vector_is_nmi) = true;
> I strongly prefer guest_ctx_loaded.  pmi_vector_is_nmi very inflexible and
> doesn't communicate *why* perf's NMI handler needs to ignore NMIs

Sure.


>
>>  DEFINE_STATIC_KEY_FALSE(rdpmc_never_available_key);
>>  DEFINE_STATIC_KEY_FALSE(rdpmc_always_available_key);
>>  DEFINE_STATIC_KEY_FALSE(perf_is_hybrid);
>> @@ -1737,6 +1739,24 @@ perf_event_nmi_handler(unsigned int cmd, struct pt_regs *regs)
>>  	u64 finish_clock;
>>  	int ret;
>>  
>> +	/*
>> +	 * When guest pmu context is loaded this handler should be forbidden from
>> +	 * running, the reasons are:
>> +	 * 1. After perf_guest_enter() is called, and before cpu enter into
>> +	 *    non-root mode, host non-PMI NMI could happen, but x86_pmu_handle_irq()
>> +	 *    restore PMU to use NMI vector, which destroy KVM PMI vector setting.
>> +	 * 2. When VM is running, host non-PMI NMI causes VM exit, KVM will
>> +	 *    call host NMI handler (vmx_vcpu_enter_exit()) first before KVM save
>> +	 *    guest PMU context (kvm_pmu_put_guest_context()), as x86_pmu_handle_irq()
>> +	 *    clear global_status MSR which has guest status now, then this destroy
>> +	 *    guest PMU status.
>> +	 * 3. After VM exit, but before KVM save guest PMU context, host non-PMI NMI
>> +	 *    could happen, x86_pmu_handle_irq() clear global_status MSR which has
>> +	 *    guest status now, then this destroy guest PMU status.
>> +	 */
> This *might* be useful for a changelog, but even then it's probably overkill.
> NMIs can happen at any time, that's the full the story.  Enumerating the exact
> edge cases adds a lot of noise and not much value.

OK, we just want it to be understood more easily. :)


>

