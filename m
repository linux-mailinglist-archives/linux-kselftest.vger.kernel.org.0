Return-Path: <linux-kselftest+bounces-33007-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A414AB7BC7
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 04:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4BF87A2882
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 02:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109DB269880;
	Thu, 15 May 2025 02:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EqEWnzPl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777564B1E44;
	Thu, 15 May 2025 02:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747277630; cv=none; b=iFUs4reMIGVhWZaHkDfjXY5sFbyc79wEwz9861r0wXFruMpZI9lxzU5Q8YefWkkXv1bgmX9TCGPx5fSIDp63W/Cz1UW+4y55SFXFx21Xxc5f16KVhrdp1uJHQW8uoXe4x9xPWPM2he67zKW+o1dw9+wjOINvozH5PrL+/jFcjIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747277630; c=relaxed/simple;
	bh=gTnT9tsByGMmefYHI0pCyNdM8i4PA2xC4p36UkNk7SM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W+IdrNAm/E9fY0SOGygiPG/U2fS9B0vzlR2KJkv1hM69IFHvn1P82NPhrHItmOofRfetUcfjfynbxsSMuUoCx3UiyVIBh620JqNXurOMGRlg2Xc/nlJ14rRWyU0C/lEgeAfpMqB4LtQsNyXCoVXYf6U6zm/xFPK+fexD/tP+WZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EqEWnzPl; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747277629; x=1778813629;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gTnT9tsByGMmefYHI0pCyNdM8i4PA2xC4p36UkNk7SM=;
  b=EqEWnzPlgui2oq+bkDg+Ts3WtLxGQ8AoGjKIemLg5P+5hZLlZqDYAiUt
   3AYgeLxxp4SMZrLuckZQisqXcJ6h84b2EBdIkzHSez96zQxFUZJgGnfhb
   v8b+mRFcazG2VtvFWeGye5LRVTT3aTXFwmSp4gC7QIyyVtvIWR/STi0PA
   KFPgv2zu2sNeOrrDxIOFvIPYF2kfdT1DcyJQ1JYcKwZtTBkk27ClM2igS
   Xwtz5XY0Cp6cywH6Pf4EihB4T2YB95Hx13+Xm/k9k/W4kPf84h6F07ZF8
   fWcHv0HF/T3uGBaY2wK93pbQsCQSDeJ1M/ZD53QpOxGGDJ3MxTLCMdd6K
   w==;
X-CSE-ConnectionGUID: 25413maKRHy5HGb4j7PLTg==
X-CSE-MsgGUID: m2J/4vuASw+9XfFaLi4AkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49272321"
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; 
   d="scan'208";a="49272321"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 19:53:48 -0700
X-CSE-ConnectionGUID: 77qO3U+pT4Wp0Xelp6vp6g==
X-CSE-MsgGUID: Mo42WKnwTjeIMIUgKav2rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; 
   d="scan'208";a="143420967"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 19:53:42 -0700
Message-ID: <1d024d71-0b02-4481-a0d4-f1786313c1e7@linux.intel.com>
Date: Thu, 15 May 2025 10:53:39 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/38] KVM: x86/pmu: Introduce enable_mediated_pmu
 global parameter
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
 <20250324173121.1275209-15-mizhang@google.com> <aCUwvXPKD0ANKFb7@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aCUwvXPKD0ANKFb7@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 5/15/2025 8:09 AM, Sean Christopherson wrote:
> On Mon, Mar 24, 2025, Mingwei Zhang wrote:
>> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>
>> Introduce enable_mediated_pmu global parameter to control if mediated
>> vPMU can be enabled on KVM level. Even enable_mediated_pmu is set to
>> true in KVM, user space hypervisor still need to enable mediated vPMU
>> explicitly by calling KVM_CAP_PMU_CAPABILITY ioctl. This gives
>> hypervisor flexibility to enable or disable mediated vPMU for each VM.
>>
>> Mediated vPMU depends on some PMU features on higher PMU version, like
>> PERF_GLOBAL_STATUS_SET MSR in v4+ for Intel PMU. Thus introduce a
>> pmu_ops variable MIN_MEDIATED_PMU_VERSION to indicates the minimum host
>> PMU version which mediated vPMU needs.
>>
>> Currently enable_mediated_pmu is not exposed to user space as a module
>> parameter until all mediated vPMU code are in place.
>>
>> Suggested-by: Sean Christopherson <seanjc@google.com>
>> Co-developed-by: Mingwei Zhang <mizhang@google.com>
>> Signed-off-by: Mingwei Zhang <mizhang@google.com>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  arch/x86/kvm/pmu.c              |  3 ++-
>>  arch/x86/kvm/pmu.h              | 11 +++++++++
>>  arch/x86/kvm/svm/pmu.c          |  1 +
>>  arch/x86/kvm/vmx/capabilities.h |  3 ++-
>>  arch/x86/kvm/vmx/pmu_intel.c    |  5 ++++
>>  arch/x86/kvm/vmx/vmx.c          |  3 ++-
>>  arch/x86/kvm/x86.c              | 44 ++++++++++++++++++++++++++++++---
>>  arch/x86/kvm/x86.h              |  1 +
>>  8 files changed, 64 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
>> index 75e9cfc689f8..4f455afe4009 100644
>> --- a/arch/x86/kvm/pmu.c
>> +++ b/arch/x86/kvm/pmu.c
>> @@ -775,7 +775,8 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
>>  	pmu->pebs_data_cfg_rsvd = ~0ull;
>>  	bitmap_zero(pmu->all_valid_pmc_idx, X86_PMC_IDX_MAX);
>>  
>> -	if (!vcpu->kvm->arch.enable_pmu)
>> +	if (!vcpu->kvm->arch.enable_pmu ||
>> +	    (!lapic_in_kernel(vcpu) && enable_mediated_pmu))
> This check belongs in KVM_CAP_PMU_CAPABILITY, i.e. KVM needs to reject enabling
> a mediated PMU without an in-kernel local APIC, not silently drop the PMU.

