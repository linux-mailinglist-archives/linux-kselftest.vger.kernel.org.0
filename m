Return-Path: <linux-kselftest+bounces-47533-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AA6CB9E15
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 22:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F28D030B3A0B
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 21:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CBF30E837;
	Fri, 12 Dec 2025 21:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MW2HlbUh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C882BE625
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 21:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765574548; cv=none; b=r5nctHK9ow6+0iQTHpcaQVqUfRGyMvk92SjJSEwutNXKlg0MLR1EAQzkIX/cChUrViqknMMaz1ZqwxBZb2UEJM34MTTweUrhEiKla0h+RKwvImqFi5TUVUn6Cyi5OGA8iVQyBd+RdbbC1x5YNwG3fP4rSkA0oOLEcu/eIKH1PII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765574548; c=relaxed/simple;
	bh=zUcTgO8xFxXTIs2xi2maKe3MVihox+NtvOsRoMBmnbc=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=VOoshv1GSxXBPsKFORDPq5IfJGuYzXeRIpBOhE+/5Z6lScSlLjqZdKkwFtIsfcyhs9e58hU81hfGDRcjvo3BA+T1YtcPcVtI1GigqvgywKvZI90TnYPIx1YSSP56RgG+uPlRfk4uphL5whuGnouRvEUGqiYkhq9eq7L/2bgYCbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MW2HlbUh; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-65b3208d4deso2457233eaf.1
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 13:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765574544; x=1766179344; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TDikX7MxydgpkEhVgiFec0tbYtt4zp46Bk2PRaWMaw0=;
        b=MW2HlbUhOD7SlhnGYeQqsyjKWNjRs1JTUy3Rajh8ot/0qyCr6Gb8najsiX3y3JAwiN
         22hzC+8C94q8j/ekLsaBY7GO4frsEPI1fjWphsJKi8VK1Nd1CF0XZp8rvzQQv0Zy6ETy
         ePiDLGRX5iTjUefHA3KxsQInMje5hq7IfVM9/fX173MR7K5w3FfYA/ByScf47Sz2aima
         lKXwSpAqfgYI1/yPAPcm9wf0xnY/8Arl/wALbwR6JazfznD2NGJ5stssqsKNRwYTcaMh
         NCSDm3UtHDRE7udBgAF7Qhmleptjot6h6keG4XMsbJp/8XcW+T/deoH0oTiozDuGNKY+
         9JnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765574544; x=1766179344;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TDikX7MxydgpkEhVgiFec0tbYtt4zp46Bk2PRaWMaw0=;
        b=HMtQ6hf/Np7prxBeLPMW5vApsWOITEBfkbBmgSArRcH4H1Mt5kbI+ioHKhLO3Hh7lf
         50N+MJ6pHQkmFp2rvAc0Q22/UPfyUYO5bOmszWOwTOp+XY9C6x4SwnWgv8JZ1Fvc74d4
         EN/0nKqrN5t0x6XOMLXeNnQt+Opa2qR+ZPMhBJJ9/kuW0FX+pmTo1lRDNtoxwVblmsCO
         Y1bqwBH7U62vDuXWtwprpQAg1i930SkzKeJ0tE2rvyNrFhCB0jEpykNDnW/e869cbrKG
         Or/bVrGw4uexNGRivTjZKDLb48GFH1d1g20AYl4BzVJIswxxgRHaex605uRFziYl75um
         1g8A==
X-Forwarded-Encrypted: i=1; AJvYcCXuc7gJL7x8BPISik48m1WyP0mF8I4YRg1TU33SswhhmntNRj1I8sN6hC/L2xyc2WriDTud8NEzH//PlVXCJ6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoL3CCCwDqDPJ3d1wUc9KzN3eWwG1ieqRlIgxIHdKWZy1+OyAH
	RSfwZtOt+wp7NO78DryQsATblRV20XtgaIg35R9o0FxZVCG5DRA3xmQnmcGYE9aJxP91dw9BdHi
	hAhLJDP4IUZEEQikh35gSenV6IA==
X-Google-Smtp-Source: AGHT+IFacNltyMpQaFsNK7rlABry0i4u7xBCuikCMLsDPxZN/lK6t81XIofzqcYLqh4pqGUQWt5vQ9Tbd4atv0DZBg==
X-Received: from jabbm9.prod.google.com ([2002:a05:6638:42c9:b0:5b7:27fd:4260])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:16a4:b0:657:6fdd:9875 with SMTP id 006d021491bc7-65b455bc09emr1840088eaf.5.1765574544449;
 Fri, 12 Dec 2025 13:22:24 -0800 (PST)
Date: Fri, 12 Dec 2025 21:22:23 +0000
In-Reply-To: <aTiVnI5ewoEVRztD@kernel.org> (message from Oliver Upton on Tue,
 9 Dec 2025 13:33:16 -0800)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntpl8j2y5s.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v5 15/24] KVM: arm64: Setup MDCR_EL2 to handle a
 partitioned PMU
From: Colton Lewis <coltonlewis@google.com>
To: Oliver Upton <oupton@kernel.org>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	maz@kernel.org, oliver.upton@linux.dev, mizhang@google.com, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	mark.rutland@arm.com, shuah@kernel.org, gankulkarni@os.amperecomputing.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Oliver Upton <oupton@kernel.org> writes:

> On Tue, Dec 09, 2025 at 08:51:12PM +0000, Colton Lewis wrote:
>> Setup MDCR_EL2 to handle a partitioned PMU. That means calculate an
>> appropriate value for HPMN instead of the default maximum setting the
>> host allows (which implies no partition) so hardware enforces that a
>> guest will only see the counters in the guest partition.

>> Setting HPMN to a non default value means the global enable bit for
>> the host counters is now MDCR_EL2.HPME instead of the usual
>> PMCR_EL0.E. Enable the HPME bit to allow the host to count guest
>> events. Since HPME only has an effect when HPMN is set which we only
>> do for the guest, it is correct to enable it unconditionally here.

>> Unset the TPM and TPMCR bits, which trap all PMU accesses, if
>> FGT (fine grain trapping) is being used.

>> If available, set the filtering bits HPMD and HCCD to be extra sure
>> nothing in the guest counts at EL2.

>> Signed-off-by: Colton Lewis <coltonlewis@google.com>
>> ---
>>   arch/arm64/include/asm/kvm_pmu.h | 11 ++++++
>>   arch/arm64/kvm/debug.c           | 29 ++++++++++++--
>>   arch/arm64/kvm/pmu-direct.c      | 65 ++++++++++++++++++++++++++++++++
>>   3 files changed, 102 insertions(+), 3 deletions(-)

>> diff --git a/arch/arm64/include/asm/kvm_pmu.h  
>> b/arch/arm64/include/asm/kvm_pmu.h
>> index 60b8a48cad456..8b634112eded2 100644
>> --- a/arch/arm64/include/asm/kvm_pmu.h
>> +++ b/arch/arm64/include/asm/kvm_pmu.h
>> @@ -101,6 +101,9 @@ u64 kvm_pmu_guest_counter_mask(struct arm_pmu *pmu);
>>   void kvm_pmu_host_counters_enable(void);
>>   void kvm_pmu_host_counters_disable(void);

