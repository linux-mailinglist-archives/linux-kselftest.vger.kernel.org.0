Return-Path: <linux-kselftest+bounces-6973-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A18D894D9C
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 10:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC799B22A87
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 08:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0605E56444;
	Tue,  2 Apr 2024 08:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="NJHJMI9W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090893E479
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Apr 2024 08:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712046797; cv=none; b=oTGLJ7oVOALZ7W4QyFGbkes4zAWRJNd8L7PeAkyO8WaqdGw63n8c/WAe8arlYjBMsugVOJJ3PbhaolTKgbBp67772sMpdeJYfiUtJR6IgcL/FbSJgpNOfEY4cj1Vpf4UODD4vHX7wIgsB7N2c5aViGaMUibx0hHW0DQ3o6e1kY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712046797; c=relaxed/simple;
	bh=Fgj2wXUFAYuYZjGCKO305AwFEQMfc7MddyRpOUxobx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sh7IquxfPYgKeSU1Y9SGqnwzSvLRR3PLCNlXT1Haj4mM3M45tWEdSBhgTZXc0CFzfD8NQon+puB1q3NStljcxj1BRUrFj3qBo+7oUsMc9o4okbsRgzt3JcLBL/p9om9WTl35b8twRBdMHuxXTxlOa13VIrfUB2TBdU5P1u2yg4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=NJHJMI9W; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-29f93c4946cso3550661a91.1
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Apr 2024 01:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712046794; x=1712651594; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pF+GHx3jZMME3DYF+6wzP0Y1vgFK2YHi+oSZmNYz6ZQ=;
        b=NJHJMI9Wna5xe71MPwfdP5d/DEQV3uHvl99PovfMtXNq7qJ/IOH2peaU2ZezYCcGqv
         82P46HV4eKrR/siLGLx0UZ/zxG2w4xE1fi5U6/s59hyRihlOhhZFGriy85Y2zUh0nxIY
         6sdw9I2QKslOKVJ6tIlEKB5uZzbOqaonJlVta+STTC2n/LcLdOpSmBC0UH8xnS9XYDZM
         jidR+wQ6p1bE0X5jvybjo92nXi0XgirKgee+Y0W4HN/olXDKPrAHq1u0dQUKX98nX+Ax
         D35e2nJ79KiOZrvTRdBJdEmw4DkCqNCEdfKFgIWLkSU+EVST+djIloEoUe/JF+kM1ZZ8
         NCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712046794; x=1712651594;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pF+GHx3jZMME3DYF+6wzP0Y1vgFK2YHi+oSZmNYz6ZQ=;
        b=S8fkVz4H0X7kXW9DvaLZvtCuR4wEwaOO2DLuMLssWbtnMxYzFWp0M6LYf5v1rBe4Ac
         427rCsgmTBJa0qjeoHIMxIME2E9cipIkWgTlnrzD06eCTmEmuOeOBqje8QGMQt0zp4sI
         XcknHXWgz0MSqAtdbzxRVNnd9sPSwfnvrz9Qf6ZOG8qy8FHZUtQl7obEPwBAWGD0dkkE
         /77U0AytzqbBpyZ86SsNfLr1jYUpiv/VRLw1HlWs7VV16wNeb6IxyyyMwOrpM8vzxRQt
         DELcdRagVN63ZdKzPdNLViXpTsy1aJxStCDaIK4JYM2zAyBe1BCpto3zpQ25ACvjrlgJ
         lVog==
X-Forwarded-Encrypted: i=1; AJvYcCWf+kiOMTqqNAgVuswLGL2/6Uqw/5+eMefE61zwkaWz4/kbvoxhJBrZvBGAW5rMuG7FNln/KLFlBn/snSHjpEhNE0vUMxBZG1/nADJjKhDg
X-Gm-Message-State: AOJu0YxmC5CqzwgzwVSHlGDhlBZOBN88A6VA85x8wrDHEbtP+OB8sj97
	D1XlqxCCEIBA9ROK3jmbhPK02dmDoCUX/9O50qsRTFA5xeia1vFNva6TEdsVtEw=
