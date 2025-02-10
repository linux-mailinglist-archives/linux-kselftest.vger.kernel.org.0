Return-Path: <linux-kselftest+bounces-26265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 030A7A2FE32
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 00:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E5D3A5DBA
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 23:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9A125EFB3;
	Mon, 10 Feb 2025 23:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ao33QvaD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F9925EF9B
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 23:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739228894; cv=none; b=rDr+AD+9YBx1OiAvez12l7IcjRNG4uZPFVvNFyy53w6aKbCLebmlBhXQpTC18g/BmdfvimOVndjK9hBjGrj1ovK7zp+kI5YK6F2rDU9+aqUj6UfhiT5y/AbFJaHXZGQYjkMi1Q2VlT8iL1+3eCSEDVm/nzE4zH8I/qpmxy5x3c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739228894; c=relaxed/simple;
	bh=s/ssfNn4b7bCXjP2GKwiQQgiKWJx78QfbpNKZtSS6Q4=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=nYcKPMmut0EZm8A3n3jMwpXWj3LaUd89g/kkXHq0TYcJHpA7Y37KcnTVqDXkHvS/YGij2WQorFFvyGynIyiEhFDhfp2u5+IK5Rse2yLKy/fviJHAoy6Nnp20BhVJRlkbNb1oTmtAB5PRPr3nq5pLa1hEdRgTBLqFz2NkkKfmfME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ao33QvaD; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3d058142573so37326475ab.1
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 15:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739228892; x=1739833692; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CXinvutFgPziM7RxPNDr3Edga1bpxeAp0Ov8Puttle0=;
        b=Ao33QvaDqLBfzcYuOSvLYfq+o96q/+BbX+Pbb21EuoerhsSxeODMPQTRIsKNEH34EG
         wHMMd1dZcEuclV++vpCezIT1xj8Hp1lTYfI62i1WTxMlTcfx3Q8o2lSpLyBtvdG26cL2
         2LY6+K4dJxlp67e7/iAlurx7F7pvyvWGfFGe0pR6Ut3CymKI2V6p0KEy1uBMllKnmsbR
         wp90AScnRgqcaFTW9htr2U9hNC7NRfD1Eio6WVOa7iCl4ZeSl9cAuWcJCi0Dr+IxoaaY
         BZ34DCyvu+Hz2HtzoB9okY7a9q5AHbixBW4ffRCuY9P8OkwKd70hCtxZr+ef8qLJ80W3
         uVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739228892; x=1739833692;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CXinvutFgPziM7RxPNDr3Edga1bpxeAp0Ov8Puttle0=;
        b=QIaukPGprlYMDWXivOAHfY/jgKyg/eSFrgoeWeQ7yWVU7WBdZNepRE/4jPDArC0xW1
         IxYGVIzfB/E9dySLZdfznwdUYF+GB1hJGoG2nM9J/zLD+AzQgO1wGd67w2OHPwaXGGd3
         Iz3vHnVE697xs1v/RWtqcgopApvaGvrVH+FdMxDtL97eKHOAeYANyWs2X5MaPRZkTA2d
         dlw5zK5gQ6lnJ0wyJC5FhZk1qwv484WRR+pZxHSCJeIPT459LurdbMOgGvt27giwNEFp
         O5E2fKsXemcDbUn3/DD+P1ZTPfErUYcyW8grO5TC52Tu59AI0kzt98NtCffEV7SKRlDs
         xfvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBbqQ5SoHjnT3Mp8cyaRT+TNnbeweR0cmQVvU2wpfb7rbE2WFFFPkSzxFBi/9TYqn94fk2/t6elxv8Ojt0Evg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxHi32ZDr6jZP39WPp2+KjEB/ezaQqHfreSTkdJKBHIBEhk0bb
	5nRZO6JwbQGHdN1B23wSjbgf6qcOsAPEI3ffgSGkscSywbKWk11tMAa41X1JTkNATGMIxeTFIJR
	DqCuMGbz7iLbNSZ6bZThr2A==
X-Google-Smtp-Source: AGHT+IFUZhu2OwBm9Xl4P9gAhtgSkcN1rVy5kcIM68xBXK4rcWyV4/0jaNvjvAieMThFeK6tg2McyqvG5JOCTsu70Q==
X-Received: from ilbec1.prod.google.com ([2002:a05:6e02:4701:b0:3d1:3d59:434b])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:1c01:b0:3d0:f2ca:65aa with SMTP id e9e14a558f8ab-3d16f40b648mr9951285ab.4.1739228891849;
 Mon, 10 Feb 2025 15:08:11 -0800 (PST)
Date: Mon, 10 Feb 2025 23:08:11 +0000
In-Reply-To: <Z6msyUG0HWM2EImQ@linux.dev> (message from Oliver Upton on Sun, 9
 Feb 2025 23:37:45 -0800)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsnted051jqc.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [RFC PATCH v2 4/4] KVM: arm64: Make guests see only counters they
 can access
From: Colton Lewis <coltonlewis@google.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: kvm@vger.kernel.org, linux@armlinux.org.uk, catalin.marinas@arm.com, 
	will@kernel.org, maz@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, mark.rutland@arm.com, pbonzini@redhat.com, 
	shuah@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Hi Oliver, thanks for the review.

Oliver Upton <oliver.upton@linux.dev> writes:

> On Sat, Feb 08, 2025 at 02:01:11AM +0000, Colton Lewis wrote:
>> The ARM architecture specifies that when MDCR_EL2.HPMN is set, EL1 and
>> EL0, which includes KVM guests, should read that value for PMCR.N.

>> Signed-off-by: Colton Lewis <coltonlewis@google.com>
>> ---
>>   arch/arm64/kvm/debug.c                                  | 3 +--
>>   arch/arm64/kvm/pmu-emul.c                               | 8 +++++++-
>>   tools/testing/selftests/kvm/arm64/vpmu_counter_access.c | 2 +-
>>   3 files changed, 9 insertions(+), 4 deletions(-)

>> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
>> index 0e4c805e7e89..7c04db00bf6c 100644
>> --- a/arch/arm64/kvm/debug.c
>> +++ b/arch/arm64/kvm/debug.c
>> @@ -36,8 +36,7 @@ static void kvm_arm_setup_mdcr_el2(struct kvm_vcpu  
>> *vcpu)
>>   	 * This also clears MDCR_EL2_E2PB_MASK and MDCR_EL2_E2TB_MASK
>>   	 * to disable guest access to the profiling and trace buffers
>>   	 */
>> -	vcpu->arch.mdcr_el2 = FIELD_PREP(MDCR_EL2_HPMN,
>> -					 *host_data_ptr(nr_event_counters));
>> +	vcpu->arch.mdcr_el2 = FIELD_PREP(MDCR_EL2_HPMN, read_mdcr());

> Please avoid unnecessary accesses to MDCR_EL2 at all costs. This is a
> guaranteed trap to EL2 with nested virt.

I thought it was necessary when I wrote this, but I see it's not after
thinking about it for a while.

The intended value is accessible from vcpu->kvm->arch.arm_pmu.hpmn as
written, but could be somewhere else after addressing your suggestion to
lift all MDCR handling into KVM.

>>   	vcpu->arch.mdcr_el2 |= (MDCR_EL2_TPM |
>>   				MDCR_EL2_TPMS |
>>   				MDCR_EL2_TTRF |
>> diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
>> index 6c5950b9ceac..052ce8c721fe 100644
>> --- a/arch/arm64/kvm/pmu-emul.c
>> +++ b/arch/arm64/kvm/pmu-emul.c
>> @@ -993,12 +993,18 @@ static bool pmu_irq_is_valid(struct kvm *kvm, int  
>> irq)
>>   u8 kvm_arm_pmu_get_max_counters(struct kvm *kvm)
>>   {
>>   	struct arm_pmu *arm_pmu = kvm->arch.arm_pmu;
>> +	u8 limit;
>> +
>> +	if (arm_pmu->partitioned)
>> +		limit = arm_pmu->hpmn - 1;
>> +	else
>> +		limit = ARMV8_PMU_MAX_GENERAL_COUNTERS;

>>   	/*
>>   	 * The arm_pmu->cntr_mask considers the fixed counter(s) as well.
>>   	 * Ignore those and return only the general-purpose counters.
>>   	 */
>> -	return bitmap_weight(arm_pmu->cntr_mask,  
>> ARMV8_PMU_MAX_GENERAL_COUNTERS);
>> +	return bitmap_weight(arm_pmu->cntr_mask, limit);
>>   }

> This isn't necessary and is likely to regress the existing behavior.

> When the architecture says the lower ELs should see PMCR_EL0.N have the
> same value as MDCR_EL2.HPMN, what it really means is direct reads from
> hardware will return the value.

> So my expectation would be that a VM using the partitioned PMU
> implementation would never reach any of the *emulated* PMU handlers, as
> we would've disabled the associated traps.

Understood. The change was here to see be able to read PMCR_EL0.N from
inside a VM since I haven't disabled the associated traps yet.

It shouldn't be in this patch.

> The partitioned PMU will not replace the emulated vPMU implementation in
> KVM, so it'd be good to refactor what we have today to make room for
> your work. I think that'd be along the lines of:

>   - Shared code for event filter enforcement and handling of the vPMU
>     overflow IRQ.

>   - Emulated PMU implementation that provides trap handlers for all PMUv3
>     registers and backs into host perf

>   - Partitioned PMU implementation that doesn't rely on traps and instead
>     saves / restores a portion of the PMU that contains the guest
>     context.

> These should be done in separate files, i.e. I do not want to see a
> bunch of inline handling to cope with emulated v. partitioned PMUs.

Agreed.

>>   static void kvm_arm_set_pmu(struct kvm *kvm, struct arm_pmu *arm_pmu)
>> diff --git a/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c  
>> b/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
>> index f16b3b27e32e..b5bc18b7528d 100644
>> --- a/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
>> +++ b/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
>> @@ -609,7 +609,7 @@ static void run_pmregs_validity_test(uint64_t pmcr_n)
>>    */
>>   static void run_error_test(uint64_t pmcr_n)
>>   {
>> -	pr_debug("Error test with pmcr_n %lu (larger than the host)\n",  
>> pmcr_n);
>> +	pr_debug("Error test with pmcr_n %lu (larger than the host allows)\n",  
>> pmcr_n);

> NBD for an RFC, but in the future please do selftests changes in a
> separate patch.

Ok, I'll do that in the future.

