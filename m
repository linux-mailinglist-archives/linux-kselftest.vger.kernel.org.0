Return-Path: <linux-kselftest+bounces-34262-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E84BACCF8D
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 00:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F5C71896EDF
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 22:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EC324BC1A;
	Tue,  3 Jun 2025 22:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dk4b4e0r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B49624A069;
	Tue,  3 Jun 2025 22:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748988152; cv=none; b=bECD9NCuTnjVEyANcThgy6NTnJr+V5h0wsEHNCHGRlPgiQ5aeeJYU8VJ16YqpVA2kp1Ucz2T5H6LdHlAcg2qpexAeEw+WOABaXY6pE76MrAhSVEWyt+AJDRBg1yrcRo85nHJaGjvMJ2Zr/NxQKn1T4vnsmUJuP0ftknHMMw7pUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748988152; c=relaxed/simple;
	bh=5t6pSx2u95X5YcFVdkNUKGb9rqXxwfBLn0vDa4U2GyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCMgllK4TwQaXmiqHGDXud1cqckDeOKPp+phNyHIu8eq39qZR/SkAUDu8SXDOc3UijHrLoewL/E6OPDBztbF8yEHin8ni1h9twc74erTz7zx/P23GMBglRM4PNHC39GoLRVXI0KToREM2mZlRTC1OjYxgmruZIUwszdUQ568AdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dk4b4e0r; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 3 Jun 2025 15:02:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748988138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MYBLN18ggSpU1/ZnBt64YliW65vABIyi5xIBnaUOp24=;
	b=dk4b4e0rO/wW9aCyG+NXQO6YRkCVUwQVLI4dYbglDpsOngGTqtDeLAsdEzAtU+ic9J/Mvb
	/2ypH0EAxpXsVG6x9gO1djeyijHbtjQcP+aDQutvZ22djAlBhSfTubZLHVBjvyEHNpOhKt
	lxfK2PTtvCJu2SG/k6dddNR+CoTrIfY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, corbet@lwn.net,
	linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
	maz@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, mark.rutland@arm.com, shuah@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 06/17] KVM: arm64: Introduce method to partition the PMU
Message-ID: <aD9w3Kj4-YoizKv5@linux.dev>
References: <aD4llDZwb_sC_Ptj@linux.dev>
 <gsnt4iww3406.fsf@coltonlewis-kvm.c.googlers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gsnt4iww3406.fsf@coltonlewis-kvm.c.googlers.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 03, 2025 at 09:32:41PM +0000, Colton Lewis wrote:
> Oliver Upton <oliver.upton@linux.dev> writes:
> 
> > On Mon, Jun 02, 2025 at 07:26:51PM +0000, Colton Lewis wrote:
> > >   static void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
> > >   {
> > > +	u8 hpmn = vcpu->kvm->arch.arm_pmu->hpmn;
> > > +
> > >   	preempt_disable();
> 
> > >   	/*
> > >   	 * This also clears MDCR_EL2_E2PB_MASK and MDCR_EL2_E2TB_MASK
> > >   	 * to disable guest access to the profiling and trace buffers
> > >   	 */
> > > -	vcpu->arch.mdcr_el2 = FIELD_PREP(MDCR_EL2_HPMN,
> > > -					 *host_data_ptr(nr_event_counters));
> > > -	vcpu->arch.mdcr_el2 |= (MDCR_EL2_TPM |
> > > +	vcpu->arch.mdcr_el2 = FIELD_PREP(MDCR_EL2_HPMN, hpmn);
> > > +	vcpu->arch.mdcr_el2 |= (MDCR_EL2_HPMD |
> > > +				MDCR_EL2_TPM |
> 
> > This isn't safe, as there's no guarantee that kvm_arch::arm_pmu is
> > pointing that the PMU for this CPU. KVM needs to derive HPMN from some
> > per-CPU state, not anything tied to the VM/vCPU.
> 
> I'm confused. Isn't this function preparing to run the vCPU on this
> CPU? Why would it be pointing at a different PMU?

Because arm64 is a silly ecosystem and system designers can glue
together heterogenous CPU implementations. The arm_pmu that KVM is
pointing at might only match a subset of CPUs, but vCPUs migrate at the
whim of the scheduler (and userspace).

> And HPMN is something that we only want set when running a vCPU, so
> there isn't any per-CPU state saying it should be anything but the
> default value (number of counters) outside that context.
> 
> Unless you just mean I should check the number of counters again and
> make sure HPMN is not an invalid value.

As you've implemented it the host cannot schedule events in the guest
range of counters regardless of context. You need to reconcile that
global limit with the desires of the VMM on how many counters it wants
presented to this particular guest.

> > > +/**
> > > + * kvm_pmu_partition() - Partition the PMU
> > > + * @pmu: Pointer to pmu being partitioned
> > > + * @host_counters: Number of host counters to reserve
> > > + *
> > > + * Partition the given PMU by taking a number of host counters to
> > > + * reserve and, if it is a valid reservation, recording the
> > > + * corresponding HPMN value in the hpmn field of the PMU and clearing
> > > + * the guest-reserved counters from the counter mask.
> > > + *
> > > + * Passing 0 for @host_counters has the effect of disabling
> > > partitioning.
> > > + *
> > > + * Return: 0 on success, -ERROR otherwise
> > > + */
> > > +int kvm_pmu_partition(struct arm_pmu *pmu, u8 host_counters)
> > > +{
> > > +	u8 nr_counters;
> > > +	u8 hpmn;
> > > +
> > > +	if (!kvm_pmu_reservation_is_valid(host_counters))
> > > +		return -EINVAL;
> > > +
> > > +	nr_counters = *host_data_ptr(nr_event_counters);
> > > +	hpmn = kvm_pmu_hpmn(host_counters);
> > > +
> > > +	if (hpmn < nr_counters) {
> > > +		pmu->hpmn = hpmn;
> > > +		/* Inform host driver of available counters */
> > > +		bitmap_clear(pmu->cntr_mask, 0, hpmn);
> > > +		bitmap_set(pmu->cntr_mask, hpmn, nr_counters);
> > > +		clear_bit(ARMV8_PMU_CYCLE_IDX, pmu->cntr_mask);
> > > +		if (pmuv3_has_icntr())
> > > +			clear_bit(ARMV8_PMU_INSTR_IDX, pmu->cntr_mask);
> > > +
> > > +		kvm_debug("Partitioned PMU with HPMN %u", hpmn);
> > > +	} else {
> > > +		pmu->hpmn = nr_counters;
> > > +		bitmap_set(pmu->cntr_mask, 0, nr_counters);
> > > +		set_bit(ARMV8_PMU_CYCLE_IDX, pmu->cntr_mask);
> > > +		if (pmuv3_has_icntr())
> > > +			set_bit(ARMV8_PMU_INSTR_IDX, pmu->cntr_mask);
> > > +
> > > +		kvm_debug("Unpartitioned PMU");
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> 
> > Hmm... Just in terms of code organization I'm not sure I like having KVM
> > twiddling with *host* support for PMUv3. Feels like the ARM PMU driver
> > should own partitioning and KVM just takes what it can get.
> 
> Okay. I can move the code.
> 
> > > @@ -239,6 +245,13 @@ void kvm_host_pmu_init(struct arm_pmu *pmu)
> > >   	if (!pmuv3_implemented(kvm_arm_pmu_get_pmuver_limit()))
> > >   		return;
> 
> > > +	if (reserved_host_counters) {
> > > +		if (kvm_pmu_partition_supported())
> > > +			WARN_ON(kvm_pmu_partition(pmu, reserved_host_counters));
> > > +		else
> > > +			kvm_err("PMU Partition is not supported");
> > > +	}
> > > +
> 
> > Hasn't the ARM PMU been registered with perf at this point? Surely the
> > driver wouldn't be very pleased with us ripping counters out from under
> > its feet.
> 
> AFAICT nothing in perf registration cares about the number of counters
> the PMU has. The PMUv3 driver tracks its own available counters through
> cntr_mask and I modify that during partition.
> 
> Since this is still initialization of the PMU, I don't believe anything
> has had a chance to use a counter yet that will be ripped away.

Given that kvm_pmu_partition() is called from an ioctl, it is entirely
possible that events have been scheduled prior to applying the
partition.

> Aesthetically It makes since to change this if I move the partitioning
> code to the PMUv3 driver, but I think it's inconsequential to the
> function.

There are two *very* distinct functions w.r.t. partitioning:

 1) Partitioning of a particular arm_pmu that says how many counters the
 host can use

 2) VMM intentions to present a subset of the KVM-owned counter
 partition to its guest

#1 is modifying *global* state, we really can't mess with that in the
context of a single VM...

Thanks,
Oliver

