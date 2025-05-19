Return-Path: <linux-kselftest+bounces-33308-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB7AABB473
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 07:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2023B5485
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 05:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77FC1F130A;
	Mon, 19 May 2025 05:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GyxVJOxv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AFA1CF96;
	Mon, 19 May 2025 05:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747632295; cv=none; b=MgLh7fxFwwFhXPBY/UCacsIuYvUvEeDVvQR4ylOYGh3N7si65EAA2qCvVqlzN4D94Ci6AUQkfHq1gJTT66s7Kv978S3wWAAXmIvnd7OqM/2z6oqzznjhUodr6Wit6sWaXdlfNcwFmkeIoUQeZNje+zqMrZ+i4U91PgctWbAmQf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747632295; c=relaxed/simple;
	bh=jiTVEkMPDck3ZXVnwfcCr1G6DDOSxv+4n2R0CgzFG7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tqDggu6raG0w51khZYKV6dWyslAZIhZ1Gu80PKA15+37Fx6gOknQKb618YgHf6CtSvjPxn6ML8POR8gdvrtO0ErZZ9x1Gmg6/UnngwJ+ybactnpo53kZODlu7NtIG7sPEKlv9ITzf90G+HDmTxzjUOtcMaJXft2WvYau703xFJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GyxVJOxv; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747632294; x=1779168294;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jiTVEkMPDck3ZXVnwfcCr1G6DDOSxv+4n2R0CgzFG7M=;
  b=GyxVJOxv9iOh2oor3fJVSpYrO+dgnRXvgXxBN4GMUF2/7Ma/jnjBwYSa
   AayFsIkYebiwGGAOogpNfJqesfA+Om3ZnXH1gi6cAlGL1U37eL2VRRyKm
   uwm10aerDPR0Cig6XAlJH2BS3uVr5l1KTE1IUEy6DxTNLc4sFULRlvwRT
   22Be1Lk55fKkkuNnvV6Vw+fByOyDD1GBLfdh9oi8URek/nu6Lqtg/d6P6
   JK28k/TEy+MhWZRTlYdf+TUGYirFgyAKGZwKh3LBbdGA2+iVmzjxBePvD
   IYRM6P6Jo/Www2sxPfrWXBI2TOUdwoNMoPNxDzBbg3XRKES2b+n7C9VcH
   g==;
X-CSE-ConnectionGUID: tm2rfTftSAeKg6anY0CnzQ==
X-CSE-MsgGUID: HBrNMWhYSgyhMDNTBHc5bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="49621779"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="49621779"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2025 22:24:53 -0700
X-CSE-ConnectionGUID: CgDmWs88TUuHrhD9vQA8Jw==
X-CSE-MsgGUID: x1kdZNoCTfCrgNlU9bvxEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="162556027"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2025 22:24:45 -0700
Message-ID: <71123914-ba9b-4ab0-b9c0-fa32fb53dfe2@linux.intel.com>
Date: Mon, 19 May 2025 13:24:43 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 32/38] KVM: nVMX: Add nested virtualization support for
 mediated PMU
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
 <20250324173121.1275209-33-mizhang@google.com> <aCc-q_udsn8o1vBT@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aCc-q_udsn8o1vBT@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/16/2025 9:33 PM, Sean Christopherson wrote:
