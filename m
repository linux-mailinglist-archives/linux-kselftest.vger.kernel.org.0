Return-Path: <linux-kselftest+bounces-38426-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E046B1D0D0
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 04:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C34D7ADBD1
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 02:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC4E188907;
	Thu,  7 Aug 2025 02:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qg86bz33"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B96145B3E
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Aug 2025 02:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754532236; cv=none; b=MPRlOXxHnjLRqQ+t5zk305/pYcvHZwyQ0SgRz5eGmaJp+/wX584rQxpiBTXdC4APDkVx7OmwXIZApqt/IEw2uSMinhaSoOMfq3fwMWRWV+OhDSmuJGR2EC1etWwHNSUm2kldh0+gmuL3c7FlTpDv+Bm+3byerApXCAHRslbBKYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754532236; c=relaxed/simple;
	bh=hqmcfReuijwtnpNcJRsSkCHLXblH9O/rigatjdEuRlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGxgxmnrbBJEe0zB1csUxaycI+0Gg2deQ1kf5Q2z2R6YdVKdXyy3KkCClzadQ+2AQm+YNhXtw8lQ6QPXAlAQ8LuEwdzoq9D/swddeKLFK6eD/R5epHsKE7yge9CrA6jVLN5cY60cfQfVT5CEklTtnaNVnVwvhp48V9h2hrjAHUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qg86bz33; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 6 Aug 2025 19:03:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754532222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m4lFUwBUTBASs8+w6RWnaE1vMNcqXEPtsns4iFPW3QQ=;
	b=Qg86bz33wt/39A/xZzIW0ZTd1srRiZPD+rB+zqoTKG4gFhl3WRsh3Owk58E9KtF176Vpfj
	05pY2mo1wxaAb79x+wFf8f2yL2E96FW2bZ4GODk0yLPFhGuQvFjdfgoSq/csplV1rYXk22
	sFeqpRT2AYHBtFw9a98PEruMPqQMaDc=
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
Message-ID: <aJQJdElbZJ6KzQxD@linux.dev>
References: <20250806-hybrid-v2-0-0661aec3af8c@rsg.ci.i.u-tokyo.ac.jp>
 <20250806-hybrid-v2-1-0661aec3af8c@rsg.ci.i.u-tokyo.ac.jp>
 <aJOO99xUrhsrvLwl@linux.dev>
 <276fdfb8-f1ca-44ad-b310-a811684b265a@rsg.ci.i.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <276fdfb8-f1ca-44ad-b310-a811684b265a@rsg.ci.i.u-tokyo.ac.jp>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 07, 2025 at 03:24:43AM +0900, Akihiko Odaki wrote:
