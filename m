Return-Path: <linux-kselftest+bounces-7047-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C38B8966B4
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 09:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D09285686
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 07:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD426EB67;
	Wed,  3 Apr 2024 07:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="mRIdH7tr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533205D737
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Apr 2024 07:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712129808; cv=none; b=aEuLTiiP2lwKanBO97tpguVl5mqW6psc0Zf+xtVKpNTHtWR/Ov4Wud1cRQnpp2+wsaJKr2rnVlInRZFzLlDlDZBJ0ANJius3dFiHBq6AXOYuLw1ggX7d7HrdLcFiQ06XX+iOfUNOmejUlbmGMHr/gju2/V8094v4qelTTlvoZe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712129808; c=relaxed/simple;
	bh=N12r8/H2ZijzxzI5R47jV6U/5E389Ca2qn74O6uFp5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JB6VwxApS6P4CKQ81oQjGC54Jhr1OqXyxEFKRClmh1DXRIqUu4g9Pgmk5TkWoZB14fsW9RRqZ9Cu5NpVNq/aDB4hphfOZ+JGbgGJ1peMnkF2KRLT9vjhgTl7tJ/JqULqpbCyR3YCWOWahsWcIO4ImhcKngiTNkmczeIOh1VAKjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=mRIdH7tr; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e2987e9d67so906425ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Apr 2024 00:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712129805; x=1712734605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IQpzZArlGfJYBuSfWBUhzl7YP9oA2MCeqdxxTvwKJ6o=;
        b=mRIdH7trmqLXO80rXn+tiE+ESXOBWk6XCK1jvOcYlg4+XsYFehsAgB0cNWxB0/lEKe
         bVxB5caWMC3XwvEnW67bhSCMQKQ7n0WygzxWstwmUrzMacFs/LYUKzDzvxq+KY6uGG47
         aIaR7TgNE3h6Sf1t77zgg/sZ6YyjtRfw3q0ZWXAWjTAwgjfnAM3xUkA9GA6l9koPVTax
         zrsRPp+T1KVKB2s7dceV9UNNXqrq0vPdRFQxYYWNQucobcYTE6m6KLk0tAzgz1cS8VdA
         LvdVAPXTkCJDuBRl+kZ5tQpVL4xS2Ysk2n7yk6qvexH9oZ/7WkmjceE780L33hwLpVuh
         hSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712129805; x=1712734605;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IQpzZArlGfJYBuSfWBUhzl7YP9oA2MCeqdxxTvwKJ6o=;
        b=k7RzGsaGv1WN/il8CcyDw6VuNN9ed3ha1+oXyMDtVBGDv5bemnOP+b8xQ9zECC5wr/
         aUsVtoagtv06wQhXtw+pQAX9L8j6SFFrnZElqOTzGUQeU2dElUIEZXgD8JMZgD9xsbH5
         JKC1O+VTianPl+m7dBk0jllUCDqKq5KV6Q5kljm3IX1L1bMRqQs5E6sJLc5MdiO38iOi
         vOzQTl/n3XAOm26E6kKhk5uUYpx3CEO9QBYFYhy4gPwV1vqsyHYK2o/K82AQHrUG2rJQ
         zIMynqV04WbzF/nS8NM5pow1f+wE/ym8G9CBZRJCedFlem/sGmk68gPzt5e3SZqwAhIk
         HTzg==
X-Forwarded-Encrypted: i=1; AJvYcCVxUk8kLw/x8aL4/RcLI1QWk+ohAt37hcU/dFIM2Q4rohKoxdq23r45V5oHD+UjEUIKlBm3L3cSmKw1gwj9IiMysCKVh4rO/cFaXCiKHbQh
X-Gm-Message-State: AOJu0YxDhclYHd3H9KeJEsMZHGN3J8RzyiPbdM+7GRfk7ywp4SN4NblY
	KoYhTMGSKcqccD4po5KsrwGSB8KYuJH0m7OQy8jtc5oZFBwUaOWBFnnVyrgXh7o=
X-Google-Smtp-Source: AGHT+IGQfpT5TIhYfq9vwX/P51mdnd9ta2F0BiVCWL7etleJQIhV4I+MyTUSgLsbE8QKwJSMbVGPKg==
X-Received: by 2002:a17:903:1c1:b0:1e0:188c:ad4f with SMTP id e1-20020a17090301c100b001e0188cad4fmr2405697plh.26.1712129804531;
        Wed, 03 Apr 2024 00:36:44 -0700 (PDT)