> This shortlog is unnecessarily confusing.  It reads as if supported for running
> L2 in a vCPU with a mediated PMU is somehow lacking.
>
> On Mon, Mar 24, 2025, Mingwei Zhang wrote:
>> Add nested virtualization support for mediated PMU by combining the MSR
>> interception bitmaps of vmcs01 and vmcs12.
> Do not phrase changelogs related to nested virtualization in terms of enabling a
> _KVM_ feature.  KVM has no control over what hypervisor runs in L1.  It's a-ok to
> provide example use cases, but they need to be just that, examples.
>
>> Readers may argue even without this patch, nested virtualization works for
>> mediated PMU because L1 will see Perfmon v2 and will have to use legacy vPMU
>> implementation if it is Linux. However, any assumption made on L1 may be
>> invalid, e.g., L1 may not even be Linux.
>>
>> If both L0 and L1 pass through PMU MSRs, the correct behavior is to allow
>> MSR access from L2 directly touch HW MSRs, since both L0 and L1 passthrough
>> the access.
>>
>> However, in current implementation, if without adding anything for nested,
>> KVM always set MSR interception bits in vmcs02. This leads to the fact that
>> L0 will emulate all MSR read/writes for L2, leading to errors, since the
>> current mediated vPMU never implements set_msr() and get_msr() for any
>> counter access except counter accesses from the VMM side.
>>
>> So fix the issue by setting up the correct MSR interception for PMU MSRs.
> This is not a fix.  
>
>     KVM: nVMX: Disable PMU MSR interception as appropriate while running L2
>     
>     Merge KVM's PMU MSR interception bitmaps with those of L1, i.e. merge the
>     bitmaps of vmcs01 and vmcs12, e.g. so that KVM doesn't interpose on MSR
>     accesses unnecessarily if L1 exposes a mediated PMU (or equivalent) to L2.

Sure. Thanks.


>
>> Signed-off-by: Mingwei Zhang <mizhang@google.com>
>> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  arch/x86/kvm/vmx/nested.c | 32 ++++++++++++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>
>> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
>> index cf557acf91f8..dbec40cb55bc 100644
>> --- a/arch/x86/kvm/vmx/nested.c
>> +++ b/arch/x86/kvm/vmx/nested.c
>> @@ -626,6 +626,36 @@ static inline void nested_vmx_set_intercept_for_msr(struct vcpu_vmx *vmx,
>>  #define nested_vmx_merge_msr_bitmaps_rw(msr) \
>>  	nested_vmx_merge_msr_bitmaps(msr, MSR_TYPE_RW)
>>  
>> +/*
>> + * Disable PMU MSRs interception for nested VM if L0 and L1 are
>> + * both mediated vPMU.
>> + */
> Again, KVM has no idea what is running in L1.  Drop this.

Yes. thanks.


>
>> +static void nested_vmx_merge_pmu_msr_bitmaps(struct kvm_vcpu *vcpu,
>> +					     unsigned long *msr_bitmap_l1,
>> +					     unsigned long *msr_bitmap_l0)
>> +{
>> +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>> +	struct vcpu_vmx *vmx = to_vmx(vcpu);
>> +	int i;
>> +
>> +	if (!kvm_mediated_pmu_enabled(vcpu))
> This is a worthwhile check, but a comment would be helpful:
>
> 	/*
> 	 * Skip the merges if the vCPU doesn't have a mediated PMU MSR, i.e. if
> 	 * none of the MSRs can possibly be passed through to L1.
> 	 */
> 	if (!kvm_vcpu_has_mediated_pmu(vcpu))
> 		return;

Sure. thanks.


>
>> +		return;
>> +
>> +	for (i = 0; i < pmu->nr_arch_gp_counters; i++) {
>> +		nested_vmx_merge_msr_bitmaps_rw(MSR_ARCH_PERFMON_EVENTSEL0 + i);
> This is unnecessary, KVM always intercepts event selectors.

Yes.


>
>> +		nested_vmx_merge_msr_bitmaps_rw(MSR_IA32_PERFCTR0 + i);
>> +		nested_vmx_merge_msr_bitmaps_rw(MSR_IA32_PMC0 + i);
>> +	}
>> +
>> +	for (i = 0; i < pmu->nr_arch_fixed_counters; i++)
>> +		nested_vmx_merge_msr_bitmaps_rw(MSR_CORE_PERF_FIXED_CTR0 + i);
>> +
>> +	nested_vmx_merge_msr_bitmaps_rw(MSR_CORE_PERF_FIXED_CTR_CTRL);
> Same thing here.

Yes.


>
>> +	nested_vmx_merge_msr_bitmaps_rw(MSR_CORE_PERF_GLOBAL_CTRL);
>> +	nested_vmx_merge_msr_bitmaps_read(MSR_CORE_PERF_GLOBAL_STATUS);
>> +	nested_vmx_merge_msr_bitmaps_write(MSR_CORE_PERF_GLOBAL_OVF_CTRL);
>> +}

