Return-Path: <linux-kselftest+bounces-7184-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE20A898682
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 13:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38F6E1F296FF
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 11:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8873D84D2D;
	Thu,  4 Apr 2024 11:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="eqeO7W6F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386D984D10
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Apr 2024 11:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712231580; cv=none; b=K58ZDZzu/zfuofay1jxDwEF+YRyBkK6iAfaTR7WBcuJQVj7qU9e4QRAfAi21cUW8xyjc+dvyYFULBc+787lvrLjZe+E0Xpcy7TXXsMa2lEHPIU/TkYAP7TGDEXw5NSRLqo1iEUKHBLtBrKa9tzs6fhy9bUG1AKh8pdmtIOISccc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712231580; c=relaxed/simple;
	bh=wWkKjgCWHLj/69CRjOCjoNg0CCYQndHxbt51bncGABI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdYalSBTP/do9G3OcIYu5OTZbB7+fKNw3i0xN9A/dF5LOSJbiSD2AOff4ctfRngXlrnkvQ8aM+5xjh+BhE6HDcNfVPkVKefsayn3gRkOgI6ONwo9A1VBChdmD1KwYSCFAdbb2y0vt59ofjG4PBj/VhKqOY07dYQN9vHzJ2FGjoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=eqeO7W6F; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a4734ae95b3so129918366b.0
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Apr 2024 04:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712231576; x=1712836376; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D8o1BluEBbcYLN3Xq338VBTyPp2JVEWHZv5f3jLTR74=;
        b=eqeO7W6FuQA/8fcjdsNhmjn4DzA322NG75ybVOswQhjFeC5HuYN7vckZDRmJi3NOr/
         Q4dHBFYizp67GiGmQZuNU1tFxxMLJy2pvoaa6SgRZ23qxG6wjH/4DfjwtDwfavUIjvw1
         AktjoOAjud9CgqQ+3vpBPEQj0ZQQjIGdj8QI0XfrfsWJ+WX03nvCwYn+vHYzihP94tYK
         oGBjHIlin32zIfaDH+f771AwJCAprT7HLug2YDTJ/9Q8cvayUAl8A6usieZAZkEb8o3U
         soX/ERqrYslrw4Bf7dhK5TB8I7GC3ydZhwwxA3fKe4qeyZdjt69xFFeplejHA+rXdSzx
         PGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712231576; x=1712836376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8o1BluEBbcYLN3Xq338VBTyPp2JVEWHZv5f3jLTR74=;
        b=UNbfcT5AnlQUuVf1v8GST6KspTg9t9idRTPvrUdAymkYkxqaOdVO4CiJ/llMVoOmEG
         6WBhcuboUKNF4dF7SlAW11oFUeQAr8NojwE1euj48W8gE04pXiUGT46lG6ELMvHxswVe
         vEos1h7v6dRpm46eOb2xdZUpzy+wLqRst8wL9bsHNUC7xiK8FHv8TsHmOaNewuf4811/
         FSRvHJs7biHcpuJ3bucNQEvUd8b8+/5OEhT+8DG610HkzA/3QunWVQ10KaeZyR7R4sZL
         axzK9gLC7GF81X/a6Ntb5qUKwS35jEj1tCB7mJXTBpMC+v80qphpbNqSLm4vxTDF431Y
         EiCQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6M3KepX9+msMBneEK3efzCXIBwMcbiyH6bMJ65r31bRFt5TtO22SEVVdsScDHVBLLkm/ddiW84TklNrMrOLnxbidnQtE/yhgKbD54zr7R
X-Gm-Message-State: AOJu0Yww8FmWbggFdZme4cOs1u4KxoriyCBvLI8RxoxoX1IQeijCWrZG
	NDNxucWtPnIrZJarWWmmXujX2f+x6pJuAQFudAINd5zYP0ywi5S4v05jValWtxA=
X-Google-Smtp-Source: AGHT+IHvG33ZU7NQIl4xlwphowIrwoPoKcjiItt9rNMqLO2Jx6WfwC9jA1F0IupZiEpV7TRPVror7g==
X-Received: by 2002:a17:906:dc1:b0:a4f:a291:cca2 with SMTP id p1-20020a1709060dc100b00a4fa291cca2mr1306512eji.31.1712231576477;
        Thu, 04 Apr 2024 04:52:56 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id i15-20020a170906090f00b00a4e5866448bsm5972957ejd.155.2024.04.04.04.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 04:52:55 -0700 (PDT)
Date: Thu, 4 Apr 2024 13:52:55 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
	Anup Patel <anup@brainfault.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Ajay Kaher <akaher@vmware.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Alexey Makhalov <amakhalov@vmware.com>, Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v5 06/22] drivers/perf: riscv: Implement SBI PMU snapshot
 function
Message-ID: <20240404-4303d1805800fad18b6d9768@orel>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-7-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403080452.1007601-7-atishp@rivosinc.com>

