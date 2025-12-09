Return-Path: <linux-kselftest+bounces-47340-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC26CB1343
	for <lists+linux-kselftest@lfdr.de>; Tue, 09 Dec 2025 22:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A39423021072
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 21:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1433831AA84;
	Tue,  9 Dec 2025 21:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGlIChha"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B91262FC1;
	Tue,  9 Dec 2025 21:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765315997; cv=none; b=KVBepehu3b+lPGUkGIz9GAkaIKHlMRlvI2ive367OBV7W3aG0oIbYDj7JvDo9Jk9JC9ckAuzovewUI2vFNxXbTLGYgOFSVAb2Ckpu6+LEiYhugIiojbRcocaX9pWprJe4YbJmoKlXCQi/kSVMmDIK2J5KCYP+z/o/8rR6TUnoZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765315997; c=relaxed/simple;
	bh=R4XLqEiA0vD1T8P/x1CLOvvVjQ1OFPgEicxsI8oUtNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBDDUE2d8Om7JdgBzPmF3Kl7ZJmXQNGIjdTUOy3Vj6EPbzLo5rZ4mcp33jGL7v5vxi36HY6ApRWa/NFuR1QRzXrr5aCc45qGne0DzBIXpddMIP8OIPXl3PIdsMYXKQroMP55x498fbasEsAMtM+27bW3UNMSXoHwvWMyQDI4Odk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGlIChha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A67C4CEF5;
	Tue,  9 Dec 2025 21:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765315997;
	bh=R4XLqEiA0vD1T8P/x1CLOvvVjQ1OFPgEicxsI8oUtNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jGlIChha6NScNNKQYw94fZP04zj9fVOLWIANzVeK6HQ3x0VbUQdOa0Ib5fB+DJF2s
	 cxwcCe5H4Mv1oyW4aSYpWjfb50fwdSraxI3WJAnX+qf5gSk03S0LaPJLrDcmYBVr7O
	 KDVVAmLGPKuiymaJmk8xJ9Gt6fFOYj0Pog3fbZ3p8IiA1f5EHJeLxtB+DP0ZW5+G+I
	 fSTM81svNXMKEThKTwuAav0JrKSpNDN5Hu6vBRq+upM2xrQc+pjAuoeWHEyQn3UJ2R
	 +AIE1eyuyLVqt+qrtEmRo34Fmprhrz2S/9AKPCfZa+G+SldhiQdiZ0ODZv3UU1IWdj
	 50GNSNzxnYOnw==
Date: Tue, 9 Dec 2025 13:33:16 -0800
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
Subject: Re: [PATCH v5 15/24] KVM: arm64: Setup MDCR_EL2 to handle a
 partitioned PMU
Message-ID: <aTiVnI5ewoEVRztD@kernel.org>
References: <20251209205121.1871534-1-coltonlewis@google.com>
 <20251209205121.1871534-16-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209205121.1871534-16-coltonlewis@google.com>

