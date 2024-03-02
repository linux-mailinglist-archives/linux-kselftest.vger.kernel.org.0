Return-Path: <linux-kselftest+bounces-5788-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1EB86F06B
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Mar 2024 13:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D3CE1F21963
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Mar 2024 12:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B74A947;
	Sat,  2 Mar 2024 12:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="hycrEykc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB8179C2
	for <linux-kselftest@vger.kernel.org>; Sat,  2 Mar 2024 12:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709382949; cv=none; b=aIclKZjvj2qmIezDEXP5fMasjQ/+so02NoIJTu3GhVFB8kcX/1616EAGyQmAzNiraI7wrZFIyzAVboOiWLvvSHzsbD9e8kPoQiY0X+oBGUgj9SlDtKiImA6/3Qbo6vWzgxgVc9maFOEAwm3jNWTNLsSNXZi7Ka/JAOEYYFnqgSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709382949; c=relaxed/simple;
	bh=uvZe44R5Uc/kuroAUbRFRRLGnzr36ZRMq4JyI110Xtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QupMLDQMnX3jTyeC8tc7BjZACecIhUZClmKewtZxql0K8929iKtWYxfzDukTbStyrQVbiVdFfSaTJGguhHfmM1yeSvsIxP52+g0VqJAXNtD8Ga7fFxeoM8md6pitLxk36ffQsTdXywc5gTXcsaiviR3Y/IreAbxD4Zomka2Ah7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=hycrEykc; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5133bd7eb47so419237e87.3
        for <linux-kselftest@vger.kernel.org>; Sat, 02 Mar 2024 04:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1709382945; x=1709987745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fLmBNF7KnRHNjxFzW+xgQkBjw9RgIhEMQhm8dyjLxo0=;
        b=hycrEykcvI7a6vJkuvwAHzAlK65vcwluSikVanzWhmk3ZJEcxN0j5l+JdmbA/cNu6m
         /p4sbXvFma2yGYHpEq7fGrTVGRzGiN7gSrrQTaksa0y/wa0piV19JHZrvC7xBzQVm/hP
         avIT6y9A938rOdDj1rvfAdjjeRbkdMcOkVkHpVeywyEQBMG4mOnwMIUaizNdpLgQmY8d
         DDmaJGqausFc7als+FlfqzULu28BmoxuPALB16zIel5RWRL+Bf7gjPPBLTNVsmx/q481
         B9Jpdcr5+ifzyxa6pcB2x4UZERy+hPFhY6y1rx7KxJc33eq+hu7PVy5BpvVjsK+NWwxu
         fG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709382945; x=1709987745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLmBNF7KnRHNjxFzW+xgQkBjw9RgIhEMQhm8dyjLxo0=;
        b=rtxInU07yLSgp4vEEhcJi/90jHgEYQTYOmoxgCHHOluwzIwdKiEeiZgo1X0azMWgZK
         QAQY79HULDO/vhVxPPWLJ7sEJQ5R7TkxjIIf3+9ac4LGy7WCnFcPXu3iQ8T1CkOy3P/U
         JVseVOQ5ijYjU3nRM1i0XelUhdJG0cTPkpKZ/fiUAxyrk67mXpLanAE9TQCfSM/C8PO/
         r+uPDp5GanLQ0Z1nRc05NWX4usv3h2xo8/95tZ7Vz6VW81kJG3WE3sDVvZF1HdxGDPiz
         PbyeDUR3TtlkklOK1l+J5NtA4h12g5biFR49uI7Mgk/r6pMjJfHx4n8gx2NB7P5Bbc76
         V+Bg==
X-Forwarded-Encrypted: i=1; AJvYcCV5ryTMPoaeXrlHX5Lo77VPV0xAA34FE7HUWIJyCvPH+GWI+LbO/WMfBC6ECAoE9w+rWr81vZbBN3NJfabA9QBm+4qmVFwGQ01vU2+ZVJt9
X-Gm-Message-State: AOJu0Yw5ydJ3QkSOvg5RbkEDcpjSUkDeGywk2BUu11qN3RAzVqebSJqe
	zfT4+CTS5cU2DqdPz+21M89R5rA/4qIjS5NxhO2V6afGFsZsEXBZOzW99abtoT8=
X-Google-Smtp-Source: AGHT+IF7kMvVlfm0QV38CtL+50al6rOjeAc9EACkMvLkxpLCDVBPYC3K3Y+nOEoZwdZtjbgrgiosrA==
X-Received: by 2002:a05:6512:473:b0:513:1e3c:38ec with SMTP id x19-20020a056512047300b005131e3c38ecmr2688559lfd.22.1709382945338;
        Sat, 02 Mar 2024 04:35:45 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id g3-20020a056402180300b00566ea8e9f38sm1084255edy.40.2024.03.02.04.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 04:35:44 -0800 (PST)
Date: Sat, 2 Mar 2024 13:35:43 +0100
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
Subject: Re: [PATCH v4 15/15] KVM: riscv: selftests: Add a test for counter
 overflow
