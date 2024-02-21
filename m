Return-Path: <linux-kselftest+bounces-5136-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F4285D2A1
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 09:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB7EEB2314B
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 08:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693FA374EC;
	Wed, 21 Feb 2024 08:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="IhYekNWW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8278F3C496
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 08:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708504649; cv=none; b=nR2b6g1i89L9tkdEcCzjnk0a+AkISeMgcVi/zf7Q4A/bGb3q5THDlSc7AufS3RIoRxYGaCGqroyoMmIYeG+BUCAvDqFS8bpB/XQr14LKIdIRg7cku47oSBIK91HcUEKu5gYASDQpgLXmCvtj0LJZ+tNHZQQ88ZJyiCxi10fsfSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708504649; c=relaxed/simple;
	bh=2XWyxN00EFfYTYtzTseDSDHHVqgSLhtubiTpTmEktVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f2gyUaPt0DLp5jgZL3rxXQkDbodoq5DqPTuNlB5nfh8MHOO/9JvaUiZsgUp30mf1ywBYaCmWvIpaRSdH6vpsG3u9hiQrUte0hgYYjfOhCXbsPyNpzNGIt/Nk4MRJOjXIIdOIBNWHJfEgv1M9tGvTvEcpCHO3R9A3sZwVmON5cew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=IhYekNWW; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5a00dfbeb3cso326930eaf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 00:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708504646; x=1709109446; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MMnw9vKJcK+lbDT8FYPd91pzbpe6XkA1QZvMTkaziM0=;
        b=IhYekNWWLlFY1nwsRiCbRrROIRgY82SY4aGPWb9nsTl2Bl18rAYnq1TG9U+XhQb+0z
         Msfad5EQ/8OQIvDl46Baj/77JNwVjQ/fYCNOztO8Hi3WhrCyLQj+gq26CwtjCNo2dGhG
         JBZv3LfgXtJD77+LUVjiCER8+/crRYSLVyaX7rSpopIynfF+1OIRV33Ef8FPIONQNqze
         wDEBuY9PQmvz+2tsiiDeSGidVQgAPy+UDTNRfQhcsfl3bRKHrh2AOuKs4WQt2h3PCQtQ
         1m2hxpNTt16a7oKnpNMXtyrMljmpTaKVQONp+28a4BzxE0QI2lhZVcLFC5RiyD+nVW+s
         lgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708504646; x=1709109446;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MMnw9vKJcK+lbDT8FYPd91pzbpe6XkA1QZvMTkaziM0=;
        b=rrreeSuZ+vzBkCUEBu2vxez/Y1lK4LuLC26jW0RKfm5GeLjiOApjiijY7NSBAzURud
         YtlgF+A9kF9dOUcim5JuojLo71nw9e+ozzuymoOu0z0C7wiCf0BNwD2TFsYWe12oTh9+
         ydmppyYMBCcBM3sVLQDCrQCtT/4QvX0OEGtqwgM5+8updGrx4PcdIerEkHJ1Y/EDQudu
         Z6H+dd7AVukJzfL59v1MzB5EoBripKRs6UO6WkmRf4jYYwa7oW4HWxIrYtmXpo3zVLvu
         jIyou/TmFeGNa2lK9IniUHwZJsmF/ImxdRXpEPi4hO+fT5+krXNV81c4RyOj10Mw3Wp/
         Dljw==
X-Forwarded-Encrypted: i=1; AJvYcCU/S92Dyahl4fQ0R8/6mLyVnNn1moVmznZ8c8wm92jMQc+U0jEfcXUlSKmppXB4JTapbf09VzbGl4JDN3jfm6zoyiZOYNXuiMe0C12NkkpT
X-Gm-Message-State: AOJu0YzfB+EbQPhUJucxUYG0ChvFyzs3dGtZF4OFVIvUR9HviZAeOQWE
	3O/3tzojDVOeLmTGYMmVs0nFzORME4ApEj4v7VJaRaY2+yYO5RoTT0vq0C9IZ2w=
X-Google-Smtp-Source: AGHT+IGwSgsjE3CPVeonNtgWRogjIsKu+qKysC/zJGjHtavZzYR//zpXfv8521DVEpjsYdm9vUOFzw==
X-Received: by 2002:a05:6871:1cc:b0:21a:43e6:9479 with SMTP id q12-20020a05687101cc00b0021a43e69479mr19017547oad.25.1708504646344;
        Wed, 21 Feb 2024 00:37:26 -0800 (PST)
