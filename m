Return-Path: <linux-kselftest+bounces-33087-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86833AB8C80
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 18:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3173750041E
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 16:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF6E22489F;
	Thu, 15 May 2025 16:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ISFL80QA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD24224223
	for <linux-kselftest@vger.kernel.org>; Thu, 15 May 2025 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747326561; cv=none; b=TecNILeiK++4RgOgsfTvCaA9L9gBtA6TLwoa5v57QGyK8VhbOIhy3V+jMTOqTUGt7ekrQ01AJWsz2M7dgc3AICyxFxSoxTfvOcThcoQ+K673njifnneQJ5TkM2Q5Q45ScLSsfX7Y6IeAhq1U0JvdIEt14pfEvaTvo3h6GNRwaR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747326561; c=relaxed/simple;
	bh=Dpe5GUytD/ZBfI9RSwk6yyNyU3qFGXl1KlZv7Wh3PnY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AVo820zAlMcAiqKv/iBFWg8weWUS9gdNM7Hth+M9tvvf0lsf7Yr5eDq0E4vP5lPpm6ztegCAbRIShUqerV5dFTgSVYFHZfHeWbZeS6BQ+a6b9usEDwWbUhWGm2bJRItZLbkyRWBAvJvQLSXjoB9P8Mz/cprSb9V1XQlDDboVhnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ISFL80QA; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-742951722b3so980538b3a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 15 May 2025 09:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747326558; x=1747931358; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=33G1FuWPJhrQeT4tEtrokH8++dgRv3pDhHxeoQfcB18=;
        b=ISFL80QALiu45+yxd4seLdnOVcdG52kTWsSbi7lUqMrIY0ugzLiyaVbJX/6no29Maq
         ibvep4ZHgdwdC7CTxp35vfOYjjcaJHh2fh7/EJK59C7SCEE4W4aZYzl9A9248L06dt4o
         ilY3K6elbaReICBIg44ucg6hF4rdWxawCk1eyhI/JMEbnBm5LUSjKu2kPidBzvQgjCCk
         Mq9Y3M9RgfPQJ553e8ulBztj/X1hh/T+6TcFu143PfZAOS6jTCvN3wpug5SflRjtBJrO
         v9BQ1jmaLV2+v+PpokQnKCp56wroMyrzkCJb6h9TxgdglvtiF4PIn8RjbUK1d36oGhu7
         U7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747326558; x=1747931358;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=33G1FuWPJhrQeT4tEtrokH8++dgRv3pDhHxeoQfcB18=;
        b=F+07Arfz1uwFXo1ZsPV8C6IEn8jP8jTIUNI+ks/lw+MxJHWBXdW3Tet0GPvkc4qten
         afKP7fRK/aUv1KiXrLIoM7Ywawx5mt/auK8PUpk0x88PFhOrKXxz2+NKIFPS11u1P775
         sBZCl3mWcoy810lDIm5n9yRJ6N1noNziLXjO5lejQGgA61QYBMNEm4RxJJdOFooUgYVa
         EDYUyuLV4nEpHQhdPEo3+d6wyXIxeiUg3Xw96pNC1g4A0FdYQCZcGvPjekchSerSLiVc
         iRpawZ+CSVEylFveJf3RkuZ/uyYT4TiqGcByWlWyCxzljpxOrAZs4kU0vsoxrFYNJ5wP
         lmqg==
X-Forwarded-Encrypted: i=1; AJvYcCXPXGoU9m8r+BOLcwT62Un8iJ1LU5r1WNx+mYqspJau11tIUyMYUIIZfNLkq7Nj5007iXaBFuFnGP+Qe2LA9t4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXIdrxN6j7bSYPReBfmqDW/GCMVf4a25S9MS7MNbZS2eI+31Gd
	NFNVu1wgbdtzZ1dFv9M/1A5VssiXiFjkX5MoEjy+7pMzbvq8cM0mI/WmdBNWDnaZRbPwMyh8ROS
	v+hUWPg==
