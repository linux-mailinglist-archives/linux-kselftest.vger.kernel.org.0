Return-Path: <linux-kselftest+bounces-24801-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F7BA170F7
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 18:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21DB53A3AB5
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 17:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520F21EBFED;
	Mon, 20 Jan 2025 17:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WguWlmN7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CFE1E9B31
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2025 17:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737392810; cv=none; b=YYvaX76el5r/vaz0h7UBMBc+/bs5Jz9SWRV6B8GIIk4ithUoaJNEXno8QyyzA9gOraOEMjvAo6ui1tr2NxXMHaPOgk3ZO2itBI4VKM70zqZHAZztAgT6pZ3m7OnyFbkSLZKB5sqEqrgd/D0pEyTOwTmCbDWzYksge56PvibyPow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737392810; c=relaxed/simple;
	bh=HA30YDDKbpTQSqVYmFXdDpUCa4FAcHFXcwCxnCi8vgA=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=k+QZOmUWVhyXNOOz8bxhDLKSBEo4KgxzkU7gde/7Gq3y2GowATa/+PNT6LN0q7wNfqPi3dXVB9WsCdlE1CXySRMLpt0gpMUefhZIkjx6/QBVLU6w3w2Bz2pdhYoN/5gYV90C4SdfE7A2Y1vbEwU8L5LdjntWWUFY9sACCpVstLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WguWlmN7; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-844ec271431so312883539f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2025 09:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737392808; x=1737997608; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dbzRGIpUfEKMr1862KcWn9pE9FBrro2vsmhqYCsgXnw=;
        b=WguWlmN7yy6+X4qF3pto0eA9ZARVxmN67rmVTzyQIKqZRZP1XZTcPRRo2kyDj8lXIt
         k/mT4RRUfTDo4fYvkuRZW5gAaRtjBaW5y3YyEnMQy7Mf0JLE0GnPWCoXlMqLDfNF773S
         7A2I5ORyEwIL7d3WUG2a3maKvGmnDmPFvO5GhFb9lRDMLBmNIaE4KUgzFD1UJTgeytx1
         aq0U1zXc9dk8brDRQixkEInpVQ6d3K1rrgS3QM76ge5bzIpg56a1FMPcxgESaGYSliIY
         nYPQuQ2pvNPLel8vhUwfgmUBIYDZGSJHbrBp441PZk9sOlIgri0Ug/10pGa4h+tus6l8
         ccAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737392808; x=1737997608;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dbzRGIpUfEKMr1862KcWn9pE9FBrro2vsmhqYCsgXnw=;
        b=LPDpr0tdadJQrh4tJ+jD05EzGrr2n6CxJS0vwyBtyD5RkXJ+ghCdANQru8oslx56jz
         xC3qSA2IxXqSp1dGT+ClClwk+2rHOgNktweu9gMR583wDPxlxmKluJWADHLGh4LpOxDV
         va9w0JWB9hmptr0PXNIQt/AsSgtJODE+mLynmq2OmvHIlWHDKK7slxBC3OmH9pU5fPLo
         2alQk/6Qm12cX8rFs+gnXKpcZB90HbVm+c1eG1PyxqiEafCxx6r/J6YAzVjz8WmVTumL
         5SrEyiHWkRUJWVg5+ylYF2fu/yieZ+bz3LqixK7UVCXddMy2YW/GC4+r7HKjWOwuFR1r
         5DRg==
X-Forwarded-Encrypted: i=1; AJvYcCWteHLLZx3wTibC9huD9lb6XJwLZ0L4R4zohjr64bJQPvxfDcZIomwkgCHCE0nSOS/e8yW8Ls6R85tJ5DGZITI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKsFdLy45zye9q8Fg3eM61CEXEkFX5csKE/FMiCHiRguy01IS2
	h9rG84eTggLxR73ydHX4lPn+y/PrWuxfw1sa5dykTQUwBIzLAdZ6g5b5dS2F8ZEz10mXObwS7vz
	7EUziZvWjnEZwNWS+fqfFMw==
