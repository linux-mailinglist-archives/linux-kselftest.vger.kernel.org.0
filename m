Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249137A0033
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 11:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236069AbjINJgK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 05:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237120AbjINJgJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 05:36:09 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7987B1FC4
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Sep 2023 02:36:05 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-401c90ed2ecso8238665e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Sep 2023 02:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1694684164; x=1695288964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CCZCFnlZJGvjka4NILPiAYA/zskUo3Xn5QtdhyBtM2Y=;
        b=AcJvmQwi3DiafX1211Umn44N/d7w0rVh5dNQNABxd96VqhqbPSf9a0tOdg+NDNpwLw
         FKMZgXObaOPzMFXLeLHdqlZ05m5lciG6uY8qteIIL84MxfzJ17Zy2Gr1oAcVp3ngbvV3
         5EUuIlLdWdMh3j1ysceF+7E0QyfrRIgyjogVZEgMFI/53ntGu0cA7EHl0pg/YjFSH0tG
         Xj028RYkI1sVwhU9eW6WD4uppkBkt+ct+np36qtqAI7sCw3qjYY5MyGzCsfq4kBSZZVl
         wj2BhRP29r5uWEqPNcKyYxGhEQDz00HjChsVG2i/e1mk46MkLL7AZc040mD5j1pcWbC/
         qjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694684164; x=1695288964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCZCFnlZJGvjka4NILPiAYA/zskUo3Xn5QtdhyBtM2Y=;
        b=jS7dKPwoiVXrs9a2jVNYkekCS3Tx+Nj4vA1/TfAYlm54tGBYOT4YOiT9j9jzO4/AE1
         hrJI4pldHYKTjwBIImKl/qG+FVfAz7zs7FAfpUxmo0TTHAY5uUkUIHo+lJ1PIoHFraO3
         Zeizw9JZcbCu1+gKa8z+ZX6c1MXm+RC+xnrKGg2wFynqlhjeklujF7QUCITEiWTGdC/r
         IVBOVKWZaACEyDGnh9cjA2O5KqP6QwZcHQGJIKM/isstWPeg0zDgSnX8pbrvEOqLN26z
         Jy08JZlTKx0E/he7MA79ErDl7+9aLvkUBjScV51UUklBI0cWUS3USh7TEumQRGbKD56z
         qr2A==
X-Gm-Message-State: AOJu0YzxonIwjqn2giudP01OSJPJAg/XIQx4SU0dq+GpEcKhAUeeRiLv
        rkRDOZQumFoGIXd5NfPIKeYytA==
X-Google-Smtp-Source: AGHT+IEiIxzBcyLkmHLkrz7w2hqdJlTCFKJPIAZw8Hpyv1+O9WtgLsgm4Epy4ya7CqDQyGl8fHTsCA==
X-Received: by 2002:a1c:6a18:0:b0:3fe:5053:1a0b with SMTP id f24-20020a1c6a18000000b003fe50531a0bmr4400672wmc.11.1694684162891;
        Thu, 14 Sep 2023 02:36:02 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id w16-20020adfec50000000b003141a3c4353sm1252322wrn.30.2023.09.14.02.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 02:36:02 -0700 (PDT)
Date:   Thu, 14 Sep 2023 11:36:01 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Haibo Xu <haibo1.xu@intel.com>
Cc:     xiaobo55x@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Sean Christopherson <seanjc@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Vipin Sharma <vipinsh@google.com>,
        David Matlack <dmatlack@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Subject: Re: [PATCH v3 9/9] KVM: riscv: selftests: Add sstc timer test
Message-ID: <20230914-ee133dd5e804282ce28833d6@orel>
References: <cover.1694421911.git.haibo1.xu@intel.com>
 <64e0637cd6f22dd7557ed44bd2242001e7830d1c.1694421911.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64e0637cd6f22dd7557ed44bd2242001e7830d1c.1694421911.git.haibo1.xu@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 14, 2023 at 09:37:03AM +0800, Haibo Xu wrote:
