Return-Path: <linux-kselftest+bounces-47531-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38671CB9D3E
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 21:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00B193017F01
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 20:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4185F3101AD;
	Fri, 12 Dec 2025 20:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QLwvmh3F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680C82FFFBF
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 20:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765572882; cv=none; b=ldhCnD/ndwBVLIzt190P6zFQY/YHIx25U4yE4SFwF6O16UgoUXThWiH8edLnleMc2+vNV3pKqbsD4qSNx6mKNflnulB6JEgvp9MhE4D9jhhsIQ4aPkH6XhuOC/9y7SgVoH0HYwEnW1VlOn8WM6xnRa0+eot6Dkbe6GXKnygH3uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765572882; c=relaxed/simple;
	bh=KRrYXDgotZ3hkrFWqT2Xxzs4T7VsdVUIUvNsM4Tt2CA=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Y33X89pC7ZfsvT8b4yTHW5akIGT7w4ndEymYbccE9EKlivf5BlikQamTGKL+UkDptT9tWyF/A3BngkCfuqYKIWBMshnS9fumtRF1aqf7DDhLsWH+gLxddpXvVFkOvowcQboiGa/zJZUPr764aRqDn0xE00yndMzmDqRBEaSBOSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QLwvmh3F; arc=none smtp.client-ip=209.85.167.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-450178eaf86so1348563b6e.0
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 12:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765572879; x=1766177679; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3FXn5oKHBMgqIJsfuynoMoNzKyF0I0AGnsGa5FlNVAQ=;
        b=QLwvmh3FMzVzPlJlBo6h9byVXnkQN6fm/+YA1AXbW0/raH/EuS+E9RC8QAizpGKaMQ
         YGmchoXUt/2Rlh4XWuxPmyuaRPyy0lgHI8fLA6oiR8oBCFUmtb2aPaXAPMeJnEZXooJu
         7ZVcEbzjRYGJwTMATEFOgnsjhZKqbgoCcrb2sNyKKvVyumEqOzA8XR+QEyeSr9ICASGt
         pJ+De79oxbKWGytN8+33JF706rM9pXVuznSoezpYw2T7RQBN+m9tDTGqRCxMYOeBETln
         /e/3R9yhBcioToy5iRTaNnPJDjcsQbfx2u3Z0hTFA/ckskNliVg9jMRASN+HFVbXddRk
         Nyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765572879; x=1766177679;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3FXn5oKHBMgqIJsfuynoMoNzKyF0I0AGnsGa5FlNVAQ=;
        b=MxmHHCtxoEVaiVcccd89RHnZhxdknLMoc9Xy8tDGKP/5t9NLg172po2QgN+7WyC8d4
         J1vTGYY70pmMCW2VT4Zh/cDNQHTulu0G9GZJfuAcD9ISQNFRaVAEtU0lHHrYKBiUB9d5
         smJoehFNP8jihHOPZ1t8fqzMI4tAUGFsi51KRTYi6orZlYmayEUDiVun9pj8o6a0Ar7v
         AQEh1Q5AVixYgpq+MjdW7RaDOR8AKEKZ1JmHxDw4L+l7Hw6qzJ2XFzmZmKF59RCGKYTs
         oRv2J7aufOGIR0SiEaH+cJJgaqlT+QQW/4sKlMaWsJvC6YN0+iXEiWmDa1aDPTUWn/dA
         sz4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGoln5cJm25mwBZPsR3ZxvNraDaF6E/mf80k1sp8RFu4RTjSiF/MhRv2eB8Ntx4xVRAbiUwrKywAZuMs6VGBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPBD9YVmY4H42fQpHjNmvk/3fGjAml7ag3La/zak4puSJj+JPy
	ySoG1bY7le4LLzo2Irzvipe38OgcT8ElViU4awael3jfQJgX4aCb1cGsq36ucPbKoCFZG5UsPA/
	XdokaRo7pa7Rg42XjlPn4gNXo4A==
