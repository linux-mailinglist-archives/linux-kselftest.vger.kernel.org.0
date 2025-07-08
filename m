Return-Path: <linux-kselftest+bounces-36779-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C65AFDB2D
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 00:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 550261BC6ABD
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 22:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C1D25C80F;
	Tue,  8 Jul 2025 22:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EmJBj1uF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C8A25A2C2
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Jul 2025 22:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752014282; cv=none; b=QdiWfkQI/bkSIJOeXSeip3ld4m1N7oH87f3ivGqpziDUf2F+7GhawryUEf8tQHVxyMMIU0HdvtizUQHrxpkQe+j1pV53EnqAgBkyQDkoO1jsFC1al2gT+KtPaqak2K1qDYdcP1WZiypgIGjqxj7TtEWn+wmNTJNAZNDSv6BNSkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752014282; c=relaxed/simple;
	bh=JeA7p4zwf/DPSRpqESrFUAw2jCwA0F9WYGz7M2Sgufs=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=l+ypp344JpQvWjvZsCkOCC7ArlQAw+9uFIGRVvcN1KA9f/oDPVmyVARtZaov81xcGx6e8vkq65MH0iIKa7e9iijhmnZJuEp9kg9wQeJcld0RQksJsvCHvlJWEUJ8VPnlCrujrESFuFzKtaPbsmVjdMispiHBc+y9c2/afv8LqfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EmJBj1uF; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3ddd03db21cso86027765ab.1
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Jul 2025 15:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752014280; x=1752619080; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K3fDXmd8Za9nT5CKATz2Yu/CxtGDvmK7u4P2JzL5Q1M=;
        b=EmJBj1uFVZ0HaGCw2sQU5/zn4RjEBNO/0MxGF3DX9TsIDCyRK3QyMxM6lTvKUrCyPG
         GvQvbszSsowUcDFntcbgA7D/KKkIjLRBBf2xa2X9ZbzKBg4iUytMQCs0YfysFioH2rh1
         lS8yNRA4bqpXCdUWHlf0y0uUt3EQUPnxnFCdk1fV/FUHiaF6AvEXmL2zkY95HQwO/xmS
         Gb3pIwxyXvX61Q99R/9NxuCPNryQLs1Qrwc8r8aeK1OIFD8p63xVAiHjE+1oUrsSRRR/
         gchw9aQ0KsgmKmR4M4lPCXFBKdgPxDCXM6YmUL0OCYAKd+zlxEfi5iWy96aShkOejTfS
         mpog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752014280; x=1752619080;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K3fDXmd8Za9nT5CKATz2Yu/CxtGDvmK7u4P2JzL5Q1M=;
        b=t1rElSHZQ86vJc5oZuiY7wbSssuNqw1Lwx4zamNZ13ilWcEF37mvi57OlcisN43CQa
         omwLflmIFEAeA1diCh6K1zTHdsl03/gseJE4iF69DdluUYx7j4aw4fhRmKU1ycARO27d
         fMaiEeFwPmJfXkgCAEQsYx1NY5RuubryUX4ifVjRzFp+KSbq2kTeqG69xYucGBF46hFX
         Pb1mqShxFI7qhntHJfPNY9/ivC7P+rG1WwqDiONWxDiSZ6WAMCoV097MjfVmfXGuQhKa
         Sl1Tjdovti6QtMRTsVFoFSY7PGQMzwdQbrhzeHnMHuzHf4g7/ezwX0P07xnOYLLxaFB2
         cuBw==
X-Forwarded-Encrypted: i=1; AJvYcCVSZXrLggCn0nO0rJMBF9PZyWOFa/lmTXAXBpVSND6R8ayK4aFIP4AeAqj6ofCf6hIkNzQzdgJTLIUkaVkLTPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbR+MLh9XkYfeHq9nV5g7PHZzULFoGanUUhA9pqdBOv7TLDhzO
	wcpGv9AQ4MPTdL3xbSAy1g1CdDbTF9ROyUE2NRQqu/9PbUpvP1t3jM5LZ5sfxw5ye0Rb/pxrOEB
	+KL+yzWUnLgvbUJfjCKKDA3WbQw==