>> +u8 kvm_pmu_guest_num_counters(struct kvm_vcpu *vcpu);
>> +u8 kvm_pmu_hpmn(struct kvm_vcpu *vcpu);
>> +
>>   #if !defined(__KVM_NVHE_HYPERVISOR__)
>>   bool kvm_vcpu_pmu_is_partitioned(struct kvm_vcpu *vcpu);
>>   bool kvm_vcpu_pmu_use_fgt(struct kvm_vcpu *vcpu);
>> @@ -173,6 +176,14 @@ static inline u64 kvm_pmu_fgt2_bits(void)
>>   {
>>   	return 0;
>>   }
>> +static inline u8 kvm_pmu_guest_num_counters(struct kvm_vcpu *vcpu)
>> +{
>> +	return 0;
>> +}
>> +static inline u8 kvm_pmu_hpmn(struct kvm_vcpu *vcpu)
>> +{
>> +	return 0;
>> +}
>>   static inline void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu,
>>   					     u64 select_idx, u64 val) {}
>>   static inline void kvm_pmu_set_counter_value_user(struct kvm_vcpu *vcpu,
>> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
>> index 3ad6b7c6e4ba7..0ab89c91e19cb 100644
>> --- a/arch/arm64/kvm/debug.c
>> +++ b/arch/arm64/kvm/debug.c
>> @@ -36,20 +36,43 @@ static int cpu_has_spe(u64 dfr0)
>>    */
>>   static void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
>>   {
>> +	int hpmn = kvm_pmu_hpmn(vcpu);
>> +
>>   	preempt_disable();

>>   	/*
>>   	 * This also clears MDCR_EL2_E2PB_MASK and MDCR_EL2_E2TB_MASK
>>   	 * to disable guest access to the profiling and trace buffers
>>   	 */
>> -	vcpu->arch.mdcr_el2 = FIELD_PREP(MDCR_EL2_HPMN,
>> -					 *host_data_ptr(nr_event_counters));
>> +
>> +	vcpu->arch.mdcr_el2 = FIELD_PREP(MDCR_EL2_HPMN, hpmn);
>>   	vcpu->arch.mdcr_el2 |= (MDCR_EL2_TPM |
>>   				MDCR_EL2_TPMS |
>>   				MDCR_EL2_TTRF |
>>   				MDCR_EL2_TPMCR |
>>   				MDCR_EL2_TDRA |
>> -				MDCR_EL2_TDOSA);
>> +				MDCR_EL2_TDOSA |
>> +				MDCR_EL2_HPME);
>> +
>> +	if (kvm_vcpu_pmu_is_partitioned(vcpu)) {
>> +		/*
>> +		 * Filtering these should be redundant because we trap
>> +		 * all the TYPER and FILTR registers anyway and ensure
>> +		 * they filter EL2, but set the bits if they are here.
>> +		 */
>> +		if (is_pmuv3p1(read_pmuver()))
>> +			vcpu->arch.mdcr_el2 |= MDCR_EL2_HPMD;
>> +		if (is_pmuv3p5(read_pmuver()))
>> +			vcpu->arch.mdcr_el2 |= MDCR_EL2_HCCD;
>> +
>> +		/*
>> +		 * Take out the coarse grain traps if we are using
>> +		 * fine grain traps.
>> +		 */
>> +		if (kvm_vcpu_pmu_use_fgt(vcpu))
>> +			vcpu->arch.mdcr_el2 &= ~(MDCR_EL2_TPM | MDCR_EL2_TPMCR);
>> +
>> +	}

>>   	/* Is the VM being debugged by userspace? */
>>   	if (vcpu->guest_debug)
>> diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
>> index 4dd160c878862..7fb4fb5c22e2a 100644
>> --- a/arch/arm64/kvm/pmu-direct.c
>> +++ b/arch/arm64/kvm/pmu-direct.c
>> @@ -154,3 +154,68 @@ void kvm_pmu_host_counters_disable(void)
>>   	mdcr &= ~MDCR_EL2_HPME;
>>   	write_sysreg(mdcr, mdcr_el2);
>>   }

> <snip>

