Return-Path: <linux-kselftest+bounces-29819-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1603FA71C73
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 17:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EA04189E723
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 16:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA1E1F9F75;
	Wed, 26 Mar 2025 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cRElibuu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA7B1F426F;
	Wed, 26 Mar 2025 16:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743007900; cv=none; b=tP9OMkuSoUyPADDH+vTd0XSYE1BEW/IUCL8RsYWdsQXYF4AOABK13NWWgDkZ28hd02RC1wnUVhX1OX+Pk47F++bT7hATi6gBaj45+Y0pbKvzi4z9IZ4M0PXrkX9NEkOGYkF9Jm79NO6QXVB7EpneqaoH8XVxYN2atRUdyHMpQeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743007900; c=relaxed/simple;
	bh=7j+q7Ip4w28ml5S4azRv6bFIOG02D9D0SEfk4jQx5Vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qxqTKsdCq/klvQrmR2AhLvZMtGk3zxrPVzNH4foBYNKaqWS0dMqe8r49hLpMGZp6DjU2wZYOn77iYDZcbacktjGfpv9BGP7psQhHn0rJTqs8RcjJgiJ5ip1UVSv9ACL2Q1jFXwtIiZ92tvljLOg996fvdL4aPkHUtwMgChXMdKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cRElibuu; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743007899; x=1774543899;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7j+q7Ip4w28ml5S4azRv6bFIOG02D9D0SEfk4jQx5Vs=;
  b=cRElibuuoVMeB1KSQdgWMe8vd68RE81a6X2NGwv1eYsfFuEm6y9wNCkW
   vUfbPHyDcdIP7ciJvo1tZIZulVRBPo7zAk3AZR4iHab+Ct4ohsK3RxEKh
   V9icSc6pLG+4uAwEkw35cScLap1Dd+siORiIAdWF+KWtNen/VYJjxaioX
   Gr0PwWTaA8jx3iGz5M1xxCFAjfTOkdxQIYj30/0PveyQKeEqXzhquV9gQ
   DzJTRpAPdqbbEaBlB8HCveiDmimRe87B1njYSZmvyz06cV+74h+1sk3uk
   OYVdmcTQ5ll5oNmQ9sYX7qMY/hD16ODSfDqx4m3gY6bZxrIFh6v8JPNoy
   w==;
X-CSE-ConnectionGUID: gbbbdIpPRseuweL/hMqYyQ==
X-CSE-MsgGUID: LnzZ/21LTWeMU5ICSXBvyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44327857"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="44327857"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 09:51:38 -0700
X-CSE-ConnectionGUID: +ykqutRUQQO5WLB5sfJ9FQ==
X-CSE-MsgGUID: xAKLT0LhRbSwZiHzTrbc0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="124751954"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.24.8.106]) ([10.24.8.106])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 09:51:36 -0700
Message-ID: <4d55c919-92ab-4bfe-a8c2-c0a756546f7c@intel.com>
Date: Wed, 26 Mar 2025 09:51:36 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 21/38] KVM: x86/pmu/vmx: Save/load guest
 IA32_PERF_GLOBAL_CTRL with vm_exit/entry_ctrl
To: Mingwei Zhang <mizhang@google.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com,
 Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Yongwei Ma <yongwei.ma@intel.com>,
 Xiong Zhang <xiong.y.zhang@linux.intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Jim Mattson <jmattson@google.com>,
 Sandipan Das <sandipan.das@amd.com>, Eranian Stephane <eranian@google.com>,
 Shukla Manali <Manali.Shukla@amd.com>,
 Nikunj Dadhania <nikunj.dadhania@amd.com>