X-Google-Smtp-Source: AGHT+IGn06nCm9CZ+nzlG32HvMMbBVuhGSihb8VF+3WUu807Tfp1nhfGPv/rtrugveMa2wQtbIoPODa59ewzY1piAQ==
X-Received: from ilkk6.prod.google.com ([2002:a05:6e02:5e86:b0:3df:42dd:4aa6])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:380f:b0:3df:154d:aa5b with SMTP id e9e14a558f8ab-3e166ff0481mr5601765ab.5.1752014279704;
 Tue, 08 Jul 2025 15:37:59 -0700 (PDT)
Date: Tue, 08 Jul 2025 22:37:58 +0000
In-Reply-To: <aGvyFiyEEsMrhN0i@J2N7QTR9R3> (message from Mark Rutland on Mon,
 7 Jul 2025 17:13:10 +0100)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsnt1pqq1f7d.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v3 04/22] KVM: arm64: Cleanup PMU includes
From: Colton Lewis <coltonlewis@google.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	maz@kernel.org, oliver.upton@linux.dev, mizhang@google.com, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	shuah@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Mark Rutland <mark.rutland@arm.com> writes:

> On Thu, Jun 26, 2025 at 08:04:40PM +0000, Colton Lewis wrote:
>> From: Marc Zyngier <maz@kernel.org>

>> Reorganize these tangled headers.

> In prior versions of this series, there was some earlier text explaining  
> that
> there was a circular header dependency. In v2:

>     
> https://lore.kernel.org/linux-arm-kernel/20250620221326.1261128-6-coltonlewis@google.com/

> ... it said:

> | asm/kvm_host.h includes asm/arm_pmu.h which includes perf/arm_pmuv3.h
> | which includes asm/arm_pmuv3.h which includes asm/kvm_host.h This
> | causes compilation problems why trying to use anything defined in any
> | of the headers in any other headers.

> Was there some reason for dropping that? It's a bit odd to start without a
> problem statement.

When I rebased on top of kvm/queue, that included a patch from Sean that
changed the the problem. I thought I wrote a new description but I guess
not. I'll include in my next reroll.

The core issue is still that including *all* of kvm_host.h in
arm_pmuv3.h is a circular dependency.

asm/kvm_host.h includes asm/kvm_pmu.h includes perf/arm_pmuv3.h includes
asm/arm_pmuv3.h includes asm/kvm_host.h

Some other things in this patch are vestigial or needed later, so I
should put them in the patches where they are used.


>> * Respect the move defining the interface between KVM and PMU in its
>>    own header asm/kvm_pmu.h

>> * Define an empty struct arm_pmu so it is defined for those interface
>>    functions when compiling with CONFIG_KVM but not CONFIG_ARM_PMU

> Which functions in particular are those? What prevents them from  
> depending on
> CONFIG_ARM_PMU?

> Mark.

Functions I introduce later. So this hunk should be in a later patch if
I need to keep it.

bool kvm_pmu_is_partitioned(struct arm_pmu *pmu);
u64 kvm_pmu_host_counter_mask(struct arm_pmu *pmu);
u64 kvm_pmu_guest_counter_mask(struct arm_pmu *pmu);

The first, at least, has to be called in non-PMU KVM code to check if we
can use my ioctl later.

I suppose in that case it's only calling a dummy definition that returns
false, so I don't need struct arm_pmu * in the argument and can just use
void *

>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> Signed-off-by: Colton Lewis <coltonlewis@google.com>
>> ---
>>   arch/arm64/include/asm/arm_pmuv3.h      |  2 +-
>>   arch/arm64/include/asm/kvm_host.h       | 15 +--------------
>>   arch/arm64/include/asm/kvm_pmu.h        | 15 +++++++++++++++
>>   arch/arm64/kvm/debug.c                  |  1 +
>>   arch/arm64/kvm/hyp/include/hyp/switch.h |  1 +
>>   arch/arm64/kvm/pmu.c                    |  2 ++
>>   arch/arm64/kvm/sys_regs.c               |  1 +
>>   include/linux/perf/arm_pmu.h            |  5 +++++
>>   virt/kvm/kvm_main.c                     |  1 +
>>   9 files changed, 28 insertions(+), 15 deletions(-)