Received: from [172.16.0.18] (c-67-188-2-18.hsd1.ca.comcast.net. [67.188.2.18])
        by smtp.gmail.com with ESMTPSA id h6-20020a63c006000000b0059b2316be86sm8040427pgg.46.2024.02.21.00.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 00:37:25 -0800 (PST)
Message-ID: <2c96c61a-2685-4cee-9cef-963ed833bf92@rivosinc.com>
Date: Wed, 21 Feb 2024 00:37:21 -0800
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
To: Haibo Xu <xiaobo55x@gmail.com>, Atish Patra <atishp@atishpatra.org>
Cc: Haibo Xu <haibo1.xu@intel.com>, ajones@ventanamicro.com,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 James Morse <james.morse@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 Anup Patel <anup@brainfault.org>, Guo Ren <guoren@kernel.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
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
From: Atish Patra <atishp@rivosinc.com>
In-Reply-To: <CAJve8om2oOLg5-wKX7m7cBTgzwqiMcb35x=nDi1edY8evXjyMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/20/24 18:13, Haibo Xu wrote:
> On Wed, Feb 21, 2024 at 7:03 AM Atish Patra <atishp@atishpatra.org> wrote:
>>
>> On Mon, Jan 22, 2024 at 1:48 AM Haibo Xu <haibo1.xu@intel.com> wrote:
>>>
>>> Move vcpu_has_ext to the processor.c and rename it to __vcpu_has_ext
>>> so that other test cases can use it for vCPU extension check.
>>>
>>> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
>>> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>>> ---
>>>   tools/testing/selftests/kvm/include/riscv/processor.h |  2 ++
>>>   tools/testing/selftests/kvm/lib/riscv/processor.c     | 10 ++++++++++
>>>   tools/testing/selftests/kvm/riscv/get-reg-list.c      | 11 +----------
>>>   3 files changed, 13 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
>>> index b68b1b731a34..bd27e1c67579 100644
>>> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
>>> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
>>> @@ -42,6 +42,8 @@ static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t idx,
>>>   #define RISCV_ISA_EXT_REG(idx) __kvm_reg_id(KVM_REG_RISCV_ISA_EXT, \
>>>                                               idx, KVM_REG_SIZE_ULONG)
>>>
>>> +bool __vcpu_has_ext(struct kvm_vcpu *vcpu, int ext);
>>> +
>>>   struct ex_regs {
>>>          unsigned long ra;
>>>          unsigned long sp;
>>> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
>>> index 39a1e9902dec..dad73ce18164 100644
>>> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
>>> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
>>> @@ -15,6 +15,16 @@
>>>
>>>   static vm_vaddr_t exception_handlers;
>>>
>>> +bool __vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
>>> +{
>>> +       unsigned long value = 0;
>>> +       int ret;
>>> +
>>> +       ret = __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);
>>> +
>>> +       return !ret && !!value;
>>> +}
>>> +
>>
>> Not sure what was the base patch on which this was rebased. The actual
>> commit in the queue branch looks different.
>>
> 
> This patch set was based on 6.7-rc8.
> 
>> https://github.com/kvm-riscv/linux/commit/5563517cc2012e3326411b360c9924d3f2706c8d
>>
>> Both seem to have the same bug though the tests fail now and require
>> the following fix.
>> The ext id should be uint64_t and we need to pass ext directly so that
>> SBI extension tests can also pass.
>>
> 
> It's weird that 6.7-rc8 has already included Andrew's change on the ISA ext reg,
> but this patch was not generated against his change.
> 
> commit bdf6aa328f137e184b0fce607fd585354c3742f1
> Author: Andrew Jones <ajones@ventanamicro.com>
> Date:   Wed Dec 13 18:09:58 2023 +0100
> 
>      RISC-V: KVM: selftests: Treat SBI ext regs like ISA ext regs
> 
> Anyway, your changes were right. Please go ahead to include them when merging.
> 

I am not sure what happened. Probably, a merge conflict issue.

I just realized I forgot to copy paste another fix in arch timer

+++ b/tools/testing/selftests/kvm/riscv/arch_timer.c
@@ -85,7 +85,7 @@ struct kvm_vm *test_vm_create(void)
         int nr_vcpus = test_args.nr_vcpus;

         vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
