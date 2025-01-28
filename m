Return-Path: <linux-kselftest+bounces-25313-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 174BAA20DBF
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 16:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49FB0188338D
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 15:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB5B1D7E54;
	Tue, 28 Jan 2025 15:55:08 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2771D9346;
	Tue, 28 Jan 2025 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738079708; cv=none; b=FRVi0XMCEnZiVkh5WaZ1iqyJ/GM2flM295zHlaMfuESDN7iACkYTldL1WZemO5i8e635yjg5fHf0tjDZx7oFICTT6Y79O/q67JDvAfeISKl/4TuhP2XaDS46krtr1VGsQxMZdqX3LlXbw5benA5mFgYuowNsfLzGH9mo5JUZRlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738079708; c=relaxed/simple;
	bh=so9RNA6ObIf2W+UYW4qNUZcIrSOzvcMSJEizI4dEGzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sa+Bich8Kt6023VzHHGCR3JSUcRMsXwV7rVUka3oSQqeR1dXTHXmgXajp9ti+24wTqk3lhBb7eXapSu0oirVh0ehx/YeSmggyn79R0K8Ux8pE/H6pEP+ASQ3rJu9nTCgCVfz66sYWGK0a/Uh4RTl8RLz2W5vQVgfT40T8EN/08A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2146497;
	Tue, 28 Jan 2025 07:55:30 -0800 (PST)
