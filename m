Return-Path: <linux-kselftest+bounces-5233-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C4E85E90A
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 21:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74A661C22C0F
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 20:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFA786AE2;
	Wed, 21 Feb 2024 20:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="O67kK4WF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D6883CDF
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 20:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708547360; cv=none; b=bY55FJztnQIeFee+PIeNwkgf/FH+ecxl3Zs79V2bJ+nrvu2Z3rn4/iI4h3mmIPOGcMch5+GgMR2yhSZKBmHusStHspiRADBw4sofALfD5NNZ1d14igVDq0Y/HXow3zfBCAwwFBE3LUIWjyDsZa61HeAxOci2qZuwmtu+/UK0XkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708547360; c=relaxed/simple;
	bh=KgITQNa+cv8Wh8c0n2C2fUy/aaeCcLti0CzXRzvryps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qjdq7rYdBLVzGAkc3mqUsy3LkWJIY8Hp4K54n9xJv64KiLVS2CPAiXcGvZdySzbm8EiFY94IjydSlcOz9Pd+F+LEjxebkSHvi9DAVgKYrPxnECUHTnbUQtwuxyZ96L443mys5Jfbr7Ts6rVAHDnm6MyPtRIn0iekoJBqN0FkHSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=O67kK4WF; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-299372abcfeso136166a91.1
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 12:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708547357; x=1709152157; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sTCGMEew0Fipe902SlrRK/D4WW/nSfSfZfwf/W230pM=;
        b=O67kK4WFweUsPmYxrCTIK1TmK4E4xT4/zZZVo7Qb3ZTUjOucEE9Wxp+Y9+VgqVZTNd
         Dz74+3IctO6TEKAhsxP+oVEoKQwNL1cFbrf77m6WjN+U3EpWBuBFe2J6yHcLuJhhWIiB
         gVJeB/x1xY8I0tm8zFNIYVtpOH179Cki3k7ZYJELLL2Nvu4pOv0D3p6SX4rII0x3bxho
         Fz+kFkmQmILbv5WOBZOBtX3F1JHm4+zOohvZcZgPs3OMXEoHg9beEMn+5+holdLhaC8t
         wgrz3hAwbJ93WIPgbersrhJj1FQm72AEgTO/89Qdc8A/t5bNF+NrqXJtAWW+/9PVfZCo
         ytAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708547357; x=1709152157;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sTCGMEew0Fipe902SlrRK/D4WW/nSfSfZfwf/W230pM=;
        b=XTzFIUIprzX73aSLUwXjcY1QCfNgVmYqS8giEL5RBgcT0/CM8LT5p3REkkAI0Z691A
         c9kLSYzfG2A4zDVLc7FPtIAuTcawFfHoA5G/Q3OIz7ewEYeTbU5uQjnkaEQVS6QYAieP
         9M+pqUB8WXvPUfeR8R6FaGmr1Zaw1e2WQoERjyMeDXvouy3gX6WoJu2zqIcoHiPKhWfp
         No50adNUkIhMHFv0tPfMf6fxlmNoPLCU23TZq/Qqg7SHONssfEgfnRdOuSgUIOMG/XMU
         gCmyG3f+DSKZdkCBzgi4U50kjkxV9Aucd8MxM2XUrHc4TNTovMgJRpjI0vCcUfgCN1Tb
         WM0g==
X-Forwarded-Encrypted: i=1; AJvYcCXJUrd9zTGYKoooKSln9W7xpQ+WyWOb4XzGRz+fJxv67picFGttgl+OcV8omm3I5onUN+gnd+fAuO0TPcueWKeFQxJ68FVcCqx2G76ZYxQy
X-Gm-Message-State: AOJu0Yx9MJQ3wjlcqi3Gjg46/NKzXqRyzSlFLFLt8AJOxG09d42UxV+F
	0bVnTJu/5iBAqqv50UEGzMACxQz4XJbwsYDjyyH5BNl64WWsWeLmrzzhhTt3N9A=
X-Google-Smtp-Source: AGHT+IEv0rIXEEFymfbI7hv6WvIwIaG4wxAzbyU2mSU6ZNYe3WU2p1qg0ejBWvWUS0oTykMJfq8rng==
X-Received: by 2002:a17:90b:3007:b0:299:8e05:4d7b with SMTP id hg7-20020a17090b300700b002998e054d7bmr783238pjb.4.1708547357279;
        Wed, 21 Feb 2024 12:29:17 -0800 (PST)
Received: from [172.16.0.69] (c-67-188-2-18.hsd1.ca.comcast.net. [67.188.2.18])
        by smtp.gmail.com with ESMTPSA id pd18-20020a17090b1dd200b0029696f7f443sm2303021pjb.50.2024.02.21.12.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 12:29:16 -0800 (PST)
Message-ID: <b5673bce-09e7-4531-a074-e252aa9e38e8@rivosinc.com>
Date: Wed, 21 Feb 2024 12:29:13 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/12] KVM: riscv: selftests: Change vcpu_has_ext to a
 common function
Content-Language: en-US
To: Haibo Xu <xiaobo55x@gmail.com>, Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atishp@atishpatra.org>, Haibo Xu <haibo1.xu@intel.com>,
 ajones@ventanamicro.com, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 James Morse <james.morse@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 Guo Ren <guoren@kernel.org>, Mayuresh Chitale <mchitale@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Samuel Holland <samuel@sholland.org>,
 Minda Chen <minda.chen@starfivetech.com>, Jisheng Zhang
 <jszhang@kernel.org>, Sean Christopherson <seanjc@google.com>,
 Peter Xu <peterx@redhat.com>, Like Xu <likexu@tencent.com>,
 Vipin Sharma <vipinsh@google.com>, Thomas Huth <thuth@redhat.com>,
 Aaron Lewis <aaronlewis@google.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 kvm-riscv@lists.infradead.org
