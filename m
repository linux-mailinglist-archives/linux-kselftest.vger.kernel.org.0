Return-Path: <linux-kselftest+bounces-47342-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD20CB140F
	for <lists+linux-kselftest@lfdr.de>; Tue, 09 Dec 2025 22:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18AE13009553
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 21:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF532DF153;
	Tue,  9 Dec 2025 21:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuFFE37H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ECD283FE6;
	Tue,  9 Dec 2025 21:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765317361; cv=none; b=JdZPRaXxHeg9BH3+atBM56WIuZ1N61ujgsTCPYZ7vvJFujMGz9Zqhxc6t0kwLsA2A0upEeR98qph25Z/XWC+FB8i4NfFTcN3k/pn/sv2Nef+C8JB54LHiis4LyIwZwCvAMt51AFNV1frWT91aql45ZK6Y7o5C7ACRwwyXL89cHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765317361; c=relaxed/simple;
	bh=YWdg18cjyZlaQzsCfCOFgUy7Fvj4xZJkrt8yESfMLOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbACcS5VJordECXKvbC16QiCPyRdso4DtBdlCNPybQgLno/uxe9H8x8pab//aG4kf0vi1Y9xw1fmjfV6LJtKyHU4nspMH0RrlJpCaqC8fpA/8fGRGJQoGVALkLg8j4cSTB6J6zcBnCvMRSzYWUQUmdbIEKX+PiOYQFUFinsJDOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuFFE37H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F660C4CEF5;
	Tue,  9 Dec 2025 21:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765317360;
	bh=YWdg18cjyZlaQzsCfCOFgUy7Fvj4xZJkrt8yESfMLOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZuFFE37H9sfww/rNV+snhfh4JmK/7dF1PrqhKsKmfprhpKmSUuWmK+vqt3vTGUbZp
	 yVQBwmoZ6Qt4oz5/SDsze5y9RfpYvXIHOZ2H3iv1BpUSvAZkAEY5ZjCsyxvd6tHHEV
	 3pHZWHvz32XelRvYnWPct9Yr1YhvVGblc9mjM7cV7HpkVgDQi3b2saQhOB7m/lTT/u
	 um+QK9IV6GwXfroEsB55yXddyo666Q+lBhg0NGm4EJS7384iBOY2/zedhqB8+9m8Vf
	 r7EqUwXlDaeoT1TerxaJeL0HkJBDVYsbGKf8SpWgLD8w9yiG0hqBkK4kZz/shq7avc
	 fFy4eg8BDIrSQ==
Date: Tue, 9 Dec 2025 13:55:59 -0800
From: Oliver Upton <oupton@kernel.org>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>,
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 17/24] KVM: arm64: Context swap Partitioned PMU guest
 registers
Message-ID: <aTia74R74upcsMEA@kernel.org>
References: <20251209205121.1871534-1-coltonlewis@google.com>
 <20251209205121.1871534-18-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209205121.1871534-18-coltonlewis@google.com>

On Tue, Dec 09, 2025 at 08:51:14PM +0000, Colton Lewis wrote:
> +/**
> + * kvm_pmu_load() - Load untrapped PMU registers
> + * @vcpu: Pointer to struct kvm_vcpu
> + *
> + * Load all untrapped PMU registers from the VCPU into the PCPU. Mask
> + * to only bits belonging to guest-reserved counters and leave
> + * host-reserved counters alone in bitmask registers.
> + */
> +void kvm_pmu_load(struct kvm_vcpu *vcpu)
> +{
> +	struct arm_pmu *pmu;
> +	u64 mask;
> +	u8 i;
> +	u64 val;
> +

Assert that preemption is disabled.

> +	/*
> +	 * If we aren't using FGT then we are trapping everything
> +	 * anyway, so no need to bother with the swap.
> +	 */
> +	if (!kvm_vcpu_pmu_use_fgt(vcpu))
> +		return;

Uhh... Then how do events count in this case?

The absence of FEAT_FGT shouldn't affect the residence of the guest PMU
context. We just need to handle the extra traps, ideally by reading the
PMU registers directly as a fast path exit handler.

> +	pmu = vcpu->kvm->arch.arm_pmu;
> +
> +	for (i = 0; i < pmu->hpmn_max; i++) {
> +		val = __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i);
> +		write_pmevcntrn(i, val);
> +	}
> +
> +	val = __vcpu_sys_reg(vcpu, PMCCNTR_EL0);
> +	write_pmccntr(val);
> +
> +	val = __vcpu_sys_reg(vcpu, PMUSERENR_EL0);
> +	write_pmuserenr(val);

