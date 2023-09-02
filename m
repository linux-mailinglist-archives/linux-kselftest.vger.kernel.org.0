Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4067907F5
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Sep 2023 14:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237893AbjIBMzC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Sep 2023 08:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244187AbjIBMzB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Sep 2023 08:55:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E4E135;
        Sat,  2 Sep 2023 05:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693659293; x=1725195293;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=thLtNGChztA4iIOh+MAOWw+PgjHItukGczItWBbBlD4=;
  b=E8YCTkF++MK6dQJ2E2Xv3CAgLra962oe5SGb6CTGg70+Lv/11LahAGSY
   Nmu+8ed2da4ih2rFymC8TIeiJvfTQ6IA2ThZ/i+QxXLn1Ws4H6vPWU0XP
   ytTivKdHnF4vQ7baH1kePKJ5GjfKa77qFVMC8tQcHqVErZwrreI1MRuQ9
   1PpSIEEkRYpbQk1Oe5d9TfpNue3GSDoQb8wcsTz5oPV5QzuEZW8WSXmIC
   2nKc65guibaEf3bpm0K16laO8FDwXBB4xtM4nAFEjWCZikaV+tsdJrU7b
   iwBFQXdQFZt2X7J3bVQxl+vAPmu0x2jdyx6otqZ+hY8c3OUJiOkhsysg0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10821"; a="366599473"
X-IronPort-AV: E=Sophos;i="6.02,222,1688454000"; 
   d="scan'208";a="366599473"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2023 05:54:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10821"; a="855022397"
X-IronPort-AV: E=Sophos;i="6.02,222,1688454000"; 
   d="scan'208";a="855022397"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2023 05:54:43 -0700
From:   Haibo Xu <haibo1.xu@intel.com>
Cc:     xiaobo55x@gmail.com, haibo1.xu@intel.com, ajones@ventanamicro.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
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
        Guo Ren <guoren@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        wchen <waylingii@gmail.com>,
        Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
        Sean Christopherson <seanjc@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        David Matlack <dmatlack@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Thomas Huth <thuth@redhat.com>, Like Xu <likexu@tencent.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Michal Luczaj <mhal@rbox.co>,
        zhang songyi <zhang.songyi@zte.com.cn>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Subject: [PATCH v2 8/8] KVM: riscv: selftests: Add sstc timer test
Date:   Sat,  2 Sep 2023 20:59:30 +0800
Message-Id: <d2b3c53537fef3f0a2d27d8be663a64123d4bc3c.1693659382.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1693659382.git.haibo1.xu@intel.com>
References: <cover.1693659382.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a KVM selftest to validate the Sstc timer functionality.
The test was ported from arm64 arch timer test.

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 tools/testing/selftests/kvm/arch_timer.c      |   9 ++
 .../selftests/kvm/include/riscv/arch_timer.h  |  80 +++++++++++
 .../selftests/kvm/include/riscv/processor.h   |  10 ++
 .../selftests/kvm/include/timer_test.h        |   6 +
 .../testing/selftests/kvm/riscv/arch_timer.c  | 130 ++++++++++++++++++
 6 files changed, 236 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/riscv/arch_timer.h
 create mode 100644 tools/testing/selftests/kvm/riscv/arch_timer.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 01638027d059..7897d8051d8c 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -179,6 +179,7 @@ TEST_GEN_PROGS_s390x += rseq_test
 TEST_GEN_PROGS_s390x += set_memory_region_test
 TEST_GEN_PROGS_s390x += kvm_binary_stats_test
 
+TEST_GEN_PROGS_riscv += arch_timer
 TEST_GEN_PROGS_riscv += demand_paging_test
 TEST_GEN_PROGS_riscv += dirty_log_test
 TEST_GEN_PROGS_riscv += get-reg-list
diff --git a/tools/testing/selftests/kvm/arch_timer.c b/tools/testing/selftests/kvm/arch_timer.c
index 529024f58c98..691bd454e362 100644
--- a/tools/testing/selftests/kvm/arch_timer.c
+++ b/tools/testing/selftests/kvm/arch_timer.c
@@ -66,8 +66,13 @@ static void *test_vcpu_run(void *arg)
 		break;
 	case UCALL_ABORT:
 		sync_global_from_guest(vm, *shared_data);
+#ifdef __aarch64__
 		fprintf(stderr, "Guest assert failed,  vcpu %u; stage; %u; iter: %u\n",
 		        vcpu_idx, shared_data->guest_stage, shared_data->nr_iter);
+#else
+		fprintf(stderr, "Guest assert failed,  vcpu %u; iter: %u\n",
+		        vcpu_idx, shared_data->nr_iter);
+#endif
 		REPORT_GUEST_ASSERT(uc);
 		break;
 	default:
@@ -190,7 +195,9 @@ static void test_print_help(char *name)
 		TIMER_TEST_PERIOD_MS_DEF);
 	pr_info("\t-m: Frequency (in ms) of vCPUs to migrate to different pCPU. 0 to turn off (default: %u)\n",
 		TIMER_TEST_MIGRATION_FREQ_MS);