> On 2025/08/07 2:20, Oliver Upton wrote:
> > Hi Akihiko,
> > 
> > This is an unreasonably large patch that needs to be broken down into
> > smaller patches, ideally one functional change per patch. We need this
> > even for an RFC for the sake of reviews.
> > 
> > On Wed, Aug 06, 2025 at 06:09:54PM +0900, Akihiko Odaki wrote:
> > > +static u64 kvm_pmu_get_pmc_value(struct kvm_vcpu *vcpu, u8 idx)
> > >   {
> > > -	struct kvm_vcpu *vcpu = kvm_pmc_to_vcpu(pmc);
> > > +	struct kvm_pmc *pmc = *kvm_vcpu_idx_to_pmc(vcpu, idx);
> > >   	u64 counter, reg, enabled, running;
> > > +	unsigned int i;
> > > -	reg = counter_index_to_reg(pmc->idx);
> > > +	reg = counter_index_to_reg(idx);
> > >   	counter = __vcpu_sys_reg(vcpu, reg);
> > >   	/*
> > >   	 * The real counter value is equal to the value of counter register plus
> > >   	 * the value perf event counts.
> > >   	 */
> > > -	if (pmc->perf_event)
> > > -		counter += perf_event_read_value(pmc->perf_event, &enabled,
> > > -						 &running);
> > > +	if (pmc)
> > > +		for (i = 0; i < pmc->nr_perf_events; i++)
> > > +			counter += perf_event_read_value(pmc->perf_events[i],
> > > +							 &enabled, &running);
> > 
> > I'm concerned that this array of events concept you're introducing is
> > going to be error-prone. An approach that reallocates a new PMU event in
> > the case of a vCPU migrating to a new PMU implementation would be
> > desirable.
> 
> I avoided allocation at migration because I was worried with disabled
> preemption. perf_event_create_kernel_counter() internally takes a mutex so
> it cannot be used if preemption is disabled.
> 
> I wonder if it is guaranteed that kvm_arch_vcpu_load() executes with
> preemption. If so, I can add a hook there to call
> perf_event_create_kernel_counter().

You don't need to allocate the event at vcpu_load(). The only guarantee
we need is that an event has been attached to the PMC prior to entering
the guest, for which the KVM_REQ_* infrastructure is quite useful.

> > 
> > > +static void reset_sample_period(struct perf_event *perf_event)
> > > +{
> > > +	struct kvm_pmc **pmc = perf_event->overflow_handler_context;
> > > +	struct kvm_vcpu *vcpu = kvm_pmc_to_vcpu(pmc);
> > > +	struct arm_pmu *cpu_pmu = to_arm_pmu(perf_event->pmu);
> > > +	u64 period;
> > > +
> > > +	cpu_pmu->pmu.stop(perf_event, PERF_EF_UPDATE);
> > > +
> > > +	/*
> > > +	 * Reset the sample period to the architectural limit,
> > > +	 * i.e. the point where the counter overflows.
> > > +	 */
> > > +	period = compute_period(pmc, kvm_pmu_get_pmc_value(vcpu, (*pmc)->idx));
> > > +
> > > +	local64_set(&perf_event->hw.period_left, 0);
> > > +	perf_event->attr.sample_period = period;
> > > +	perf_event->hw.sample_period = period;
> > > +
> > > +	cpu_pmu->pmu.start(perf_event, PERF_EF_RELOAD);
> > > +}
> > 
> > No, we can't start calling into the internal driver interfaces. The fact
> > that we have a pointer to the PMU is an ugly hack and shouldn't be used
> > like this.
> 
> This function was extracted from kvm_pmu_perf_overflow() and is not a new
> addition (which should have been clear if I would have split the patch as
> you noted).

Yuck, then forgive my whining.

> I thought of replacing it with perf_event_period(), but there is a catch: it
> returns -EINVAL if the 63th bit of the sample period number is set. Perhaps
> we can just specify ((1ULL << 63) - 1) if the sample period is going to be
> so long, but I conservatively avoided that. I can change it if you prefer
> that way or have an alternative idea.

Let's keep it as-is then. Sorry about the noise.

> > Can we just special-case the fixed CPU cycle counter to use
> > PERF_TYPE_HARDWARE / PERF_COUNT_HW_CPU_CYCLES? That _should_ have the
> > intended effect of opening an event on the PMU for this CPU.
> 
> I have an impression that perhaps this emulation can be more generic by
> converting eventsel to PERF_COUNT_HW_* numbers with armv8_pmuv3_perf_map in
> drivers/perf/arm_pmuv3.c, but it is not in scope of this change. The current
> code is sufficient for now.

The only cross-PMU events we will support are the fixed counters, my
strong preference is that we do not reverse-map architectural events to
generic perf events for all counters.

> > I'm not sure there's much value in preventing the user from configuring
> > the PMU event filter. Even in the case of the fixed CPU cycle counter we
> > allow userspace to filter the event.
> 
> It is possible to configure the PMU event filter, but it needs to be done
> after setting the attribute. This behavior is aligned with
> KVM_ARM_VCPU_PMU_V3_SET_PMU.

That's fine then, I missed that detail.

> They are mutually exclusive and the latest configuration takes effect.
> 
> If you set SET_PMU after COMPOSITION, SET_PMU will take effect.
> If you set COMPOSITION after SET_PMU, COMPOSITION will take effect.
> 
> I'll note that in the documentation.

This isn't what I meant. What I mean is that userspace either can use
the SET_PMU ioctl or the COMPOSITION ioctl. Once one of them has been
used the other ioctl returns an error.

We're really bad at getting ioctl ordering / interleaving right and
syzkaller has a habit of finding these mistakes. There's zero practical
value in using both of these ioctls on the same VM, let's prevent it.

> > > +	case KVM_ARM_VCPU_PMU_V3_COMPOSITION:
> > > +		return kvm_arm_pmu_v3_set_pmu_composition(vcpu);
> > 
> > I'd prefer naming this something like 'KVM_ARM_VCPU_PMU_V3_FIXED_COUNTERS_ONLY'.
> > We will have the fixed instruction counter eventually which is another
> > event we could potentially provide system-wide.
> 
> The design decision to expose the cycle counter is driven by the motivation
> to satisfy FEAT_PMU for the guest rather than the host capability.
> 
> When we implement FEAT_PMUv3_ICNTR in the future, I think we will need to
> add KVM_ARM_VCPU_PMU_V3_COMPOSITION_ICNTR or something. The resultig
> emulated PMU will work only on host CPUs that have instruction counters; a
> host CPU may lack one because it doesn't implement FEAT_PMUv3_ICNTR or has a
> third-party PMU like apple-m1-cpu-pmu (this particular PMU has an
> instruction counter fortunately).

No, this is at odds with the way we handle CPU features in KVM/arm64.

Ignoring this ioctl, the goal is that after KVM_ARM_VCPU_INIT the vCPU
is initialized to the maximum possible feature set. If userspace wants
to de-feature the VM it can do so by modifying the ID registers.

OTOH, your ioctl is dealing with something structural in how we
support PMUs on the system. It should be defined as exposing all fixed
counters that we support on a given piece of hardware. On systems
without FEAT_PMUv3_ICNTR, the result should be a vPMU that only has the
CPU cycle counter.

On a system that has FEAT_PMUv3_ICNTR, userspace can still use this
ioctl and explicitly de-feature ICNTR by writing to the ID register
after initialization.

Thanks,
Oliver

