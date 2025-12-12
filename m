Return-Path: <linux-kselftest+bounces-47536-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9339CB9E5A
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 22:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 834EF307DC5C
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 21:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3D03002AE;
	Fri, 12 Dec 2025 21:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xsvorybJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848D8277C8D
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 21:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765576774; cv=none; b=qG0T9MoS1MUMFj/Kmhfxi2PRDEInXIpOKaJMnb+rWYDBVtgHdp4KIzkzIifbaRgprL/qE4Q+EmU7glUST0yGkkYlUWvgOhVa1yQxcbjoXQ/BgLw6u1KPJ16Qg7DrTjXlr8gPgGQC0zi3kGgukzFhS3P0k8g4kZykwfAQDuXGW4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765576774; c=relaxed/simple;
	bh=dIXE6EkR1BlYhVhmpJFqTLCIYmzsu4/lYU6SszEwHes=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=iXjnNK90S6xa9E1eTCXU1ciFTdoIA8436mO/q4d8YCEcAdy5Aa88XU3bB3qjo/DHIEqHfH92OrzLHUmdruRVff9M0GUgSPsj3GGrinhHOFyLg1g8rJ2AFUcJ1L77t7/WOpQgQ3rpex0egmAdUn2vD4NFbeR7Wp8WdbO81op8KAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xsvorybJ; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-65b32d52186so2256325eaf.3
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 13:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765576772; x=1766181572; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N/EpAY/5dCiD3IjULhAafgPlfUZK5B6r3caqhqftDLw=;
        b=xsvorybJM9BL8PaAAEZ0jlZyiZG/jvXTHVg6NMHr/Ji6XlAShGhD8GZeK/vCzU1nnR
         Vsdt0ifiexoujyr8mUxwBXs1dZMj/bm9qQw32LBNU6vugNuWsUhT/AScNLhdPd/YY/SR
         dm2g8X2zxAnng0RNnLtxkjIgjjVvtD90LoAou/l0upBdFuoMyqxG1ezOR/W57Dx5rkBK
         TK93KLplvqsDVqX9kGOJJd7tf5kjXyulZGnM5e3xJZXweBv68ArzB8FyqbI7SzP8FuTc
         gIfbk7bV2uQfyoUYjbXiYZerwX9oJtgdFdQPiM5eP/A3zMyZmVUUfIF/IdWuwIm48RXm
         LRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765576772; x=1766181572;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N/EpAY/5dCiD3IjULhAafgPlfUZK5B6r3caqhqftDLw=;
        b=V5+UxHDS36+lXTnPhjZLIsZ6bpsp20tx39ssosC1lg6BKRjK2O1X3ytawrkNAm06vG
         kYgN63XTE+77kkoUDh+YoSjEm2VEd+hStEfFNIJipHXYKem6TZqe1B6BKNcR296rjZoh
         7goBdIqMS+9OU3amNDjcJ0yhtgwjNaUFknYWeXZo1tEo7EHUQTS7jq9nW+DcMzhI4JFc
         q+MNZZG037ha1p0aSq8S/3cJz6TmM8dr7IR/ZyASqFSgEAYjGX4vXomd4oAjIIR0HLCS
         ixHNOrN5tBF9fGIyaISSfvtPlCeq1d3GJvDO8gT3KSSY59UiJV2622EXoZeXThJmkUZl
         ymNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJIK1GDxNjsiZO8Hq5BKKRe+89hZczaEDJEQQ0yKQRo3VF8stBDsUrj7RVOxhnXwIhGEuZ9fV3rzG7Pkml2mM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfnSreLysHfvEy8G63DlLLXZjkiHJY1o2RvvRrWF2DmXP3E+8H
	WvLebxwUoZW016qsvWhsORTWHPDcGdEBFT7RGGmn6Dfg5qsDp4rrrfM31C4fcfKML8KBqH0F5/y
	ljPBKVPoCFaxy3ByE+VmW7FrdNQ==
