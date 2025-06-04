Return-Path: <linux-kselftest+bounces-34336-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B37ACE5A0
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 22:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1063A9013
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 20:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA7322D4CE;
	Wed,  4 Jun 2025 20:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j/vQ3yr+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FC422D792
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Jun 2025 20:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749067850; cv=none; b=LRn/MtXhR+4+Ais0Qc/1dPDARUJj2jvodjC89/5e5F+VZqvIz06pG6QmUE9a99XY/ydrWYvSGY+lWY1J+ySE/w3ewPdmcODuyZr8YD6cJRdtjpG0GC7SwkfhQVm9K2B28I8dh8NaNb4Kc1HJfsneZ0wG/fAjSWcEBUAOW1WAu34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749067850; c=relaxed/simple;
	bh=mS4fz7cgO9m1HSXc8SA6kSBVkdgVjgUeW9KFvTjpWvk=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=K8xdXe7kAN5s6v4RHP9mPdClb9NcJswXeWU0sdB3q+wcdW/vIYinzxasRxcdPihcoFO1MSWDBHe6ETeVZU16PgINBj9B2fb8T2thqOFpsH8qAPt1/amEYj+6Uv/a23flcHiP8o/xAldELcu7g/KxGND5xcQNJ+K81o8JRIkNtMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j/vQ3yr+; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3ddc1af1e5bso6277575ab.0
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Jun 2025 13:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749067848; x=1749672648; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l0gzEZMaKBz+geZl5pxHGq7kFzj0QyinBj1xrmpUWk4=;
        b=j/vQ3yr+c0Qu7EdPzMYn3NKNhi1yp0gPzMpyng81GqmpwUFHaYeZKjAAMM1v6eD4b8
         WLzWeJD3o4R6iBybZ6o0CdVHLh9p71HyzkWKYl5lV0+n2T9gNu62Ti5EJxcceqq1QUbU
         TLgJpMOSvAVYOKPpVBzAPEr1gxrAb/HIrebUKawbuxLfrbwYOQ/JMQ/j4NDhwBGkoafg
         3geVMCu/hRsYt7UDnDdkAfPpplVqD/NuWhTAfvS8DYNBSX+IR86CkuNEAG7zjzTHlL6d
         p/kQ47K5GEfMvxtfnXnf5kUknQxj/xHdAGDMzrPoJgnfgs5Dd2GchdBzmYBlr5FrddZV
         CBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749067848; x=1749672648;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l0gzEZMaKBz+geZl5pxHGq7kFzj0QyinBj1xrmpUWk4=;
        b=TPOJXkNlCV0Hz7g5Y/TH92MVyiRMnaacxRrhwHBbvqwP9Ot3kn14OI3qXkbdCYslyD
         /hcgJR7g6140xAHKalOi+NI0fiAVGMxcP37iXGqLrgA39LrFkJApQQWd11xCuBPzL6uM
         eXNIWjxzaTHvIAdwx+6rE9CctwfEszi/+mgf77HmfXxwnpiJ7XfbZrXXgvvdvfiWzDci
         KIHsYkd4RgSAZo4UrH8ty/eBv1xiiJ4Rg9vpWguk2ZXcjRvZLWb4IwvVGMojYcd8VVGb
         zpYkwCdHukje6VJ6YGDVJiVPcGjaySAxt+z4Kzt3lfVpBVKd9PQJ4dYRQBTgd8RD9rsm
         sJ7g==
X-Forwarded-Encrypted: i=1; AJvYcCXw2CMDOzk5WI0PvdbwR4pzXvYWrIbDC1EJ1/6b1XQxANA3+lE0FwflWPy9+NF51kDjitF0kToMa4yN4zqSu2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGrS1tQY6I3YbZroyitI/oI+cN0etBZec7h4oQyfDEf5R4jzHM
	7J3qMO7hAsvR7rS273IQaDs99u7oUVKT1YDJT69PlH25qJjOYc+YLnJNoTZdgg1Gaj7b/H3TZs+
	xuapW9vyBZEEmJrb9297QWYrydg==
X-Google-Smtp-Source: AGHT+IEebJ+gdBmXEWqe1Fe3czqgQNBwW10WesxaqzS4IgnDmyZIhGpgkmk6gkpNi9jz//MbXeTmhCWS5OjtRGNtmg==
X-Received: from ilfj26.prod.google.com ([2002:a05:6e02:221a:b0:3dd:7629:ec3a])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:3e06:b0:3dc:87c7:a5b5 with SMTP id e9e14a558f8ab-3ddbfc344efmr50438865ab.3.1749067847917;
 Wed, 04 Jun 2025 13:10:47 -0700 (PDT)
