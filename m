Return-Path: <linux-kselftest+bounces-7615-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6511B8A0384
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 00:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8906D1C21034
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 22:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD2626289;
	Wed, 10 Apr 2024 22:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hd64sJll"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06C8101C5
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 22:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789077; cv=none; b=q42x9R1kcZrntyaiGFAnxjH7SQ8eVpzFl7oxg3mDs4fFgAVIsGerzsMXOBnBqqrRhXGurOvNCDOtMETOjUNSzmB3bt5VhDL3tvokG3Zz0zKhFCDpg7c8m1LdrFKM7imRb832CAKbA4ZHQpst8uq3f6c+e3mK8t1xkUmE1DwFUmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789077; c=relaxed/simple;
	bh=NE2ODEEBeddBEMTuJX4RMbV3G3lzLfDL7NqwBnDDouI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZNFnEoe4FHQMl2MzTiwiySpGSJP1RO280Jn5A+htsOGpy75h8I9Lq3rkOQJrHQywS9FwfdZkfOS5H+cAIWbWTikTPhGf8tOGG3cOGK8v+8nVepTAJWjVQn9s8X6ve1xgPUFLuYUyKf4Sw/X1RicJQStCP3ID7lTkwuXhTV6HWbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hd64sJll; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ecec796323so6791145b3a.3
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 15:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712789075; x=1713393875; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M2cgH2D45ho9cvREdXhs3e9eKM8qb8mttS4hZyQWXSk=;
        b=hd64sJllV+aS5YBdZ2f9J1dvSrXTumZO75Aw97JR2K3iarfA6rYXM45vQHE2iuV3hW
         BwRf46kWQ8mwHxsgUxfQBlLNf/P6+S1xA0ob1HnUxq8DPblHRGq8gQviLdgOii10FjdB
         N2cH6fQJruPDbm4MzAnUDJK+Qao5as3dphubpYQKTR/EnnmQohmt3LgAkmtvix7ntPA5
         kCmbMQvNSrSCg+IOiC6asqPCBAGifbJA0SwnIlXDmtm7eg6003IP2hLPrLr89e7oBvmG
         6rbHnwYydE9zS85BE85Du2Sh7xB91E70096M1AEtQLwXmC7ypxscxfgsBCjBR9fYjK3R
         yxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712789075; x=1713393875;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M2cgH2D45ho9cvREdXhs3e9eKM8qb8mttS4hZyQWXSk=;
        b=qUt18G45Z9GfDOIqDLKdTGpaXWFdUvHY2FFOz7oD501SICYVMMFT4XaZ/eaxtbzF57
         sPeqTe7rMnlh56Mlk0M6BRJaaStNW2AHkdD9NabeRzd2Eu9OIq+HFNS1l64tc9HObbC4
         dLAmhHH8fWFeZikNzqCXd/lJ3vi1CmYDAoJeviOaWm4/QLGv7jjrQWfkpuIFHY7RuS5M
         X8Kib/QzLrayGeoiReUFxBqbrNeeuXP5AUJFGpS02iVe1iEl7GM47x/10PG16BVXOu1f
         0+elRievMT4dN9sjMmG6y0U6+R4FqEkwL/E92IiWufMB4riwzYfM3JhPy3ul+FxzfJ6a
         nHGw==
X-Forwarded-Encrypted: i=1; AJvYcCVaxWTehMDKKQpHQYtIWxeiryRnyvsZtGkQstsJxWDCfNDc6oY+CDUhdYpHvP1td3q89MXKVzG7Grbop5B0V/sJp1Ton0SgNIjvnOSXcGd2
X-Gm-Message-State: AOJu0YwxfQRw8qlQDY2hqZt/pFxMZpXeNAUY8ADDoQZVHx8G25lEdDMd
	oGS/6CHW0EqvaBDSZZFG7IpD8zVS83Z8/u96pAUT1e3/Xa59pMi5+hXb1G8Id5I=