On Tue, Dec 09, 2025 at 08:51:12PM +0000, Colton Lewis wrote:
> Setup MDCR_EL2 to handle a partitioned PMU. That means calculate an
> appropriate value for HPMN instead of the default maximum setting the
> host allows (which implies no partition) so hardware enforces that a
> guest will only see the counters in the guest partition.
> 
> Setting HPMN to a non default value means the global enable bit for
> the host counters is now MDCR_EL2.HPME instead of the usual
> PMCR_EL0.E. Enable the HPME bit to allow the host to count guest
> events. Since HPME only has an effect when HPMN is set which we only
> do for the guest, it is correct to enable it unconditionally here.
> 
> Unset the TPM and TPMCR bits, which trap all PMU accesses, if
> FGT (fine grain trapping) is being used.
> 
> If available, set the filtering bits HPMD and HCCD to be extra sure
> nothing in the guest counts at EL2.
> 
> Signed-off-by: Colton Lewis <coltonlewis@google.com>
> ---
>  arch/arm64/include/asm/kvm_pmu.h | 11 ++++++
>  arch/arm64/kvm/debug.c           | 29 ++++++++++++--
>  arch/arm64/kvm/pmu-direct.c      | 65 ++++++++++++++++++++++++++++++++
>  3 files changed, 102 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_pmu.h b/arch/arm64/include/asm/kvm_pmu.h
> index 60b8a48cad456..8b634112eded2 100644
> --- a/arch/arm64/include/asm/kvm_pmu.h
> +++ b/arch/arm64/include/asm/kvm_pmu.h
> @@ -101,6 +101,9 @@ u64 kvm_pmu_guest_counter_mask(struct arm_pmu *pmu);
>  void kvm_pmu_host_counters_enable(void);
>  void kvm_pmu_host_counters_disable(void);
>  
> +u8 kvm_pmu_guest_num_counters(struct kvm_vcpu *vcpu);
> +u8 kvm_pmu_hpmn(struct kvm_vcpu *vcpu);
> +
>  #if !defined(__KVM_NVHE_HYPERVISOR__)
>  bool kvm_vcpu_pmu_is_partitioned(struct kvm_vcpu *vcpu);
>  bool kvm_vcpu_pmu_use_fgt(struct kvm_vcpu *vcpu);
> @@ -173,6 +176,14 @@ static inline u64 kvm_pmu_fgt2_bits(void)
>  {
>  	return 0;
>  }
> +static inline u8 kvm_pmu_guest_num_counters(struct kvm_vcpu *vcpu)
> +{
> +	return 0;
> +}
> +static inline u8 kvm_pmu_hpmn(struct kvm_vcpu *vcpu)
> +{
> +	return 0;
> +}
>  static inline void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu,
>  					     u64 select_idx, u64 val) {}
>  static inline void kvm_pmu_set_counter_value_user(struct kvm_vcpu *vcpu,
> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
> index 3ad6b7c6e4ba7..0ab89c91e19cb 100644
> --- a/arch/arm64/kvm/debug.c
> +++ b/arch/arm64/kvm/debug.c
> @@ -36,20 +36,43 @@ static int cpu_has_spe(u64 dfr0)
>   */
>  static void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
>  {
> +	int hpmn = kvm_pmu_hpmn(vcpu);
> +
>  	preempt_disable();
>  
>  	/*
>  	 * This also clears MDCR_EL2_E2PB_MASK and MDCR_EL2_E2TB_MASK
>  	 * to disable guest access to the profiling and trace buffers
>  	 */
> -	vcpu->arch.mdcr_el2 = FIELD_PREP(MDCR_EL2_HPMN,
> -					 *host_data_ptr(nr_event_counters));
> +
> +	vcpu->arch.mdcr_el2 = FIELD_PREP(MDCR_EL2_HPMN, hpmn);
>  	vcpu->arch.mdcr_el2 |= (MDCR_EL2_TPM |
>  				MDCR_EL2_TPMS |
>  				MDCR_EL2_TTRF |
>  				MDCR_EL2_TPMCR |
>  				MDCR_EL2_TDRA |
> -				MDCR_EL2_TDOSA);
> +				MDCR_EL2_TDOSA |
> +				MDCR_EL2_HPME);
> +
> +	if (kvm_vcpu_pmu_is_partitioned(vcpu)) {
> +		/*
> +		 * Filtering these should be redundant because we trap
> +		 * all the TYPER and FILTR registers anyway and ensure
> +		 * they filter EL2, but set the bits if they are here.
> +		 */
> +		if (is_pmuv3p1(read_pmuver()))
> +			vcpu->arch.mdcr_el2 |= MDCR_EL2_HPMD;
> +		if (is_pmuv3p5(read_pmuver()))
> +			vcpu->arch.mdcr_el2 |= MDCR_EL2_HCCD;
> +
> +		/*
> +		 * Take out the coarse grain traps if we are using
> +		 * fine grain traps.
> +		 */
> +		if (kvm_vcpu_pmu_use_fgt(vcpu))
> +			vcpu->arch.mdcr_el2 &= ~(MDCR_EL2_TPM | MDCR_EL2_TPMCR);
> +
> +	}
>  
>  	/* Is the VM being debugged by userspace? */
>  	if (vcpu->guest_debug)
> diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
> index 4dd160c878862..7fb4fb5c22e2a 100644
> --- a/arch/arm64/kvm/pmu-direct.c
> +++ b/arch/arm64/kvm/pmu-direct.c
> @@ -154,3 +154,68 @@ void kvm_pmu_host_counters_disable(void)
>  	mdcr &= ~MDCR_EL2_HPME;
>  	write_sysreg(mdcr, mdcr_el2);
>  }