Received: from ?IPV6:2601:647:4180:9630::406? ([2601:647:4180:9630::406])
        by smtp.gmail.com with ESMTPSA id u4-20020a17090341c400b001e2967ec100sm587265ple.58.2024.04.03.00.36.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 00:36:44 -0700 (PDT)
Message-ID: <a75fa96e-2f26-49a7-a7f7-4a397c4a4513@rivosinc.com>
Date: Wed, 3 Apr 2024 00:36:41 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/15] RISC-V: KVM: Implement SBI PMU Snapshot feature
Content-Language: en-US
To: Atish Patra <atishp@atishpatra.org>,
 Andrew Jones <ajones@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Conor Dooley <conor.dooley@microchip.com>, Guo Ren <guoren@kernel.org>,
 Icenowy Zheng <uwu@icenowy.me>, kvm-riscv@lists.infradead.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-riscv@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>,
 Will Deacon <will@kernel.org>
References: <20240229010130.1380926-1-atishp@rivosinc.com>
 <20240229010130.1380926-9-atishp@rivosinc.com>
 <20240302-6ae8fe37b90f127bc9be737f@orel>
 <CAOnJCUKjZWnS_SaR78Fy5AUOxrd+4gBx=_YrA=FQCa20iwifNQ@mail.gmail.com>
