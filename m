Return-Path: <linux-kselftest+bounces-32990-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59461AB7A5A
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 02:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 201497AFEDE
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 00:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289CB4B1E4C;
	Thu, 15 May 2025 00:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qvf8EjE4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE23CA6B
	for <linux-kselftest@vger.kernel.org>; Thu, 15 May 2025 00:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747267778; cv=none; b=DCAsdpSa+4cBQxlmgdiXUOv+SVNsK2qgA7f+VmzfwRdnBICZTl4Jyov924nw1KaVDg9K7GnJjZPQHtGXeeBcVuyLyRux5UWAyTXAU9PB1hjHKWoZ2jKjYcNeT6ZJ/XDFTllf+iUHmE3iOGNAOdXmke432M+tAZidvcxHiFwvubA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747267778; c=relaxed/simple;
	bh=ebAJP3ZuCK7o9jdqJnixc0CAvLRTF4r6aeQRLMVjXek=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P7D7HQj/1q0esg2lH6Va4F5wWfN8o2zp3okLEKa6aM9unb1ZTUyROpxRYlk/o1AD9sr6KkRs79dO/4EU3z3q/8Oplqq45SeTkkJj+DnVwummzEFXq5Bqq28rauAbsgaJMOQlK/TR7XAgVkN4nr2/hcc3aJJWBN2zaoQua6+L1vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qvf8EjE4; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b22809057b1so142576a12.3
        for <linux-kselftest@vger.kernel.org>; Wed, 14 May 2025 17:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747267774; x=1747872574; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D09EdKCu+qKlZnyk51V1issnwhEZW8zkeiyjfE2Xyzc=;
        b=Qvf8EjE4XZxD84wDra+eqFSdrZGfkZW/tpBpoIIX/ByQ05KlWwrLzOXiLwzAcDH5iq
         MAtQwUCZGnGVkdF6G/N7gCzJG0sc9gIYqPywje/wP03LwbKvcSpo9bG//Zk8OCR9xZGK
         /eO8f5xXgMMDP+aJtQQPnuEXeA2snKTw/HbI6H3vP3YqQWIaEhlI74Kilha1dnc9FqcT
         BhzQwaTxyvT6X1QbOHS5Mc9NmMjt3Gqv79ENKglpMeJ60Ya3N3MjHOs+5hGQwpjAcR2S
         yUX+PV/2Iz73Og6z8LPSv5hbvo9XAS3A2D7jmBGsB3/HSQpVajag6u4k6pBGaczAEl9g
         pYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747267774; x=1747872574;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D09EdKCu+qKlZnyk51V1issnwhEZW8zkeiyjfE2Xyzc=;
        b=i8AHzMV4FjzdNVXw5O6EJW+vIF+weVwIcFUweqPPIwn1CW/PYfAJ1z8M1WAPcmG0Bd
         ztTkq8f40+Ad1kB60PEsPj91yRyaYSbYA6mroxofuAtWdBERZQLunF4JZSu6Alp7hoM5
         8sjOF6TAWwZ+Uz6iQm8/huP3Dl7Eu3/VLxcjDfJEvXyeiRMzNwcTYwrox/2mPx01bMyA
         wTJQq9DjUj4aS7T/nQowV5JsHaEnTg4WFY1GAYRd1/YSq9DvtIWBAhHMVrQImpKAIU7G
         toJZvF5awaRlXKRleSgYZd0jKmEbhCRVjtkWz/d693G1WajFFgTxg+ni75Z3MUdcueSp
         jwDA==
X-Forwarded-Encrypted: i=1; AJvYcCU9TtRPywzPQy3d6LMOoZAk9AZpe/F+rImfx58kD8zUBQmp0Sx+Rxeofr+uExboJlvHHO/fbkdb7oD7/t7geAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcKG6CKWjanJRtJ7Icxz8mXdqm6xOVK1OgOqsqtqh2mIfYFAsv
	71FMD2N17P9Nkhj5A9rTLV7yV7U6D8TAWsP7o2R3IwxnPeit0KkMXdbFWozwyiaQ51RHhceYRIo
	LOQ==