X-Google-Smtp-Source: AGHT+IH6fb4UumzYsfcjXdyetsttD/1JFDYI7F758xyq6M3c7XHveoyP9rAiScoRQhR1KR8axHNUmY6AiGo2XvKjTQ==
X-Received: from oaeh14.prod.google.com ([2002:a05:6870:170e:b0:3f5:b0db:411a])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1814:b0:450:d504:9295 with SMTP id 5614622812f47-455ac957f68mr1619808b6e.44.1765572879590;
 Fri, 12 Dec 2025 12:54:39 -0800 (PST)
Date: Fri, 12 Dec 2025 20:54:38 +0000
In-Reply-To: <aTiRG0I1FZzntHtH@kernel.org> (message from Oliver Upton on Tue,
 9 Dec 2025 13:14:03 -0800)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntv7ib2zg1.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v5 12/24] KVM: arm64: Use physical PMSELR for PMXEVTYPER
 if partitioned
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

> On Tue, Dec 09, 2025 at 08:51:09PM +0000, Colton Lewis wrote:
>> Because PMXEVTYPER is trapped and PMSELR is not, it is not appropriate
>> to use the virtual PMSELR register when it could be outdated and lead
>> to an invalid write. Use the physical register when partitioned.

>> Signed-off-by: Colton Lewis <coltonlewis@google.com>
>> ---
>>   arch/arm64/include/asm/arm_pmuv3.h | 7 ++++++-
>>   arch/arm64/kvm/sys_regs.c          | 9 +++++++--
>>   2 files changed, 13 insertions(+), 3 deletions(-)

>> diff --git a/arch/arm64/include/asm/arm_pmuv3.h  
>> b/arch/arm64/include/asm/arm_pmuv3.h
>> index 27c4d6d47da31..60600f04b5902 100644
>> --- a/arch/arm64/include/asm/arm_pmuv3.h
>> +++ b/arch/arm64/include/asm/arm_pmuv3.h
>> @@ -70,11 +70,16 @@ static inline u64 read_pmcr(void)
>>   	return read_sysreg(pmcr_el0);
>>   }

>> -static inline void write_pmselr(u32 val)
>> +static inline void write_pmselr(u64 val)
>>   {
>>   	write_sysreg(val, pmselr_el0);
>>   }

>> +static inline u64 read_pmselr(void)
>> +{
>> +	return read_sysreg(pmselr_el0);
>> +}
>> +
>>   static inline void write_pmccntr(u64 val)
>>   {
>>   	write_sysreg(val, pmccntr_el0);
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index 0c9596325519b..2e6d907fa8af2 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -1199,14 +1199,19 @@ static bool writethrough_pmevtyper(struct  
>> kvm_vcpu *vcpu, struct sys_reg_params
>>   static bool access_pmu_evtyper(struct kvm_vcpu *vcpu, struct  
>> sys_reg_params *p,
>>   			       const struct sys_reg_desc *r)
>>   {
>> -	u64 idx, reg;
>> +	u64 idx, reg, pmselr;

>>   	if (pmu_access_el0_disabled(vcpu))
>>   		return false;

>>   	if (r->CRn == 9 && r->CRm == 13 && r->Op2 == 1) {
>>   		/* PMXEVTYPER_EL0 */
>> -		idx = SYS_FIELD_GET(PMSELR_EL0, SEL, __vcpu_sys_reg(vcpu,  
>> PMSELR_EL0));
>> +		if (kvm_vcpu_pmu_is_partitioned(vcpu))
>> +			pmselr = read_pmselr();
>> +		else
>> +			pmselr = __vcpu_sys_reg(vcpu, PMSELR_EL0);

> This isn't preemption safe. Nor should the "if (partitioned) do X else do  
> Y" get
> open-coded throughout the shop.

Okay. I had not known the register access stuff wasn't. I'll fix that.


> I would rather this be handled with a prepatory patch that provides
> generic PMU register accessors to the rest of KVM (e.g.
> vcpu_read_pmu_reg() / vcpu_write_pmu_reg()). Internally those helpers
> can locate the vCPU's PMU registers (emulated, partitioned in-memory,
> partitioned in-CPU).

That seems like a good idea.

> Thanks,
> Oliver