Date: Wed, 04 Jun 2025 20:10:47 +0000
In-Reply-To: <aD91vp8QXdIjs1Nh@linux.dev> (message from Oliver Upton on Tue, 3
 Jun 2025 15:22:54 -0700)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntqzzz1d4o.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH 10/17] KVM: arm64: Writethrough trapped PMEVTYPER register
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

Oliver Upton <oliver.upton@linux.dev> writes:

> On Mon, Jun 02, 2025 at 07:26:55PM +0000, Colton Lewis wrote:
>> With FGT in place, the remaining trapped registers need to be written
>> through to the underlying physical registers as well as the virtual
>> ones. Failing to do this means delaying when guest writes take effect.

>> Signed-off-by: Colton Lewis <coltonlewis@google.com>
>> ---
>>   arch/arm64/kvm/sys_regs.c | 27 +++++++++++++++++++++++++--
>>   1 file changed, 25 insertions(+), 2 deletions(-)

>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index d368eeb4f88e..afd06400429a 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -18,6 +18,7 @@
>>   #include <linux/printk.h>
>>   #include <linux/uaccess.h>
>>   #include <linux/irqchip/arm-gic-v3.h>
>> +#include <linux/perf/arm_pmu.h>
>>   #include <linux/perf/arm_pmuv3.h>

>>   #include <asm/arm_pmuv3.h>
>> @@ -942,7 +943,11 @@ static bool pmu_counter_idx_valid(struct kvm_vcpu  
>> *vcpu, u64 idx)
>>   {
>>   	u64 pmcr, val;

>> -	pmcr = kvm_vcpu_read_pmcr(vcpu);
>> +	if (kvm_vcpu_pmu_is_partitioned(vcpu))
>> +		pmcr = read_pmcr();

> Reading PMCR_EL0 from EL2 is not going to have the desired effect.
> PMCR_EL0.N only returns HPMN when read from the guest.

Okay. I'll change that.

>> +	else
>> +		pmcr = kvm_vcpu_read_pmcr(vcpu);
>> +
>>   	val = FIELD_GET(ARMV8_PMU_PMCR_N, pmcr);
>>   	if (idx >= val && idx != ARMV8_PMU_CYCLE_IDX) {
>>   		kvm_inject_undefined(vcpu);
>> @@ -1037,6 +1042,22 @@ static bool access_pmu_evcntr(struct kvm_vcpu  
>> *vcpu,
>>   	return true;
>>   }

>> +static void writethrough_pmevtyper(struct kvm_vcpu *vcpu, struct  
>> sys_reg_params *p,
>> +				   u64 reg, u64 idx)
>> +{
>> +	u64 evmask = kvm_pmu_evtyper_mask(vcpu->kvm);
>> +	u64 val = p->regval & evmask;
>> +
>> +	__vcpu_sys_reg(vcpu, reg) = val;
>> +
>> +	if (idx == ARMV8_PMU_CYCLE_IDX)
>> +		write_pmccfiltr(val);
>> +	else if (idx == ARMV8_PMU_INSTR_IDX)
>> +		write_pmicfiltr(val);
>> +	else
>> +		write_pmevtypern(idx, val);
>> +}
>> +

> How are you preventing the VM from configuring an event counter to count
> at EL2?

I had thought that's what kvm_pmu_evtyper_mask() did since masking with
that is what kvm_pmu_set_counter_event_type() writes to the vCPU register.

> I see that you're setting MDCR_EL2.HPMD (which assumes FEAT_PMUv3p1) but
> due to an architecture bug there's no control to prohibit the cycle
> counter until FEAT_PMUv3p5 (MDCR_EL2.HCCD).

I'll fix that.

> Since you're already trapping PMCCFILTR you could potentially configure
> the hardware value in such a way that it filters EL2.

Sure.

>>   static bool access_pmu_evtyper(struct kvm_vcpu *vcpu, struct  
>> sys_reg_params *p,
>>   			       const struct sys_reg_desc *r)
>>   {
>> @@ -1063,7 +1084,9 @@ static bool access_pmu_evtyper(struct kvm_vcpu  
>> *vcpu, struct sys_reg_params *p,
>>   	if (!pmu_counter_idx_valid(vcpu, idx))
>>   		return false;

>> -	if (p->is_write) {
>> +	if (kvm_vcpu_pmu_is_partitioned(vcpu) && p->is_write) {
>> +		writethrough_pmevtyper(vcpu, p, reg, idx);

> What about the vPMU event filter?

I'll check that too.

>> +	} else if (p->is_write) {
>>   		kvm_pmu_set_counter_event_type(vcpu, p->regval, idx);
>>   		kvm_vcpu_pmu_restore_guest(vcpu);
>>   	} else {
>> --
>> 2.49.0.1204.g71687c7c1d-goog


> Thanks,
> Oliver

