Return-Path: <linux-kselftest+bounces-5733-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDA886E38A
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 15:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63AFB283F84
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 14:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DDC38FAD;
	Fri,  1 Mar 2024 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="CvsaHZ1P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ACF33C9
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Mar 2024 14:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709304049; cv=none; b=mZi91JOX5+1fOE3XzmdUuStK4kBM6ocIuZH8f3Fs/mF+QBHmBCDy6pjvKaIv+2Fiyp9O25iS9bufoP0N21gDDut953RxrJvO/f3L+5Cm+NtGZQ7EaIinPmBNXj+bqmYaLMZ4FE9fLwaED+XISZk6y7T7jKUvBx2YxTNfCGZOmCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709304049; c=relaxed/simple;
	bh=WMSw5cE6yzpZ/oWRNSEpaFg92NKoKbCJGdB3z7DqFZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNEypQ5YDUVGrlWKafaLW9HTAcDmfkoMWCCzppe3ab+e3u70CtLRSB3pg16PadJLC+aKrogvfv0nZEOKaslhA/gPg2EaJT+h+P1Z9aCB+KDHk7WlnqwhNLEydNzTkqYsJrIbq7XFNfJj7HLCSo6/cWW51j2aFR3rYvl6QKzLRUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=CvsaHZ1P; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33e122c8598so1057266f8f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Mar 2024 06:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1709304044; x=1709908844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/fH9e4Y+5VSjP/Y4cR8MCnV8KGx8N82MLsMiROFh7zo=;
        b=CvsaHZ1PdE3b02RO7Ftl9n1EuxN+/jq1XS4KjJpeLJmPQVbVUI/2RGl0CbgAYvwzMN
         +0HfgJ2jEQtkGSn9rhwxyVgQ2tNVYif44Kk77KWNorfvWcBwWGEq+cxCDd0JmPqOWRAG
         9mPFFIheBxAAuOf2VmhoSe7GI8kRz6PyY1At3LkPoRYNJbs4sdqv1ndw2S8KWagzWmbi
         fx6OeA0B+hR93mcGGoNb+Rx2mKHgRra4/vK9Ba3rCc55qVoZ4G/eRcaENC1Yv2weaeOC
         brCINGBfqahpjot8IppGAmZ9NMS8B4er9+DMsohjREDMj1crSOGuUVgzZ0MdFWdqe6f9
         J5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709304044; x=1709908844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fH9e4Y+5VSjP/Y4cR8MCnV8KGx8N82MLsMiROFh7zo=;
        b=cHUAWEwSyX1Is2pzbw1Ao2XVSy48ejH+Yw+d85pXNXafKwbJZB0USNtFLQ6ccgcIMM
         jOwzfNyssKVvChJp10rtFDl+Mk6/EBdOpcCAtp5t48Q4NUgC6H80bPilgufGBBMy/Spq
         D+wPSV5r44C2O6oCffKCsffPyOazA1+tNsbCUHUHyDcfqrPwMDzIC3g/p6yuSjJcNrhu
         kuPDEBA36pUJ3xDMon4f9HrMwU2fdCIplXPxU+ucUf91j4+CcRnHogs2s6OTmu6YtWIR
         /a0cRWQaiNEIBDatdzygXFLIEK6Ezg8QWmPxlUHdiEdZy119lvxGbFEJts5ck6Z+IQQ5
         hW/w==
X-Forwarded-Encrypted: i=1; AJvYcCUjGW8jdp/OpZpjLuiVHZsAUtflHH9/JbP0uVWp2KBAip9J8FXLp45v3EgLO49XvHfr6+5oTux3oBtYbMnohps59SwK3lgTm9a/qHmP2OfS
X-Gm-Message-State: AOJu0Yyh9R3TIksKRbH6LPbIGFhEaqojjj6Rs4Oqjm3Y2z1Om7K37EyM
	Nrsx3jSXI0+9Am7gAdTJpwNv5NsixQqM/Xl6JIv5BStcEoiKppGgvYJszeVOMG8=
