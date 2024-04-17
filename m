Return-Path: <linux-kselftest+bounces-8236-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0838A7B32
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 06:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57C1E2822E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 04:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204DC40850;
	Wed, 17 Apr 2024 04:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="cwNh8s0x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DD03FBAD
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Apr 2024 04:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713326577; cv=none; b=HxeVrBIM6Yy7pLZNkB1jcAilHbC5zF4hLoBbDmOjZQild/NAMoTfZk3SwO0wOG8jslVi9DxRr7ljuOq+s1ihbQcA+QbT4l22FD9qmoolnuivHmasMU3CQxDas95qTkFdV4Vr/YAjw39jHl/hAYNnbkb2bck4OrAbnYKHpVxjntA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713326577; c=relaxed/simple;
	bh=SDyXE5nZDg6+MjOWy7eoQiciPcZIDo2Fwhbkbjz+vMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MS1UGXgkBIqKboqLn45d7iXnX32a94N7eEWco6SatrOEUhwIw/6Wg84JlGDKxkKLbkQAuHTbpccNqr8g2S0KSaVzGnDlLVRQl5RyqavDNZiDdAyW4l/9dw8hkIpX6KdUSer9C83fcsHNhbXZkUIIqBaTrTspj3UhL9eSZq/tQHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=cwNh8s0x; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7d0262036afso194554839f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 21:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1713326574; x=1713931374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZidXVkciqp1TOCVOced4I35ER/7IPUxlhgOSqJkxCz8=;
        b=cwNh8s0xUTw7W//+0yIvygbwVxEatlGIN3O6vF7xNefILWLL40u/phWAOF8LAlSPl5
         zpt0oW4IjEZvz/626YjGJXAl3tuBikgdLspjQS8NsxJtmdlcnXBSNDYYJKN66V8OfUj/
         4IRzNDdefjHv/hMRmbB3AO+Vpmj2j/tuUMKOWx5hXBTPY/du8Zp7jJqbX7bzbSZ6c7RR
         hyjgC86I2Qax6Mm7+472Pgk2KXLjpxguAHQXceBrj3hiyUFbfQc5kdc0X/reyJgsFNTn
         GG3BpTM39vCPSBs6+q34wdWWyl1hy/XwzVBdR2QdmnATJaQ+XTLH1+egz0n7UAmRrv58
         Ev0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713326574; x=1713931374;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZidXVkciqp1TOCVOced4I35ER/7IPUxlhgOSqJkxCz8=;
        b=ZFDsHXgtLbytaX4+SypYTi/3hJe3+U5EnQ3Oyh4elq9WtU3ZOqFoma3l/6A8pjzdCW
         shE6YUyrJbewKp3FuZsKPEYMOFjwffoBP9lZ3XR2oDpr22SonEG9afFQU4/XpnVIr/Ek
         bNY2iWRI6TwTED6u5wAPBKu6EDJW0SDO1/UvGAvKGoWnaurx0fRWPGbsL3sMsamSj7uL
         xwxBaZU2dVw7HELtP1FOg0qgNXfrXJ3WXO6fI3RLjIEuHdDf0TQeOsUJQZutl1wdZedq
         eWSRrA++xdKROVCu5cmyfQsm2REnb50BQSeSbkrsIcVhzR/GzUtVd2QmWUAmFdceUShb
         bBJA==
X-Forwarded-Encrypted: i=1; AJvYcCXolYuEmX7i+CBtlAmwM2Zu9UxoiqqRd+Afz7yA9aYzxRpY/pb3SJ9cf9w3SjQOsSE+1T1EJJbH3HLX2qmqizk0MsAi0fEgRHq3bcksb+aG
X-Gm-Message-State: AOJu0YyfSn6OBVZfhUQA7rczvZjdMtA/ajJJ7TWvXYnNrDaea2QzZxj+
	xnl9A5E3+a33VrhCHWTDITiQipZ1rP8PPbWLBBS2K3put82LxCzoEwc3sXIf0WM=
X-Google-Smtp-Source: AGHT+IFY/4fK2G3PJ3uf/u0jrY64VVbXODRBpAjEp1JStF8cX38mtCgR7YvZBgyhjwUFaPaGQX0eCA==
X-Received: by 2002:a05:6602:3709:b0:7d6:74d1:e86d with SMTP id bh9-20020a056602370900b007d674d1e86dmr18075864iob.20.1713326573619;
        Tue, 16 Apr 2024 21:02:53 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.197])
        by smtp.gmail.com with ESMTPSA id s16-20020a056638219000b0047eff5b28dcsm4299645jaj.146.2024.04.16.21.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 21:02:53 -0700 (PDT)
