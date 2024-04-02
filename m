Return-Path: <linux-kselftest+bounces-6976-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA75894DC2
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 10:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FE071C21147
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 08:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600034501B;
	Tue,  2 Apr 2024 08:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="rQgrG+WW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8049340C15
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Apr 2024 08:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712047351; cv=none; b=kZyALgpM3t+JFTdf33svcXhAdFjYOvczwFjMOgeaH4/M6mMNP1WmO37cN+M1JPIpXruzlL61rOG1rgbF6+YTu/3IDzZoXCXwJwlZGKm9HvyEDcrChxVsrtQZt0I/ZiEcSlAwlkarlo1+S5fD0eJUxrejwhAOP4No+2ROaQs01KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712047351; c=relaxed/simple;
	bh=3Mm76az14X2MK6os+t9jWefEwvvKy1DLHkw+HmPAxHE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZJRQ9CDYCzKztPs3Md2P/OVRW5o/nEwzUVhc8fYeaIOdcc099jF6yg4gKM7A8UbThuWLhVuN220JFSl7U9yRcNmgrgM3O+jfIzIcCOteE+n11UQhCJjI7NovmsecYJ0MrtP424orjUqpUH6OGZn+bVnXDRFBtEV3ZAPK0e8GMkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=rQgrG+WW; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso2507295a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Apr 2024 01:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712047349; x=1712652149; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=afh5OaKuMfMLyjYIAfIBdXfS0bylET/+oqOyOLeuEas=;
        b=rQgrG+WW/ANrBzuPKwCbsjmh5XrUypT4ia7fi2JtcVTOHhIx6ue+bvpo8DiceIAtFq
         dc6XHOQ5m6XvgoOvsJeBxrhltR2mc+2EYRlxuycBv6yos5aHFlOq97rGOABJ9xS+LzAj
         /mCNXsm3+jSjugbV9LuQIFjPkqJozNwyDYkmKqDJVi6oeBO7vTTiVHfYd6sUtgBWkYEU
         PqrrkAiuDaLPkcvmjHG7mLvfUIss6ChU4i43MOl6qOGweaHzQ5Slaxa6xS/eGDzweXLd
         YEJGET3J8V8xV9TeN3Ewwmzfk57iSulvhICKIKlF8zpDkT3NlHd3z8px5W1AZRTTtf7Z
         lekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712047349; x=1712652149;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=afh5OaKuMfMLyjYIAfIBdXfS0bylET/+oqOyOLeuEas=;
        b=Kec7Lnh/gtljy7z4dstu4zmwg8fuNGeU+ULlqzaiHHyFDXFuqAF3PZl56Um9rS/Y83
         nPnkA69SqwpmHml+Ae2QdEBSIbhFXCqKN9z7usOgeWSXMuxBlN5ynP67ne8QmcVZR8TD
         ALFWEEh4piFVWDSQDI+hHO6RwJDnVwgcdsZA1U4oUFiBDjNaRT1sqP6dY4CE4m0okzJc
         BcWWF0pkuxpQ1BZTQBiDChqVQcro65jjtRPvfLrY/TG4v9+SuRP0p7F/dZIjE/EIk297
         qLdhVmR2XyyidEF/GNLd8IOih9+2HKEr1GUJyJmGy975tL8uX+pB6ybcm++0jiyfA8Oe
         IqUA==
X-Forwarded-Encrypted: i=1; AJvYcCXJD6CeaEKmQDEe2bWPWHekRd/N0i/aCQ6DmhBgGceYWN2IdgXw4tB8od5C2yk9FfV4ONizK0X8FOH1ViNP+TxfW2z8EhDIbTGEFF/4Lh0s
X-Gm-Message-State: AOJu0YwrxVCZwnLfFdCaeLTer6GA8i+jMDsWnkdi7y6hx3N1HoGkfhsu
	Vp/SMiJSA+BFXFUTnnyl+wR1weMb4WKqxL2DIEZY4xZKq9Mpk/cqQKRwktKD7t8=
