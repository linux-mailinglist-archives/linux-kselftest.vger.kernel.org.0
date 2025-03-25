Return-Path: <linux-kselftest+bounces-29773-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2400DA70910
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 19:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A17A6176150
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 18:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396581AAA2F;
	Tue, 25 Mar 2025 18:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b402Qx9q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB1919CCFC
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Mar 2025 18:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742927554; cv=none; b=jJydm6dPK65an+TddJMSMqe/ugZddaoxL3bmippy70dmskrFcidFO6p/3kHfvXvE71zeMOZ7pfM2O4shvu7iD+NLe6GkXSeRV6GBcFx8rRbdFADbBncRJ40TIvHM4/MG9J29D4omcC15Z8me0IU/e1y4Z7k0wdWldXalkPFl3wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742927554; c=relaxed/simple;
	bh=3VLxMqia7k4wh5CKGCdVuUe0lQhVMHo8f9DLEg5u/rc=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Qowzcu+T2lVaZtgXpXaJMX/25IR7vIzXQtjcsiz2x66WddR57pfSGjPdVHQcIN4fZfIxb+vijjnOYvZHZ1BGZLkFe7saHaVcNQXgaKDFbQIlIZtxiPPywhev0UWdW0ixJ5QLJTn33ReM0GsVXI51JVLEx38LB9D+n+fFF+oOn54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b402Qx9q; arc=none smtp.client-ip=209.85.167.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-3fdf9b1f191so6370414b6e.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Mar 2025 11:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742927550; x=1743532350; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rT6uk1ccRQgk3tPYDgENsmPhevfhVkGtCPi5a1GUXLo=;
        b=b402Qx9qTFwTDYuJ5GooiZTDhp38PaHMYVBQTOsCh6mg+8/PpZyIaFiJy5/9vL0FK4
         aFYreTCjQn6C62vvpe30nU4WthwfOKLvRhvbkPSRbddAKc7k0TXToW4aGXybjQEpxGe0
         OxqZsS+cMh1jXrL6YeOBGCnP0adV+JbWVAncicfe+67Xo9Fi7gFC5eCfhsPCCRsXOgpw
         Uwq0wpfFAjjt5fmkvuXv0dLOT70Ek2cy3yiCuw0GiaZBcWnqork5vTxRzzzUQ9RXNc1+
         p1UWUAyhaQkvgmG3p7L+1G1FRkYVPFO38bQGRvFfyrHsNUkCAVTqxHjvP2p8DcSek6Du
         VuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742927550; x=1743532350;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rT6uk1ccRQgk3tPYDgENsmPhevfhVkGtCPi5a1GUXLo=;
        b=KBK53cNq5oMqbvRuQJLvy3tpNBsixEQDXNj+t3ItW3xLfYODYB4oAUQ52ioRet29u2
         GyN37C8Ilcv8lcOPoLNUjL2EEf5CTfZowvypKciBAl0hzUA8o/v+7ZzAIlPnW0/oSfai
         c8dEx5fFowH3nFq7p4pX3B1hX5qwZJzuPqfayNJYZ/Jbr0yHaVL4wNvo3gHMz/Y3gBzO
         OvQ7YCVIaFPTvppVMbPn3cy7gJe8/Z9U/ZiHXxkB5Fj3AdgyNpegWaRmeSH6an0naJc3
         irocqJjZDXl3/uzmzneeSwKoFarAtC3T3ApZ0uH2IZP7eK7W4C4dPn3pOEVtmk4xDtA4
         Zi/g==
X-Forwarded-Encrypted: i=1; AJvYcCWBDVLq+Kt1MDXGMToRZ82WdhT9KjDz9iYf7GARiyaG9AgR53jn0IeERO760/qqK2lag2TfKQTCfwUDOPz9A6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdwPr3u/+D/DJIbt26zlnk92bRMMTu1fgdze+aWS/jIf4UV5px
	69/0GWUV4Y+WmB/S90k6q0Tkaj53XXeRzp8h8MIVTiGysjpO3PcytlMTYaxyegv6a4mclS//Op+
	XSoR1QQtk4ozhL+Wp9sRFgg==
X-Google-Smtp-Source: AGHT+IHRRMYIJCHEAh3svSotUa8q7hV/04SZRRr5Jw10gUK3/nM69X6981QRTYUVyLaD3ga2dWmRCXaZa3v0y+Ebxw==
X-Received: from oio6.prod.google.com ([2002:a05:6808:8706:b0:3f6:dccd:c522])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1184:b0:3fb:2e8f:4de5 with SMTP id 5614622812f47-3febf73a9cbmr12594859b6e.17.1742927550105;
 Tue, 25 Mar 2025 11:32:30 -0700 (PDT)
Date: Tue, 25 Mar 2025 18:32:28 +0000
In-Reply-To: <d018f56a-15c3-4739-b8f4-aea863006765@linaro.org> (message from
 James Clark on Mon, 24 Mar 2025 14:53:49 +0000)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsnt1pulnepv.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [RFC PATCH v3 5/8] KVM: arm64: Introduce module param to
 partition the PMU
