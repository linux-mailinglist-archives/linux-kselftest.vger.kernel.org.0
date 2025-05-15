Return-Path: <linux-kselftest+bounces-33022-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D97ABAB7D10
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 07:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2AF81BA4B63
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 05:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C393827E7DE;
	Thu, 15 May 2025 05:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HPBCW3R5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3984B1E54;
	Thu, 15 May 2025 05:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747287537; cv=none; b=QzsmymAYJ2YghziywZJvOCj7jIeFAqf8x6pI6WUHy9cQqSDjj8V76zye+KLGp4OVIt8I5C0MzqgKqWsx1qbJvF/kNPhpXgzw1yh88gCWT9bZByy6ukYYZqOoTPO/pn7573fDAch6yd+ft/MKDuOsZ2x4lje9HuJjNRILaiG2OXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747287537; c=relaxed/simple;
	bh=XqcUkZHXIgok8l24svkuW7o9mZPcMaO36R3fz+K+l+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I5W96YA5y7tm4/IctOjHeKGDVjJ80vv4C+5sdZsyKUW57iWWdlUHngY+ga58Xq2hctL12uMgpXPTlDSlKdc9NVAnQA6udYXeSOMAXBXOArK/nFVVtnA3wdVqlqGtjcLbrcUQyQmn6fPeCVWIQb72g7UapcN6j99A9mrN7iMPmlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HPBCW3R5; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747287536; x=1778823536;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XqcUkZHXIgok8l24svkuW7o9mZPcMaO36R3fz+K+l+w=;
  b=HPBCW3R5ifp8+O1O0myW8ZK8hbLLNxDQQAf1tp6a+dB63gqf1wkSOBK/
   TbHhCNkfq+SprbVNP0OQ23XpQ9IB1r6HueDB1Eyk9++B7/ZG1XWGUUaVO
   IKDBLrH0f54riiJa2BTUnhn6rgDZUsPf1cfWc57aG2hFXZpZOj5z9HSwP
   THYZKrOSYI/8v8Lg55F+u2+vxRxYllNanzdRwPzbSWSrW2JBLhxeLSz3/
   nLkN/ZAbh5BMIxZiImk6pGNtlYBnjsNj4SBNbCRODlItt2FUB+8NHMkiR
   uHPOpl3PhWvXsUnmQDvTWaSo+M+d2BORChTDnVqWP655ISAAx0ZCknUkJ
   Q==;
X-CSE-ConnectionGUID: K2eNHVUCT42kyMoLW8JQ/g==
X-CSE-MsgGUID: b4ZIZdWwQSqbI+vAA9PiGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="71717948"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="71717948"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 22:38:56 -0700
X-CSE-ConnectionGUID: IkGhXpNhTzOpl0I+Mve6LA==
X-CSE-MsgGUID: L+k1zYZEQJm1Uoj8tyM+ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="138129524"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 22:38:50 -0700
Message-ID: <c1a18d0f-c166-4084-b764-46377cb11e57@linux.intel.com>
Date: Thu, 15 May 2025 13:38:47 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 27/38] KVM: x86/pmu: Handle PMU MSRs interception and
 event filtering
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
 <20250324173121.1275209-28-mizhang@google.com> <aCU4qAjgUCUa5Mgz@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aCU4qAjgUCUa5Mgz@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/15/2025 8:43 AM, Sean Christopherson wrote:
> Again, be more precise.
>
> On Mon, Mar 24, 2025, Mingwei Zhang wrote:
>> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>
>> Mediated vPMU needs to intercept EVENTSELx and FIXED_CNTR_CTRL MSRs to
>> filter out guest malicious perf events. Either writing these MSRs or
>> updating event filters would call reprogram_counter() eventually. Thus
>> check if the guest event should be filtered out in reprogram_counter().
>> If so, clear corresponding EVENTSELx MSR or FIXED_CNTR_CTRL field to
>> ensure the guest event won't be really enabled at vm-entry.
>>
>> Besides, mediated vPMU intercepts the MSRs of these guest not owned
>> counters and it just needs simply to read/write from/to pmc->counter.
>>
>> Suggested-by: Sean Christopherson <seanjc@google.com>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Co-developed-by: Mingwei Zhang <mizhang@google.com>
>> Signed-off-by: Mingwei Zhang <mizhang@google.com>
>> ---
>>  arch/x86/kvm/pmu.c | 27 +++++++++++++++++++++++++++
>>  arch/x86/kvm/pmu.h |  3 +++
>>  2 files changed, 30 insertions(+)
>>
>> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
>> index 63143eeb5c44..e9100dc49fdc 100644
>> --- a/arch/x86/kvm/pmu.c
>> +++ b/arch/x86/kvm/pmu.c
>> @@ -305,6 +305,11 @@ static void pmc_update_sample_period(struct kvm_pmc *pmc)
>>  
>>  void pmc_write_counter(struct kvm_pmc *pmc, u64 val)
>>  {
>> +	if (kvm_mediated_pmu_enabled(pmc->vcpu)) {
>> +		pmc->counter = val & pmc_bitmask(pmc);
>> +		return;
>> +	}
>> +
>>  	/*
>>  	 * Drop any unconsumed accumulated counts, the WRMSR is a write, not a
>>  	 * read-modify-write.  Adjust the counter value so that its value is
>> @@ -455,6 +460,28 @@ static int reprogram_counter(struct kvm_pmc *pmc)
>>  	bool emulate_overflow;
>>  	u8 fixed_ctr_ctrl;
>>  
>> +	if (kvm_mediated_pmu_enabled(pmu_to_vcpu(pmu))) {
>> +		bool allowed = check_pmu_event_filter(pmc);
>> +
>> +		if (pmc_is_gp(pmc)) {
>> +			if (allowed)
>> +				pmc->eventsel_hw |= pmc->eventsel &
>> +						    ARCH_PERFMON_EVENTSEL_ENABLE;
>> +			else
>> +				pmc->eventsel_hw &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
>> +		} else {
>> +			int idx = pmc->idx - KVM_FIXED_PMC_BASE_IDX;
>> +
>> +			if (allowed)
>> +				pmu->fixed_ctr_ctrl_hw = pmu->fixed_ctr_ctrl;
>> +			else
>> +				pmu->fixed_ctr_ctrl_hw &=
>> +					~intel_fixed_bits_by_idx(idx, 0xf);
>> +		}
>> +
>> +		return 0;
> I think it's worth adding a helper for this, as it makes things a bit more
> self-documenting in terms of when KVM needs to "reprogram" mediated PMU PMCs.

Sure. Thanks.



