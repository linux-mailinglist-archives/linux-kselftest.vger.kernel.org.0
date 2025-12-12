Return-Path: <linux-kselftest+bounces-47534-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F6ACB9E36
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 22:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2E2A630022DB
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 21:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CE22BEC43;
	Fri, 12 Dec 2025 21:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hk1b9Oka"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAF63C38
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 21:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765575109; cv=none; b=f/HTLGK7/e0aCIRYMs8k37zxQbH/rG6whmlPj9ilU0IujFtoaXC1dKt6W8yQZ2qA4T47bRZ3DA8B+A1eX0UWZgYJcrkZOd2JGbh61eaYI7LbWSUW7TguaAvEsua+mZTNdNDtrAQ6GVFkC+GUlujzGMUFwR+vgj9SaOkwyRNp6LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765575109; c=relaxed/simple;
	bh=3l391GJrmu2vQ09ks1w9jqj02asnWMy1KuP+zG+MYE8=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=IoslbgtvD/T5gX5bUse2Rb51cdXgsLUhFqvHMDTewyJo3j8cXPQajphDct2cFbNGLlK2r0Ekbf1P9DnXv9pjyI5DvvQ0KRK50oGl33lwUDyTqovK4oJ6vGOHg5xq6LzdIvJC8nYTQqe5ZRYHfuofRE12CPxfKm1cICC6qE5nQQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hk1b9Oka; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-65b325457e5so1404116eaf.1
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 13:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765575107; x=1766179907; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=glFaNkoh8KYWfLmCHCO0uc2mAujAPglg5i0xIpFSAo0=;
        b=hk1b9OkaTy0jH0areGNc5MtVgIsBr1tvlB6B+oYYp62wrWQGKJxB5fz2OONee2yCRP
         /7erfVNrLWULLU+l/OWF87ANVd87fGMuTW7ytWJJsh+9kvZ47biyboFrgO/gxP3HFwbN
         pnX6i/cbeQGFKeXCmglQrvTrPFvdSvzQD3MIKrZqwSoClNBjWGqjyXG7TeB55FzxFwkC
         K3RJ5QQo23RCAt11E1XZYJAcYXSFaPpgl/D5Ow53Ef/xUBUT1zygid5sfUyCjCzJqfQn
         9H5jVARE0+8ZUFwbPoXDtF8lrIzo/BOVMYmcIwkyIW7EMC0lAb9K+PiBc0AInMXheUa0
         RL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765575107; x=1766179907;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=glFaNkoh8KYWfLmCHCO0uc2mAujAPglg5i0xIpFSAo0=;
        b=MSHu/WFBKO3jK4KG1M++hie1Ky9svKwf/pp8adscsHzv6NzLMyQVqzkSdRD3Zkm9NI
         zepNA18Qp2pAUGMSroF4Z3OwexwDt0vZVXP18L9QD+k/8Wd+cMK+POjDpiiOJ0xb7lO7
         3Oxlb7dAAXT4nLLhYfmOubt8fuY/4uC0Zzt5kT6jGluiXTuj+X7bAeATZKEAx9DGc5c9
         5/vxYd2IFj86sNhgXxhkVHqp3pdYeCDfD1RRGnAg9YliQzkx4VgeSw7ipP8RkUw/X+pq
         kQwCzhXVgoVAIeJHrYtke+DFsJmalo5A2Ruzm+FQYSnuMYXwG3tA+hMEH1qCiEOkP0HY
         QNoA==
X-Forwarded-Encrypted: i=1; AJvYcCXJ8ODpLFNuxgcM/NBrOzmaQ4pqaAuj/mVig8KfcEyPKvnSWqlb/FPQ4wzkhLIjqJI3qS+9EDjErU3bS4ZKKR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwduKmkE1GURnUNgzzEhrCFmT2efYDeA4A+s7/rqAYlOHrOVgpL
	ZaP4Ymh3mpbtsGCR7dVvPvsj7UbZFl1X4pL6pULAWyjGQH4nxsOEMuDFiMEYqr3QXL7F6W4uRpS
	AwRdWgo6EWqATwFTaTJC2Bbnzkw==
X-Google-Smtp-Source: AGHT+IFo/ZiQG26nv5+gQHvcotb1AIOm/8xhz9dzc9kzbBKDKtRIGeh0RuPM+qweY1hUtH68Xze57kOA5qfLCql13A==
X-Received: from ilbbb16.prod.google.com ([2002:a05:6e02:10:b0:42f:913a:9596])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:1b0f:b0:659:9a49:8e83 with SMTP id 006d021491bc7-65b452c3646mr1638400eaf.83.1765575106969;
 Fri, 12 Dec 2025 13:31:46 -0800 (PST)
Date: Fri, 12 Dec 2025 21:31:46 +0000
In-Reply-To: <aTiWsAvK9krnEw7V@kernel.org> (message from Oliver Upton on Tue,
 9 Dec 2025 13:37:52 -0800)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntms3n2xq5.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v5 16/24] KVM: arm64: Account for partitioning in PMCR_EL0 access
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

> On Tue, Dec 09, 2025 at 08:51:13PM +0000, Colton Lewis wrote:
>> Make sure reads and writes to PMCR_EL0 conform to additional
>> constraints imposed when the PMU is partitioned.

>> Signed-off-by: Colton Lewis <coltonlewis@google.com>
>> ---
>>   arch/arm64/kvm/pmu.c      | 2 +-
>>   arch/arm64/kvm/sys_regs.c | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)

>> diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
>> index 1fd012f8ff4a9..48b39f096fa12 100644
>> --- a/arch/arm64/kvm/pmu.c
>> +++ b/arch/arm64/kvm/pmu.c
>> @@ -877,7 +877,7 @@ u64 kvm_pmu_accessible_counter_mask(struct kvm_vcpu  
>> *vcpu)
>>   u64 kvm_vcpu_read_pmcr(struct kvm_vcpu *vcpu)
>>   {
>>   	u64 pmcr = __vcpu_sys_reg(vcpu, PMCR_EL0);
>> -	u64 n = vcpu->kvm->arch.nr_pmu_counters;
>> +	u64 n = kvm_pmu_guest_num_counters(vcpu);

> Why can't the value of vcpu->kvm->arch.nr_pmu_counters be trusted?

Similar to discussion on a previous patch, I need to move some
validation to the ioctl where it's set.

>> @@ -1360,7 +1360,7 @@ static int set_pmcr(struct kvm_vcpu *vcpu, const  
>> struct sys_reg_desc *r,
>>   	 */
>>   	if (!kvm_vm_has_ran_once(kvm) &&
>>   	    !vcpu_has_nv(vcpu)	      &&
>> -	    new_n <= kvm_arm_pmu_get_max_counters(kvm))
>> +	    new_n <= kvm_pmu_hpmn(vcpu))
>>   		kvm->arch.nr_pmu_counters = new_n;

> This is the legacy UAPI for setting the number of PMU counters by
> writing to PMCR_EL0.N.

> The 'partitioned' implementation should take a dependency on the
> SET_NR_COUNTERS attribute and reject attempts to change the value of
> PMCR_EL0.N. Just like nested.

Good! I hated making writes to PMCR_EL0.N work and only did it because
of selftests assuming it did.


> Thanks,
> Oliver