> Add a KVM selftests to validate the Sstc timer functionality.
> The test was ported from arm64 arch timer test.
> 
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../selftests/kvm/aarch64/arch_timer.c        |  12 +-
>  tools/testing/selftests/kvm/arch_timer.c      |  10 +-
>  .../selftests/kvm/include/riscv/arch_timer.h  |  80 +++++++++++++
>  .../selftests/kvm/include/riscv/processor.h   |  10 ++
>  .../selftests/kvm/include/timer_test.h        |   3 +-
>  .../testing/selftests/kvm/riscv/arch_timer.c  | 107 ++++++++++++++++++
>  7 files changed, 214 insertions(+), 9 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/include/riscv/arch_timer.h
>  create mode 100644 tools/testing/selftests/kvm/riscv/arch_timer.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index a5bc8e156047..73d393a5f337 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -180,6 +180,7 @@ TEST_GEN_PROGS_s390x += rseq_test
>  TEST_GEN_PROGS_s390x += set_memory_region_test
>  TEST_GEN_PROGS_s390x += kvm_binary_stats_test
>  
> +TEST_GEN_PROGS_riscv += arch_timer
>  TEST_GEN_PROGS_riscv += demand_paging_test
>  TEST_GEN_PROGS_riscv += dirty_log_test
>  TEST_GEN_PROGS_riscv += guest_print_test
> diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/testing/selftests/kvm/aarch64/arch_timer.c
> index 4688b258247c..178f37737d33 100644
> --- a/tools/testing/selftests/kvm/aarch64/arch_timer.c
> +++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
> @@ -190,10 +190,14 @@ struct kvm_vm *test_vm_create(void)
>  	vm_init_vector_tables(vm);
>  	vm_install_exception_handler(vm, VECTOR_IRQ_CURRENT, guest_irq_handler);
>  
> -	if (!test_args.offset.reserved) {
> -		if (kvm_has_cap(KVM_CAP_COUNTER_OFFSET))
> -			vm_ioctl(vm, KVM_ARM_SET_COUNTER_OFFSET, &test_args.offset);
> -		else
> +	if (!test_args.reserved) {
> +		if (kvm_has_cap(KVM_CAP_COUNTER_OFFSET)) {
> +			struct kvm_arm_counter_offset offset = {
> +				.counter_offset = test_args.counter_offset,
> +				.reserved = 0,
> +			};
> +			vm_ioctl(vm, KVM_ARM_SET_COUNTER_OFFSET, &offset);
> +		} else
>  			TEST_FAIL("no support for global offset\n");
>  	}
>  
> diff --git a/tools/testing/selftests/kvm/arch_timer.c b/tools/testing/selftests/kvm/arch_timer.c
> index ea3dd1a772b0..184a0f5f484d 100644
> --- a/tools/testing/selftests/kvm/arch_timer.c
> +++ b/tools/testing/selftests/kvm/arch_timer.c
> @@ -33,7 +33,7 @@ struct test_args test_args = {
>  	.nr_iter = NR_TEST_ITERS_DEF,
>  	.timer_period_ms = TIMER_TEST_PERIOD_MS_DEF,
>  	.migration_freq_ms = TIMER_TEST_MIGRATION_FREQ_MS,
> -	.offset = { .reserved = 1 },
> +	.reserved = 1,
>  };
>  
>  struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
> @@ -72,6 +72,8 @@ static void *test_vcpu_run(void *arg)
>  		TEST_FAIL("Unexpected guest exit\n");
>  	}
>  
> +	pr_info("PASS(vCPU-%d).\n", vcpu_idx);
> +
>  	return NULL;
>  }
>  
> @@ -186,7 +188,7 @@ static void test_print_help(char *name)
>  		TIMER_TEST_PERIOD_MS_DEF);
>  	pr_info("\t-m: Frequency (in ms) of vCPUs to migrate to different pCPU. 0 to turn off (default: %u)\n",
>  		TIMER_TEST_MIGRATION_FREQ_MS);
> -	pr_info("\t-o: Counter offset (in counter cycles, default: 0)\n");
> +	pr_info("\t-o: Counter offset (in counter cycles, default: 0)[aarch64-only]\n");
                                                                     ^
								     need
						     		a space here