X-Google-Smtp-Source: AGHT+IG4x7GYL02R2P8WMU+wLeob+JkU+UOoOPCapsMLMJ+HN2IC3jxlZ7fkGf710FtXGhOHOjUVNPZMwxVgc3FATg==
X-Received: from iox13.prod.google.com ([2002:a05:6602:490d:b0:84f:41e2:80e5])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6602:6b12:b0:84a:5133:9cd8 with SMTP id ca18e2360f4ac-851b62835afmr813531839f.10.1737392807759;
 Mon, 20 Jan 2025 09:06:47 -0800 (PST)
Date: Mon, 20 Jan 2025 17:06:45 +0000
In-Reply-To: <Z368wnzQgMKMclFw@google.com> (message from Sean Christopherson
 on Wed, 8 Jan 2025 09:58:26 -0800)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntsepd2z4q.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v2 2/6] KVM: x86: selftests: Define AMD PMU CPUID leaves
From: Colton Lewis <coltonlewis@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, mizhang@google.com, ljr.kernel@gmail.com, 
	jmattson@google.com, aaronlewis@google.com, pbonzini@redhat.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Noted about the changelog and the ordering. No objections for how you
want to apply it.

Sean Christopherson <seanjc@google.com> writes:

> The shortlog is misleading.  It's the *leaves* that are being defined,  
> it's the
> features and properties.

> On Wed, Sep 18, 2024, Colton Lewis wrote:
>> This defined the CPUID calls to determine what extensions and
>> properties are available.

> This is not a coherent changelog.

>> AMD reference manual names listed below.

>> * PerfCtrExtCore (six core counters instead of four)
>> * PerfCtrExtNB (four counters for northbridge events)
>> * PerfCtrExtL2I (four counters for L2 cache events)
>> * PerfMonV2 (support for registers to control multiple
>>    counters with a single register write)
>> * LbrAndPmcFreeze (support for freezing last branch recorded stack on
>>    performance counter overflow)
>> * NumPerfCtrCore (number of core counters)
>> * NumPerfCtrNB (number of northbridge counters)

>> Signed-off-by: Colton Lewis <coltonlewis@google.com>
>> ---
>>   tools/testing/selftests/kvm/include/x86_64/processor.h | 7 +++++++
>>   1 file changed, 7 insertions(+)

>> diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h  
>> b/tools/testing/selftests/kvm/include/x86_64/processor.h
>> index a0c1440017bb..44ddfc4c1673 100644
>> --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
>> +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
>> @@ -183,6 +183,9 @@ struct kvm_x86_cpu_feature {
>>   #define	X86_FEATURE_GBPAGES		KVM_X86_CPU_FEATURE(0x80000001, 0, EDX, 26)
>>   #define	X86_FEATURE_RDTSCP		KVM_X86_CPU_FEATURE(0x80000001, 0, EDX, 27)
>>   #define	X86_FEATURE_LM			KVM_X86_CPU_FEATURE(0x80000001, 0, EDX, 29)
>> +#define	X86_FEATURE_PERF_CTR_EXT_CORE	KVM_X86_CPU_FEATURE(0x80000001,  
>> 0, ECX, 23)

> This ordering is "broken", and confused me for quite some time.  These  
> new features
> are in ECX, but they're landed after features for EDX.  To make matters  
> worse,
> there's an existing feature, SVM, defined for ECX.

> TL;DR: please be more careful about the ordering, don't just drop stuff  
> at the
> end.

>> +#define	X86_FEATURE_PERF_CTR_EXT_NB	KVM_X86_CPU_FEATURE(0x80000001, 0,  
>> ECX, 24)
>> +#define	X86_FEATURE_PERF_CTR_EXT_L2I	KVM_X86_CPU_FEATURE(0x80000001, 0,  
>> ECX, 28)

> To make life easier for developers, I think it makes sense to use the  
> kernel's
> names (when the kernel also defines a feature), and adjust the property  
> names to
> follow suit.

> If there are no objections, I'll apply this as:

> --
> Author:     Colton Lewis <coltonlewis@google.com>
> AuthorDate: Wed Sep 18 20:53:15 2024 +0000
> Commit:     Sean Christopherson <seanjc@google.com>
> CommitDate: Wed Jan 8 09:55:57 2025 -0800

>      KVM: selftests: Add defines for AMD PMU CPUID features and properties

>      Add macros for AMD's PMU related CPUID features.  To make it easier to
>      cross reference selftest code with KVM/kernel code, use the same macro
>      names as the kernel for the features.

