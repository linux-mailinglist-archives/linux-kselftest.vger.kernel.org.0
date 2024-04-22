Return-Path: <linux-kselftest+bounces-8630-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DEB8AD185
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 18:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 197F01C227EE
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 16:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6545153596;
	Mon, 22 Apr 2024 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IIcG8VoT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC1A153581
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Apr 2024 16:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713802000; cv=none; b=nCdrBuKHmKnddzAZTYetnY6M27Fi/vO6JMwfSK18iUr95Vce7Awd8aQ02rk4GId/QmWU9XbOM79MCPxRjHC8PqGgju5sp5KzL1SHbAzv/W7huwXJrBL+Mu5iGccCnCxIx/j2djhhr0M3rSmpN2ddd0I8NWwpDETQyRuRwAR9TbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713802000; c=relaxed/simple;
	bh=Pq+IwXgfHTea7oJCPx8f0hI/Vb/vVGxsxYuy44v4DeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sisaYYon/ElZEHvtN/kBTV6/YE85BN3W4SV84PjbIe+LkIk5s/ah5OPql6Kcf4BebR9fyiDxT8jJ5SD3xqsRDgttE41sR4NKWcVzCftwQix7I8NVR+d+ytLNf1YBkFJGiNoSJ4gB/chH1oyj7h8Qe9oADtTDgGPkHIknOwsnrrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=IIcG8VoT; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7da41c6aa37so209595939f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Apr 2024 09:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1713801997; x=1714406797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BlLfyhn8mWAgG7LaLhxMl3R58E+jwif8sheVl+iy1w0=;
        b=IIcG8VoTCr8mu9cwpSsXGGXktxndx/hACq95wQSrxDkurBp0mc1m9Ymb/R/KPHNO2k
         KR9ILjTUekAsUUmYMs2oNaZU164jeMnVx+xeVBcp58xzx5LYrSYIf9fTeJQwhRjYaV1e
         oobRoziWNtu1Fj107nDZHx6fBAlcmK4yzdDzluohRd+hNUba1tCL7aCbZc7rQSSiIzqe
         j7/JMc8/fvAwdpYWgfMI+8Alcn20R8w1nT0MA1NBoG7NK4qbqb92WdtqOzCHwOXPv+Co
         PVLnEghw0l1P+m/tuYpAikqsElUXFPOxZwrdr/58yQu1HncBLZpGT2yutcZ8/yOY53EU
         gi+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713801997; x=1714406797;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BlLfyhn8mWAgG7LaLhxMl3R58E+jwif8sheVl+iy1w0=;
        b=P6nPBItDhwxKf+/6gtxD3C+5Dv2EJHWNBDteE0x+L+XRyE9C0idJwgjG7uehawPSLM
         sr9KeVHzKjijVZ6JvsuxfE0gf4aM3XbFLaQeCJ8EfwlbnIafrIAtIjcK8KdXtGqDjDr8
         t8Y8nDsguBHB3u0nvYmrm047iwtT4beCnKOiCWI2PkJj27VzijVmmmM4No/lmqPEVvPn
         bewAn7tKVUOC/pZWu1GpWZYjMPU8Fj+jyqTUDI89K4cihAhzl+oMADNcpiXmj+CePD9A
         LCPdGTuHeqmunpTfHvZ22J4/nTRWTaOWLObjhP79szPKZaD2rOpRWP2NNIYbYL9VG0sa
         4CQg==
X-Forwarded-Encrypted: i=1; AJvYcCUe/DrOLL7nlaCzKDRQzIf0DzbBd3sPQvwC3iQdb49chuhbfCEfh8uSl4ZfLiZbBT2MdwVS3FqprBqPhRQFEsMkjEEDtbPHUdGu19vNBKFF
X-Gm-Message-State: AOJu0YzQs1zMx7KJdFe2w8ef7raElaBDWhJShEceCJnNRhriIJUfj1Bu
	Sif9gCIPA0RuW05ix9KeGHxogHqkR6pAU2JRrJAFfem4Iq7cLdGra7Eors3z/k0=