Message-ID: <d4923b62-3cda-4bdd-900e-265059593cf2@sifive.com>
Date: Tue, 16 Apr 2024 23:02:50 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/24] drivers/perf: riscv: Implement SBI PMU snapshot
 function
To: Atish Patra <atishp@rivosinc.com>
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
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20240416184421.3693802-9-atishp@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Atish,

On 2024-04-16 1:44 PM, Atish Patra wrote:
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
>  drivers/perf/riscv_pmu_sbi.c   | 224 +++++++++++++++++++++++++++++++--
>  include/linux/perf/riscv_pmu.h |   6 +
>  3 files changed, 219 insertions(+), 12 deletions(-)
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
> index f23501898657..dabf8a17b096 100644
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
> @@ -508,14 +511,109 @@ static int pmu_sbi_event_map(struct perf_event *event, u64 *econfig)
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
> +		if (cpu_hw_evt->snapshot_addr)
> +			continue;

This condition can never occur because pmu_sbi_snapshot_free() is called in the
error path.

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

phys_addr_t on riscv32 is 32 bits, so the high argument will always be zero.
(I'm guessing the compiler warned without the cast?) Do we need this special case?

> +	else
> +		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_SNAPSHOT_SET_SHMEM,
> +				cpu_hw_evt->snapshot_addr_phys, 0, 0, 0, 0, 0);
> +
> +	/* Free up the snapshot area memory and fall back to SBI PMU calls without snapshot */
> +	if (ret.error) {
> +		if (ret.error != SBI_ERR_NOT_SUPPORTED)
> +			pr_warn("pmu snapshot setup failed with error %ld\n", ret.error);
> +		cpu_hw_evt->snapshot_set_done = false;

This statement has no effect; snapshot_set_done is known to be false above.

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
> +	/* Read the value from the shared memory directly */
> +	if (sbi_pmu_snapshot_available()) {
> +		val = sdata->ctr_values[idx];
> +		return val;
> +	}

This does not work if pmu_sbi_ctr_read() is called while the counter is started,
because ctr_values is only updated when stopping the counter (and the shared
memory is only updated at that time as well). So you would need to check for
PERF_HES_STOPPED or being in the overflow handler here. And this can't possibly
work for idx >= XLEN.

> +
>  	if (pmu_sbi_is_fw_event(event)) {
>  		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_FW_READ,
>  				hwc->idx, 0, 0, 0, 0, 0);
> @@ -565,6 +663,7 @@ static void pmu_sbi_ctr_start(struct perf_event *event, u64 ival)
>  	struct hw_perf_event *hwc = &event->hw;
>  	unsigned long flag = SBI_PMU_START_FLAG_SET_INIT_VALUE;
>  
> +	/* There is no benefit setting SNAPSHOT FLAG for a single counter */
>  #if defined(CONFIG_32BIT)
>  	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, hwc->idx,
>  			1, flag, ival, ival >> 32, 0);
> @@ -585,16 +684,36 @@ static void pmu_sbi_ctr_stop(struct perf_event *event, unsigned long flag)
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

This clobbers sdata->ctr_values[0], which may be used later by
pmu_sbi_ctr_read(). This only happens to work if riscv_pmu_stop() is always
called with the PERF_EF_UPDATE flag, and riscv_pmu_read() is never called with
the event stopped but still in PERF_EVENT_STATE_ACTIVE. I think both of those
conditions are true at the moment, but this is still rather fragile.

> +		}
> +	} else if (ret.error && (ret.error != SBI_ERR_ALREADY_STOPPED) &&
> +		flag != SBI_PMU_STOP_FLAG_RESET) {
>  		pr_err("Stopping counter idx %d failed with error %d\n",
>  			hwc->idx, sbi_err_map_linux_errno(ret.error));
> +	}
>  }
>  
>  static int pmu_sbi_find_num_ctrs(void)
> @@ -652,10 +771,14 @@ static inline void pmu_sbi_stop_all(struct riscv_pmu *pmu)
>  static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
>  {
>  	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
> +	unsigned long flag = 0;
> +
> +	if (sbi_pmu_snapshot_available())
> +		flag = SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT;
>  
>  	/* No need to check the error here as we can't do anything about the error */
>  	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, 0,
> -		  cpu_hw_evt->used_hw_ctrs[0], 0, 0, 0, 0);
> +		  cpu_hw_evt->used_hw_ctrs[0], flag, 0, 0, 0);