>> +/**
>> + * kvm_pmu_guest_num_counters() - Number of counters to show to guest
>> + * @vcpu: Pointer to struct kvm_vcpu
>> + *
>> + * Calculate the number of counters to show to the guest via
>> + * PMCR_EL0.N, making sure to respect the maximum the host allows,
>> + * which is hpmn_max if partitioned and host_max otherwise.
>> + *
>> + * Return: Valid value for PMCR_EL0.N
>> + */
>> +u8 kvm_pmu_guest_num_counters(struct kvm_vcpu *vcpu)
>> +{
>> +	u8 nr_cnt = vcpu->kvm->arch.nr_pmu_counters;
>> +	int hpmn_max = armv8pmu_hpmn_max;
>> +	u8 host_max = *host_data_ptr(nr_event_counters);
>> +
>> +	if (vcpu->kvm->arch.arm_pmu)
>> +		hpmn_max = vcpu->kvm->arch.arm_pmu->hpmn_max;
>> +
>> +	if (kvm_vcpu_pmu_is_partitioned(vcpu)) {
>> +		if (nr_cnt <= hpmn_max && nr_cnt <= host_max)
>> +			return nr_cnt;
>> +		if (hpmn_max <= host_max)
>> +			return hpmn_max;
>> +	}
>> +
>> +	if (nr_cnt <= host_max)
>> +		return nr_cnt;
>> +
>> +	return host_max;
>> +}
>> +
>> +/**
>> + * kvm_pmu_hpmn() - Calculate HPMN field value
>> + * @vcpu: Pointer to struct kvm_vcpu
>> + *
>> + * Calculate the appropriate value to set for MDCR_EL2.HPMN. If
>> + * partitioned, this is the number of counters set for the guest if
>> + * supported, falling back to hpmn_max if needed. If we are not
>> + * partitioned or can't set the implied HPMN value, fall back to the
>> + * host value.
>> + *
>> + * Return: A valid HPMN value
>> + */
>> +u8 kvm_pmu_hpmn(struct kvm_vcpu *vcpu)
>> +{
>> +	u8 nr_guest_cnt = kvm_pmu_guest_num_counters(vcpu);
>> +	int nr_guest_cnt_max = armv8pmu_hpmn_max;
>> +	u8 nr_host_cnt_max = *host_data_ptr(nr_event_counters);
>> +
>> +	if (vcpu->kvm->arch.arm_pmu)
>> +		nr_guest_cnt_max = vcpu->kvm->arch.arm_pmu->hpmn_max;
>> +
>> +	if (kvm_vcpu_pmu_is_partitioned(vcpu)) {
>> +		if (cpus_have_final_cap(ARM64_HAS_HPMN0))
>> +			return nr_guest_cnt;
>> +		else if (nr_guest_cnt > 0)
>> +			return nr_guest_cnt;
>> +		else if (nr_guest_cnt_max > 0)
>> +			return nr_guest_cnt_max;
>> +	}
>> +
>> +	return nr_host_cnt_max;
>> +}

> </snip>

> I find all of this rather confusing. It seems like you're dealing with
> sanitizing kvm->arch.nr_pmu_counters vs. the underlying implementation.
> I'm not sure why you need to do that, I would expect that we reject
> unsupported values at the time of the ioctl.

I agree it makes more sense to do the validating at the ioctl. I'll do that.

> The only thing you do need to handle is if the vCPU has migrated to an
> "unsupported" CPU, for which we already have supporting helpers. I'm too
> lazy to fetch the Arm ARM and cite architecture but I'm pretty sure an
> out-of-range HPMN has UNPREDICTABLE behavior.

It does.

> I think you just need to move the vcpu_set_unsupported_cpu() call earlier  
> in
> kvm_arch_vcpu_load().

> Taking all that into consideration:

> u8 kvm_mdcr_hpmn(struct kvm_vcpu *vcpu)
> {
> 	u8 nr_counters = *host_data_ptr(nr_event_counters);

> 	if (!kvm_vcpu_pmu_is_partitioned(vcpu) || vcpu_on_unsupported_cpu(vcpu))
> 		return nr_counters;

> 	return vcpu->kvm->arch.nr_pmu_counters;
> }

Something like that will probably work. But I also need to account for
if arch.nr_pmu_counters is 0 and we don't have HPMN0, which is also
unpredictable. I don't think I can reject that at the ioctl because we
still want to support that case. Is there any way to handle that through
vcpu_on_unsupported_cpu()?

> Thanks,
> Oliver