X-Google-Smtp-Source: AGHT+IFOs0DWU7qRtLwZS8q4mBlc3GS6E0uhBHn2npU45ykLOXlx7J+qnf3/xj3qEtURDx9Q7UvkAw==
X-Received: by 2002:a05:6a21:6d85:b0:1a7:c67:82ff with SMTP id wl5-20020a056a216d8500b001a70c6782ffmr4674154pzb.13.1712789074961;
        Wed, 10 Apr 2024 15:44:34 -0700 (PDT)
Received: from [172.16.0.69] (c-67-188-2-18.hsd1.ca.comcast.net. [67.188.2.18])
        by smtp.gmail.com with ESMTPSA id d15-20020a170903230f00b001d8be6d1ec4sm63707plh.39.2024.04.10.15.44.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 15:44:34 -0700 (PDT)
Message-ID: <7d02c86e-8c36-4e78-9fa8-5e30f3431eb3@rivosinc.com>
Date: Wed, 10 Apr 2024 15:44:32 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/15] RISC-V: KVM: No need to exit to the user space
 if perf event failed
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>,
 Atish Patra <atishp@atishpatra.org>
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
 <20240229010130.1380926-8-atishp@rivosinc.com>
 <20240302-1a3c0df25f2422e1e6abecf3@orel>
 <CAOnJCUJCQjBfLZFW-3iLUB6ygyRmz1Anu+fhfrT4Lpoj2iNB5Q@mail.gmail.com>
 <20240404-ea40bc0237635d671e64fef6@orel>
From: Atish Patra <atishp@rivosinc.com>
In-Reply-To: <20240404-ea40bc0237635d671e64fef6@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/4/24 05:16, Andrew Jones wrote:
> On Mon, Apr 01, 2024 at 03:37:01PM -0700, Atish Patra wrote:
>> On Sat, Mar 2, 2024 at 12:16 AM Andrew Jones <ajones@ventanamicro.com> wrote:
>>>
>>> On Wed, Feb 28, 2024 at 05:01:22PM -0800, Atish Patra wrote:
>>>> Currently, we return a linux error code if creating a perf event failed
>>>> in kvm. That shouldn't be necessary as guest can continue to operate
>>>> without perf profiling or profiling with firmware counters.
>>>>
>>>> Return appropriate SBI error code to indicate that PMU configuration
>>>> failed. An error message in kvm already describes the reason for failure.
>>>
>>> I don't know enough about the perf subsystem to know if there may be
>>> a concern that resources are temporarily unavailable. If so, then this
>>
>> Do you mean the hardware resources unavailable because the host is using it ?
> 
> Yes (I think). The issue I'm thinking of is if kvm_pmu_create_perf_event
> (perf_event_create_kernel_counter) returns something like EBUSY and then
> we translate that to SBI_ERR_NOT_SUPPORTED. I'm not sure guests would
> interpret not-supported as an error which means they can retry. Or if
> they retry and get something other than not-supported if they'd be
> confused.
> 

At least in Linux driver, treats -ENOTSUPP and it just fails. Other 
guest OS implementation may interpret it differently. But they should 
fail at that point as well. I don't see how can they interpret to be retry.

The perf user can retry again with assumption that may be enough 
counters are not available at this moment. But that's different from 
return a retry from driver code.

Even if we support a retry error code, when does the caller retry it ?
The driver doesn't know how long the user is going to run the perf 
command to keep the hardware resources occupied.

I feel the perf user is the best entity to know that and should retry if 
it knows the previous run is over which might have released the hardware 
resources.

