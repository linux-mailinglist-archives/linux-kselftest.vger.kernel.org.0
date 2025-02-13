Return-Path: <linux-kselftest+bounces-26580-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 930C0A34DA6
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 19:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34E10188F366
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 18:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2F024293A;
	Thu, 13 Feb 2025 18:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0bVcB9/9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859D9245AF9
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Feb 2025 18:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739471203; cv=none; b=gmc3+m73VZ9kdIEutfOBmXXLHH6RqC5bWhdc/6Sjy4QrnovepPrpjpNkTt/vudMAvCwqpEzcLCapt10mASd/SFg5FrJT/rb3DET+ZkF624zwvSfjCqSlqrYmwu2MdQQLBSlUqwz9wZfEFhZtf6sVTf0/kpLKgR90eIcFiP6R8FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739471203; c=relaxed/simple;
	bh=DfCUgXqHlCqaCGoUZXwUtD1qYSWkevdkOR/NjWpaCe0=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=mSdVDDxuzFwCwr+SysIcKK0PKWRTihCmC79FDtSdEl+pccdB1E/IgfmHuvN2zTxSzpz+4mzgitJDkOCPKBbhEYeK5KvwoDR+HqzoVgFCwoZtNG2/EW20eL2xnlN78ABZhQS0xWVOP2gghXaQvWteLaPuoikUMNPBnmKg9v8W2Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0bVcB9/9; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3cfba354f79so24493815ab.1
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Feb 2025 10:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739471200; x=1740076000; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SRbyrxxE6pQ51BtN/RARGY7p3IaeF1wyaiGnD0BFrdo=;
        b=0bVcB9/9XF7hQRjR53KQ45kOU3zZGgCGpOk6AAUVlfcPUm9NFWWpmTnv6f8peFcuAE
         C2oAadMce/EQW/SIW5/uM+rCgnmo2hCeKDrOoxOeynI5M/W/b7sxQ+6kCANkTnWPhVuV
         4nXzX3j3wf0Yfso2nrZU3FOMBLKypzNR26qBNRfgzQiXokqO+A/8lCM4X6Th0Um8tlan
         3XP7Qlb663UHUw9PrLs0qNB/tGEVTfhXsvulGY3Y/JOb4lYLhcGIw3TzuRp+tiEYGSZY
         dKvNT+lhxjPeTD4CJfPz9flkeZlhiV6K7v3WrQOvW5pNsIyl04VTgFJWc/qHPFlvPsGt
         dBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739471200; x=1740076000;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SRbyrxxE6pQ51BtN/RARGY7p3IaeF1wyaiGnD0BFrdo=;
        b=CJ08y60nCaAHQ6NPBUAojUHuDyUozNTl9KF/QWQxIzN9Wjah4fK7yZBkfr+OuHIpZb
         dqrT+CG2vToih/m5AeXqxxPJGcSOI1M8i2+MsWdRKdTR2HyfsoCANks/Z+OKYd9FIEdn
         gsui9mvksUz/uF21yIrrHCk9hsQfbf7fWJhsNzSDkdsuCpacBW8o8IOPrUVBTft1ORgj
         TYM2ruuTFPuG4Z2vSltMfQr5mfPpGUZD/L3iEZjXaRnFRViOUqnPrSXrxjPg292nsnIY
         G3abHeSnq0NZ+xLZ8eLoOD0GuuSbBinnFZYnkRZibJDKoSHskwUPIGSF+8pLbXPCKgkV
         mFVA==
X-Forwarded-Encrypted: i=1; AJvYcCU1x++AmREofO42y+CEFuA16+2jWEzQdzZ/gKbSzcqtJKzBujoD6wax5h2mc6q4wG8+kPdPfWurOpVckD4XljM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDBCeCOkr/i5F+elUS/8oCFEFDmTyKX/fATghkQNGJh9nU5f8H
	xBWmo5CsWWpEE6GRzDlrXfr6ETp5psxWeGuRgZ1zZhqwBsSKvtcbaRg0XOOGJNOyQ2oLz3DHDDW
	nLh/PyjysoHRGtvLRluVAHw==