>  	pr_info("\t-h: print this help screen\n");
>  }
>  
> @@ -214,8 +216,8 @@ static bool parse_args(int argc, char *argv[])
>  			test_args.migration_freq_ms = atoi_non_negative("Frequency", optarg);
>  			break;
>  		case 'o':
> -			test_args.offset.counter_offset = strtol(optarg, NULL, 0);
> -			test_args.offset.reserved = 0;
> +			test_args.counter_offset = strtol(optarg, NULL, 0);
> +			test_args.reserved = 0;
>  			break;
>  		case 'h':
>  		default:
> diff --git a/tools/testing/selftests/kvm/include/riscv/arch_timer.h b/tools/testing/selftests/kvm/include/riscv/arch_timer.h
> new file mode 100644
> index 000000000000..5c063df13b98
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/riscv/arch_timer.h
> @@ -0,0 +1,80 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * RISC-V Arch Timer(sstc) specific interface
> + *
> + * Copyright (c) 2023 Intel Corporation
> + */
> +
> +#ifndef SELFTEST_KVM_ARCH_TIMER_H
> +#define SELFTEST_KVM_ARCH_TIMER_H
> +
> +#include <asm/csr.h>
> +
> +static unsigned long timer_freq;
> +
> +#define msec_to_cycles(msec)	\
> +	((timer_freq) * (uint64_t)(msec) / 1000)
> +
> +#define usec_to_cycles(usec)	\
> +	((timer_freq) * (uint64_t)(usec) / 1000000)
> +
> +#define cycles_to_usec(cycles) \
> +	((uint64_t)(cycles) * 1000000 / (timer_freq))
> +
> +static inline uint64_t timer_get_cycles(void)
> +{
> +	return csr_read(CSR_TIME);
> +}
> +
> +static inline void timer_set_cmp(uint64_t cval)
> +{
> +	csr_write(CSR_STIMECMP, cval);
> +}
> +
> +static inline uint64_t timer_get_cmp(void)
> +{
> +	return csr_read(CSR_STIMECMP);
> +}
> +
> +static inline void timer_irq_enable(void)
> +{
> +	csr_set(CSR_SIE, IE_TIE);
> +}
> +
> +static inline void timer_irq_disable(void)
> +{
> +	csr_clear(CSR_SIE, IE_TIE);
> +}
> +
> +static inline void timer_set_next_cmp_ms(uint32_t msec)
> +{
> +	uint64_t now_ct = timer_get_cycles();
> +	uint64_t next_ct = now_ct + msec_to_cycles(msec);
> +
> +	timer_set_cmp(next_ct);
> +}
> +
> +static inline void cpu_relax(void)
> +{
> +#ifdef __riscv_zihintpause
> +	asm volatile("pause" ::: "memory");
> +#else
> +	/* Encoding of the pause instruction */
> +	asm volatile(".4byte 0x100000F" ::: "memory");
> +#endif
> +}

cpu_relax() should go to include/riscv/processor.h