>      For reference, the AMD APM defines the features/properties as:

>        * PerfCtrExtCore (six core counters instead of four)
>        * PerfCtrExtNB (four counters for northbridge events)
>        * PerfCtrExtL2I (four counters for L2 cache events)
>        * PerfMonV2 (support for registers to control multiple
>          counters with a single register write)
>        * LbrAndPmcFreeze (support for freezing last branch recorded stack  
> on
>          performance counter overflow)
>        * NumPerfCtrCore (number of core counters)
>        * NumPerfCtrNB (number of northbridge counters)

>      Signed-off-by: Colton Lewis <coltonlewis@google.com>
>      Link:  
> https://lore.kernel.org/r/20240918205319.3517569-3-coltonlewis@google.com
>      [sean: massage changelog, use same names as the kernel]
>      Signed-off-by: Sean Christopherson <seanjc@google.com>

> diff --git a/tools/testing/selftests/kvm/include/x86/processor.h  
> b/tools/testing/selftests/kvm/include/x86/processor.h
> index 9ec984cf8674..8de7cace1fbf 100644
> --- a/tools/testing/selftests/kvm/include/x86/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86/processor.h
> @@ -181,6 +181,9 @@ struct kvm_x86_cpu_feature {
>    * Extended Leafs, a.k.a. AMD defined
>    */
>   #define        X86_FEATURE_SVM                  
> KVM_X86_CPU_FEATURE(0x80000001, 0, ECX, 2)
> +#define        X86_FEATURE_PERFCTR_CORE         
> KVM_X86_CPU_FEATURE(0x80000001, 0, ECX, 23)
> +#define        X86_FEATURE_PERFCTR_NB           
> KVM_X86_CPU_FEATURE(0x80000001, 0, ECX, 24)
> +#define        X86_FEATURE_PERFCTR_LLC          
> KVM_X86_CPU_FEATURE(0x80000001, 0, ECX, 28)
>   #define        X86_FEATURE_NX                   
> KVM_X86_CPU_FEATURE(0x80000001, 0, EDX, 20)
>   #define        X86_FEATURE_GBPAGES              
> KVM_X86_CPU_FEATURE(0x80000001, 0, EDX, 26)
>   #define        X86_FEATURE_RDTSCP               
> KVM_X86_CPU_FEATURE(0x80000001, 0, EDX, 27)
> @@ -197,6 +200,8 @@ struct kvm_x86_cpu_feature {
>   #define        X86_FEATURE_VGIF                 
> KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 16)
>   #define X86_FEATURE_SEV                         
> KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 1)
>   #define X86_FEATURE_SEV_ES             KVM_X86_CPU_FEATURE(0x8000001F,  
> 0, EAX, 3)
> +#define        X86_FEATURE_PERFMON_V2           
> KVM_X86_CPU_FEATURE(0x80000022, 0, EAX, 0)
> +#define        X86_FEATURE_LBR_PMC_FREEZE       
> KVM_X86_CPU_FEATURE(0x80000022, 0, EAX, 2)

>   /*
>    * KVM defined paravirt features.
> @@ -283,6 +288,8 @@ struct kvm_x86_cpu_property {
>   #define X86_PROPERTY_GUEST_MAX_PHY_ADDR                 
> KVM_X86_CPU_PROPERTY(0x80000008, 0, EAX, 16, 23)
>   #define X86_PROPERTY_SEV_C_BIT                  
> KVM_X86_CPU_PROPERTY(0x8000001F, 0, EBX, 0, 5)
>   #define X86_PROPERTY_PHYS_ADDR_REDUCTION        
> KVM_X86_CPU_PROPERTY(0x8000001F, 0, EBX, 6, 11)
> +#define X86_PROPERTY_NR_PERFCTR_CORE            
> KVM_X86_CPU_PROPERTY(0x80000022, 0, EBX, 0, 3)
> +#define X86_PROPERTY_NR_PERFCTR_NB              
> KVM_X86_CPU_PROPERTY(0x80000022, 0, EBX, 10, 15)

>   #define X86_PROPERTY_MAX_CENTAUR_LEAF           
> KVM_X86_CPU_PROPERTY(0xC0000000, 0, EAX, 0, 31)

