Return-Path: <linux-kselftest+bounces-34335-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EB0ACE59C
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 22:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01A8D3A3006
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 20:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B70722759B;
	Wed,  4 Jun 2025 20:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y6eXqrp6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72331224B05
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Jun 2025 20:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749067831; cv=none; b=DWs2anGj3IpyzUSNehzG6yg1dgR9iV6R34CppPVdhR8RVFEN21jPhsnYsgFHJheLsjrB9rHE8z20oppDeaXOsZzIboj/44O7YNFQf12ElaQKocRo6Co+/nPGeTtzqOsscS54qBccDgE8oViMaadHJPb2HAZspCnRHAzkT4oGxGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749067831; c=relaxed/simple;
	bh=EU4BduYV5ySU8iGFm6pmTUebG9iN4J4Jbh/y+qckhzE=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Gn5E6pSpGyvQaUbl0Ll7uBSR3W+VSpIJ5HYiGQVSONiVfqfcMb5RMs+xk8SHdFT9jMEWmeKCK0vaAEtDgVChu91tpQIUJqFRgF0ysuVHLkTmb6UTc/zmEx6c3QdfnMalUvtQOCg5LD2dfxA/zqdx+YaF2GDor/bTOXumZ0zlmQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y6eXqrp6; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-86d126265baso27777739f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Jun 2025 13:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749067828; x=1749672628; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e/kzWc0kpD6KViH3+1QPaMZ6x27hYFTDLDJNvBdlpRQ=;
        b=y6eXqrp6/gYtUXCr05z6wLTtqFJdt7Gj8i6CiKJL7UerF6nAtqmC5C36rOYPWvcTRD
         nWqxUh1OaRhn2V/xGXK8guJfDbBvPMH/tqBc4/7nStUM/MOV46lvxHcj1d7S78f5EY2M
         e2tqFQOeEKBQRoqV6o9XcEk6kjiwpFUw3A+Ws929AkMP75mBrQ7tP20ef+NIWTVcBTJL
         4nZXf2e2TE9ok2eY0zSiq+mUzlkwYrh5ovfvPQgkBJsHHfL2b93KGQrOaLp/qpxnKKbc
         h4Ro3nUpAkIRKMjyRCvsbuZaLvcpt+eZu5zIrdMLWkerlc5DyPk41HiXnj2GZ9lGlx6b
         E9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749067828; x=1749672628;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e/kzWc0kpD6KViH3+1QPaMZ6x27hYFTDLDJNvBdlpRQ=;
        b=JusjF0gHSee3juFpLGrGRVyuKYQ8pif+idj+WiTTCdqGGlbSwKk8lXpB3D+Vxvt3Lp
         kEuOj3soSFdch6kcHF2yxF6QZP/ZJiIgOz6MZ0aWNO5iT6AJ+5+KRxKN22H4KNyJ5y/4
         c1qvBT10RN4K0AxeK7eOvzxggdvaBWDIWp3Aj9/hAwBKQa+gCIOTkuYu61Mmynw0DXX4
         gEV5IkGTBtayaN4uRU44pVv8Ejy4ukkQYQHZu7BwAkJSalt9zNOoemaue0rtL6TAih+I
         so/xlfF0G7J+FwubB7zEBzCoVmaNJVRLaZiXlDTYFD99ZiW7EeIvmOl8DcbDld61qIHu
         44wg==
X-Forwarded-Encrypted: i=1; AJvYcCXMJFih0mtPSrTxdZRvUg3/DfpAtWwhAmL0AmQz1L1tKzwIIPYJs+6KVudiZYgILYeT/ctveMmNnFwEC8qep1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWZ+J8MUDJ/oBvvp5rvMSeqmwwWe4LfTZx5Dybl4E2ubU1LPtA
	frVP9cHR5TFmB96U7KLsrZ+mMin6le/jID0YJNeQOVvBXZUTu5hcncKCU1IZlrkSDwk+PnPsWyG
	8PxvyWVMSWXRpk9DnEwTg6jjjGQ==