Message-ID: <20240302-fb3a4d2c7918a24d10ee4a63@orel>
References: <20240229010130.1380926-1-atishp@rivosinc.com>
 <20240229010130.1380926-16-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229010130.1380926-16-atishp@rivosinc.com>

On Wed, Feb 28, 2024 at 05:01:30PM -0800, Atish Patra wrote:
> Add a test for verifying overflow interrupt. Currently, it relies on
> overflow support on cycle/instret events. This test works for cycle/
> instret events which support sampling via hpmcounters on the platform.
> There are no ISA extensions to detect if a platform supports that. Thus,

Ouch. Are there discussions/proposals as to how we can do better with
discoverability here? This type of thing sounds like the types of things
that get new extension names defined for them as part of the profile spec
work.

> this test will fail on platform with virtualization but doesn't
> support overflow on these two events.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  tools/testing/selftests/kvm/riscv/sbi_pmu.c | 126 +++++++++++++++++++-
>  1 file changed, 125 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu.c b/tools/testing/selftests/kvm/riscv/sbi_pmu.c
> index 8ea2a6db6610..c0264c636054 100644
> --- a/tools/testing/selftests/kvm/riscv/sbi_pmu.c
> +++ b/tools/testing/selftests/kvm/riscv/sbi_pmu.c
> @@ -8,6 +8,7 @@
>   * Copyright (c) 2024, Rivos Inc.
>   */
>  
> +#include "asm/csr.h"
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> @@ -16,6 +17,7 @@
>  #include "kvm_util.h"
>  #include "test_util.h"
>  #include "processor.h"
> +#include "arch_timer.h"
>  
>  /* Maximum counters (firmware + hardware)*/
>  #define RISCV_MAX_PMU_COUNTERS 64
> @@ -26,6 +28,11 @@ union sbi_pmu_ctr_info ctrinfo_arr[RISCV_MAX_PMU_COUNTERS];
>  static void *snapshot_gva;
>  static vm_paddr_t snapshot_gpa;
>  
> +static int pmu_irq = IRQ_PMU_OVF;
> +
> +static int vcpu_shared_irq_count;
> +static int counter_in_use;
> +
>  /* Cache the available counters in a bitmask */
>  static unsigned long counter_mask_available;
>  
> @@ -69,7 +76,9 @@ unsigned long pmu_csr_read_num(int csr_num)
>  #undef switchcase_csr_read
>  }
>  
> -static inline void dummy_func_loop(int iter)
> +static void stop_counter(unsigned long counter, unsigned long stop_flags);
> +
> +static inline void dummy_func_loop(uint64_t iter)
>  {
>  	int i = 0;
>  
> @@ -88,6 +97,26 @@ static void guest_illegal_exception_handler(struct ex_regs *regs)
>  	regs->epc += 4;
>  }
>  
> +static void guest_irq_handler(struct ex_regs *regs)
> +{
> +	unsigned int irq_num = regs->cause & ~CAUSE_IRQ_FLAG;
> +	struct riscv_pmu_snapshot_data *snapshot_data = snapshot_gva;
> +	unsigned long overflown_mask;
> +
> +	/* Stop all counters first to avoid further interrupts */
> +	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, 0, 1UL << counter_in_use,
> +		  SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT, 0, 0, 0);
> +
> +	csr_clear(CSR_SIP, BIT(pmu_irq));
> +
> +	overflown_mask = READ_ONCE(snapshot_data->ctr_overflow_mask);
> +	GUEST_ASSERT(overflown_mask & (1UL << counter_in_use));
> +
> +	/* Validate that we are in the correct irq handler */
> +	GUEST_ASSERT_EQ(irq_num, pmu_irq);

Should probably do this irq handler assert first.

> +	WRITE_ONCE(vcpu_shared_irq_count, vcpu_shared_irq_count+1);
> +}
> +
>  static unsigned long get_counter_index(unsigned long cbase, unsigned long cmask,
>  				       unsigned long cflags,
>  				       unsigned long event)
> @@ -263,6 +292,32 @@ static void test_pmu_event_snapshot(unsigned long event)
>  	stop_counter(counter, SBI_PMU_STOP_FLAG_RESET);
>  }
>  
> +static void test_pmu_event_overflow(unsigned long event)
> +{
> +	unsigned long counter;
> +	unsigned long counter_value_post;
> +	unsigned long counter_init_value = ULONG_MAX - 10000;
> +	struct riscv_pmu_snapshot_data *snapshot_data = snapshot_gva;
> +
> +	counter = get_counter_index(0, counter_mask_available, 0, event);
> +	counter_in_use = counter;
> +
> +	/* The counter value is updated w.r.t relative index of cbase passed to start/stop */
> +	WRITE_ONCE(snapshot_data->ctr_values[0], counter_init_value);
> +	start_counter(counter, SBI_PMU_START_FLAG_INIT_FROM_SNAPSHOT, 0);
> +	dummy_func_loop(10000);
> +	udelay(msecs_to_usecs(2000));
> +	/* irq handler should have stopped the counter */
> +
> +	counter_value_post = READ_ONCE(snapshot_data->ctr_values[counter_in_use]);
> +	/* The counter value after stopping should be less the init value due to overflow */
> +	__GUEST_ASSERT(counter_value_post < counter_init_value,
> +		       "counter_value_post %lx counter_init_value %lx for counter\n",
> +		       counter_value_post, counter_init_value);
> +
> +	stop_counter(counter, SBI_PMU_STOP_FLAG_RESET);
> +}
> +
>  static void test_invalid_event(void)
>  {
>  	struct sbiret ret;
> @@ -361,6 +416,43 @@ static void test_pmu_events_snaphost(int cpu)
>  	GUEST_DONE();
>  }
>  
> +static void test_pmu_events_overflow(int cpu)

