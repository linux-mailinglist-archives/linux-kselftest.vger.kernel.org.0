Return-Path: <linux-kselftest+bounces-7509-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B803889E5C4
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 00:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4504D1F228FE
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 22:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC40158DA0;
	Tue,  9 Apr 2024 22:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="pirceWlp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D3C158D6F
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Apr 2024 22:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712703166; cv=none; b=nRmM4lCjkSnZYN32uODEOYZ0MwnpLQ2x702CrhFgxyAd8wM2Tf8qp4Zf+0k6UCfuIiaUgT5mKhLyctt4/+hn6kGiNgkfN78zEpaxpFNLtc0Z4tGo9LM/iAh5Uqe+L5qTm1OASIfpKK321e0FpKUGQofsLPcJdE9IyGw84Uf90ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712703166; c=relaxed/simple;
	bh=mAjayV0DPWOtmoPQbTOB12HW/zadj4FzkdoGwSXy7Cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YnpRXWvlmz/t4tp+iD0mgepQqsd3LtNF9AOUyZ1/17+PPrkHRl5mMGytg8lsaaqXJaInLt8/yn/a4QHB8G1uDivjAIdz8kwp4I2OZVWUYAOGChHsdCPjpOqP4/6kfD4eCuulm59Hcf/2AMUhVfWaf7nVW4wDbaxTzNDuJmvOhY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=pirceWlp; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e3f17c64daso22648755ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Apr 2024 15:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712703164; x=1713307964; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8646Xh8g5yQ0wp4lvVkVKpM6tKaisldaAHvB1jCcuIM=;
        b=pirceWlpYX8Fk+aURGPBD1NqxhL8vuBgifa3jr6Ez8ez3AFoUjItyapSt35bFlrSmu
         MdasjUf1TVs9P9UMqkmzARyOjQ6XvAqjsbzkx0iZMDG92FdYJrSoGzOzgW6JNVS389Wm
         kJ60eFu9tiszLjF5+HS/NzhF2pcTcpJcbMCMqXX6Zo5GnQF1/hjE8HL1r2jKbaKX0Zy8
         m2ADYOvYlGyNG4lydjAzG7tAyAfizBpGSkillz3JOMmyGFZvByt0myEYQ9m0741uWj8K
         3dJlOwP9OoCtnyUUljxQBFHIxOwSdYEAuODGp9SH8OdroRl3gpW8DAhmlvNTsSlj57Ts
         Z3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712703164; x=1713307964;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8646Xh8g5yQ0wp4lvVkVKpM6tKaisldaAHvB1jCcuIM=;
        b=v2UzTyWJEsvG9JOedMSjUkaiwfLRg2BG3AWLYHvaFyWUT+gOTdnlaIllY0XqRKhCuG
         xZS2a2VdYhna38ob0jd/TTu8iReGf6VH2lQHr2lNcl9poGwyVMyLgkG9FCveAFBQzyk7
         J5LToOoA0pV9qHwcsDVm04UavPzCBX6HLYfU1stC6XxGe91TgOqXqs7IEspORtUi+wb5
         SgTZX0sfaxPwesjHQpIQ0EATskwnmU3/EYY1M5IztJlCV3YCX3e8TM7CNqFSS/QTSflW
         dzJs1v0KhwxhML6Sb35L9xLZe8qX9PeHjCj1WRbVDB3RzrDbfvvayJyzHAJBBjSpupns
         YLCA==
X-Forwarded-Encrypted: i=1; AJvYcCUKUEv4KeH5AxQNGlG4PGQzJ01y+jY90DCyDe9AsICJ4eqemdtJizPw4fjpK/+fjNJK1omhkefWQcfiEDhxP2ox325sBpB5nnKQn7QnUi01
X-Gm-Message-State: AOJu0YwJcLoqCf/OkyjBR99FBhUOrP6r8mOAOMF7Q+Okv8nl0bPwyLDV
	QmcOyJGGPUwiRSpqbgoh3jGHdWYUafg6NcWdDarqut9zCxCX8bERLi0wkIRjFsQ=
X-Google-Smtp-Source: AGHT+IHPTK8LD9zQy/xLQpYsma/G3UlebQRk8nSskauRbNZ+/B4hgd1PN7d7FaruEdopv10/t5kwJg==
X-Received: by 2002:a17:902:e548:b0:1e0:b9d0:f6b with SMTP id n8-20020a170902e54800b001e0b9d00f6bmr1177730plf.68.1712703163716;
        Tue, 09 Apr 2024 15:52:43 -0700 (PDT)