X-Google-Smtp-Source: AGHT+IFh/8mtqkpalqzk1KUKOx68qwJSaQ1z3VwlY5VIPWzy5mNTtLH8FEcMZxZh9pPP2vJyzvJ8dNTJRze1hcsbYw==
X-Received: from ilbbf2.prod.google.com ([2002:a05:6e02:3082:b0:3dd:a279:72c1])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:250d:b0:3dc:79e5:e6b7 with SMTP id e9e14a558f8ab-3ddbedb49ccmr48769095ab.20.1749067828362;
 Wed, 04 Jun 2025 13:10:28 -0700 (PDT)
Date: Wed, 04 Jun 2025 20:10:27 +0000
In-Reply-To: <aD9w3Kj4-YoizKv5@linux.dev> (message from Oliver Upton on Tue, 3
 Jun 2025 15:02:04 -0700)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntsekf1d58.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH 06/17] KVM: arm64: Introduce method to partition the PMU
From: Colton Lewis <coltonlewis@google.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	maz@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, mark.rutland@arm.com, shuah@kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Thank you Oliver for the additional explanation.

Oliver Upton <oliver.upton@linux.dev> writes:

> On Tue, Jun 03, 2025 at 09:32:41PM +0000, Colton Lewis wrote:
>> Oliver Upton <oliver.upton@linux.dev> writes:

>> > On Mon, Jun 02, 2025 at 07:26:51PM +0000, Colton Lewis wrote:
>> > >   static void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
>> > >   {
>> > > +	u8 hpmn = vcpu->kvm->arch.arm_pmu->hpmn;
>> > > +
>> > >   	preempt_disable();

>> > >   	/*
>> > >   	 * This also clears MDCR_EL2_E2PB_MASK and MDCR_EL2_E2TB_MASK
>> > >   	 * to disable guest access to the profiling and trace buffers
>> > >   	 */
>> > > -	vcpu->arch.mdcr_el2 = FIELD_PREP(MDCR_EL2_HPMN,
>> > > -					 *host_data_ptr(nr_event_counters));
>> > > -	vcpu->arch.mdcr_el2 |= (MDCR_EL2_TPM |
>> > > +	vcpu->arch.mdcr_el2 = FIELD_PREP(MDCR_EL2_HPMN, hpmn);
>> > > +	vcpu->arch.mdcr_el2 |= (MDCR_EL2_HPMD |
>> > > +				MDCR_EL2_TPM |

>> > This isn't safe, as there's no guarantee that kvm_arch::arm_pmu is
>> > pointing that the PMU for this CPU. KVM needs to derive HPMN from some
>> > per-CPU state, not anything tied to the VM/vCPU.

>> I'm confused. Isn't this function preparing to run the vCPU on this
>> CPU? Why would it be pointing at a different PMU?

> Because arm64 is a silly ecosystem and system designers can glue
> together heterogenous CPU implementations. The arm_pmu that KVM is
> pointing at might only match a subset of CPUs, but vCPUs migrate at the
> whim of the scheduler (and userspace).

That means the arm_pmu field might at any time point to data that
doesn't represent the current CPU. I'm surprised that's not swapped out
anywhere. Seems like it would be useful to have an arch struct be a
reliable source of information about the current arch.

>> And HPMN is something that we only want set when running a vCPU, so
>> there isn't any per-CPU state saying it should be anything but the
>> default value (number of counters) outside that context.

>> Unless you just mean I should check the number of counters again and
>> make sure HPMN is not an invalid value.

> As you've implemented it the host cannot schedule events in the guest
> range of counters regardless of context. You need to reconcile that
> global limit with the desires of the VMM on how many counters it wants
> presented to this particular guest.

It's true that's the current implementation. I was assuming the VMM
would control that with the new partition API. Given that partitioning
untraps access to counters, there is no other way besides HPMN to
control how many counters are exposed to the guest.

>> > > +/**
>> > > + * kvm_pmu_partition() - Partition the PMU
>> > > + * @pmu: Pointer to pmu being partitioned
>> > > + * @host_counters: Number of host counters to reserve
>> > > + *
>> > > + * Partition the given PMU by taking a number of host counters to
>> > > + * reserve and, if it is a valid reservation, recording the
>> > > + * corresponding HPMN value in the hpmn field of the PMU and  
>> clearing
>> > > + * the guest-reserved counters from the counter mask.
>> > > + *
>> > > + * Passing 0 for @host_counters has the effect of disabling
>> > > partitioning.
>> > > + *
>> > > + * Return: 0 on success, -ERROR otherwise
>> > > + */
>> > > +int kvm_pmu_partition(struct arm_pmu *pmu, u8 host_counters)
>> > > +{
>> > > +	u8 nr_counters;
>> > > +	u8 hpmn;
>> > > +
>> > > +	if (!kvm_pmu_reservation_is_valid(host_counters))
>> > > +		return -EINVAL;
>> > > +
>> > > +	nr_counters = *host_data_ptr(nr_event_counters);
>> > > +	hpmn = kvm_pmu_hpmn(host_counters);
>> > > +
>> > > +	if (hpmn < nr_counters) {
>> > > +		pmu->hpmn = hpmn;
>> > > +		/* Inform host driver of available counters */
>> > > +		bitmap_clear(pmu->cntr_mask, 0, hpmn);
>> > > +		bitmap_set(pmu->cntr_mask, hpmn, nr_counters);
>> > > +		clear_bit(ARMV8_PMU_CYCLE_IDX, pmu->cntr_mask);
>> > > +		if (pmuv3_has_icntr())
>> > > +			clear_bit(ARMV8_PMU_INSTR_IDX, pmu->cntr_mask);
>> > > +
>> > > +		kvm_debug("Partitioned PMU with HPMN %u", hpmn);
>> > > +	} else {
>> > > +		pmu->hpmn = nr_counters;
>> > > +		bitmap_set(pmu->cntr_mask, 0, nr_counters);
>> > > +		set_bit(ARMV8_PMU_CYCLE_IDX, pmu->cntr_mask);
>> > > +		if (pmuv3_has_icntr())
>> > > +			set_bit(ARMV8_PMU_INSTR_IDX, pmu->cntr_mask);
>> > > +
>> > > +		kvm_debug("Unpartitioned PMU");
>> > > +	}
>> > > +
>> > > +	return 0;
>> > > +}

>> > Hmm... Just in terms of code organization I'm not sure I like having  
>> KVM
>> > twiddling with *host* support for PMUv3. Feels like the ARM PMU driver
>> > should own partitioning and KVM just takes what it can get.

>> Okay. I can move the code.

>> > > @@ -239,6 +245,13 @@ void kvm_host_pmu_init(struct arm_pmu *pmu)
>> > >   	if (!pmuv3_implemented(kvm_arm_pmu_get_pmuver_limit()))
>> > >   		return;

>> > > +	if (reserved_host_counters) {
>> > > +		if (kvm_pmu_partition_supported())
>> > > +			WARN_ON(kvm_pmu_partition(pmu, reserved_host_counters));
>> > > +		else
>> > > +			kvm_err("PMU Partition is not supported");
>> > > +	}
>> > > +

>> > Hasn't the ARM PMU been registered with perf at this point? Surely the
>> > driver wouldn't be very pleased with us ripping counters out from under
>> > its feet.

>> AFAICT nothing in perf registration cares about the number of counters
>> the PMU has. The PMUv3 driver tracks its own available counters through
>> cntr_mask and I modify that during partition.

>> Since this is still initialization of the PMU, I don't believe anything
>> has had a chance to use a counter yet that will be ripped away.

> Given that kvm_pmu_partition() is called from an ioctl, it is entirely
> possible that events have been scheduled prior to applying the
> partition.

That's true for the ioctl call. I was only saying it's not true here.

>> Aesthetically It makes since to change this if I move the partitioning
>> code to the PMUv3 driver, but I think it's inconsequential to the
>> function.

> There are two *very* distinct functions w.r.t. partitioning:

>   1) Partitioning of a particular arm_pmu that says how many counters the
>   host can use

>   2) VMM intentions to present a subset of the KVM-owned counter
>   partition to its guest

> #1 is modifying *global* state, we really can't mess with that in the
> context of a single VM...

I see the distinction more clearly now. Since KVM can only control the
number of counters presented to the guest through HPMN, why would the
VMM ever choose a subset? If the host PMU is globally partitioned to not
use anything in the guest range, presenting fewer counters to a guest is
just leaving some counters in the middle of the range unused.


> Thanks,
> Oliver