From: Colton Lewis <coltonlewis@google.com>
To: James Clark <james.clark@linaro.org>
Cc: kvm@vger.kernel.org, alexandru.elisei@arm.com, robh@kernel.org, 
	linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, mark.rutland@arm.com, 
	pbonzini@redhat.com, shuah@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Hi James,

Thanks for the review.

James Clark <james.clark@linaro.org> writes:

> On 13/02/2025 6:03 pm, Colton Lewis wrote:
>> For PMUv3, the register MDCR_EL2.HPMN partitiones the PMU counters
>> into two ranges where counters 0..HPMN-1 are accessible by EL1 and, if
>> allowed, EL0 while counters HPMN..N are only accessible by EL2.

>> Introduce a module parameter in KVM to set this register. The name
>> reserved_host_counters reflects the intent to reserve some counters
>> for the host so the guest may eventually be allowed direct access to a
>> subset of PMU functionality for increased performance.

>> Track HPMN and whether the pmu is partitioned in struct arm_pmu
>> because both KVM and the PMUv3 driver will need to know that to handle
>> guests correctly.

>> Due to the difficulty this feature would create for the driver running
>> at EL1 on the host, partitioning is only allowed in VHE mode. Working
>> on nVHE mode would require a hypercall for every register access
>> because the counters reserved for the host by HPMN are now only
>> accessible to EL2.

>> The parameter is only configurable at boot time. Making the parameter
>> configurable on a running system is dangerous due to the difficulty of
>> knowing for sure no counters are in use anywhere so it is safe to
>> reporgram HPMN.


> Hi Colton,

> For some high level feedback for the RFC, it probably makes sense to
> include the other half of the feature at the same time. I think there is
> a risk that it requires something slightly different than what's here
> and there ends up being some churn.

I agree. That's what I'm working on now. I justed wanted an iteration or
two in public so I'm not building on something that needs drastic change
later.

> Other than that I think it looks ok apart from some minor code review  
> nits.

Thank you

> I was also thinking about how BRBE interacts with this. Alex has done
> some analysis that finds that it's difficult to use BRBE in guests with
> virtualized counters due to the fact that BRBE freezes on any counter
> overflow, rather than just guest ones. That leaves the guest with branch
> blackout windows in the delay between a host counter overflowing and the
> interrupt being taken and BRBE being restarted.

> But with HPMN, BRBE does allow freeze on overflow of only one partition
> or the other (or both, but I don't think we'd want that) e.g.:

>    RNXCWF: If EL2 is implemented, a BRBE freeze event occurs when all of
>    the following are true:

>    * BRBCR_EL1.FZP is 1.
>    * Generation of Branch records is not paused.
>    * PMOVSCLR_EL0[(MDCR_EL2.HPMN-1):0] is nonzero.
>    * The PE is in a BRBE Non-prohibited region.

> Unfortunately that means we could only let guests use BRBE with a
> partitioned PMU, which would massively reduce flexibility if hosts have
> to lose counters just so the guest can use BRBE.

> I don't know if this is a stupid idea, but instead of having a fixed
> number for the partition, wouldn't it be nice if we could trap and
> increment HPMN on the first guest use of a counter, then decrement it on
> guest exit depending on what's still in use? The host would always
> assign its counters from the top down, and guests go bottom up if they
> want PMU passthrough. Maybe it's too complicated or won't work for
> various reasons, but because of BRBE the counter partitioning changes go
> from an optimization to almost a necessity.

This is a cool idea that would enable useful things. I can think of a
few potential problems.

1. Partitioning will give guests direct access to some PMU counter
registers. There is no reliable way for KVM to determine what is in use
from that state. A counter that is disabled guest at exit might only be
so temporarily, which could lead to a lot of thrashing allocating and
deallocating counters.

2. HPMN affects reads of PMCR_EL0.N, which is the standard way to
determine how many counters there are. If HPMN starts as a low number,
guests have no way of knowing there are more counters
available. Dynamically changing the counters available could be
confusing for guests.

3. If guests were aware they could write beyond HPMN and get the
counters allocated to them, nothing stops them from writing at counter
N and taking as many counters as possible to starve the host.

>> Signed-off-by: Colton Lewis <coltonlewis@google.com>
>> ---
>>    arch/arm64/include/asm/kvm_pmu.h |  4 +++
>>    arch/arm64/kvm/Makefile          |  2 +-
>>    arch/arm64/kvm/debug.c           |  9 ++++--
>>    arch/arm64/kvm/pmu-part.c        | 47 ++++++++++++++++++++++++++++++++
>>    arch/arm64/kvm/pmu.c             |  2 ++
>>    include/linux/perf/arm_pmu.h     |  2 ++
>>    6 files changed, 62 insertions(+), 4 deletions(-)
>>    create mode 100644 arch/arm64/kvm/pmu-part.c

