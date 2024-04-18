Return-Path: <linux-kselftest+bounces-8294-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCEB8A9460
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 09:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A95C91F21206
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 07:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336E175811;
	Thu, 18 Apr 2024 07:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qKJdUaBq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28F73B79F
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 07:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713426460; cv=none; b=CBk1HNBGYOPpqwdsoAFalY0PNwGwMMZ+ox04tRWuvaJKZMvH6Qk3gGi9bDdXFt7nRA8v6f1NMUiTQGABh6kNScwgqU3ZZOS73qaROCKRcuAvFMm5nfIdd9fwV5BYDFFyojdJf/3S80QTpYx1WXNBI5nV9O27lQ9yC3UxQDT05KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713426460; c=relaxed/simple;
	bh=izB5m2HZGolw4caLP/xgSKjFA4pBfkvEHZeQeDAUb0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CPNx1q8Co96gNaPhVtZWbCjOlr/pP7yYJCoXwpXRaPXVDiwR2LVUrtcYpY2/aAvbfkeDXnJMDMgMFoy+8F+6NUZVDJMOOzPw1/5Ty09CktyuRtAGNeG96IqylWGcv0YBvDJpzBIAUG0cuEVnrK71fy7P1MnrnHE39l8EtnD7JtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=qKJdUaBq; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e65b29f703so4960765ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 00:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713426456; x=1714031256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gd6gFPZAxx+5gcu4yDf2LXosDfIMjdL2yzTP/d3RPS4=;
        b=qKJdUaBqoIc4BrycWsO+XM6YXW8cqfXtj/9BM9iB5qNtzGnQUFJZrlRf3R10AdlAF+
         7G2i1hpIyMmsGBZqHg+bK8Ofqy4DUIOXTlk6dEfX2HGLhYsOEGVolddKQ9Nnpu6/pHqa
         6xsLHnqIdKY7UyK5GDDjPTga+qURhy/sglHMdZWob2UQJq+UB8gbdVNQC1mqQC/jEFSj
         C6v6drUTKXj3GfKxaYwCByp0BfNLQbA0bLIORByV8Q5bjXKTipvAJQnf6cUTvH4d1mrK
         zunU3VZclFmlSlWsus9vySppTIGxBUAdCD/AWXx/Hqdw+mH0UjPrhVem7PSixOP3G81M
         TssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713426456; x=1714031256;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gd6gFPZAxx+5gcu4yDf2LXosDfIMjdL2yzTP/d3RPS4=;
        b=fNuaSlfwYG/5OfyUSszfdCRefItsQuSxQYn+ih/aQSIIVvTYPjFbx+Cl5ukopyb3BH
         yDRhhdUfRA5YC0fIz4d3vxJ3PRJJOj+gdX7S9gLPYpp7hebxTt+J+DKYonllLO6W/kFQ
         mGO3Xeycn6FHx99r5dtwQpEEGJCLU9Xr7bLjZJVabkn6NfifWHP0lnfCByYH4F4dZn84
         /Ho3UcQePUHq7sNbtiHkhwuUd7ehgpeJxnI1u4zwY1cCN71222HB6Je2/xBZI4o0ivro
         Wvv1Eb1cP8ywfTsJWB7Jln6Jwyn+x/QVnFpenMIavDa2r0NIbR95QVBP0XXZxvRtH1rL
         EPSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcJne0v6SukY6SaRDR51LUX7KFmmYOgL2XGe/OXh5kdCacd2HnUdqiPOv6K27cw92/G829pfYC9KyaCGc8BMukuKIyDia3Ck2DdKZIFw2h
X-Gm-Message-State: AOJu0YwE5z5LV3/fmjuE43WdRt5sRHu/MOc4MiEyuU6e/mDCUBuG8OZI
	15u0pOtZZpV9ZfBuyBTZ8PeFRWO6Olk78IHYxbH2m0UNYYVm2N3XnMbfpRUa5wc=
X-Google-Smtp-Source: AGHT+IFxUI0TO/Mu+JQwu55GwuTNCWFBnkQHYdj4RpkZpl0DdDZgopHUoXL2TFsSmwarUaX0nfOaMQ==
X-Received: by 2002:a17:902:7409:b0:1e8:4063:6deb with SMTP id g9-20020a170902740900b001e840636debmr1839510pll.15.1713426455945;
        Thu, 18 Apr 2024 00:47:35 -0700 (PDT)
Received: from [172.16.0.39] (c-67-188-2-18.hsd1.ca.comcast.net. [67.188.2.18])
        by smtp.gmail.com with ESMTPSA id t2-20020a170902a5c200b001e26d572f9esm861052plq.242.2024.04.18.00.47.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 00:47:35 -0700 (PDT)
Message-ID: <c3dab594-473e-4644-9543-66c172ae61bb@rivosinc.com>
Date: Thu, 18 Apr 2024 00:47:32 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/24] drivers/perf: riscv: Implement SBI PMU snapshot
 function
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, Anup Patel <anup@brainfault.org>,
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
References: <20240416184421.3693802-1-atishp@rivosinc.com>
 <20240416184421.3693802-9-atishp@rivosinc.com>
 <d4923b62-3cda-4bdd-900e-265059593cf2@sifive.com>
Content-Language: en-US
From: Atish Patra <atishp@rivosinc.com>
In-Reply-To: <d4923b62-3cda-4bdd-900e-265059593cf2@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/16/24 21:02, Samuel Holland wrote:
> Hi Atish,
>
> On 2024-04-16 1:44 PM, Atish Patra wrote:
>> SBI v2.0 SBI introduced PMU snapshot feature which adds the following
>> features.
>>
>> 1. Read counter values directly from the shared memory instead of
>> csr read.
>> 2. Start multiple counters with initial values with one SBI call.
>>
>> These functionalities optimizes the number of traps to the higher
>> privilege mode. If the kernel is in VS mode while the hypervisor
>> deploy trap & emulate method, this would minimize all the hpmcounter
>> CSR read traps. If the kernel is running in S-mode, the benefits
>> reduced to CSR latency vs DRAM/cache latency as there is no trap
>> involved while accessing the hpmcounter CSRs.
>>
>> In both modes, it does saves the number of ecalls while starting
>> multiple counter together with an initial values. This is a likely
>> scenario if multiple counters overflow at the same time.
>>
>> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>> Reviewed-by: Anup Patel <anup@brainfault.org>
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
>> ---
>>   drivers/perf/riscv_pmu.c       |   1 +
>>   drivers/perf/riscv_pmu_sbi.c   | 224 +++++++++++++++++++++++++++++++--
>>   include/linux/perf/riscv_pmu.h |   6 +
>>   3 files changed, 219 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
>> index b4efdddb2ad9..36d348753d05 100644
>> --- a/drivers/perf/riscv_pmu.c
>> +++ b/drivers/perf/riscv_pmu.c
>> @@ -408,6 +408,7 @@ struct riscv_pmu *riscv_pmu_alloc(void)
>>   		cpuc->n_events = 0;
>>   		for (i = 0; i < RISCV_MAX_COUNTERS; i++)
>>   			cpuc->events[i] = NULL;
>> +		cpuc->snapshot_addr = NULL;
>>   	}
>>   	pmu->pmu = (struct pmu) {
>>   		.event_init	= riscv_pmu_event_init,
>> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
>> index f23501898657..dabf8a17b096 100644
>> --- a/drivers/perf/riscv_pmu_sbi.c
>> +++ b/drivers/perf/riscv_pmu_sbi.c
>> @@ -58,6 +58,9 @@ PMU_FORMAT_ATTR(event, "config:0-47");
>>   PMU_FORMAT_ATTR(firmware, "config:63");
>>   
>>   static bool sbi_v2_available;
>> +static DEFINE_STATIC_KEY_FALSE(sbi_pmu_snapshot_available);
>> +#define sbi_pmu_snapshot_available() \
>> +	static_branch_unlikely(&sbi_pmu_snapshot_available)
>>   
>>   static struct attribute *riscv_arch_formats_attr[] = {
>>   	&format_attr_event.attr,
>> @@ -508,14 +511,109 @@ static int pmu_sbi_event_map(struct perf_event *event, u64 *econfig)
>>   	return ret;
>>   }
>>   
>> +static void pmu_sbi_snapshot_free(struct riscv_pmu *pmu)
>> +{
>> +	int cpu;
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		struct cpu_hw_events *cpu_hw_evt = per_cpu_ptr(pmu->hw_events, cpu);
>> +
>> +		if (!cpu_hw_evt->snapshot_addr)
>> +			continue;
>> +
>> +		free_page((unsigned long)cpu_hw_evt->snapshot_addr);
>> +		cpu_hw_evt->snapshot_addr = NULL;
>> +		cpu_hw_evt->snapshot_addr_phys = 0;
>> +	}
>> +}
>> +
>> +static int pmu_sbi_snapshot_alloc(struct riscv_pmu *pmu)
>> +{
>> +	int cpu;
>> +	struct page *snapshot_page;
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		struct cpu_hw_events *cpu_hw_evt = per_cpu_ptr(pmu->hw_events, cpu);
>> +
>> +		if (cpu_hw_evt->snapshot_addr)
>> +			continue;
> This condition can never occur because pmu_sbi_snapshot_free() is called in the
> error path.

Yeah. Removed it.

>
>> +
>> +		snapshot_page = alloc_page(GFP_ATOMIC | __GFP_ZERO);
>> +		if (!snapshot_page) {
>> +			pmu_sbi_snapshot_free(pmu);
>> +			return -ENOMEM;
>> +		}
>> +		cpu_hw_evt->snapshot_addr = page_to_virt(snapshot_page);
>> +		cpu_hw_evt->snapshot_addr_phys = page_to_phys(snapshot_page);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int pmu_sbi_snapshot_disable(void)
>> +{
>> +	struct sbiret ret;
>> +
>> +	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_SNAPSHOT_SET_SHMEM, SBI_SHMEM_DISABLE,
>> +			SBI_SHMEM_DISABLE, 0, 0, 0, 0);
>> +	if (ret.error) {
>> +		pr_warn("failed to disable snapshot shared memory\n");
>> +		return sbi_err_map_linux_errno(ret.error);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int pmu_sbi_snapshot_setup(struct riscv_pmu *pmu, int cpu)
>> +{
>> +	struct cpu_hw_events *cpu_hw_evt;
>> +	struct sbiret ret = {0};
>> +
>> +	cpu_hw_evt = per_cpu_ptr(pmu->hw_events, cpu);
>> +	if (!cpu_hw_evt->snapshot_addr_phys)
>> +		return -EINVAL;
>> +
>> +	if (cpu_hw_evt->snapshot_set_done)
>> +		return 0;
>> +
>> +	if (IS_ENABLED(CONFIG_32BIT))
>> +		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_SNAPSHOT_SET_SHMEM,
>> +				cpu_hw_evt->snapshot_addr_phys,
>> +				(u64)(cpu_hw_evt->snapshot_addr_phys) >> 32, 0, 0, 0, 0);
> phys_addr_t on riscv32 is 32 bits, so the high argument will always be zero.
> (I'm guessing the compiler warned without the cast?) Do we need this special case?

As per the spec maximum physical address bits can be 34 bits on RV32. 
Linux kernel doesn't support it yet though.
But the casting is there just for forward compatibility. We can remove 
it and leave a commit but I thought of keeping it
there to make things explicit.

>> +	else
>> +		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_SNAPSHOT_SET_SHMEM,
>> +				cpu_hw_evt->snapshot_addr_phys, 0, 0, 0, 0, 0);
>> +
>> +	/* Free up the snapshot area memory and fall back to SBI PMU calls without snapshot */
>> +	if (ret.error) {
>> +		if (ret.error != SBI_ERR_NOT_SUPPORTED)
>> +			pr_warn("pmu snapshot setup failed with error %ld\n", ret.error);
>> +		cpu_hw_evt->snapshot_set_done = false;
> This statement has no effect; snapshot_set_done is known to be false above.

Removed it.

>> +		return sbi_err_map_linux_errno(ret.error);
>> +	}
>> +
>> +	cpu_hw_evt->snapshot_set_done = true;
>> +
>> +	return 0;
>> +}
>> +
>>   static u64 pmu_sbi_ctr_read(struct perf_event *event)
>>   {
>>   	struct hw_perf_event *hwc = &event->hw;
>>   	int idx = hwc->idx;
>>   	struct sbiret ret;
>>   	u64 val = 0;
>> +	struct riscv_pmu *pmu = to_riscv_pmu(event->pmu);
>> +	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
>> +	struct riscv_pmu_snapshot_data *sdata = cpu_hw_evt->snapshot_addr;
>>   	union sbi_pmu_ctr_info info = pmu_ctr_list[idx];
>>   
>> +	/* Read the value from the shared memory directly */
>> +	if (sbi_pmu_snapshot_available()) {
>> +		val = sdata->ctr_values[idx];
>> +		return val;
>> +	}
> This does not work if pmu_sbi_ctr_read() is called while the counter is started,
> because ctr_values is only updated when stopping the counter (and the shared
> memory is only updated at that time as well). So you would need to check for
> PERF_HES_STOPPED or being in the overflow handler here. And this can't possibly

Do you see a case where it is not called before counters are stopped ?
IIRC, perf framework invokes pmu->read() function when counters are stopped

riscv_pmu.c invokes it only after stopping the counters
riscv_pmu_stop->riscv_pmu_event_update->rvpmu->ctr_read


> work for idx >= XLEN.

The idx should be less than num_counters as that's what pmu_ctr_list is 
allocated for.
ctr_values size limitation is 64 as per the spec which is sufficient as 
given number of defined
firmware events + hpmcounters < 64.

We can add a paranoia check for idx but idx is retrieved from event->hw 
which is filled by the driver itself.
There are lot of function which access idx from event->hw as well.

That's why, I don't think it is required.

>> +
>>   	if (pmu_sbi_is_fw_event(event)) {
>>   		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_FW_READ,
>>   				hwc->idx, 0, 0, 0, 0, 0);
>> @@ -565,6 +663,7 @@ static void pmu_sbi_ctr_start(struct perf_event *event, u64 ival)
>>   	struct hw_perf_event *hwc = &event->hw;
>>   	unsigned long flag = SBI_PMU_START_FLAG_SET_INIT_VALUE;
>>   
>> +	/* There is no benefit setting SNAPSHOT FLAG for a single counter */
>>   #if defined(CONFIG_32BIT)
>>   	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, hwc->idx,
>>   			1, flag, ival, ival >> 32, 0);
>> @@ -585,16 +684,36 @@ static void pmu_sbi_ctr_stop(struct perf_event *event, unsigned long flag)
>>   {
>>   	struct sbiret ret;
>>   	struct hw_perf_event *hwc = &event->hw;
>> +	struct riscv_pmu *pmu = to_riscv_pmu(event->pmu);
>> +	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
>> +	struct riscv_pmu_snapshot_data *sdata = cpu_hw_evt->snapshot_addr;
>>   
>>   	if ((hwc->flags & PERF_EVENT_FLAG_USER_ACCESS) &&
>>   	    (hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT))
>>   		pmu_sbi_reset_scounteren((void *)event);
>>   
>> +	if (sbi_pmu_snapshot_available())
>> +		flag |= SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT;
>> +
>>   	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, hwc->idx, 1, flag, 0, 0, 0);
>> -	if (ret.error && (ret.error != SBI_ERR_ALREADY_STOPPED) &&
>> -		flag != SBI_PMU_STOP_FLAG_RESET)
>> +	if (!ret.error && sbi_pmu_snapshot_available()) {
>> +		/*
>> +		 * The counter snapshot is based on the index base specified by hwc->idx.
>> +		 * The actual counter value is updated in shared memory at index 0 when counter
>> +		 * mask is 0x01. To ensure accurate counter values, it's necessary to transfer
>> +		 * the counter value to shared memory. However, if hwc->idx is zero, the counter
>> +		 * value is already correctly updated in shared memory, requiring no further
>> +		 * adjustment.
>> +		 */
>> +		if (hwc->idx > 0) {
>> +			sdata->ctr_values[hwc->idx] = sdata->ctr_values[0];
>> +			sdata->ctr_values[0] = 0;
> This clobbers sdata->ctr_values[0], which may be used later by
> pmu_sbi_ctr_read(). This only happens to work if riscv_pmu_stop() is always
> called with the PERF_EF_UPDATE flag, and riscv_pmu_read() is never called with
> the event stopped but still in PERF_EVENT_STATE_ACTIVE. I think both of those
> conditions are true at the moment, but this is still rather fragile.

I don't understand the concern of being fragile when the current 
implementation
does it what you just described.

Can you describe the use case when you think it will be fragile ? Do you 
envision some core perf framework
changes that would call pmu->stop() without PERF_EF_UPDATE ?

>> +		}
>> +	} else if (ret.error && (ret.error != SBI_ERR_ALREADY_STOPPED) &&
>> +		flag != SBI_PMU_STOP_FLAG_RESET) {
>>   		pr_err("Stopping counter idx %d failed with error %d\n",
>>   			hwc->idx, sbi_err_map_linux_errno(ret.error));
>> +	}
>>   }
>>   
>>   static int pmu_sbi_find_num_ctrs(void)
>> @@ -652,10 +771,14 @@ static inline void pmu_sbi_stop_all(struct riscv_pmu *pmu)
>>   static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
>>   {
>>   	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
>> +	unsigned long flag = 0;
>> +
>> +	if (sbi_pmu_snapshot_available())
>> +		flag = SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT;
>>   
>>   	/* No need to check the error here as we can't do anything about the error */
>>   	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, 0,
>> -		  cpu_hw_evt->used_hw_ctrs[0], 0, 0, 0, 0);
>> +		  cpu_hw_evt->used_hw_ctrs[0], flag, 0, 0, 0);
> This only updates the overflow bitmap and counter values for the first XLEN
> counters. You need a second call for any remaining counters on riscv32. Of
> course, this will clobber (up to) the entire shared memory, breaking later calls
> to pmu_sbi_ctr_read().

It's done in the next patch.
https://lore.kernel.org/lkml/20240416184421.3693802-10-atishp@rivosinc.com/

>>   }
>>   
>>   /*
>> @@ -664,11 +787,10 @@ static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
>>    * while the overflowed counters need to be started with updated initialization
>>    * value.
>>    */
>> -static inline void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
>> -					       unsigned long ctr_ovf_mask)
>> +static noinline void pmu_sbi_start_ovf_ctrs_sbi(struct cpu_hw_events *cpu_hw_evt,
>> +						unsigned long ctr_ovf_mask)
>>   {
>>   	int idx = 0;
>> -	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
>>   	struct perf_event *event;
>>   	unsigned long flag = SBI_PMU_START_FLAG_SET_INIT_VALUE;
>>   	unsigned long ctr_start_mask = 0;
>> @@ -703,6 +825,48 @@ static inline void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
>>   	}
>>   }
>>   
>> +static noinline void pmu_sbi_start_ovf_ctrs_snapshot(struct cpu_hw_events *cpu_hw_evt,
>> +						     unsigned long ctr_ovf_mask)
> Why do these two functions need to be noinline?
>
They don't. I will remove it.

>> +{
>> +	int idx = 0;
>> +	struct perf_event *event;
>> +	unsigned long flag = SBI_PMU_START_FLAG_INIT_SNAPSHOT;
>> +	u64 max_period, init_val = 0;
>> +	struct hw_perf_event *hwc;
>> +	struct riscv_pmu_snapshot_data *sdata = cpu_hw_evt->snapshot_addr;
>> +
>> +	for_each_set_bit(idx, cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS) {
>> +		if (ctr_ovf_mask & BIT(idx)) {
> This is also broken on riscv32 (as is the existing code), since ctr_ovf_mask is
> only 32 bits there, but idx counts from 0 to 63.

For RV32, if there is a counter idx that is beyond 32 bits, it is not 
supported in counter overflow
scenario anyways. So it doesn't matter now.

We need to change the pmu_sbi_ovf_handler to handle counter overflows 
for counters > 32 bit though.
As there is not use case right now, I did not add it.

>> +			event = cpu_hw_evt->events[idx];
>> +			hwc = &event->hw;
>> +			max_period = riscv_pmu_ctr_get_width_mask(event);
>> +			init_val = local64_read(&hwc->prev_count) & max_period;
>> +			sdata->ctr_values[idx] = init_val;
>> +		}
>> +		/*
>> +		 * We do not need to update the non-overflow counters the previous
>> +		 * value should have been there already.
>> +		 */
>> +	}
>> +
>> +	for (idx = 0; idx < BITS_TO_LONGS(RISCV_MAX_COUNTERS); idx++) {
>> +		/* Start all the counters in a single shot */
>> +		sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, idx * BITS_PER_LONG,
>> +			  cpu_hw_evt->used_hw_ctrs[idx], flag, 0, 0, 0);
>> +	}
>> +}
>> +
>> +static void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
>> +					unsigned long ctr_ovf_mask)
>> +{
>> +	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
>> +
>> +	if (sbi_pmu_snapshot_available())
>> +		pmu_sbi_start_ovf_ctrs_snapshot(cpu_hw_evt, ctr_ovf_mask);
>> +	else
>> +		pmu_sbi_start_ovf_ctrs_sbi(cpu_hw_evt, ctr_ovf_mask);
>> +}
>> +
>>   static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>>   {
>>   	struct perf_sample_data data;
>> @@ -716,6 +880,7 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>>   	unsigned long overflowed_ctrs = 0;
>>   	struct cpu_hw_events *cpu_hw_evt = dev;
>>   	u64 start_clock = sched_clock();
>> +	struct riscv_pmu_snapshot_data *sdata = cpu_hw_evt->snapshot_addr;
>>   
>>   	if (WARN_ON_ONCE(!cpu_hw_evt))
>>   		return IRQ_NONE;
>> @@ -737,8 +902,10 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>>   	pmu_sbi_stop_hw_ctrs(pmu);
>>   
>>   	/* Overflow status register should only be read after counter are stopped */
>> -	ALT_SBI_PMU_OVERFLOW(overflow);
>> -
> nit: no need to remove this line.

Fixed.


>> +	if (sbi_pmu_snapshot_available())
>> +		overflow = sdata->ctr_overflow_mask;
>> +	else
>> +		ALT_SBI_PMU_OVERFLOW(overflow);
>>   	/*
>>   	 * Overflow interrupt pending bit should only be cleared after stopping
>>   	 * all the counters to avoid any race condition.
>> @@ -819,6 +986,9 @@ static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
>>   		enable_percpu_irq(riscv_pmu_irq, IRQ_TYPE_NONE);
>>   	}
>>   
>> +	if (sbi_pmu_snapshot_available())
>> +		return pmu_sbi_snapshot_setup(pmu, cpu);
>> +
>>   	return 0;
>>   }
>>   
>> @@ -831,6 +1001,9 @@ static int pmu_sbi_dying_cpu(unsigned int cpu, struct hlist_node *node)
>>   	/* Disable all counters access for user mode now */
>>   	csr_write(CSR_SCOUNTEREN, 0x0);
>>   
>> +	if (sbi_pmu_snapshot_available())
>> +		return pmu_sbi_snapshot_disable();
>> +
>>   	return 0;
>>   }
>>   
>> @@ -939,6 +1112,11 @@ static inline void riscv_pm_pmu_unregister(struct riscv_pmu *pmu) { }
>>   
>>   static void riscv_pmu_destroy(struct riscv_pmu *pmu)
>>   {
>> +	if (sbi_v2_available) {
>> +		pmu_sbi_snapshot_free(pmu);
>> +		if (sbi_pmu_snapshot_available())
>> +			pmu_sbi_snapshot_disable();
> This is technically fine because nothing is writing to the shmem at this time,
> but it certainly looks like a possible use-after-free.

Yes. It would have been use-after-free if pmu_sbi_snapshot_disable uses 
the allocated
address. I guess the the function name doesn't indicate that the disable 
happens by passing -1 instead
of the previously allocated address.


> Also, this whole block can go inside the sbi_pmu_snapshot_available() check,
> because either the branch is set or pmu_sbi_snapshot_free() is already called in
> the error case below.

I kept it above because the conditions are different logically.
The sbi_pmu_snapshot_available is only enabled when snapshot_setup 
succeeds not
when snapshot_alloc is successful.

In reality, it doesn't matter though as we free it in the error case as 
you pointed.

Either way, I will move it inside.

> Regards,
> Samuel
>
>> +	}
>>   	riscv_pm_pmu_unregister(pmu);
>>   	cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
>>   }
>> @@ -1106,10 +1284,6 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
>>   	pmu->event_unmapped = pmu_sbi_event_unmapped;
>>   	pmu->csr_index = pmu_sbi_csr_index;
>>   
>> -	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
>> -	if (ret)
>> -		return ret;
>> -
>>   	ret = riscv_pm_pmu_register(pmu);
>>   	if (ret)
>>   		goto out_unregister;
>> @@ -1118,8 +1292,34 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
>>   	if (ret)
>>   		goto out_unregister;
>>   
>> +	/* SBI PMU Snapsphot is only available in SBI v2.0 */
>> +	if (sbi_v2_available) {
>> +		ret = pmu_sbi_snapshot_alloc(pmu);
>> +		if (ret)
>> +			goto out_unregister;
>> +
>> +		ret = pmu_sbi_snapshot_setup(pmu, smp_processor_id());
>> +		if (ret) {
>> +			/* Snapshot is an optional feature. Continue if not available */
>> +			pmu_sbi_snapshot_free(pmu);
>> +		} else {
>> +			pr_info("SBI PMU snapshot detected\n");
>> +			/*
>> +			 * We enable it once here for the boot cpu. If snapshot shmem setup
>> +			 * fails during cpu hotplug process, it will fail to start the cpu
>> +			 * as we can not handle hetergenous PMUs with different snapshot
>> +			 * capability.
>> +			 */
>> +			static_branch_enable(&sbi_pmu_snapshot_available);
>> +		}
>> +	}
>> +
>>   	register_sysctl("kernel", sbi_pmu_sysctl_table);
>>   
>> +	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
>> +	if (ret)
>> +		goto out_unregister;
>> +
>>   	return 0;
>>   
>>   out_unregister:
>> diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
>> index 43282e22ebe1..c3fa90970042 100644
>> --- a/include/linux/perf/riscv_pmu.h
>> +++ b/include/linux/perf/riscv_pmu.h
>> @@ -39,6 +39,12 @@ struct cpu_hw_events {
>>   	DECLARE_BITMAP(used_hw_ctrs, RISCV_MAX_COUNTERS);
>>   	/* currently enabled firmware counters */
>>   	DECLARE_BITMAP(used_fw_ctrs, RISCV_MAX_COUNTERS);
>> +	/* The virtual address of the shared memory where counter snapshot will be taken */
>> +	void *snapshot_addr;
>> +	/* The physical address of the shared memory where counter snapshot will be taken */
>> +	phys_addr_t snapshot_addr_phys;
>> +	/* Boolean flag to indicate setup is already done */
>> +	bool snapshot_set_done;
>>   };
>>   
>>   struct riscv_pmu {

