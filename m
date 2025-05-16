Return-Path: <linux-kselftest+bounces-33154-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0B0AB941D
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 04:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA4AEA00B2F
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 02:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4390E22687B;
	Fri, 16 May 2025 02:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZhpQ4jY9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3272110E5;
	Fri, 16 May 2025 02:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747363058; cv=none; b=dYwIWVL+x0fqO5uo9/3ZTW2oRuvo9xAKOqe+fgan/0jzgtFLfbx8Iay7xtHWHmJPtethg/QcjetjBZzitdRgDohCeQDbj+3FQ5FHTqAUje4a6jbYKRLkaTZjmJTTn5uM94WMdZumjB7rmmLF3S6z147bRO7i8dc/A4aViESihUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747363058; c=relaxed/simple;
	bh=Q6ZDWA9yvz8aRWhSDSs2GRbngR5LSltaq/6JtHPTBuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z6UP+yItXzdunI1LbPJJPyDMRmokuK1+RAjR2WQoZraLO3/shPypax7mIr1iX2d6056VUD3B+w2eEMH5CDyTdPTKdQWdyaTw9muHZyvawgf3ClxhApCrUsDTsXur05T82DmGGfl+Iu5VPB5sZX1C4HIceTswefduoF4KKfkKFdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZhpQ4jY9; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747363056; x=1778899056;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q6ZDWA9yvz8aRWhSDSs2GRbngR5LSltaq/6JtHPTBuI=;
  b=ZhpQ4jY95qzjxIf2xTdFhFpAtfX+XMQ1S97Hxf+HxrSNdwKjqs+OWYKf
   Gt+PG73wZYp30O8GesbR20U+lNqK02cU30PeBUu8U8dSPHrXLPqqSLZxB
   sn84cXI66eYtif75iedicZzFXEaK6ysQI5pChGzAskfopzFgwwVK/1+XR
   tuk/SId4dVlB2v/CLW4YADh9FUYNADO3yMyaz02jfdPemzt/cHUm/Yphw
   4Q7oCtQUb78IdtDB/bqkOIR4Y7Md86Jlwie23lBOVUnBXaXFxll0yh02x
   Vl1L9JMEA5PbSQqe0SfjSj8tb40U927MbXul1g2/8LNY1Y6qFCjio2S7J
   g==;
X-CSE-ConnectionGUID: QkBxejomSJGloJcsvD4q2g==
X-CSE-MsgGUID: uPGp2l7JTxagnWSsRXxAdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="48577739"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="48577739"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 19:37:35 -0700
X-CSE-ConnectionGUID: 6SXgd0j3Q0Sm/OF03Q0egw==
X-CSE-MsgGUID: Q9Nmp0fVRsOZ/bcp9TOhcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="169492757"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 19:37:29 -0700
Message-ID: <60c594d0-d048-485b-83b9-a3b81b12c5a7@linux.intel.com>
Date: Fri, 16 May 2025 10:37:27 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 29/38] KVM: x86/pmu: Switch host/guest PMU context at
 vm-exit/vm-entry
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
 <20250324173121.1275209-30-mizhang@google.com> <aCYWXXpFcx33uVPi@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aCYWXXpFcx33uVPi@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/16/2025 12:29 AM, Sean Christopherson wrote:
> On Mon, Mar 24, 2025, Mingwei Zhang wrote:
>> diff --git a/arch/x86/include/asm/kvm-x86-pmu-ops.h b/arch/x86/include/asm/kvm-x86-pmu-ops.h
>> index 9159bf1a4730..35f27366c277 100644
>> --- a/arch/x86/include/asm/kvm-x86-pmu-ops.h
>> +++ b/arch/x86/include/asm/kvm-x86-pmu-ops.h
>> @@ -22,6 +22,8 @@ KVM_X86_PMU_OP(init)
>>  KVM_X86_PMU_OP_OPTIONAL(reset)
>>  KVM_X86_PMU_OP_OPTIONAL(deliver_pmi)
>>  KVM_X86_PMU_OP_OPTIONAL(cleanup)
>> +KVM_X86_PMU_OP(put_guest_context)
>> +KVM_X86_PMU_OP(load_guest_context)
> For KVM, the "guest_context" part is largely superfluous, as KVM always operates
> on guest state, e.g. kvm_fpu_{load,put}().
>
> I do think we should squeeze in "mediated" somewhere, otherwise the it's hard to
> see that these are specific to the mediated PMU.
>
> So probably mediated_{load,put}()?

After moving all PMC's manipulation into kvm common code, these two helper
actually only manipulates global shared MSRs right now, not sure if add
extra "global" word to the ops name which makes the name more descriptive.
But considering we may add more other MSRs like PEBS MSRs in these 2
helpers, I'm ok for mediated_{load,put}.