<snip>

> +/**
> + * kvm_pmu_guest_num_counters() - Number of counters to show to guest
> + * @vcpu: Pointer to struct kvm_vcpu
> + *
> + * Calculate the number of counters to show to the guest via
> + * PMCR_EL0.N, making sure to respect the maximum the host allows,
> + * which is hpmn_max if partitioned and host_max otherwise.
> + *
> + * Return: Valid value for PMCR_EL0.N
> + */
> +u8 kvm_pmu_guest_num_counters(struct kvm_vcpu *vcpu)
> +{
> +	u8 nr_cnt = vcpu->kvm->arch.nr_pmu_counters;
> +	int hpmn_max = armv8pmu_hpmn_max;
> +	u8 host_max = *host_data_ptr(nr_event_counters);
> +
> +	if (vcpu->kvm->arch.arm_pmu)
> +		hpmn_max = vcpu->kvm->arch.arm_pmu->hpmn_max;
> +
> +	if (kvm_vcpu_pmu_is_partitioned(vcpu)) {
> +		if (nr_cnt <= hpmn_max && nr_cnt <= host_max)
> +			return nr_cnt;
> +		if (hpmn_max <= host_max)
> +			return hpmn_max;
> +	}
> +
> +	if (nr_cnt <= host_max)
> +		return nr_cnt;
> +
> +	return host_max;
> +}
> +
> +/**
> + * kvm_pmu_hpmn() - Calculate HPMN field value
> + * @vcpu: Pointer to struct kvm_vcpu
> + *
> + * Calculate the appropriate value to set for MDCR_EL2.HPMN. If
> + * partitioned, this is the number of counters set for the guest if
> + * supported, falling back to hpmn_max if needed. If we are not
> + * partitioned or can't set the implied HPMN value, fall back to the
> + * host value.
> + *
> + * Return: A valid HPMN value
> + */
> +u8 kvm_pmu_hpmn(struct kvm_vcpu *vcpu)
> +{
> +	u8 nr_guest_cnt = kvm_pmu_guest_num_counters(vcpu);
> +	int nr_guest_cnt_max = armv8pmu_hpmn_max;
> +	u8 nr_host_cnt_max = *host_data_ptr(nr_event_counters);
> +
> +	if (vcpu->kvm->arch.arm_pmu)
> +		nr_guest_cnt_max = vcpu->kvm->arch.arm_pmu->hpmn_max;
> +
> +	if (kvm_vcpu_pmu_is_partitioned(vcpu)) {
> +		if (cpus_have_final_cap(ARM64_HAS_HPMN0))
> +			return nr_guest_cnt;
> +		else if (nr_guest_cnt > 0)
> +			return nr_guest_cnt;
> +		else if (nr_guest_cnt_max > 0)
> +			return nr_guest_cnt_max;
> +	}
> +
> +	return nr_host_cnt_max;
> +}

</snip>

I find all of this rather confusing. It seems like you're dealing with
sanitizing kvm->arch.nr_pmu_counters vs. the underlying implementation.
I'm not sure why you need to do that, I would expect that we reject
unsupported values at the time of the ioctl.

The only thing you do need to handle is if the vCPU has migrated to an
"unsupported" CPU, for which we already have supporting helpers. I'm too
lazy to fetch the Arm ARM and cite architecture but I'm pretty sure an
out-of-range HPMN has UNPREDICTABLE behavior.

I think you just need to move the vcpu_set_unsupported_cpu() call earlier in
kvm_arch_vcpu_load().

Taking all that into consideration:

u8 kvm_mdcr_hpmn(struct kvm_vcpu *vcpu)
{
	u8 nr_counters = *host_data_ptr(nr_event_counters);

	if (!kvm_vcpu_pmu_is_partitioned(vcpu) || vcpu_on_unsupported_cpu(vcpu))
		return nr_counters;

	return vcpu->kvm->arch.nr_pmu_counters;
}

Thanks,
Oliver