X-Google-Smtp-Source: AGHT+IG6i4Ql7QxdqDS+namDmxhrAYEcLOTNClrETOX5R5KqFJpjaHYTWyhnRXJ27aSZiPLgy5D8PFJ682M=
X-Received: from pgar27.prod.google.com ([2002:a05:6a02:2e9b:b0:b1f:866e:b28a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d88:b0:215:db66:2a32
 with SMTP id adf61e73a8af0-216219ba60emr236442637.33.1747326558483; Thu, 15
 May 2025 09:29:18 -0700 (PDT)
Date: Thu, 15 May 2025 09:29:17 -0700
In-Reply-To: <20250324173121.1275209-30-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com> <20250324173121.1275209-30-mizhang@google.com>
Message-ID: <aCYWXXpFcx33uVPi@google.com>
Subject: Re: [PATCH v4 29/38] KVM: x86/pmu: Switch host/guest PMU context at vm-exit/vm-entry
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
> diff --git a/arch/x86/include/asm/kvm-x86-pmu-ops.h b/arch/x86/include/asm/kvm-x86-pmu-ops.h
> index 9159bf1a4730..35f27366c277 100644
> --- a/arch/x86/include/asm/kvm-x86-pmu-ops.h
> +++ b/arch/x86/include/asm/kvm-x86-pmu-ops.h
> @@ -22,6 +22,8 @@ KVM_X86_PMU_OP(init)
>  KVM_X86_PMU_OP_OPTIONAL(reset)
>  KVM_X86_PMU_OP_OPTIONAL(deliver_pmi)
>  KVM_X86_PMU_OP_OPTIONAL(cleanup)
> +KVM_X86_PMU_OP(put_guest_context)
> +KVM_X86_PMU_OP(load_guest_context)

For KVM, the "guest_context" part is largely superfluous, as KVM always operates
on guest state, e.g. kvm_fpu_{load,put}().

I do think we should squeeze in "mediated" somewhere, otherwise the it's hard to
see that these are specific to the mediated PMU.

So probably mediated_{load,put}()?

>  #undef KVM_X86_PMU_OP
>  #undef KVM_X86_PMU_OP_OPTIONAL
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 7ee74bbbb0aa..4117a382739a 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -568,6 +568,10 @@ struct kvm_pmu {
>  	u64 raw_event_mask;
>  	struct kvm_pmc gp_counters[KVM_MAX_NR_GP_COUNTERS];
>  	struct kvm_pmc fixed_counters[KVM_MAX_NR_FIXED_COUNTERS];
> +	u32 gp_eventsel_base;
> +	u32 gp_counter_base;
> +	u32 fixed_base;
> +	u32 cntr_shift;

Gah, my bad, "shift" was a terrible suggestion.  It should be "stride".

> @@ -306,6 +313,10 @@ void kvm_pmu_destroy(struct kvm_vcpu *vcpu);
>  int kvm_vm_ioctl_set_pmu_event_filter(struct kvm *kvm, void __user *argp);
>  void kvm_pmu_trigger_event(struct kvm_vcpu *vcpu, u64 eventsel);
>  bool vcpu_pmu_can_enable(struct kvm_vcpu *vcpu);
> +void kvm_pmu_put_guest_pmcs(struct kvm_vcpu *vcpu);
> +void kvm_pmu_load_guest_pmcs(struct kvm_vcpu *vcpu);
> +void kvm_pmu_put_guest_context(struct kvm_vcpu *vcpu);
> +void kvm_pmu_load_guest_context(struct kvm_vcpu *vcpu);
>  
>  bool is_vmware_backdoor_pmc(u32 pmc_idx);
>  bool kvm_rdpmc_in_guest(struct kvm_vcpu *vcpu);
> diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
> index 1a7e3a897fdf..7e0d84d50b74 100644
> --- a/arch/x86/kvm/svm/pmu.c
> +++ b/arch/x86/kvm/svm/pmu.c
> @@ -175,6 +175,22 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	return 1;
>  }
>  
> +static inline void amd_update_msr_base(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> +
> +	if (kvm_pmu_has_perf_global_ctrl(pmu) ||
> +	    guest_cpu_cap_has(vcpu, X86_FEATURE_PERFCTR_CORE)) {
> +		pmu->gp_eventsel_base = MSR_F15H_PERF_CTL0;
> +		pmu->gp_counter_base = MSR_F15H_PERF_CTR0;
> +		pmu->cntr_shift = 2;
> +	} else {
> +		pmu->gp_eventsel_base = MSR_K7_EVNTSEL0;
> +		pmu->gp_counter_base = MSR_K7_PERFCTR0;
> +		pmu->cntr_shift = 1;
> +	}
> +}

Moving quoted text around to organize responses...

> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 796b7bc4affe..ed17ab198dfb 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -460,6 +460,17 @@ static void intel_pmu_enable_fixed_counter_bits(struct kvm_pmu *pmu, u64 bits)
>  		pmu->fixed_ctr_ctrl_rsvd &= ~intel_fixed_bits_by_idx(i, bits);
>  }
>  
> +static inline void intel_update_msr_base(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> +
> +	pmu->gp_eventsel_base = MSR_P6_EVNTSEL0;
> +	pmu->gp_counter_base = fw_writes_is_enabled(vcpu) ?
> +			       MSR_IA32_PMC0 : MSR_IA32_PERFCTR0;

This is wrong.  And I unintentionally proved that it's wrong, by goofing when I
fixed up this code and using MSR_IA32_PERFCTR0 instead of MSR_IA32_PMC0.

Whether or not the guest supports full-width writes is irrelevant, because support
for FW writes doesn't change the width of the counters.  Just because the *guest* 
can't directly write all e.g. 48 bits doesn't mean clobbering bits 47:32 is ok.

Similarly, on the AMD side, using the legacy interface in KVM is unnecessary.
The guest may be limited to those MSRs, but KVM has a hard dependency on PMU v2,
so just unconditionally use MSR_F15H_PERF_CTR0 (and for the record, because I
had to look it up, the newfangled MSRs on AMD are aliased to the legacy MSRs for
0..3).

Very happily, that means the MSRs don't need to be per-PMU, and they don't even
need to be configured at runtime for a given vendor.  Simply require FW writes
on Intel to enable the mediated PMU, and then hardcode the GP base to MSR_IA32_PMC0.

> +static void amd_put_guest_context(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> +
> +	rdmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, pmu->global_ctrl);
> +	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, 0);
> +	rdmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS, pmu->global_status);
> +
> +	/* Clear global status bits if non-zero */
> +	if (pmu->global_status)
> +		wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, pmu->global_status);
> +
> +	kvm_pmu_put_guest_pmcs(vcpu);
> +}
> +
> +static void amd_load_guest_context(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> +	u64 global_status;
> +
> +	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, 0);