This only updates the overflow bitmap and counter values for the first XLEN
counters. You need a second call for any remaining counters on riscv32. Of
course, this will clobber (up to) the entire shared memory, breaking later calls
to pmu_sbi_ctr_read().

>  }
>  
>  /*
> @@ -664,11 +787,10 @@ static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
>   * while the overflowed counters need to be started with updated initialization
>   * value.
>   */
> -static inline void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
> -					       unsigned long ctr_ovf_mask)
> +static noinline void pmu_sbi_start_ovf_ctrs_sbi(struct cpu_hw_events *cpu_hw_evt,
> +						unsigned long ctr_ovf_mask)
>  {
>  	int idx = 0;
> -	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
>  	struct perf_event *event;
>  	unsigned long flag = SBI_PMU_START_FLAG_SET_INIT_VALUE;
>  	unsigned long ctr_start_mask = 0;
> @@ -703,6 +825,48 @@ static inline void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
>  	}
>  }
>  
> +static noinline void pmu_sbi_start_ovf_ctrs_snapshot(struct cpu_hw_events *cpu_hw_evt,
> +						     unsigned long ctr_ovf_mask)

Why do these two functions need to be noinline?

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

This is also broken on riscv32 (as is the existing code), since ctr_ovf_mask is
only 32 bits there, but idx counts from 0 to 63.

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
> +	}
> +}
> +
> +static void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
> +					unsigned long ctr_ovf_mask)
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
> @@ -716,6 +880,7 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>  	unsigned long overflowed_ctrs = 0;
>  	struct cpu_hw_events *cpu_hw_evt = dev;
>  	u64 start_clock = sched_clock();
> +	struct riscv_pmu_snapshot_data *sdata = cpu_hw_evt->snapshot_addr;
>  
>  	if (WARN_ON_ONCE(!cpu_hw_evt))
>  		return IRQ_NONE;
> @@ -737,8 +902,10 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>  	pmu_sbi_stop_hw_ctrs(pmu);
>  
>  	/* Overflow status register should only be read after counter are stopped */
> -	ALT_SBI_PMU_OVERFLOW(overflow);
> -

nit: no need to remove this line.

> +	if (sbi_pmu_snapshot_available())
> +		overflow = sdata->ctr_overflow_mask;
> +	else
> +		ALT_SBI_PMU_OVERFLOW(overflow);
>  	/*
>  	 * Overflow interrupt pending bit should only be cleared after stopping
>  	 * all the counters to avoid any race condition.
> @@ -819,6 +986,9 @@ static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
>  		enable_percpu_irq(riscv_pmu_irq, IRQ_TYPE_NONE);
>  	}
>  
> +	if (sbi_pmu_snapshot_available())
> +		return pmu_sbi_snapshot_setup(pmu, cpu);
> +
>  	return 0;
>  }
>  
> @@ -831,6 +1001,9 @@ static int pmu_sbi_dying_cpu(unsigned int cpu, struct hlist_node *node)
>  	/* Disable all counters access for user mode now */
>  	csr_write(CSR_SCOUNTEREN, 0x0);
>  
> +	if (sbi_pmu_snapshot_available())
> +		return pmu_sbi_snapshot_disable();
> +
>  	return 0;
>  }
>  
> @@ -939,6 +1112,11 @@ static inline void riscv_pm_pmu_unregister(struct riscv_pmu *pmu) { }
>  
>  static void riscv_pmu_destroy(struct riscv_pmu *pmu)
>  {
> +	if (sbi_v2_available) {
> +		pmu_sbi_snapshot_free(pmu);
> +		if (sbi_pmu_snapshot_available())
> +			pmu_sbi_snapshot_disable();

This is technically fine because nothing is writing to the shmem at this time,
but it certainly looks like a possible use-after-free.

Also, this whole block can go inside the sbi_pmu_snapshot_available() check,
because either the branch is set or pmu_sbi_snapshot_free() is already called in
the error case below.

Regards,
Samuel

> +	}
>  	riscv_pm_pmu_unregister(pmu);
>  	cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
>  }
> @@ -1106,10 +1284,6 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
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
> @@ -1118,8 +1292,34 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
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


