Return-Path: <linux-kselftest+bounces-34337-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB48BACE5A7
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 22:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBD68189B8DE
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 20:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80BF221DBD;
	Wed,  4 Jun 2025 20:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QW3CdoRg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE67111BF
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Jun 2025 20:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749067928; cv=none; b=h9Pu5h0fbaWixplSizpS+xp4YFzRuq3WQzxS6Q2P8GX1K5osb/p7zyPKL4pv/QUOA7gp6eq3poVGn03tPVZ7C287si/txyOtpOtXqZB1RIsvNdDNyIiyfw8pZPl1H9qnzQWu6NFaR4vrzuxzDkAzU4TcTHeDZ3a+dClhQJCJBQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749067928; c=relaxed/simple;
	bh=Yf/iHPu8H60AsxB9qOlBzBCZlW0/bPjuVXhfXOJSwAA=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=I3WkncHn/RWpP8IJtECvs8Oh+jCS42VqVk9O7c7M+mfMfKZT9gHxbgGizYQ3MzZln/SsQmJUf7y8EWW7q1dSIHNF7QPUJVnNFK1NNdmM8yCqtbdr95ueXmqj3r1zocKLfb6MxFEZPksjyVQZ522RDnV0cQG4VKycL6VK7tIXsu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QW3CdoRg; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2e43c3e66d1so318164fac.1
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Jun 2025 13:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749067926; x=1749672726; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l2ZfRBtkCFUyGNfWWgvViMBCRTnEKTD5lF2sn5A9h8E=;
        b=QW3CdoRgS7be6+MpiXVr20xsSl8gq75nvx/SVIA0bhQZvSJzUSG8XdDBSXwtpR1iZi
         PbOP8kAfNSr6FlC/PHJxH/Zo4j2EBysGEmQu+2mF+5zV1s8kGcFulctFNOqt+b5ILSmm
         H4EM06P5uhtiGqGBTdhG27TF+rvUZ7Y++8jqw1b1722O6OrtrUiUyQ3ZY4YYd/A/VKMC
         RzT+O5La9OIuE3R8PKZdlPFUOhvqpDnbFXSVDJRkE3TW4gL04Hul1XG/mYlzQyiO6FZ7
         rV3tgUKhBWX9xt+zKvRwWWv5L5dj1B0Tpa9CI9N4uOteK2QvthW1eym8Nx9yZD7wVh5v
         wgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749067926; x=1749672726;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l2ZfRBtkCFUyGNfWWgvViMBCRTnEKTD5lF2sn5A9h8E=;
        b=LYbgKGHlO2vZ27Sdok5naSGxi+0Wi0loYtO/Vz/vzqv2XJ4t8P7Dgy4lGIAwF3Ivmp
         +Y9y+zSlKdNUdgBPorr2QQWxSijLTqQxnQQpyH5nJjJ4Z1W2diZCCW3yYxkidSqgAetZ
         CbSC/UC+kWrEfeMh4wS96t2nyufVnOnAijdrzKpsiIqz5TZ72G3amUjyeSXvYbV+L+cN
         I2XP4LQQ2oJsUwSUyNSx7UE7sjPjRotL9c6F86R22ZozC0SSRMx2CHD3usJ3dG5H0xMs
         H8CZdg2fCIzpTEI0a5zl/yZW5hIDUbeUtZxWtVZPRDSpiEjJ9AnJboP9wJtrB68PiUkr
         8A6g==
X-Forwarded-Encrypted: i=1; AJvYcCVghB6y5FNjI6n+WMOOO1DuUCraBNFlj6PNtoUVcQJEntN5sJOsfAHFbfTjFUCW9jIMLyVVE2zbBa/b+eDo7AA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcrA15dj+UzB1ub06eqhFJzm8zVj983huRXBk1pk/K+M+dDq3B
	9/2aENm2GStiTRYU4F3dxGsefibfsY4rmSMlKJ2EecRfHLITBEFuHsRBzP5jF7SDYjujTXvlMQH
	wt9vaYMk+HHZ4VliWv8FySV5OQg==
X-Google-Smtp-Source: AGHT+IHnv4E1vDPP/ZiBUn0UZugjQZBj8858Crg/sw9WU1O9tNE8wE+e6qgJBHSzAxiHAj9ZIzvPLqoD1kotwzxLmg==
X-Received: from oabfz25.prod.google.com ([2002:a05:6870:ed99:b0:2e9:175e:cff3])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6871:e716:b0:2d4:e29d:5297 with SMTP id 586e51a60fabf-2e9bfbe153emr3220979fac.29.1749067926258;
 Wed, 04 Jun 2025 13:12:06 -0700 (PDT)
Date: Wed, 04 Jun 2025 20:12:05 +0000
In-Reply-To: <gsnt1ps033ch.fsf@coltonlewis-kvm.c.googlers.com> (message from
 Colton Lewis on Tue, 03 Jun 2025 21:46:54 +0000)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntplfj1d2i.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH 16/17] KVM: arm64: Add ioctl to partition the PMU when supported
From: Colton Lewis <coltonlewis@google.com>
To: Colton Lewis <coltonlewis@google.com>
Cc: oliver.upton@linux.dev, kvm@vger.kernel.org, pbonzini@redhat.com, 
	corbet@lwn.net, linux@armlinux.org.uk, catalin.marinas@arm.com, 
	will@kernel.org, maz@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, mark.rutland@arm.com, shuah@kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

> Oliver Upton <oliver.upton@linux.dev> writes:

>> On Mon, Jun 02, 2025 at 07:27:01PM +0000, Colton Lewis wrote:
>>> +	case KVM_ARM_PARTITION_PMU: {

>> This should be a vCPU attribute similar to the other PMUv3 controls we
>> already have. Ideally a single attribute where userspace tells us it
>> wants paritioning and specifies the PMU ID to use. None of this can be
>> changed after INIT'ing the PMU.

> Okay

>>> +		struct arm_pmu *pmu;
>>> +		u8 host_counters;
>>> +
>>> +		if (unlikely(!kvm_vcpu_initialized(vcpu)))
>>> +			return -ENOEXEC;
>>> +
>>> +		if (!kvm_pmu_partition_supported())
>>> +			return -EPERM;
>>> +
>>> +		if (copy_from_user(&host_counters, argp, sizeof(host_counters)))
>>> +			return -EFAULT;
>>> +
>>> +		pmu = vcpu->kvm->arch.arm_pmu;
>>> +		return kvm_pmu_partition(pmu, host_counters);

>> Yeah, we really can't be changing the counters available to the ARM PMU
>> driver at this point. What happens to host events already scheduled on
>> the CPU?

> Okay. I remember talking about this before.

>> Either the partition of host / KVM-owned counters needs to be computed
>> up front (prior to scheduling events) or KVM needs a way to direct perf
>> to reschedule events on the PMU based on the new operating constraints.

> Yes. I will think about it.

It would be cool to have perf reschedule events. I'm not positive how to
do that, but it looks not too hard. Can someone comment on the
correctness and feasibility here?

1. Scan perf events and call event_sched_out on all events using the
    counters KVM wants.
2. Do the PMU surgery to change the available counters.
3. Call ctx_resched to reschedule events with the available counters.

There is a second option to avoid a permanent partition up front. We
know which counters are in use through used_mask. We could check if the
partition would claim any counters in use and fail with an error if it
would.

