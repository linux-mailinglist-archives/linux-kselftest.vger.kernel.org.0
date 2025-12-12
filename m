Return-Path: <linux-kselftest+bounces-47530-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8ABCB9D11
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 21:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7B163009128
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 20:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CF330FC17;
	Fri, 12 Dec 2025 20:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fFQJVvdt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71E130FC18
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 20:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765572699; cv=none; b=ocwCACyqajmu15ALkubK+V8KR7mPogz3538khtavRYlsaHCyB2qwPKRwbvICEbki/ByreD/PyU4jVY/DFyW1nmU8Lt8A1LvRr4hazJyG+TWBggIiQI9WGYrpDJZvoM7j3BhcRkFHWP+0aJw+PQFlZKw6ELnJT18UpopI49Wcdr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765572699; c=relaxed/simple;
	bh=5Vy0MtUSIVOvMELJVQ+zn0Oy3IQYDESUULZ9DpVuI4E=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=HJ9+xlkN8Lp+w+omPDSFmFzoSKk6JjlJZhb8No9/zy694jEEDsJ2YJJxkPisyYxEcicr38QoOy3ZvHD0o8xMPp30tNhQNJALE8lpbZ0Fpc3n6XyrfCoVmBZ64D5mysr7zrjBidrlssiuzzbuaUHoZfb7vgFYqLdYc9sX1WEImDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fFQJVvdt; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-65b3208d4deso2424319eaf.1
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 12:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765572696; x=1766177496; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NzWUthEm6qM67H7+l7VSfoh+naGIv34T+Myn0YzgNIE=;
        b=fFQJVvdtXYEkiPwn/JGabQ6i71nzyPI8O7k5qpqIj+PPWXEJJewYkdpjXcPX/KdOJR
         MEDXOHVPHJjaIlFkwSuzWg+UQNtJQeOIKi05HM/dnh1+lN9lOWYLFqaEGgQPpU7ilRmB
         qLNXTxsCK565qOt1hE/fqvU24GLqcoQqmty44Yy/hWB+zSkXouNo973e7da+mE0UBe4I
         jVPz/KXpoj/juh1GLuobJJcd3i5ODEgOe+7Q4sEn23iAvQcjXsnfgcKiEFbIzNXS6nxu
         01Rh05s6XMcXeJq+VQn74NDOmmZplNS9Ia2onqEAEcm7/NsOI0RCJzrZgRr998WGzveD
         9Rdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765572696; x=1766177496;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NzWUthEm6qM67H7+l7VSfoh+naGIv34T+Myn0YzgNIE=;
        b=wa7nBchehH6u2Yn9S82K/aEgode+F03rhFr85qoa5oHXBKzzKEVgcoOFqucLiW/3WL
         MjoFX4yNoO9v8xC1vhTu7DqObnYxdDHHP0jQkyaia0k379hanAx6tbdApT+fVn92S0M9
         RwbJQ/raZh13cwLSbgO4dAV5A3Wo/hzo5W8uSkP9CZqIlSxsunZ4XY4lTCVl7lhcNkV6
         NHQVu/uJkhJqkuzlxF+Vv0ELVYFNy0Od3MiLBd+2enlOcOxlW/SG9O8i6PyfXr0UeU+X
         h1N1cixOXEm23TnqEe7YzXRKl4KAePU0O24OlKoEORpEMnHbf1BFfQBqKWCKa0+vvAbr
         NrQw==
X-Forwarded-Encrypted: i=1; AJvYcCU1o39kSQ/YdCw14t9mzY2av4pdMscISZWrA314yNpjxI3ArBzSy95DSMxQDZSYvxFtRKooxUj6i7alXAqhNAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFUZwzxbsdHE/VXfQFKtxzo/mcS2/hvM3oYzwXdkV3eEveNzxu
	GE0sHPpL4LozfR7TE97PZ6zSdWZgaNdzbhVun+qMuQTyDiCbbUL0SoxSiu+aMMgscuS+OwnciX7
	oDlsyxaNCkduhPu7lTQOeCy//fg==
