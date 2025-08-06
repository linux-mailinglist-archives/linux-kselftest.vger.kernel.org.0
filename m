Return-Path: <linux-kselftest+bounces-38398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A29B1CA94
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 19:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B604918C15E6
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 17:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A8829B8F8;
	Wed,  6 Aug 2025 17:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VtkQ++7b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614E6296141
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Aug 2025 17:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754500881; cv=none; b=grNZ7ugXqlKI6GVRN+cJuFCuTiqoSsISUU5A5OKcWq80KkK4VYz86SDbk+9IzHXSOH1emNULJQC2cbuWup4O6le86C/WAF6gwpzF0avM2U7iwNThBOqvKcHji1vIMgIQ2QV/x1tKNhIRKDwenx8SN7nSWe5ffcMRuTwj9ftk/NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754500881; c=relaxed/simple;
	bh=kjhnQ5Za+XBsranDfYgw0zRqfwEAy/mULiOdftIXj5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwJvc++UpgTuLivfHhQPAM19A7d4jNMtHQvROTlNKV710KxtpvTTPGL9zHm/MAAXPH4l4Z32Wi6CMJvvJ6XAY6wakob96n5JAoNigyl4cw1df0D2X1cPzZO4iMMfSt1GY6kl8T9/gHnFibvO/V3ez/jOmcpKC85M4zwuvfjK6e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VtkQ++7b; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 6 Aug 2025 10:20:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754500867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LXEzdvjKc1frf74KZZ2Dk9UeoT9Qj8s/haDO00iYsCY=;
	b=VtkQ++7b2u/bXmsWSk18w3r7GM1P5JVR7OF9qYXkJUdtUAb1xF+174eBKK9E0p7iYnpU9o
	qMZ/Jn24nSr9r2S/3tLcPCdxS8TX5DhSvQ3mumqS7+RSehNtdiprcMvvWdydZeJAT64sl/
	DZOMHF4WOTVO1Lqo5qTY5dzVsOhTh5M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	devel@daynix.com, kvm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/2] KVM: arm64: PMU: Introduce
 KVM_ARM_VCPU_PMU_V3_COMPOSITION
Message-ID: <aJOO99xUrhsrvLwl@linux.dev>
References: <20250806-hybrid-v2-0-0661aec3af8c@rsg.ci.i.u-tokyo.ac.jp>
 <20250806-hybrid-v2-1-0661aec3af8c@rsg.ci.i.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806-hybrid-v2-1-0661aec3af8c@rsg.ci.i.u-tokyo.ac.jp>
X-Migadu-Flow: FLOW_OUT

Hi Akihiko,

This is an unreasonably large patch that needs to be broken down into
smaller patches, ideally one functional change per patch. We need this
even for an RFC for the sake of reviews.