References: <20250324173121.1275209-1-mizhang@google.com>
 <20250324173121.1275209-22-mizhang@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20250324173121.1275209-22-mizhang@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/24/2025 10:31 AM, Mingwei Zhang wrote:
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
> 
> Intel processor (vmx) provides capability to save/load guest
> IA32_PERF_GLOBAL_CTRL at vm-exit/vm-entry by setting
> VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL bit in VM-exit-ctrl or
> VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL bit in VM-entry-ctrl.
> 
> Mediated vPMU leverages both capabilities to save/load guest
> IA32_PERF_GLOBAL_CTRL automatically at vm-exit/vm-entry. Note that the
> former was introduced in SapphireRapids and later Intel CPUs.
> 
> If VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL is unavailable, mediated PMU will be
> disabled. Note that mediated PMU can be enabled by falling back to atomic
> msr save/retore list. However, that would cause extra overhead per
> VM-enter/exit.
> 
> Since these VMX capability bits perform automatic saving/restoring of the
> PMU global ctrl between VMCS and the HW MSR. No synchronization was
> performed betwen HW MSR and pmu->global_ctrli, the KVM cached value .
> Therefore, whenever KVM needs to use this variable, it will need to
> explicitly read the value from MSR to pmu->global_ctrl. This is especially
> so when guest doesn't own all PMU counters, i.e., when
> IA32_PERF_GLOBAL_CTRL is interceped by mediated PMU.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Co-developed-by: Mingwei Zhang <mizhang@google.com>
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  4 ++++
>  arch/x86/include/asm/vmx.h      |  1 +
>  arch/x86/kvm/pmu.c              | 30 ++++++++++++++++++++++++-
>  arch/x86/kvm/vmx/capabilities.h |  5 +++++
>  arch/x86/kvm/vmx/nested.c       |  3 ++-
>  arch/x86/kvm/vmx/pmu_intel.c    | 39 ++++++++++++++++++++++++++++++++-
>  arch/x86/kvm/vmx/vmx.c          | 22 ++++++++++++++++++-
>  arch/x86/kvm/vmx/vmx.h          |  3 ++-
>  8 files changed, 102 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 0b7af5902ff7..4b3bfefc2d05 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -553,6 +553,10 @@ struct kvm_pmu {
>  	unsigned available_event_types;
>  	u64 fixed_ctr_ctrl;
>  	u64 fixed_ctr_ctrl_rsvd;
> +	/*
> +	 * kvm_pmu_sync_global_ctrl_from_vmcs() must be called to update
> +	 * this SW-maintained global_ctrl for mediated vPMU before accessing it.
> +	 */
>  	u64 global_ctrl;
>  	u64 global_status;
>  	u64 counter_bitmask[2];
> diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
> index f7fd4369b821..48e137560f17 100644
> --- a/arch/x86/include/asm/vmx.h
> +++ b/arch/x86/include/asm/vmx.h
> @@ -106,6 +106,7 @@
>  #define VM_EXIT_CLEAR_BNDCFGS                   0x00800000
>  #define VM_EXIT_PT_CONCEAL_PIP			0x01000000
>  #define VM_EXIT_CLEAR_IA32_RTIT_CTL		0x02000000
> +#define VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL	0x40000000
>  
>  #define VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR	0x00036dff
>  
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 6ad71752be4b..4e8cefcce7ab 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -646,6 +646,30 @@ void kvm_pmu_deliver_pmi(struct kvm_vcpu *vcpu)
>  	}
>  }
>  
> +static void kvm_pmu_sync_global_ctrl_from_vmcs(struct kvm_vcpu *vcpu)
> +{
> +	struct msr_data msr_info = { .index = MSR_CORE_PERF_GLOBAL_CTRL };
> +
> +	if (!kvm_mediated_pmu_enabled(vcpu))
> +		return;
> +
> +	/* Sync pmu->global_ctrl from GUEST_IA32_PERF_GLOBAL_CTRL. */
> +	kvm_pmu_call(get_msr)(vcpu, &msr_info);
> +}
> +
> +static void kvm_pmu_sync_global_ctrl_to_vmcs(struct kvm_vcpu *vcpu, u64 global_ctrl)
> +{
> +	struct msr_data msr_info = {
> +		.index = MSR_CORE_PERF_GLOBAL_CTRL,
> +		.data = global_ctrl };
> +
> +	if (!kvm_mediated_pmu_enabled(vcpu))
> +		return;
> +
> +	/* Sync pmu->global_ctrl to GUEST_IA32_PERF_GLOBAL_CTRL. */
> +	kvm_pmu_call(set_msr)(vcpu, &msr_info);
> +}
> +
>  bool kvm_pmu_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
>  {
>  	switch (msr) {
> @@ -680,7 +704,6 @@ int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		msr_info->data = pmu->global_status;
>  		break;
>  	case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
> -	case MSR_CORE_PERF_GLOBAL_CTRL:
>  		msr_info->data = pmu->global_ctrl;
>  		break;
>  	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
> @@ -731,6 +754,9 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)


pmu->global_ctrl doesn't always have the up-to-date guest value, need to
sync from vmcs/vmbc before comparing it against 'data'.

+               kvm_pmu_sync_global_ctrl_from_vmcs(vcpu);
                if (pmu->global_ctrl != data) {

>  			diff = pmu->global_ctrl ^ data;
>  			pmu->global_ctrl = data;
>  			reprogram_counters(pmu, diff);
> +
> +			/* Propagate guest global_ctrl to GUEST_IA32_PERF_GLOBAL_CTRL. */
> +			kvm_pmu_sync_global_ctrl_to_vmcs(vcpu, data);
>  		}
>  		break;
>  	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
> @@ -907,6 +933,8 @@ void kvm_pmu_trigger_event(struct kvm_vcpu *vcpu, u64 eventsel)
>  
>  	BUILD_BUG_ON(sizeof(pmu->global_ctrl) * BITS_PER_BYTE != X86_PMC_IDX_MAX);
>  
> +	kvm_pmu_sync_global_ctrl_from_vmcs(vcpu);
> +
>  	if (!kvm_pmu_has_perf_global_ctrl(pmu))
>  		bitmap_copy(bitmap, pmu->all_valid_pmc_idx, X86_PMC_IDX_MAX);
>  	else if (!bitmap_and(bitmap, pmu->all_valid_pmc_idx,
> diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
> index 013536fde10b..cc63bd4ab87c 100644
> --- a/arch/x86/kvm/vmx/capabilities.h
> +++ b/arch/x86/kvm/vmx/capabilities.h
> @@ -101,6 +101,11 @@ static inline bool cpu_has_load_perf_global_ctrl(void)
>  	return vmcs_config.vmentry_ctrl & VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL;
>  }
>  
> +static inline bool cpu_has_save_perf_global_ctrl(void)
> +{
> +	return vmcs_config.vmexit_ctrl & VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL;
> +}
> +
>  static inline bool cpu_has_vmx_mpx(void)
>  {
>  	return vmcs_config.vmentry_ctrl & VM_ENTRY_LOAD_BNDCFGS;
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 8a7af02d466e..ecf72394684d 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -7004,7 +7004,8 @@ static void nested_vmx_setup_exit_ctls(struct vmcs_config *vmcs_conf,
>  		VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR |
>  		VM_EXIT_LOAD_IA32_EFER | VM_EXIT_SAVE_IA32_EFER |
>  		VM_EXIT_SAVE_VMX_PREEMPTION_TIMER | VM_EXIT_ACK_INTR_ON_EXIT |
> -		VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL;
> +		VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
> +		VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL;
>  
>  	/* We support free control of debug control saving. */
>  	msrs->exit_ctls_low &= ~VM_EXIT_SAVE_DEBUG_CONTROLS;
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 2a5f79206b02..04a893e56135 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -294,6 +294,11 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	u32 msr = msr_info->index;
>  
>  	switch (msr) {
> +	case MSR_CORE_PERF_GLOBAL_CTRL:
> +		if (kvm_mediated_pmu_enabled(vcpu))
> +			pmu->global_ctrl = vmcs_read64(GUEST_IA32_PERF_GLOBAL_CTRL);
> +		msr_info->data = pmu->global_ctrl;
> +		break;
>  	case MSR_CORE_PERF_FIXED_CTR_CTRL:
>  		msr_info->data = pmu->fixed_ctr_ctrl;
>  		break;
> @@ -339,6 +344,11 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	u64 reserved_bits, diff;
>  
>  	switch (msr) {
> +	case MSR_CORE_PERF_GLOBAL_CTRL:
> +		if (kvm_mediated_pmu_enabled(vcpu))
> +			vmcs_write64(GUEST_IA32_PERF_GLOBAL_CTRL,
> +				     pmu->global_ctrl);
> +		break;
>  	case MSR_CORE_PERF_FIXED_CTR_CTRL:
>  		if (data & pmu->fixed_ctr_ctrl_rsvd)
>  			return 1;
> @@ -558,10 +568,37 @@ static void __intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  
>  static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  {
> +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> +	struct vcpu_vmx *vmx = to_vmx(vcpu);
> +	bool mediated;
> +
>  	__intel_pmu_refresh(vcpu);
>  
> -	exec_controls_changebit(to_vmx(vcpu), CPU_BASED_RDPMC_EXITING,
> +	exec_controls_changebit(vmx, CPU_BASED_RDPMC_EXITING,
>  				!kvm_rdpmc_in_guest(vcpu));
> +
> +	mediated = kvm_mediated_pmu_enabled(vcpu);
> +	if (cpu_has_load_perf_global_ctrl()) {
> +		vm_entry_controls_changebit(vmx,
> +			VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL, mediated);
> +		/*
> +		 * Initialize guest PERF_GLOBAL_CTRL to reset value as SDM rules.
> +		 *
> +		 * Note: GUEST_IA32_PERF_GLOBAL_CTRL must be initialized to
> +		 * "BIT_ULL(pmu->nr_arch_gp_counters) - 1" instead of pmu->global_ctrl
> +		 * since pmu->global_ctrl is only be initialized when guest
> +		 * pmu->version > 1. Otherwise if pmu->version is 1, pmu->global_ctrl
> +		 * is 0 and guest counters are never really enabled.
> +		 */
> +		if (mediated)
> +			vmcs_write64(GUEST_IA32_PERF_GLOBAL_CTRL,
> +				     BIT_ULL(pmu->nr_arch_gp_counters) - 1);
> +	}
> +
> +	if (cpu_has_save_perf_global_ctrl())
> +		vm_exit_controls_changebit(vmx,
> +			VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
> +			VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL, mediated);
>  }
>  
>  static void intel_pmu_init(struct kvm_vcpu *vcpu)
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index ff66f17d6358..38ecf3c116bd 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -4390,6 +4390,13 @@ void vmx_set_constant_host_state(struct vcpu_vmx *vmx)
>  
>  	if (cpu_has_load_ia32_efer())
>  		vmcs_write64(HOST_IA32_EFER, kvm_host.efer);
> +
> +	/*
> +	 * Initialize host PERF_GLOBAL_CTRL to 0 to disable all counters
> +	 * immediately once VM exits. Mediated vPMU then call perf_guest_exit()
> +	 * to re-enable host perf events.
> +	 */
> +	vmcs_write64(HOST_IA32_PERF_GLOBAL_CTRL, 0);
>  }
>  
>  void set_cr4_guest_host_mask(struct vcpu_vmx *vmx)
> @@ -4457,7 +4464,8 @@ static u32 vmx_get_initial_vmexit_ctrl(void)
>  				 VM_EXIT_CLEAR_IA32_RTIT_CTL);
>  	/* Loading of EFER and PERF_GLOBAL_CTRL are toggled dynamically */
>  	return vmexit_ctrl &
> -		~(VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL | VM_EXIT_LOAD_IA32_EFER);
> +		~(VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL | VM_EXIT_LOAD_IA32_EFER |
> +		  VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL);
>  }
>  
>  void vmx_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
> @@ -7196,6 +7204,9 @@ static void atomic_switch_perf_msrs(struct vcpu_vmx *vmx)
>  	struct perf_guest_switch_msr *msrs;
>  	struct kvm_pmu *pmu = vcpu_to_pmu(&vmx->vcpu);
>  
> +	if (kvm_mediated_pmu_enabled(&vmx->vcpu))
> +		return;
> +
>  	pmu->host_cross_mapped_mask = 0;
>  	if (pmu->pebs_enable & pmu->global_ctrl)
>  		intel_pmu_cross_mapped_check(pmu);
> @@ -8451,6 +8462,15 @@ __init int vmx_hardware_setup(void)
>  		enable_sgx = false;
>  #endif
>  
> +	/*
> +	 * All CPUs that support a mediated PMU are expected to support loading
> +	 * and saving PERF_GLOBAL_CTRL via dedicated VMCS fields.
> +	 */
> +	if (enable_mediated_pmu &&
> +	    (WARN_ON_ONCE(!cpu_has_load_perf_global_ctrl() ||
> +			  !cpu_has_save_perf_global_ctrl())))
> +		enable_mediated_pmu = false;
> +
>  	/*
>  	 * set_apic_access_page_addr() is used to reload apic access
>  	 * page upon invalidation.  No need to do anything if not
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index 5c505af553c8..b282165f98a6 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -510,7 +510,8 @@ static inline u8 vmx_get_rvi(void)
>  	       VM_EXIT_LOAD_IA32_EFER |					\
>  	       VM_EXIT_CLEAR_BNDCFGS |					\
>  	       VM_EXIT_PT_CONCEAL_PIP |					\
> -	       VM_EXIT_CLEAR_IA32_RTIT_CTL)
> +	       VM_EXIT_CLEAR_IA32_RTIT_CTL |				\
> +	       VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL)
>  
>  #define KVM_REQUIRED_VMX_PIN_BASED_VM_EXEC_CONTROL			\
>  	(PIN_BASED_EXT_INTR_MASK |					\


