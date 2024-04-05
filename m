Return-Path: <linux-kselftest+bounces-7290-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AB2899E31
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 15:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26FFE283C73
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 13:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301AB16D4DA;
	Fri,  5 Apr 2024 13:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="n/P6zTEA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD34616D4C5
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Apr 2024 13:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712323406; cv=none; b=ZoyHvPA04AaQm876XiDRUOzsfa7nmx0czqcYtUXJbYgj0lpdeGPchK9mK1kP2sQNzqkCUBLic5W2ztkN6CyeFPjeWttuXRBRpBXiGFuTeJl0tEUdHHjjiWzp7gjOy/9ExPW74iSnJgAe/sMjQHseCaxohkHpwIaVJa0f8op5l60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712323406; c=relaxed/simple;
	bh=jMhYY8dFdQP3i/lURcmjsgqU90mz/slXD8doxAmjetc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7AFFxYkpNXB4e74mbTDq80MMKzc0Nok6MEvNyahVhLiGBvtPSvTApTtgunyXT6Rw3V6BzCQE5rJ/uOsRtzUyVEzHEM1KHnLQwApD1FubcHK386jA8Q3HDRdKelUgCp+QBQMjpnlBqNE1pCNOl0+0pXHB6Tb0h4iYlfE/7VPwR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=n/P6zTEA; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a51a8749478so59387566b.2
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Apr 2024 06:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712323402; x=1712928202; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WAlEwvrkVW7t1ChXhk39Ejj3ZEPYPMlfWsiWP+NJhlQ=;
        b=n/P6zTEALDai8r5zZhA7F5Ob88l77w1xhCu6sklmWeBP1ueYUud8/zLLUoQ7MC683j
         qLq09C7YHfbQcSdPNmVsmXTKKkP6VkfohfTMOpD5NJpiu7izHlmb0lYcnt/PrGWe9ZuK
         xgJpi9jsf44vw+Yxe6XSOZq7220ODiIiCPhNlyWGK86jQl7ZLJ6Sf6VTA8Hd0GBLEp2g
         8kxdTX49RhQ1BjJCGdIVvVKr/dJqsi9GCPRm1m2Cb3xba61cNUWI7jBXIQWOrOLqNEEH
         vgxfPy/nKT0Nt2u1gYiz2MXdwRkXb6lFd2R6x5yFIsilJDBfwQyPpJvojD4u5e0vqu6u
         1jXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712323402; x=1712928202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAlEwvrkVW7t1ChXhk39Ejj3ZEPYPMlfWsiWP+NJhlQ=;
        b=uuu/HZSDQSNi+eJ0JLz9SuCQ+cBbVWPLfKE+qLDlfDbOuIce6uKXLSPmnT/Nyx0lgt
         +LbW24eNP1CS3L0qdBeHt/m/7ZCeG6dy9XYCjTwFgEjVKap+/8kW4vU6icqjVIJ53rdT
         +GAmcz9Y6Z2SPTpRGvbkHvYjk+MwXReUe3UJt90VfUPDd9Ck6inWdOwJ+KzIDKD+cbp8
         +zJGAvUS4v6OE7kn2sDxRyKz4sNA5BmdHpcxLAhxQv5i8oJVha3mpbRYB0P9AsTMGjFO
         wUqaloS91yDXJZuUfrs73ye44VWXVj6w1NpnGI5xCAa6jbuh7HNgqf9ZHqXpd9HLlQqm
         eMhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6kyrccApR8a2yKiFGIM9qGhxt3aBHtUjrPpldKQCJlSQY61MYa+2nWGe3VqDGRr/QLMQtbLrFPnlxsyOqoxHMiRPFjockB3qeFrI0vgNJ
X-Gm-Message-State: AOJu0YxE6inrct/scbAe9/fe4/rEvZ9Hde4Ahm5VsJHzq0bOiOboKdFo
	U86+joWTo7wOAzBJBQh6iC0Y6DYzLENrS/Ci5qUgfG+sfb1eKMiG8jlhEQXW7zs=
X-Google-Smtp-Source: AGHT+IFT5fpj+iBK8UO32k7xz0OaaW2bIAmv7JHzJqwxSEHIQcNC0uhhtNFgJzf9NkGng4ZOEcQb2w==
X-Received: by 2002:a17:906:4a81:b0:a4a:3663:2f51 with SMTP id x1-20020a1709064a8100b00a4a36632f51mr1265585eju.2.1712323402070;
        Fri, 05 Apr 2024 06:23:22 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id dr2-20020a170907720200b00a4ea1fbb323sm822066ejc.98.2024.04.05.06.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 06:23:21 -0700 (PDT)
Date: Fri, 5 Apr 2024 15:23:20 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>, 
	Ajay Kaher <akaher@vmware.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Alexey Makhalov <amakhalov@vmware.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v5 22/22] KVM: riscv: selftests: Add a test for counter
 overflow
Message-ID: <20240405-3a20fe10d65368651c2d23fa@orel>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-23-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403080452.1007601-23-atishp@rivosinc.com>

On Wed, Apr 03, 2024 at 01:04:51AM -0700, Atish Patra wrote:
> Add a test for verifying overflow interrupt. Currently, it relies on
> overflow support on cycle/instret events. This test works for cycle/
> instret events which support sampling via hpmcounters on the platform.
> There are no ISA extensions to detect if a platform supports that. Thus,
> this test will fail on platform with virtualization but doesn't
> support overflow on these two events.

Maybe we should give the user a command line option to disable this test
in case the platform they're testing doesn't support it but they want to
run the rest of the tests without getting a FAIL.