X-Google-Smtp-Source: AGHT+IFYJjdmIlrg4fK3WoCRNzoK5W1dEpib8k88k8LxEH9B8Q+MpB4/nMVejEIsAdEv356F0HcTVw==
X-Received: by 2002:a5d:550c:0:b0:33e:cc6:e6b5 with SMTP id b12-20020a5d550c000000b0033e0cc6e6b5mr1492380wrv.23.1709304044512;
        Fri, 01 Mar 2024 06:40:44 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id co24-20020a0560000a1800b0033da4b06632sm4870668wrb.6.2024.03.01.06.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 06:40:44 -0800 (PST)
Date: Fri, 1 Mar 2024 15:40:43 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
	Anup Patel <anup@brainfault.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Atish Patra <atishp@atishpatra.org>, Guo Ren <guoren@kernel.org>, Icenowy Zheng <uwu@icenowy.me>, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 05/15] drivers/perf: riscv: Implement SBI PMU snapshot
 function
Message-ID: <20240301-9587f1bcaa6b25b1dcc7062e@orel>
References: <20240229010130.1380926-1-atishp@rivosinc.com>
 <20240229010130.1380926-6-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229010130.1380926-6-atishp@rivosinc.com>

On Wed, Feb 28, 2024 at 05:01:20PM -0800, Atish Patra wrote:
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
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  drivers/perf/riscv_pmu.c       |   1 +
>  drivers/perf/riscv_pmu_sbi.c   | 209 +++++++++++++++++++++++++++++++--
>  include/linux/perf/riscv_pmu.h |   6 +
>  3 files changed, 204 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
> index 0dda70e1ef90..5b57acb770d3 100644
> --- a/drivers/perf/riscv_pmu.c
> +++ b/drivers/perf/riscv_pmu.c
> @@ -412,6 +412,7 @@ struct riscv_pmu *riscv_pmu_alloc(void)
>  		cpuc->n_events = 0;
>  		for (i = 0; i < RISCV_MAX_COUNTERS; i++)
>  			cpuc->events[i] = NULL;
> +		cpuc->snapshot_addr = NULL;
>  	}
>  	pmu->pmu = (struct pmu) {
>  		.event_init	= riscv_pmu_event_init,
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index ea0fdb589f0d..8de5721e8019 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -36,6 +36,9 @@ PMU_FORMAT_ATTR(event, "config:0-47");
>  PMU_FORMAT_ATTR(firmware, "config:63");
>  
>  static bool sbi_v2_available;
> +static DEFINE_STATIC_KEY_FALSE(sbi_pmu_snapshot_available);
> +#define sbi_pmu_snapshot_available() \
> +	static_branch_unlikely(&sbi_pmu_snapshot_available)
>  
>  static struct attribute *riscv_arch_formats_attr[] = {
>  	&format_attr_event.attr,
> @@ -485,14 +488,100 @@ static int pmu_sbi_event_map(struct perf_event *event, u64 *econfig)
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
> +static void pmu_sbi_snapshot_disable(void)
> +{
> +	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_SNAPSHOT_SET_SHMEM, -1,
> +		  -1, 0, 0, 0, 0);
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
> +	/* Read the value from the shared memory directly */
> +	if (sbi_pmu_snapshot_available()) {
> +		val = sdata->ctr_values[idx];
> +		return val;
> +	}
> +
>  	if (pmu_sbi_is_fw_event(event)) {
>  		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_FW_READ,
>  				hwc->idx, 0, 0, 0, 0, 0);
> @@ -539,6 +628,7 @@ static void pmu_sbi_ctr_start(struct perf_event *event, u64 ival)
>  	struct hw_perf_event *hwc = &event->hw;
>  	unsigned long flag = SBI_PMU_START_FLAG_SET_INIT_VALUE;
>  
> +	/* There is no benefit setting SNAPSHOT FLAG for a single counter */
>  #if defined(CONFIG_32BIT)
>  	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, hwc->idx,
>  			1, flag, ival, ival >> 32, 0);
> @@ -559,16 +649,36 @@ static void pmu_sbi_ctr_stop(struct perf_event *event, unsigned long flag)
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
> @@ -626,10 +736,14 @@ static inline void pmu_sbi_stop_all(struct riscv_pmu *pmu)
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
>  }
>  
>  /*
> @@ -638,11 +752,10 @@ static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
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
> @@ -677,6 +790,49 @@ static inline void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
>  	}
>  }
>  
> +static noinline void pmu_sbi_start_ovf_ctrs_snapshot(struct cpu_hw_events *cpu_hw_evt,
> +						     unsigned long ctr_ovf_mask)
> +{
> +	int idx = 0;
> +	struct perf_event *event;
> +	unsigned long flag = SBI_PMU_START_FLAG_INIT_FROM_SNAPSHOT;
> +	u64 max_period, init_val = 0;
> +	struct hw_perf_event *hwc;
> +	unsigned long ctr_start_mask = 0;
> +	struct riscv_pmu_snapshot_data *sdata = cpu_hw_evt->snapshot_addr;
> +
> +	for_each_set_bit(idx, cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS) {
> +		if (ctr_ovf_mask & (1 << idx)) {

nit: BIT(idx)

> +			event = cpu_hw_evt->events[idx];
> +			hwc = &event->hw;
> +			max_period = riscv_pmu_ctr_get_width_mask(event);
> +			init_val = local64_read(&hwc->prev_count) & max_period;
> +			sdata->ctr_values[idx] = init_val;
> +		}
> +		/*
> +		 * We donot need to update the non-overflow counters the previous

do not

> +		 * value should have been there already.
> +		 */
> +	}
> +
> +	ctr_start_mask = cpu_hw_evt->used_hw_ctrs[0];
> +
> +	/* Start all the counters in a single shot */
> +	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, 0, ctr_start_mask,
> +		  flag, 0, 0, 0);

