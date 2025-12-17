Return-Path: <linux-kselftest+bounces-47677-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC5DCC9C32
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 00:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35C9D30378AC
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 23:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30CE3128A0;
	Wed, 17 Dec 2025 23:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rIPrPCAK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f73.google.com (mail-ot1-f73.google.com [209.85.210.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3514826FA5A
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Dec 2025 23:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766012625; cv=none; b=WFkzULesogZF9aFJQDZ63oDAQr9lVkvNIvU5Rzb9gwRr5Tyw+EB+6iQxLEUfTdrRjjSc60SKdCjOkNVmVaycfWdtZCCDpL24mmHkVLTvuJBiKUSv1Ksdhc/Hicj3ogyDmCnXWVsDotz1ArAkqnv6G6Jqca9EohjQmEhra5N7GK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766012625; c=relaxed/simple;
	bh=GcH2YU9svXn1lwAwNWQlWL84mdn4ZPEmHup1iY+NLn4=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=lrWp/wAohbOwJ9RHAzXzuzFRqKEu4KPIuKwSlmW3O57aJyjFOJHbBdtuLi/ozD+NFxxmEa5psysizsH0oZTC2funwPLX/XqOmXe67jjRwhDaEHraODAUhFvvefOrNxM7VDZu3z2wBorl7AY1njCISA2ngtr5x+IR36kcmegX0X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rIPrPCAK; arc=none smtp.client-ip=209.85.210.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-ot1-f73.google.com with SMTP id 46e09a7af769-7caf66b2866so10181346a34.3
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Dec 2025 15:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766012622; x=1766617422; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aRTGpXalCpTw9EJ3jwwqmWQTyjHYa0HLkPGjExiFjCQ=;
        b=rIPrPCAKLA8TVt8dJxvDb+V4hecsW6IZV/IKE1B7Wyao84NDPJag6rll8HfyFWh72T
         QQ7q1kA1ZgcGll/QN81Eb1F/X3ZzdXDd6StpuJEiv4w/GmbYGvWMS0WvBZ0XCgeWae43
         cstm9EcONBmeCEQtQ3uLgmE8qEzjvnE3TPT4rC7d62x/HIFdzzXsjeeT6KeawWNJYmlc
         Guywernkj//1zm54qgEN0bn/sOUNOsBXLbQHG7H13AsEYJonMTIXH3r+kb8rfVMtYj7q
         N9TxMrwAtpR7GU13YA12cZ3/Fh/BttjHwuYmQ8pD/KD8zJcWMSXgp4wnWZKCMEKa+fAU
         zwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766012622; x=1766617422;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aRTGpXalCpTw9EJ3jwwqmWQTyjHYa0HLkPGjExiFjCQ=;
        b=t5F9JV1TgoZuAjzqQmp51HXaZMm7OAKzgjy1H11B7DHJE675sRG1Ds5ZQSQ3VnuLKp
         E9hBlqf7Iy73Vkpt5Zap9g9u8tLCnWbkRuxfAm5vNvM8vuKN0GdlByGHpfZfWNOzhVeK
         l9mW0FUBJJR3fnDwdc9fDX8fgeUujLZKtQYWZhPgAVCPJ7k366vM8CLxit3kB64qr9RJ
         6vYSemHdd9EYQL0n5aMLIx80EavNtlOtVdqvo9Z3R2Qeb81L0IcF7XAUPrWPdCSJSRqv
         63n2uAVYBLv+L2I9nzKo3T2qGb7B8DA1nRZS1OcBwPh8abnlE/2O9AYRoQ5Pl1RQXJ59
         CnCg==
X-Forwarded-Encrypted: i=1; AJvYcCVAz4Sa8K4Zf3tFy/2Kqq7PrCBp6wvXOvKo8UlfHj5j1Te7VXGT6v0DvCtZE0Q37Y8StJgrTW3EJasjW/CHguY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUHtXSBxlxdvrFEHbJKJPvy22gghMn5T+qqX+ESiINx4Kr/ZCn
	KkokQ5X32m7WBb1NBfZHiDD88mhw3LSeb/xTK3ia6xpUOBXSXPQf0zdvL2D/59v8oy21Vd6vb8w
	uV2ndR+MiiAlkacB5raRb+AZTeQ==
X-Google-Smtp-Source: AGHT+IFQs5k1bWdHtz7tc4/8DEUyRxbCe8MSuSfyN2BvguDIeAIIerMywbvjRsitUO6G8RkTOEE+yjjKcwPQBwUtTA==
X-Received: from jaii7.prod.google.com ([2002:a05:6638:4007:b0:5c6:3249:f8ff])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:2915:b0:659:9a49:8fb7 with SMTP id 006d021491bc7-65b452574dfmr8508202eaf.48.1766012622152;
 Wed, 17 Dec 2025 15:03:42 -0800 (PST)
Date: Wed, 17 Dec 2025 23:03:41 +0000
In-Reply-To: <aUH7oC41XaEMsXf_@kernel.org> (message from Oliver Upton on Tue,
 16 Dec 2025 16:38:56 -0800)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsnt34583e42.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v5 14/24] KVM: arm64: Write fast path PMU register handlers
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

> On Tue, Dec 09, 2025 at 08:51:11PM +0000, Colton Lewis wrote:
>> diff --git a/arch/arm64/include/asm/arm_pmuv3.h  
>> b/arch/arm64/include/asm/arm_pmuv3.h
>> index 3e25c0313263c..41ec6730ebc62 100644
>> --- a/arch/arm64/include/asm/arm_pmuv3.h
>> +++ b/arch/arm64/include/asm/arm_pmuv3.h
>> @@ -39,6 +39,16 @@ static inline unsigned long read_pmevtypern(int n)
>>   	return 0;
>>   }

