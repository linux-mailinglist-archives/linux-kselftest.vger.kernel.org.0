Return-Path: <linux-kselftest+bounces-5787-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD3386F064
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Mar 2024 13:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C87A91F215AE
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Mar 2024 12:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5F917561;
	Sat,  2 Mar 2024 12:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="GvqZQHJa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E9B171A5
	for <linux-kselftest@vger.kernel.org>; Sat,  2 Mar 2024 12:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709381588; cv=none; b=HMVDkeepUyPZXanWRsSC6W/mYzjnzzDsGct9/tzwU8pe3Zja29fCaripGSJ6rME8aIit8prI3jyOtApH3gusWDcbufJpvS2Dt7hLRG/8o4MMboj51mXswD9Fh9yyLqLRbBgjfplPlg4FEh3ydPpN8sZ4MluxVPzQI9PWlYbmfd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709381588; c=relaxed/simple;
	bh=341DJflZLsaUJxLcsxaf0stD3RlGIMXO3C5Tpe6286Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnL7JepjxIOg/x6LQI9Ht1+q4c3IwYjgk2NfAA1uCGkAGoyRf19t4fO+rrDxlqZw7P1IXgs8LSYqtIkQssH+eWQr/zb6tCGO+gBi77x8n2VeAIHv0Cf1xeD2tEvLqmM3Txjj8y2WE8/BvQRpYCV1//d80OwRY9FVVOVI3i8xTnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=GvqZQHJa; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a34c5ca2537so468895166b.0
        for <linux-kselftest@vger.kernel.org>; Sat, 02 Mar 2024 04:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1709381584; x=1709986384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=//dksukFIxerglEAIo7HrabeYM0d04Z0de+v50cQ1aU=;
        b=GvqZQHJavhTmT6uPGyaZsdhfkWdjPfWtMH3g5/RW++FJnCcfoqqMgeNZEx1rvX3HDr
         lY46u7e7iRMDwG6N0qMYc4CvWy7qMVB9XLjPvjSoi3ADgTL0KagNd4ac4IBw7Y9+VxY+
         MLAfzPHfxlXH7ewGTa7A92VQu/K1RnAKRNqibc7mCcvgIW0P3CVD/s65uiIbFg/YU2mu
         qj2xvuiQV8V09MzGdDJ/Jn+jGF0btMp24o+WhkYJbc/i5hTNmK5s58LhWTFoo53D+Ixm
         HVFm49G8jyO8iZr7qRh9m0hvD/CaEndcnws1ppiND5YXFNjOGMyR/S1n9OO4usB2gfUa
         WxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709381584; x=1709986384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//dksukFIxerglEAIo7HrabeYM0d04Z0de+v50cQ1aU=;
        b=pZZ5O0qP+SpZKgUYEqSI8OQl2TY+1wPdI7qWO1Iyep+KPHjxK8jVsOLvpHZAFTiXjX
         YUBMANuna4i4tlwSqCE93y6v+O+KX4gToa/1kq0guJgtrbT803oNma8lU1S0Vt2HwXOj
         IFhW1Y8R9DjOVf0k6b16ZJgKH4/Eg90zpyfX4mGzUdLSoLJGCMX9hqKh82TmlELOL4jz
         Vq4+4dfOwRuvRWqBFJdxqOMIrQ3Dt3qfsM8RhCfaWVhRPcIjr4VWkzUgegJdc/SLfiFj
         6swEoasJvhU73GGrZJsd9J7a/nfGhJfMHLh6EjRmrItuJzZwIP40XXGFT6Z0a/WrUsw+
         xu1g==
X-Forwarded-Encrypted: i=1; AJvYcCUmvFLCKHXmFUUKbiPOlijEMXnMnZjSN0pRV5r/m3xf9H+WXI2GFfWT327NYjtpGE2mrRoF3UgK2vPLQZXCCgtEUTV2T86NcuX1HnB5Wm3R
X-Gm-Message-State: AOJu0YxXah7waXHDJ56UbDY4icVZEVtos4PrS95BQu68D3sBn0F+W0Kd
	+Ci8tGPjrKUbrB73vR6mZp8nwZYyR4UrGYUuXvLzZF/yaK8GOEywRu8VOC6/YOs=
