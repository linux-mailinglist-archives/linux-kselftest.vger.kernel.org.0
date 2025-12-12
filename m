Return-Path: <linux-kselftest+bounces-47540-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6230ACB9FDC
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 23:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D6143002896
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 22:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE9D2F8BC8;
	Fri, 12 Dec 2025 22:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EREG08Bp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f73.google.com (mail-ot1-f73.google.com [209.85.210.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E142EBB96
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 22:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765580109; cv=none; b=kT2pq/HGtkeCv9ik+grP5HWRPQ1/eV76v9GJZQL9ouOkC95fOiLdXIlabwO3V4B6jcmzO5TzxjxCKy69dNIuMefzA2MsH2sNa3BYcA+U2/ACveoIqR7u/EFlHoBVpxsCFVsphgx878iqW0EbYHrFa4asr8QYC7S3KgJJFqVOPdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765580109; c=relaxed/simple;
	bh=bIF6Bo2epqbYmITgIckR0PAV4EA02NE1jjQfw25p3QM=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=qtdxH8rTgaGQ9q3WY58E0ykaHAU8E8fxp6NUiOcxhMyvLwKIReZS9dlN0CgDIgCupKckseTN4TJ0f3kxjXOSo2YyCZbZhI3c2DHpKdbv3WRrR61Vv1u7pYpI1vQe/KCVy7s66YKXaR3jD1hMJ1K63l4JJqvmDkvCtam1EHpoJ80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EREG08Bp; arc=none smtp.client-ip=209.85.210.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-ot1-f73.google.com with SMTP id 46e09a7af769-7c702347c6eso1829473a34.1
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 14:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765580107; x=1766184907; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gf9nzt/AIijA0v6SQzCygaqS4FyyvskIif7ML2SRzkU=;
        b=EREG08BpDYUwlqkunNMgj89aVsu2u/3cqMutBwf/mxNlJc7m75YWxicoBReFcn4VX3
         ELIqjdcHXYbmwBlJn92PhBx/2RTE6HgnR5to2q0vaLLA+BuOjRxMHSRGCQCG8Q5kEgZf
         Ehii7IxEXPQ1TGn+Uu1HD6xZhDGSC5+keBq1DM23vhFrkwvZd+1kCs5O+n9gd3XLOXC8
         2v5gv5tRYEEGPXdPcqgQZcovwIvEgMa/syG8KpC1+VBJg4MOC3Cdb8YjtEA9pgsaTDiO
         RnbZ9KrraydttPIu9M2llTDE4C/vG3yQDR5PMcly/K3PbBLYqptCLbvY95QOtDZYERJ1
         jUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765580107; x=1766184907;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gf9nzt/AIijA0v6SQzCygaqS4FyyvskIif7ML2SRzkU=;
        b=oJSaPV6NWi8lf1igfZxDu4HtN2K9B3wKkFDXRshPUFRXc5/GxAE+flrlGSMl44UQ83
         NpfDWrQCRGaAToVLr9O+zHTACfw9v5TZy59rm1Ijt2jyUwHhshoz2y98OY9UdG9jkzcE
         xmHfsa8EmGzD5DBbpt51eNC6jMT7pOgKc1lJl/V2INsHdhO8g9cpSi/luAlZfvhE7nxq
         SDX2xaxH4dvQriMCLsFqI0fERneAuJFH1jrVnHApTvEU9FRxV+zftR49MpgUOGU10vi+
         yGUwHKGkdnVmfFu2QSmAxj+77qQWd7WaCkGwU2is9Aqnczg662UfEMq4WHgSRg1q2Rrm
         j26g==
X-Forwarded-Encrypted: i=1; AJvYcCUW/yog0GMvNxykslJGlPjoRTkz2J+7hiYNLX7IQ+ZalGDmAP+nJ8cvmxMPcv5BqKdvC4auV5uJaho9Lw21hqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyHe89FclOFUNoRdAIPo6CsUaMi7DfW8l/fjI5+FuZ8i5OLbJu
	c6qqm8ATe/f99cA+cEtXQHwr+t2ol85bcnYWNnDnRgm8PffLtkPr53bwlAgRq62Zr87LFGjgNJv
	qFNTMxwkbv4RXQ/j66EoLVRwBvw==
X-Google-Smtp-Source: AGHT+IGW0I1EN/TmF7XRt1Ne1xEDcpx6Or2Kw9UCPmMzkWNCsmyBQjelpeiy18twJajc3tFWP5QaNlfD3CTKO6VqfQ==
X-Received: from ilbbd1.prod.google.com ([2002:a05:6e02:3001:b0:438:1345:e9c3])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:162a:b0:65b:25e8:13f1 with SMTP id 006d021491bc7-65b4529af0dmr1939098eaf.73.1765580107018;
 Fri, 12 Dec 2025 14:55:07 -0800 (PST)
Date: Fri, 12 Dec 2025 22:55:06 +0000
In-Reply-To: <aTioEWHu0ZbFCjR6@kernel.org> (message from Oliver Upton on Tue,
 9 Dec 2025 14:52:01 -0800)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsnt8qf72tv9.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v5 21/24] KVM: arm64: Inject recorded guest interrupts
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

> In no situation should KVM be injecting a "recorded" IRQ. The overflow
> condition of the PMU is well defined in the architecture and we should
> implement *exactly* that.

When I say "record" I just meant "updating the virtual overflow register
to reflect an overflow".

Do you think I'm not implementing the condition correctly in
kvm_pmu_part_overflow_status()?

> On Tue, Dec 09, 2025 at 08:51:18PM +0000, Colton Lewis wrote:
>> +/**
>> + * kvm_pmu_part_overflow_status() - Determine if any guest counters  
>> have overflowed
>> + * @vcpu: Ponter to struct kvm_vcpu
>> + *
>> + * Determine if any guest counters have overflowed and therefore an
>> + * IRQ needs to be injected into the guest.
>> + *
>> + * Return: True if there was an overflow, false otherwise
>> + */
>> +bool kvm_pmu_part_overflow_status(struct kvm_vcpu *vcpu)
>> +{
>> +	struct arm_pmu *pmu = vcpu->kvm->arch.arm_pmu;
>> +	u64 mask = kvm_pmu_guest_counter_mask(pmu);
>> +	u64 pmovs = __vcpu_sys_reg(vcpu, PMOVSSET_EL0);
>> +	u64 pmint = read_pmintenset();
>> +	u64 pmcr = read_pmcr();

> How do we know that the vPMU has been loaded on the CPU at this point?

Because this is only called by kvm_pmu_update_state which is only called
by kvm_pmu_update_state <- kvm_pmu_{flush,sync}_hwstate <-
kvm_arch_vcpu_ioctl_run after a vcpu_load.

>> +
>> +	return (pmcr & ARMV8_PMU_PMCR_E) && (mask & pmovs & pmint);
>> +}

> I'd rather reuse kvm_pmu_overflow_status(), relying on the accessors to
> abstract away the implementation / location of the guest PMU context.

Agreed on making some generic accessors.

> Thanks,
> Oliver