>> diff --git a/arch/arm64/include/asm/arm_pmuv3.h  
>> b/arch/arm64/include/asm/arm_pmuv3.h
>> index 8a777dec8d88..32c003a7b810 100644
>> --- a/arch/arm64/include/asm/arm_pmuv3.h
>> +++ b/arch/arm64/include/asm/arm_pmuv3.h
>> @@ -6,7 +6,7 @@
>>   #ifndef __ASM_PMUV3_H
>>   #define __ASM_PMUV3_H

>> -#include <asm/kvm_host.h>
>> +#include <asm/kvm_pmu.h>

>>   #include <asm/cpufeature.h>
>>   #include <asm/sysreg.h>
>> diff --git a/arch/arm64/include/asm/kvm_host.h  
>> b/arch/arm64/include/asm/kvm_host.h
>> index 27ed26bd4381..2df76689381a 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -14,6 +14,7 @@
>>   #include <linux/arm-smccc.h>
>>   #include <linux/bitmap.h>
>>   #include <linux/types.h>
>> +#include <linux/irq_work.h>
>>   #include <linux/jump_label.h>
>>   #include <linux/kvm_types.h>
>>   #include <linux/maple_tree.h>
>> @@ -1487,25 +1488,11 @@ void kvm_arch_vcpu_ctxflush_fp(struct kvm_vcpu  
>> *vcpu);
>>   void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu);
>>   void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu);

>> -static inline bool kvm_pmu_counter_deferred(struct perf_event_attr  
>> *attr)
>> -{
>> -	return (!has_vhe() && attr->exclude_host);
>> -}
>> -
>>   #ifdef CONFIG_KVM
>> -void kvm_set_pmu_events(u64 set, struct perf_event_attr *attr);
>> -void kvm_clr_pmu_events(u64 clr);
>> -bool kvm_set_pmuserenr(u64 val);
>>   void kvm_enable_trbe(void);
>>   void kvm_disable_trbe(void);
>>   void kvm_tracing_set_el1_configuration(u64 trfcr_while_in_guest);
>>   #else
>> -static inline void kvm_set_pmu_events(u64 set, struct perf_event_attr  
>> *attr) {}
>> -static inline void kvm_clr_pmu_events(u64 clr) {}
>> -static inline bool kvm_set_pmuserenr(u64 val)
>> -{
>> -	return false;
>> -}
>>   static inline void kvm_enable_trbe(void) {}
>>   static inline void kvm_disable_trbe(void) {}
>>   static inline void kvm_tracing_set_el1_configuration(u64  
>> trfcr_while_in_guest) {}
>> diff --git a/arch/arm64/include/asm/kvm_pmu.h  
>> b/arch/arm64/include/asm/kvm_pmu.h
>> index baf028d19dfc..ad3247b46838 100644
>> --- a/arch/arm64/include/asm/kvm_pmu.h
>> +++ b/arch/arm64/include/asm/kvm_pmu.h
>> @@ -11,9 +11,15 @@
>>   #include <linux/kvm_types.h>
>>   #include <linux/perf_event.h>
>>   #include <linux/perf/arm_pmuv3.h>
>> +#include <linux/perf/arm_pmu.h>

>>   #define KVM_ARMV8_PMU_MAX_COUNTERS	32

