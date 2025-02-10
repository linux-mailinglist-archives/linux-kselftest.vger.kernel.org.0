Return-Path: <linux-kselftest+bounces-26264-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898EEA2FE2F
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 00:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AD69160752
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 23:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60ADB25EFA5;
	Mon, 10 Feb 2025 23:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WTM6Kw6O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819782586FA
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 23:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739228878; cv=none; b=eu6C9H+1KwfLa2iZTlIANUVKvROWu/QOxO5s9gdxEALqyxuqu4x6TmtrR8XGvqiOCuyb3kSdyWkiDQ4nBC0TxkXuR7CrNIwaceY979x8Gk4jJ3Kd6V5xIJJabFyMoNWGYpWfkPQU3m/jyLecMnRHGAqUPZsZCW2oj8ksbgR1Bx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739228878; c=relaxed/simple;
	bh=AxQ0BatG3tWnwllw3i3I8ZpefXtmDeo0wa5eJwy1kCw=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=R0Pc5m8BcUyctreSQiTakZKnHU3mDxnCLzVVjbwSEFfH8CxbfckEdinFDwAeRmdESPb9qOlvDFu5D7ydpvgyy59tdotAuZZZJQPYSi6pR4tR2Wu0AiZy4uAR9ieVcxcbIZiyEWZySSjlLeOtk4WJ8YO2vbCP8VuC9FmapMG3tHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WTM6Kw6O; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3ce81a40f5cso95692545ab.1
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 15:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739228876; x=1739833676; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NzOtRn06dmJeLMt6lIohnur0KCLnTsq8EA/pFJWvUPc=;
        b=WTM6Kw6Oq/0/pFVlJhgSfg25VRe4w318dx3x3tDoY5irJ3qYxQxm1BqBuZqYetjgaD
         bO1tl5Om6YGrtqRNLP2icuDGBpJTujwGiNrwtdltyfX4A8oTkpZQgP8Px/fcIs5Xu1tW
         B+O6HbR4YXXJs10k558a1MAQP9SLczBOhItOSULb5rYzk6iGyYyCSh+0L8cvaOKAaYMY
         pqja/JCY5j2J3Po3WB2Eg/BFF71bXnUxqaxvmTG7+/seqTpH3BYB0IOTMypkHfxD49Tk
         SgLQJ6nhWP76uS92hfitTS+qYrWLAUByUyVjOelDuXhluZNmAumHUbkuz75BD7AtrYJ8
         3wCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739228876; x=1739833676;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NzOtRn06dmJeLMt6lIohnur0KCLnTsq8EA/pFJWvUPc=;
        b=nD0M1NeYVu01LDQybSE/hYBZO2OLFBHMVIGdN0q9uEg1Lyd/5rztx/t6XG+I9KTGqM
         p/5yVXGuR4L+qRsuP4d2W8JSnhIRcr504G5P82LII4gsxmopuiFh42+YywZKIgNB/izp
         iNm9/YfsEpGd8BKZ2NgMT05BK10ocPdKj3lA80vuZaYrNP4FmAHYAdFbff9T6eEx31QP
         3Q7pVBdaA/zpYzPi5hbwExP3vgUqQpP7zsXaCoe5kGgQYsTFZwluDyjvx2kObqu2hxp+
         Ywsck/3Wk7zBn0jkrEVSMEDd0DZbfL+/YDwcDDS9UAgNxOPh1ElMgHd2EzY+4ct+LtfQ
         7qQA==
X-Forwarded-Encrypted: i=1; AJvYcCVcvuR0+kRLWXXh7chnzpAl0Htumx023uGY8zu8bpCOy8Y9ImkL+5TWrQuRg6bO2hWI3HJ9DAAxfUFmyk92LsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTOruxM2tSCUknTIkiCAoyIhD9BiSQmlngkA0jHkbVyab1u4bl
	Lc507oKvP8fKBMDgxY9cJ6zOE0vQ2bbXqhXI5se2Rfy7Es9agsF2Zv+0Nw9wFawRsBWHsxAGT0Y
	gMAAwacqDxgdVj8AOyuUf2g==