X-Google-Smtp-Source: AGHT+IHZxjMDZEUoyieykpHJBN8fkIofFqi4PCpWEy+uuvPUHwBl4Xu9AdE++jsZ4ntU4sQV8cnlqyvgKCE=
X-Received: from pfwz32.prod.google.com ([2002:a05:6a00:1da0:b0:740:c2df:693f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:b882:b0:216:119f:7fa2
 with SMTP id adf61e73a8af0-216119f9be0mr367084637.34.1747267774638; Wed, 14
 May 2025 17:09:34 -0700 (PDT)
Date: Wed, 14 May 2025 17:09:33 -0700
In-Reply-To: <20250324173121.1275209-15-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com> <20250324173121.1275209-15-mizhang@google.com>
Message-ID: <aCUwvXPKD0ANKFb7@google.com>
Subject: Re: [PATCH v4 14/38] KVM: x86/pmu: Introduce enable_mediated_pmu
 global parameter
From: Sean Christopherson <seanjc@google.com>
To: Mingwei Zhang <mizhang@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yongwei Ma <yongwei.ma@intel.com>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Jim Mattson <jmattson@google.com>, 
	Sandipan Das <sandipan.das@amd.com>, Zide Chen <zide.chen@intel.com>, 
	Eranian Stephane <eranian@google.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Mar 24, 2025, Mingwei Zhang wrote:
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
> 
> Introduce enable_mediated_pmu global parameter to control if mediated
> vPMU can be enabled on KVM level. Even enable_mediated_pmu is set to
> true in KVM, user space hypervisor still need to enable mediated vPMU
> explicitly by calling KVM_CAP_PMU_CAPABILITY ioctl. This gives
> hypervisor flexibility to enable or disable mediated vPMU for each VM.
> 
> Mediated vPMU depends on some PMU features on higher PMU version, like
> PERF_GLOBAL_STATUS_SET MSR in v4+ for Intel PMU. Thus introduce a
> pmu_ops variable MIN_MEDIATED_PMU_VERSION to indicates the minimum host
> PMU version which mediated vPMU needs.
> 
> Currently enable_mediated_pmu is not exposed to user space as a module
> parameter until all mediated vPMU code are in place.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Co-developed-by: Mingwei Zhang <mizhang@google.com>
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/kvm/pmu.c              |  3 ++-
>  arch/x86/kvm/pmu.h              | 11 +++++++++
>  arch/x86/kvm/svm/pmu.c          |  1 +
>  arch/x86/kvm/vmx/capabilities.h |  3 ++-
>  arch/x86/kvm/vmx/pmu_intel.c    |  5 ++++
>  arch/x86/kvm/vmx/vmx.c          |  3 ++-
>  arch/x86/kvm/x86.c              | 44 ++++++++++++++++++++++++++++++---
>  arch/x86/kvm/x86.h              |  1 +
>  8 files changed, 64 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 75e9cfc689f8..4f455afe4009 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -775,7 +775,8 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
>  	pmu->pebs_data_cfg_rsvd = ~0ull;
>  	bitmap_zero(pmu->all_valid_pmc_idx, X86_PMC_IDX_MAX);
>  
> -	if (!vcpu->kvm->arch.enable_pmu)
> +	if (!vcpu->kvm->arch.enable_pmu ||
> +	    (!lapic_in_kernel(vcpu) && enable_mediated_pmu))

This check belongs in KVM_CAP_PMU_CAPABILITY, i.e. KVM needs to reject enabling
a mediated PMU without an in-kernel local APIC, not silently drop the PMU.

>  		return;
>  
>  	kvm_pmu_call(refresh)(vcpu);
> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index ad89d0bd6005..dd45a0c6be74 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -45,6 +45,7 @@ struct kvm_pmu_ops {
>  	const u64 EVENTSEL_EVENT;
>  	const int MAX_NR_GP_COUNTERS;
>  	const int MIN_NR_GP_COUNTERS;
> +	const int MIN_MEDIATED_PMU_VERSION;

I like the idea, but simply checking the PMU version is insufficient on Intel,
i.e. just add a callback.

>  };
>  
>  void kvm_pmu_ops_update(const struct kvm_pmu_ops *pmu_ops);
> @@ -63,6 +64,12 @@ static inline bool kvm_pmu_has_perf_global_ctrl(struct kvm_pmu *pmu)
>  	return pmu->version > 1;
>  }
>  
> +static inline bool kvm_mediated_pmu_enabled(struct kvm_vcpu *vcpu)

kvm_vcpu_has_mediated_pmu() to align with e.g. guest_cpu_cap_has(), and because
kvm_mediated_pmu_enabled() sounds like a VM-scoped or module-scoped helper.

> +{
> +	return vcpu->kvm->arch.enable_pmu &&

This is superfluous, pmu->version should never be non-zero without the PMU being
enabled at the VM level.

> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 77012b2eca0e..425e93d4b1c6 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -739,4 +739,9 @@ struct kvm_pmu_ops intel_pmu_ops __initdata = {
>  	.EVENTSEL_EVENT = ARCH_PERFMON_EVENTSEL_EVENT,
>  	.MAX_NR_GP_COUNTERS = KVM_MAX_NR_INTEL_GP_COUNTERS,
>  	.MIN_NR_GP_COUNTERS = 1,
> +	/*
> +	 * Intel mediated vPMU support depends on
> +	 * MSR_CORE_PERF_GLOBAL_STATUS_SET which is supported from 4+.
> +	 */
> +	.MIN_MEDIATED_PMU_VERSION = 4,
>  };
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 00ac94535c21..a4b5b6455c7b 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7916,7 +7916,8 @@ static __init u64 vmx_get_perf_capabilities(void)
>  	if (boot_cpu_has(X86_FEATURE_PDCM))
>  		rdmsrl(MSR_IA32_PERF_CAPABILITIES, host_perf_cap);
>  
> -	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR)) {
> +	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR) &&
> +	    !enable_mediated_pmu) {
>  		x86_perf_get_lbr(&vmx_lbr_caps);
>  
>  		/*

There's a bit too much going on in this patch.  I think it makes sense to split
the vendor chunks out to separate patches, so that each can elaborate on the
exact requirements.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 72995952978a..1ebe169b88b6 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -188,6 +188,14 @@ bool __read_mostly enable_pmu = true;
>  EXPORT_SYMBOL_GPL(enable_pmu);
>  module_param(enable_pmu, bool, 0444);
>  
> +/*
> + * Enable/disable mediated passthrough PMU virtualization.
> + * Don't expose it to userspace as a module paramerter until
> + * all mediated vPMU code is in place.
> + */

No need for the comment, documenting this in the changelog is sufficient.

> +bool __read_mostly enable_mediated_pmu;
> +EXPORT_SYMBOL_GPL(enable_mediated_pmu);
> +
>  bool __read_mostly eager_page_split = true;
>  module_param(eager_page_split, bool, 0644);
>  
> @@ -6643,9 +6651,28 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>  			break;
>  
>  		mutex_lock(&kvm->lock);
> -		if (!kvm->created_vcpus) {
> -			kvm->arch.enable_pmu = !(cap->args[0] & KVM_PMU_CAP_DISABLE);
> -			r = 0;
> +		/*
> +		 * To keep PMU configuration "simple", setting vPMU support is
> +		 * disallowed if vCPUs are created, or if mediated PMU support
> +		 * was already enabled for the VM.
> +		 */
> +		if (!kvm->created_vcpus &&
> +		    (!enable_mediated_pmu || !kvm->arch.enable_pmu)) {
> +			bool pmu_enable = !(cap->args[0] & KVM_PMU_CAP_DISABLE);
> +
> +			if (enable_mediated_pmu && pmu_enable) {

Local APIC check goes here.

> +				char *err_msg = "Fail to enable mediated vPMU, " \
> +					"please disable system wide perf events or nmi_watchdog " \
> +					"(echo 0 > /proc/sys/kernel/nmi_watchdog).\n";
> +
> +				r = perf_get_mediated_pmu();
> +				if (r)
> +					kvm_err("%s", err_msg);


#define MEDIATED_PMU_MSG "Fail to enable mediated vPMU, disable system wide perf events and nmi_watchdog.\n"

				r = perf_create_mediated_pmu();
				if (r)
					kvm_err(MEDIATED_PMU_MSG);

> +			} else
> +				r = 0;
> +
> +			if (!r)
> +				kvm->arch.enable_pmu = pmu_enable;
>  		}
>  		mutex_unlock(&kvm->lock);
>  		break;
> @@ -12723,7 +12750,14 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>  	kvm->arch.default_tsc_khz = max_tsc_khz ? : tsc_khz;
>  	kvm->arch.apic_bus_cycle_ns = APIC_BUS_CYCLE_NS_DEFAULT;
>  	kvm->arch.guest_can_read_msr_platform_info = true;
> -	kvm->arch.enable_pmu = enable_pmu;
> +
> +	/*
> +	 * PMU virtualization is opt-in when mediated PMU support is enabled.
> +	 * KVM_CAP_PMU_CAPABILITY ioctl must be called explicitly to enable
> +	 * mediated vPMU. For legacy perf-based vPMU, its behavior isn't changed,
> +	 * KVM_CAP_PMU_CAPABILITY ioctl is optional.
> +	 */

Again, too much extraneous info, the exception proves the rule.  I.e. by calling
out that mediated PMU is special, it's clear the rule is that PMUs are enabled by
default in the !mediated case.

	/*
	 * Userspace must explicitly opt-in to PMU virtualization when mediated
	 * PMU support is enabled (see KVM_CAP_PMU_CAPABILITY).
	 */

> +	kvm->arch.enable_pmu = enable_pmu && !enable_mediated_pmu;

So I tried to run a QEMU with this and it failed, because QEMU expected the PMU
to be enabled and tried to write to PMU MSRs.  I haven't dug through the QEMU
code, but I assume that QEMU rightly expects that passing in PMU in CPUID when
KVM_GET_SUPPORTED_CPUID says its supported will result in the VM having a PMU.

I.e. by trying to get cute with backwards compatibility, I think we broke backwards
compatiblity.  At this point, I'm leaning toward making the module param off-by-default,
but otherwise not messing with the behavior of kvm->arch.enable_pmu.  Not sure if
that has implications for KVM_PMU_CAP_DISABLE though.