X-Google-Smtp-Source: AGHT+IGIBpAHqLeUqYqY/I5AiG/85DRZ33edmSV9gedKZK5X9bTJZYi476/i9hbZ6V4Mt7L5BhnDsw==
X-Received: by 2002:a05:6a20:3241:b0:1a3:df1d:deba with SMTP id hm1-20020a056a20324100b001a3df1ddebamr8729596pzc.31.1712047348688;
        Tue, 02 Apr 2024 01:42:28 -0700 (PDT)
Received: from [172.16.0.34] (c-67-188-2-18.hsd1.ca.comcast.net. [67.188.2.18])
        by smtp.gmail.com with ESMTPSA id e19-20020a63f553000000b005e485fbd455sm9184675pgk.45.2024.04.02.01.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 01:42:28 -0700 (PDT)
Message-ID: <f9bac0a6-5fbe-4928-b6c4-94f70c726cbe@rivosinc.com>
Date: Tue, 2 Apr 2024 01:42:26 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v4 15/15] KVM: riscv: selftests: Add a test for counter
 overflow
To: Andrew Jones <ajones@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>,
 Conor Dooley <conor.dooley@microchip.com>, Guo Ren <guoren@kernel.org>,
 Icenowy Zheng <uwu@icenowy.me>, kvm-riscv@lists.infradead.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-riscv@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>,
 Will Deacon <will@kernel.org>
References: <20240229010130.1380926-1-atishp@rivosinc.com>
 <20240229010130.1380926-16-atishp@rivosinc.com>
 <20240302-fb3a4d2c7918a24d10ee4a63@orel>
X-Mozilla-News-Host: news://nntp.lore.kernel.org
Content-Language: en-US
In-Reply-To: <20240302-fb3a4d2c7918a24d10ee4a63@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/2/24 04:35, Andrew Jones wrote:
> On Wed, Feb 28, 2024 at 05:01:30PM -0800, Atish Patra wrote:
>> Add a test for verifying overflow interrupt. Currently, it relies on
>> overflow support on cycle/instret events. This test works for cycle/
>> instret events which support sampling via hpmcounters on the platform.
>> There are no ISA extensions to detect if a platform supports that. Thus,
> 
> Ouch. Are there discussions/proposals as to how we can do better with
> discoverability here? This type of thing sounds like the types of things
> that get new extension names defined for them as part of the profile spec
> work.
> 

There is a Perf events TG started (last month) which will work on 
standardzing perf events for RISC-V.

Perf tool can also rely on the json file to figure out if sampling 
support or not. But for kselftests we don't have any of these 
infrastructure.

>> this test will fail on platform with virtualization but doesn't
>> support overflow on these two events.
>>
>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
>> ---
>>   tools/testing/selftests/kvm/riscv/sbi_pmu.c | 126 +++++++++++++++++++-
>>   1 file changed, 125 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu.c b/tools/testing/selftests/kvm/riscv/sbi_pmu.c
>> index 8ea2a6db6610..c0264c636054 100644
>> --- a/tools/testing/selftests/kvm/riscv/sbi_pmu.c
>> +++ b/tools/testing/selftests/kvm/riscv/sbi_pmu.c
>> @@ -8,6 +8,7 @@
>>    * Copyright (c) 2024, Rivos Inc.
>>    */
>>   
>> +#include "asm/csr.h"
>>   #include <stdio.h>
>>   #include <stdlib.h>
>>   #include <string.h>
>> @@ -16,6 +17,7 @@
>>   #include "kvm_util.h"
>>   #include "test_util.h"
>>   #include "processor.h"
>> +#include "arch_timer.h"
>>   
>>   /* Maximum counters (firmware + hardware)*/
>>   #define RISCV_MAX_PMU_COUNTERS 64
>> @@ -26,6 +28,11 @@ union sbi_pmu_ctr_info ctrinfo_arr[RISCV_MAX_PMU_COUNTERS];
>>   static void *snapshot_gva;
>>   static vm_paddr_t snapshot_gpa;
>>   
>> +static int pmu_irq = IRQ_PMU_OVF;
>> +
>> +static int vcpu_shared_irq_count;
>> +static int counter_in_use;
>> +
>>   /* Cache the available counters in a bitmask */
>>   static unsigned long counter_mask_available;
>>   
>> @@ -69,7 +76,9 @@ unsigned long pmu_csr_read_num(int csr_num)
>>   #undef switchcase_csr_read
>>   }
>>   
>> -static inline void dummy_func_loop(int iter)
>> +static void stop_counter(unsigned long counter, unsigned long stop_flags);
>> +
>> +static inline void dummy_func_loop(uint64_t iter)
>>   {
>>   	int i = 0;
>>   
>> @@ -88,6 +97,26 @@ static void guest_illegal_exception_handler(struct ex_regs *regs)
>>   	regs->epc += 4;
>>   }
>>   
>> +static void guest_irq_handler(struct ex_regs *regs)
>> +{
>> +	unsigned int irq_num = regs->cause & ~CAUSE_IRQ_FLAG;
>> +	struct riscv_pmu_snapshot_data *snapshot_data = snapshot_gva;
>> +	unsigned long overflown_mask;
>> +
>> +	/* Stop all counters first to avoid further interrupts */
>> +	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, 0, 1UL << counter_in_use,
>> +		  SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT, 0, 0, 0);
>> +
>> +	csr_clear(CSR_SIP, BIT(pmu_irq));
>> +
>> +	overflown_mask = READ_ONCE(snapshot_data->ctr_overflow_mask);
>> +	GUEST_ASSERT(overflown_mask & (1UL << counter_in_use));
>> +
>> +	/* Validate that we are in the correct irq handler */
>> +	GUEST_ASSERT_EQ(irq_num, pmu_irq);
> 
> Should probably do this irq handler assert first.
> 