X-Google-Smtp-Source: AGHT+IEYUiomyuN/bGInuZpdaF2fRRM/BetqkFJjxK+LoWD1u4DPDFiIADjLJWFWyB1MEsSvhotxG42I2ZAf1MOJBQ==
X-Received: from ilbbn13.prod.google.com ([2002:a05:6e02:338d:b0:3d0:23fd:8ce4])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:481c:b0:3cf:b626:66c2 with SMTP id e9e14a558f8ab-3d13df546c4mr121244895ab.19.1739228875706;
 Mon, 10 Feb 2025 15:07:55 -0800 (PST)
Date: Mon, 10 Feb 2025 23:07:54 +0000
In-Reply-To: <Z6mp4NeklzORJg5y@linux.dev> (message from Oliver Upton on Sun, 9
 Feb 2025 23:25:20 -0800)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntfrkl1jqt.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [RFC PATCH v2 2/4] perf: arm_pmuv3: Introduce module param to
 partition the PMU
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

> Hi Colton,

> On Sat, Feb 08, 2025 at 02:01:09AM +0000, Colton Lewis wrote:
>> For PMUv3, the register MDCR_EL2.HPMN partitiones the PMU counters
>> into two ranges where counters 0..HPMN-1 are accessible by EL1 and, if
>> allowed, EL0 while counters HPMN..N are only accessible by EL2.

>> Introduce a module parameter in the PMUv3 driver to set this
>> register. The name reserved_host_counters reflects the intent to
>> reserve some counters for the host so the guest may eventually be
>> allowed direct access to a subset of PMU functionality for increased
>> performance.

>> Track HPMN and whether the pmu is partitioned in struct arm_pmu
>> because KVM will need to know that to handle guests correctly.

>> While FEAT_HPMN0 does allow HPMN to be set to 0, this patch
>> specifically disallows that case because it's not useful given the
>> intention to allow guests access to their own counters.

> Quite the contrary.

> FEAT_HPMN0 is useful if userspace wants to provide a vPMU that has a
> fixed cycle counter w/o event counters. Certain OSes refuse to boot
> without it...

Cool. I'll make sure writing 0 is allowed if we have FEAT_HPMN0.

>> static inline u32 read_mdcr(void)
>> {
>> 	return read_sysreg(HDCR);
>> }

>> static inline void write_mdcr(u32 val)
>> {
>> 	write_sysreg(val, HDCR);
>> }


> Hmm... While this fixes the 32bit compilation issues, it opens a new can
> of worms.

> VHE is a 64bit only feature, so you're *guaranteed* that these accessors
> will undef (running at EL1).

True. I mentioned in the cover letter they aren't intended to actually
run in the PMU driver because I guard for VHE there.

>> +static void armv8pmu_partition(u8 hpmn)
>> +{
>> +	u64 mdcr = armv8pmu_mdcr_read();
>> +
>> +	mdcr &= ~ARMV8_PMU_MDCR_HPMN;
>> +	mdcr |= FIELD_PREP(ARMV8_PMU_MDCR_HPMN, hpmn);
>> +	/* Prevent guest counters counting at EL2 */
>> +	mdcr |= ARMV8_PMU_MDCR_HPMD;
>> +
>> +	armv8pmu_mdcr_write(mdcr);
>> +}
>> +

> After giving this a read, I don't think the host PMU driver should care
> about MDCR_EL2 at all. The only time that 'guest' events are loaded into
> the PMU is between vcpu_load() / vcpu_put(), at which point *KVM* has
> reconfigured MDCR_EL2.

> I'm not sure if there's much involvement with the host PMU driver beyond
> it pinky-swearing to only use the specified counters. KVM is what
> actually will program HPMN.

> That'd alleviate the PMU driver from having VHE awareness or caring
> about MDCR_EL2.

That does seem like a cleaner solution. I can lift that handling into
KVM code, but I will still need the variables I introduced in struct
arm_pmu to be populated so the driver knows what counters to use.

Without looking, I'm concerned there might be an initilization ordering
issue with that where KVM will get the value for HPMN first because it's
initialized first but then can't store them somewhere accessible to the
driver because the driver hasn't been initialized yet. Then the driver
is initialized and used without knowing HPMN and is now using counters
we wanted the guest to have.

There is probably an easy way around this, but I'll need to do some
digging.