X-Google-Smtp-Source: AGHT+IGQzDy6EDRUx9rtYBW2j0eF+TYsJjWcSkav988OtHvTbiJ4yAnbUpXjKLkLa46xMZa50qB/G0Iw4pQoa2klIQ==
X-Received: from ilbbs15.prod.google.com ([2002:a05:6e02:240f:b0:434:972f:bf91])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a4a:e90c:0:b0:659:9a49:8f5b with SMTP id 006d021491bc7-65b4560080dmr1608719eaf.32.1765572695916;
 Fri, 12 Dec 2025 12:51:35 -0800 (PST)
Date: Fri, 12 Dec 2025 20:51:34 +0000
In-Reply-To: <aTiPvS49uMOJEBrf@kernel.org> (message from Oliver Upton on Tue,
 9 Dec 2025 13:08:13 -0800)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsnty0n72zl5.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v5 10/24] KVM: arm64: Set up FGT for Partitioned PMU
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


Hi Oliver. Thanks for the speedy review.

Oliver Upton <oupton@kernel.org> writes:

> Hi Colton,

> On Tue, Dec 09, 2025 at 08:51:07PM +0000, Colton Lewis wrote:
>> In order to gain the best performance benefit from partitioning the
>> PMU, utilize fine grain traps (FEAT_FGT and FEAT_FGT2) to avoid
>> trapping common PMU register accesses by the guest to remove that
>> overhead.

>> Untrapped:
>> * PMCR_EL0
>> * PMUSERENR_EL0
>> * PMSELR_EL0
>> * PMCCNTR_EL0
>> * PMCNTEN_EL0
>> * PMINTEN_EL1
>> * PMEVCNTRn_EL0

>> These are safe to untrap because writing MDCR_EL2.HPMN as this series
>> will do limits the effect of writes to any of these registers to the
>> partition of counters 0..HPMN-1. Reads from these registers will not
>> leak information from between guests as all these registers are
>> context swapped by a later patch in this series. Reads from these
>> registers also do not leak any information about the host's hardware
>> beyond what is promised by PMUv3.

>> Trapped:
>> * PMOVS_EL0
>> * PMEVTYPERn_EL0
>> * PMCCFILTR_EL0
>> * PMICNTR_EL0
>> * PMICFILTR_EL0
>> * PMCEIDn_EL0
>> * PMMIR_EL1

>> PMOVS remains trapped so KVM can track overflow IRQs that will need to
>> be injected into the guest.

>> PMICNTR and PMIFILTR remain trapped because KVM is not handling them
>> yet.

>> PMEVTYPERn remains trapped so KVM can limit which events guests can
>> count, such as disallowing counting at EL2. PMCCFILTR and PMCIFILTR
>> are special cases of the same.

>> PMCEIDn and PMMIR remain trapped because they can leak information
>> specific to the host hardware implementation.

>> NOTE: This patch temporarily forces kvm_vcpu_pmu_is_partitioned() to
>> be false to prevent partial feature activation for easier debugging.

>> Signed-off-by: Colton Lewis <coltonlewis@google.com>
>> ---
>>   arch/arm64/include/asm/kvm_pmu.h | 33 ++++++++++++++++++++++
>>   arch/arm64/kvm/config.c          | 34 ++++++++++++++++++++--
>>   arch/arm64/kvm/pmu-direct.c      | 48 ++++++++++++++++++++++++++++++++
>>   3 files changed, 112 insertions(+), 3 deletions(-)

>> diff --git a/arch/arm64/include/asm/kvm_pmu.h  
>> b/arch/arm64/include/asm/kvm_pmu.h
>> index 8887f39c25e60..7297a697a4a62 100644
>> --- a/arch/arm64/include/asm/kvm_pmu.h
>> +++ b/arch/arm64/include/asm/kvm_pmu.h
>> @@ -96,6 +96,23 @@ u64 kvm_pmu_guest_counter_mask(struct arm_pmu *pmu);
>>   void kvm_pmu_host_counters_enable(void);
>>   void kvm_pmu_host_counters_disable(void);