>> +static inline void write_pmxevcntr(u64 val)
>> +{
>> +	write_sysreg(val, pmxevcntr_el0);
>> +}
>> +
>> +static inline u64 read_pmxevcntr(void)
>> +{
>> +	return read_sysreg(pmxevcntr_el0);
>> +}
>> +
>>   static inline unsigned long read_pmmir(void)
>>   {
>>   	return read_cpuid(PMMIR_EL1);
>> @@ -105,21 +115,41 @@ static inline void write_pmcntenset(u64 val)
>>   	write_sysreg(val, pmcntenset_el0);
>>   }

>> +static inline u64 read_pmcntenset(void)
>> +{
>> +	return read_sysreg(pmcntenset_el0);
>> +}
>> +
>>   static inline void write_pmcntenclr(u64 val)
>>   {
>>   	write_sysreg(val, pmcntenclr_el0);
>>   }

>> +static inline u64 read_pmcntenclr(void)
>> +{
>> +	return read_sysreg(pmcntenclr_el0);
>> +}
>> +
>>   static inline void write_pmintenset(u64 val)
>>   {
>>   	write_sysreg(val, pmintenset_el1);
>>   }

>> +static inline u64 read_pmintenset(void)
>> +{
>> +	return read_sysreg(pmintenset_el1);
>> +}
>> +
>>   static inline void write_pmintenclr(u64 val)
>>   {
>>   	write_sysreg(val, pmintenclr_el1);
>>   }

>> +static inline u64 read_pmintenclr(void)
>> +{
>> +	return read_sysreg(pmintenclr_el1);
>> +}
>> +
>>   static inline void write_pmccfiltr(u64 val)
>>   {
>>   	write_sysreg(val, pmccfiltr_el0);
>> @@ -160,11 +190,16 @@ static inline u64 read_pmovsclr(void)
>>   	return read_sysreg(pmovsclr_el0);
>>   }

>> -static inline void write_pmuserenr(u32 val)
>> +static inline void write_pmuserenr(u64 val)
>>   {
>>   	write_sysreg(val, pmuserenr_el0);
>>   }