X-Google-Smtp-Source: AGHT+IHoS/kVI8LDmc+k7J58OiQUcdmlPsMU+9PQEBztMhOWy4QzOXWEgZ3jKigZq8lGFBWZL3DQ/Q==
X-Received: by 2002:a17:90b:33cd:b0:29b:bbef:912f with SMTP id lk13-20020a17090b33cd00b0029bbbef912fmr9360161pjb.10.1712046794124;
        Tue, 02 Apr 2024 01:33:14 -0700 (PDT)
Received: from [172.16.0.34] (c-67-188-2-18.hsd1.ca.comcast.net. [67.188.2.18])
        by smtp.gmail.com with ESMTPSA id g14-20020a17090a67ce00b0029ffba4bf0esm9052919pjm.19.2024.04.02.01.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 01:33:13 -0700 (PDT)
Message-ID: <c46c57c2-95bc-4289-ac99-efd5bad093b5@rivosinc.com>
Date: Tue, 2 Apr 2024 01:33:10 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/15] RISC-V: KVM: Add perf sampling support for
 guests
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Atish Patra <atishp@atishpatra.org>,
 Conor Dooley <conor.dooley@microchip.com>, Guo Ren <guoren@kernel.org>,
 Icenowy Zheng <uwu@icenowy.me>, kvm-riscv@lists.infradead.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-riscv@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>,
 Will Deacon <will@kernel.org>
References: <20240229010130.1380926-1-atishp@rivosinc.com>
 <20240229010130.1380926-10-atishp@rivosinc.com>
 <20240302-f9732d962e5f7c7760059f2e@orel>
From: Atish Patra <atishp@rivosinc.com>
In-Reply-To: <20240302-f9732d962e5f7c7760059f2e@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/2/24 02:33, Andrew Jones wrote:
> On Wed, Feb 28, 2024 at 05:01:24PM -0800, Atish Patra wrote:
>> KVM enables perf for guest via counter virtualization. However, the
>> sampling can not be supported as there is no mechanism to enabled
>> trap/emulate scountovf in ISA yet. Rely on the SBI PMU snapshot
>> to provide the counter overflow data via the shared memory.
>>
>> In case of sampling event, the host first guest the LCOFI interrupt
>         
> s/guest the LCOFI/sets the guest's LCOFI/
> 
>> and injects to the guest via irq filtering mechanism defined in AIA
>> specification. Thus, ssaia must be enabled in the host in order to
>> use perf sampling in the guest. No other AIA dpeendancy w.r.t kernel
> 
> dependency
> 

Fixed both.