Received: from [10.0.16.226] ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902e30c00b001e290812d49sm9463411plc.226.2024.04.09.15.52.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 15:52:42 -0700 (PDT)
Message-ID: <8748dbed-d105-4f26-a808-667c3b56c8ec@rivosinc.com>
Date: Tue, 9 Apr 2024 15:52:40 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 21/22] KVM: riscv: selftests: Add a test for PMU
 snapshot functionality
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>,
 Ajay Kaher <akaher@vmware.com>, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Alexey Makhalov <amakhalov@vmware.com>,
 Conor Dooley <conor.dooley@microchip.com>, Juergen Gross <jgross@suse.com>,
 kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
 Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>,
 virtualization@lists.linux.dev,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Will Deacon <will@kernel.org>, x86@kernel.org
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-22-atishp@rivosinc.com>
 <20240405-4e840120e8117c286cb593f9@orel>
From: Atish Patra <atishp@rivosinc.com>
In-Reply-To: <20240405-4e840120e8117c286cb593f9@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/5/24 06:11, Andrew Jones wrote:
> On Wed, Apr 03, 2024 at 01:04:50AM -0700, Atish Patra wrote:
>> Verify PMU snapshot functionality by setting up the shared memory
>> correctly and reading the counter values from the shared memory
>> instead of the CSR.
>>
>> Reviewed-by: Anup Patel <anup@brainfault.org>
>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
>> ---
>>   .../testing/selftests/kvm/include/riscv/sbi.h |  25 ++++
>>   .../selftests/kvm/lib/riscv/processor.c       |  12 ++
>>   .../selftests/kvm/riscv/sbi_pmu_test.c        | 127 ++++++++++++++++++
>>   3 files changed, 164 insertions(+)
>>
>> diff --git a/tools/testing/selftests/kvm/include/riscv/sbi.h b/tools/testing/selftests/kvm/include/riscv/sbi.h
>> index 6675ca673c77..8c98bd99d450 100644
>> --- a/tools/testing/selftests/kvm/include/riscv/sbi.h
>> +++ b/tools/testing/selftests/kvm/include/riscv/sbi.h
>> @@ -8,6 +8,12 @@
>>   #ifndef SELFTEST_KVM_SBI_H
>>   #define SELFTEST_KVM_SBI_H
>>   
>> +/* SBI spec version fields */
>> +#define SBI_SPEC_VERSION_DEFAULT	0x1
>> +#define SBI_SPEC_VERSION_MAJOR_SHIFT	24
>> +#define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
>> +#define SBI_SPEC_VERSION_MINOR_MASK	0xffffff
>> +
>>   /* SBI return error codes */
>>   #define SBI_SUCCESS				 0
>>   #define SBI_ERR_FAILURE				-1
>> @@ -33,6 +39,9 @@ enum sbi_ext_id {
>>   };
>>   
>>   enum sbi_ext_base_fid {
>> +	SBI_EXT_BASE_GET_SPEC_VERSION = 0,
>> +	SBI_EXT_BASE_GET_IMP_ID,
>> +	SBI_EXT_BASE_GET_IMP_VERSION,
>>   	SBI_EXT_BASE_PROBE_EXT = 3,
>>   };
>>   enum sbi_ext_pmu_fid {
>> @@ -60,6 +69,12 @@ union sbi_pmu_ctr_info {
>>   	};
>>   };
>>   
>> +struct riscv_pmu_snapshot_data {
>> +	u64 ctr_overflow_mask;
>> +	u64 ctr_values[64];
>> +	u64 reserved[447];
>> +};
>> +
>>   struct sbiret {
>>   	long error;
>>   	long value;
>> @@ -113,4 +128,14 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
>>   
>>   bool guest_sbi_probe_extension(int extid, long *out_val);
>>   
>> +/* Make SBI version */
>> +static inline unsigned long sbi_mk_version(unsigned long major,
>> +					    unsigned long minor)
>> +{
>> +	return ((major & SBI_SPEC_VERSION_MAJOR_MASK) <<
>> +		SBI_SPEC_VERSION_MAJOR_SHIFT) | minor;
> 
> Should also also mask 'minor'. I see this matches what we have in the
> kernel so we should fix it there too.
> 

Nice catch. I fixed it in both places.

>> +}
>> +
>> +unsigned long get_host_sbi_spec_version(void);
>> +
>>   #endif /* SELFTEST_KVM_SBI_H */
>> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
>> index e8211f5d6863..ccb35573749c 100644
>> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
>> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
>> @@ -502,3 +502,15 @@ bool guest_sbi_probe_extension(int extid, long *out_val)
>>   
>>   	return true;
>>   }
>> +
>> +unsigned long get_host_sbi_spec_version(void)
>> +{
>> +	struct sbiret ret;
>> +
>> +	ret = sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_GET_SPEC_VERSION, 0,
>> +		       0, 0, 0, 0, 0);
>> +
>> +	GUEST_ASSERT(!ret.error);
>> +
>> +	return ret.value;
>> +}
>> diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
>> index 8e7c7a3172d8..7d195be5c3d9 100644
>> --- a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
>> +++ b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
>> @@ -19,6 +19,11 @@
>>   #define RISCV_MAX_PMU_COUNTERS 64
>>   union sbi_pmu_ctr_info ctrinfo_arr[RISCV_MAX_PMU_COUNTERS];
>>   
>> +/* Snapshot shared memory data */
>> +#define PMU_SNAPSHOT_GPA_BASE		BIT(30)
>> +static void *snapshot_gva;
>> +static vm_paddr_t snapshot_gpa;
>> +
>>   /* Cache the available counters in a bitmask */
>>   static unsigned long counter_mask_available;
>>   
>> @@ -178,6 +183,32 @@ static unsigned long read_counter(int idx, union sbi_pmu_ctr_info ctrinfo)
>>   	return counter_val;
>>   }
>>   
>> +static inline void verify_sbi_requirement_assert(void)
>> +{
>> +	long out_val = 0;
>> +	bool probe;
>> +
>> +	probe = guest_sbi_probe_extension(SBI_EXT_PMU, &out_val);
>> +	GUEST_ASSERT(probe && out_val == 1);
>> +
>> +	if (get_host_sbi_spec_version() < sbi_mk_version(2, 0))
>> +		__GUEST_ASSERT(0, "SBI implementation version doesn't support PMU Snapshot");
>> +}
> 
> It's a pity we can't check the SBI spec version that KVM is advertising
> from KVM userspace. Normally we'd want to check something like this at
> the start of the test with TEST_REQUIRE() before running a VCPU in order
> to generate a skip exit.
> 