no need for cpu

> +{
> +	long out_val = 0;
> +	bool probe;
> +	int num_counters = 0;
> +	unsigned long sbi_impl_version;
> +
> +	probe = guest_sbi_probe_extension(SBI_EXT_PMU, &out_val);
> +	GUEST_ASSERT(probe && out_val == 1);
> +
> +	sbi_impl_version = get_host_sbi_impl_version();
> +	if (sbi_impl_version >= sbi_mk_version(2, 0))
> +		__GUEST_ASSERT(0, "SBI implementation version doesn't support PMU Snapshot");

Identical probe and version check as test_pmu_events_snaphost(). Can
factor out.

> +
> +	snapshot_set_shmem(snapshot_gpa, 0);
> +	csr_set(CSR_IE, BIT(pmu_irq));
> +	local_irq_enable();
> +
> +	/* Get the counter details */
> +	num_counters = get_num_counters();
> +	update_counter_info(num_counters);
> +
> +	/*
> +	 * Qemu supports overflow for cycle/instruction.
> +	 * This test may fail on any platform that do not support overflow for these two events.
> +	 */
> +	test_pmu_event_overflow(SBI_PMU_HW_CPU_CYCLES);
> +	GUEST_ASSERT_EQ(vcpu_shared_irq_count, 1);
> +
> +	/* Renable the interrupt again for another event */
> +	csr_set(CSR_IE, BIT(pmu_irq));
> +	test_pmu_event_overflow(SBI_PMU_HW_INSTRUCTIONS);
> +	GUEST_ASSERT_EQ(vcpu_shared_irq_count, 2);
> +
> +	GUEST_DONE();
> +}
> +
>  static void run_vcpu(struct kvm_vcpu *vcpu)
>  {
>  	struct ucall uc;
> @@ -449,6 +541,35 @@ static void test_vm_events_snapshot_test(void *guest_code)
>  	test_vm_destroy(vm);
>  }
>  
> +static void test_vm_events_overflow(void *guest_code)
> +{
> +	struct kvm_vm *vm = NULL;
> +	struct kvm_vcpu *vcpu = NULL;

nit: no need for NULL

> +
> +	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
> +	__TEST_REQUIRE(__vcpu_has_ext(vcpu, RISCV_SBI_EXT_REG(KVM_RISCV_SBI_EXT_PMU)),
> +				   "SBI PMU not available, skipping test");
> +
> +	__TEST_REQUIRE(__vcpu_has_ext(vcpu, RISCV_ISA_EXT_REG(KVM_RISCV_ISA_EXT_SSCOFPMF)),
> +				   "Sscofpmf is not available, skipping overflow test");
> +
> +
> +	test_vm_setup_snapshot_mem(vm, vcpu);
> +	vm_init_vector_tables(vm);
> +	vm_install_interrupt_handler(vm, guest_irq_handler);
> +
> +	vcpu_init_vector_tables(vcpu);
> +	/* Initialize guest timer frequency. */
> +	vcpu_get_reg(vcpu, RISCV_TIMER_REG(frequency), &timer_freq);
> +	sync_global_to_guest(vm, timer_freq);

I just noticed that timer_freq is in arch_timer.h and isn't an extern...
Fixing that is out of scope for this series though.

> +
> +	vcpu_args_set(vcpu, 1, 0);

no need for args

> +
> +	run_vcpu(vcpu);
> +
> +	test_vm_destroy(vm);
> +}
> +
>  int main(void)
>  {
>  	test_vm_basic_test(test_pmu_basic_sanity);
> @@ -460,5 +581,8 @@ int main(void)
>  	test_vm_events_snapshot_test(test_pmu_events_snaphost);
>  	pr_info("SBI PMU event verification with snapshot test : PASS\n");
>  
> +	test_vm_events_overflow(test_pmu_events_overflow);
> +	pr_info("SBI PMU event verification with overflow test : PASS\n");
> +
>  	return 0;
>  }
> -- 
> 2.34.1
>

Thanks,
drew