On Wed, Apr 03, 2024 at 01:04:35AM -0700, Atish Patra wrote:
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
>  drivers/perf/riscv_pmu_sbi.c   | 216 +++++++++++++++++++++++++++++++--
>  include/linux/perf/riscv_pmu.h |   6 +
>  3 files changed, 211 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
> index c78a6fd6c57f..3a941b2c3888 100644
> --- a/drivers/perf/riscv_pmu.c
> +++ b/drivers/perf/riscv_pmu.c
> @@ -404,6 +404,7 @@ struct riscv_pmu *riscv_pmu_alloc(void)
>  		cpuc->n_events = 0;
>  		for (i = 0; i < RISCV_MAX_COUNTERS; i++)
>  			cpuc->events[i] = NULL;
> +		cpuc->snapshot_addr = NULL;
>  	}
>  	pmu->pmu = (struct pmu) {
>  		.event_init	= riscv_pmu_event_init,
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index a83ae82301e3..8c3475d55433 100644
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
> @@ -508,14 +511,108 @@ static int pmu_sbi_event_map(struct perf_event *event, u64 *econfig)
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
> +static int pmu_sbi_snapshot_disable(void)
> +{
> +	struct sbiret ret;
> +
> +	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_SNAPSHOT_SET_SHMEM, -1,
> +			-1, 0, 0, 0, 0);
> +	if (ret.error) {
> +		pr_warn("failed to disable snapshot shared memory\n");
> +		return sbi_err_map_linux_errno(ret.error);
> +	}

Also need to set snapshot_set_done to false, but I'm not yet convinced
that we need snapshot_set_done, especially if we don't allow
snapshot_addr_phys to be zero, since zero can then mean set-not-done,
but ~0UL is probably a better invalid physical address choice than zero.

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
> +	/* Read the value from the shared memory directly */
> +	if (sbi_pmu_snapshot_available()) {
> +		val = sdata->ctr_values[idx];
> +		return val;
> +	}
> +
>  	if (pmu_sbi_is_fw_event(event)) {
>  		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_FW_READ,
>  				hwc->idx, 0, 0, 0, 0, 0);
> @@ -565,6 +662,7 @@ static void pmu_sbi_ctr_start(struct perf_event *event, u64 ival)
>  	struct hw_perf_event *hwc = &event->hw;
>  	unsigned long flag = SBI_PMU_START_FLAG_SET_INIT_VALUE;
>  
> +	/* There is no benefit setting SNAPSHOT FLAG for a single counter */
>  #if defined(CONFIG_32BIT)
>  	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, hwc->idx,
>  			1, flag, ival, ival >> 32, 0);
> @@ -585,16 +683,36 @@ static void pmu_sbi_ctr_stop(struct perf_event *event, unsigned long flag)
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
> @@ -652,10 +770,14 @@ static inline void pmu_sbi_stop_all(struct riscv_pmu *pmu)
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
> @@ -664,11 +786,10 @@ static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
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
> @@ -703,6 +824,48 @@ static inline void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
>  	}
>  }
>  
> +static noinline void pmu_sbi_start_ovf_ctrs_snapshot(struct cpu_hw_events *cpu_hw_evt,
> +						     unsigned long ctr_ovf_mask)
> +{
> +	int idx = 0;
> +	struct perf_event *event;
> +	unsigned long flag = SBI_PMU_START_FLAG_INIT_SNAPSHOT;
> +	u64 max_period, init_val = 0;
> +	struct hw_perf_event *hwc;
> +	struct riscv_pmu_snapshot_data *sdata = cpu_hw_evt->snapshot_addr;
> +
> +	for_each_set_bit(idx, cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS) {
> +		if (ctr_ovf_mask & (BIT(idx))) {

Unnecessary () around BIT()

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
> @@ -716,6 +879,7 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>  	unsigned long overflowed_ctrs = 0;
>  	struct cpu_hw_events *cpu_hw_evt = dev;
>  	u64 start_clock = sched_clock();
> +	struct riscv_pmu_snapshot_data *sdata = cpu_hw_evt->snapshot_addr;
>  
>  	if (WARN_ON_ONCE(!cpu_hw_evt))
>  		return IRQ_NONE;
> @@ -737,8 +901,10 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
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
> @@ -819,6 +985,9 @@ static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
>  		enable_percpu_irq(riscv_pmu_irq, IRQ_TYPE_NONE);
>  	}
>  
> +	if (sbi_pmu_snapshot_available())
> +		return pmu_sbi_snapshot_setup(pmu, cpu);
> +
>  	return 0;
>  }
>  
> @@ -831,6 +1000,9 @@ static int pmu_sbi_dying_cpu(unsigned int cpu, struct hlist_node *node)
>  	/* Disable all counters access for user mode now */
>  	csr_write(CSR_SCOUNTEREN, 0x0);
>  
> +	if (sbi_pmu_snapshot_available())
> +		return pmu_sbi_snapshot_disable();
> +
>  	return 0;
>  }
>  
> @@ -1106,10 +1278,6 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
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
> @@ -1118,8 +1286,32 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
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

This should be goto out_unregister, and in the case of sbi_v2_available we
also need a pmu_sbi_snapshot_free() and a pmu_sbi_snapshot_disable().

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
> -- 
> 2.34.1
>

Thanks,
drew