>> +static inline u64 read_pmuserenr(void)
>> +{
>> +	return read_sysreg(pmuserenr_el0);
>> +}
>> +
>>   static inline void write_pmuacr(u64 val)
>>   {
>>   	write_sysreg_s(val, SYS_PMUACR_EL1);

> I wouldn't bother with adding accessors to the PMUv3 driver header, this
> gets a bit confusing when the 32-bit counterpart lacks matching  
> definitions.
> Additionally, the part of KVM you're modifying is very much an
> "internal" part meant to run in a not-quite-kernel context.

> Considering this, I'd prefer KVM directly accessed the PMU registers to
> avoid the possibility of taking some instrumented codepath in the
> future.

Will do.

>> +	if (!kvm_vcpu_pmu_is_partitioned(vcpu)
>> +	    || pmu_access_el0_disabled(vcpu))

> Always put operators on the preceding line for line continuations.

> Also, don't call pmu_access_el0_disabled() from here. It can potentially
> do a full emulated exception entry even though the vCPU is in an
> extremely inconsistent state (i.e. haven't returned to kernel context
> yet). Isn't the current value for PMUSERENR_EL0 on the CPU instead of in
> the vCPU's saved context anyway?

> The fast-path accessors really need to be *just* accessors, reading
> state from the CPU in the unfortunate situation that a TPM trap has been
> forced upon us.

Understood.

>> +	case SYS_PMXEVCNTR_EL0:
>> +		idx = FIELD_GET(PMSELR_EL0_SEL, read_pmselr());
>> +
>> +		if (pmu_access_event_counter_el0_disabled(vcpu))
>> +			return false;
>> +
>> +		if (!pmu_counter_idx_valid(vcpu, idx))
>> +			return false;
>> +
>> +		ret = handle_pmu_reg(vcpu, &p, PMEVCNTR0_EL0 + idx, rt, val,
>> +				     &read_pmxevcntr, &write_pmxevcntr);
>> +		break;

> It is a bit odd to handle the muxing for finding the in-memory value yet
> using the selector-based register for hardware.

Agreed

>> +	case SYS_PMEVCNTRn_EL0(0) ... SYS_PMEVCNTRn_EL0(30):
>> +		idx = ((p.CRm & 3) << 3) | (p.Op2 & 7);
>> +
>> +		if (pmu_access_event_counter_el0_disabled(vcpu))
>> +			return false;
>> +
>> +		if (!pmu_counter_idx_valid(vcpu, idx))
>> +			return false;
>> +
>> +		if (p.is_write) {
>> +			write_pmevcntrn(idx, val);
>> +			__vcpu_assign_sys_reg(vcpu, PMEVCNTR0_EL0 + idx, val);
>> +		} else {
>> +			vcpu_set_reg(vcpu, rt, read_pmevcntrn(idx));
>> +		}
>> +
>> +		ret = true;
>> +		break;

> Can't both of these cases share a helper once you've worked out the
> index? Same for PMEVTYPERn_EL0.

Agreed

>> +	default:
>> +		ret = false;
>> +	}
>> +
>> +	if (ret)
>> +		__kvm_skip_instr(vcpu);
>> +
>> +	return ret;
>> +}
>> +
>>   static inline bool kvm_hyp_handle_sysreg(struct kvm_vcpu *vcpu, u64  
>> *exit_code)
>>   {
>>   	if (cpus_have_final_cap(ARM64_WORKAROUND_CAVIUM_TX2_219_TVM) &&
>> @@ -785,6 +983,9 @@ static inline bool kvm_hyp_handle_sysreg(struct  
>> kvm_vcpu *vcpu, u64 *exit_code)
>>   	if (kvm_handle_cntxct(vcpu))
>>   		return true;

>> +	if (kvm_hyp_handle_pmu_regs(vcpu))
>> +		return true;
>> +

> Since the whole partitioned PMU feature is constrained to VHE-only you
> should call this from kvm_hyp_handle_sysreg_vhe().

Will do.

>> +
>> +bool check_pmu_access_disabled(struct kvm_vcpu *vcpu, u64 flags)
>> +{
>> +	u64 reg = __vcpu_sys_reg(vcpu, PMUSERENR_EL0);
>> +	bool enabled = (reg & flags) || vcpu_mode_priv(vcpu);
>> +
>> +	if (!enabled)
>> +		kvm_inject_undefined(vcpu);
>> +
>> +	return !enabled;
>> +}
>> +
>> +bool pmu_access_el0_disabled(struct kvm_vcpu *vcpu)
>> +{
>> +	return check_pmu_access_disabled(vcpu, ARMV8_PMU_USERENR_EN);
>> +}
>> +
>> +bool pmu_counter_idx_valid(struct kvm_vcpu *vcpu, u64 idx)
>> +{
>> +	u64 pmcr, val;
>> +
>> +	pmcr = kvm_vcpu_read_pmcr(vcpu);
>> +	val = FIELD_GET(ARMV8_PMU_PMCR_N, pmcr);
>> +	if (idx >= val && idx != ARMV8_PMU_CYCLE_IDX) {
>> +		kvm_inject_undefined(vcpu);
>> +		return false;
>> +	}
>> +
>> +	return true;
>> +}
>> +
>> +bool pmu_access_cycle_counter_el0_disabled(struct kvm_vcpu *vcpu)
>> +{
>> +	return check_pmu_access_disabled(vcpu, ARMV8_PMU_USERENR_CR |  
>> ARMV8_PMU_USERENR_EN);
>> +}
>> +
>> +bool pmu_access_event_counter_el0_disabled(struct kvm_vcpu *vcpu)
>> +{
>> +	return check_pmu_access_disabled(vcpu, ARMV8_PMU_USERENR_ER |  
>> ARMV8_PMU_USERENR_EN);
>> +}

> Refactorings need to happen in a separate patch.

Will do

> Thanks,
> Oliver

