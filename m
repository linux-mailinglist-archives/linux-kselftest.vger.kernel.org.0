Return-Path: <linux-kselftest+bounces-33018-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E54DBAB7CD5
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 07:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED244A6D2B
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 05:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD2C27EC7D;
	Thu, 15 May 2025 05:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="edYumvmE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910A88C1F;
	Thu, 15 May 2025 05:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747285779; cv=none; b=ffHXLMo9iZKi+ss4NEBcWMyR+WonGSDTU3ANhRnjjXigVnnEs1AI2Tkq8PZw5p7JvhkxiewX/nlQQ0kBE/sY3IOIKfFwK2g+RJU45QjIqFClVKfbWFXMbFxszHIqCts0/m0BAGngS/Jir3HNqiamgx+XTHjipcXvayrJXgAlaME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747285779; c=relaxed/simple;
	bh=uxbsQpMeKa8E2VkKT5+LTBbhyG22diHloapfLODy/p4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mY9oeZurnay4eMMDbFUDYl4sTZAra0pUZK+9FvdUZYm3493+5T5JfIeE8ZtN1GPnSRNvOt3cpkrX4xIH2uOoK1ajkK/35dENz8v6KBdDbbtGJnZPLO+GVC5VK0QWy8ZuroEzXVM6uAVJI68j+uUGxlouItHo1XyIDSRAaGzXa6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=edYumvmE; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747285778; x=1778821778;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uxbsQpMeKa8E2VkKT5+LTBbhyG22diHloapfLODy/p4=;
  b=edYumvmExLPHrbViDxuds7uI71ViY19Gc5BAWNN1mgQKRn+V8gTmqKL7
   bXY+VuydXWnFswUlDA0vqlJPrigrfZtZiE1eTnxoQLCubM+Cb9GByhGiW
   hDR9IOEePj8ItgHmY9aFl0beLMCyu0EPeJevjhVSgYDu4NwwzrvaTOO5t
   iDiGDuX/8laDLWss5uKm0sbByVJMFiqIww4kBhQG/HQvXWPHZ7jIVBSEG
   fc/OxxeyXwLQhYO9P4WwG0qoONe6IOsR4Z/EolKMMULdZrP6Q386ZHe8J
   dIvM1+SldqFVZZlWcwdfCanJxCulMAL3Pkm6XgWyNNfypA6a55ke8IAG4
   w==;
X-CSE-ConnectionGUID: ft3ou1QtRamY6w70GkSGPg==
X-CSE-MsgGUID: 2JgsQi4CTo2RefNwlifIcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="52878238"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="52878238"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 22:09:37 -0700
X-CSE-ConnectionGUID: ZmKsqzIERGOt+Pz6urd1sA==
X-CSE-MsgGUID: AYK35yG+SxGBvZMuE7eoCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="137983579"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 22:09:31 -0700
Message-ID: <41821a66-8db1-42f1-85d6-fde67a8c072e@linux.intel.com>
Date: Thu, 15 May 2025 13:09:28 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 22/38] KVM: x86/pmu: Optimize intel/amd_pmu_refresh()
 helpers
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
 <20250324173121.1275209-23-mizhang@google.com> <aCU3Ri0iz0aDBDup@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aCU3Ri0iz0aDBDup@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/15/2025 8:37 AM, Sean Christopherson wrote:
> This is not an optimization in any sane interpretation of that word.

Yes, maybe clean up or bug fix is more accurate.


>
> On Mon, Mar 24, 2025, Mingwei Zhang wrote:
>> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>
>> Currently pmu->global_ctrl is initialized in the common kvm_pmu_refresh()
>> helper since both Intel and AMD CPUs set enable bits for all GP counters
>> for PERF_GLOBAL_CTRL MSR. But it may be not the best place to initialize
>> pmu->global_ctrl. Strictly speaking, pmu->global_ctrl is vendor specific
> And?  There's mounds of KVM code that show it's very, very easy to manage
> global_ctrl in common code.

The original intention is to put all initialization code into a same place,
which looks more easily to maintain. But if you don't like it. would drop
the change.


