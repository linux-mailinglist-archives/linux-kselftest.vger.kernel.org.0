Return-Path: <linux-kselftest+bounces-8376-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 626C78AA39D
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 22:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8E681F255D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 20:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D5D180A7E;
	Thu, 18 Apr 2024 20:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="NXqr2dXM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D0817F394
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 20:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713470485; cv=none; b=PE0StlFQ4EpEsLfx1iO4fKeKfzATzRI+mLq6mtlBdzRFKwwkw5MbF9Kqp9cTXdI/JcFMQ6k6i8AyGte5oDfauKQMgqKQFPYEmZwrjPk0a0kdNQWOehElMRXG3vtToxSAg3AQiduRYRxQVr4G5H1yzRn4zj8zOmDdY8uCC1d9sYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713470485; c=relaxed/simple;
	bh=cf0PCQhBT408dQRYP8aFl+Rz+dJetAri5k+t1+9NKnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FWx9jj9nCo+vzmgLahE8L5ZqR4BgyU/Nh5wfWO00NM2X/x3mUpg4WO8uikO98APg07RhlK2YR60lflPPKUeOttyh1mt/haGeU2xjFN3uMV0RA14W+5rvWFD2z41uSeq58Ug1Fu4QRIV9D4ZcCsvG63i4wxrMTkXhVi8jkxKOKoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=NXqr2dXM; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-36b38a2288aso5409565ab.0
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 13:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1713470483; x=1714075283; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wp2qHt8JRoKGgCZU0XBGYwPmPX8gJPIBeFYJ91EsI3E=;
        b=NXqr2dXMdC0lYccvuTT8HMxKvfjyVuyESisCYd28Kvt+XViUdnTsd1owdH+XFtEt/4
         LJeQ0tpfNH3vCiIszkY/EuzmON/f3mrCzm7wj4q2pPR2PhgmWpoQ4b30iEp/PFvFkNwI
         /zIKkluDk8io2QQx9T7EYkmqc6UbWo8Gn89kxHxmJFbyrObUYdxygXLmi3Pt3vZJ0P1I
         4HQxS97QwRpVkTthyB4VwBWYjoKj89RxMRx286IjZbFkJiuFeZl1azpWXcxFprYF34ST
         xvmN2jJ45Kb+oLrOVNHeY4ozcPoUzDCTFUN4wbFsPLqsGe/ohKq6MwEyL9+9TVNDp7As
         0FyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713470483; x=1714075283;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wp2qHt8JRoKGgCZU0XBGYwPmPX8gJPIBeFYJ91EsI3E=;
        b=X0E5N9X0vIEdASamed0zW6UVZOescNOMeVVUUiuCwQyL7PfkKHy45hYVxFwgEx3LKd
         72QPp1ru0jfx3aMKE/aF3HYZrUAbNcIHBOscMHTuq+pXjyzdNCSpu3DZijKgx6uJIPya
         d51wKrTO/j4m4npoiH8gxOu3dEiR4UFkzV88uSnHAD5ZKIlRarXdyVEUsLuKHf1LW5GN
         LrPryTxB1iQz2ou8DUlHg3XBEmjcUSSjXKisxbxUF7woFXyFQJPWHMlScPInorD6FbkM
         LyyxE1GmChPmTdruESUL2WyJ7G8JGAC4NVC33KHIM1OXKPxUpIgXczcN5cAMCv0eylYC
         yjMA==
X-Forwarded-Encrypted: i=1; AJvYcCVLDviNGtaLm7/qASFEtSMUY1lfQ9T/UUEz35KOln0HSMNiKWzbPoB5do5fTLWbLPuFCY5GiMJgSJ7hMlK40HyiegI9R6J7rMs/ywseAn/l
X-Gm-Message-State: AOJu0YwhVBuzPKOE+Ej47M2t3aIxC3/KpZK0xl98KXBltblaSXP+pKGD
	KRXDqajyq9K92TH+uYn4R0ud82aEPvpZLGiyzZ7o19SpZTiUEBp7ZaZzIQQhVpk=