X-Google-Smtp-Source: AGHT+IEvWyD7Rp+NiKiA8Hg530PnZRPbdrbQ0poKxXPdyFIlgnEtIBUMeG4JgkvVbbaozkB/wnP3zQ==
X-Received: by 2002:a17:906:f1d1:b0:a43:83dd:1e4e with SMTP id gx17-20020a170906f1d100b00a4383dd1e4emr3057535ejb.29.1709381584340;
        Sat, 02 Mar 2024 04:13:04 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id ld15-20020a170906f94f00b00a44e7afde87sm363969ejb.148.2024.03.02.04.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 04:13:03 -0800 (PST)
Date: Sat, 2 Mar 2024 13:13:02 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Guo Ren <guoren@kernel.org>, Icenowy Zheng <uwu@icenowy.me>, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 14/15] KVM: riscv: selftests: Add a test for PMU
 snapshot functionality
Message-ID: <20240302-188985ea03041de3e8910916@orel>
References: <20240229010130.1380926-1-atishp@rivosinc.com>
 <20240229010130.1380926-15-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229010130.1380926-15-atishp@rivosinc.com>

On Wed, Feb 28, 2024 at 05:01:29PM -0800, Atish Patra wrote:
> Verify PMU snapshot functionality by setting up the shared memory
> correctly and reading the counter values from the shared memory
> instead of the CSR.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  .../selftests/kvm/include/riscv/processor.h   |  25 ++++
>  .../selftests/kvm/lib/riscv/processor.c       |  12 ++
>  tools/testing/selftests/kvm/riscv/sbi_pmu.c   | 124 ++++++++++++++++++
>  3 files changed, 161 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
> index a49a39c8e8d4..e114d039e87b 100644
> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> @@ -173,6 +173,7 @@ enum sbi_ext_id {
>  };
>  
>  enum sbi_ext_base_fid {
> +	SBI_EXT_BASE_GET_IMP_VERSION = 2,
>  	SBI_EXT_BASE_PROBE_EXT = 3,
>  };
>  
> @@ -201,6 +202,12 @@ union sbi_pmu_ctr_info {
>  	};
>  };
>  
> +struct riscv_pmu_snapshot_data {
> +	u64 ctr_overflow_mask;
> +	u64 ctr_values[64];
> +	u64 reserved[447];
> +};
> +
>  struct sbiret {
>  	long error;
>  	long value;
> @@ -247,6 +254,14 @@ enum sbi_pmu_ctr_type {
>  #define SBI_PMU_STOP_FLAG_RESET (1 << 0)
>  #define SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT BIT(1)
>  
> +#define SBI_STA_SHMEM_DISABLE		-1

unrelated change

> +
> +/* SBI spec version fields */
> +#define SBI_SPEC_VERSION_DEFAULT	0x1
> +#define SBI_SPEC_VERSION_MAJOR_SHIFT	24
> +#define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
> +#define SBI_SPEC_VERSION_MINOR_MASK	0xffffff
> +
>  struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
>  			unsigned long arg1, unsigned long arg2,
>  			unsigned long arg3, unsigned long arg4,
> @@ -254,6 +269,16 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
>  
>  bool guest_sbi_probe_extension(int extid, long *out_val);
>  
> +/* Make SBI version */
> +static inline unsigned long sbi_mk_version(unsigned long major,
> +					    unsigned long minor)
> +{
> +	return ((major & SBI_SPEC_VERSION_MAJOR_MASK) <<
> +		SBI_SPEC_VERSION_MAJOR_SHIFT) | minor;
> +}

We should probably just synch sbi.h into tools, since we need plenty
from it.

> +
> +unsigned long get_host_sbi_impl_version(void);
> +
>  static inline void local_irq_enable(void)
>  {
>  	csr_set(CSR_SSTATUS, SR_SIE);
> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
> index ec66d331a127..b0162d923e38 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
> @@ -499,3 +499,15 @@ bool guest_sbi_probe_extension(int extid, long *out_val)
>  
>  	return true;
>  }
> +
> +unsigned long get_host_sbi_impl_version(void)
> +{
> +	struct sbiret ret;
> +
> +	ret = sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_GET_IMP_VERSION, 0,
> +		       0, 0, 0, 0, 0);
> +
> +	GUEST_ASSERT(!ret.error);
> +
> +	return ret.value;
> +}
> diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu.c b/tools/testing/selftests/kvm/riscv/sbi_pmu.c
> index fc1fc5eea99e..8ea2a6db6610 100644
> --- a/tools/testing/selftests/kvm/riscv/sbi_pmu.c
> +++ b/tools/testing/selftests/kvm/riscv/sbi_pmu.c
> @@ -21,6 +21,11 @@
>  #define RISCV_MAX_PMU_COUNTERS 64
>  union sbi_pmu_ctr_info ctrinfo_arr[RISCV_MAX_PMU_COUNTERS];
>  
> +/* Snapshot shared memory data */
> +#define PMU_SNAPSHOT_GPA_BASE		(1 << 30)
> +static void *snapshot_gva;
> +static vm_paddr_t snapshot_gpa;
> +
>  /* Cache the available counters in a bitmask */
>  static unsigned long counter_mask_available;
>  
> @@ -173,6 +178,20 @@ static void stop_counter(unsigned long counter, unsigned long stop_flags)
>  			       counter, ret.error);
>  }
>  
> +static void snapshot_set_shmem(vm_paddr_t gpa, unsigned long flags)
> +{
> +	unsigned long lo = (unsigned long)gpa;
> +#if __riscv_xlen == 32
> +	unsigned long hi = (unsigned long)(gpa >> 32);
> +#else
> +	unsigned long hi = gpa == -1 ? -1 : 0;
> +#endif
> +	struct sbiret ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_SNAPSHOT_SET_SHMEM,
> +				      lo, hi, flags, 0, 0, 0);
> +
> +	GUEST_ASSERT(ret.value == 0 && ret.error == 0);
> +}
> +
>  static void test_pmu_event(unsigned long event)
>  {
>  	unsigned long counter;
> @@ -207,6 +226,43 @@ static void test_pmu_event(unsigned long event)
>  	stop_counter(counter, SBI_PMU_STOP_FLAG_RESET);
>  }
>  
> +static void test_pmu_event_snapshot(unsigned long event)
> +{
> +	unsigned long counter;
> +	unsigned long counter_value_pre, counter_value_post;
> +	unsigned long counter_init_value = 100;
> +	struct riscv_pmu_snapshot_data *snapshot_data = snapshot_gva;
> +
> +	counter = get_counter_index(0, counter_mask_available, 0, event);
> +	counter_value_pre = read_counter(counter, ctrinfo_arr[counter]);
> +
> +	/* Do not set the initial value */
> +	start_counter(counter, 0, 0);
> +	dummy_func_loop(10000);
> +
> +	stop_counter(counter, SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT);
> +
> +	/* The counter value is updated w.r.t relative index of cbase */
> +	counter_value_post = READ_ONCE(snapshot_data->ctr_values[0]);
> +	__GUEST_ASSERT(counter_value_post > counter_value_pre,
> +		       "counter_value_post %lx counter_value_pre %lx\n",
> +		       counter_value_post, counter_value_pre);
> +
> +	/* Now set the initial value and compare */
> +	WRITE_ONCE(snapshot_data->ctr_values[0], counter_init_value);
> +	start_counter(counter, SBI_PMU_START_FLAG_INIT_FROM_SNAPSHOT, 0);
> +	dummy_func_loop(10000);
> +
> +	stop_counter(counter, SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT);
> +
> +	counter_value_post = READ_ONCE(snapshot_data->ctr_values[0]);
> +	__GUEST_ASSERT(counter_value_post > counter_init_value,
> +		       "counter_value_post %lx counter_init_value %lx for counter\n",
> +		       counter_value_post, counter_init_value);
> +
> +	stop_counter(counter, SBI_PMU_STOP_FLAG_RESET);

This function is almost identical to test_pmu_event(). If we change one,
we'll likely have to change the other. We should have a single function
which can be used by both tests. We can do that by passing a function
pointer for the read which is different for non-snapshot and snapshot.

> +}
> +
>  static void test_invalid_event(void)
>  {
>  	struct sbiret ret;
> @@ -270,6 +326,41 @@ static void test_pmu_basic_sanity(int cpu)
>  	GUEST_DONE();
>  }
>  
> +static void test_pmu_events_snaphost(int cpu)