I think we should always loop over all words of used_hw_ctrs[] since it'll
have more than one for riscv32. Hmm, it seems like there are several
places where we don't expect riscv32's second word to be used...

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
> @@ -690,6 +846,7 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>  	unsigned long overflowed_ctrs = 0;
>  	struct cpu_hw_events *cpu_hw_evt = dev;
>  	u64 start_clock = sched_clock();
> +	struct riscv_pmu_snapshot_data *sdata = cpu_hw_evt->snapshot_addr;
>  
>  	if (WARN_ON_ONCE(!cpu_hw_evt))
>  		return IRQ_NONE;
> @@ -711,8 +868,10 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>  	pmu_sbi_stop_hw_ctrs(pmu);
>  
>  	/* Overflow status register should only be read after counter are stopped */
> -	ALT_SBI_PMU_OVERFLOW(overflow);
> -
> +	if (sbi_pmu_snapshot_available())
> +		overflow = sdata->ctr_overflow_mask;
> +	else
> +		ALT_SBI_PMU_OVERFLOW(overflow);
>  	/*
>  	 * Overflow interrupt pending bit should only be cleared after stopping
>  	 * all the counters to avoid any race condition.
> @@ -794,6 +953,9 @@ static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
>  		enable_percpu_irq(riscv_pmu_irq, IRQ_TYPE_NONE);
>  	}
>  
> +	if (sbi_pmu_snapshot_available())
> +		return pmu_sbi_snapshot_setup(pmu, cpu);
> +
>  	return 0;
>  }
>  
> @@ -807,6 +969,9 @@ static int pmu_sbi_dying_cpu(unsigned int cpu, struct hlist_node *node)
>  	/* Disable all counters access for user mode now */
>  	csr_write(CSR_SCOUNTEREN, 0x0);
>  
> +	if (sbi_pmu_snapshot_available())
> +		pmu_sbi_snapshot_disable();
> +
>  	return 0;
>  }
>  
> @@ -1076,10 +1241,6 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
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
> @@ -1088,8 +1249,32 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
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
> +		if (!ret) {
> +			pr_info("SBI PMU snapshot detected\n");
> +			/*
> +			 * We enable it once here for the boot cpu. If snapshot shmem setup
> +			 * fails during cpu hotplug process, it will fail to start the cpu
> +			 * as we can not handle hetergenous PMUs with different snapshot
> +			 * capability.
> +			 */
> +			static_branch_enable(&sbi_pmu_snapshot_available);
> +		}
> +		/* Snapshot is an optional feature. Continue if not available */
> +	}
> +
>  	register_sysctl("kernel", sbi_pmu_sysctl_table);
>  
> +	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
> +	if (ret)
> +		return ret;
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

Instead of the 'snapshot_set_done' boolean, we can just use
snapshot_addr, which can't be NULL after setup.

>  };
>  
>  struct riscv_pmu {
> -- 
> 2.34.1
> 

Thanks,
drew

