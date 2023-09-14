Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF12679FEA2
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 10:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbjINInW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 04:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjINInV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 04:43:21 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5098106
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Sep 2023 01:43:16 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40473f1fe9fso1847435e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Sep 2023 01:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1694680995; x=1695285795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KMS+MJKGdnNO0UsMv29klbKRBKRho0UWtG/KudVElHw=;
        b=K/xXxo8RflSqYBCaleIzeqgmlDzIJTehK/NRpGSRd5FjMwi+dWdvokNtQUV3LqMrGa
         x84bFEFffHpCm5cJcwbC1ZzaK+WcZDxLjlNYCAaaahKZzx8Lerhrtra7MIBAA9N9u01P
         AN/3UQQutQxb+SDgrCPtiIrGcL9Ta8s8/LFKysLh4s4StWtFgbvL1e08dkXhnL31IsD3
         2MgBtdEuTa89DpZmrIk4BpjnHlmFB3eMAEUD00A7pQ79C7w5FPgg7rPCXPJAKBTQ6gWq
         ZPP2Ee3V4Ini2oAFTM7ysAB1Bis6KQC9ZKuyZOl2nB6/2B28VkJLAaKaCTp73IK+VbjU
         3aYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694680995; x=1695285795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMS+MJKGdnNO0UsMv29klbKRBKRho0UWtG/KudVElHw=;
        b=Tdhlf7Jtwh1AzCBXVr8tLpSIpVZkYwl3AD2OOtLvgsr+Rb525qaWNgmOCM/ELCfm00
         GBol6XutO/ULrguAVcUlFLQSW7Bzzfjp0Toc/3w6I8eiskLMaP6tid5E18pBRPtQIEXq
         sBOYpUd5ICNYzQAWsw9RoijESaXjAitHby3NaBFkTBtOiwo37g4YxCY9V88NamAiSXLN
         dPzQ1mlHnb78CcoYzEBIsFRQa5BBhDLCEUOw7ziwJKry+tGkWf0psHtagR/V6pE59ntf
         0sA5tYAI7eGalZBJmmBnXJ+FiTdNNAZphf88ySxwdfrHZmcmZPFQ0AVXKW+8MT7abKDl
         yt4w==
X-Gm-Message-State: AOJu0Yxnd9DK4pk/qC77dvf1DIXcoeE2tisZGmzJG7vC66pBEGIR0iY0
        TySwAnHt6bIP8JBJgWCo+q+xpQ==
X-Google-Smtp-Source: AGHT+IEwR7yEvqxHeQhojBJArT9VyZFsvYPMxHz39kcYusFW9lolluB+9cF7umQtY47xn7AIbUQh6w==
X-Received: by 2002:a7b:c7d5:0:b0:401:4542:5edd with SMTP id z21-20020a7bc7d5000000b0040145425eddmr4003943wmk.34.1694680995079;
        Thu, 14 Sep 2023 01:43:15 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c020700b003fe2de3f94fsm1331500wmi.12.2023.09.14.01.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 01:43:14 -0700 (PDT)
Date:   Thu, 14 Sep 2023 10:43:08 +0200
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
        David Matlack <dmatlack@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Thomas Huth <thuth@redhat.com>,
        Colton Lewis <coltonlewis@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Subject: Re: [PATCH v3 3/9] KVM: arm64: selftests: Split arch_timer test code
Message-ID: <20230914-5827d3a3a5269d480c5c2d50@orel>
References: <cover.1694421911.git.haibo1.xu@intel.com>
 <66f81991b15de608c43c96c911387cf0ee0a49b1.1694421911.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66f81991b15de608c43c96c911387cf0ee0a49b1.1694421911.git.haibo1.xu@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 14, 2023 at 09:36:57AM +0800, Haibo Xu wrote:
> Split the arch-neutral test code out of aarch64/arch_timer.c
> and put them into a common arch_timer.c. This is a preparation
> to share timer test codes in riscv.
> 
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  tools/testing/selftests/kvm/Makefile          |   3 +-
>  .../selftests/kvm/aarch64/arch_timer.c        | 275 +-----------------
>  tools/testing/selftests/kvm/arch_timer.c      | 248 ++++++++++++++++
>  .../testing/selftests/kvm/include/test_util.h |   2 +
>  .../selftests/kvm/include/timer_test.h        |  42 +++
>  5 files changed, 300 insertions(+), 270 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/arch_timer.c
>  create mode 100644 tools/testing/selftests/kvm/include/timer_test.h
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 7972269e8c5f..0102a0297b84 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -140,7 +140,6 @@ TEST_GEN_PROGS_x86_64 += system_counter_offset_test
>  TEST_GEN_PROGS_EXTENDED_x86_64 += x86_64/nx_huge_pages_test
>  
>  TEST_GEN_PROGS_aarch64 += aarch64/aarch32_id_regs
> -TEST_GEN_PROGS_aarch64 += aarch64/arch_timer
>  TEST_GEN_PROGS_aarch64 += aarch64/debug-exceptions
>  TEST_GEN_PROGS_aarch64 += aarch64/hypercalls
>  TEST_GEN_PROGS_aarch64 += aarch64/page_fault_test
> @@ -150,6 +149,7 @@ TEST_GEN_PROGS_aarch64 += aarch64/vcpu_width_config
>  TEST_GEN_PROGS_aarch64 += aarch64/vgic_init
>  TEST_GEN_PROGS_aarch64 += aarch64/vgic_irq
>  TEST_GEN_PROGS_aarch64 += access_tracking_perf_test
> +TEST_GEN_PROGS_aarch64 += arch_timer
>  TEST_GEN_PROGS_aarch64 += demand_paging_test
>  TEST_GEN_PROGS_aarch64 += dirty_log_test
>  TEST_GEN_PROGS_aarch64 += dirty_log_perf_test
> @@ -188,6 +188,7 @@ TEST_GEN_PROGS_riscv += kvm_page_table_test
>  TEST_GEN_PROGS_riscv += set_memory_region_test
>  TEST_GEN_PROGS_riscv += kvm_binary_stats_test
>  
> +SPLIT_TESTS += arch_timer
>  SPLIT_TESTS += get-reg-list
>  
>  TEST_PROGS += $(TEST_PROGS_$(ARCH_DIR))
> diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/testing/selftests/kvm/aarch64/arch_timer.c
> index b63859829a96..4688b258247c 100644
> --- a/tools/testing/selftests/kvm/aarch64/arch_timer.c
> +++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
> @@ -1,64 +1,19 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * arch_timer.c - Tests the aarch64 timer IRQ functionality
> - *
>   * The test validates both the virtual and physical timer IRQs using
> - * CVAL and TVAL registers. This consitutes the four stages in the test.
> - * The guest's main thread configures the timer interrupt for a stage
> - * and waits for it to fire, with a timeout equal to the timer period.
> - * It asserts that the timeout doesn't exceed the timer period.
> - *
> - * On the other hand, upon receipt of an interrupt, the guest's interrupt
> - * handler validates the interrupt by checking if the architectural state
> - * is in compliance with the specifications.
> - *
> - * The test provides command-line options to configure the timer's
> - * period (-p), number of vCPUs (-n), and iterations per stage (-i).
> - * To stress-test the timer stack even more, an option to migrate the
> - * vCPUs across pCPUs (-m), at a particular rate, is also provided.
> + * CVAL and TVAL registers.
>   *
>   * Copyright (c) 2021, Google LLC.
>   */
>  #define _GNU_SOURCE
>  
> -#include <stdlib.h>
> -#include <pthread.h>
> -#include <linux/kvm.h>
> -#include <linux/sizes.h>
> -#include <linux/bitmap.h>
> -#include <sys/sysinfo.h>
> -
> -#include "kvm_util.h"
> -#include "processor.h"
> -#include "delay.h"
>  #include "arch_timer.h"
> +#include "delay.h"
>  #include "gic.h"
> +#include "processor.h"
> +#include "timer_test.h"
>  #include "vgic.h"
>  
> -#define NR_VCPUS_DEF			4
> -#define NR_TEST_ITERS_DEF		5
> -#define TIMER_TEST_PERIOD_MS_DEF	10
> -#define TIMER_TEST_ERR_MARGIN_US	100
> -#define TIMER_TEST_MIGRATION_FREQ_MS	2
> -
> -struct test_args {
> -	int nr_vcpus;
> -	int nr_iter;
> -	int timer_period_ms;
> -	int migration_freq_ms;
> -	struct kvm_arm_counter_offset offset;
> -};
> -
> -static struct test_args test_args = {
> -	.nr_vcpus = NR_VCPUS_DEF,
> -	.nr_iter = NR_TEST_ITERS_DEF,
> -	.timer_period_ms = TIMER_TEST_PERIOD_MS_DEF,
> -	.migration_freq_ms = TIMER_TEST_MIGRATION_FREQ_MS,
> -	.offset = { .reserved = 1 },
> -};
> -
> -#define msecs_to_usecs(msec)		((msec) * 1000LL)
> -
>  #define GICD_BASE_GPA			0x8000000ULL
>  #define GICR_BASE_GPA			0x80A0000ULL
>  
> @@ -70,22 +25,8 @@ enum guest_stage {
>  	GUEST_STAGE_MAX,
>  };
>  
> -/* Shared variables between host and guest */
> -struct test_vcpu_shared_data {
> -	int nr_iter;
> -	enum guest_stage guest_stage;
> -	uint64_t xcnt;
> -};
> -
> -static struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
> -static pthread_t pt_vcpu_run[KVM_MAX_VCPUS];
> -static struct test_vcpu_shared_data vcpu_shared_data[KVM_MAX_VCPUS];
> -
>  static int vtimer_irq, ptimer_irq;
>  
> -static unsigned long *vcpu_done_map;
> -static pthread_mutex_t vcpu_done_map_lock;
> -
>  static void
>  guest_configure_timer_action(struct test_vcpu_shared_data *shared_data)
>  {
> @@ -222,137 +163,6 @@ static void guest_code(void)
>  	GUEST_DONE();
>  }
>  
> -static void *test_vcpu_run(void *arg)
> -{
> -	unsigned int vcpu_idx = (unsigned long)arg;
> -	struct ucall uc;
> -	struct kvm_vcpu *vcpu = vcpus[vcpu_idx];
> -	struct kvm_vm *vm = vcpu->vm;
> -	struct test_vcpu_shared_data *shared_data = &vcpu_shared_data[vcpu_idx];
> -
> -	vcpu_run(vcpu);
> -
> -	/* Currently, any exit from guest is an indication of completion */
> -	pthread_mutex_lock(&vcpu_done_map_lock);
> -	__set_bit(vcpu_idx, vcpu_done_map);
> -	pthread_mutex_unlock(&vcpu_done_map_lock);
> -
> -	switch (get_ucall(vcpu, &uc)) {
> -	case UCALL_SYNC:
> -	case UCALL_DONE:
> -		break;
> -	case UCALL_ABORT:
> -		sync_global_from_guest(vm, *shared_data);
> -		fprintf(stderr, "Guest assert failed,  vcpu %u; stage; %u; iter: %u\n",
> -			vcpu_idx, shared_data->guest_stage, shared_data->nr_iter);
> -		REPORT_GUEST_ASSERT(uc);
> -		break;
> -	default:
> -		TEST_FAIL("Unexpected guest exit\n");
> -	}
> -
> -	return NULL;
> -}
> -
> -static uint32_t test_get_pcpu(void)
> -{
> -	uint32_t pcpu;
> -	unsigned int nproc_conf;
> -	cpu_set_t online_cpuset;
> -
> -	nproc_conf = get_nprocs_conf();
> -	sched_getaffinity(0, sizeof(cpu_set_t), &online_cpuset);
> -
> -	/* Randomly find an available pCPU to place a vCPU on */
> -	do {
> -		pcpu = rand() % nproc_conf;
> -	} while (!CPU_ISSET(pcpu, &online_cpuset));
> -
> -	return pcpu;
> -}
> -
> -static int test_migrate_vcpu(unsigned int vcpu_idx)
> -{
> -	int ret;
> -	cpu_set_t cpuset;
> -	uint32_t new_pcpu = test_get_pcpu();
> -
> -	CPU_ZERO(&cpuset);
> -	CPU_SET(new_pcpu, &cpuset);
> -
> -	pr_debug("Migrating vCPU: %u to pCPU: %u\n", vcpu_idx, new_pcpu);
> -
> -	ret = pthread_setaffinity_np(pt_vcpu_run[vcpu_idx],
> -				     sizeof(cpuset), &cpuset);
> -
> -	/* Allow the error where the vCPU thread is already finished */
> -	TEST_ASSERT(ret == 0 || ret == ESRCH,
> -		    "Failed to migrate the vCPU:%u to pCPU: %u; ret: %d\n",
> -		    vcpu_idx, new_pcpu, ret);
> -
> -	return ret;
> -}
> -
> -static void *test_vcpu_migration(void *arg)
> -{
> -	unsigned int i, n_done;
> -	bool vcpu_done;
> -
> -	do {
> -		usleep(msecs_to_usecs(test_args.migration_freq_ms));
> -
> -		for (n_done = 0, i = 0; i < test_args.nr_vcpus; i++) {
> -			pthread_mutex_lock(&vcpu_done_map_lock);
> -			vcpu_done = test_bit(i, vcpu_done_map);
> -			pthread_mutex_unlock(&vcpu_done_map_lock);
> -
> -			if (vcpu_done) {
> -				n_done++;
> -				continue;
> -			}
> -
> -			test_migrate_vcpu(i);
> -		}
> -	} while (test_args.nr_vcpus != n_done);
> -
> -	return NULL;
> -}
> -
> -static void test_run(struct kvm_vm *vm)
> -{
> -	pthread_t pt_vcpu_migration;
> -	unsigned int i;
> -	int ret;
> -
> -	pthread_mutex_init(&vcpu_done_map_lock, NULL);
> -	vcpu_done_map = bitmap_zalloc(test_args.nr_vcpus);
> -	TEST_ASSERT(vcpu_done_map, "Failed to allocate vcpu done bitmap\n");
> -
> -	for (i = 0; i < (unsigned long)test_args.nr_vcpus; i++) {
> -		ret = pthread_create(&pt_vcpu_run[i], NULL, test_vcpu_run,
> -				     (void *)(unsigned long)i);
> -		TEST_ASSERT(!ret, "Failed to create vCPU-%d pthread\n", i);
> -	}
> -
> -	/* Spawn a thread to control the vCPU migrations */
> -	if (test_args.migration_freq_ms) {
> -		srand(time(NULL));
> -
> -		ret = pthread_create(&pt_vcpu_migration, NULL,
> -					test_vcpu_migration, NULL);
> -		TEST_ASSERT(!ret, "Failed to create the migration pthread\n");
> -	}
> -
> -
> -	for (i = 0; i < test_args.nr_vcpus; i++)
> -		pthread_join(pt_vcpu_run[i], NULL);
> -
> -	if (test_args.migration_freq_ms)
> -		pthread_join(pt_vcpu_migration, NULL);
> -
> -	bitmap_free(vcpu_done_map);
> -}
> -
>  static void test_init_timer_irq(struct kvm_vm *vm)
>  {
>  	/* Timer initid should be same for all the vCPUs, so query only vCPU-0 */
> @@ -369,7 +179,7 @@ static void test_init_timer_irq(struct kvm_vm *vm)
>  
>  static int gic_fd;
>  
> -static struct kvm_vm *test_vm_create(void)
> +struct kvm_vm *test_vm_create(void)
>  {
>  	struct kvm_vm *vm;
>  	unsigned int i;
> @@ -400,81 +210,8 @@ static struct kvm_vm *test_vm_create(void)
>  	return vm;
>  }
>  
> -static void test_vm_cleanup(struct kvm_vm *vm)
> +void test_vm_cleanup(struct kvm_vm *vm)
>  {
>  	close(gic_fd);
>  	kvm_vm_free(vm);
>  }
> -
> -static void test_print_help(char *name)
> -{
> -	pr_info("Usage: %s [-h] [-n nr_vcpus] [-i iterations] [-p timer_period_ms]\n",
> -		name);
> -	pr_info("\t-n: Number of vCPUs to configure (default: %u; max: %u)\n",
> -		NR_VCPUS_DEF, KVM_MAX_VCPUS);
> -	pr_info("\t-i: Number of iterations per stage (default: %u)\n",
> -		NR_TEST_ITERS_DEF);
> -	pr_info("\t-p: Periodicity (in ms) of the guest timer (default: %u)\n",
> -		TIMER_TEST_PERIOD_MS_DEF);
> -	pr_info("\t-m: Frequency (in ms) of vCPUs to migrate to different pCPU. 0 to turn off (default: %u)\n",
> -		TIMER_TEST_MIGRATION_FREQ_MS);
> -	pr_info("\t-o: Counter offset (in counter cycles, default: 0)\n");
> -	pr_info("\t-h: print this help screen\n");
> -}
> -
> -static bool parse_args(int argc, char *argv[])
> -{
> -	int opt;
> -
> -	while ((opt = getopt(argc, argv, "hn:i:p:m:o:")) != -1) {
> -		switch (opt) {
> -		case 'n':
> -			test_args.nr_vcpus = atoi_positive("Number of vCPUs", optarg);
> -			if (test_args.nr_vcpus > KVM_MAX_VCPUS) {
> -				pr_info("Max allowed vCPUs: %u\n",
> -					KVM_MAX_VCPUS);
> -				goto err;
> -			}
> -			break;
> -		case 'i':
> -			test_args.nr_iter = atoi_positive("Number of iterations", optarg);
> -			break;
> -		case 'p':
> -			test_args.timer_period_ms = atoi_positive("Periodicity", optarg);
> -			break;
> -		case 'm':
> -			test_args.migration_freq_ms = atoi_non_negative("Frequency", optarg);
> -			break;
> -		case 'o':
> -			test_args.offset.counter_offset = strtol(optarg, NULL, 0);
> -			test_args.offset.reserved = 0;
> -			break;
> -		case 'h':
> -		default:
> -			goto err;
> -		}
> -	}
> -
> -	return true;
> -
> -err:
> -	test_print_help(argv[0]);
> -	return false;
> -}
> -
> -int main(int argc, char *argv[])
> -{
> -	struct kvm_vm *vm;
> -
> -	if (!parse_args(argc, argv))
> -		exit(KSFT_SKIP);
> -
> -	__TEST_REQUIRE(!test_args.migration_freq_ms || get_nprocs() >= 2,
> -		       "At least two physical CPUs needed for vCPU migration");
> -
> -	vm = test_vm_create();
> -	test_run(vm);
> -	test_vm_cleanup(vm);
> -
> -	return 0;
> -}
> diff --git a/tools/testing/selftests/kvm/arch_timer.c b/tools/testing/selftests/kvm/arch_timer.c
> new file mode 100644
> index 000000000000..ea3dd1a772b0
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/arch_timer.c
> @@ -0,0 +1,248 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * arch_timer.c - Tests the arch timer IRQ functionality
> + *
> + * The guest's main thread configures the timer interrupt and waits
> + * for it to fire, with a timeout equal to the timer period.
> + * It asserts that the timeout doesn't exceed the timer period.

While this text is a faithful port of the original, I think we should
change it to "...exceed the timer period plus an error margin of 100 us.

(And maybe we should allow that error margin to be configured. But
making it configurable should be done in separate patches either before
or after the splitting of the test. I'm OK with leaving it
non-configurable for now. We can change it later if we want to.)

> + *
> + * On the other hand, upon receipt of an interrupt, the guest's interrupt
> + * handler validates the interrupt by checking if the architectural state
> + * is in compliance with the specifications.
> + *
> + * The test provides command-line options to configure the timer's
> + * period (-p), number of vCPUs (-n), and iterations per stage (-i).
> + * To stress-test the timer stack even more, an option to migrate the
> + * vCPUs across pCPUs (-m), at a particular rate, is also provided.
> + *
> + * Copyright (c) 2021, Google LLC.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <stdlib.h>
> +#include <pthread.h>
> +#include <linux/sizes.h>
> +#include <linux/bitmap.h>
> +#include <sys/sysinfo.h>
> +
> +#include "timer_test.h"
> +
> +struct test_args test_args = {
> +	.nr_vcpus = NR_VCPUS_DEF,
> +	.nr_iter = NR_TEST_ITERS_DEF,
> +	.timer_period_ms = TIMER_TEST_PERIOD_MS_DEF,
> +	.migration_freq_ms = TIMER_TEST_MIGRATION_FREQ_MS,
> +	.offset = { .reserved = 1 },
> +};
> +
> +struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
> +struct test_vcpu_shared_data vcpu_shared_data[KVM_MAX_VCPUS];
> +
> +static pthread_t pt_vcpu_run[KVM_MAX_VCPUS];
> +static unsigned long *vcpu_done_map;
> +static pthread_mutex_t vcpu_done_map_lock;
> +
> +static void *test_vcpu_run(void *arg)
> +{
> +	unsigned int vcpu_idx = (unsigned long)arg;
> +	struct ucall uc;
> +	struct kvm_vcpu *vcpu = vcpus[vcpu_idx];
> +	struct kvm_vm *vm = vcpu->vm;
> +	struct test_vcpu_shared_data *shared_data = &vcpu_shared_data[vcpu_idx];
> +
> +	vcpu_run(vcpu);
> +
> +	/* Currently, any exit from guest is an indication of completion */
> +	pthread_mutex_lock(&vcpu_done_map_lock);
> +	__set_bit(vcpu_idx, vcpu_done_map);
> +	pthread_mutex_unlock(&vcpu_done_map_lock);
> +
> +	switch (get_ucall(vcpu, &uc)) {
> +	case UCALL_SYNC:
> +	case UCALL_DONE:
> +		break;
> +	case UCALL_ABORT:
> +		sync_global_from_guest(vm, *shared_data);
> +		fprintf(stderr, "Guest assert failed,  vcpu %u; stage; %u; iter: %u\n",
> +			vcpu_idx, shared_data->guest_stage, shared_data->nr_iter);
> +		REPORT_GUEST_ASSERT(uc);
> +		break;
> +	default:
> +		TEST_FAIL("Unexpected guest exit\n");
> +	}
> +
> +	return NULL;
> +}
> +
> +static uint32_t test_get_pcpu(void)
> +{
> +	uint32_t pcpu;
> +	unsigned int nproc_conf;
> +	cpu_set_t online_cpuset;
> +
> +	nproc_conf = get_nprocs_conf();
> +	sched_getaffinity(0, sizeof(cpu_set_t), &online_cpuset);
> +
> +	/* Randomly find an available pCPU to place a vCPU on */
> +	do {
> +		pcpu = rand() % nproc_conf;
> +	} while (!CPU_ISSET(pcpu, &online_cpuset));
> +
> +	return pcpu;
> +}
> +
> +static int test_migrate_vcpu(unsigned int vcpu_idx)
> +{
> +	int ret;
> +	cpu_set_t cpuset;
> +	uint32_t new_pcpu = test_get_pcpu();
> +
> +	CPU_ZERO(&cpuset);
> +	CPU_SET(new_pcpu, &cpuset);
> +
> +	pr_debug("Migrating vCPU: %u to pCPU: %u\n", vcpu_idx, new_pcpu);
> +
> +	ret = pthread_setaffinity_np(pt_vcpu_run[vcpu_idx],
> +				     sizeof(cpuset), &cpuset);
> +
> +	/* Allow the error where the vCPU thread is already finished */
> +	TEST_ASSERT(ret == 0 || ret == ESRCH,
> +		    "Failed to migrate the vCPU:%u to pCPU: %u; ret: %d\n",
> +		    vcpu_idx, new_pcpu, ret);
> +
> +	return ret;
> +}
> +
> +static void *test_vcpu_migration(void *arg)
> +{
> +	unsigned int i, n_done;
> +	bool vcpu_done;
> +
> +	do {
> +		usleep(msecs_to_usecs(test_args.migration_freq_ms));
> +
> +		for (n_done = 0, i = 0; i < test_args.nr_vcpus; i++) {
> +			pthread_mutex_lock(&vcpu_done_map_lock);
> +			vcpu_done = test_bit(i, vcpu_done_map);
> +			pthread_mutex_unlock(&vcpu_done_map_lock);
> +
> +			if (vcpu_done) {
> +				n_done++;
> +				continue;
> +			}
> +
> +			test_migrate_vcpu(i);
> +		}
> +	} while (test_args.nr_vcpus != n_done);
> +
> +	return NULL;
> +}
> +
> +static void test_run(struct kvm_vm *vm)
> +{
> +	pthread_t pt_vcpu_migration;
> +	unsigned int i;
> +	int ret;
> +
> +	pthread_mutex_init(&vcpu_done_map_lock, NULL);
> +	vcpu_done_map = bitmap_zalloc(test_args.nr_vcpus);
> +	TEST_ASSERT(vcpu_done_map, "Failed to allocate vcpu done bitmap\n");
> +
> +	for (i = 0; i < (unsigned long)test_args.nr_vcpus; i++) {
> +		ret = pthread_create(&pt_vcpu_run[i], NULL, test_vcpu_run,
> +				     (void *)(unsigned long)i);
> +		TEST_ASSERT(!ret, "Failed to create vCPU-%d pthread\n", i);
> +	}
> +
> +	/* Spawn a thread to control the vCPU migrations */
> +	if (test_args.migration_freq_ms) {
> +		srand(time(NULL));
> +
> +		ret = pthread_create(&pt_vcpu_migration, NULL,
> +					test_vcpu_migration, NULL);
> +		TEST_ASSERT(!ret, "Failed to create the migration pthread\n");
> +	}
> +
> +
> +	for (i = 0; i < test_args.nr_vcpus; i++)
> +		pthread_join(pt_vcpu_run[i], NULL);
> +
> +	if (test_args.migration_freq_ms)
> +		pthread_join(pt_vcpu_migration, NULL);
> +
> +	bitmap_free(vcpu_done_map);
> +}
> +
> +static void test_print_help(char *name)
> +{
> +	pr_info("Usage: %s [-h] [-n nr_vcpus] [-i iterations] [-p timer_period_ms]\n",
> +		name);
> +	pr_info("\t-n: Number of vCPUs to configure (default: %u; max: %u)\n",
> +		NR_VCPUS_DEF, KVM_MAX_VCPUS);
> +	pr_info("\t-i: Number of iterations per stage (default: %u)\n",
> +		NR_TEST_ITERS_DEF);
> +	pr_info("\t-p: Periodicity (in ms) of the guest timer (default: %u)\n",
> +		TIMER_TEST_PERIOD_MS_DEF);
> +	pr_info("\t-m: Frequency (in ms) of vCPUs to migrate to different pCPU. 0 to turn off (default: %u)\n",
> +		TIMER_TEST_MIGRATION_FREQ_MS);
> +	pr_info("\t-o: Counter offset (in counter cycles, default: 0)\n");
> +	pr_info("\t-h: print this help screen\n");
> +}
> +
> +static bool parse_args(int argc, char *argv[])
> +{
> +	int opt;
> +
> +	while ((opt = getopt(argc, argv, "hn:i:p:m:o:")) != -1) {
> +		switch (opt) {
> +		case 'n':
> +			test_args.nr_vcpus = atoi_positive("Number of vCPUs", optarg);
> +			if (test_args.nr_vcpus > KVM_MAX_VCPUS) {
> +				pr_info("Max allowed vCPUs: %u\n",
> +					KVM_MAX_VCPUS);
> +				goto err;
> +			}
> +			break;
> +		case 'i':
> +			test_args.nr_iter = atoi_positive("Number of iterations", optarg);
> +			break;
> +		case 'p':
> +			test_args.timer_period_ms = atoi_positive("Periodicity", optarg);
> +			break;
> +		case 'm':
> +			test_args.migration_freq_ms = atoi_non_negative("Frequency", optarg);
> +			break;
> +		case 'o':
> +			test_args.offset.counter_offset = strtol(optarg, NULL, 0);
> +			test_args.offset.reserved = 0;
> +			break;
> +		case 'h':
> +		default:
> +			goto err;
> +		}
> +	}
> +
> +	return true;
> +
> +err:
> +	test_print_help(argv[0]);
> +	return false;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	struct kvm_vm *vm;
> +
> +	if (!parse_args(argc, argv))
> +		exit(KSFT_SKIP);
> +
> +	__TEST_REQUIRE(!test_args.migration_freq_ms || get_nprocs() >= 2,
> +		       "At least two physical CPUs needed for vCPU migration");
> +
> +	vm = test_vm_create();
> +	test_run(vm);
> +	test_vm_cleanup(vm);
> +
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
> index 7e614adc6cf4..c019675f6259 100644
> --- a/tools/testing/selftests/kvm/include/test_util.h
> +++ b/tools/testing/selftests/kvm/include/test_util.h
> @@ -20,6 +20,8 @@
>  #include <sys/mman.h>
>  #include "kselftest.h"
>  
> +#define msecs_to_usecs(msec)    ((msec) * 1000LL)
> +
>  static inline int _no_printf(const char *format, ...) { return 0; }
>  
>  #ifdef DEBUG
> diff --git a/tools/testing/selftests/kvm/include/timer_test.h b/tools/testing/selftests/kvm/include/timer_test.h
> new file mode 100644
> index 000000000000..04e8aff2dc22
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/timer_test.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * timer test specific header
> + *
> + * Copyright (C) 2018, Google LLC
> + */
> +
> +#ifndef SELFTEST_KVM_TIMER_TEST_H
> +#define SELFTEST_KVM_TIMER_TEST_H
> +
> +#include "kvm_util.h"
> +
> +#define NR_VCPUS_DEF            4
> +#define NR_TEST_ITERS_DEF       5
> +#define TIMER_TEST_PERIOD_MS_DEF    10
> +#define TIMER_TEST_ERR_MARGIN_US    100
> +#define TIMER_TEST_MIGRATION_FREQ_MS    2
> +
> +/* Timer test cmdline parameters */
> +struct test_args {
> +	int nr_vcpus;
> +	int nr_iter;
> +	int timer_period_ms;
> +	int migration_freq_ms;
> +	struct kvm_arm_counter_offset offset;

nit:
I see a later patch changes this arm-specific part. This patch could add a
TODO comment here, which would get removed with the later patch.

> +};
> +
> +/* Shared variables between host and guest */
> +struct test_vcpu_shared_data {
> +	int nr_iter;
> +	int guest_stage;
> +	uint64_t xcnt;
> +};
> +
> +extern struct test_args test_args;
> +extern struct kvm_vcpu *vcpus[];
> +extern struct test_vcpu_shared_data vcpu_shared_data[];
> +
> +struct kvm_vm *test_vm_create(void);
> +void test_vm_cleanup(struct kvm_vm *vm);
> +
> +#endif /* SELFTEST_KVM_TIMER_TEST_H */
> -- 
> 2.34.1
>

Besides my comment about the test description including the error margin,
which could probably be done as a separate patch anyway since we should
modify as little as possible when moving code, then this looks good to me

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