Good idea.


>
>>  		return;
>>  
>>  	kvm_pmu_call(refresh)(vcpu);
>> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
>> index ad89d0bd6005..dd45a0c6be74 100644
>> --- a/arch/x86/kvm/pmu.h
>> +++ b/arch/x86/kvm/pmu.h
>> @@ -45,6 +45,7 @@ struct kvm_pmu_ops {
>>  	const u64 EVENTSEL_EVENT;
>>  	const int MAX_NR_GP_COUNTERS;
>>  	const int MIN_NR_GP_COUNTERS;
>> +	const int MIN_MEDIATED_PMU_VERSION;
> I like the idea, but simply checking the PMU version is insufficient on Intel,
> i.e. just add a callback.

sure.


>
>>  };
>>  
>>  void kvm_pmu_ops_update(const struct kvm_pmu_ops *pmu_ops);
>> @@ -63,6 +64,12 @@ static inline bool kvm_pmu_has_perf_global_ctrl(struct kvm_pmu *pmu)
>>  	return pmu->version > 1;
>>  }
>>  
>> +static inline bool kvm_mediated_pmu_enabled(struct kvm_vcpu *vcpu)
> kvm_vcpu_has_mediated_pmu() to align with e.g. guest_cpu_cap_has(), and because
> kvm_mediated_pmu_enabled() sounds like a VM-scoped or module-scoped helper.

exactly.