+#ifdef __aarch64__
 	pr_info("\t-o: Counter offset (in counter cycles, default: 0)\n");
+#endif
 	pr_info("\t-h: print this help screen\n");
 }
 
@@ -217,10 +224,12 @@ static bool parse_args(int argc, char *argv[])
 		case 'm':
 			test_args.migration_freq_ms = atoi_non_negative("Frequency", optarg);
 			break;
+#ifdef __aarch64__
 		case 'o':
 			test_args.offset.counter_offset = strtol(optarg, NULL, 0);
 			test_args.offset.reserved = 0;
 			break;
+#endif
 		case 'h':
 		default:
 			goto err;
diff --git a/tools/testing/selftests/kvm/include/riscv/arch_timer.h b/tools/testing/selftests/kvm/include/riscv/arch_timer.h
new file mode 100644
index 000000000000..897edcef8fc2
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/riscv/arch_timer.h
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0 */
+/*
+ * RISC-V Arch Timer(sstc) specific interface
+ *
+ * Copyright (c) 2023 Intel Corporation
+ */
+
+#ifndef SELFTEST_KVM_ARCH_TIMER_H
+#define SELFTEST_KVM_ARCH_TIMER_H
+
+#include <asm/csr.h>
+
+static unsigned long timer_freq;
+
+#define msec_to_cycles(msec)	\
+	((timer_freq) * (uint64_t)(msec) / 1000)
+
+#define usec_to_cycles(usec)	\
+	((timer_freq) * (uint64_t)(usec) / 1000000)
+
+#define cycles_to_usec(cycles) \
+	((uint64_t)(cycles) * 1000000 / (timer_freq))
+
+static inline uint64_t timer_get_cntct(void)
+{
+	return csr_read(CSR_TIME);
+}
+
+static inline void timer_set_cval(uint64_t cval)
+{
+	csr_write(CSR_STIMECMP, cval);
+}
+
+static inline uint64_t timer_get_cval(void)
+{
+	return csr_read(CSR_STIMECMP);
+}
+
+static inline void timer_irq_enable(void)
+{
+	csr_set(CSR_SIE, IE_TIE);
+}
+
+static inline void timer_irq_disable(void)
+{
+	csr_clear(CSR_SIE, IE_TIE);
+}
+
+static inline void timer_set_next_cval_ms(uint32_t msec)
+{
+	uint64_t now_ct = timer_get_cntct();
+	uint64_t next_ct = now_ct + msec_to_cycles(msec);
+
+	timer_set_cval(next_ct);
+}
+
+static inline void cpu_relax(void)
+{
+#ifdef __riscv_zihintpause
+	asm volatile("pause" ::: "memory");
+#else
+	/* Encoding of the pause instruction */
+	asm volatile(".4byte 0x100000F" ::: "memory");
+#endif
+}
+
+static inline void __delay(uint64_t cycles)
+{
+	uint64_t start = timer_get_cntct();
+
+	while ((timer_get_cntct() - start) < cycles)
+		cpu_relax();
+}
+
+static inline void udelay(unsigned long usec)
+{
+	__delay(usec_to_cycles(usec));
+}
+
+#endif /* SELFTEST_KVM_ARCH_TIMER_H */
diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
index 6087c8fc263a..c69f36302d41 100644
--- a/tools/testing/selftests/kvm/include/riscv/processor.h
+++ b/tools/testing/selftests/kvm/include/riscv/processor.h
@@ -161,4 +161,14 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
 			unsigned long arg3, unsigned long arg4,
 			unsigned long arg5);
 
+static inline void local_irq_enable(void)
+{
+	csr_set(CSR_SSTATUS, SR_SIE);
+}
+
+static inline void local_irq_disable(void)
+{
+	csr_clear(CSR_SSTATUS, SR_SIE);
+}
+
 #endif /* SELFTEST_KVM_PROCESSOR_H */
diff --git a/tools/testing/selftests/kvm/include/timer_test.h b/tools/testing/selftests/kvm/include/timer_test.h
index 109e4d635627..091c05a14c93 100644
--- a/tools/testing/selftests/kvm/include/timer_test.h
+++ b/tools/testing/selftests/kvm/include/timer_test.h
@@ -18,6 +18,7 @@
 
 #define msecs_to_usecs(msec)    ((msec) * 1000LL)
 
+#ifdef __aarch64__
 #define GICD_BASE_GPA    0x8000000ULL
 #define GICR_BASE_GPA    0x80A0000ULL
 
@@ -28,6 +29,7 @@ enum guest_stage {
 	GUEST_STAGE_PTIMER_TVAL,
 	GUEST_STAGE_MAX,
 };
+#endif
 
 /* Timer test cmdline parameters */
 struct test_args
@@ -36,13 +38,17 @@ struct test_args
 	int nr_iter;
 	int timer_period_ms;
 	int migration_freq_ms;
+#ifdef __aarch64__
 	struct kvm_arm_counter_offset offset;
