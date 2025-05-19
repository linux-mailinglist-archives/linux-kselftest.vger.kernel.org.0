Return-Path: <linux-kselftest+bounces-33307-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5898ABB46C
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 07:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E18416F568
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 05:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6761F1507;
	Mon, 19 May 2025 05:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B+XTDIfh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0AA3595D;
	Mon, 19 May 2025 05:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747632082; cv=none; b=WoFSQEGGG4dw0wjZ2L2RawfKRkaZF9W5fcedR5nABnout9NrvWp7OuT913HiC9/qcG1YR3/eJkKiARdFLS3c25DJ5JgJrCRM5Zzlzo/5CusHN8/2M2NlvuhgJ+7FAH2jBqd8/G5uqpVRJb/lQQdCrNEpz7VzlptoaXW91t2e3Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747632082; c=relaxed/simple;
	bh=SY0Y7hYN39xgQcVqGaPVqYZ0mV3XyiT8xPuG0QcFo2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EygCJgn+DouUNfllVwLDSlliUagmd5WE/bxi9gZEh8bbVv8HFTmK7jfxMH33As4f6dva+998Y6tzwRquO/lWCJwZNnRGHHRMszHe79peKdeG2wwKCZm9x17yklXH2/HFt9CTwPY9r6Gblrg5R4KwwE8mk/2sHkAMItqC+NXQsBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B+XTDIfh; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747632081; x=1779168081;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SY0Y7hYN39xgQcVqGaPVqYZ0mV3XyiT8xPuG0QcFo2c=;
  b=B+XTDIfhcqW1OAJyexVvKh1XlAbs1f+uJCR0G4macooHP1J1bibo+9OH
   SV1LoiOovebp42ocLuN2jeUTEyjOjoow8xA+lj2DO7Trm4F0sU2ysTbG1
   yp/v1YxK84myNHoUvaWZREvGvqp4xKjBPYTc2zDKXJabXkUgdTYwGWWU8
   tPEhtO9zkzr0ZM1iS/5l9q40gMzpH6bYgdTgeJEtyjh+SBx9uVaMU0ZfG
   lXHzLMVeD1MriltVR9SyloHJNpkQShWxBPbYo0e6Nboer0MY/hjGIeEUc
   zfO/+i5ZWwxImD3UvAdglNsUX+9jmXTMDr287GsGOVlrqF6Mzz15bg85Q
   g==;
X-CSE-ConnectionGUID: s9MD7767Qz6eQcuBD4FFCQ==
X-CSE-MsgGUID: XieQkNdpSui4VnHgRBqwtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="49582890"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="49582890"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2025 22:21:17 -0700
X-CSE-ConnectionGUID: Nzk8Ek0NSROmy59+BkNG1g==
X-CSE-MsgGUID: okCR8U7+T1W2PHghfzmjtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="144238544"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2025 22:21:08 -0700
Message-ID: <5dc2527f-8fd4-4f66-8168-f2f9653a3712@linux.intel.com>
Date: Mon, 19 May 2025 13:21:05 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 24/38] KVM: x86/pmu: Exclude PMU MSRs in
 vmx_get_passthrough_msr_slot()
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
 <20250324173121.1275209-25-mizhang@google.com> <aCc_LmORNibXBt8V@google.com>
 <aCdPbZiYmtni4Bjs@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aCdPbZiYmtni4Bjs@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/16/2025 10:45 PM, Sean Christopherson wrote:
> On Fri, May 16, 2025, Sean Christopherson wrote:
>> On Mon, Mar 24, 2025, Mingwei Zhang wrote:
>>> Reject PMU MSRs interception explicitly in
>>> vmx_get_passthrough_msr_slot() since interception of PMU MSRs are
>>> specially handled in intel_passthrough_pmu_msrs().
>>>
>>> Signed-off-by: Mingwei Zhang <mizhang@google.com>
>>> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>> ---
>>>  arch/x86/kvm/vmx/vmx.c | 12 +++++++++++-
>>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>>> index 38ecf3c116bd..7bb16bed08da 100644
>>> --- a/arch/x86/kvm/vmx/vmx.c
>>> +++ b/arch/x86/kvm/vmx/vmx.c
>>> @@ -165,7 +165,7 @@ module_param(allow_smaller_maxphyaddr, bool, S_IRUGO);
>>>  
>>>  /*
>>>   * List of MSRs that can be directly passed to the guest.
>>> - * In addition to these x2apic, PT and LBR MSRs are handled specially.
>>> + * In addition to these x2apic, PMU, PT and LBR MSRs are handled specially.
> Except y'all forgot to actually do the "special" handling, vmx_msr_filter_changed()
> needs to refresh the PMU MSR filters.  Only the x2APIC MSRs are excluded from
> userspace filtering (see kvm_msr_allowed()), everything else can be intercepted
> by userespace.  E.g. if an MSR filter is set _before_ PMU refresh, KVM's behavior
> will diverge from a filter that is set after PMU refresh.

Yes, it's indeed missed. Needs to add them. Thanks for reminding it.


>
>>>   */
>>>  static u32 vmx_possible_passthrough_msrs[MAX_POSSIBLE_PASSTHROUGH_MSRS] = {
>>>  	MSR_IA32_SPEC_CTRL,
>>> @@ -691,6 +691,16 @@ static int vmx_get_passthrough_msr_slot(u32 msr)
>>>  	case MSR_LBR_CORE_FROM ... MSR_LBR_CORE_FROM + 8:
>>>  	case MSR_LBR_CORE_TO ... MSR_LBR_CORE_TO + 8:
>>>  		/* LBR MSRs. These are handled in vmx_update_intercept_for_lbr_msrs() */
>>> +	case MSR_IA32_PMC0 ...
>>> +		MSR_IA32_PMC0 + KVM_MAX_NR_GP_COUNTERS - 1:
>>> +	case MSR_IA32_PERFCTR0 ...
>>> +		MSR_IA32_PERFCTR0 + KVM_MAX_NR_GP_COUNTERS - 1:
>>> +	case MSR_CORE_PERF_FIXED_CTR0 ...
>>> +		MSR_CORE_PERF_FIXED_CTR0 + KVM_MAX_NR_FIXED_COUNTERS - 1:
>>> +	case MSR_CORE_PERF_GLOBAL_STATUS:
>>> +	case MSR_CORE_PERF_GLOBAL_CTRL:
>>> +	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
>>> +		/* PMU MSRs. These are handled in intel_passthrough_pmu_msrs() */
>>>  		return -ENOENT;
>>>  	}
>> This belongs in the patch that configures interception.  A better split would be
>> to have an Intel patch and an AMD patch, 
> I take that back, splitting the Intel and AMD logic makes is just as messy,
> because the control logic is very much shared between VMX and SVM.