>
>>  #undef KVM_X86_PMU_OP
>>  #undef KVM_X86_PMU_OP_OPTIONAL
>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>> index 7ee74bbbb0aa..4117a382739a 100644
>> --- a/arch/x86/include/asm/kvm_host.h
>> +++ b/arch/x86/include/asm/kvm_host.h
>> @@ -568,6 +568,10 @@ struct kvm_pmu {
>>  	u64 raw_event_mask;
>>  	struct kvm_pmc gp_counters[KVM_MAX_NR_GP_COUNTERS];
>>  	struct kvm_pmc fixed_counters[KVM_MAX_NR_FIXED_COUNTERS];
>> +	u32 gp_eventsel_base;
>> +	u32 gp_counter_base;
>> +	u32 fixed_base;
>> +	u32 cntr_shift;
> Gah, my bad, "shift" was a terrible suggestion.  It should be "stride".

Yes.


>
>> @@ -306,6 +313,10 @@ void kvm_pmu_destroy(struct kvm_vcpu *vcpu);
>>  int kvm_vm_ioctl_set_pmu_event_filter(struct kvm *kvm, void __user *argp);
>>  void kvm_pmu_trigger_event(struct kvm_vcpu *vcpu, u64 eventsel);
>>  bool vcpu_pmu_can_enable(struct kvm_vcpu *vcpu);
>> +void kvm_pmu_put_guest_pmcs(struct kvm_vcpu *vcpu);
>> +void kvm_pmu_load_guest_pmcs(struct kvm_vcpu *vcpu);
>> +void kvm_pmu_put_guest_context(struct kvm_vcpu *vcpu);
>> +void kvm_pmu_load_guest_context(struct kvm_vcpu *vcpu);
>>  
>>  bool is_vmware_backdoor_pmc(u32 pmc_idx);
>>  bool kvm_rdpmc_in_guest(struct kvm_vcpu *vcpu);
>> diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
>> index 1a7e3a897fdf..7e0d84d50b74 100644
>> --- a/arch/x86/kvm/svm/pmu.c
>> +++ b/arch/x86/kvm/svm/pmu.c
>> @@ -175,6 +175,22 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>  	return 1;
>>  }
>>  
>> +static inline void amd_update_msr_base(struct kvm_vcpu *vcpu)
>> +{
>> +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>> +
>> +	if (kvm_pmu_has_perf_global_ctrl(pmu) ||
>> +	    guest_cpu_cap_has(vcpu, X86_FEATURE_PERFCTR_CORE)) {
>> +		pmu->gp_eventsel_base = MSR_F15H_PERF_CTL0;
>> +		pmu->gp_counter_base = MSR_F15H_PERF_CTR0;
>> +		pmu->cntr_shift = 2;
>> +	} else {
>> +		pmu->gp_eventsel_base = MSR_K7_EVNTSEL0;
>> +		pmu->gp_counter_base = MSR_K7_PERFCTR0;
>> +		pmu->cntr_shift = 1;
>> +	}
>> +}
> Moving quoted text around to organize responses...
>
>> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
>> index 796b7bc4affe..ed17ab198dfb 100644
>> --- a/arch/x86/kvm/vmx/pmu_intel.c
>> +++ b/arch/x86/kvm/vmx/pmu_intel.c
>> @@ -460,6 +460,17 @@ static void intel_pmu_enable_fixed_counter_bits(struct kvm_pmu *pmu, u64 bits)
>>  		pmu->fixed_ctr_ctrl_rsvd &= ~intel_fixed_bits_by_idx(i, bits);
>>  }
>>  
>> +static inline void intel_update_msr_base(struct kvm_vcpu *vcpu)
>> +{
>> +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>> +
>> +	pmu->gp_eventsel_base = MSR_P6_EVNTSEL0;
>> +	pmu->gp_counter_base = fw_writes_is_enabled(vcpu) ?
>> +			       MSR_IA32_PMC0 : MSR_IA32_PERFCTR0;
> This is wrong.  And I unintentionally proved that it's wrong, by goofing when I
> fixed up this code and using MSR_IA32_PERFCTR0 instead of MSR_IA32_PMC0.
>
> Whether or not the guest supports full-width writes is irrelevant, because support
> for FW writes doesn't change the width of the counters.  Just because the *guest* 
> can't directly write all e.g. 48 bits doesn't mean clobbering bits 47:32 is ok.
>
> Similarly, on the AMD side, using the legacy interface in KVM is unnecessary.
> The guest may be limited to those MSRs, but KVM has a hard dependency on PMU v2,
> so just unconditionally use MSR_F15H_PERF_CTR0 (and for the record, because I
> had to look it up, the newfangled MSRs on AMD are aliased to the legacy MSRs for
> 0..3).
>
> Very happily, that means the MSRs don't need to be per-PMU, and they don't even
> need to be configured at runtime for a given vendor.  Simply require FW writes
> on Intel to enable the mediated PMU, and then hardcode the GP base to MSR_IA32_PMC0.

Since mediated vPMU requires the HW PMU version is 4 at least, so I think
it's safe to set GP base to MSR_IA32_PMC0.


>
>> +static void amd_put_guest_context(struct kvm_vcpu *vcpu)
>> +{
>> +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>> +
>> +	rdmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, pmu->global_ctrl);
>> +	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, 0);
>> +	rdmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS, pmu->global_status);
>> +
>> +	/* Clear global status bits if non-zero */
>> +	if (pmu->global_status)
>> +		wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, pmu->global_status);
>> +
>> +	kvm_pmu_put_guest_pmcs(vcpu);
>> +}
>> +
>> +static void amd_load_guest_context(struct kvm_vcpu *vcpu)
>> +{
>> +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>> +	u64 global_status;
>> +
>> +	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, 0);
> Back when I suggested we give up on trying to handle PMCs and eventsels in common
> x86, this WRMSR didn't exist.  Now that it does, I don't see anything that prevents
> invoking kvm_pmu_{load,put}_guest_pmcs() from common x86, KVM just needs to clear
> GLOBAL_CTRL before setting eventsels and PMCs.
>
> For the load path:
>
> 	/*
> 	 * Disable all counters before loading event selectors and PMCs so that
> 	 * KVM doesn't enable or load guest counters while host events are
> 	 * active.  VMX will enable/disabled counters at VM-Enter/VM-Exit by
> 	 * atomically loading PERF_GLOBAL_CONTROL.  SVM effectively performs
> 	 * the switch by configuring all events to be GUEST_ONLY.
> 	 */
> 	wrmsrl(kvm_pmu_ops.PERF_GLOBAL_CTRL, 0);
>
> 	kvm_pmu_load_guest_pmcs(vcpu);
>
> 	kvm_pmu_call(mediated_load)(vcpu);
>
> And for the put path, just reverse the ordering:
>
> 	/*
> 	 * Defer handling of PERF_GLOBAL_CTRL to vendor code.  On Intel, it's
> 	 * atomically cleared on VM-Exit, i.e. doesn't need to be clear here.
> 	 */
> 	kvm_pmu_call(mediated_put)(vcpu);
>
> 	kvm_pmu_put_guest_pmcs(vcpu);
>
> 	perf_put_guest_context();
>
> On Intel, PERF_GLOBAL_CTRL is cleared on VM-Exit, and on AMD, the vendor hook
> will clear it.  The fact that vendor code sets other MSRs is irrelevant, what
> matters is that all counters are quieseced.
>
> I think it's still worth having helpers, but they can be static locals.