Agreed. I will send a separate series for that as it is an ABI change.

> (We probably should allow reading and even writing the SBI spec version
> from the VMM in order to better support migration.)
> 

How that would work for SBI spec version write use case ? For migraiton, 
you can't go back to older SBI versions in the host. Isn't it ?

Considering this case your VM is running with PMU snapshot as the host 
has SBI v2.0. It can't be migrated to v1.0 and expecting it work. Correct ?


>> +
>> +static void snapshot_set_shmem(vm_paddr_t gpa, unsigned long flags)
>> +{
>> +	unsigned long lo = (unsigned long)gpa;
>> +#if __riscv_xlen == 32
>> +	unsigned long hi = (unsigned long)(gpa >> 32);
>> +#else
>> +	unsigned long hi = gpa == -1 ? -1 : 0;
>> +#endif
>> +	struct sbiret ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_SNAPSHOT_SET_SHMEM,
>> +				      lo, hi, flags, 0, 0, 0);
>> +
>> +	GUEST_ASSERT(ret.value == 0 && ret.error == 0);
>> +}
>> +
>>   static void test_pmu_event(unsigned long event)
>>   {
>>   	unsigned long counter;
>> @@ -210,6 +241,41 @@ static void test_pmu_event(unsigned long event)
>>   	stop_reset_counter(counter, 0);
>>   }
>>   
>> +static void test_pmu_event_snapshot(unsigned long event)
>> +{
>> +	unsigned long counter;
>> +	unsigned long counter_value_pre, counter_value_post;
>> +	unsigned long counter_init_value = 100;
>> +	struct riscv_pmu_snapshot_data *snapshot_data = snapshot_gva;
>> +
>> +	counter = get_counter_index(0, counter_mask_available, 0, event);
>> +	counter_value_pre = read_counter(counter, ctrinfo_arr[counter]);
>> +
>> +	/* Do not set the initial value */
>> +	start_counter(counter, 0, 0);
>> +	dummy_func_loop(10000);
>> +	stop_counter(counter, SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT);
>> +
>> +	/* The counter value is updated w.r.t relative index of cbase */
>> +	counter_value_post = READ_ONCE(snapshot_data->ctr_values[0]);
>> +	__GUEST_ASSERT(counter_value_post > counter_value_pre,
>> +		       "counter_value_post %lx counter_value_pre %lx\n",
>> +		       counter_value_post, counter_value_pre);
>> +
>> +	/* Now set the initial value and compare */
>> +	WRITE_ONCE(snapshot_data->ctr_values[0], counter_init_value);
>> +	start_counter(counter, SBI_PMU_START_FLAG_INIT_SNAPSHOT, 0);
>> +	dummy_func_loop(10000);
>> +	stop_counter(counter, SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT);
>> +
>> +	counter_value_post = READ_ONCE(snapshot_data->ctr_values[0]);
>> +	__GUEST_ASSERT(counter_value_post > counter_init_value,
>> +		       "counter_value_post %lx counter_init_value %lx for counter\n",
>> +		       counter_value_post, counter_init_value);
>> +
>> +	stop_reset_counter(counter, 0);
>> +}
>> +
>>   static void test_invalid_event(void)
>>   {
>>   	struct sbiret ret;
>> @@ -272,6 +338,34 @@ static void test_pmu_basic_sanity(void)
>>   	GUEST_DONE();
>>   }
>>   
>> +static void test_pmu_events_snaphost(void)
>> +{
>> +	int num_counters = 0;
>> +	struct riscv_pmu_snapshot_data *snapshot_data = snapshot_gva;
>> +	int i;
>> +
>> +	/* Verify presence of SBI PMU and minimum requrired SBI version */
>> +	verify_sbi_requirement_assert();
>> +
>> +	snapshot_set_shmem(snapshot_gpa, 0);
>> +
>> +	/* Get the counter details */
>> +	num_counters = get_num_counters();
>> +	update_counter_info(num_counters);
>> +
>> +	/* Validate shared memory access */
>> +	GUEST_ASSERT_EQ(READ_ONCE(snapshot_data->ctr_overflow_mask), 0);
>> +	for (i = 0; i < num_counters; i++) {
>> +		if (counter_mask_available & (BIT(i)))
>> +			GUEST_ASSERT_EQ(READ_ONCE(snapshot_data->ctr_values[i]), 0);
>> +	}
>> +	/* Only these two events are guranteed to be present */
>> +	test_pmu_event_snapshot(SBI_PMU_HW_CPU_CYCLES);
>> +	test_pmu_event_snapshot(SBI_PMU_HW_INSTRUCTIONS);
>> +
>> +	GUEST_DONE();
>> +}
>> +
>>   static void run_vcpu(struct kvm_vcpu *vcpu)
>>   {
>>   	struct ucall uc;
>> @@ -328,13 +422,46 @@ static void test_vm_events_test(void *guest_code)
>>   	test_vm_destroy(vm);
>>   }
>>   
>> +static void test_vm_setup_snapshot_mem(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
>> +{
>> +	/* PMU Snapshot requires single page only */
>> +	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, PMU_SNAPSHOT_GPA_BASE, 1, 1, 0);
>> +	/* PMU_SNAPSHOT_GPA_BASE is identity mapped */
>> +	virt_map(vm, PMU_SNAPSHOT_GPA_BASE, PMU_SNAPSHOT_GPA_BASE, 1);
>> +
>> +	snapshot_gva = (void *)(PMU_SNAPSHOT_GPA_BASE);
>> +	snapshot_gpa = addr_gva2gpa(vcpu->vm, (vm_vaddr_t)snapshot_gva);
>> +	sync_global_to_guest(vcpu->vm, snapshot_gva);
>> +	sync_global_to_guest(vcpu->vm, snapshot_gpa);
>> +}
>> +
>> +static void test_vm_events_snapshot_test(void *guest_code)
>> +{
>> +	struct kvm_vm *vm = NULL;
>> +	struct kvm_vcpu *vcpu;
>> +
>> +	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
>> +	__TEST_REQUIRE(__vcpu_has_sbi_ext(vcpu, KVM_RISCV_SBI_EXT_PMU),
>> +				   "SBI PMU not available, skipping test");
>> +
>> +	test_vm_setup_snapshot_mem(vm, vcpu);
>> +
>> +	run_vcpu(vcpu);
>> +
>> +	test_vm_destroy(vm);
>> +}
>> +
>>   int main(void)
>>   {
>> +	pr_info("SBI PMU basic test : starting\n");
>>   	test_vm_basic_test(test_pmu_basic_sanity);
>>   	pr_info("SBI PMU basic test : PASS\n");
>>   
>>   	test_vm_events_test(test_pmu_events);
>>   	pr_info("SBI PMU event verification test : PASS\n");
>>   
>> +	test_vm_events_snapshot_test(test_pmu_events_snaphost);
>> +	pr_info("SBI PMU event verification with snapshot test : PASS\n");
>> +
>>   	return 0;
>>   }
>> -- 
>> 2.34.1
>>
> 
> Since my comments are a bit out-of-scope for this patch,
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> 
> Thanks,
> drew