X-Google-Smtp-Source: AGHT+IFp1n/vC+oFo5ydHEWrWlrc0W2BfMN0AUt8qYnomxpir+p2bRTl1EUF7TIhpDwxVdsQKX089g8EAXv0qFw7gA==
X-Received: from ilbeb7.prod.google.com ([2002:a05:6e02:4607:b0:3d0:1b91:f6])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:1a0d:b0:3d0:239a:c46f with SMTP id e9e14a558f8ab-3d17bf37598mr81031685ab.12.1739471200775;
 Thu, 13 Feb 2025 10:26:40 -0800 (PST)
Date: Thu, 13 Feb 2025 18:26:39 +0000
In-Reply-To: <20250213180317.3205285-6-coltonlewis@google.com> (message from
 Colton Lewis on Thu, 13 Feb 2025 18:03:14 +0000)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntbjv51z1c.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [RFC PATCH v3 5/8] KVM: arm64: Introduce module param to
 partition the PMU
From: Colton Lewis <coltonlewis@google.com>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, linux@armlinux.org.uk, catalin.marinas@arm.com, 
	will@kernel.org, maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, mark.rutland@arm.com, 
	pbonzini@redhat.com, shuah@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Colton Lewis <coltonlewis@google.com> writes:

> For PMUv3, the register MDCR_EL2.HPMN partitiones the PMU counters
> into two ranges where counters 0..HPMN-1 are accessible by EL1 and, if
> allowed, EL0 while counters HPMN..N are only accessible by EL2.

> Introduce a module parameter in KVM to set this register. The name
> reserved_host_counters reflects the intent to reserve some counters
> for the host so the guest may eventually be allowed direct access to a
> subset of PMU functionality for increased performance.

> Track HPMN and whether the pmu is partitioned in struct arm_pmu
> because both KVM and the PMUv3 driver will need to know that to handle
> guests correctly.

> Due to the difficulty this feature would create for the driver running
> at EL1 on the host, partitioning is only allowed in VHE mode. Working
> on nVHE mode would require a hypercall for every register access
> because the counters reserved for the host by HPMN are now only
> accessible to EL2.

> The parameter is only configurable at boot time. Making the parameter
> configurable on a running system is dangerous due to the difficulty of
> knowing for sure no counters are in use anywhere so it is safe to
> reporgram HPMN.

> Signed-off-by: Colton Lewis <coltonlewis@google.com>
> ---
>   arch/arm64/include/asm/kvm_pmu.h |  4 +++
>   arch/arm64/kvm/Makefile          |  2 +-
>   arch/arm64/kvm/debug.c           |  9 ++++--
>   arch/arm64/kvm/pmu-part.c        | 47 ++++++++++++++++++++++++++++++++
>   arch/arm64/kvm/pmu.c             |  2 ++
>   include/linux/perf/arm_pmu.h     |  2 ++
>   6 files changed, 62 insertions(+), 4 deletions(-)
>   create mode 100644 arch/arm64/kvm/pmu-part.c

> diff --git a/arch/arm64/include/asm/kvm_pmu.h  
> b/arch/arm64/include/asm/kvm_pmu.h
> index 613cddbdbdd8..174b7f376d95 100644
> --- a/arch/arm64/include/asm/kvm_pmu.h
> +++ b/arch/arm64/include/asm/kvm_pmu.h
> @@ -22,6 +22,10 @@ bool kvm_set_pmuserenr(u64 val);
>   void kvm_vcpu_pmu_resync_el0(void);
>   void kvm_host_pmu_init(struct arm_pmu *pmu);

> +u8 kvm_pmu_get_reserved_counters(void);
> +u8 kvm_pmu_hpmn(u8 nr_counters);
> +void kvm_pmu_partition(struct arm_pmu *pmu);
> +
>   #else

>   static inline void kvm_set_pmu_events(u64 set, struct perf_event_attr  
> *attr) {}
> diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
> index 3cf7adb2b503..065a6b804c84 100644
> --- a/arch/arm64/kvm/Makefile
> +++ b/arch/arm64/kvm/Makefile
> @@ -25,7 +25,7 @@ kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o  
> pvtime.o \
>   	 vgic/vgic-mmio-v3.o vgic/vgic-kvm-device.o \
>   	 vgic/vgic-its.o vgic/vgic-debug.o

> -kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu.o
> +kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu-part.o pmu.o
>   kvm-$(CONFIG_ARM64_PTR_AUTH)  += pauth.o
>   kvm-$(CONFIG_PTDUMP_STAGE2_DEBUGFS) += ptdump.o

> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
> index 7fb1d9e7180f..b5ac5a213877 100644
> --- a/arch/arm64/kvm/debug.c
> +++ b/arch/arm64/kvm/debug.c
> @@ -31,15 +31,18 @@
>    */
>   static void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
>   {
> +	u8 counters = *host_data_ptr(nr_event_counters);
> +	u8 hpmn = kvm_pmu_hpmn(counters);
> +
>   	preempt_disable();

>   	/*
>   	 * This also clears MDCR_EL2_E2PB_MASK and MDCR_EL2_E2TB_MASK
>   	 * to disable guest access to the profiling and trace buffers
>   	 */
> -	vcpu->arch.mdcr_el2 = FIELD_PREP(MDCR_EL2_HPMN,
> -					 *host_data_ptr(nr_event_counters));
> -	vcpu->arch.mdcr_el2 |= (MDCR_EL2_TPM |
> +	vcpu->arch.mdcr_el2 = FIELD_PREP(MDCR_EL2_HPMN, hpmn);
> +	vcpu->arch.mdcr_el2 |= (MDCR_EL2_HPMD |
> +				MDCR_EL2_TPM |
>   				MDCR_EL2_TPMS |
>   				MDCR_EL2_TTRF |
>   				MDCR_EL2_TPMCR |
> diff --git a/arch/arm64/kvm/pmu-part.c b/arch/arm64/kvm/pmu-part.c
> new file mode 100644
> index 000000000000..e74fecc67e37
> --- /dev/null
> +++ b/arch/arm64/kvm/pmu-part.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2025 Google LLC
> + * Author: Colton Lewis <coltonlewis@google.com>
> + */
> +
> +#include <linux/kvm_host.h>
> +#include <linux/perf/arm_pmu.h>
> +
> +#include <asm/kvm_pmu.h>
> +
> +static u8 reserved_host_counters __read_mostly;
> +
> +module_param(reserved_host_counters, byte, 0);
> +MODULE_PARM_DESC(reserved_host_counters,
> +		 "Partition the PMU into host and guest counters");
> +
> +u8 kvm_pmu_get_reserved_counters(void)
> +{
> +	return reserved_host_counters;
> +}
> +
> +u8 kvm_pmu_hpmn(u8 nr_counters)
> +{
> +	if (reserved_host_counters >= nr_counters) {
> +		if (this_cpu_has_cap(ARM64_HAS_HPMN0))
> +			return 0;
> +
> +		return 1;
> +	}
> +
> +	return nr_counters - reserved_host_counters;
> +}
> +
> +void kvm_pmu_partition(struct arm_pmu *pmu)
> +{
> +	u8 nr_counters = *host_data_ptr(nr_event_counters);
> +	u8 hpmn = kvm_pmu_hpmn(nr_counters);
> +
> +	if (hpmn < nr_counters) {
> +		pmu->hpmn = hpmn;
> +		pmu->partitioned = true;
> +	} else {
> +		pmu->hpmn = nr_counters;
> +		pmu->partitioned = false;
> +	}
> +}

There should be a VHE check in here. I thought I wouldn't need it with
moving MDCR_EL2 writes out of the driver but I just remembered there are
two spots in patch 7 I still need to write that register.

> diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
> index 85b5cb432c4f..7169c1a24dd6 100644
> --- a/arch/arm64/kvm/pmu.c
> +++ b/arch/arm64/kvm/pmu.c
> @@ -243,6 +243,8 @@ void kvm_host_pmu_init(struct arm_pmu *pmu)
>   	entry->arm_pmu = pmu;
>   	list_add_tail(&entry->entry, &arm_pmus);

> +	kvm_pmu_partition(pmu);
> +
>   	if (list_is_singular(&arm_pmus))
>   		static_branch_enable(&kvm_arm_pmu_available);

> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index 35c3a85bee43..ee4fc2e26bff 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -125,6 +125,8 @@ struct arm_pmu {

>   	/* Only to be used by ACPI probing code */
>   	unsigned long acpi_cpuid;
> +	u8		hpmn; /* MDCR_EL2.HPMN: counter partition pivot */
> +	bool		partitioned;
>   };

>   #define to_arm_pmu(p) (container_of(p, struct arm_pmu, pmu))
> --
> 2.48.1.601.g30ceb7b040-goog