> 
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  .../selftests/kvm/riscv/sbi_pmu_test.c        | 114 ++++++++++++++++++
>  1 file changed, 114 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
> index 7d195be5c3d9..451db956b885 100644
> --- a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
> +++ b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
> @@ -14,6 +14,7 @@
>  #include "test_util.h"
>  #include "processor.h"
>  #include "sbi.h"
> +#include "arch_timer.h"
>  
>  /* Maximum counters(firmware + hardware) */
>  #define RISCV_MAX_PMU_COUNTERS 64
> @@ -24,6 +25,9 @@ union sbi_pmu_ctr_info ctrinfo_arr[RISCV_MAX_PMU_COUNTERS];
>  static void *snapshot_gva;
>  static vm_paddr_t snapshot_gpa;
>  
> +static int vcpu_shared_irq_count;
> +static int counter_in_use;
> +
>  /* Cache the available counters in a bitmask */
>  static unsigned long counter_mask_available;
>  
> @@ -117,6 +121,31 @@ static void guest_illegal_exception_handler(struct ex_regs *regs)
>  	regs->epc += 4;
>  }
>  
> +static void guest_irq_handler(struct ex_regs *regs)
> +{
> +	unsigned int irq_num = regs->cause & ~CAUSE_IRQ_FLAG;
> +	struct riscv_pmu_snapshot_data *snapshot_data = snapshot_gva;
> +	unsigned long overflown_mask;
> +	unsigned long counter_val = 0;
> +
> +	/* Validate that we are in the correct irq handler */
> +	GUEST_ASSERT_EQ(irq_num, IRQ_PMU_OVF);
> +
> +	/* Stop all counters first to avoid further interrupts */
> +	stop_counter(counter_in_use, SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT);
> +
> +	csr_clear(CSR_SIP, BIT(IRQ_PMU_OVF));
> +
> +	overflown_mask = READ_ONCE(snapshot_data->ctr_overflow_mask);
> +	GUEST_ASSERT(overflown_mask & 0x01);
> +
> +	WRITE_ONCE(vcpu_shared_irq_count, vcpu_shared_irq_count+1);
> +
> +	counter_val = READ_ONCE(snapshot_data->ctr_values[0]);
> +	/* Now start the counter to mimick the real driver behavior */
> +	start_counter(counter_in_use, SBI_PMU_START_FLAG_SET_INIT_VALUE, counter_val);
> +}
> +
>  static unsigned long get_counter_index(unsigned long cbase, unsigned long cmask,
>  				       unsigned long cflags,
>  				       unsigned long event)
> @@ -276,6 +305,33 @@ static void test_pmu_event_snapshot(unsigned long event)
>  	stop_reset_counter(counter, 0);
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
> +	start_counter(counter, SBI_PMU_START_FLAG_INIT_SNAPSHOT, 0);
> +	dummy_func_loop(10000);
> +	udelay(msecs_to_usecs(2000));
> +	/* irq handler should have stopped the counter */
> +	stop_counter(counter, SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT);
> +
> +	counter_value_post = READ_ONCE(snapshot_data->ctr_values[0]);
> +	/* The counter value after stopping should be less the init value due to overflow */
> +	__GUEST_ASSERT(counter_value_post < counter_init_value,
> +		       "counter_value_post %lx counter_init_value %lx for counter\n",
> +		       counter_value_post, counter_init_value);
> +
> +	stop_reset_counter(counter, 0);
> +}
> +
>  static void test_invalid_event(void)
>  {
>  	struct sbiret ret;
> @@ -366,6 +422,34 @@ static void test_pmu_events_snaphost(void)
>  	GUEST_DONE();
>  }
>  
> +static void test_pmu_events_overflow(void)
> +{
> +	int num_counters = 0;
> +
> +	/* Verify presence of SBI PMU and minimum requrired SBI version */
> +	verify_sbi_requirement_assert();
> +
> +	snapshot_set_shmem(snapshot_gpa, 0);
> +	csr_set(CSR_IE, BIT(IRQ_PMU_OVF));
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
> +	test_pmu_event_overflow(SBI_PMU_HW_INSTRUCTIONS);
> +	GUEST_ASSERT_EQ(vcpu_shared_irq_count, 2);
> +
> +	GUEST_DONE();
> +}
> +
>  static void run_vcpu(struct kvm_vcpu *vcpu)
>  {
>  	struct ucall uc;
> @@ -451,6 +535,33 @@ static void test_vm_events_snapshot_test(void *guest_code)
>  	test_vm_destroy(vm);
>  }
>  
> +static void test_vm_events_overflow(void *guest_code)
> +{
> +	struct kvm_vm *vm = NULL;
> +	struct kvm_vcpu *vcpu;
> +
> +	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
> +	__TEST_REQUIRE(__vcpu_has_sbi_ext(vcpu, KVM_RISCV_SBI_EXT_PMU),
> +				   "SBI PMU not available, skipping test");
> +
> +	__TEST_REQUIRE(__vcpu_has_isa_ext(vcpu, KVM_RISCV_ISA_EXT_SSCOFPMF),
> +				   "Sscofpmf is not available, skipping overflow test");
> +
> +

extra blank line here

> +	test_vm_setup_snapshot_mem(vm, vcpu);
> +	vm_init_vector_tables(vm);
> +	vm_install_interrupt_handler(vm, guest_irq_handler);
> +
> +	vcpu_init_vector_tables(vcpu);
> +	/* Initialize guest timer frequency. */
> +	vcpu_get_reg(vcpu, RISCV_TIMER_REG(frequency), &timer_freq);
> +	sync_global_to_guest(vm, timer_freq);
> +
> +	run_vcpu(vcpu);
> +
> +	test_vm_destroy(vm);
> +}
> +
>  int main(void)
>  {
>  	pr_info("SBI PMU basic test : starting\n");
> @@ -463,5 +574,8 @@ int main(void)
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

Other than the command line option idea,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew

