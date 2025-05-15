Return-Path: <linux-kselftest+bounces-33010-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A7AAB7C30
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 05:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFF563B89BD
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 03:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5DB258CF6;
	Thu, 15 May 2025 03:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mCzpWIjn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2EB1C3C1F;
	Thu, 15 May 2025 03:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747279399; cv=none; b=pF/jNSvZxU9KgEV2mSzTdYutJWuPMGUqUKYGR3PKQzSVPkTaVTYTp93mSqJpNJHK2EaRb7I+hqcTEdGi3z9hnx7ecgUU2uKhn3cinl7qNn6hOgEO72o3Qeir6EBH/KfCasP4Qki3TXEzBSFodtKo4V4WiKxrAmD42gURnMt+p8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747279399; c=relaxed/simple;
	bh=FFkIck5WEpe1ylHiy43DrIUF2d/UVZz1agmgdg0BBjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XFPG4XQ3RaObBAPkYgOvCMECJtTFPI5lijch/57kRd5Ewf+2Yi0J072jp4XCBXCseB60067kFVK69ikMHRFOmVcrvZnKCC6ri9GOGehfc/2NVx9Ur3mQ5amJsvGqWJqrM9B9iAc0jKAxEApbe61DFpzCF+dN4ArW9vdcqFSJm2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mCzpWIjn; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747279398; x=1778815398;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FFkIck5WEpe1ylHiy43DrIUF2d/UVZz1agmgdg0BBjo=;
  b=mCzpWIjn+sGTyE4jvmQpYA92zZQvxiwt1EhiU1QVgrBZ9s1nWGzPfd9Q
   myghzRJbbvz95ZQUCMaDv2hgkAIVISaEW5aFOxjyCOKR2yp8bGGq9S7BW
   MFrnC1GFa09+q5FcGITWAN5no6gPLb33g7mGmPrfGF756jWv5zb/NnIoF
   u2He29CxDNGK+q6/P5B+fzkf/zarf5arWlxC1Wxgu0XXFTrc7fhWzOYCM
   2tHV45DwRcJo7QUF6Ka7C+PrXweVCaz55R8T6/YnyCCqA8MhaNJedOUH+
   FduLo8f03EHKI6/LJ/4x0vXiYD8zKwAD6AzXHzvY1OOb3CyBk9LiDJnhC
   w==;
X-CSE-ConnectionGUID: 7yXXPwb/T9uhC7EIgMpUXA==
X-CSE-MsgGUID: MPPL0EZ1RK+dP3G2p/Tdvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="48885906"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="48885906"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 20:23:17 -0700
X-CSE-ConnectionGUID: mKURwDSwSpqWc510vqdJ4g==
X-CSE-MsgGUID: VuxJwbW7TaekJTuW2qVWmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="139132687"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 20:23:11 -0700
Message-ID: <27ad4a47-d39f-4210-898c-b55a3e28de67@linux.intel.com>
Date: Thu, 15 May 2025 11:23:07 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/38] KVM: x86/pmu: Check if mediated vPMU can
 intercept rdpmc
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
 <20250324173121.1275209-21-mizhang@google.com> <aCUzKp1uhMsn-g_u@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aCUzKp1uhMsn-g_u@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 5/15/2025 8:19 AM, Sean Christopherson wrote:
> The shortlog is wildly inaccurate.  KVM is not simply checking, KVM is actively
> disabling RDPMC interception.  *That* needs to be the focus of the shortlog and
> changelog.

Sure.


>
>> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
>> index 92c742ead663..6ad71752be4b 100644
>> --- a/arch/x86/kvm/pmu.c
>> +++ b/arch/x86/kvm/pmu.c
>> @@ -604,6 +604,40 @@ int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
>>  	return 0;
>>  }
>>  
>> +inline bool kvm_rdpmc_in_guest(struct kvm_vcpu *vcpu)
> Strongly prefer kvm_need_rdpmc_intercept(), e.g. to follow vmx_need_pf_intercept(),
> and because it makes the users more obviously correct.  The "in_guest" terminology
> from kvm_{hlt,mwait,pause,cstate}_in_guest() isn't great, but at least in those
> flows it's not awful because they are very direct reflections of knobs that control
> interception, whereas this helper is making a variety of runtime checks.

Sure.


>
>> +{
>> +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>> +
>> +	if (!kvm_mediated_pmu_enabled(vcpu))
>> +		return false;
>> +
>> +	/*
>> +	 * VMware allows access to these Pseduo-PMCs even when read via RDPMC
>> +	 * in Ring3 when CR4.PCE=0.
>> +	 */
>> +	if (enable_vmware_backdoor)
>> +		return false;
>> +
>> +	/*
>> +	 * FIXME: In theory, perf metrics is always combined with fixed
>> +	 *	  counter 3. it's fair enough to compare the guest and host
>> +	 *	  fixed counter number and don't need to check perf metrics
>> +	 *	  explicitly. However kvm_pmu_cap.num_counters_fixed is limited
>> +	 *	  KVM_MAX_NR_FIXED_COUNTERS (3) as fixed counter 3 is not
>> +	 *	  supported now. perf metrics is still needed to be checked
>> +	 *	  explicitly here. Once fixed counter 3 is supported, the perf
>> +	 *	  metrics checking can be removed.
>> +	 */
> And then what happens when hardware supported fixed counter #4?  KVM has the same
> problem, and we can't check for features that KVM doesn't know about.
>
> The entire problem is that this code is checking for *KVM* support, but what the
> guest can see and access needs to be checked against *hardware* support.  Handling
> that is simple, just take a snapshot of the host PMU capabilities before KVM
> generates kvm_pmu_cap, and use the unadulterated snapshot here (and everywhere
> else with similar checks).

Yes. That's correct. Whether disabling intercept should check against  HW 
instead of KVM PMU capability since host perf subsystem may hide some PMU
features.


>
>> +	return pmu->nr_arch_gp_counters == kvm_pmu_cap.num_counters_gp &&
>> +	       pmu->nr_arch_fixed_counters == kvm_pmu_cap.num_counters_fixed &&
>> +	       vcpu_has_perf_metrics(vcpu) == kvm_host_has_perf_metrics() &&
>> +	       pmu->counter_bitmask[KVM_PMC_GP] ==
>> +				(BIT_ULL(kvm_pmu_cap.bit_width_gp) - 1) &&
>> +	       pmu->counter_bitmask[KVM_PMC_FIXED] ==
>> +				(BIT_ULL(kvm_pmu_cap.bit_width_fixed) - 1);
>> +}
>> @@ -212,6 +212,18 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
>>  	bitmap_set(pmu->all_valid_pmc_idx, 0, pmu->nr_arch_gp_counters);
>>  }
>>  
>> +static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
>> +{
>> +	struct vcpu_svm *svm = to_svm(vcpu);
>> +
>> +	__amd_pmu_refresh(vcpu);
> To better communicate the roles of the two paths to refresh():
>
> 	amd_pmu_refresh_capabilities(vcpu);
>
> 	amd_pmu_refresh_controls(vcpu);
>
> Ditto for Intel.

Sure.