>> diff --git a/arch/arm64/include/asm/kvm_pmu.h  
>> b/arch/arm64/include/asm/kvm_pmu.h
>> index 613cddbdbdd8..174b7f376d95 100644
>> --- a/arch/arm64/include/asm/kvm_pmu.h
>> +++ b/arch/arm64/include/asm/kvm_pmu.h
>> @@ -22,6 +22,10 @@ bool kvm_set_pmuserenr(u64 val);
>>    void kvm_vcpu_pmu_resync_el0(void);
>>    void kvm_host_pmu_init(struct arm_pmu *pmu);

>> +u8 kvm_pmu_get_reserved_counters(void);
>> +u8 kvm_pmu_hpmn(u8 nr_counters);
>> +void kvm_pmu_partition(struct arm_pmu *pmu);
>> +
>>    #else

>>    static inline void kvm_set_pmu_events(u64 set, struct perf_event_attr  
>> *attr) {}
>> diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
>> index 3cf7adb2b503..065a6b804c84 100644
>> --- a/arch/arm64/kvm/Makefile
>> +++ b/arch/arm64/kvm/Makefile
>> @@ -25,7 +25,7 @@ kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o  
>> pvtime.o \
>>    	 vgic/vgic-mmio-v3.o vgic/vgic-kvm-device.o \
>>    	 vgic/vgic-its.o vgic/vgic-debug.o

>> -kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu.o
>> +kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu-part.o pmu.o
>>    kvm-$(CONFIG_ARM64_PTR_AUTH)  += pauth.o
>>    kvm-$(CONFIG_PTDUMP_STAGE2_DEBUGFS) += ptdump.o

>> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
>> index 7fb1d9e7180f..b5ac5a213877 100644
>> --- a/arch/arm64/kvm/debug.c
>> +++ b/arch/arm64/kvm/debug.c
>> @@ -31,15 +31,18 @@
>>     */
>>    static void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
>>    {
>> +	u8 counters = *host_data_ptr(nr_event_counters);
>> +	u8 hpmn = kvm_pmu_hpmn(counters);
>> +
>>    	preempt_disable();


> Would you not need to use vcpu->cpu here to access host_data? The
> preempt_disable() after the access seems suspicious. I think you'll end
> up with the same issue as here:

> https://lore.kernel.org/kvmarm/5edb7c69-f548-4651-8b63-1643c5b13dac@linaro.org/

I think that's right. I should use the host_data for vcpu->cpu

>>    	/*
>>    	 * This also clears MDCR_EL2_E2PB_MASK and MDCR_EL2_E2TB_MASK
>>    	 * to disable guest access to the profiling and trace buffers
>>    	 */
>> -	vcpu->arch.mdcr_el2 = FIELD_PREP(MDCR_EL2_HPMN,
>> -					 *host_data_ptr(nr_event_counters));
>> -	vcpu->arch.mdcr_el2 |= (MDCR_EL2_TPM |
>> +	vcpu->arch.mdcr_el2 = FIELD_PREP(MDCR_EL2_HPMN, hpmn);
>> +	vcpu->arch.mdcr_el2 |= (MDCR_EL2_HPMD |
>> +				MDCR_EL2_TPM |
>>    				MDCR_EL2_TPMS |
>>    				MDCR_EL2_TTRF |
>>    				MDCR_EL2_TPMCR |
>> diff --git a/arch/arm64/kvm/pmu-part.c b/arch/arm64/kvm/pmu-part.c
>> new file mode 100644
>> index 000000000000..e74fecc67e37
>> --- /dev/null
>> +++ b/arch/arm64/kvm/pmu-part.c
>> @@ -0,0 +1,47 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2025 Google LLC
>> + * Author: Colton Lewis <coltonlewis@google.com>
>> + */
>> +
>> +#include <linux/kvm_host.h>
>> +#include <linux/perf/arm_pmu.h>
>> +
>> +#include <asm/kvm_pmu.h>
>> +
>> +static u8 reserved_host_counters __read_mostly;
>> +
>> +module_param(reserved_host_counters, byte, 0);
>> +MODULE_PARM_DESC(reserved_host_counters,
>> +		 "Partition the PMU into host and guest counters");
>> +
>> +u8 kvm_pmu_get_reserved_counters(void)
>> +{
>> +	return reserved_host_counters;
>> +}
>> +
>> +u8 kvm_pmu_hpmn(u8 nr_counters)
>> +{
>> +	if (reserved_host_counters >= nr_counters) {
>> +		if (this_cpu_has_cap(ARM64_HAS_HPMN0))
>> +			return 0;
>> +
>> +		return 1;
>> +	}
>> +
>> +	return nr_counters - reserved_host_counters;
>> +}
>> +
>> +void kvm_pmu_partition(struct arm_pmu *pmu)
>> +{
>> +	u8 nr_counters = *host_data_ptr(nr_event_counters);
>> +	u8 hpmn = kvm_pmu_hpmn(nr_counters);
>> +
>> +	if (hpmn < nr_counters) {
>> +		pmu->hpmn = hpmn;
>> +		pmu->partitioned = true;

> Looks like Rob's point about pmu->partitioned being duplicate data
> stands again. On the previous version you mentioned that saving it was
> to avoid reading PMCR.N, but now it's not based on PMCR.N anymore.

I will make it a function instead so the meaning of hpmn < nr_counters
is clear.