What about the host's value for PMUSERENR?

> +	val = __vcpu_sys_reg(vcpu, PMSELR_EL0);
> +	write_pmselr(val);

PMSELR_EL0 needs to be switched late, e.g. at sysreg_restore_guest_state_vhe().
Even though the host doesn't currently use the selector-based accessor,
I'd prefer we not load things that'd affect the host context until we're
about to enter the guest.

> +	/* Save only the stateful writable bits. */
> +	val = __vcpu_sys_reg(vcpu, PMCR_EL0);
> +	mask = ARMV8_PMU_PMCR_MASK &
> +		~(ARMV8_PMU_PMCR_P | ARMV8_PMU_PMCR_C);
> +	write_pmcr(val & mask);
> +
> +	/*
> +	 * When handling these:
> +	 * 1. Apply only the bits for guest counters (indicated by mask)
> +	 * 2. Use the different registers for set and clear
> +	 */
> +	mask = kvm_pmu_guest_counter_mask(pmu);
> +
> +	val = __vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
> +	write_pmcntenset(val & mask);
> +	write_pmcntenclr(~val & mask);
> +
> +	val = __vcpu_sys_reg(vcpu, PMINTENSET_EL1);
> +	write_pmintenset(val & mask);
> +	write_pmintenclr(~val & mask);

Is this safe? What happens if we put the PMU into an overflow condition?

> +}
> +
> +/**
> + * kvm_pmu_put() - Put untrapped PMU registers
> + * @vcpu: Pointer to struct kvm_vcpu
> + *
> + * Put all untrapped PMU registers from the VCPU into the PCPU. Mask
> + * to only bits belonging to guest-reserved counters and leave
> + * host-reserved counters alone in bitmask registers.
> + */
> +void kvm_pmu_put(struct kvm_vcpu *vcpu)
> +{
> +	struct arm_pmu *pmu;
> +	u64 mask;
> +	u8 i;
> +	u64 val;
> +
> +	/*
> +	 * If we aren't using FGT then we are trapping everything
> +	 * anyway, so no need to bother with the swap.
> +	 */
> +	if (!kvm_vcpu_pmu_use_fgt(vcpu))
> +		return;
> +
> +	pmu = vcpu->kvm->arch.arm_pmu;
> +
> +	for (i = 0; i < pmu->hpmn_max; i++) {
> +		val = read_pmevcntrn(i);
> +		__vcpu_assign_sys_reg(vcpu, PMEVCNTR0_EL0 + i, val);
> +	}
> +
> +	val = read_pmccntr();
> +	__vcpu_assign_sys_reg(vcpu, PMCCNTR_EL0, val);
> +
> +	val = read_pmuserenr();
> +	__vcpu_assign_sys_reg(vcpu, PMUSERENR_EL0, val);
> +
> +	val = read_pmselr();
> +	__vcpu_assign_sys_reg(vcpu, PMSELR_EL0, val);
> +
> +	val = read_pmcr();
> +	__vcpu_assign_sys_reg(vcpu, PMCR_EL0, val);
> +
> +	/* Mask these to only save the guest relevant bits. */
> +	mask = kvm_pmu_guest_counter_mask(pmu);
> +
> +	val = read_pmcntenset();
> +	__vcpu_assign_sys_reg(vcpu, PMCNTENSET_EL0, val & mask);
> +
> +	val = read_pmintenset();
> +	__vcpu_assign_sys_reg(vcpu, PMINTENSET_EL1, val & mask);

What if the PMU is in an overflow state at this point?

Thanks,
Oliver