Agree.


>
>> +
>> +	kvm_pmu_load_guest_pmcs(vcpu);
>> +
>> +	rdmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS, global_status);
>> +	/* Clear host global_status MSR if non-zero. */
>> +	if (global_status)
>> +		wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, global_status);
>> +
>> +	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET, pmu->global_status);
>> +	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, pmu->global_ctrl);
>> +}
>> +
>>  static void intel_pmu_update_msr_intercepts(struct kvm_vcpu *vcpu)
>> @@ -809,6 +822,50 @@ void intel_pmu_cross_mapped_check(struct kvm_pmu *pmu)
>>  	}
>>  }
>>  
>> +static void intel_put_guest_context(struct kvm_vcpu *vcpu)
>> +{
>> +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>> +
>> +	/* Global ctrl register is already saved at VM-exit. */
>> +	rdmsrl(MSR_CORE_PERF_GLOBAL_STATUS, pmu->global_status);
>> +
>> +	/* Clear hardware MSR_CORE_PERF_GLOBAL_STATUS MSR, if non-zero. */
>> +	if (pmu->global_status)
>> +		wrmsrl(MSR_CORE_PERF_GLOBAL_OVF_CTRL, pmu->global_status);
>> +
>> +	rdmsrl(MSR_CORE_PERF_FIXED_CTR_CTRL, pmu->fixed_ctr_ctrl_hw);
>> +
>> +	/*
>> +	 * Clear hardware FIXED_CTR_CTRL MSR to avoid information leakage and
>> +	 * also avoid these guest fixed counters get accidentially enabled
>> +	 * during host running when host enable global ctrl.
>> +	 */
>> +	if (pmu->fixed_ctr_ctrl_hw)
>> +		wrmsrl(MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
>> +
>> +	kvm_pmu_put_guest_pmcs(vcpu);
>> +}
>> +
>> +static void intel_load_guest_context(struct kvm_vcpu *vcpu)
>> +{
>> +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>> +	u64 global_status, toggle;
>> +
>> +	/* Clear host global_ctrl MSR if non-zero. */
>> +	wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, 0);
>> +
>> +	rdmsrl(MSR_CORE_PERF_GLOBAL_STATUS, global_status);
>> +	toggle = pmu->global_status ^ global_status;
>> +	if (global_status & toggle)
>> +		wrmsrl(MSR_CORE_PERF_GLOBAL_OVF_CTRL, global_status & toggle);
>> +	if (pmu->global_status & toggle)
>> +		wrmsrl(MSR_CORE_PERF_GLOBAL_STATUS_SET, pmu->global_status & toggle);
>> +
>> +	wrmsrl(MSR_CORE_PERF_FIXED_CTR_CTRL, pmu->fixed_ctr_ctrl_hw);
>> +
>> +	kvm_pmu_load_guest_pmcs(vcpu);
>> +}

