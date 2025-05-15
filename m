Return-Path: <linux-kselftest+bounces-33016-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A69AFAB7C70
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 05:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E4464A4DFD
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 03:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415FA12C499;
	Thu, 15 May 2025 03:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j7/YF4ns"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0471361;
	Thu, 15 May 2025 03:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747280745; cv=none; b=BrCSrkvzIJkeHjolFJN726lIUQuO+Y+oHtwdXhxI7GbnPa7x2DKXnXgElV6Qo5IeuWTTry4kLX3oVsOb938EB7bALw/KeNq6yF29gSQu6yRTx7W+tZJZtIehs4NsYC3NMsSC5/evGPvJwagvazqHJan//bEEDcKuEvwOFOERxy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747280745; c=relaxed/simple;
	bh=tGr307HCw1T+7zsfEplVXFrFlJlzWpsW+UUf+2EEZuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dawcT0PoGxxI3RYZR7vRzYqj/OVG1AjZ5CLG1omg6MJEV90XrfAKhd8RtG3I2mks9RqIPdsHyj3Y//nqx3UD/iQXyie1QB1+sHusXkThnSAhwWtpqHbPA1qHdlChDSiRTiJR42JrAgcoPyhsodJJX20hEZAkxDJ+oldKDVclaMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j7/YF4ns; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747280744; x=1778816744;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tGr307HCw1T+7zsfEplVXFrFlJlzWpsW+UUf+2EEZuE=;
  b=j7/YF4nsYgkDrKzdOECNfIRraJDpOx1AcPjm5meVpT/KLWTqxwshqiq8
   mrfEmLK/PafBSBPpiSfep6yx4wxNcGWqhBL7a9LDPKnlIwtUJaBasj39l
   fAUlPUDhOORlako81SEnXTSBLHTNYhEP2k+mo8PtKYgX3E8tjncDtr+9F
   t3xkoJrEuOMhSDSefyjUkwww3MU+Mz9We02JBQ2G1r2GMOho0MFbqyokv
   wk3zV7iC5CAc+X5X6U9vT6+LKkZAtOShxEl/v/bH5vsYuwQqEU5cwAbAf
   yF2M+b7Bax00MqaNdUwEQNJmNG3teSJftPT/D2ESu8K8UiEwByJW3BuKY
   w==;
X-CSE-ConnectionGUID: QwzhmUINTraTcypjHi5KKQ==
X-CSE-MsgGUID: IYTjXIzwQNiXNkoDff/cNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="66606431"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="66606431"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 20:45:42 -0700
X-CSE-ConnectionGUID: xMo36eKQQ32U3Z83uPI5/Q==
X-CSE-MsgGUID: JyCMxJ5xRFqaIG/rFzkziw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="143339351"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 20:45:35 -0700
Message-ID: <d585c449-19f0-4a07-9223-82d892f7d3e0@linux.intel.com>
Date: Thu, 15 May 2025 11:45:32 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 21/38] KVM: x86/pmu/vmx: Save/load guest
 IA32_PERF_GLOBAL_CTRL with vm_exit/entry_ctrl
To: Sean Christopherson <seanjc@google.com>,
 Mingwei Zhang <mizhang@google.com>
Cc: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
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
 Eranian Stephane <eranian@google.com>, Shukla Manali
 <Manali.Shukla@amd.com>, Nikunj Dadhania <nikunj.dadhania@amd.com>
References: <20250324173121.1275209-1-mizhang@google.com>
 <20250324173121.1275209-22-mizhang@google.com>
 <4d55c919-92ab-4bfe-a8c2-c0a756546f7c@intel.com>
 <CAL715WLfr5k=Rz0cQ08xS=eHEyRn83PBTiqQ5H7iX4qH=jiS8A@mail.gmail.com>
 <aCU2YEpU0dOk7RTk@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aCU2YEpU0dOk7RTk@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 5/15/2025 8:33 AM, Sean Christopherson wrote:
> On Wed, Mar 26, 2025, Mingwei Zhang wrote:
>> On Wed, Mar 26, 2025 at 9:51 AM Chen, Zide <zide.chen@intel.com> wrote:
>>>> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
>>>> index 6ad71752be4b..4e8cefcce7ab 100644
>>>> --- a/arch/x86/kvm/pmu.c
>>>> +++ b/arch/x86/kvm/pmu.c
>>>> @@ -646,6 +646,30 @@ void kvm_pmu_deliver_pmi(struct kvm_vcpu *vcpu)
>>>>       }
>>>>  }
>>>>
>>>> +static void kvm_pmu_sync_global_ctrl_from_vmcs(struct kvm_vcpu *vcpu)
>>>> +{
>>>> +     struct msr_data msr_info = { .index = MSR_CORE_PERF_GLOBAL_CTRL };
>>>> +
>>>> +     if (!kvm_mediated_pmu_enabled(vcpu))
>>>> +             return;
>>>> +
>>>> +     /* Sync pmu->global_ctrl from GUEST_IA32_PERF_GLOBAL_CTRL. */
>>>> +     kvm_pmu_call(get_msr)(vcpu, &msr_info);
>>>> +}
>>>> +
>>>> +static void kvm_pmu_sync_global_ctrl_to_vmcs(struct kvm_vcpu *vcpu, u64 global_ctrl)
>>>> +{
>>>> +     struct msr_data msr_info = {
>>>> +             .index = MSR_CORE_PERF_GLOBAL_CTRL,
>>>> +             .data = global_ctrl };
>>>> +
>>>> +     if (!kvm_mediated_pmu_enabled(vcpu))
>>>> +             return;
>>>> +
>>>> +     /* Sync pmu->global_ctrl to GUEST_IA32_PERF_GLOBAL_CTRL. */
>>>> +     kvm_pmu_call(set_msr)(vcpu, &msr_info);
> Eh, just add a dedicated kvm_pmu_ops hook.  Feeding this through set_msr() avoids
> adding another hook, but makes the code hard to follow and requires the above
> ugly boilerplate.

Sure. I originally thought if it's worthy to add a new kvm_pmu_ops hook
since only Intel platforms need it.


>
>>>> +}
>>>> +
>>>>  bool kvm_pmu_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
>>>>  {
>>>>       switch (msr) {
>>>> @@ -680,7 +704,6 @@ int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>>>               msr_info->data = pmu->global_status;
>>>>               break;
>>>>       case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
>>>> -     case MSR_CORE_PERF_GLOBAL_CTRL:
>>>>               msr_info->data = pmu->global_ctrl;
>>>>               break;
>>>>       case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
>>>> @@ -731,6 +754,9 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>>
>>> pmu->global_ctrl doesn't always have the up-to-date guest value, need to
>>> sync from vmcs/vmbc before comparing it against 'data'.
>>>
>>> +               kvm_pmu_sync_global_ctrl_from_vmcs(vcpu);
>>>                 if (pmu->global_ctrl != data) {
>> Good catch. Thanks!
>>
>> This is why I really prefer just unconditionally syncing the global
>> ctrl from VMCS to pmu->global_ctrl and vice versa.
>>
>> We might get into similar problems as well in the future.
> The problem isn't conditional synchronization, it's that y'all reinvented the
> wheel, poorly.  This is a solved problem via EXREG and wrappers.
>
> That said, I went through the exercise of adding a PERF_GLOBAL_CTRL EXREG and
> associated wrappers, and didn't love the result.  Host writes should be rare, so
> the dirty tracking is overkill.  For reads, the cost of VMREAD is lower than
> VMWRITE (doesn't trigger consistency check re-evaluation on VM-Enter), and is
> dwarfed by the cost of switching all other PMU state.
>
> So I think for the initial implementation, it makes sense to propagated writes
> to the VMCS on demand, but do VMREAD after VM-Exit (if VM-Enter was successful).
> We can always revisit the optimization if/when we optimize the PMU world switches,
> e.g. to defer them if there are no active host events.

Sure.


>
>>>> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
>>>> index 8a7af02d466e..ecf72394684d 100644
>>>> --- a/arch/x86/kvm/vmx/nested.c
>>>> +++ b/arch/x86/kvm/vmx/nested.c
>>>> @@ -7004,7 +7004,8 @@ static void nested_vmx_setup_exit_ctls(struct vmcs_config *vmcs_conf,
>>>>               VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR |
>>>>               VM_EXIT_LOAD_IA32_EFER | VM_EXIT_SAVE_IA32_EFER |
>>>>               VM_EXIT_SAVE_VMX_PREEMPTION_TIMER | VM_EXIT_ACK_INTR_ON_EXIT |
>>>> -             VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL;
>>>> +             VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
>>>> +             VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL;
> This is completely wrong.  Stuffing VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL here
> advertises support for KVM emulation of the control, and that support is non-existent
> in this patch (and series).
>
> Just drop this, emulation of VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL can be done
> separately.

Sure.


>
>>>> +     mediated = kvm_mediated_pmu_enabled(vcpu);
>>>> +     if (cpu_has_load_perf_global_ctrl()) {
>>>> +             vm_entry_controls_changebit(vmx,
>>>> +                     VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL, mediated);
>>>> +             /*
>>>> +              * Initialize guest PERF_GLOBAL_CTRL to reset value as SDM rules.
>>>> +              *
>>>> +              * Note: GUEST_IA32_PERF_GLOBAL_CTRL must be initialized to
>>>> +              * "BIT_ULL(pmu->nr_arch_gp_counters) - 1" instead of pmu->global_ctrl
>>>> +              * since pmu->global_ctrl is only be initialized when guest
>>>> +              * pmu->version > 1. Otherwise if pmu->version is 1, pmu->global_ctrl
>>>> +              * is 0 and guest counters are never really enabled.
>>>> +              */
>>>> +             if (mediated)
>>>> +                     vmcs_write64(GUEST_IA32_PERF_GLOBAL_CTRL,
>>>> +                                  BIT_ULL(pmu->nr_arch_gp_counters) - 1);
> This belongs in common code, as a call to the aforementioned hook to propagate
> PERF_GLOBAL_CTRL to hardware.

Sure.


>
>>>> +     }
>>>> +
>>>> +     if (cpu_has_save_perf_global_ctrl())
>>>> +             vm_exit_controls_changebit(vmx,
>>>> +                     VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
>>>> +                     VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL, mediated);
>>>>  }
>>>>
>>>>  static void intel_pmu_init(struct kvm_vcpu *vcpu)
>>>> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>>>> index ff66f17d6358..38ecf3c116bd 100644
>>>> --- a/arch/x86/kvm/vmx/vmx.c
>>>> +++ b/arch/x86/kvm/vmx/vmx.c
>>>> @@ -4390,6 +4390,13 @@ void vmx_set_constant_host_state(struct vcpu_vmx *vmx)
>>>>
>>>>       if (cpu_has_load_ia32_efer())
>>>>               vmcs_write64(HOST_IA32_EFER, kvm_host.efer);
>>>> +
>>>> +     /*
>>>> +      * Initialize host PERF_GLOBAL_CTRL to 0 to disable all counters
>>>> +      * immediately once VM exits. Mediated vPMU then call perf_guest_exit()
>>>> +      * to re-enable host perf events.
>>>> +      */
>>>> +     vmcs_write64(HOST_IA32_PERF_GLOBAL_CTRL, 0);
> This needs to be conditioned on the mediated PMU being enabled, because this field
> is not constant when using the emulated PMU (or no vPMU).

Yes.


>
>>>> @@ -8451,6 +8462,15 @@ __init int vmx_hardware_setup(void)
>>>>               enable_sgx = false;
>>>>  #endif
>>>>
>>>> +     /*
>>>> +      * All CPUs that support a mediated PMU are expected to support loading
>>>> +      * and saving PERF_GLOBAL_CTRL via dedicated VMCS fields.
>>>> +      */
>>>> +     if (enable_mediated_pmu &&
>>>> +         (WARN_ON_ONCE(!cpu_has_load_perf_global_ctrl() ||
>>>> +                       !cpu_has_save_perf_global_ctrl())))
> This needs to be conditioned on !HYPERVISOR, or it *will* fire.

Ok.


>
> And placing this check here, without *any* mention of *why* you did so, is evil
> and made me very grumpy.  I had to discover the hard way that you checked the
> VMCS fields here, instead of in kvm_init_pmu_capability() where it logically
> belongs, because the VMCS configuration isn't yet initialized.
>
> Grumpiness aside, I don't like this late clear of enable_mediated_pmu, as it risks
> a variation of the problem you're trying to avoid, i.e. risks consuming the variable
> between kvm_init_pmu_capability() and here.

Yes.


>
> I don't see any reason why setup_vmcs_config() can't be called before
> kvm_x86_vendor_init(), so unless I'm missing/forgetting something, let's just do
> that, and move these checks where they belong.

I'm not quite sure about this. Let me double check.