From: Atish Patra <atishp@rivosinc.com>
In-Reply-To: <CAOnJCUKjZWnS_SaR78Fy5AUOxrd+4gBx=_YrA=FQCa20iwifNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/1/24 15:36, Atish Patra wrote:
> On Sat, Mar 2, 2024 at 1:49 AM Andrew Jones <ajones@ventanamicro.com> wrote:
>>
>> On Wed, Feb 28, 2024 at 05:01:23PM -0800, Atish Patra wrote:
>>> PMU Snapshot function allows to minimize the number of traps when the
>>> guest access configures/access the hpmcounters. If the snapshot feature
>>> is enabled, the hypervisor updates the shared memory with counter
>>> data and state of overflown counters. The guest can just read the
>>> shared memory instead of trap & emulate done by the hypervisor.
>>>
>>> This patch doesn't implement the counter overflow yet.
>>>
>>> Reviewed-by: Anup Patel <anup@brainfault.org>
>>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
>>> ---
>>>   arch/riscv/include/asm/kvm_vcpu_pmu.h |   7 ++
>>>   arch/riscv/kvm/vcpu_pmu.c             | 120 +++++++++++++++++++++++++-
>>>   arch/riscv/kvm/vcpu_sbi_pmu.c         |   3 +
>>>   drivers/perf/riscv_pmu_sbi.c          |   2 +-
>>>   4 files changed, 129 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/riscv/include/asm/kvm_vcpu_pmu.h b/arch/riscv/include/asm/kvm_vcpu_pmu.h
>>> index 395518a1664e..586bab84be35 100644
>>> --- a/arch/riscv/include/asm/kvm_vcpu_pmu.h
>>> +++ b/arch/riscv/include/asm/kvm_vcpu_pmu.h
>>> @@ -50,6 +50,10 @@ struct kvm_pmu {
>>>        bool init_done;
>>>        /* Bit map of all the virtual counter used */
>>>        DECLARE_BITMAP(pmc_in_use, RISCV_KVM_MAX_COUNTERS);
>>> +     /* The address of the counter snapshot area (guest physical address) */
>>> +     gpa_t snapshot_addr;
>>> +     /* The actual data of the snapshot */
>>> +     struct riscv_pmu_snapshot_data *sdata;
>>>   };
>>>
>>>   #define vcpu_to_pmu(vcpu) (&(vcpu)->arch.pmu_context)
>>> @@ -85,6 +89,9 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_ba
>>>   int kvm_riscv_vcpu_pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
>>>                                struct kvm_vcpu_sbi_return *retdata);
>>>   void kvm_riscv_vcpu_pmu_init(struct kvm_vcpu *vcpu);
>>> +int kvm_riscv_vcpu_pmu_setup_snapshot(struct kvm_vcpu *vcpu, unsigned long saddr_low,
>>> +                                   unsigned long saddr_high, unsigned long flags,
>>> +                                   struct kvm_vcpu_sbi_return *retdata);
>>
>> I prefer to name this function
>>
>> kvm_riscv_vcpu_pmu_snapshot_set_shmem
>>
> 
> Sure.
> 
>>>   void kvm_riscv_vcpu_pmu_deinit(struct kvm_vcpu *vcpu);
>>>   void kvm_riscv_vcpu_pmu_reset(struct kvm_vcpu *vcpu);
>>>
>>> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
>>> index 29bf4ca798cb..74865e6050a1 100644
>>> --- a/arch/riscv/kvm/vcpu_pmu.c
>>> +++ b/arch/riscv/kvm/vcpu_pmu.c
>>> @@ -311,6 +311,81 @@ int kvm_riscv_vcpu_pmu_read_hpm(struct kvm_vcpu *vcpu, unsigned int csr_num,
>>>        return ret;
>>>   }
>>>
>>> +static void kvm_pmu_clear_snapshot_area(struct kvm_vcpu *vcpu)
>>> +{
>>> +     struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
>>> +     int snapshot_area_size = sizeof(struct riscv_pmu_snapshot_data);
>>> +
>>> +     if (kvpmu->sdata) {
>>> +             memset(kvpmu->sdata, 0, snapshot_area_size);
>>> +             if (kvpmu->snapshot_addr != INVALID_GPA)
>>
>> It's a KVM bug if we have non-null sdata but snapshot_addr is INVALID_GPA,
>> right? Maybe we should warn if we see that. We can also move the memset
>> inside the if block.
>>
> 
> Added a warning.
> 
>>> +                     kvm_vcpu_write_guest(vcpu, kvpmu->snapshot_addr,
>>> +                                          kvpmu->sdata, snapshot_area_size);
>>> +             kfree(kvpmu->sdata);
>>> +             kvpmu->sdata = NULL;
>>> +     }
>>> +     kvpmu->snapshot_addr = INVALID_GPA;
>>> +}
>>> +
>>> +int kvm_riscv_vcpu_pmu_setup_snapshot(struct kvm_vcpu *vcpu, unsigned long saddr_low,
>>> +                                   unsigned long saddr_high, unsigned long flags,
>>> +                                   struct kvm_vcpu_sbi_return *retdata)
>>> +{
>>> +     struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
>>> +     int snapshot_area_size = sizeof(struct riscv_pmu_snapshot_data);
>>> +     int sbiret = 0;
>>> +     gpa_t saddr;
>>> +     unsigned long hva;
>>> +     bool writable;
>>> +
>>> +     if (!kvpmu) {
>>> +             sbiret = SBI_ERR_INVALID_PARAM;
>>> +             goto out;
>>> +     }
>>
>> Need to check that flags is zero or return SBI_ERR_INVALID_PARAM.
>>
> 
> Fixed.
> 
>>> +
>>> +     if (saddr_low == -1 && saddr_high == -1) {
>>
>> We introduced SBI_STA_SHMEM_DISABLE for these magic -1's for STA. Since
>> SBI is using the -1 approach for all its shmem, then maybe we should
>> rename SBI_STA_SHMEM_DISABLE to SBI_SHMEM_DISABLE and then use them here
>> too.
>>
> 
> Fixed
> 
>>> +             kvm_pmu_clear_snapshot_area(vcpu);
>>> +             return 0;
>>> +     }
>>> +
>>> +     saddr = saddr_low;
>>> +
>>> +     if (saddr_high != 0) {
>>> +             if (IS_ENABLED(CONFIG_32BIT))
>>> +                     saddr |= ((gpa_t)saddr << 32);
>>> +             else
>>> +                     sbiret = SBI_ERR_INVALID_ADDRESS;
>>> +             goto out;
>>> +     }
>>> +
>>> +     if (kvm_is_error_gpa(vcpu->kvm, saddr)) {
>>> +             sbiret = SBI_ERR_INVALID_PARAM;
>>> +             goto out;
>>> +     }
>>
>> Does the check above provide anything more than what the check below does?
>>
> You are correct. I have removed the check
> 
>>> +
>>> +     hva = kvm_vcpu_gfn_to_hva_prot(vcpu, saddr >> PAGE_SHIFT, &writable);
>>> +     if (kvm_is_error_hva(hva) || !writable) {
>>> +             sbiret = SBI_ERR_INVALID_ADDRESS;
>>> +             goto out;
>>> +     }
>>> +
>>> +     kvpmu->snapshot_addr = saddr;
>>> +     kvpmu->sdata = kzalloc(snapshot_area_size, GFP_ATOMIC);
>>> +     if (!kvpmu->sdata)
>>
>> Should reset snapshot_addr to INVALID_GPA here on error. Or maybe we
>> should just set snapshot_addr to saddr at the bottom of this function if
>> we make it.
>>
> 
> Done.
> 
>>> +             return -ENOMEM;
>>> +
>>> +     if (kvm_vcpu_write_guest(vcpu, saddr, kvpmu->sdata, snapshot_area_size)) {
>>> +             kfree(kvpmu->sdata);
>>> +             kvpmu->snapshot_addr = INVALID_GPA;
>>> +             sbiret = SBI_ERR_FAILURE;
>>
>> I agree we should return this SBI error for this case, but unfortunately
>> the spec is missing the
>>
>>   SBI_ERR_FAILED - The request failed for unspecified or unknown other reasons.
>>
>> that we have for other SBI functions. I guess we should keep the code like
>> this and open a PR to the spec.
>>
> 
> I have created a blanket github issue for now. I will send a PR.
> 
>>> +     }
>>> +
>>> +out:
>>> +     retdata->err_val = sbiret;
>>> +
>>> +     return 0;
>>> +}
>>> +
>>>   int kvm_riscv_vcpu_pmu_num_ctrs(struct kvm_vcpu *vcpu,
>>>                                struct kvm_vcpu_sbi_return *retdata)
>>>   {
>>> @@ -344,20 +419,33 @@ int kvm_riscv_vcpu_pmu_ctr_start(struct kvm_vcpu *vcpu, unsigned long ctr_base,
>>>        int i, pmc_index, sbiret = 0;
>>>        struct kvm_pmc *pmc;
>>>        int fevent_code;
>>> +     bool snap_flag_set = flags & SBI_PMU_START_FLAG_INIT_FROM_SNAPSHOT;
>>
>> This function should confirm no undefined bits are set in flags and the
>> spec should specify that the reserved flags must be zero otherwise an
>> invalid param will be returned.
>>
>> Also here would should confirm that only one of the two flags is set,
>> otherwise return invalid param, as they've specified to be mutually
>> exclusive.
>>
> 
> That makes sense. Update the same github issue.
> (https://github.com/riscv-non-isa/riscv-sbi-doc/issues/145)
> 
> I will make the necessary changes in a separate series after the spec is merged.
> 
>> Regarding the spec, the note about the counter value not being modified
>> unless SBI_PMU_START_SET_INIT_VALUE is set should be modified to state
>> unless either of the two flags are set (so I think we need another spec
>> PR).
>>
>> (The same flags checking/specifying comments apply to the other functions
>> with flags too.)
>>
> 
> Noted (https://github.com/riscv-non-isa/riscv-sbi-doc/issues/146).
> 
>>>
>>>        if (kvm_pmu_validate_counter_mask(kvpmu, ctr_base, ctr_mask) < 0) {
>>>                sbiret = SBI_ERR_INVALID_PARAM;
>>>                goto out;
>>>        }
>>>
>>> +     if (snap_flag_set && kvpmu->snapshot_addr == INVALID_GPA) {
>>> +             sbiret = SBI_ERR_NO_SHMEM;
>>> +             goto out;
>>> +     }
>>> +
>>>        /* Start the counters that have been configured and requested by the guest */
>>>        for_each_set_bit(i, &ctr_mask, RISCV_MAX_COUNTERS) {
>>>                pmc_index = i + ctr_base;
>>>                if (!test_bit(pmc_index, kvpmu->pmc_in_use))
>>>                        continue;
>>>                pmc = &kvpmu->pmc[pmc_index];
>>> -             if (flags & SBI_PMU_START_FLAG_SET_INIT_VALUE)
>>> +             if (flags & SBI_PMU_START_FLAG_SET_INIT_VALUE) {
>>>                        pmc->counter_val = ival;
>>> +             } else if (snap_flag_set) {
>>> +                     kvm_vcpu_read_guest(vcpu, kvpmu->snapshot_addr, kvpmu->sdata,
>>> +                                         sizeof(struct riscv_pmu_snapshot_data));
>>
>> The snapshot read should be outside the for_each_set_bit() loop and we
>> should warn and abort the counter starting if the read fails.
>>
> 
> Fixed. This should also fall under the SBI_ERR_FAILURE category.
> 
>>> +                     /* The counter index in the snapshot are relative to the counter base */
>>> +                     pmc->counter_val = kvpmu->sdata->ctr_values[i];
>>> +             }
>>> +
>>>                if (pmc->cinfo.type == SBI_PMU_CTR_TYPE_FW) {
>>>                        fevent_code = get_event_code(pmc->event_idx);
>>>                        if (fevent_code >= SBI_PMU_FW_MAX) {
>>> @@ -398,14 +486,21 @@ int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *vcpu, unsigned long ctr_base,
>>>   {
>>>        struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
>>>        int i, pmc_index, sbiret = 0;
>>> +     u64 enabled, running;
>>>        struct kvm_pmc *pmc;
>>>        int fevent_code;
>>> +     bool snap_flag_set = flags & SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT;
>>>
>>> -     if (kvm_pmu_validate_counter_mask(kvpmu, ctr_base, ctr_mask) < 0) {
>>> +     if ((kvm_pmu_validate_counter_mask(kvpmu, ctr_base, ctr_mask) < 0)) {
>>
>> Added unnecessary () here.
>>
> 
> Fixed.
> 
>>>                sbiret = SBI_ERR_INVALID_PARAM;
>>>                goto out;
>>>        }
>>>
>>> +     if (snap_flag_set && kvpmu->snapshot_addr == INVALID_GPA) {
>>> +             sbiret = SBI_ERR_NO_SHMEM;
>>> +             goto out;
>>> +     }
>>> +
>>>        /* Stop the counters that have been configured and requested by the guest */
>>>        for_each_set_bit(i, &ctr_mask, RISCV_MAX_COUNTERS) {
>>>                pmc_index = i + ctr_base;
>>> @@ -438,9 +533,28 @@ int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *vcpu, unsigned long ctr_base,
>>>                } else {
>>>                        sbiret = SBI_ERR_INVALID_PARAM;
>>>                }
>>> +
>>> +             if (snap_flag_set && !sbiret) {
>>> +                     if (pmc->cinfo.type == SBI_PMU_CTR_TYPE_FW)
>>> +                             pmc->counter_val = kvpmu->fw_event[fevent_code].value;
>>> +                     else if (pmc->perf_event)
>>> +                             pmc->counter_val += perf_event_read_value(pmc->perf_event,
>>> +                                                                       &enabled, &running);
>>> +                     /* TODO: Add counter overflow support when sscofpmf support is added */
>>> +                     kvpmu->sdata->ctr_values[i] = pmc->counter_val;
>>> +                     kvm_vcpu_write_guest(vcpu, kvpmu->snapshot_addr, kvpmu->sdata,
>>> +                                          sizeof(struct riscv_pmu_snapshot_data));
>>
>> Should just set a boolean here saying that the snapshot needs an update
>> and then do the update outside the for_each_set_bit loop.
>>
> 
> Done.
> 
>>> +             }
>>> +
>>>                if (flags & SBI_PMU_STOP_FLAG_RESET) {
>>>                        pmc->event_idx = SBI_PMU_EVENT_IDX_INVALID;
>>>                        clear_bit(pmc_index, kvpmu->pmc_in_use);
>>> +                     if (snap_flag_set) {
>>> +                             /* Clear the snapshot area for the upcoming deletion event */
>>> +                             kvpmu->sdata->ctr_values[i] = 0;
>>> +                             kvm_vcpu_write_guest(vcpu, kvpmu->snapshot_addr, kvpmu->sdata,
>>> +                                                  sizeof(struct riscv_pmu_snapshot_data));
>>
>> The spec isn't clear on this (so we should clarify it), but I'd expect
>> that a caller who set both the reset and the snapshot flag would want
>> the snapshot from before the reset when this call completes and then
>> assume that when they start counting again, and look at the snapshot
>> again, that those new counts would be from the reset values. Or maybe
>> not :-) Maybe they want to do a reset and take a snapshot in order to
>> look at the snapshot and confirm the reset happened? Either way, it
>> seems we should only do one of the two here. Either update the snapshot
>> before resetting, and not again after reset, or reset and then update
>> the snapshot (with no need to update before).
>>
> 
> The reset call should happen when the event is deleted by the perf
> framework in supervisor.
> If we don't clear the values, the shared memory may have stale data of
> last read counters
> which is not ideal. That's why, I am clearing it upon resetting.

Thinking about it more, I think having stale values in the shared memory
would be similar expected behavior to hardware counters after reset. We 
don't need to clear the shared memory during the reset.

If both SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT and SBI_PMU_STOP_FLAG_RESET are 
set, may be we should just write it to the shared memory again without 
assuming the intention of the caller ?

> The actual counter value should be read while stopping the counters.
> 
> I thought the current description is clear enough as it says
> 
> "SBI_PMU_STOP_FLAG_RESET - Reset the counter to event mapping."
> 
> Do you feel we should be more explicit about this ?
> 
>>> +                     }
>>>                }
>>>        }
>>>
>>> @@ -566,6 +680,7 @@ void kvm_riscv_vcpu_pmu_init(struct kvm_vcpu *vcpu)
>>>        kvpmu->num_hw_ctrs = num_hw_ctrs + 1;
>>>        kvpmu->num_fw_ctrs = SBI_PMU_FW_MAX;
>>>        memset(&kvpmu->fw_event, 0, SBI_PMU_FW_MAX * sizeof(struct kvm_fw_event));
>>> +     kvpmu->snapshot_addr = INVALID_GPA;
>>>
>>>        if (kvpmu->num_hw_ctrs > RISCV_KVM_MAX_HW_CTRS) {
>>>                pr_warn_once("Limiting the hardware counters to 32 as specified by the ISA");
>>> @@ -625,6 +740,7 @@ void kvm_riscv_vcpu_pmu_deinit(struct kvm_vcpu *vcpu)
>>>        }
>>>        bitmap_zero(kvpmu->pmc_in_use, RISCV_MAX_COUNTERS);
>>>        memset(&kvpmu->fw_event, 0, SBI_PMU_FW_MAX * sizeof(struct kvm_fw_event));
>>> +     kvm_pmu_clear_snapshot_area(vcpu);
>>>   }
>>>
>>>   void kvm_riscv_vcpu_pmu_reset(struct kvm_vcpu *vcpu)
>>> diff --git a/arch/riscv/kvm/vcpu_sbi_pmu.c b/arch/riscv/kvm/vcpu_sbi_pmu.c
>>> index b70179e9e875..9f61136e4bb1 100644
>>> --- a/arch/riscv/kvm/vcpu_sbi_pmu.c
>>> +++ b/arch/riscv/kvm/vcpu_sbi_pmu.c
>>> @@ -64,6 +64,9 @@ static int kvm_sbi_ext_pmu_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
>>>        case SBI_EXT_PMU_COUNTER_FW_READ:
>>>                ret = kvm_riscv_vcpu_pmu_ctr_read(vcpu, cp->a0, retdata);
>>>                break;
>>> +     case SBI_EXT_PMU_SNAPSHOT_SET_SHMEM:
>>> +             ret = kvm_riscv_vcpu_pmu_setup_snapshot(vcpu, cp->a0, cp->a1, cp->a2, retdata);
>>> +             break;
>>>        default:
>>>                retdata->err_val = SBI_ERR_NOT_SUPPORTED;
>>>        }
>>> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
>>> index 8de5721e8019..1a22ce1ff8c8 100644
>>> --- a/drivers/perf/riscv_pmu_sbi.c
>>> +++ b/drivers/perf/riscv_pmu_sbi.c
>>> @@ -802,7 +802,7 @@ static noinline void pmu_sbi_start_ovf_ctrs_snapshot(struct cpu_hw_events *cpu_h
>>>        struct riscv_pmu_snapshot_data *sdata = cpu_hw_evt->snapshot_addr;
>>>
>>>        for_each_set_bit(idx, cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS) {
>>> -             if (ctr_ovf_mask & (1 << idx)) {
>>> +             if (ctr_ovf_mask & (BIT(idx))) {
>>>                        event = cpu_hw_evt->events[idx];
>>>                        hwc = &event->hw;
>>>                        max_period = riscv_pmu_ctr_get_width_mask(event);
>>> --
>>> 2.34.1
>>>
>>
>> Thanks,
>> drew
> 
> 
> 