-       __TEST_REQUIRE(__vcpu_has_ext(vcpus[0], KVM_RISCV_ISA_EXT_SSTC),
+       __TEST_REQUIRE(__vcpu_has_ext(vcpus[0], 
RISCV_ISA_EXT_REG(KVM_RISCV_ISA_EXT_SSTC)),


> Thanks,
> Haibo
> 
>>
>> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
>> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
>> @@ -48,7 +48,7 @@ static inline uint64_t __kvm_reg_id(uint64_t type,
>> uint64_t subtype,
>> KVM_REG_RISCV_SBI_SINGLE, \
>> idx, KVM_REG_SIZE_ULONG)
>>
>> -bool __vcpu_has_ext(struct kvm_vcpu *vcpu, int ext);
>> +bool __vcpu_has_ext(struct kvm_vcpu *vcpu, uint64_t ext);
>>
>> struct ex_regs {
>> unsigned long ra;
>> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c
>> b/tools/testing/selftests/kvm/lib/riscv/processor.c
>> index 282587cd4bbc..ec66d331a127 100644
>> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
>> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
>> @@ -15,12 +15,12 @@
>>
>> static vm_vaddr_t exception_handlers;
>>
>> -bool __vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
>> +bool __vcpu_has_ext(struct kvm_vcpu *vcpu, uint64_t ext)
>> {
>> unsigned long value = 0;
>> int ret;
>>
>> - ret = __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);
>> + ret = __vcpu_get_reg(vcpu, ext, &value);
>>
>> return !ret && !!value;
>> }
>>
>> With the above the fix, Both SBI/ISA extension tests pass.
>> # ./get-reg-list
>> sbi-base: PASS
>> sbi-sta: PASS
>> sbi-pmu: PASS
>> sbi-dbcn: PASS
>> aia: PASS
>> fp_f: PASS
>> fp_d: PASS
>> 1..0 # SKIP - h not available, skipping tests
>> smstateen: PASS
>> sscofpmf: PASS
>> sstc: PASS
>> 1..0 # SKIP - svinval not available, skipping tests
>> 1..0 # SKIP - svnapot not available, skipping tests
>> 1..0 # SKIP - svpbmt not available, skipping tests
>> zba: PASS
>> zbb: PASS
>> zbc: PASS
>> 1..0 # SKIP - zbkb not available, skipping tests
>> 1..0 # SKIP - zbkc not available, skipping tests
>> 1..0 # SKIP - zbkx not available, skipping tests
>> zbs: PASS
>> zfa: PASS
>> 1..0 # SKIP - zfh not available, skipping tests
>> 1..0 # SKIP - zfhmin not available, skipping tests
>> zicbom: PASS
>> zicboz: PASS
>> zicntr: PASS
>> 1..0 # SKIP - zicond not available, skipping tests
>> zicsr: PASS
>> zifencei: PASS
>> zihintntl: PASS
>> zihintpause: PASS
>> zihpm: PASS
>>
>>
>>>   static uint64_t page_align(struct kvm_vm *vm, uint64_t v)
>>>   {
>>>          return (v + vm->page_size) & ~(vm->page_size - 1);
>>> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
>>> index 25de4b8bc347..ed29ba45588c 100644
>>> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
>>> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
>>> @@ -75,15 +75,6 @@ bool check_reject_set(int err)
>>>          return err == EINVAL;
>>>   }
>>>
>>> -static inline bool vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
>>> -{
>>> -       int ret;
>>> -       unsigned long value;
>>> -
>>> -       ret = __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);
>>> -       return (ret) ? false : !!value;
>>> -}
>>> -
>>>   void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
>>>   {
>>>          unsigned long isa_ext_state[KVM_RISCV_ISA_EXT_MAX] = { 0 };
>>> @@ -111,7 +102,7 @@ void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
>>>                  __vcpu_set_reg(vcpu, RISCV_ISA_EXT_REG(s->feature), 1);
>>>
>>>                  /* Double check whether the desired extension was enabled */
>>> -               __TEST_REQUIRE(vcpu_has_ext(vcpu, s->feature),
>>> +               __TEST_REQUIRE(__vcpu_has_ext(vcpu, s->feature),
>>>                                 "%s not available, skipping tests\n", s->name);
>>>          }
>>>   }
>>> --
>>> 2.34.1
>>>
>>
>>
>> --
>> Regards,
>> Atish