>
>> +{
>> +	return vcpu->kvm->arch.enable_pmu &&
> This is superfluous, pmu->version should never be non-zero without the PMU being
> enabled at the VM level.

Strictly speaking, "arch.enable_pmu" and pmu->version doesn't indicates
fully same thing.  "arch.enable_pmu" indicates whether PMU function is
enabled in KVM, but the "pmu->version" comes from user space configuration.
In theory user space could configure a "0"  PMU version just like
pmu_counters_test does. Currently I'm not sure if the check for
"pmu->version" can be removed, let me have a double check.


>
>> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
>> index 77012b2eca0e..425e93d4b1c6 100644
>> --- a/arch/x86/kvm/vmx/pmu_intel.c
>> +++ b/arch/x86/kvm/vmx/pmu_intel.c
>> @@ -739,4 +739,9 @@ struct kvm_pmu_ops intel_pmu_ops __initdata = {
>>  	.EVENTSEL_EVENT = ARCH_PERFMON_EVENTSEL_EVENT,
>>  	.MAX_NR_GP_COUNTERS = KVM_MAX_NR_INTEL_GP_COUNTERS,
>>  	.MIN_NR_GP_COUNTERS = 1,
>> +	/*
>> +	 * Intel mediated vPMU support depends on
>> +	 * MSR_CORE_PERF_GLOBAL_STATUS_SET which is supported from 4+.
>> +	 */
>> +	.MIN_MEDIATED_PMU_VERSION = 4,
>>  };
>> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>> index 00ac94535c21..a4b5b6455c7b 100644
>> --- a/arch/x86/kvm/vmx/vmx.c
>> +++ b/arch/x86/kvm/vmx/vmx.c
>> @@ -7916,7 +7916,8 @@ static __init u64 vmx_get_perf_capabilities(void)
>>  	if (boot_cpu_has(X86_FEATURE_PDCM))
>>  		rdmsrl(MSR_IA32_PERF_CAPABILITIES, host_perf_cap);
>>  
>> -	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR)) {
>> +	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR) &&
>> +	    !enable_mediated_pmu) {
>>  		x86_perf_get_lbr(&vmx_lbr_caps);
>>  
>>  		/*
> There's a bit too much going on in this patch.  I think it makes sense to split
> the vendor chunks out to separate patches, so that each can elaborate on the
> exact requirements.

Sure.


>
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index 72995952978a..1ebe169b88b6 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -188,6 +188,14 @@ bool __read_mostly enable_pmu = true;
>>  EXPORT_SYMBOL_GPL(enable_pmu);
>>  module_param(enable_pmu, bool, 0444);
>>  
>> +/*
>> + * Enable/disable mediated passthrough PMU virtualization.
>> + * Don't expose it to userspace as a module paramerter until
>> + * all mediated vPMU code is in place.
>> + */
> No need for the comment, documenting this in the changelog is sufficient.

Sure.


>
>> +bool __read_mostly enable_mediated_pmu;
>> +EXPORT_SYMBOL_GPL(enable_mediated_pmu);
>> +
>>  bool __read_mostly eager_page_split = true;
>>  module_param(eager_page_split, bool, 0644);
>>  
>> @@ -6643,9 +6651,28 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>>  			break;
>>  
>>  		mutex_lock(&kvm->lock);
>> -		if (!kvm->created_vcpus) {
>> -			kvm->arch.enable_pmu = !(cap->args[0] & KVM_PMU_CAP_DISABLE);
>> -			r = 0;
>> +		/*
>> +		 * To keep PMU configuration "simple", setting vPMU support is
>> +		 * disallowed if vCPUs are created, or if mediated PMU support
>> +		 * was already enabled for the VM.
>> +		 */
>> +		if (!kvm->created_vcpus &&
>> +		    (!enable_mediated_pmu || !kvm->arch.enable_pmu)) {
>> +			bool pmu_enable = !(cap->args[0] & KVM_PMU_CAP_DISABLE);
>> +
>> +			if (enable_mediated_pmu && pmu_enable) {
> Local APIC check goes here.

Yes.


>
>> +				char *err_msg = "Fail to enable mediated vPMU, " \
>> +					"please disable system wide perf events or nmi_watchdog " \
>> +					"(echo 0 > /proc/sys/kernel/nmi_watchdog).\n";
>> +
>> +				r = perf_get_mediated_pmu();
>> +				if (r)
>> +					kvm_err("%s", err_msg);
>
> #define MEDIATED_PMU_MSG "Fail to enable mediated vPMU, disable system wide perf events and nmi_watchdog.\n"

Sure.


>
> 				r = perf_create_mediated_pmu();
> 				if (r)
> 					kvm_err(MEDIATED_PMU_MSG);
>
>> +			} else
>> +				r = 0;
>> +
>> +			if (!r)
>> +				kvm->arch.enable_pmu = pmu_enable;
>>  		}
>>  		mutex_unlock(&kvm->lock);
>>  		break;
>> @@ -12723,7 +12750,14 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>>  	kvm->arch.default_tsc_khz = max_tsc_khz ? : tsc_khz;
>>  	kvm->arch.apic_bus_cycle_ns = APIC_BUS_CYCLE_NS_DEFAULT;
>>  	kvm->arch.guest_can_read_msr_platform_info = true;
>> -	kvm->arch.enable_pmu = enable_pmu;
>> +
>> +	/*
>> +	 * PMU virtualization is opt-in when mediated PMU support is enabled.
>> +	 * KVM_CAP_PMU_CAPABILITY ioctl must be called explicitly to enable
>> +	 * mediated vPMU. For legacy perf-based vPMU, its behavior isn't changed,
>> +	 * KVM_CAP_PMU_CAPABILITY ioctl is optional.
>> +	 */
> Again, too much extraneous info, the exception proves the rule.  I.e. by calling
> out that mediated PMU is special, it's clear the rule is that PMUs are enabled by
> default in the !mediated case.

Sure.


>
> 	/*
> 	 * Userspace must explicitly opt-in to PMU virtualization when mediated
> 	 * PMU support is enabled (see KVM_CAP_PMU_CAPABILITY).
> 	 */
>
>> +	kvm->arch.enable_pmu = enable_pmu && !enable_mediated_pmu;
> So I tried to run a QEMU with this and it failed, because QEMU expected the PMU
> to be enabled and tried to write to PMU MSRs.  I haven't dug through the QEMU
> code, but I assume that QEMU rightly expects that passing in PMU in CPUID when
> KVM_GET_SUPPORTED_CPUID says its supported will result in the VM having a PMU.

As long as the module parameter "enable_mediated_pmu" is enabled, qemu
needs below extra code to enable mediated vPMU, otherwise PMU is disabled
in KVM.

https://lore.kernel.org/all/20250324123712.34096-1-dapeng1.mi@linux.intel.com/

> I.e. by trying to get cute with backwards compatibility, I think we broke backwards
> compatiblity.  At this point, I'm leaning toward making the module param off-by-default,
> but otherwise not messing with the behavior of kvm->arch.enable_pmu.  Not sure if
> that has implications for KVM_PMU_CAP_DISABLE though.

I'm not sure if it's a kind of break for backwards compatibility.  As long
as "enable_mediated_pmu" is not enabled, the qemu doesn't need any changes,
the legacy vPMU can still be enabled by old qemu version. But if user want
to enable mediated vPMU, so they should use the new version qemu which has
the capability to enable mediated vPMU, it sounds reasonable for me.