>
>> and there are lots of global_ctrl related processing in
>> intel/amd_pmu_refresh() helpers, so better handle them in same place.
>> Thus move pmu->global_ctrl initialization into intel/amd_pmu_refresh()
>> helpers.
>>
>> Besides, intel_pmu_refresh() doesn't handle global_ctrl_rsvd and
>> global_status_rsvd properly and fix it.
> Really?  You mention a bug fix in passing, and squash it into an opinionated
> refactoring that is advertised as "optimizations" without even stating what the
> bug is?  C'mon.

Sorry not clearly to describe the issue. global_ctrl_rsvd and
global_status_rsvd should be updated only when pmu->verion >=2, but the
original code doesn't.


>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Signed-off-by: Mingwei Zhang <mizhang@google.com>
>> ---
>>  arch/x86/kvm/pmu.c           | 10 -------
>>  arch/x86/kvm/svm/pmu.c       | 14 +++++++--
>>  arch/x86/kvm/vmx/pmu_intel.c | 55 ++++++++++++++++++------------------
>>  3 files changed, 39 insertions(+), 40 deletions(-)
>>
>> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
>> index 4e8cefcce7ab..2ac4c039de8b 100644
>> --- a/arch/x86/kvm/pmu.c
>> +++ b/arch/x86/kvm/pmu.c
>> @@ -843,16 +843,6 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
>>  		return;
>>  
>>  	kvm_pmu_call(refresh)(vcpu);
>> -
>> -	/*
>> -	 * At RESET, both Intel and AMD CPUs set all enable bits for general
>> -	 * purpose counters in IA32_PERF_GLOBAL_CTRL (so that software that
>> -	 * was written for v1 PMUs don't unknowingly leave GP counters disabled
>> -	 * in the global controls).  Emulate that behavior when refreshing the
>> -	 * PMU so that userspace doesn't need to manually set PERF_GLOBAL_CTRL.
>> -	 */
>> -	if (kvm_pmu_has_perf_global_ctrl(pmu) && pmu->nr_arch_gp_counters)
>> -		pmu->global_ctrl = GENMASK_ULL(pmu->nr_arch_gp_counters - 1, 0);
> Absolutely not, this code stays where it is.

Sure.


>
>>  }
>>  
>>  void kvm_pmu_init(struct kvm_vcpu *vcpu)
>> diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
>> index 153972e944eb..eba086ef5eca 100644
>> --- a/arch/x86/kvm/svm/pmu.c
>> +++ b/arch/x86/kvm/svm/pmu.c
>> @@ -198,12 +198,20 @@ static void __amd_pmu_refresh(struct kvm_vcpu *vcpu)
>>  	pmu->nr_arch_gp_counters = min_t(unsigned int, pmu->nr_arch_gp_counters,
>>  					 kvm_pmu_cap.num_counters_gp);
>>  
>> -	if (pmu->version > 1) {
>> -		pmu->global_ctrl_rsvd = ~((1ull << pmu->nr_arch_gp_counters) - 1);
>> +	if (kvm_pmu_cap.version > 1) {
> It's not just global_ctrl.  PEBS and the fixed counters also depend on v2+ (the
> SDM contradicts itself; KVM's ABI is that they're v2+).
>
>> +		/*
>> +		 * At RESET, AMD CPUs set all enable bits for general purpose counters in
>> +		 * IA32_PERF_GLOBAL_CTRL (so that software that was written for v1 PMUs
>> +		 * don't unknowingly leave GP counters disabled in the global controls).
>> +		 * Emulate that behavior when refreshing the PMU so that userspace doesn't
>> +		 * need to manually set PERF_GLOBAL_CTRL.
>> +		 */
>> +		pmu->global_ctrl = BIT_ULL(pmu->nr_arch_gp_counters) - 1;
>> +		pmu->global_ctrl_rsvd = ~pmu->global_ctrl;
>>  		pmu->global_status_rsvd = pmu->global_ctrl_rsvd;
>>  	}
>>  
>> -	pmu->counter_bitmask[KVM_PMC_GP] = ((u64)1 << 48) - 1;
>> +	pmu->counter_bitmask[KVM_PMC_GP] = BIT_ULL(48) - 1;
> I like these cleanups, but they too belong in a separate patch.

Sure.


>
>>  	pmu->reserved_bits = 0xfffffff000280000ull;
>>  	pmu->raw_event_mask = AMD64_RAW_EVENT_MASK;
>>  	/* not applicable to AMD; but clean them to prevent any fall out */