>> is required.
>>
>> Reviewed-by: Anup Patel <anup@brainfault.org>
>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
>> ---
>>   arch/riscv/include/asm/csr.h          |  3 +-
>>   arch/riscv/include/asm/kvm_vcpu_pmu.h |  3 ++
>>   arch/riscv/include/uapi/asm/kvm.h     |  1 +
>>   arch/riscv/kvm/aia.c                  |  5 ++
>>   arch/riscv/kvm/vcpu.c                 | 14 ++++--
>>   arch/riscv/kvm/vcpu_onereg.c          |  9 +++-
>>   arch/riscv/kvm/vcpu_pmu.c             | 72 ++++++++++++++++++++++++---
>>   7 files changed, 96 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
>> index 603e5a3c61f9..c0de2fd6c564 100644
>> --- a/arch/riscv/include/asm/csr.h
>> +++ b/arch/riscv/include/asm/csr.h
>> @@ -168,7 +168,8 @@
>>   #define VSIP_TO_HVIP_SHIFT	(IRQ_VS_SOFT - IRQ_S_SOFT)
>>   #define VSIP_VALID_MASK		((_AC(1, UL) << IRQ_S_SOFT) | \
>>   				 (_AC(1, UL) << IRQ_S_TIMER) | \
>> -				 (_AC(1, UL) << IRQ_S_EXT))
>> +				 (_AC(1, UL) << IRQ_S_EXT) | \
>> +				 (_AC(1, UL) << IRQ_PMU_OVF))
>>   
>>   /* AIA CSR bits */
>>   #define TOPI_IID_SHIFT		16
>> diff --git a/arch/riscv/include/asm/kvm_vcpu_pmu.h b/arch/riscv/include/asm/kvm_vcpu_pmu.h
>> index 586bab84be35..8cb21a4f862c 100644
>> --- a/arch/riscv/include/asm/kvm_vcpu_pmu.h
>> +++ b/arch/riscv/include/asm/kvm_vcpu_pmu.h
>> @@ -36,6 +36,7 @@ struct kvm_pmc {
>>   	bool started;
>>   	/* Monitoring event ID */
>>   	unsigned long event_idx;
>> +	struct kvm_vcpu *vcpu;
>>   };
>>   
>>   /* PMU data structure per vcpu */
>> @@ -50,6 +51,8 @@ struct kvm_pmu {
>>   	bool init_done;
>>   	/* Bit map of all the virtual counter used */
>>   	DECLARE_BITMAP(pmc_in_use, RISCV_KVM_MAX_COUNTERS);
>> +	/* Bit map of all the virtual counter overflown */
>> +	DECLARE_BITMAP(pmc_overflown, RISCV_KVM_MAX_COUNTERS);
>>   	/* The address of the counter snapshot area (guest physical address) */
>>   	gpa_t snapshot_addr;
>>   	/* The actual data of the snapshot */
>> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
>> index 7499e88a947c..e8b7545f1803 100644
>> --- a/arch/riscv/include/uapi/asm/kvm.h
>> +++ b/arch/riscv/include/uapi/asm/kvm.h
>> @@ -166,6 +166,7 @@ enum KVM_RISCV_ISA_EXT_ID {
>>   	KVM_RISCV_ISA_EXT_ZVFH,
>>   	KVM_RISCV_ISA_EXT_ZVFHMIN,
>>   	KVM_RISCV_ISA_EXT_ZFA,
>> +	KVM_RISCV_ISA_EXT_SSCOFPMF,
>>   	KVM_RISCV_ISA_EXT_MAX,
>>   };
>>   
>> diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
>> index a944294f6f23..0f0a9d11bb5f 100644
>> --- a/arch/riscv/kvm/aia.c
>> +++ b/arch/riscv/kvm/aia.c
>> @@ -545,6 +545,9 @@ void kvm_riscv_aia_enable(void)
>>   	enable_percpu_irq(hgei_parent_irq,
>>   			  irq_get_trigger_type(hgei_parent_irq));
>>   	csr_set(CSR_HIE, BIT(IRQ_S_GEXT));
>> +	/* Enable IRQ filtering for overflow interrupt only if sscofpmf is present */
>> +	if (__riscv_isa_extension_available(NULL, RISCV_ISA_EXT_SSCOFPMF))
>> +		csr_write(CSR_HVIEN, BIT(IRQ_PMU_OVF));
>>   }
>>   
>>   void kvm_riscv_aia_disable(void)
>> @@ -558,6 +561,8 @@ void kvm_riscv_aia_disable(void)
>>   		return;
>>   	hgctrl = get_cpu_ptr(&aia_hgei);
>>   
>> +	if (__riscv_isa_extension_available(NULL, RISCV_ISA_EXT_SSCOFPMF))
>> +		csr_clear(CSR_HVIEN, BIT(IRQ_PMU_OVF));
>>   	/* Disable per-CPU SGEI interrupt */
>>   	csr_clear(CSR_HIE, BIT(IRQ_S_GEXT));
>>   	disable_percpu_irq(hgei_parent_irq);
>> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
>> index b5ca9f2e98ac..fcd8ad4de4d2 100644
>> --- a/arch/riscv/kvm/vcpu.c
>> +++ b/arch/riscv/kvm/vcpu.c
>> @@ -365,6 +365,12 @@ void kvm_riscv_vcpu_sync_interrupts(struct kvm_vcpu *vcpu)
>>   		}
>>   	}
>>   
>> +	/* Sync up the HVIP.LCOFIP bit changes (only clear) by the guest */
>> +	if ((csr->hvip ^ hvip) & (1UL << IRQ_PMU_OVF)) {
>> +		if (!test_and_set_bit(IRQ_PMU_OVF, v->irqs_pending_mask))
>> +			clear_bit(IRQ_PMU_OVF, v->irqs_pending);
>> +	}
>> +
>>   	/* Sync-up AIA high interrupts */
>>   	kvm_riscv_vcpu_aia_sync_interrupts(vcpu);
>>   
>> @@ -382,7 +388,8 @@ int kvm_riscv_vcpu_set_interrupt(struct kvm_vcpu *vcpu, unsigned int irq)
>>   	if (irq < IRQ_LOCAL_MAX &&
>>   	    irq != IRQ_VS_SOFT &&
>>   	    irq != IRQ_VS_TIMER &&
>> -	    irq != IRQ_VS_EXT)
>> +	    irq != IRQ_VS_EXT &&
>> +	    irq != IRQ_PMU_OVF)
>>   		return -EINVAL;
>>   
>>   	set_bit(irq, vcpu->arch.irqs_pending);
>> @@ -397,14 +404,15 @@ int kvm_riscv_vcpu_set_interrupt(struct kvm_vcpu *vcpu, unsigned int irq)
>>   int kvm_riscv_vcpu_unset_interrupt(struct kvm_vcpu *vcpu, unsigned int irq)
>>   {
>>   	/*
>> -	 * We only allow VS-mode software, timer, and external
>> +	 * We only allow VS-mode software, timer, counter overflow and external
>>   	 * interrupts when irq is one of the local interrupts
>>   	 * defined by RISC-V privilege specification.
>>   	 */
>>   	if (irq < IRQ_LOCAL_MAX &&
>>   	    irq != IRQ_VS_SOFT &&
>>   	    irq != IRQ_VS_TIMER &&
>> -	    irq != IRQ_VS_EXT)
>> +	    irq != IRQ_VS_EXT &&
>> +	    irq != IRQ_PMU_OVF)
>>   		return -EINVAL;
>>   
>>   	clear_bit(irq, vcpu->arch.irqs_pending);
>> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
>> index 5f7355e96008..a072910820c2 100644
>> --- a/arch/riscv/kvm/vcpu_onereg.c
>> +++ b/arch/riscv/kvm/vcpu_onereg.c
>> @@ -36,6 +36,7 @@ static const unsigned long kvm_isa_ext_arr[] = {
>>   	/* Multi letter extensions (alphabetically sorted) */
>>   	KVM_ISA_EXT_ARR(SMSTATEEN),
>>   	KVM_ISA_EXT_ARR(SSAIA),
>> +	KVM_ISA_EXT_ARR(SSCOFPMF),
>>   	KVM_ISA_EXT_ARR(SSTC),
>>   	KVM_ISA_EXT_ARR(SVINVAL),
>>   	KVM_ISA_EXT_ARR(SVNAPOT),
>> @@ -115,6 +116,7 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
>>   	case KVM_RISCV_ISA_EXT_I:
>>   	case KVM_RISCV_ISA_EXT_M:
>>   	case KVM_RISCV_ISA_EXT_SSTC:
>> +	case KVM_RISCV_ISA_EXT_SSCOFPMF:
> 
> It should go above SSTC to keep the alphabet happy,
> 

Fixed.

> but it should be possible for the VMM to disable this extension in the
> guest. We just need to change all the checks in KVM of the host's ISA
> for RISCV_ISA_EXT_SSCOFPMF to checking the guest's ISA instead. Maybe
> it's not worth it, though, if the guest PMU isn't useful without overflow.
> But, sometimes it's nice to be able to disable stuff for debug and
> workarounds.
> 

As per my understanding, kvm_riscv_vcpu_isa_disable_allowed only returns
true for those extensions which can be disabled architecturally.

VMM can still disable any extension by not adding to the device tree.
In fact, that's how kvmtool can disable sstc or sscofpmf with 
--disable-<isa-ext command>.

The warning is bit confused though.

For example: if you run kvmtool with --disable-sstc

"Warning: Failed to disable sstc ISA exension"

But sstc is disabled: Here is the cpuinfo output.
# cat /proc/cpuinfo
processor       : 0
hart            : 0
isa             : 
rv64imafdc_zicbom_zicboz_zicntr_zicsr_zifencei_zihintntl_zihintpause_zihpm_zfa_zba_zbb_zbc_zbs_smstateen_sscofpmf
mmu             : sv57
mvendorid       : 0x0
marchid         : 0x0
mimpid          : 0x0
hart isa        : 
rv64imafdc_zicbom_zicboz_zicntr_zicsr_zifencei_zihintntl_zihintpause_zihpm_zfa_zba_zbb_zbc_zbs_smstateen_sscofpmf


Let me know if I misunderstood your comment.

>>   	case KVM_RISCV_ISA_EXT_SVINVAL:
>>   	case KVM_RISCV_ISA_EXT_SVNAPOT:
>>   	case KVM_RISCV_ISA_EXT_ZBA:
>> @@ -171,8 +173,13 @@ void kvm_riscv_vcpu_setup_isa(struct kvm_vcpu *vcpu)
>>   	for (i = 0; i < ARRAY_SIZE(kvm_isa_ext_arr); i++) {
>>   		host_isa = kvm_isa_ext_arr[i];
>>   		if (__riscv_isa_extension_available(NULL, host_isa) &&
>> -		    kvm_riscv_vcpu_isa_enable_allowed(i))
>> +		    kvm_riscv_vcpu_isa_enable_allowed(i)) {
>> +			/* Sscofpmf depends on interrupt filtering defined in ssaia */
>> +			if (host_isa == RISCV_ISA_EXT_SSCOFPMF &&
>> +			    !__riscv_isa_extension_available(NULL, RISCV_ISA_EXT_SSAIA))
>> +				continue;
> 
> We shouldn't need to change kvm_riscv_vcpu_setup_isa(). We just need to
> add a case for KVM_RISCV_ISA_EXT_SSCOFPMF to
> kvm_riscv_vcpu_isa_enable_allowed().
> 

Good point. Done.

>>   			set_bit(host_isa, vcpu->arch.isa);
>> +		}
>>   	}
>>   }
>>   
>> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
>> index 74865e6050a1..a02f7b981005 100644
>> --- a/arch/riscv/kvm/vcpu_pmu.c
>> +++ b/arch/riscv/kvm/vcpu_pmu.c
>> @@ -39,7 +39,7 @@ static u64 kvm_pmu_get_sample_period(struct kvm_pmc *pmc)
>>   	u64 sample_period;
>>   
>>   	if (!pmc->counter_val)
>> -		sample_period = counter_val_mask + 1;
>> +		sample_period = counter_val_mask;
> 
> This change looks unrelated.
> 
Technically, it is related as this would be problematic when counter 
overflow is enabled as it may result in sample_period as 0 (if mask is 
0xFFFFFFFFFFFFFFFF) and generate spurious interrupts.