X-Google-Smtp-Source: AGHT+IF0CbQ2D3A1j2krEFoQZv301Z7CiO1P+3KpILDRxaeGjkRt5qjZ/Vujtj48CE91VIyGHYcc/uN+dXFfoTP2HA==
X-Received: from ilbee24.prod.google.com ([2002:a05:6e02:4918:b0:438:237b:ed42])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:1344:b0:659:9a49:8eb6 with SMTP id 006d021491bc7-65b4525d320mr1663961eaf.58.1765576771672;
 Fri, 12 Dec 2025 13:59:31 -0800 (PST)
Date: Fri, 12 Dec 2025 21:59:30 +0000
In-Reply-To: <aTicD5hlKhZ3rkIn@kernel.org> (message from Oliver Upton on Tue,
 9 Dec 2025 14:00:47 -0800)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsnth5tv2wfx.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v5 18/24] KVM: arm64: Enforce PMU event filter at vcpu_load()
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

> On Tue, Dec 09, 2025 at 08:51:15PM +0000, Colton Lewis wrote:
>> The KVM API for event filtering says that counters do not count when
>> blocked by the event filter. To enforce that, the event filter must be
>> rechecked on every load since it might have changed since the last
>> time the guest wrote a value. If the event is filtered, exclude
>> counting at all exception levels before writing the hardware.

>> Signed-off-by: Colton Lewis <coltonlewis@google.com>
>> ---
>>   arch/arm64/kvm/pmu-direct.c | 44 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)

>> diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
>> index 71977d24f489a..8d0d6d1a0d851 100644
>> --- a/arch/arm64/kvm/pmu-direct.c
>> +++ b/arch/arm64/kvm/pmu-direct.c
>> @@ -221,6 +221,49 @@ u8 kvm_pmu_hpmn(struct kvm_vcpu *vcpu)
>>   	return nr_host_cnt_max;
>>   }

>> +/**
>> + * kvm_pmu_apply_event_filter()
>> + * @vcpu: Pointer to vcpu struct
>> + *
>> + * To uphold the guarantee of the KVM PMU event filter, we must ensure
>> + * no counter counts if the event is filtered. Accomplish this by
>> + * filtering all exception levels if the event is filtered.
>> + */
>> +static void kvm_pmu_apply_event_filter(struct kvm_vcpu *vcpu)
>> +{
>> +	struct arm_pmu *pmu = vcpu->kvm->arch.arm_pmu;
>> +	u64 evtyper_set = ARMV8_PMU_EXCLUDE_EL0 |
>> +		ARMV8_PMU_EXCLUDE_EL1;
>> +	u64 evtyper_clr = ARMV8_PMU_INCLUDE_EL2;
>> +	u8 i;
>> +	u64 val;
>> +	u64 evsel;
>> +
>> +	if (!pmu)
>> +		return;
>> +
>> +	for (i = 0; i < pmu->hpmn_max; i++) {
>> +		val = __vcpu_sys_reg(vcpu, PMEVTYPER0_EL0 + i);
>> +		evsel = val & kvm_pmu_event_mask(vcpu->kvm);
>> +
>> +		if (vcpu->kvm->arch.pmu_filter &&
>> +		    !test_bit(evsel, vcpu->kvm->arch.pmu_filter))
>> +			val |= evtyper_set;
>> +
>> +		val &= ~evtyper_clr;
>> +		write_pmevtypern(i, val);
>> +	}
>> +
>> +	val = __vcpu_sys_reg(vcpu, PMCCFILTR_EL0);
>> +
>> +	if (vcpu->kvm->arch.pmu_filter &&
>> +	    !test_bit(ARMV8_PMUV3_PERFCTR_CPU_CYCLES,  
>> vcpu->kvm->arch.pmu_filter))
>> +		val |= evtyper_set;
>> +
>> +	val &= ~evtyper_clr;
>> +	write_pmccfiltr(val);
>> +}

> This doesn't work for nested. I agree that the hardware value of
> PMEVTYPERn_EL0 needs to be under KVM control, but depending on whether
> or not we're in a hyp context the meaning of the EL1 filtering bit
> changes. Have a look at kvm_pmu_create_perf_event().

That's where I got the ideas for this code. I'll look at the handling
for hyp context too.


> Thanks,
> Oliver