> +
> +static inline void __delay(uint64_t cycles)
> +{
> +	uint64_t start = timer_get_cycles();
> +
> +	while ((timer_get_cycles() - start) < cycles)
> +		cpu_relax();
> +}
> +
> +static inline void udelay(unsigned long usec)
> +{
> +	__delay(usec_to_cycles(usec));
> +}
> +
> +#endif /* SELFTEST_KVM_ARCH_TIMER_H */
> diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
> index 7d5517648ea7..268c549f87cf 100644
> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> @@ -158,4 +158,14 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
>  			unsigned long arg3, unsigned long arg4,
>  			unsigned long arg5);
>  
> +static inline void local_irq_enable(void)
> +{
> +	csr_set(CSR_SSTATUS, SR_SIE);
> +}
> +
> +static inline void local_irq_disable(void)
> +{
> +	csr_clear(CSR_SSTATUS, SR_SIE);
> +}
> +
>  #endif /* SELFTEST_KVM_PROCESSOR_H */
> diff --git a/tools/testing/selftests/kvm/include/timer_test.h b/tools/testing/selftests/kvm/include/timer_test.h
> index 04e8aff2dc22..00b455235b82 100644
> --- a/tools/testing/selftests/kvm/include/timer_test.h
> +++ b/tools/testing/selftests/kvm/include/timer_test.h
> @@ -22,7 +22,8 @@ struct test_args {
>  	int nr_iter;
>  	int timer_period_ms;
>  	int migration_freq_ms;
> -	struct kvm_arm_counter_offset offset;
> +	uint64_t counter_offset;
> +	uint64_t reserved;

These need a comment above them explaining that they are the members of
struct kvm_arm_counter_offset or they can be renamed with arm_ prefixes.

>  };
>  
>  /* Shared variables between host and guest */
> diff --git a/tools/testing/selftests/kvm/riscv/arch_timer.c b/tools/testing/selftests/kvm/riscv/arch_timer.c
> new file mode 100644
> index 000000000000..13bf184d1ff5
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/riscv/arch_timer.c
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * arch_timer.c - Tests the riscv64 sstc timer IRQ functionality
> + *
> + * The test validates the sstc timer IRQs using vstimecmp registers.
> + * It's ported from the aarch64 arch_timer test.
> + *
> + * Copyright (c) 2023, Intel Corporation.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include "arch_timer.h"
> +#include "kvm_util.h"
> +#include "processor.h"
> +#include "timer_test.h"
> +
> +static int timer_irq = IRQ_S_TIMER;
> +
> +static void guest_irq_handler(struct ex_regs *regs)
> +{
> +	uint64_t xcnt, xcnt_diff_us, cmp;
> +	unsigned int intid = regs->cause & ~CAUSE_IRQ_FLAG;
> +	uint32_t cpu = guest_get_vcpuid();
> +	struct test_vcpu_shared_data *shared_data = &vcpu_shared_data[cpu];
> +
> +	timer_irq_disable();
> +
> +	xcnt = timer_get_cycles();
> +	cmp = timer_get_cmp();
> +	xcnt_diff_us = cycles_to_usec(xcnt - shared_data->xcnt);
> +
> +	/* Make sure we are dealing with the correct timer IRQ */
> +	GUEST_ASSERT_EQ(intid, timer_irq);
> +
> +	__GUEST_ASSERT(xcnt >= cmp,
> +			"xcnt = 0x%llx, cmp = 0x%llx, xcnt_diff_us = 0x%llx",
> +			xcnt, cmp, xcnt_diff_us);
> +
> +	WRITE_ONCE(shared_data->nr_iter, shared_data->nr_iter + 1);
> +}
> +
> +static void guest_run(struct test_vcpu_shared_data *shared_data)
> +{
> +	uint32_t irq_iter, config_iter;
> +
> +	shared_data->nr_iter = 0;
> +	shared_data->guest_stage = 0;
> +
> +	for (config_iter = 0; config_iter < test_args.nr_iter; config_iter++) {
> +		/* Setup the next interrupt */
> +		timer_set_next_cmp_ms(test_args.timer_period_ms);
> +		shared_data->xcnt = timer_get_cycles();
> +		timer_irq_enable();
> +
> +		/* Setup a timeout for the interrupt to arrive */
> +		udelay(msecs_to_usecs(test_args.timer_period_ms) +
> +			TIMER_TEST_ERR_MARGIN_US);
> +
> +		irq_iter = READ_ONCE(shared_data->nr_iter);
> +		GUEST_ASSERT_EQ(config_iter + 1, irq_iter);
> +	}
> +}
> +
> +static void guest_code(void)
> +{
> +	uint32_t cpu = guest_get_vcpuid();
> +	struct test_vcpu_shared_data *shared_data = &vcpu_shared_data[cpu];
> +
> +	timer_irq_disable();
> +	local_irq_enable();
> +
> +	guest_run(shared_data);
> +
> +	GUEST_DONE();
> +}
> +
> +struct kvm_vm *test_vm_create(void)
> +{
> +	struct kvm_vm *vm;
> +	int nr_vcpus = test_args.nr_vcpus;
> +
> +	vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
> +	__TEST_REQUIRE(__vcpu_has_ext(vcpus[0], KVM_RISCV_ISA_EXT_SSTC),
> +				   "SSTC not available, skipping test\n");
> +
> +	vm_init_vector_tables(vm);
> +	vm_install_interrupt_handler(vm, guest_irq_handler);
> +
> +	for (int i = 0; i < nr_vcpus; i++)
> +		vcpu_init_vector_tables(vcpus[i]);
> +
> +	/* Initialize guest timer frequency. */
> +	vcpu_get_reg(vcpus[0], RISCV_TIMER_REG(frequency), &timer_freq);
> +	sync_global_to_guest(vm, timer_freq);
> +	pr_debug("timer_freq: %lu\n", timer_freq);
> +
> +	/* Make all the test's cmdline args visible to the guest */
> +	sync_global_to_guest(vm, test_args);
> +
> +	return vm;
> +}
> +
> +void test_vm_cleanup(struct kvm_vm *vm)
> +{
> +	kvm_vm_free(vm);
> +}
> -- 
> 2.34.1
>

Besides the three minor comments, this looks good to me.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