Done.

>> +	WRITE_ONCE(vcpu_shared_irq_count, vcpu_shared_irq_count+1);
>> +}
>> +
>>   static unsigned long get_counter_index(unsigned long cbase, unsigned long cmask,
>>   				       unsigned long cflags,
>>   				       unsigned long event)
>> @@ -263,6 +292,32 @@ static void test_pmu_event_snapshot(unsigned long event)
>>   	stop_counter(counter, SBI_PMU_STOP_FLAG_RESET);
>>   }
>>   
>> +static void test_pmu_event_overflow(unsigned long event)
>> +{
>> +	unsigned long counter;
>> +	unsigned long counter_value_post;
>> +	unsigned long counter_init_value = ULONG_MAX - 10000;
>> +	struct riscv_pmu_snapshot_data *snapshot_data = snapshot_gva;
>> +
>> +	counter = get_counter_index(0, counter_mask_available, 0, event);
>> +	counter_in_use = counter;
>> +
>> +	/* The counter value is updated w.r.t relative index of cbase passed to start/stop */
>> +	WRITE_ONCE(snapshot_data->ctr_values[0], counter_init_value);
>> +	start_counter(counter, SBI_PMU_START_FLAG_INIT_FROM_SNAPSHOT, 0);
>> +	dummy_func_loop(10000);
>> +	udelay(msecs_to_usecs(2000));
>> +	/* irq handler should have stopped the counter */
>> +
>> +	counter_value_post = READ_ONCE(snapshot_data->ctr_values[counter_in_use]);
>> +	/* The counter value after stopping should be less the init value due to overflow */
>> +	__GUEST_ASSERT(counter_value_post < counter_init_value,
>> +		       "counter_value_post %lx counter_init_value %lx for counter\n",
>> +		       counter_value_post, counter_init_value);
>> +
>> +	stop_counter(counter, SBI_PMU_STOP_FLAG_RESET);
>> +}
>> +
>>   static void test_invalid_event(void)
>>   {
>>   	struct sbiret ret;
>> @@ -361,6 +416,43 @@ static void test_pmu_events_snaphost(int cpu)
>>   	GUEST_DONE();
>>   }
>>   
>> +static void test_pmu_events_overflow(int cpu)
> 
> no need for cpu
> 

Fixed.