Received: from [10.57.34.26] (unknown [10.57.34.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 015DB3F694;
	Tue, 28 Jan 2025 07:55:01 -0800 (PST)
Message-ID: <a6152acf-67e1-4800-857f-cffb35a5d738@arm.com>
Date: Tue, 28 Jan 2025 15:55:00 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/4] perf: arm_pmuv3: Keep out of guest counter
 partition
Content-Language: en-GB
To: Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Joey Gouly <joey.gouly@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 Mark Rutland <mark.rutland@arm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-kselftest@vger.kernel.org
References: <20250127222031.3078945-1-coltonlewis@google.com>
 <20250127222031.3078945-5-coltonlewis@google.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20250127222031.3078945-5-coltonlewis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/01/2025 22:20, Colton Lewis wrote:
> If the PMU is partitioned, keep the driver out of the guest counter
> partition and only use the host counter partition. Partitioning is
> defined by the MDCR_EL2.HPMN register field and saved in
> cpu_pmu->hpmn. The range 0..HPMN-1 is accessible by EL1 and EL0 while
> HPMN..PMCR.N is reserved for EL2.
> 
> Define some macros that take HPMN as an argument and construct
> mutually exclusive bitmaps for testing which partition a particular
> counter is in. Note that despite their different position in the
> bitmap, the cycle and instruction counters are always in the guest
> partition.
> 
> Signed-off-by: Colton Lewis <coltonlewis@google.com>
> ---
>   drivers/perf/arm_pmuv3.c       | 72 +++++++++++++++++++++++++++++-----
>   include/linux/perf/arm_pmuv3.h |  8 ++++
>   2 files changed, 70 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> index 55f9ae560715..c61845fad9d9 100644
> --- a/drivers/perf/arm_pmuv3.c
> +++ b/drivers/perf/arm_pmuv3.c
> @@ -754,15 +754,19 @@ static void armv8pmu_disable_event_irq(struct perf_event *event)
>   	armv8pmu_disable_intens(BIT(event->hw.idx));
>   }
>   
> -static u64 armv8pmu_getreset_flags(void)
> +static u64 armv8pmu_getreset_flags(struct arm_pmu *cpu_pmu)
>   {
>   	u64 value;
>   
>   	/* Read */
>   	value = read_pmovsclr();
>   
> +	if (cpu_pmu->partitioned)
> +		value &= ARMV8_PMU_HOST_CNT_PART(cpu_pmu->hpmn);
> +	else
> +		value &= ARMV8_PMU_OVERFLOWED_MASK;
> +
>   	/* Write to clear flags */
> -	value &= ARMV8_PMU_OVERFLOWED_MASK;
>   	write_pmovsclr(value);
>   
>   	return value;
> @@ -789,6 +793,18 @@ static void armv8pmu_disable_user_access(void)
>   	update_pmuserenr(0);
>   }
>   
> +static bool armv8pmu_is_guest_part(struct arm_pmu *cpu_pmu, u8 idx)
> +{
> +	return cpu_pmu->partitioned &&
> +		(BIT(idx) & ARMV8_PMU_GUEST_CNT_PART(cpu_pmu->hpmn));
> +}
> +
> +static bool armv8pmu_is_host_part(struct arm_pmu *cpu_pmu, u8 idx)
> +{
> +	return !cpu_pmu->partitioned ||
> +		(BIT(idx) & ARMV8_PMU_HOST_CNT_PART(cpu_pmu->hpmn));
> +}
> +
>   static void armv8pmu_enable_user_access(struct arm_pmu *cpu_pmu)
>   {
>   	int i;
> @@ -797,6 +813,8 @@ static void armv8pmu_enable_user_access(struct arm_pmu *cpu_pmu)
>   	if (is_pmuv3p9(cpu_pmu->pmuver)) {
>   		u64 mask = 0;
>   		for_each_set_bit(i, cpuc->used_mask, ARMPMU_MAX_HWEVENTS) {
> +			if (armv8pmu_is_guest_part(cpu_pmu, i))
> +				continue;
>   			if (armv8pmu_event_has_user_read(cpuc->events[i]))
>   				mask |= BIT(i);
>   		}
> @@ -805,6 +823,8 @@ static void armv8pmu_enable_user_access(struct arm_pmu *cpu_pmu)
>   		/* Clear any unused counters to avoid leaking their contents */
>   		for_each_andnot_bit(i, cpu_pmu->cntr_mask, cpuc->used_mask,
>   				    ARMPMU_MAX_HWEVENTS) {
> +			if (armv8pmu_is_guest_part(cpu_pmu, i))
> +				continue;
>   			if (i == ARMV8_PMU_CYCLE_IDX)
>   				write_pmccntr(0);
>   			else if (i == ARMV8_PMU_INSTR_IDX)
> @@ -850,7 +870,10 @@ static void armv8pmu_start(struct arm_pmu *cpu_pmu)
>   		armv8pmu_disable_user_access();
>   
>   	/* Enable all counters */
> -	armv8pmu_pmcr_write(armv8pmu_pmcr_read() | ARMV8_PMU_PMCR_E);
> +	if (cpu_pmu->partitioned)
> +		armv8pmu_mdcr_write(armv8pmu_mdcr_read() | ARMV8_PMU_MDCR_HPME);
> +	else
> +		armv8pmu_pmcr_write(armv8pmu_pmcr_read() | ARMV8_PMU_PMCR_E);
>   
>   	kvm_vcpu_pmu_resync_el0();
>   }
> @@ -858,7 +881,10 @@ static void armv8pmu_start(struct arm_pmu *cpu_pmu)
>   static void armv8pmu_stop(struct arm_pmu *cpu_pmu)
>   {
>   	/* Disable all counters */
> -	armv8pmu_pmcr_write(armv8pmu_pmcr_read() & ~ARMV8_PMU_PMCR_E);
> +	if (cpu_pmu->partitioned)
> +		armv8pmu_mdcr_write(armv8pmu_pmcr_read() & ~ARMV8_PMU_MDCR_HPME);

typo: s/armv8pmu_pmcr_read/armv8pmu_mdcr_read


Suzuki


> +	else
> +		armv8pmu_pmcr_write(armv8pmu_pmcr_read() & ~ARMV8_PMU_PMCR_E);
>   }
>   
>   static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
> @@ -872,7 +898,7 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
>   	/*
>   	 * Get and reset the IRQ flags
>   	 */
> -	pmovsr = armv8pmu_getreset_flags();
> +	pmovsr = armv8pmu_getreset_flags(cpu_pmu);
>   
>   	/*
>   	 * Did an overflow occur?
> @@ -930,6 +956,8 @@ static int armv8pmu_get_single_idx(struct pmu_hw_events *cpuc,
>   	int idx;
>   
>   	for_each_set_bit(idx, cpu_pmu->cntr_mask, ARMV8_PMU_MAX_GENERAL_COUNTERS) {
> +		if (armv8pmu_is_guest_part(cpu_pmu, idx))
> +			continue;
>   		if (!test_and_set_bit(idx, cpuc->used_mask))
>   			return idx;
>   	}
> @@ -946,6 +974,8 @@ static int armv8pmu_get_chain_idx(struct pmu_hw_events *cpuc,
>   	 * the lower idx must be even.
>   	 */
>   	for_each_set_bit(idx, cpu_pmu->cntr_mask, ARMV8_PMU_MAX_GENERAL_COUNTERS) {
> +		if (armv8pmu_is_guest_part(cpu_pmu, idx))
> +			continue;
>   		if (!(idx & 0x1))
>   			continue;
>   		if (!test_and_set_bit(idx, cpuc->used_mask)) {
> @@ -968,6 +998,7 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
>   
>   	/* Always prefer to place a cycle counter into the cycle counter. */
>   	if ((evtype == ARMV8_PMUV3_PERFCTR_CPU_CYCLES) &&
> +	    !cpu_pmu->partitioned &&
>   	    !armv8pmu_event_get_threshold(&event->attr)) {
>   		if (!test_and_set_bit(ARMV8_PMU_CYCLE_IDX, cpuc->used_mask))
>   			return ARMV8_PMU_CYCLE_IDX;
> @@ -983,6 +1014,7 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
>   	 * may not know how to handle it.
>   	 */
>   	if ((evtype == ARMV8_PMUV3_PERFCTR_INST_RETIRED) &&
> +	    !cpu_pmu->partitioned &&
>   	    !armv8pmu_event_get_threshold(&event->attr) &&
>   	    test_bit(ARMV8_PMU_INSTR_IDX, cpu_pmu->cntr_mask) &&
>   	    !armv8pmu_event_want_user_access(event)) {
> @@ -994,7 +1026,7 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
>   	 * Otherwise use events counters
>   	 */
>   	if (armv8pmu_event_is_chained(event))
> -		return	armv8pmu_get_chain_idx(cpuc, cpu_pmu);
> +		return armv8pmu_get_chain_idx(cpuc, cpu_pmu);
>   	else
>   		return armv8pmu_get_single_idx(cpuc, cpu_pmu);
>   }
> @@ -1086,6 +1118,15 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
>   	return 0;
>   }
>   
> +static void armv8pmu_reset_host_counters(struct arm_pmu *cpu_pmu)
> +{
> +	int idx;
> +
> +	for_each_set_bit(idx, cpu_pmu->cntr_mask, ARMV8_PMU_MAX_GENERAL_COUNTERS)
> +		if (armv8pmu_is_host_part(cpu_pmu, idx))
> +			armv8pmu_write_evcntr(idx, 0);
> +}
> +
>   static void armv8pmu_reset(void *info)
>   {
>   	struct arm_pmu *cpu_pmu = (struct arm_pmu *)info;
> @@ -1093,8 +1134,10 @@ static void armv8pmu_reset(void *info)
>   
>   	bitmap_to_arr64(&mask, cpu_pmu->cntr_mask, ARMPMU_MAX_HWEVENTS);
>   
> -	if (cpu_pmu->partitioned)
> +	if (cpu_pmu->partitioned) {
>   		armv8pmu_partition(cpu_pmu->hpmn);
> +		mask &= ARMV8_PMU_HOST_CNT_PART(cpu_pmu->hpmn);
> +	}
>   
>   	/* The counter and interrupt enable registers are unknown at reset. */
>   	armv8pmu_disable_counter(mask);
> @@ -1103,11 +1146,20 @@ static void armv8pmu_reset(void *info)
>   	/* Clear the counters we flip at guest entry/exit */
>   	kvm_clr_pmu_events(mask);
>   
> +
> +	pmcr = ARMV8_PMU_PMCR_LC;
> +
>   	/*
> -	 * Initialize & Reset PMNC. Request overflow interrupt for
> -	 * 64 bit cycle counter but cheat in armv8pmu_write_counter().
> +	 * Initialize & Reset PMNC. Request overflow interrupt for 64
> +	 * bit cycle counter but cheat in armv8pmu_write_counter().
> +	 *
> +	 * When partitioned, there is no single bit to reset only the
> +	 * host counters. so reset them individually.
>   	 */
> -	pmcr = ARMV8_PMU_PMCR_P | ARMV8_PMU_PMCR_C | ARMV8_PMU_PMCR_LC;
> +	if (cpu_pmu->partitioned)
> +		armv8pmu_reset_host_counters(cpu_pmu);
> +	else
> +		pmcr = ARMV8_PMU_PMCR_P | ARMV8_PMU_PMCR_C;
>   
>   	/* Enable long event counter support where available */
>   	if (armv8pmu_has_long_event(cpu_pmu))
> diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
> index 115ee39f693a..5f8b143794ce 100644
> --- a/include/linux/perf/arm_pmuv3.h
> +++ b/include/linux/perf/arm_pmuv3.h
> @@ -247,6 +247,14 @@
>   #define ARMV8_PMU_OVSR_F		ARMV8_PMU_CNT_MASK_F
>   /* Mask for writable bits is both P and C fields */
>   #define ARMV8_PMU_OVERFLOWED_MASK	ARMV8_PMU_CNT_MASK_ALL
> +
> +/* Masks for guest and host counter partitions */
> +#define ARMV8_PMU_HPMN_CNT_MASK(N)	GENMASK((N) - 1, 0)
> +#define ARMV8_PMU_GUEST_CNT_PART(N)	(ARMV8_PMU_HPMN_CNT_MASK(N) | \
> +					 ARMV8_PMU_CNT_MASK_C | \
> +					 ARMV8_PMU_CNT_MASK_F)
> +#define ARMV8_PMU_HOST_CNT_PART(N)	(ARMV8_PMU_CNT_MASK_ALL & \
> +					 ~ARMV8_PMU_GUEST_CNT_PART(N))
>   /*
>    * PMXEVTYPER: Event selection reg
>    */