I can create a separate patch with above explaination.


>>   	else
>>   		sample_period = (-pmc->counter_val) & counter_val_mask;
>>   
>> @@ -229,6 +229,47 @@ static int kvm_pmu_validate_counter_mask(struct kvm_pmu *kvpmu, unsigned long ct
>>   	return 0;
>>   }
>>   
>> +static void kvm_riscv_pmu_overflow(struct perf_event *perf_event,
>> +				   struct perf_sample_data *data,
>> +				   struct pt_regs *regs)
>> +{
>> +	struct kvm_pmc *pmc = perf_event->overflow_handler_context;
>> +	struct kvm_vcpu *vcpu = pmc->vcpu;
>> +	struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
>> +	struct riscv_pmu *rpmu = to_riscv_pmu(perf_event->pmu);
>> +	u64 period;
>> +
>> +	/*
>> +	 * Stop the event counting by directly accessing the perf_event.
>> +	 * Otherwise, this needs to deferred via a workqueue.
>> +	 * That will introduce skew in the counter value because the actual
>> +	 * physical counter would start after returning from this function.
>> +	 * It will be stopped again once the workqueue is scheduled
>> +	 */
>> +	rpmu->pmu.stop(perf_event, PERF_EF_UPDATE);
>> +
>> +	/*
>> +	 * The hw counter would start automatically when this function returns.
>> +	 * Thus, the host may continue to interrupt and inject it to the guest
>> +	 * even without the guest configuring the next event. Depending on the hardware
>> +	 * the host may have some sluggishness only if privilege mode filtering is not
>> +	 * available. In an ideal world, where qemu is not the only capable hardware,
>> +	 * this can be removed.
>> +	 * FYI: ARM64 does this way while x86 doesn't do anything as such.
>> +	 * TODO: Should we keep it for RISC-V ?
>> +	 */
>> +	period = -(local64_read(&perf_event->count));
>> +
>> +	local64_set(&perf_event->hw.period_left, 0);
>> +	perf_event->attr.sample_period = period;
>> +	perf_event->hw.sample_period = period;
>> +
>> +	set_bit(pmc->idx, kvpmu->pmc_overflown);
>> +	kvm_riscv_vcpu_set_interrupt(vcpu, IRQ_PMU_OVF);
>> +
>> +	rpmu->pmu.start(perf_event, PERF_EF_RELOAD);
>> +}
>> +
>>   static long kvm_pmu_create_perf_event(struct kvm_pmc *pmc, struct perf_event_attr *attr,
>>   				      unsigned long flags, unsigned long eidx,
>>   				      unsigned long evtdata)
>> @@ -248,7 +289,7 @@ static long kvm_pmu_create_perf_event(struct kvm_pmc *pmc, struct perf_event_att
>>   	 */
>>   	attr->sample_period = kvm_pmu_get_sample_period(pmc);
>>   
>> -	event = perf_event_create_kernel_counter(attr, -1, current, NULL, pmc);
>> +	event = perf_event_create_kernel_counter(attr, -1, current, kvm_riscv_pmu_overflow, pmc);
>>   	if (IS_ERR(event)) {
>>   		pr_err("kvm pmu event creation failed for eidx %lx: %ld\n", eidx, PTR_ERR(event));
>>   		return PTR_ERR(event);
>> @@ -436,6 +477,8 @@ int kvm_riscv_vcpu_pmu_ctr_start(struct kvm_vcpu *vcpu, unsigned long ctr_base,
>>   		pmc_index = i + ctr_base;
>>   		if (!test_bit(pmc_index, kvpmu->pmc_in_use))
>>   			continue;
>> +		/* The guest started the counter again. Reset the overflow status */
>> +		clear_bit(pmc_index, kvpmu->pmc_overflown);
>>   		pmc = &kvpmu->pmc[pmc_index];
>>   		if (flags & SBI_PMU_START_FLAG_SET_INIT_VALUE) {
>>   			pmc->counter_val = ival;
>> @@ -474,6 +517,10 @@ int kvm_riscv_vcpu_pmu_ctr_start(struct kvm_vcpu *vcpu, unsigned long ctr_base,
>>   		}
>>   	}
>>   
>> +	/* The guest have serviced the interrupt and starting the counter again */
>> +	if (test_bit(IRQ_PMU_OVF, vcpu->arch.irqs_pending))
>> +		kvm_riscv_vcpu_unset_interrupt(vcpu, IRQ_PMU_OVF);
>> +
>>   out:
>>   	retdata->err_val = sbiret;
>>   
>> @@ -540,7 +587,13 @@ int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *vcpu, unsigned long ctr_base,
>>   			else if (pmc->perf_event)
>>   				pmc->counter_val += perf_event_read_value(pmc->perf_event,
>>   									  &enabled, &running);
>> -			/* TODO: Add counter overflow support when sscofpmf support is added */
>> +			/*
>> +			 * The counter and overflow indicies in the snapshot region are w.r.to
>> +			 * cbase. Modify the set bit in the counter mask instead of the pmc_index
>> +			 * which indicates the absolute counter index.
>> +			 */
>> +			if (test_bit(pmc_index, kvpmu->pmc_overflown))
>> +				kvpmu->sdata->ctr_overflow_mask |= (1UL << i);
> 
> Just in case you missed this one; BIT()
> 
>>   			kvpmu->sdata->ctr_values[i] = pmc->counter_val;
>>   			kvm_vcpu_write_guest(vcpu, kvpmu->snapshot_addr, kvpmu->sdata,
>>   					     sizeof(struct riscv_pmu_snapshot_data));
>> @@ -549,15 +602,20 @@ int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *vcpu, unsigned long ctr_base,
>>   		if (flags & SBI_PMU_STOP_FLAG_RESET) {
>>   			pmc->event_idx = SBI_PMU_EVENT_IDX_INVALID;
>>   			clear_bit(pmc_index, kvpmu->pmc_in_use);
>> +			clear_bit(pmc_index, kvpmu->pmc_overflown);
>>   			if (snap_flag_set) {
>>   				/* Clear the snapshot area for the upcoming deletion event */
>>   				kvpmu->sdata->ctr_values[i] = 0;
>> +				/*
>> +				 * Only clear the given counter as the caller is responsible to
>> +				 * validate both the overflow mask and configured counters.
>> +				 */
>> +				kvpmu->sdata->ctr_overflow_mask &= ~(1UL << i);
> 
> And another BIT()
> 
>>   				kvm_vcpu_write_guest(vcpu, kvpmu->snapshot_addr, kvpmu->sdata,
>>   						     sizeof(struct riscv_pmu_snapshot_data));
>>   			}
>>   		}
>>   	}
>> -
>>   out:
>>   	retdata->err_val = sbiret;
>>   
>> @@ -700,6 +758,7 @@ void kvm_riscv_vcpu_pmu_init(struct kvm_vcpu *vcpu)
>>   		pmc = &kvpmu->pmc[i];
>>   		pmc->idx = i;
>>   		pmc->event_idx = SBI_PMU_EVENT_IDX_INVALID;
>> +		pmc->vcpu = vcpu;
>>   		if (i < kvpmu->num_hw_ctrs) {
>>   			pmc->cinfo.type = SBI_PMU_CTR_TYPE_HW;
>>   			if (i < 3)
>> @@ -732,13 +791,14 @@ void kvm_riscv_vcpu_pmu_deinit(struct kvm_vcpu *vcpu)
>>   	if (!kvpmu)
>>   		return;
>>   
>> -	for_each_set_bit(i, kvpmu->pmc_in_use, RISCV_MAX_COUNTERS) {
>> +	for_each_set_bit(i, kvpmu->pmc_in_use, RISCV_KVM_MAX_COUNTERS) {
>>   		pmc = &kvpmu->pmc[i];
>>   		pmc->counter_val = 0;
>>   		kvm_pmu_release_perf_event(pmc);
>>   		pmc->event_idx = SBI_PMU_EVENT_IDX_INVALID;
>>   	}
>> -	bitmap_zero(kvpmu->pmc_in_use, RISCV_MAX_COUNTERS);
>> +	bitmap_zero(kvpmu->pmc_in_use, RISCV_KVM_MAX_COUNTERS);
> 
> Ideally the RISCV_MAX_COUNTERS change would go in a separate patch,
> but 64 == 64, so OK.
> 
>> +	bitmap_zero(kvpmu->pmc_overflown, RISCV_KVM_MAX_COUNTERS);
>>   	memset(&kvpmu->fw_event, 0, SBI_PMU_FW_MAX * sizeof(struct kvm_fw_event));
>>   	kvm_pmu_clear_snapshot_area(vcpu);
>>   }
>> -- 
>> 2.34.1
>>
> 
> Thanks,
> drew