X-Google-Smtp-Source: AGHT+IHBf94x35l+oMBJgIxz+ytLVCtBSrQBtpGSPysagcxu6+2BlEIhEOOjWWFTa2t1aFkTGkHKmw==
X-Received: by 2002:a05:6602:6c1c:b0:7d5:e4a5:c20a with SMTP id ik28-20020a0566026c1c00b007d5e4a5c20amr16513177iob.12.1713801996902;
        Mon, 22 Apr 2024 09:06:36 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.197])
        by smtp.gmail.com with ESMTPSA id i17-20020a0566022c9100b007da1efc9b3asm2642998iow.43.2024.04.22.09.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 09:06:36 -0700 (PDT)
Message-ID: <2f43393d-2488-40c8-abde-4dc82a64a829@sifive.com>
Date: Mon, 22 Apr 2024 11:06:32 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/24] drivers/perf: riscv: Implement SBI PMU snapshot
 function
To: Atish Patra <atishp@rivosinc.com>, Anup Patel <anup@brainfault.org>
Cc: Palmer Dabbelt <palmer@rivosinc.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Andrew Jones <ajones@ventanamicro.com>, Ajay Kaher
 <ajay.kaher@broadcom.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Juergen Gross <jgross@suse.com>,
 kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
 Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>,
 virtualization@lists.linux.dev, Will Deacon <will@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
References: <20240420151741.962500-1-atishp@rivosinc.com>
 <20240420151741.962500-10-atishp@rivosinc.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20240420151741.962500-10-atishp@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Atish,