On Wed, Aug 06, 2025 at 06:09:54PM +0900, Akihiko Odaki wrote:
> +static u64 kvm_pmu_get_pmc_value(struct kvm_vcpu *vcpu, u8 idx)
>  {
> -	struct kvm_vcpu *vcpu = kvm_pmc_to_vcpu(pmc);
> +	struct kvm_pmc *pmc = *kvm_vcpu_idx_to_pmc(vcpu, idx);
>  	u64 counter, reg, enabled, running;
> +	unsigned int i;
>  
> -	reg = counter_index_to_reg(pmc->idx);
> +	reg = counter_index_to_reg(idx);
>  	counter = __vcpu_sys_reg(vcpu, reg);
>  
>  	/*
>  	 * The real counter value is equal to the value of counter register plus
>  	 * the value perf event counts.
>  	 */
> -	if (pmc->perf_event)
> -		counter += perf_event_read_value(pmc->perf_event, &enabled,
> -						 &running);
> +	if (pmc)
> +		for (i = 0; i < pmc->nr_perf_events; i++)
> +			counter += perf_event_read_value(pmc->perf_events[i],
> +							 &enabled, &running);

I'm concerned that this array of events concept you're introducing is
going to be error-prone. An approach that reallocates a new PMU event in
the case of a vCPU migrating to a new PMU implementation would be
desirable.

> +static void reset_sample_period(struct perf_event *perf_event)
> +{
> +	struct kvm_pmc **pmc = perf_event->overflow_handler_context;
> +	struct kvm_vcpu *vcpu = kvm_pmc_to_vcpu(pmc);
> +	struct arm_pmu *cpu_pmu = to_arm_pmu(perf_event->pmu);
> +	u64 period;
> +
> +	cpu_pmu->pmu.stop(perf_event, PERF_EF_UPDATE);
> +
> +	/*
> +	 * Reset the sample period to the architectural limit,
> +	 * i.e. the point where the counter overflows.
> +	 */
> +	period = compute_period(pmc, kvm_pmu_get_pmc_value(vcpu, (*pmc)->idx));
> +
> +	local64_set(&perf_event->hw.period_left, 0);
> +	perf_event->attr.sample_period = period;
> +	perf_event->hw.sample_period = period;
> +
> +	cpu_pmu->pmu.start(perf_event, PERF_EF_RELOAD);
> +}

No, we can't start calling into the internal driver interfaces. The fact
that we have a pointer to the PMU is an ugly hack and shouldn't be used
like this.

> @@ -725,8 +729,8 @@ static void kvm_pmu_create_perf_event(struct kvm_pmc *pmc)
>  	attr.type = arm_pmu->pmu.type;
>  	attr.size = sizeof(attr);
>  	attr.pinned = 1;
> -	attr.disabled = !kvm_pmu_counter_is_enabled(pmc);
> -	attr.exclude_user = !kvm_pmc_counts_at_el0(pmc);
> +	attr.disabled = !kvm_pmu_counter_is_enabled(vcpu, (*pmc)->idx);
> +	attr.exclude_user = !kvm_pmc_counts_at_el0(vcpu, (*pmc)->idx);
>  	attr.exclude_hv = 1; /* Don't count EL2 events */
>  	attr.exclude_host = 1; /* Don't count host events */
>  	attr.config = eventsel;

Can we just special-case the fixed CPU cycle counter to use
PERF_TYPE_HARDWARE / PERF_COUNT_HW_CPU_CYCLES? That _should_ have the
intended effect of opening an event on the PMU for this CPU.

> +	/*
> +	 * If we have a filter in place and that the event isn't allowed, do
> +	 * not install a perf event either.
> +	 */
> +	if (vcpu->kvm->arch.pmu_filter &&
> +	    !test_bit(eventsel, vcpu->kvm->arch.pmu_filter))
> +		return;
> +
> +	if (arm_pmu) {
> +		*pmc = kvm_pmu_alloc_pmc(idx, 1);
> +		if (!*pmc)
> +			goto err;
> +
> +		kvm_pmu_create_perf_event(pmc, arm_pmu, eventsel);
> +	} else {
> +		guard(mutex)(&arm_pmus_lock);

This is a system-wide lock, the need for which is eliminated if you go
for the reallocation approach I mention.

> +static int kvm_arm_pmu_v3_set_pmu_composition(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm *kvm = vcpu->kvm;
> +	struct arm_pmu_entry *entry;
> +	struct arm_pmu *arm_pmu;
> +
> +	lockdep_assert_held(&kvm->arch.config_lock);
> +
> +	if (kvm_vm_has_ran_once(kvm) ||
> +	    (kvm->arch.pmu_filter && !kvm->arch.nr_composed_host_pmus))
> +		return -EBUSY;

I'm not sure there's much value in preventing the user from configuring
the PMU event filter. Even in the case of the fixed CPU cycle counter we
allow userspace to filter the event.

It is much more important to have mutual exclusion between this UAPI and
userspace explicitly selecting a PMU implementation.

> @@ -1223,6 +1328,8 @@ int kvm_arm_pmu_v3_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
>  
>  		return kvm_arm_pmu_v3_set_nr_counters(vcpu, n);
>  	}
> +	case KVM_ARM_VCPU_PMU_V3_COMPOSITION:
> +		return kvm_arm_pmu_v3_set_pmu_composition(vcpu);

I'd prefer naming this something like 'KVM_ARM_VCPU_PMU_V3_FIXED_COUNTERS_ONLY'.
We will have the fixed instruction counter eventually which is another
event we could potentially provide system-wide.

Thanks,
Oliver

