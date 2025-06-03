Return-Path: <linux-kselftest+bounces-34248-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7965BACCE7E
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 22:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398443A72ED
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 20:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47B422F164;
	Tue,  3 Jun 2025 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YcuM4k25"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7AD223321
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Jun 2025 20:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748983833; cv=none; b=H2iQ0THJNISLCTk1UU5hd8sXQXa6XWRBqG6OT1yeZME4q1P6qgYtNIUnjBBysFDhcAb6i1Ignt9HrNc+OqDngugeykXiZud6/RxPZcBvpko0xVbx7+jviJkfXAvCjhfy5LET97Tt5DJgdxZy5QwPC3u2ttEghaHZi7u9Kenrdw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748983833; c=relaxed/simple;
	bh=1ORI/LqUz7dCfdMO8958T7FDJ2un7M0ICUmDzX9c648=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=a56CpYFimDRhJBbia9kvxBsuT3wvP1j79iX4cOkj8aX8w6IgK7uYnAXqBtWBPwj9QPyLa0J9nhxjVE5d1poFlhWzMIf9fpn8HRvUz2V83PkTkNSZeF2bp1bqAYBBgTvq296aUsuVMFdRulkU6lX1/3AMiV47QFVSNPpcgO2bnIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YcuM4k25; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3ddba1b53e8so14457415ab.1
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Jun 2025 13:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748983829; x=1749588629; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3lsZMwRkh1UP98Tqde8+akeySm6v1iX6h0YAqQdmB3c=;
        b=YcuM4k258VOoTUTtX3F6tKlcsHIW3zUABRKNQ1wIuT2QVJraLplTNEhb1+2gwLsYWW
         X1damSvVhKSOfVO85yIyumHXXgLaqL+dRaDl6eOsbIYq0e/zonT3mlEM7PKu/H0CxV45
         BnwjzD1RfURGe9gvZJfpwHKO5OdlODjRRHbp/uvMP664pZYzcNcznWmUN4gUxxkeFeXO
         MAkx80NesSRyHSyWkJtCCQboiQjBo+lz1qR+cAr4wrQD9aHGGwgqt53qox8NcU3F955e
         DM7jYbRx9wBlwK5DHo7ZY16vE8VaknazUbE4Y+ibI+yLXEkw7DcYwUxMyAq3OcBMoHlQ
         rI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748983829; x=1749588629;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3lsZMwRkh1UP98Tqde8+akeySm6v1iX6h0YAqQdmB3c=;
        b=ArSRpdudRdqGjAfDcdjaIBnP9iwptv6XfR9YpoWr7LxfDWZhSlg36ZN5o8zqXFNXgd
         1gW7v0ybEH179KFDpbysxGxWFLyT0EYSZWX+oXOIVzLItq4IcXghU2qDuNySA+5s8GJt
         dYx/G3B+yX0uInOTkpR9RSqDwFpUgBOC20RrxTkmY3W7QlDeeiXHFxPq6jjCzTEK4q3A
         Q7PwW6BklPbecekkx8tOtcBVxS+dYAYsTE53Gn5TYZ2zEF5EYGKy4MRIIrJzp+mRGSRC
         /9zU8EDOiMZYC03C44RZsGcmKbcdnWrAqauYH/5vDg22ztipMRAE2Zs/KZxV0U9S9K+x
         8WcA==
X-Forwarded-Encrypted: i=1; AJvYcCU5d3YG31UXVDU/EsltyiiR98oETNkEW3MozOHe6Oj84imO1cRLU8Z6uEv+748b2zbbfbZ2bZJdU7onFMdAs5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJZqfBsAz2uSilkPp5A7AKUvCeimQwOF00iNSJPZ8QPvfsbmPP
	+jKQS/hyQHb6Vpxz7E4JnQ5FWzjmrEhmcbMk+bNlhFYuvmwVKxJhMbMEpFadOZPeBwM/FqgBdoq
	SISDd0ZnZNK1FE6MelaHgj6xTQA==
X-Google-Smtp-Source: AGHT+IE8lcweOrXzv1dJ7JnXQujzAi86ZbFeivqiLkC8HSJs78PXh7Mwa8lRBkCmnRTpW9aZv5V6w/tu2G1Ilng5MA==
X-Received: from ilbbf2.prod.google.com ([2002:a05:6e02:3082:b0:3dd:a279:72c1])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:1807:b0:3dc:8b29:30bc with SMTP id e9e14a558f8ab-3ddbedbef4cmr5429525ab.21.1748983829547;
 Tue, 03 Jun 2025 13:50:29 -0700 (PDT)
Date: Tue, 03 Jun 2025 20:50:28 +0000
In-Reply-To: <aD4ijUaSGm9b2g5H@linux.dev> (message from Oliver Upton on Mon, 2
 Jun 2025 15:15:41 -0700)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsnt7c1s35yj.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH 01/17] arm64: cpufeature: Add cpucap for HPMN0
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

Hi Oliver. Thanks for the speedy response.

Oliver Upton <oliver.upton@linux.dev> writes:

> Hi Colton,

> On Mon, Jun 02, 2025 at 07:26:46PM +0000, Colton Lewis wrote:
>> Add a capability for FEAT_HPMN0, whether MDCR_EL2.HPMN can specify 0
>> counters reserved for the guest.

>> This required changing HPMN0 to an UnsignedEnum in tools/sysreg
>> because otherwise not all the appropriate macros are generated to add
>> it to arm64_cpu_capabilities_arm64_features.

>> Signed-off-by: Colton Lewis <coltonlewis@google.com>
>> ---
>>   arch/arm64/kernel/cpufeature.c | 8 ++++++++
>>   arch/arm64/tools/cpucaps       | 1 +
>>   arch/arm64/tools/sysreg        | 6 +++---
>>   3 files changed, 12 insertions(+), 3 deletions(-)

>> diff --git a/arch/arm64/kernel/cpufeature.c  
>> b/arch/arm64/kernel/cpufeature.c
>> index a3da020f1d1c..578eea321a60 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -541,6 +541,7 @@ static const struct arm64_ftr_bits ftr_id_mmfr0[] = {
>>   };

>>   static const struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
>> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE,  
>> ID_AA64DFR0_EL1_HPMN0_SHIFT, 4, 0),
>>   	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE,  
>> ID_AA64DFR0_EL1_DoubleLock_SHIFT, 4, 0),
>>   	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE,  
>> ID_AA64DFR0_EL1_PMSVer_SHIFT, 4, 0),
>>   	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE,  
>> ID_AA64DFR0_EL1_CTX_CMPs_SHIFT, 4, 0),
>> @@ -2884,6 +2885,13 @@ static const struct arm64_cpu_capabilities  
>> arm64_features[] = {
>>   		.matches = has_cpuid_feature,
>>   		ARM64_CPUID_FIELDS(ID_AA64MMFR0_EL1, FGT, FGT2)
>>   	},
>> +	{
>> +		.desc = "Hypervisor PMU Partitioning 0 Guest Counters",

> nit: just use the the FEAT_xxx name for the description (i.e. "HPMN0").

Okay