+#endif
 };
 
 /* Shared variables between host and guest */
 struct test_vcpu_shared_data {
 	int nr_iter;
+#ifdef __aarch64__
 	enum guest_stage guest_stage;
+#endif
 	uint64_t xcnt;
 };
 
diff --git a/tools/testing/selftests/kvm/riscv/arch_timer.c b/tools/testing/selftests/kvm/riscv/arch_timer.c
new file mode 100644
index 000000000000..c50a33c1e4f9
--- /dev/null
+++ b/tools/testing/selftests/kvm/riscv/arch_timer.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * arch_timer.c - Tests the riscv64 sstc timer IRQ functionality
+ *
+ * The test validates the sstc timer IRQs using vstimecmp registers.
+ * It's ported from the aarch64 arch_timer test.
+ *
+ * Copyright (c) 2023, Intel Corporation.
+ */
+
+#define _GNU_SOURCE
+
+#include "arch_timer.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "timer_test.h"
+
+extern struct test_args test_args;
+extern struct kvm_vcpu *vcpus[];
+extern struct test_vcpu_shared_data vcpu_shared_data[];
+
+static int timer_irq = IRQ_S_TIMER;
+
+static void
+guest_configure_timer_action(struct test_vcpu_shared_data *shared_data)
+{
+	timer_set_next_cval_ms(test_args.timer_period_ms);
+	shared_data->xcnt = timer_get_cntct();
+	timer_irq_enable();
+}
+
+static void guest_validate_irq(unsigned int intid,
+				struct test_vcpu_shared_data *shared_data)
+{
+	uint64_t xcnt = 0, xcnt_diff_us, cval = 0;
+
+	timer_irq_disable();
+	xcnt = timer_get_cntct();
+	cval = timer_get_cval();
+
+	xcnt_diff_us = cycles_to_usec(xcnt - shared_data->xcnt);
+
+	/* Make sure we are dealing with the correct timer IRQ */
+	GUEST_ASSERT_EQ(intid, timer_irq);
+
+	__GUEST_ASSERT(xcnt >= cval,
+	               "xcnt = 0x%llx, cval = 0x%llx, xcnt_diff_us = 0x%llx",
+	               xcnt, cval, xcnt_diff_us);
+
+	WRITE_ONCE(shared_data->nr_iter, shared_data->nr_iter + 1);
+}
+
+static void guest_irq_handler(struct ex_regs *regs)
+{
+	unsigned int intid = regs->cause & ~CAUSE_IRQ_FLAG;
+	uint32_t cpu = guest_get_vcpuid();
+	struct test_vcpu_shared_data *shared_data = &vcpu_shared_data[cpu];
+
+	guest_validate_irq(intid, shared_data);
+}
+
+static void guest_run(struct test_vcpu_shared_data *shared_data)
+{
+	uint32_t irq_iter, config_iter;
+
+	shared_data->nr_iter = 0;
+
+	for (config_iter = 0; config_iter < test_args.nr_iter; config_iter++) {
+		/* Setup the next interrupt */
+		guest_configure_timer_action(shared_data);
+
+		/* Setup a timeout for the interrupt to arrive */
+		udelay(msecs_to_usecs(test_args.timer_period_ms) +
+			TIMER_TEST_ERR_MARGIN_US);
+
+		irq_iter = READ_ONCE(shared_data->nr_iter);
+		GUEST_ASSERT_EQ(config_iter + 1, irq_iter);
+	}
+}
+
+static void guest_code(void)
+{
+	uint32_t cpu = guest_get_vcpuid();
+	struct test_vcpu_shared_data *shared_data = &vcpu_shared_data[cpu];
+
+	local_irq_disable();
+	timer_irq_disable();
+	local_irq_enable();
+
+	guest_run(shared_data);
+
+	GUEST_DONE();
+}
+
+static void test_init_timer_freq(struct kvm_vm *vm)
+{
+	/* Timer frequency should be same for all the vCPUs, so query only vCPU-0 */
+	vcpu_get_reg(vcpus[0], RISCV_TIMER_REG(frequency), &timer_freq);
+	sync_global_to_guest(vm, timer_freq);
+
+	pr_debug("timer_freq: %lu\n", timer_freq);
+}
+
+struct kvm_vm *test_vm_create(void)
+{
+	struct kvm_vm *vm;
+	int nr_vcpus = test_args.nr_vcpus;
+
+	vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
+	__TEST_REQUIRE(vcpu_has_ext(vcpus[0], KVM_RISCV_ISA_EXT_SSTC),
+				   "SSTC not available, skipping test\n");
+
+	vm_init_vector_tables(vm);
+	vm_install_interrupt_handler(vm, guest_irq_handler);
+
+	for (int i = 0; i < nr_vcpus; i++)
+		vcpu_init_vector_tables(vcpus[i]);
+
+	test_init_timer_freq(vm);
+
+	/* Make all the test's cmdline args visible to the guest */
+	sync_global_to_guest(vm, test_args);
+
+	return vm;
+}
+
+void test_vm_cleanup(struct kvm_vm *vm)
+{
+	kvm_vm_free(vm);
+}
-- 
2.34.1