On 2024-04-20 10:17 AM, Atish Patra wrote:
> SBI v2.0 SBI introduced PMU snapshot feature which adds the following
> features.
> 
> 1. Read counter values directly from the shared memory instead of
> csr read.
> 2. Start multiple counters with initial values with one SBI call.
> 
> These functionalities optimizes the number of traps to the higher
> privilege mode. If the kernel is in VS mode while the hypervisor
> deploy trap & emulate method, this would minimize all the hpmcounter
> CSR read traps. If the kernel is running in S-mode, the benefits
> reduced to CSR latency vs DRAM/cache latency as there is no trap
> involved while accessing the hpmcounter CSRs.
> 
> In both modes, it does saves the number of ecalls while starting
> multiple counter together with an initial values. This is a likely
> scenario if multiple counters overflow at the same time.
> 
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  drivers/perf/riscv_pmu.c       |   1 +
>  drivers/perf/riscv_pmu_sbi.c   | 265 ++++++++++++++++++++++++++++++---
>  include/linux/perf/riscv_pmu.h |   6 +
>  3 files changed, 255 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
> index b4efdddb2ad9..36d348753d05 100644
> --- a/drivers/perf/riscv_pmu.c
> +++ b/drivers/perf/riscv_pmu.c
> @@ -408,6 +408,7 @@ struct riscv_pmu *riscv_pmu_alloc(void)
>  		cpuc->n_events = 0;
>  		for (i = 0; i < RISCV_MAX_COUNTERS; i++)
>  			cpuc->events[i] = NULL;
> +		cpuc->snapshot_addr = NULL;
>  	}
>  	pmu->pmu = (struct pmu) {
>  		.event_init	= riscv_pmu_event_init,
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 4eacd89141a9..2694110f1cff 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -58,6 +58,9 @@ PMU_FORMAT_ATTR(event, "config:0-47");
>  PMU_FORMAT_ATTR(firmware, "config:63");
>  
>  static bool sbi_v2_available;
> +static DEFINE_STATIC_KEY_FALSE(sbi_pmu_snapshot_available);
> +#define sbi_pmu_snapshot_available() \
> +	static_branch_unlikely(&sbi_pmu_snapshot_available)
>  
>  static struct attribute *riscv_arch_formats_attr[] = {
>  	&format_attr_event.attr,
> @@ -508,14 +511,105 @@ static int pmu_sbi_event_map(struct perf_event *event, u64 *econfig)
>  	return ret;
>  }
>  
> +static void pmu_sbi_snapshot_free(struct riscv_pmu *pmu)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct cpu_hw_events *cpu_hw_evt = per_cpu_ptr(pmu->hw_events, cpu);
> +
> +		if (!cpu_hw_evt->snapshot_addr)
> +			continue;
> +
> +		free_page((unsigned long)cpu_hw_evt->snapshot_addr);
> +		cpu_hw_evt->snapshot_addr = NULL;
> +		cpu_hw_evt->snapshot_addr_phys = 0;
> +	}
> +}
> +
> +static int pmu_sbi_snapshot_alloc(struct riscv_pmu *pmu)
> +{
> +	int cpu;
> +	struct page *snapshot_page;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct cpu_hw_events *cpu_hw_evt = per_cpu_ptr(pmu->hw_events, cpu);
> +
> +		snapshot_page = alloc_page(GFP_ATOMIC | __GFP_ZERO);
> +		if (!snapshot_page) {
> +			pmu_sbi_snapshot_free(pmu);
> +			return -ENOMEM;
> +		}
> +		cpu_hw_evt->snapshot_addr = page_to_virt(snapshot_page);
> +		cpu_hw_evt->snapshot_addr_phys = page_to_phys(snapshot_page);
> +	}
> +
> +	return 0;
> +}
> +
> +static int pmu_sbi_snapshot_disable(void)
> +{
> +	struct sbiret ret;
> +
> +	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_SNAPSHOT_SET_SHMEM, SBI_SHMEM_DISABLE,
> +			SBI_SHMEM_DISABLE, 0, 0, 0, 0);
> +	if (ret.error) {
> +		pr_warn("failed to disable snapshot shared memory\n");
> +		return sbi_err_map_linux_errno(ret.error);
> +	}
> +
> +	return 0;
> +}
> +
> +static int pmu_sbi_snapshot_setup(struct riscv_pmu *pmu, int cpu)
> +{
> +	struct cpu_hw_events *cpu_hw_evt;
> +	struct sbiret ret = {0};
> +
> +	cpu_hw_evt = per_cpu_ptr(pmu->hw_events, cpu);
> +	if (!cpu_hw_evt->snapshot_addr_phys)
> +		return -EINVAL;
> +
> +	if (cpu_hw_evt->snapshot_set_done)
> +		return 0;
> +
> +	if (IS_ENABLED(CONFIG_32BIT))
> +		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_SNAPSHOT_SET_SHMEM,
> +				cpu_hw_evt->snapshot_addr_phys,
> +				(u64)(cpu_hw_evt->snapshot_addr_phys) >> 32, 0, 0, 0, 0);
> +	else
> +		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_SNAPSHOT_SET_SHMEM,
> +				cpu_hw_evt->snapshot_addr_phys, 0, 0, 0, 0, 0);
> +
> +	/* Free up the snapshot area memory and fall back to SBI PMU calls without snapshot */
> +	if (ret.error) {
> +		if (ret.error != SBI_ERR_NOT_SUPPORTED)
> +			pr_warn("pmu snapshot setup failed with error %ld\n", ret.error);
> +		return sbi_err_map_linux_errno(ret.error);
> +	}
> +
> +	cpu_hw_evt->snapshot_set_done = true;
> +
> +	return 0;
> +}
> +
>  static u64 pmu_sbi_ctr_read(struct perf_event *event)
>  {
>  	struct hw_perf_event *hwc = &event->hw;
>  	int idx = hwc->idx;
>  	struct sbiret ret;
>  	u64 val = 0;
> +	struct riscv_pmu *pmu = to_riscv_pmu(event->pmu);
> +	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
> +	struct riscv_pmu_snapshot_data *sdata = cpu_hw_evt->snapshot_addr;
>  	union sbi_pmu_ctr_info info = pmu_ctr_list[idx];
>  
> +	/* Read the value from the shared memory directly only if counter is stopped */
> +	if (sbi_pmu_snapshot_available() & (hwc->state & PERF_HES_STOPPED)) {

nit: logical && between the two conditions

> +		val = sdata->ctr_values[idx];
> +		return val;
> +	}
> +
>  	if (pmu_sbi_is_fw_event(event)) {
>  		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_FW_READ,
>  				hwc->idx, 0, 0, 0, 0, 0);
> @@ -565,6 +659,7 @@ static void pmu_sbi_ctr_start(struct perf_event *event, u64 ival)
>  	struct hw_perf_event *hwc = &event->hw;
>  	unsigned long flag = SBI_PMU_START_FLAG_SET_INIT_VALUE;
>  
> +	/* There is no benefit setting SNAPSHOT FLAG for a single counter */
>  #if defined(CONFIG_32BIT)
>  	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, hwc->idx,
>  			1, flag, ival, ival >> 32, 0);
> @@ -585,16 +680,36 @@ static void pmu_sbi_ctr_stop(struct perf_event *event, unsigned long flag)
>  {
>  	struct sbiret ret;
>  	struct hw_perf_event *hwc = &event->hw;
> +	struct riscv_pmu *pmu = to_riscv_pmu(event->pmu);
> +	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
> +	struct riscv_pmu_snapshot_data *sdata = cpu_hw_evt->snapshot_addr;
>  
>  	if ((hwc->flags & PERF_EVENT_FLAG_USER_ACCESS) &&
>  	    (hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT))
>  		pmu_sbi_reset_scounteren((void *)event);
>  
> +	if (sbi_pmu_snapshot_available())
> +		flag |= SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT;
> +
>  	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, hwc->idx, 1, flag, 0, 0, 0);
> -	if (ret.error && (ret.error != SBI_ERR_ALREADY_STOPPED) &&
> -		flag != SBI_PMU_STOP_FLAG_RESET)
> +	if (!ret.error && sbi_pmu_snapshot_available()) {
> +		/*
> +		 * The counter snapshot is based on the index base specified by hwc->idx.
> +		 * The actual counter value is updated in shared memory at index 0 when counter
> +		 * mask is 0x01. To ensure accurate counter values, it's necessary to transfer
> +		 * the counter value to shared memory. However, if hwc->idx is zero, the counter
> +		 * value is already correctly updated in shared memory, requiring no further
> +		 * adjustment.
> +		 */
> +		if (hwc->idx > 0) {
> +			sdata->ctr_values[hwc->idx] = sdata->ctr_values[0];
> +			sdata->ctr_values[0] = 0;
> +		}
> +	} else if (ret.error && (ret.error != SBI_ERR_ALREADY_STOPPED) &&
> +		flag != SBI_PMU_STOP_FLAG_RESET) {
>  		pr_err("Stopping counter idx %d failed with error %d\n",
>  			hwc->idx, sbi_err_map_linux_errno(ret.error));
> +	}
>  }
>  
>  static int pmu_sbi_find_num_ctrs(void)
> @@ -652,12 +767,39 @@ static inline void pmu_sbi_stop_all(struct riscv_pmu *pmu)
>  static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
>  {
>  	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
> +	struct riscv_pmu_snapshot_data *sdata = cpu_hw_evt->snapshot_addr;
> +	unsigned long flag = 0;
>  	int i;
> +	struct sbiret ret;
> +	unsigned long temp_ctr_values[64] = {0};
> +	unsigned long ctr_val, temp_ctr_overflow_mask = 0;
>  
> -	for (i = 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++)
> +	if (sbi_pmu_snapshot_available())
> +		flag = SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT;
> +
> +	for (i = 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++) {
>  		/* No need to check the error here as we can't do anything about the error */
> -		sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, i * BITS_PER_LONG,
> -			  cpu_hw_evt->used_hw_ctrs[i], 0, 0, 0, 0);
> +		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, i * BITS_PER_LONG,
> +				cpu_hw_evt->used_hw_ctrs[i], flag, 0, 0, 0);
> +		if (!ret.error && sbi_pmu_snapshot_available()) {
> +			/* Save the counter values to avoid clobbering */
> +			temp_ctr_values[i * BITS_PER_LONG + i] = sdata->ctr_values[i];
> +			/* Save the overflow mask to avoid clobbering */
> +			if (BIT(i) & sdata->ctr_overflow_mask)
> +				temp_ctr_overflow_mask |= BIT(i + i * BITS_PER_LONG);

`i` is iterating over longs here, not individual counters. Using `i` twice in
the same expression like this makes no sense.

And again, since you made temp_ctr_overflow_mask an `unsigned long`, this BIT
expression overflows during the second iteration of the loop on riscv32.

> +		}
> +	}
> +
> +	/* Restore the counter values to the shared memory */
> +	if (sbi_pmu_snapshot_available()) {
> +		for (i = 0; i < 64; i++) {
> +			ctr_val = temp_ctr_values[i];
> +			if (ctr_val)
> +				sdata->ctr_values[i] = ctr_val;

It is entirely possible for the correct value of a counter to be zero when some
other counter overflows. But here if a counter with value zero is clobbered by a
nonzero value, the correct value will not be restored.

> +			if (temp_ctr_overflow_mask)
> +				sdata->ctr_overflow_mask = temp_ctr_overflow_mask;

This doesn't need to be inside the loop. And if temp_ctr_overflow_mask is the
64-bit combination of the two 32-bit values from the SBI calls (which seems to
be the intention), then we already know there is at least one set bit, since
this is called from the overflow IRQ handler.

> +		}
> +	}
>  }
>  
>  /*
> @@ -666,11 +808,10 @@ static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
>   * while the overflowed counters need to be started with updated initialization
>   * value.
>   */
> -static inline void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
> -					       unsigned long ctr_ovf_mask)
> +static inline void pmu_sbi_start_ovf_ctrs_sbi(struct cpu_hw_events *cpu_hw_evt,
> +					      u64 ctr_ovf_mask)
>  {
>  	int idx = 0, i;
> -	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
>  	struct perf_event *event;
>  	unsigned long flag = SBI_PMU_START_FLAG_SET_INIT_VALUE;
>  	unsigned long ctr_start_mask = 0;
> @@ -706,6 +847,48 @@ static inline void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
>  	}
>  }
>  
> +static inline void pmu_sbi_start_ovf_ctrs_snapshot(struct cpu_hw_events *cpu_hw_evt,
> +						   u64 ctr_ovf_mask)
> +{
> +	int idx = 0;
> +	struct perf_event *event;
> +	unsigned long flag = SBI_PMU_START_FLAG_INIT_SNAPSHOT;
> +	u64 max_period, init_val = 0;
> +	struct hw_perf_event *hwc;
> +	struct riscv_pmu_snapshot_data *sdata = cpu_hw_evt->snapshot_addr;
> +
> +	for_each_set_bit(idx, cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS) {
> +		if (ctr_ovf_mask & BIT(idx)) {
> +			event = cpu_hw_evt->events[idx];
> +			hwc = &event->hw;
> +			max_period = riscv_pmu_ctr_get_width_mask(event);
> +			init_val = local64_read(&hwc->prev_count) & max_period;
> +			sdata->ctr_values[idx] = init_val;
> +		}
> +		/*
> +		 * We do not need to update the non-overflow counters the previous
> +		 * value should have been there already.
> +		 */
> +	}
> +
> +	for (idx = 0; idx < BITS_TO_LONGS(RISCV_MAX_COUNTERS); idx++) {
> +		/* Start all the counters in a single shot */
> +		sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, idx * BITS_PER_LONG,
> +			  cpu_hw_evt->used_hw_ctrs[idx], flag, 0, 0, 0);

This doesn't work either... for riscv32 you have to copy the initial values for
counters 32-63 to ctr_values indexes 0-31, since that is where the SBI
implementation expects to find them. And since this clobbers counters 0-31,
those need to be preserved somewhere. That's why I recommended a shadow copy of
ctr_values -- globally, not local to pmu_sbi_stop_hw_ctrs().

Also, you need SBI_PMU_START_FLAG_INIT_SNAPSHOT here to actually load the values
from shared memory, so this is broken on riscv64 as well.

> +	}
> +}
> +
> +static void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
> +					u64 ctr_ovf_mask)
> +{
> +	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
> +
> +	if (sbi_pmu_snapshot_available())
> +		pmu_sbi_start_ovf_ctrs_snapshot(cpu_hw_evt, ctr_ovf_mask);
> +	else
> +		pmu_sbi_start_ovf_ctrs_sbi(cpu_hw_evt, ctr_ovf_mask);
> +}
> +
>  static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>  {
>  	struct perf_sample_data data;
> @@ -716,9 +899,10 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>  	struct riscv_pmu *pmu;
>  	struct perf_event *event;
>  	unsigned long overflow;
> -	unsigned long overflowed_ctrs = 0;
> +	u64 overflowed_ctrs = 0;
>  	struct cpu_hw_events *cpu_hw_evt = dev;
>  	u64 start_clock = sched_clock();
> +	struct riscv_pmu_snapshot_data *sdata = cpu_hw_evt->snapshot_addr;
>  
>  	if (WARN_ON_ONCE(!cpu_hw_evt))
>  		return IRQ_NONE;
> @@ -740,7 +924,10 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>  	pmu_sbi_stop_hw_ctrs(pmu);
>  
>  	/* Overflow status register should only be read after counter are stopped */
> -	ALT_SBI_PMU_OVERFLOW(overflow);
> +	if (sbi_pmu_snapshot_available())
> +		overflow = sdata->ctr_overflow_mask;

Overflow is `unsigned long`, so this assignment truncates ctr_overflow_mask on
riscv32.

Was this series tested on riscv32?

Regards,
Samuel

> +	else
> +		ALT_SBI_PMU_OVERFLOW(overflow);
>  
>  	/*
>  	 * Overflow interrupt pending bit should only be cleared after stopping
> @@ -766,9 +953,14 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>  		if (!info || info->type != SBI_PMU_CTR_TYPE_HW)
>  			continue;
>  
> -		/* compute hardware counter index */
> -		hidx = info->csr - CSR_CYCLE;
> -		/* check if the corresponding bit is set in sscountovf */
> +		if (sbi_pmu_snapshot_available())
> +			/* SBI implementation already updated the logical indicies */
> +			hidx = lidx;
> +		else
> +			/* compute hardware counter index */
> +			hidx = info->csr - CSR_CYCLE;
> +
> +		/* check if the corresponding bit is set in sscountovf or overflow mask in shmem */
>  		if (!(overflow & BIT(hidx)))
>  			continue;
>  
> @@ -778,7 +970,10 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>  		 */
>  		overflowed_ctrs |= BIT(lidx);
>  		hw_evt = &event->hw;
> +		/* Update the event states here so that we know the state while reading */
> +		hw_evt->state |= PERF_HES_STOPPED;
>  		riscv_pmu_event_update(event);
> +		hw_evt->state |= PERF_HES_UPTODATE;
>  		perf_sample_data_init(&data, 0, hw_evt->last_period);
>  		if (riscv_pmu_event_set_period(event)) {
>  			/*
> @@ -791,6 +986,8 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>  			 */
>  			perf_event_overflow(event, &data, regs);
>  		}
> +		/* Reset the state as we are going to start the counter after the loop */
> +		hw_evt->state = 0;
>  	}
>  
>  	pmu_sbi_start_overflow_mask(pmu, overflowed_ctrs);
> @@ -822,6 +1019,9 @@ static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
>  		enable_percpu_irq(riscv_pmu_irq, IRQ_TYPE_NONE);
>  	}
>  
> +	if (sbi_pmu_snapshot_available())
> +		return pmu_sbi_snapshot_setup(pmu, cpu);
> +
>  	return 0;
>  }
>  
> @@ -834,6 +1034,9 @@ static int pmu_sbi_dying_cpu(unsigned int cpu, struct hlist_node *node)
>  	/* Disable all counters access for user mode now */
>  	csr_write(CSR_SCOUNTEREN, 0x0);
>  
> +	if (sbi_pmu_snapshot_available())
> +		return pmu_sbi_snapshot_disable();
> +
>  	return 0;
>  }
>  
> @@ -942,6 +1145,12 @@ static inline void riscv_pm_pmu_unregister(struct riscv_pmu *pmu) { }
>  
>  static void riscv_pmu_destroy(struct riscv_pmu *pmu)
>  {
> +	if (sbi_v2_available) {
> +		if (sbi_pmu_snapshot_available()) {
> +			pmu_sbi_snapshot_disable();
> +			pmu_sbi_snapshot_free(pmu);
> +		}
> +	}
>  	riscv_pm_pmu_unregister(pmu);
>  	cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
>  }
> @@ -1109,10 +1318,6 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
>  	pmu->event_unmapped = pmu_sbi_event_unmapped;
>  	pmu->csr_index = pmu_sbi_csr_index;
>  
> -	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
> -	if (ret)
> -		return ret;
> -
>  	ret = riscv_pm_pmu_register(pmu);
>  	if (ret)
>  		goto out_unregister;
> @@ -1121,8 +1326,34 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto out_unregister;
>  
> +	/* SBI PMU Snapsphot is only available in SBI v2.0 */
> +	if (sbi_v2_available) {
> +		ret = pmu_sbi_snapshot_alloc(pmu);
> +		if (ret)
> +			goto out_unregister;
> +
> +		ret = pmu_sbi_snapshot_setup(pmu, smp_processor_id());
> +		if (ret) {
> +			/* Snapshot is an optional feature. Continue if not available */
> +			pmu_sbi_snapshot_free(pmu);
> +		} else {
> +			pr_info("SBI PMU snapshot detected\n");
> +			/*
> +			 * We enable it once here for the boot cpu. If snapshot shmem setup
> +			 * fails during cpu hotplug process, it will fail to start the cpu
> +			 * as we can not handle hetergenous PMUs with different snapshot
> +			 * capability.
> +			 */
> +			static_branch_enable(&sbi_pmu_snapshot_available);
> +		}
> +	}
> +
>  	register_sysctl("kernel", sbi_pmu_sysctl_table);
>  
> +	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
> +	if (ret)
> +		goto out_unregister;
> +
>  	return 0;
>  
>  out_unregister:
> diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
> index 43282e22ebe1..c3fa90970042 100644
> --- a/include/linux/perf/riscv_pmu.h
> +++ b/include/linux/perf/riscv_pmu.h
> @@ -39,6 +39,12 @@ struct cpu_hw_events {
>  	DECLARE_BITMAP(used_hw_ctrs, RISCV_MAX_COUNTERS);
>  	/* currently enabled firmware counters */
>  	DECLARE_BITMAP(used_fw_ctrs, RISCV_MAX_COUNTERS);
> +	/* The virtual address of the shared memory where counter snapshot will be taken */
> +	void *snapshot_addr;
> +	/* The physical address of the shared memory where counter snapshot will be taken */
> +	phys_addr_t snapshot_addr_phys;
> +	/* Boolean flag to indicate setup is already done */
> +	bool snapshot_set_done;
>  };
>  
>  struct riscv_pmu {