unnecessary cpu parameter

> +{
> +	long out_val = 0;
> +	bool probe;
> +	int num_counters = 0;
> +	unsigned long sbi_impl_version;
> +	struct riscv_pmu_snapshot_data *snapshot_data = snapshot_gva;
> +	int i;
> +
> +	probe = guest_sbi_probe_extension(SBI_EXT_PMU, &out_val);
> +	GUEST_ASSERT(probe && out_val == 1);
> +
> +	sbi_impl_version = get_host_sbi_impl_version();
> +	if (sbi_impl_version >= sbi_mk_version(2, 0))
> +		__GUEST_ASSERT(0, "SBI implementation version doesn't support PMU Snapshot");
> +
> +	snapshot_set_shmem(snapshot_gpa, 0);
> +
> +	/* Get the counter details */
> +	num_counters = get_num_counters();
> +	update_counter_info(num_counters);
> +
> +	/* Validate shared memory access */
> +	GUEST_ASSERT_EQ(READ_ONCE(snapshot_data->ctr_overflow_mask), 0);
> +	for (i = 0; i < num_counters; i++) {
> +		if (counter_mask_available & (1UL << i))

BIT()

> +			GUEST_ASSERT_EQ(READ_ONCE(snapshot_data->ctr_values[i]), 0);
> +	}
> +	/* Only these two events are guranteed to be present */
> +	test_pmu_event_snapshot(SBI_PMU_HW_CPU_CYCLES);
> +	test_pmu_event_snapshot(SBI_PMU_HW_INSTRUCTIONS);
> +
> +	GUEST_DONE();
> +}
> +
>  static void run_vcpu(struct kvm_vcpu *vcpu)
>  {
>  	struct ucall uc;
> @@ -328,6 +419,36 @@ static void test_vm_events_test(void *guest_code)
>  	test_vm_destroy(vm);
>  }
>  
> +static void test_vm_setup_snapshot_mem(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
> +{
> +	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, PMU_SNAPSHOT_GPA_BASE, 1, 1, 0);
> +	/* PMU Snapshot requires single page only */

This comment should go above the memory region add

> +	virt_map(vm, PMU_SNAPSHOT_GPA_BASE, PMU_SNAPSHOT_GPA_BASE, 1);
> +
> +	/* PMU_SNAPSHOT_GPA_BASE is identity mapped */

This comment should go above the virt_map

> +	snapshot_gva = (void *)(PMU_SNAPSHOT_GPA_BASE);
> +	snapshot_gpa = addr_gva2gpa(vcpu->vm, (vm_vaddr_t)snapshot_gva);
> +	sync_global_to_guest(vcpu->vm, snapshot_gva);
> +	sync_global_to_guest(vcpu->vm, snapshot_gpa);
> +}
> +
> +static void test_vm_events_snapshot_test(void *guest_code)
> +{
> +	struct kvm_vm *vm = NULL;
> +	struct kvm_vcpu *vcpu = NULL;

nit: no need to set to NULL

> +
> +	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
> +	__TEST_REQUIRE(__vcpu_has_ext(vcpu, RISCV_ISA_EXT_REG(KVM_RISCV_SBI_EXT_PMU)),

RISCV_SBI_EXT_REG

> +				   "SBI PMU not available, skipping test");
> +
> +	test_vm_setup_snapshot_mem(vm, vcpu);
> +
> +	vcpu_args_set(vcpu, 1, 0);

no need to set args

> +	run_vcpu(vcpu);
> +
> +	test_vm_destroy(vm);
> +}
> +
>  int main(void)
>  {
>  	test_vm_basic_test(test_pmu_basic_sanity);
> @@ -336,5 +457,8 @@ int main(void)
>  	test_vm_events_test(test_pmu_events);
>  	pr_info("SBI PMU event verification test : PASS\n");
>  
> +	test_vm_events_snapshot_test(test_pmu_events_snaphost);
> +	pr_info("SBI PMU event verification with snapshot test : PASS\n");
> +
>  	return 0;
>  }
> -- 
> 2.34.1
>

Thanks,
drew