>> +#if !defined(__KVM_NVHE_HYPERVISOR__)
>> +bool kvm_vcpu_pmu_is_partitioned(struct kvm_vcpu *vcpu);
>> +bool kvm_vcpu_pmu_use_fgt(struct kvm_vcpu *vcpu);
>> +#else
>> +static inline bool kvm_vcpu_pmu_is_partitioned(struct kvm_vcpu *vcpu)
>> +{
>> +	return false;
>> +}
>> +
>> +static inline bool kvm_vcpu_pmu_use_fgt(struct kvm_vcpu *vcpu)
>> +{
>> +	return false;
>> +}
>> +#endif
>> +u64 kvm_pmu_fgt_bits(void);
>> +u64 kvm_pmu_fgt2_bits(void);
>> +
>>   /*
>>    * Updates the vcpu's view of the pmu events for this cpu.
>>    * Must be called before every vcpu run after disabling interrupts, to  
>> ensure
>> @@ -135,6 +152,22 @@ static inline u64 kvm_pmu_get_counter_value(struct  
>> kvm_vcpu *vcpu,
>>   {
>>   	return 0;
>>   }
>> +static inline bool kvm_vcpu_pmu_is_partitioned(struct kvm_vcpu *vcpu)
>> +{
>> +	return false;
>> +}
>> +static inline bool kvm_vcpu_pmu_use_fgt(struct kvm_vcpu *vcpu)
>> +{
>> +	return false;
>> +}
>> +static inline u64 kvm_pmu_fgt_bits(void)
>> +{
>> +	return 0;
>> +}
>> +static inline u64 kvm_pmu_fgt2_bits(void)
>> +{
>> +	return 0;
>> +}
>>   static inline void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu,
>>   					     u64 select_idx, u64 val) {}
>>   static inline void kvm_pmu_set_counter_value_user(struct kvm_vcpu *vcpu,
>> diff --git a/arch/arm64/kvm/config.c b/arch/arm64/kvm/config.c
>> index 24bb3f36e9d59..064dc6aa06f76 100644
>> --- a/arch/arm64/kvm/config.c
>> +++ b/arch/arm64/kvm/config.c
>> @@ -6,6 +6,7 @@

>>   #include <linux/kvm_host.h>
>>   #include <asm/kvm_emulate.h>
>> +#include <asm/kvm_pmu.h>
>>   #include <asm/kvm_nested.h>
>>   #include <asm/sysreg.h>

>> @@ -1489,12 +1490,39 @@ static void __compute_hfgwtr(struct kvm_vcpu  
>> *vcpu)
>>   		*vcpu_fgt(vcpu, HFGWTR_EL2) |= HFGWTR_EL2_TCR_EL1;
>>   }

>> +static void __compute_hdfgrtr(struct kvm_vcpu *vcpu)
>> +{
>> +	__compute_fgt(vcpu, HDFGRTR_EL2);
>> +
>> +	if (kvm_vcpu_pmu_use_fgt(vcpu))
>> +		*vcpu_fgt(vcpu, HDFGRTR_EL2) |= kvm_pmu_fgt_bits();

> Couple of suggestions. I'd rather see this conditioned on
> kvm_vcpu_pmu_is_partitioned() and get rid of the FGT predicate. After
> all, kvm_vcpu_load_fgt() already checks for the presence of FEAT_FGT
> first.

I can use that here. I'll still need the use_fgt predicate when
programming MDCR_EL2 so I'll introduce in the later patch.

> Additionally, I'd prefer that the trap configuration is inline instead
> of done in a helper in some other file. Centralizing the FGT
> configuration here was very much intentional.

Sure I can centralize it.

> The other reason for doing this is kvm_pmu_fgt_bits() assumes a
> 'positive' trap polarity, even though there are several cases where FGTs
> have a 'negative' priority (i.e. 0 => trap).

For the bits I was concerned with they all had positive polarity, except
for the dedicated instruction counter. (Side note: Why would ARM do
this?)

IIRC the FGT setup I plugged into in previous versions of the patch had
some icky macros that accounted for polarity. They were confusing and I
didn't like the effort to understand them.

Is there a good reason not to adopt a convetion that 1 => trap for
kernel code? Reversing the negative polarities immediately before write
could be easy: Have a bitmap of the negative polarity bits to xor with
the traps we actually want.

A^0 = A (positive polarity bits)
A^1 = ~A (negative polarity bits)

> Thanks,
> Oliver