>> +#define kvm_pmu_counter_deferred(attr)			\
>> +	({						\
>> +		!has_vhe() && (attr)->exclude_host;	\
>> +	})
>> +
>>   #if IS_ENABLED(CONFIG_HW_PERF_EVENTS) && IS_ENABLED(CONFIG_KVM)
>>   struct kvm_pmc {
>>   	u8 idx;	/* index into the pmu->pmc array */
>> @@ -68,6 +74,9 @@ int kvm_arm_pmu_v3_has_attr(struct kvm_vcpu *vcpu,
>>   int kvm_arm_pmu_v3_enable(struct kvm_vcpu *vcpu);

>>   struct kvm_pmu_events *kvm_get_pmu_events(void);
>> +void kvm_set_pmu_events(u64 set, struct perf_event_attr *attr);
>> +void kvm_clr_pmu_events(u64 clr);
>> +bool kvm_set_pmuserenr(u64 val);
>>   void kvm_vcpu_pmu_restore_guest(struct kvm_vcpu *vcpu);
>>   void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu);
>>   void kvm_vcpu_pmu_resync_el0(void);
>> @@ -161,6 +170,12 @@ static inline u64 kvm_pmu_get_pmceid(struct  
>> kvm_vcpu *vcpu, bool pmceid1)

>>   #define kvm_vcpu_has_pmu(vcpu)		({ false; })
>>   static inline void kvm_pmu_update_vcpu_events(struct kvm_vcpu *vcpu) {}
>> +static inline void kvm_set_pmu_events(u64 set, struct perf_event_attr  
>> *attr) {}
>> +static inline void kvm_clr_pmu_events(u64 clr) {}
>> +static inline bool kvm_set_pmuserenr(u64 val)
>> +{
>> +	return false;
>> +}
>>   static inline void kvm_vcpu_pmu_restore_guest(struct kvm_vcpu *vcpu) {}
>>   static inline void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu) {}
>>   static inline void kvm_vcpu_reload_pmu(struct kvm_vcpu *vcpu) {}
>> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
>> index 1a7dab333f55..a554c3e368dc 100644
>> --- a/arch/arm64/kvm/debug.c
>> +++ b/arch/arm64/kvm/debug.c
>> @@ -9,6 +9,7 @@

>>   #include <linux/kvm_host.h>
>>   #include <linux/hw_breakpoint.h>
>> +#include <linux/perf/arm_pmuv3.h>

>>   #include <asm/debug-monitors.h>
>>   #include <asm/kvm_asm.h>
>> diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h  
>> b/arch/arm64/kvm/hyp/include/hyp/switch.h
>> index 7599844908c0..825b81749972 100644
>> --- a/arch/arm64/kvm/hyp/include/hyp/switch.h
>> +++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
>> @@ -14,6 +14,7 @@
>>   #include <linux/kvm_host.h>
>>   #include <linux/types.h>
>>   #include <linux/jump_label.h>
>> +#include <linux/perf/arm_pmuv3.h>
>>   #include <uapi/linux/psci.h>

>>   #include <asm/barrier.h>
>> diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
>> index 6b48a3d16d0d..8bfc6b0a85f6 100644
>> --- a/arch/arm64/kvm/pmu.c
>> +++ b/arch/arm64/kvm/pmu.c
>> @@ -8,6 +8,8 @@
>>   #include <linux/perf/arm_pmu.h>
>>   #include <linux/perf/arm_pmuv3.h>

>> +#include <asm/kvm_pmu.h>
>> +
>>   static DEFINE_PER_CPU(struct kvm_pmu_events, kvm_pmu_events);

>>   /*
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index 99fdbe174202..eaff6d63ef77 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -18,6 +18,7 @@
>>   #include <linux/printk.h>
>>   #include <linux/uaccess.h>
>>   #include <linux/irqchip/arm-gic-v3.h>
>> +#include <linux/perf/arm_pmuv3.h>

>>   #include <asm/arm_pmuv3.h>
>>   #include <asm/cacheflush.h>
>> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
>> index 6dc5e0cd76ca..fb382bcd4f4b 100644
>> --- a/include/linux/perf/arm_pmu.h
>> +++ b/include/linux/perf/arm_pmu.h
>> @@ -187,6 +187,11 @@ void armpmu_free_irq(int irq, int cpu);

>>   #define ARMV8_PMU_PDEV_NAME "armv8-pmu"

>> +#else
>> +
>> +struct arm_pmu {
>> +};
>> +
>>   #endif /* CONFIG_ARM_PMU */

>>   #define ARMV8_SPE_PDEV_NAME "arm,spe-v1"
>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> index e2f6344256ce..25259fcf3115 100644
>> --- a/virt/kvm/kvm_main.c
>> +++ b/virt/kvm/kvm_main.c
>> @@ -48,6 +48,7 @@
>>   #include <linux/lockdep.h>
>>   #include <linux/kthread.h>
>>   #include <linux/suspend.h>
>> +#include <linux/perf_event.h>

>>   #include <asm/processor.h>
>>   #include <asm/ioctl.h>
>> --
>> 2.50.0.727.gbf7dc18ff4-goog