>> +{
>> +	long out_val = 0;
>> +	bool probe;
>> +	int num_counters = 0;
>> +	unsigned long sbi_impl_version;
>> +
>> +	probe = guest_sbi_probe_extension(SBI_EXT_PMU, &out_val);
>> +	GUEST_ASSERT(probe && out_val == 1);
>> +
>> +	sbi_impl_version = get_host_sbi_impl_version();
>> +	if (sbi_impl_version >= sbi_mk_version(2, 0))
>> +		__GUEST_ASSERT(0, "SBI implementation version doesn't support PMU Snapshot");
> 
> Identical probe and version check as test_pmu_events_snaphost(). Can
> factor out.
> 

Done.

>> +
>> +	snapshot_set_shmem(snapshot_gpa, 0);
>> +	csr_set(CSR_IE, BIT(pmu_irq));
>> +	local_irq_enable();
>> +
>> +	/* Get the counter details */
>> +	num_counters = get_num_counters();
>> +	update_counter_info(num_counters);
>> +
>> +	/*
>> +	 * Qemu supports overflow for cycle/instruction.
>> +	 * This test may fail on any platform that do not support overflow for these two events.
>> +	 */
>> +	test_pmu_event_overflow(SBI_PMU_HW_CPU_CYCLES);
>> +	GUEST_ASSERT_EQ(vcpu_shared_irq_count, 1);
>> +
>> +	/* Renable the interrupt again for another event */
>> +	csr_set(CSR_IE, BIT(pmu_irq));
>> +	test_pmu_event_overflow(SBI_PMU_HW_INSTRUCTIONS);
>> +	GUEST_ASSERT_EQ(vcpu_shared_irq_count, 2);
>> +
>> +	GUEST_DONE();
>> +}
>> +
>>   static void run_vcpu(struct kvm_vcpu *vcpu)
>>   {
>>   	struct ucall uc;
>> @@ -449,6 +541,35 @@ static void test_vm_events_snapshot_test(void *guest_code)
>>   	test_vm_destroy(vm);
>>   }
>>   
>> +static void test_vm_events_overflow(void *guest_code)
>> +{
>> +	struct kvm_vm *vm = NULL;
>> +	struct kvm_vcpu *vcpu = NULL;
> 
> nit: no need for NULL
> 
>> +
>> +	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
>> +	__TEST_REQUIRE(__vcpu_has_ext(vcpu, RISCV_SBI_EXT_REG(KVM_RISCV_SBI_EXT_PMU)),
>> +				   "SBI PMU not available, skipping test");
>> +
>> +	__TEST_REQUIRE(__vcpu_has_ext(vcpu, RISCV_ISA_EXT_REG(KVM_RISCV_ISA_EXT_SSCOFPMF)),
>> +				   "Sscofpmf is not available, skipping overflow test");
>> +
>> +
>> +	test_vm_setup_snapshot_mem(vm, vcpu);
>> +	vm_init_vector_tables(vm);
>> +	vm_install_interrupt_handler(vm, guest_irq_handler);
>> +
>> +	vcpu_init_vector_tables(vcpu);
>> +	/* Initialize guest timer frequency. */
>> +	vcpu_get_reg(vcpu, RISCV_TIMER_REG(frequency), &timer_freq);
>> +	sync_global_to_guest(vm, timer_freq);
> 
> I just noticed that timer_freq is in arch_timer.h and isn't an extern...
> Fixing that is out of scope for this series though.
> 

Yeah. I can add a patch for that.
But declaring it as an extern requires the definitions to be in either 
common source file (i.e processor.c) or define it in each tests using 
timer_freq.

The first approach is bit odd with header file and definition residing 
two different source/header file.

Any preference ?

>> +
>> +	vcpu_args_set(vcpu, 1, 0);
> 
> no need for args
> 

Fixed.

>> +
>> +	run_vcpu(vcpu);
>> +
>> +	test_vm_destroy(vm);
>> +}
>> +
>>   int main(void)
>>   {
>>   	test_vm_basic_test(test_pmu_basic_sanity);
>> @@ -460,5 +581,8 @@ int main(void)
>>   	test_vm_events_snapshot_test(test_pmu_events_snaphost);
>>   	pr_info("SBI PMU event verification with snapshot test : PASS\n");
>>   
>> +	test_vm_events_overflow(test_pmu_events_overflow);
>> +	pr_info("SBI PMU event verification with overflow test : PASS\n");
>> +
>>   	return 0;
>>   }
>> -- 
>> 2.34.1
>>
> 
> Thanks,
> drew


