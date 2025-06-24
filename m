Return-Path: <linux-kselftest+bounces-35713-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 403C5AE704A
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 22:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E85A71BC3C73
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 20:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CFF2EA145;
	Tue, 24 Jun 2025 20:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pLoSu/cb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DA22E92CC
	for <linux-kselftest@vger.kernel.org>; Tue, 24 Jun 2025 20:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750795504; cv=none; b=JUk1ZgPRY0JrpGh1K0Y4okFTVMabLfPWAdZshNNGSjcHSF/yFVtFShPH4wOpdsXS0QFaV9ExZ+J5AUB9E0ge++xcs6jLaDITFGci6jjiCe/D2KerfouwiXE753tc8lmaS8/VS4emXMBBjiyr4K9tpid/M6JWlkXP70nI8tE+6hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750795504; c=relaxed/simple;
	bh=f/D0i2v6lCewKUJtGBKR3xLCM9Mzx3OhGJfQ80nZptI=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=llF/9dWg4t81rcmuga4mTC8IHzmF+nyR8odCDFQ7l/8cJ5UN0euuz4dKJJE/4MQaKPcW0oIsuRVQCyIaoUmlB9wlzxHMBffJRRmXMFSZqmfeZq5UwML48BKKa/8m0KiTWaZQ+/9j6UglHmu6SGohlhoMtz+tmCGn2/KB6qYezw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pLoSu/cb; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3ddbd339f3dso9876305ab.0
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Jun 2025 13:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750795501; x=1751400301; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pP2HWMoMCKbdHfq9EmswNyKqb25oMjrzzlNWwJCxpig=;
        b=pLoSu/cbj3AzQjCsa5iDJqdzTYjjfxBizollD1c+u673fbD6CwxdEWDuSw3JmBfG3d
         4cEchzEUxBvYa5GcADG5FH9HJELPcBZHuokl3eGrh4F7/xk/X7zo31KKTB1e1WEenqmA
         8M5pBTh09kcx01h6/Q4lUlI1+rM/pUhKGQAKFQZ36zkRuCOQ6P7FmghQgGnBJNGAtKHE
         /IihjJ7d9hMQjo0WXWg98gyfkI2TIw26vmIN4BVaP3jhifDeiRobHn3d7tZyYS8bSoQm
         spTGHNjOWA4erTiuACbGBRT/0e2NU7YzuwriCLOwDPzuGWum0wI1nNfP/TdmX54B5nVi
         uj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750795501; x=1751400301;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pP2HWMoMCKbdHfq9EmswNyKqb25oMjrzzlNWwJCxpig=;
        b=VTC9OU6eroSXbiXSooAD2E2m7NfxbLa+P1I1jRPQVAJgiKylH9rzwyUS+TecUlICdV
         5eh/uWZpOQEwL88QE+mW1QnE5XsZZaaolqvZhJOWHFtnUkMuNBGlKJb4/nldGV5leVtD
         rIEGWCsdpURp91Rg+ewlBEtLrbW997e4nAv7zDjlrI7MruMBb+WVKX5JQePd6zJYH4SS
         tCk0On9V28EdypoQFNyMP+E+GBqm7YbBKroERN11onHY981S2rrynlUzKfIwJmvJ3rYP
         49aKM5Ta9PHsUCjjHzRSqzAQ9tBL2mXpR5BhRPs6AIj0aKG4GjuTGOJbYWnKp8Ug8tqV
         XF3g==
X-Forwarded-Encrypted: i=1; AJvYcCU9XxycxLQnxxyL8/8Z1tCAJAjmHMm9FmSJxLy06Y/Li9ukL0Cfmb9hqcNEixNNE31h/EQF117WKwwjL0oS1EU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLu8KQwT+DTM5kHtACAX0s8y0PBFCV4vqqzJbYtsHmVNHy0jSF
	f1bpC7kGzubHst1MjkXM3Hlutp8PBaD/tscYdLSrB83ydXhXgZxTSxs3G/kZu2gGG5BKDA9uchl
	9hF/x5E1IYMuWuBqyWQbqhwcueQ==
X-Google-Smtp-Source: AGHT+IEpwXEjWcAkbmXUn25NbkOypFqMgOZS4LSaytEWOm4lY0osguKw8gnkLrqXfYVp9g/tkoRSIDkKJowW6gl+SA==
X-Received: from ilff3.prod.google.com ([2002:a05:6e02:5e03:b0:3dd:a3df:9d57])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:190a:b0:3dd:d90a:af30 with SMTP id e9e14a558f8ab-3df329364f2mr5932045ab.10.1750795501770;
 Tue, 24 Jun 2025 13:05:01 -0700 (PDT)
Date: Tue, 24 Jun 2025 20:05:00 +0000
In-Reply-To: <aFpOI7cWTOAIjNjV@linux.dev> (message from Oliver Upton on Tue,
 24 Jun 2025 00:05:07 -0700)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntecv8aosz.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v2 07/23] perf: arm_pmuv3: Introduce method to partition
 the PMU
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

> On Mon, Jun 23, 2025 at 06:26:42PM +0000, Colton Lewis wrote:
>> Oliver Upton <oliver.upton@linux.dev> writes:

>> > On Fri, Jun 20, 2025 at 10:13:07PM +0000, Colton Lewis wrote:
>> > > For PMUv3, the register field MDCR_EL2.HPMN partitiones the PMU
>> > > counters into two ranges where counters 0..HPMN-1 are accessible by
>> > > EL1 and, if allowed, EL0 while counters HPMN..N are only accessible  
>> by
>> > > EL2.

>> > > Create module parameters partition_pmu and reserved_guest_counters to
>> > > reserve a number of counters for the guest. These numbers are set at
>> > > boot because the perf subsystem assumes the number of counters will
>> > > not change after the PMU is probed.

>> > > Introduce the function armv8pmu_partition() to modify the PMU  
>> driver's
>> > > cntr_mask of available counters to exclude the counters being  
>> reserved
>> > > for the guest and record reserved_guest_counters as the maximum
>> > > allowable value for HPMN.

>> > > Due to the difficulty this feature would create for the driver  
>> running
>> > > at EL1 on the host, partitioning is only allowed in VHE mode. Working
>> > > on nVHE mode would require a hypercall for every counter access in  
>> the
>> > > driver because the counters reserved for the host by HPMN are only
>> > > accessible to EL2.

>> > > Signed-off-by: Colton Lewis <coltonlewis@google.com>
>> > > ---
>> > >   arch/arm/include/asm/arm_pmuv3.h   | 10 ++++
>> > >   arch/arm64/include/asm/arm_pmuv3.h |  5 ++
>> > >   drivers/perf/arm_pmuv3.c           | 95  
>> +++++++++++++++++++++++++++++-
>> > >   include/linux/perf/arm_pmu.h       |  1 +
>> > >   4 files changed, 109 insertions(+), 2 deletions(-)

>> > > diff --git a/arch/arm/include/asm/arm_pmuv3.h
>> > > b/arch/arm/include/asm/arm_pmuv3.h
>> > > index 2ec0e5e83fc9..9dc43242538c 100644
>> > > --- a/arch/arm/include/asm/arm_pmuv3.h
>> > > +++ b/arch/arm/include/asm/arm_pmuv3.h
>> > > @@ -228,6 +228,11 @@ static inline bool kvm_set_pmuserenr(u64 val)

>> > >   static inline void kvm_vcpu_pmu_resync_el0(void) {}

>> > > +static inline bool has_vhe(void)
>> > > +{
>> > > +	return false;
>> > > +}
>> > > +

>> > This has nothing to do with PMUv3, I'm a bit surprised to see you're
>> > touching 32-bit ARM. Can you just gate the whole partitioning thing on
>> > arm64?

>> The PMUv3 driver also has to compile on 32-bit ARM.

> Quite aware.

>> My first series had the partitioning code in arch/arm64 but you asked me
>> to move it to the PMUv3 driver.

>> How are you suggesting I square those two requirements?

> You should try to structure your predicates in such a way that the
> partitioning stuff all resolves to false for 32 bit arm, generally. That
> way we can avoid stubbing out silly things like has_vhe() which doesn't
> make sense in the context of 32 bit.

Okay. I will do that. When I was reworking it I thought it looked weird
to have the predicates live in a different location than the main
partitioning function.

>> > > +static bool partition_pmu __read_mostly;
>> > > +static u8 reserved_guest_counters __read_mostly;
>> > > +
>> > > +module_param(partition_pmu, bool, 0);
>> > > +MODULE_PARM_DESC(partition_pmu,
>> > > +		 "Partition the PMU into host and guest VM counters [y/n]");
>> > > +
>> > > +module_param(reserved_guest_counters, byte, 0);
>> > > +MODULE_PARM_DESC(reserved_guest_counters,
>> > > +		 "How many counters to reserve for guest VMs [0-$NR_COUNTERS]");
>> > > +

>> > This is confusing and not what we discussed offline.

>> > Please use a single parameter that describes the number of counters  
>> used
>> > by the *host*. This affects the *host* PMU driver, KVM can discover  
>> (and
>> > use) the leftovers.

>> > If the single module parameter goes unspecified the user did not ask  
>> for
>> > PMU partitioning.

>> I understand what we discussed offline, but I had a dilemma.

>> If we do a single module parameter for number of counters used by the
>> host, then it defaults to 0 if unset and there is no way to distinguish
>> between no partitioning and a request for partitioning reserving 0
>> counters to the host which I also thought you requested. Would you be
>> happy leaving no way to specify that?

> You can make the command line use a signed integer for storage and a
> reset value of -1.

> -1 would imply default behavior (no partitioning) and a non-negative
> value would imply partitioning.

Good idea. I thought of that solution myself for the first time after I
logged off yesterday. Slightly embarrassed I didn't see it sooner :(

>> In any case, I think the usage is more self explainatory if
>> partitition=[y/n] is a separate bit.

> What would be the user's intent of "partition_pmu=n  
> reserved_guest_counters=$X"?

That doesn't make sense, which is a decent argument for using just one
parameter. I'm now fine with going back to just reserved_host_counters.