References: <cover.1705916069.git.haibo1.xu@intel.com>
 <68856b86a93a4188558e5d0ebac0dd6aac8e404c.1705916069.git.haibo1.xu@intel.com>
 <CAOnJCULwRTSnrQkR2o1P53R=tJ3TAxX+y+XRBesW6OFEzgFv2g@mail.gmail.com>
 <CAJve8om2oOLg5-wKX7m7cBTgzwqiMcb35x=nDi1edY8evXjyMw@mail.gmail.com>
 <2c96c61a-2685-4cee-9cef-963ed833bf92@rivosinc.com>
 <CAJve8omCZxsiP1jF0n5SBh0_U6q7Exj5A1ACFahWpdBoxohaMA@mail.gmail.com>
From: Atish Patra <atishp@rivosinc.com>
In-Reply-To: <CAJve8omCZxsiP1jF0n5SBh0_U6q7Exj5A1ACFahWpdBoxohaMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/21/24 05:08, Haibo Xu wrote:
> On Wed, Feb 21, 2024 at 4:37 PM Atish Patra <atishp@rivosinc.com> wrote:
>>
>> On 2/20/24 18:13, Haibo Xu wrote:
>>> On Wed, Feb 21, 2024 at 7:03 AM Atish Patra <atishp@atishpatra.org> wrote:
>>>>
>>>> On Mon, Jan 22, 2024 at 1:48 AM Haibo Xu <haibo1.xu@intel.com> wrote:
>>>>>
>>>>> Move vcpu_has_ext to the processor.c and rename it to __vcpu_has_ext
>>>>> so that other test cases can use it for vCPU extension check.
>>>>>
>>>>> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
>>>>> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>>>>> ---
>>>>>    tools/testing/selftests/kvm/include/riscv/processor.h |  2 ++
>>>>>    tools/testing/selftests/kvm/lib/riscv/processor.c     | 10 ++++++++++
>>>>>    tools/testing/selftests/kvm/riscv/get-reg-list.c      | 11 +----------
>>>>>    3 files changed, 13 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
>>>>> index b68b1b731a34..bd27e1c67579 100644
>>>>> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
>>>>> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
>>>>> @@ -42,6 +42,8 @@ static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t idx,
>>>>>    #define RISCV_ISA_EXT_REG(idx) __kvm_reg_id(KVM_REG_RISCV_ISA_EXT, \
>>>>>                                                idx, KVM_REG_SIZE_ULONG)
>>>>>
>>>>> +bool __vcpu_has_ext(struct kvm_vcpu *vcpu, int ext);
>>>>> +
>>>>>    struct ex_regs {
>>>>>           unsigned long ra;
>>>>>           unsigned long sp;
>>>>> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
>>>>> index 39a1e9902dec..dad73ce18164 100644
>>>>> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
>>>>> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
>>>>> @@ -15,6 +15,16 @@
>>>>>
>>>>>    static vm_vaddr_t exception_handlers;
>>>>>
>>>>> +bool __vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
>>>>> +{
>>>>> +       unsigned long value = 0;
>>>>> +       int ret;
>>>>> +
>>>>> +       ret = __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);
>>>>> +
>>>>> +       return !ret && !!value;
>>>>> +}
>>>>> +
>>>>
>>>> Not sure what was the base patch on which this was rebased. The actual
>>>> commit in the queue branch looks different.
>>>>
>>>
>>> This patch set was based on 6.7-rc8.
>>>
>>>> https://github.com/kvm-riscv/linux/commit/5563517cc2012e3326411b360c9924d3f2706c8d
>>>>
>>>> Both seem to have the same bug though the tests fail now and require
>>>> the following fix.
>>>> The ext id should be uint64_t and we need to pass ext directly so that
>>>> SBI extension tests can also pass.
>>>>
>>>
>>> It's weird that 6.7-rc8 has already included Andrew's change on the ISA ext reg,
>>> but this patch was not generated against his change.
>>>
>>> commit bdf6aa328f137e184b0fce607fd585354c3742f1
>>> Author: Andrew Jones <ajones@ventanamicro.com>
>>> Date:   Wed Dec 13 18:09:58 2023 +0100
>>>
>>>       RISC-V: KVM: selftests: Treat SBI ext regs like ISA ext regs
>>>
>>> Anyway, your changes were right. Please go ahead to include them when merging.
>>>
>>
>> I am not sure what happened. Probably, a merge conflict issue.
>>
>> I just realized I forgot to copy paste another fix in arch timer
>>
>> +++ b/tools/testing/selftests/kvm/riscv/arch_timer.c
>> @@ -85,7 +85,7 @@ struct kvm_vm *test_vm_create(void)
>>           int nr_vcpus = test_args.nr_vcpus;
>>
>>           vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
>> -       __TEST_REQUIRE(__vcpu_has_ext(vcpus[0], KVM_RISCV_ISA_EXT_SSTC),
>> +       __TEST_REQUIRE(__vcpu_has_ext(vcpus[0],
>> RISCV_ISA_EXT_REG(KVM_RISCV_ISA_EXT_SSTC)),
>>
> 
> Right Fix!
> Please let me know if I need to rebase this patch series on your tree
> and resent it.
> 

That's Anup's call.

> Thanks,
> Haibo
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