> Thanks,
> drew
>    
> 
>>
>>> patch would make it possible for a guest to do the exact same thing,
>>> but sometimes succeed and sometimes get SBI_ERR_NOT_SUPPORTED.
>>> sbi_pmu_counter_config_matching doesn't currently have any error types
>>> specified that say "unsupported at the moment, maybe try again", which
>>> would be more appropriate in that case. I do see
>>> perf_event_create_kernel_counter() can return ENOMEM when memory isn't
>>> available, but if the kernel isn't able to allocate a small amount of
>>> memory, then we're in bigger trouble anyway, so the concern would be
>>> if there are perf resource pools which may temporarily be exhausted at
>>> the time the guest makes this request.
>>>
>>
>> For other cases, this patch ensures that guests continue to run without failure
>> which allows the user in the guest to try again if this fails due to a temporary
>> resource availability.
>>
>>> One comment below.
>>>
>>>>
>>>> Fixes: 0cb74b65d2e5 ("RISC-V: KVM: Implement perf support without sampling")
>>>> Reviewed-by: Anup Patel <anup@brainfault.org>
>>>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
>>>> ---
>>>>   arch/riscv/kvm/vcpu_pmu.c     | 14 +++++++++-----
>>>>   arch/riscv/kvm/vcpu_sbi_pmu.c |  6 +++---
>>>>   2 files changed, 12 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
>>>> index b1574c043f77..29bf4ca798cb 100644
>>>> --- a/arch/riscv/kvm/vcpu_pmu.c
>>>> +++ b/arch/riscv/kvm/vcpu_pmu.c
>>>> @@ -229,8 +229,9 @@ static int kvm_pmu_validate_counter_mask(struct kvm_pmu *kvpmu, unsigned long ct
>>>>        return 0;
>>>>   }
>>>>
>>>> -static int kvm_pmu_create_perf_event(struct kvm_pmc *pmc, struct perf_event_attr *attr,
>>>> -                                  unsigned long flags, unsigned long eidx, unsigned long evtdata)
>>>> +static long kvm_pmu_create_perf_event(struct kvm_pmc *pmc, struct perf_event_attr *attr,
>>>> +                                   unsigned long flags, unsigned long eidx,
>>>> +                                   unsigned long evtdata)
>>>>   {
>>>>        struct perf_event *event;
>>>>
>>>> @@ -454,7 +455,8 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_ba
>>>>                                     unsigned long eidx, u64 evtdata,
>>>>                                     struct kvm_vcpu_sbi_return *retdata)
>>>>   {
>>>> -     int ctr_idx, ret, sbiret = 0;
>>>> +     int ctr_idx, sbiret = 0;
>>>> +     long ret;
>>>>        bool is_fevent;
>>>>        unsigned long event_code;
>>>>        u32 etype = kvm_pmu_get_perf_event_type(eidx);
>>>> @@ -513,8 +515,10 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_ba
>>>>                        kvpmu->fw_event[event_code].started = true;
>>>>        } else {
>>>>                ret = kvm_pmu_create_perf_event(pmc, &attr, flags, eidx, evtdata);
>>>> -             if (ret)
>>>> -                     return ret;
>>>> +             if (ret) {
>>>> +                     sbiret = SBI_ERR_NOT_SUPPORTED;
>>>> +                     goto out;
>>>> +             }
>>>>        }
>>>>
>>>>        set_bit(ctr_idx, kvpmu->pmc_in_use);
>>>> diff --git a/arch/riscv/kvm/vcpu_sbi_pmu.c b/arch/riscv/kvm/vcpu_sbi_pmu.c
>>>> index 7eca72df2cbd..b70179e9e875 100644
>>>> --- a/arch/riscv/kvm/vcpu_sbi_pmu.c
>>>> +++ b/arch/riscv/kvm/vcpu_sbi_pmu.c
>>>> @@ -42,9 +42,9 @@ static int kvm_sbi_ext_pmu_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
>>>>   #endif
>>>>                /*
>>>>                 * This can fail if perf core framework fails to create an event.
>>>> -              * Forward the error to userspace because it's an error which
>>>> -              * happened within the host kernel. The other option would be
>>>> -              * to convert to an SBI error and forward to the guest.
>>>> +              * No need to forward the error to userspace and exit the guest
>>>
>>> Period after guest
>>>
>>>
>>>> +              * operation can continue without profiling. Forward the
>>>
>>> The operation
>>>
>>
>> Fixed the above two.
>>
>>
>>>> +              * appropriate SBI error to the guest.
>>>>                 */
>>>>                ret = kvm_riscv_vcpu_pmu_ctr_cfg_match(vcpu, cp->a0, cp->a1,
>>>>                                                       cp->a2, cp->a3, temp, retdata);
>>>> --
>>>> 2.34.1
>>>>
>>>
>>> Thanks,
>>> drew
>>
>>
>>
>> --
>> Regards,
>> Atish