X-Google-Smtp-Source: AGHT+IHZgp+rgkg+h161qh+wLcjvodsoRVcNbQf96rmD4T3Z5SagsXuBNe3TLPAKphIwq8th60Fs1g==
X-Received: by 2002:a05:6e02:1848:b0:36a:36d9:36eb with SMTP id b8-20020a056e02184800b0036a36d936ebmr157054ilv.27.1713470482386;
        Thu, 18 Apr 2024 13:01:22 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.197])
        by smtp.gmail.com with ESMTPSA id b16-20020a92dcd0000000b0036b1ebe9e47sm445352ilr.75.2024.04.18.13.01.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 13:01:21 -0700 (PDT)
Message-ID: <1e13e981-14f2-4993-afba-dd3baadffe29@sifive.com>
Date: Thu, 18 Apr 2024 15:01:00 -0500
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
 <d4923b62-3cda-4bdd-900e-265059593cf2@sifive.com>
 <c3dab594-473e-4644-9543-66c172ae61bb@rivosinc.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <c3dab594-473e-4644-9543-66c172ae61bb@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Atish,

On 2024-04-18 2:47 AM, Atish Patra wrote:
> 
> On 4/16/24 21:02, Samuel Holland wrote:
>> Hi Atish,
>>
>> On 2024-04-16 1:44 PM, Atish Patra wrote:
>>> SBI v2.0 SBI introduced PMU snapshot feature which adds the following
>>> features.
>>>
>>> 1. Read counter values directly from the shared memory instead of
>>> csr read.
>>> 2. Start multiple counters with initial values with one SBI call.
>>>
>>> These functionalities optimizes the number of traps to the higher
>>> privilege mode. If the kernel is in VS mode while the hypervisor
>>> deploy trap & emulate method, this would minimize all the hpmcounter
>>> CSR read traps. If the kernel is running in S-mode, the benefits
>>> reduced to CSR latency vs DRAM/cache latency as there is no trap
>>> involved while accessing the hpmcounter CSRs.
>>>
>>> In both modes, it does saves the number of ecalls while starting
>>> multiple counter together with an initial values. This is a likely
>>> scenario if multiple counters overflow at the same time.
>>>
>>> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>>> Reviewed-by: Anup Patel <anup@brainfault.org>
>>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>>> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
>>> ---
>>>   drivers/perf/riscv_pmu.c       |   1 +
>>>   drivers/perf/riscv_pmu_sbi.c   | 224 +++++++++++++++++++++++++++++++--
>>>   include/linux/perf/riscv_pmu.h |   6 +
>>>   3 files changed, 219 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
>>> index b4efdddb2ad9..36d348753d05 100644
>>> --- a/drivers/perf/riscv_pmu.c
>>> +++ b/drivers/perf/riscv_pmu.c
>>> @@ -408,6 +408,7 @@ struct riscv_pmu *riscv_pmu_alloc(void)
>>>           cpuc->n_events = 0;
>>>           for (i = 0; i < RISCV_MAX_COUNTERS; i++)
>>>               cpuc->events[i] = NULL;
>>> +        cpuc->snapshot_addr = NULL;
>>>       }
>>>       pmu->pmu = (struct pmu) {
>>>           .event_init    = riscv_pmu_event_init,
>>> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
>>> index f23501898657..dabf8a17b096 100644
>>> --- a/drivers/perf/riscv_pmu_sbi.c
>>> +++ b/drivers/perf/riscv_pmu_sbi.c
>>> @@ -58,6 +58,9 @@ PMU_FORMAT_ATTR(event, "config:0-47");
>>>   PMU_FORMAT_ATTR(firmware, "config:63");
>>>     static bool sbi_v2_available;
>>> +static DEFINE_STATIC_KEY_FALSE(sbi_pmu_snapshot_available);
>>> +#define sbi_pmu_snapshot_available() \
>>> +    static_branch_unlikely(&sbi_pmu_snapshot_available)
>>>     static struct attribute *riscv_arch_formats_attr[] = {
>>>       &format_attr_event.attr,
>>> @@ -508,14 +511,109 @@ static int pmu_sbi_event_map(struct perf_event *event,
>>> u64 *econfig)
>>>       return ret;
>>>   }
>>>   +static void pmu_sbi_snapshot_free(struct riscv_pmu *pmu)
>>> +{
>>> +    int cpu;
>>> +
>>> +    for_each_possible_cpu(cpu) {
>>> +        struct cpu_hw_events *cpu_hw_evt = per_cpu_ptr(pmu->hw_events, cpu);
>>> +
>>> +        if (!cpu_hw_evt->snapshot_addr)
>>> +            continue;
>>> +
>>> +        free_page((unsigned long)cpu_hw_evt->snapshot_addr);
>>> +        cpu_hw_evt->snapshot_addr = NULL;
>>> +        cpu_hw_evt->snapshot_addr_phys = 0;
>>> +    }
>>> +}
>>> +
>>> +static int pmu_sbi_snapshot_alloc(struct riscv_pmu *pmu)
>>> +{
>>> +    int cpu;
>>> +    struct page *snapshot_page;
>>> +
>>> +    for_each_possible_cpu(cpu) {
>>> +        struct cpu_hw_events *cpu_hw_evt = per_cpu_ptr(pmu->hw_events, cpu);
>>> +
>>> +        if (cpu_hw_evt->snapshot_addr)
>>> +            continue;
>> This condition can never occur because pmu_sbi_snapshot_free() is called in the
>> error path.
> 
> Yeah. Removed it.
> 
>>
>>> +
>>> +        snapshot_page = alloc_page(GFP_ATOMIC | __GFP_ZERO);
>>> +        if (!snapshot_page) {
>>> +            pmu_sbi_snapshot_free(pmu);
>>> +            return -ENOMEM;
>>> +        }
>>> +        cpu_hw_evt->snapshot_addr = page_to_virt(snapshot_page);
>>> +        cpu_hw_evt->snapshot_addr_phys = page_to_phys(snapshot_page);
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int pmu_sbi_snapshot_disable(void)
>>> +{
>>> +    struct sbiret ret;
>>> +
>>> +    ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_SNAPSHOT_SET_SHMEM,
>>> SBI_SHMEM_DISABLE,
>>> +            SBI_SHMEM_DISABLE, 0, 0, 0, 0);
>>> +    if (ret.error) {
>>> +        pr_warn("failed to disable snapshot shared memory\n");
>>> +        return sbi_err_map_linux_errno(ret.error);
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int pmu_sbi_snapshot_setup(struct riscv_pmu *pmu, int cpu)
>>> +{
>>> +    struct cpu_hw_events *cpu_hw_evt;
>>> +    struct sbiret ret = {0};
>>> +
>>> +    cpu_hw_evt = per_cpu_ptr(pmu->hw_events, cpu);
>>> +    if (!cpu_hw_evt->snapshot_addr_phys)
>>> +        return -EINVAL;
>>> +
>>> +    if (cpu_hw_evt->snapshot_set_done)
>>> +        return 0;
>>> +
>>> +    if (IS_ENABLED(CONFIG_32BIT))
>>> +        ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_SNAPSHOT_SET_SHMEM,
>>> +                cpu_hw_evt->snapshot_addr_phys,
>>> +                (u64)(cpu_hw_evt->snapshot_addr_phys) >> 32, 0, 0, 0, 0);
>> phys_addr_t on riscv32 is 32 bits, so the high argument will always be zero.
>> (I'm guessing the compiler warned without the cast?) Do we need this special
>> case?
> 
> As per the spec maximum physical address bits can be 34 bits on RV32. Linux
> kernel doesn't support it yet though.
> But the casting is there just for forward compatibility. We can remove it and
> leave a commit but I thought of keeping it
> there to make things explicit.
> 
>>> +    else
>>> +        ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_SNAPSHOT_SET_SHMEM,
>>> +                cpu_hw_evt->snapshot_addr_phys, 0, 0, 0, 0, 0);
>>> +
>>> +    /* Free up the snapshot area memory and fall back to SBI PMU calls
>>> without snapshot */
>>> +    if (ret.error) {
>>> +        if (ret.error != SBI_ERR_NOT_SUPPORTED)
>>> +            pr_warn("pmu snapshot setup failed with error %ld\n", ret.error);
>>> +        cpu_hw_evt->snapshot_set_done = false;
>> This statement has no effect; snapshot_set_done is known to be false above.
> 
> Removed it.
> 
>>> +        return sbi_err_map_linux_errno(ret.error);
>>> +    }
>>> +
>>> +    cpu_hw_evt->snapshot_set_done = true;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   static u64 pmu_sbi_ctr_read(struct perf_event *event)
>>>   {
>>>       struct hw_perf_event *hwc = &event->hw;
>>>       int idx = hwc->idx;
>>>       struct sbiret ret;
>>>       u64 val = 0;
>>> +    struct riscv_pmu *pmu = to_riscv_pmu(event->pmu);
>>> +    struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
>>> +    struct riscv_pmu_snapshot_data *sdata = cpu_hw_evt->snapshot_addr;
>>>       union sbi_pmu_ctr_info info = pmu_ctr_list[idx];
>>>   +    /* Read the value from the shared memory directly */
>>> +    if (sbi_pmu_snapshot_available()) {
>>> +        val = sdata->ctr_values[idx];
>>> +        return val;
>>> +    }
>> This does not work if pmu_sbi_ctr_read() is called while the counter is started,
>> because ctr_values is only updated when stopping the counter (and the shared
>> memory is only updated at that time as well). So you would need to check for
>> PERF_HES_STOPPED or being in the overflow handler here. And this can't possibly
> 
> Do you see a case where it is not called before counters are stopped ?
> IIRC, perf framework invokes pmu->read() function when counters are stopped
> 
> riscv_pmu.c invokes it only after stopping the counters
> riscv_pmu_stop->riscv_pmu_event_update->rvpmu->ctr_read

It is also called through riscv_pmu_read(). A trivial example where the counters
are read while started is `perf stat -C <cpu> -I <interval>`. With logging the
function and event_idx:

root@riscv64:~# perf stat -C 0 -I 1000 -e cycles
[  104.785970] riscv-pmu-sbi: pmu_sbi_ctr_start: 000001
[  105.793160] riscv-pmu-sbi: pmu_sbi_ctr_read: 000001
#           time             counts unit events
     1.001090667         1015156505      cycles
[  106.800077] riscv-pmu-sbi: pmu_sbi_ctr_read: 000001
     2.008009126         1014973064      cycles
[  107.806955] riscv-pmu-sbi: pmu_sbi_ctr_read: 000001
     3.014884251         1014937544      cycles
[  108.813842] riscv-pmu-sbi: pmu_sbi_ctr_read: 000001
     4.021772502         1014941900      cycles
[  109.820759] riscv-pmu-sbi: pmu_sbi_ctr_read: 000001
     5.028687252         1014974904      cycles
[  110.827678] riscv-pmu-sbi: pmu_sbi_ctr_read: 000001
     6.035604711         1014971076      cycles
[  111.835107] riscv-pmu-sbi: pmu_sbi_ctr_read: 000001
     7.043036628         1015488590      cycles
^C[  111.959028] riscv-pmu-sbi: pmu_sbi_ctr_read: 000001
     7.166958420[  111.964343] riscv-pmu-sbi: pmu_sbi_ctr_stop: 000001
[  111.970435] riscv-pmu-sbi: pmu_sbi_ctr_read: 000001
[  111.975337] riscv-pmu-sbi: pmu_sbi_ctr_stop: 000001
          124942006      cycles

root@riscv64:~#

>> work for idx >= XLEN.
> 
> The idx should be less than num_counters as that's what pmu_ctr_list is
> allocated for.
> ctr_values size limitation is 64 as per the spec which is sufficient as given
> number of defined
> firmware events + hpmcounters < 64.

Yes, but only the first XLEN elements in ctr_values can be read/updated by an
SBI call, and XLEN < 64 on riscv32. This actually works with the current code
for the non-overflow case, because SBI_PMU_START_FLAG_INIT_SNAPSHOT is not used,
and the value copying code in pmu_sbi_ctr_stop() isn't limited by XLEN.

However, pmu_sbi_stop_hw_ctrs() is broken, even after the next patch. Stopping
counters 32-63 will clobber (an arbitrary subset of) the values for counters
0-31. You would need code to move the values for counters 32-63 from the first
half of ctr_values to the second half. And because ctr_values is only written by
the SBI implementation _when the counter is stopped_, we can't ask the SBI
implementation to restore the values for counters 0-31, so those values must be
backed up somewhere else.

The simple solution might be to have a shadow copy of ctr_values, that always
puts the values at the same (absolute) offset.

> We can add a paranoia check for idx but idx is retrieved from event->hw which is
> filled by the driver itself.
> There are lot of function which access idx from event->hw as well.
> 
> That's why, I don't think it is required.

Right, I wasn't concerned about bounds checking, only that
SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT is limited to writing to the first XLEN elements
of ctr_values.

>>> +
>>>       if (pmu_sbi_is_fw_event(event)) {
>>>           ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_FW_READ,
>>>                   hwc->idx, 0, 0, 0, 0, 0);
>>> @@ -565,6 +663,7 @@ static void pmu_sbi_ctr_start(struct perf_event *event,
>>> u64 ival)
>>>       struct hw_perf_event *hwc = &event->hw;
>>>       unsigned long flag = SBI_PMU_START_FLAG_SET_INIT_VALUE;
>>>   +    /* There is no benefit setting SNAPSHOT FLAG for a single counter */
>>>   #if defined(CONFIG_32BIT)
>>>       ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, hwc->idx,
>>>               1, flag, ival, ival >> 32, 0);
>>> @@ -585,16 +684,36 @@ static void pmu_sbi_ctr_stop(struct perf_event *event,
>>> unsigned long flag)
>>>   {
>>>       struct sbiret ret;
>>>       struct hw_perf_event *hwc = &event->hw;
>>> +    struct riscv_pmu *pmu = to_riscv_pmu(event->pmu);
>>> +    struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
>>> +    struct riscv_pmu_snapshot_data *sdata = cpu_hw_evt->snapshot_addr;
>>>         if ((hwc->flags & PERF_EVENT_FLAG_USER_ACCESS) &&
>>>           (hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT))
>>>           pmu_sbi_reset_scounteren((void *)event);
>>>   +    if (sbi_pmu_snapshot_available())
>>> +        flag |= SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT;
>>> +
>>>       ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, hwc->idx, 1,
>>> flag, 0, 0, 0);
>>> -    if (ret.error && (ret.error != SBI_ERR_ALREADY_STOPPED) &&
>>> -        flag != SBI_PMU_STOP_FLAG_RESET)
>>> +    if (!ret.error && sbi_pmu_snapshot_available()) {
>>> +        /*
>>> +         * The counter snapshot is based on the index base specified by
>>> hwc->idx.
>>> +         * The actual counter value is updated in shared memory at index 0
>>> when counter
>>> +         * mask is 0x01. To ensure accurate counter values, it's necessary
>>> to transfer
>>> +         * the counter value to shared memory. However, if hwc->idx is zero,
>>> the counter
>>> +         * value is already correctly updated in shared memory, requiring no
>>> further
>>> +         * adjustment.
>>> +         */
>>> +        if (hwc->idx > 0) {
>>> +            sdata->ctr_values[hwc->idx] = sdata->ctr_values[0];
>>> +            sdata->ctr_values[0] = 0;
>> This clobbers sdata->ctr_values[0], which may be used later by
>> pmu_sbi_ctr_read(). This only happens to work if riscv_pmu_stop() is always
>> called with the PERF_EF_UPDATE flag, and riscv_pmu_read() is never called with
>> the event stopped but still in PERF_EVENT_STATE_ACTIVE. I think both of those
>> conditions are true at the moment, but this is still rather fragile.
> 
> I don't understand the concern of being fragile when the current implementation
> does it what you just described.
> 
> Can you describe the use case when you think it will be fragile ? Do you
> envision some core perf framework
> changes that would call pmu->stop() without PERF_EF_UPDATE ?

PERF_EF_UPDATE is a flag, so the API seems to have been designed with the
expectation that it is set only sometimes. I can't predict how the core perf
logic will change, but I doubt whoever is changing it will be aware of the
subtle undocumented requirements for correctness here. Regardless, it's not an
issue if we copy the counter values outside the shared memory.

>>> +        }
>>> +    } else if (ret.error && (ret.error != SBI_ERR_ALREADY_STOPPED) &&
>>> +        flag != SBI_PMU_STOP_FLAG_RESET) {
>>>           pr_err("Stopping counter idx %d failed with error %d\n",
>>>               hwc->idx, sbi_err_map_linux_errno(ret.error));
>>> +    }
>>>   }
>>>     static int pmu_sbi_find_num_ctrs(void)
>>> @@ -652,10 +771,14 @@ static inline void pmu_sbi_stop_all(struct riscv_pmu *pmu)
>>>   static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
>>>   {
>>>       struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
>>> +    unsigned long flag = 0;
>>> +
>>> +    if (sbi_pmu_snapshot_available())
>>> +        flag = SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT;
>>>         /* No need to check the error here as we can't do anything about the
>>> error */
>>>       sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, 0,
>>> -          cpu_hw_evt->used_hw_ctrs[0], 0, 0, 0, 0);
>>> +          cpu_hw_evt->used_hw_ctrs[0], flag, 0, 0, 0);
>> This only updates the overflow bitmap and counter values for the first XLEN
>> counters. You need a second call for any remaining counters on riscv32. Of
>> course, this will clobber (up to) the entire shared memory, breaking later calls
>> to pmu_sbi_ctr_read().
> 
> It's done in the next patch.
> https://lore.kernel.org/lkml/20240416184421.3693802-10-atishp@rivosinc.com/

This still isn't right (overflowed_ctrs and ctr_ovf_mask also need to be 64
bits), and the fix should come before patches adding new features.

>>>   }
>>>     /*
>>> @@ -664,11 +787,10 @@ static inline void pmu_sbi_stop_hw_ctrs(struct
>>> riscv_pmu *pmu)
>>>    * while the overflowed counters need to be started with updated
>>> initialization
>>>    * value.
>>>    */
>>> -static inline void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
>>> -                           unsigned long ctr_ovf_mask)
>>> +static noinline void pmu_sbi_start_ovf_ctrs_sbi(struct cpu_hw_events
>>> *cpu_hw_evt,
>>> +                        unsigned long ctr_ovf_mask)
>>>   {
>>>       int idx = 0;
>>> -    struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
>>>       struct perf_event *event;
>>>       unsigned long flag = SBI_PMU_START_FLAG_SET_INIT_VALUE;
>>>       unsigned long ctr_start_mask = 0;
>>> @@ -703,6 +825,48 @@ static inline void pmu_sbi_start_overflow_mask(struct
>>> riscv_pmu *pmu,
>>>       }
>>>   }
>>>   +static noinline void pmu_sbi_start_ovf_ctrs_snapshot(struct cpu_hw_events
>>> *cpu_hw_evt,
>>> +                             unsigned long ctr_ovf_mask)
>> Why do these two functions need to be noinline?
>>
> They don't. I will remove it.
> 
>>> +{
>>> +    int idx = 0;
>>> +    struct perf_event *event;
>>> +    unsigned long flag = SBI_PMU_START_FLAG_INIT_SNAPSHOT;
>>> +    u64 max_period, init_val = 0;
>>> +    struct hw_perf_event *hwc;
>>> +    struct riscv_pmu_snapshot_data *sdata = cpu_hw_evt->snapshot_addr;
>>> +
>>> +    for_each_set_bit(idx, cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS) {
>>> +        if (ctr_ovf_mask & BIT(idx)) {
>> This is also broken on riscv32 (as is the existing code), since ctr_ovf_mask is
>> only 32 bits there, but idx counts from 0 to 63.
> 
> For RV32, if there is a counter idx that is beyond 32 bits, it is not supported
> in counter overflow
> scenario anyways. So it doesn't matter now.
> 
> We need to change the pmu_sbi_ovf_handler to handle counter overflows for
> counters > 32 bit though.
> As there is not use case right now, I did not add it.

There are two sets of indexes here. There's the bits in SCOUNTOVF, which are
limited to 32 bits; and there are the SBI counter indexes, which go up to 64. A
bit < 32 in SCOUNTOVF might map to a SBI counter index >= 32. The fact that
pmu_sbi_ovf_handler() is limited to SBI counter indexes < XLEN is a bug.

>>> +            event = cpu_hw_evt->events[idx];
>>> +            hwc = &event->hw;
>>> +            max_period = riscv_pmu_ctr_get_width_mask(event);
>>> +            init_val = local64_read(&hwc->prev_count) & max_period;
>>> +            sdata->ctr_values[idx] = init_val;
>>> +        }
>>> +        /*
>>> +         * We do not need to update the non-overflow counters the previous
>>> +         * value should have been there already.
>>> +         */
>>> +    }
>>> +
>>> +    for (idx = 0; idx < BITS_TO_LONGS(RISCV_MAX_COUNTERS); idx++) {
>>> +        /* Start all the counters in a single shot */
>>> +        sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, idx * BITS_PER_LONG,
>>> +              cpu_hw_evt->used_hw_ctrs[idx], flag, 0, 0, 0);
>>> +    }
>>> +}
>>> +
>>> +static void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
>>> +                    unsigned long ctr_ovf_mask)
>>> +{
>>> +    struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
>>> +
>>> +    if (sbi_pmu_snapshot_available())
>>> +        pmu_sbi_start_ovf_ctrs_snapshot(cpu_hw_evt, ctr_ovf_mask);
>>> +    else
>>> +        pmu_sbi_start_ovf_ctrs_sbi(cpu_hw_evt, ctr_ovf_mask);
>>> +}
>>> +
>>>   static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>>>   {
>>>       struct perf_sample_data data;
>>> @@ -716,6 +880,7 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>>>       unsigned long overflowed_ctrs = 0;
>>>       struct cpu_hw_events *cpu_hw_evt = dev;
>>>       u64 start_clock = sched_clock();
>>> +    struct riscv_pmu_snapshot_data *sdata = cpu_hw_evt->snapshot_addr;
>>>         if (WARN_ON_ONCE(!cpu_hw_evt))
>>>           return IRQ_NONE;
>>> @@ -737,8 +902,10 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>>>       pmu_sbi_stop_hw_ctrs(pmu);
>>>         /* Overflow status register should only be read after counter are
>>> stopped */
>>> -    ALT_SBI_PMU_OVERFLOW(overflow);
>>> -
>> nit: no need to remove this line.
> 
> Fixed.
> 
> 
>>> +    if (sbi_pmu_snapshot_available())
>>> +        overflow = sdata->ctr_overflow_mask;
>>> +    else
>>> +        ALT_SBI_PMU_OVERFLOW(overflow);
>>>       /*
>>>        * Overflow interrupt pending bit should only be cleared after stopping
>>>        * all the counters to avoid any race condition.
>>> @@ -819,6 +986,9 @@ static int pmu_sbi_starting_cpu(unsigned int cpu, struct
>>> hlist_node *node)
>>>           enable_percpu_irq(riscv_pmu_irq, IRQ_TYPE_NONE);
>>>       }
>>>   +    if (sbi_pmu_snapshot_available())
>>> +        return pmu_sbi_snapshot_setup(pmu, cpu);
>>> +
>>>       return 0;
>>>   }
>>>   @@ -831,6 +1001,9 @@ static int pmu_sbi_dying_cpu(unsigned int cpu, struct
>>> hlist_node *node)
>>>       /* Disable all counters access for user mode now */
>>>       csr_write(CSR_SCOUNTEREN, 0x0);
>>>   +    if (sbi_pmu_snapshot_available())
>>> +        return pmu_sbi_snapshot_disable();
>>> +
>>>       return 0;
>>>   }
>>>   @@ -939,6 +1112,11 @@ static inline void riscv_pm_pmu_unregister(struct
>>> riscv_pmu *pmu) { }
>>>     static void riscv_pmu_destroy(struct riscv_pmu *pmu)
>>>   {
>>> +    if (sbi_v2_available) {
>>> +        pmu_sbi_snapshot_free(pmu);
>>> +        if (sbi_pmu_snapshot_available())
>>> +            pmu_sbi_snapshot_disable();
>> This is technically fine because nothing is writing to the shmem at this time,
>> but it certainly looks like a possible use-after-free.
> 
> Yes. It would have been use-after-free if pmu_sbi_snapshot_disable uses the
> allocated
> address. I guess the the function name doesn't indicate that the disable happens
> by passing -1 instead
> of the previously allocated address.
> 
> 
>> Also, this whole block can go inside the sbi_pmu_snapshot_available() check,
>> because either the branch is set or pmu_sbi_snapshot_free() is already called in
>> the error case below.
> 
> I kept it above because the conditions are different logically.
> The sbi_pmu_snapshot_available is only enabled when snapshot_setup succeeds not
> when snapshot_alloc is successful.
> 
> In reality, it doesn't matter though as we free it in the error case as you
> pointed.
> 
> Either way, I will move it inside.

Makes sense to me.

Regards,
Samuel

>>> +    }
>>>       riscv_pm_pmu_unregister(pmu);
>>>       cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
>>>   }
>>> @@ -1106,10 +1284,6 @@ static int pmu_sbi_device_probe(struct platform_device
>>> *pdev)
>>>       pmu->event_unmapped = pmu_sbi_event_unmapped;
>>>       pmu->csr_index = pmu_sbi_csr_index;
>>>   -    ret = cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
>>> -    if (ret)
>>> -        return ret;
>>> -
>>>       ret = riscv_pm_pmu_register(pmu);
>>>       if (ret)
>>>           goto out_unregister;
>>> @@ -1118,8 +1292,34 @@ static int pmu_sbi_device_probe(struct platform_device
>>> *pdev)
>>>       if (ret)
>>>           goto out_unregister;
>>>   +    /* SBI PMU Snapsphot is only available in SBI v2.0 */
>>> +    if (sbi_v2_available) {
>>> +        ret = pmu_sbi_snapshot_alloc(pmu);
>>> +        if (ret)
>>> +            goto out_unregister;
>>> +
>>> +        ret = pmu_sbi_snapshot_setup(pmu, smp_processor_id());
>>> +        if (ret) {
>>> +            /* Snapshot is an optional feature. Continue if not available */
>>> +            pmu_sbi_snapshot_free(pmu);
>>> +        } else {
>>> +            pr_info("SBI PMU snapshot detected\n");
>>> +            /*
>>> +             * We enable it once here for the boot cpu. If snapshot shmem setup
>>> +             * fails during cpu hotplug process, it will fail to start the cpu
>>> +             * as we can not handle hetergenous PMUs with different snapshot
>>> +             * capability.
>>> +             */
>>> +            static_branch_enable(&sbi_pmu_snapshot_available);
>>> +        }
>>> +    }
>>> +
>>>       register_sysctl("kernel", sbi_pmu_sysctl_table);
>>>   +    ret = cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
>>> +    if (ret)
>>> +        goto out_unregister;
>>> +
>>>       return 0;
>>>     out_unregister:
>>> diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
>>> index 43282e22ebe1..c3fa90970042 100644
>>> --- a/include/linux/perf/riscv_pmu.h
>>> +++ b/include/linux/perf/riscv_pmu.h
>>> @@ -39,6 +39,12 @@ struct cpu_hw_events {
>>>       DECLARE_BITMAP(used_hw_ctrs, RISCV_MAX_COUNTERS);
>>>       /* currently enabled firmware counters */
>>>       DECLARE_BITMAP(used_fw_ctrs, RISCV_MAX_COUNTERS);
>>> +    /* The virtual address of the shared memory where counter snapshot will
>>> be taken */
>>> +    void *snapshot_addr;
>>> +    /* The physical address of the shared memory where counter snapshot will
>>> be taken */
>>> +    phys_addr_t snapshot_addr_phys;
>>> +    /* Boolean flag to indicate setup is already done */
>>> +    bool snapshot_set_done;
>>>   };
>>>     struct riscv_pmu {