Back when I suggested we give up on trying to handle PMCs and eventsels in common
x86, this WRMSR didn't exist.  Now that it does, I don't see anything that prevents
invoking kvm_pmu_{load,put}_guest_pmcs() from common x86, KVM just needs to clear
GLOBAL_CTRL before setting eventsels and PMCs.

For the load path:

	/*
	 * Disable all counters before loading event selectors and PMCs so that
	 * KVM doesn't enable or load guest counters while host events are
	 * active.  VMX will enable/disabled counters at VM-Enter/VM-Exit by
	 * atomically loading PERF_GLOBAL_CONTROL.  SVM effectively performs
	 * the switch by configuring all events to be GUEST_ONLY.
	 */
	wrmsrl(kvm_pmu_ops.PERF_GLOBAL_CTRL, 0);

	kvm_pmu_load_guest_pmcs(vcpu);

	kvm_pmu_call(mediated_load)(vcpu);

And for the put path, just reverse the ordering:

	/*
	 * Defer handling of PERF_GLOBAL_CTRL to vendor code.  On Intel, it's
	 * atomically cleared on VM-Exit, i.e. doesn't need to be clear here.
	 */
	kvm_pmu_call(mediated_put)(vcpu);

	kvm_pmu_put_guest_pmcs(vcpu);

	perf_put_guest_context();

On Intel, PERF_GLOBAL_CTRL is cleared on VM-Exit, and on AMD, the vendor hook
will clear it.  The fact that vendor code sets other MSRs is irrelevant, what
matters is that all counters are quieseced.

I think it's still worth having helpers, but they can be static locals.

> +
> +	kvm_pmu_load_guest_pmcs(vcpu);
> +
> +	rdmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS, global_status);
> +	/* Clear host global_status MSR if non-zero. */
> +	if (global_status)
> +		wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, global_status);
> +
> +	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET, pmu->global_status);
> +	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, pmu->global_ctrl);
> +}
> +
>  static void intel_pmu_update_msr_intercepts(struct kvm_vcpu *vcpu)
> @@ -809,6 +822,50 @@ void intel_pmu_cross_mapped_check(struct kvm_pmu *pmu)
>  	}
>  }
>  
> +static void intel_put_guest_context(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> +
> +	/* Global ctrl register is already saved at VM-exit. */
> +	rdmsrl(MSR_CORE_PERF_GLOBAL_STATUS, pmu->global_status);
> +
> +	/* Clear hardware MSR_CORE_PERF_GLOBAL_STATUS MSR, if non-zero. */
> +	if (pmu->global_status)
> +		wrmsrl(MSR_CORE_PERF_GLOBAL_OVF_CTRL, pmu->global_status);
> +
> +	rdmsrl(MSR_CORE_PERF_FIXED_CTR_CTRL, pmu->fixed_ctr_ctrl_hw);
> +
> +	/*
> +	 * Clear hardware FIXED_CTR_CTRL MSR to avoid information leakage and
> +	 * also avoid these guest fixed counters get accidentially enabled
> +	 * during host running when host enable global ctrl.
> +	 */
> +	if (pmu->fixed_ctr_ctrl_hw)
> +		wrmsrl(MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
> +
> +	kvm_pmu_put_guest_pmcs(vcpu);
> +}
> +
> +static void intel_load_guest_context(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> +	u64 global_status, toggle;
> +
> +	/* Clear host global_ctrl MSR if non-zero. */
> +	wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, 0);
> +
> +	rdmsrl(MSR_CORE_PERF_GLOBAL_STATUS, global_status);
> +	toggle = pmu->global_status ^ global_status;
> +	if (global_status & toggle)
> +		wrmsrl(MSR_CORE_PERF_GLOBAL_OVF_CTRL, global_status & toggle);
> +	if (pmu->global_status & toggle)
> +		wrmsrl(MSR_CORE_PERF_GLOBAL_STATUS_SET, pmu->global_status & toggle);
> +
> +	wrmsrl(MSR_CORE_PERF_FIXED_CTR_CTRL, pmu->fixed_ctr_ctrl_hw);
> +
> +	kvm_pmu_load_guest_pmcs(vcpu);
> +}

