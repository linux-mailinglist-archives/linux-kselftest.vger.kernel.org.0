Return-Path: <linux-kselftest+bounces-3309-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6872835EA2
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 10:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EB80B28B86
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 09:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A4C39FE8;
	Mon, 22 Jan 2024 09:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JDea/qXJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845C839AF0;
	Mon, 22 Jan 2024 09:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705916910; cv=none; b=Vrdds6N+50ZYM2UlPLKgmeoh5GDC29XqLqBley5PGTXrMgqJOOQZCQwRrlei5RxbCzoKMXh1509s8VH1gaafiKZawNiwsN/H5HMsw4TsG7LZdCnS5npVl5DRDgS+MnmUgnavPeHEtFe50kdhp9HsDNsbei/4GyBA5FN2+rdpLVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705916910; c=relaxed/simple;
	bh=1XO9eEdspJUyiQNfOySiSxKbv3KYnLFim284FfulR8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X8+E7ZoiQVE/Eep9teoGusHcI0llNDkRfxVGSDmNUXxHEffrbI7fywNkZxrZWvPsSliC8zbBIJeQjf4tTZZII2OVMeOi0SGk7q22HRSo+E3ZqVfYM7mJMOmzROJaHnSp+qNNSyKj60bBkKpFpGsdeGEE6les7z9GmS1V73aBBSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JDea/qXJ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705916909; x=1737452909;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1XO9eEdspJUyiQNfOySiSxKbv3KYnLFim284FfulR8k=;
  b=JDea/qXJa6Mng02KeTXZxtciEKLLzMPGAZiKf9whoa2yNPQPQWQM1fXR
   yy5Cv0pusjryZCV9OBUTfO2m+IIZj9h7/EXsYG0cTTFe5r8hYo2Ylwrsr
   /C8ONCN15x7xC11DYrrP0pJyiOMeVQZRrv6MWFx6PY43gRN0y98GpYvSx
   yeqAOKu4mQGyxXDrekXc71aY6Uu4wvbLr8p9t31m6oN9Q9Z3ZLEbUQk/5
   Kb8IZ5fXN1tsf4b3osflWv7d+93ZZXtgl3kvz4fLoiFlax7ZPBGz+yj2F
   T7qXSK2Tf7idAgdrQzEXCR+YAKwfA5R2PUmfBx7Lbtm6E3TUIvHK+uxbH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="22642103"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="22642103"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 01:48:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="778535602"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="778535602"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 01:48:18 -0800
From: Haibo Xu <haibo1.xu@intel.com>
To: 
Cc: xiaobo55x@gmail.com,
	ajones@ventanamicro.com,
	Haibo Xu <haibo1.xu@intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	Samuel Holland <samuel@sholland.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Like Xu <likexu@tencent.com>,
	Peter Xu <peterx@redhat.com>,
	Vipin Sharma <vipinsh@google.com>,
	Thomas Huth <thuth@redhat.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Aaron Lewis <aaronlewis@google.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	kvm-riscv@lists.infradead.org
Subject: [PATCH v5 12/12] KVM: riscv: selftests: Add sstc timer test
Date: Mon, 22 Jan 2024 17:58:42 +0800
Message-Id: <f20fbb9657f586f159c7b8171c9163226e2d52c1.1705916069.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1705916069.git.haibo1.xu@intel.com>
References: <cover.1705916069.git.haibo1.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a KVM selftests to validate the Sstc timer functionality.
The test was ported from arm64 arch timer test.

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/aarch64/arch_timer.c        |  12 +-
 tools/testing/selftests/kvm/arch_timer.c      |  10 +-
 .../selftests/kvm/include/riscv/arch_timer.h  |  71 +++++++++++
 .../selftests/kvm/include/riscv/processor.h   |  10 ++
 .../selftests/kvm/include/timer_test.h        |   5 +-
 .../testing/selftests/kvm/riscv/arch_timer.c  | 111 ++++++++++++++++++
 7 files changed, 210 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/riscv/arch_timer.h
 create mode 100644 tools/testing/selftests/kvm/riscv/arch_timer.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index f514c81877ce..77004220763e 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -183,6 +183,7 @@ TEST_GEN_PROGS_s390x += rseq_test
 TEST_GEN_PROGS_s390x += set_memory_region_test
 TEST_GEN_PROGS_s390x += kvm_binary_stats_test
 
+TEST_GEN_PROGS_riscv += arch_timer
 TEST_GEN_PROGS_riscv += demand_paging_test
 TEST_GEN_PROGS_riscv += dirty_log_test
 TEST_GEN_PROGS_riscv += guest_print_test
diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/testing/selftests/kvm/aarch64/arch_timer.c
index a4732ec9f761..77393be9236d 100644
--- a/tools/testing/selftests/kvm/aarch64/arch_timer.c
+++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
@@ -194,10 +194,14 @@ struct kvm_vm *test_vm_create(void)
 	vm_init_descriptor_tables(vm);
 	vm_install_exception_handler(vm, VECTOR_IRQ_CURRENT, guest_irq_handler);
 
-	if (!test_args.offset.reserved) {
-		if (kvm_has_cap(KVM_CAP_COUNTER_OFFSET))
-			vm_ioctl(vm, KVM_ARM_SET_COUNTER_OFFSET, &test_args.offset);
-		else
+	if (!test_args.reserved) {
+		if (kvm_has_cap(KVM_CAP_COUNTER_OFFSET)) {
+			struct kvm_arm_counter_offset offset = {
+				.counter_offset = test_args.counter_offset,
+				.reserved = 0,
+			};
+			vm_ioctl(vm, KVM_ARM_SET_COUNTER_OFFSET, &offset);
+		} else
 			TEST_FAIL("no support for global offset\n");
 	}
 
diff --git a/tools/testing/selftests/kvm/arch_timer.c b/tools/testing/selftests/kvm/arch_timer.c
index 113d40f7bb14..e4eb6cacc356 100644
--- a/tools/testing/selftests/kvm/arch_timer.c
+++ b/tools/testing/selftests/kvm/arch_timer.c
@@ -36,7 +36,7 @@ struct test_args test_args = {
 	.timer_period_ms = TIMER_TEST_PERIOD_MS_DEF,
 	.migration_freq_ms = TIMER_TEST_MIGRATION_FREQ_MS,
 	.timer_err_margin_us = TIMER_TEST_ERR_MARGIN_US,
-	.offset = { .reserved = 1 },
+	.reserved = 1,
 };
 
 struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
@@ -75,6 +75,8 @@ static void *test_vcpu_run(void *arg)
 		TEST_FAIL("Unexpected guest exit\n");
 	}
 
+	pr_info("PASS(vCPU-%d).\n", vcpu_idx);
+
 	return NULL;
 }
 
@@ -190,7 +192,7 @@ static void test_print_help(char *name)
 		TIMER_TEST_PERIOD_MS_DEF);
 	pr_info("\t-m: Frequency (in ms) of vCPUs to migrate to different pCPU. 0 to turn off (default: %u)\n",
 		TIMER_TEST_MIGRATION_FREQ_MS);
-	pr_info("\t-o: Counter offset (in counter cycles, default: 0)\n");
+	pr_info("\t-o: Counter offset (in counter cycles, default: 0) [aarch64-only]\n");
 	pr_info("\t-e: Interrupt arrival error margin (in us) of the guest timer (default: %u)\n",
 		TIMER_TEST_ERR_MARGIN_US);
 	pr_info("\t-h: print this help screen\n");
@@ -223,8 +225,8 @@ static bool parse_args(int argc, char *argv[])
 			test_args.timer_err_margin_us = atoi_non_negative("Error Margin", optarg);
 			break;
 		case 'o':
-			test_args.offset.counter_offset = strtol(optarg, NULL, 0);
-			test_args.offset.reserved = 0;
+			test_args.counter_offset = strtol(optarg, NULL, 0);
+			test_args.reserved = 0;
 			break;
 		case 'h':
 		default:
diff --git a/tools/testing/selftests/kvm/include/riscv/arch_timer.h b/tools/testing/selftests/kvm/include/riscv/arch_timer.h
new file mode 100644
index 000000000000..225d81dad064
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/riscv/arch_timer.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * RISC-V Arch Timer(sstc) specific interface
+ *
+ * Copyright (c) 2024 Intel Corporation
+ */
+
+#ifndef SELFTEST_KVM_ARCH_TIMER_H
+#define SELFTEST_KVM_ARCH_TIMER_H
+
+#include <asm/csr.h>
+#include <asm/vdso/processor.h>
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
+static inline uint64_t timer_get_cycles(void)
+{
+	return csr_read(CSR_TIME);
+}
+
+static inline void timer_set_cmp(uint64_t cval)
+{
+	csr_write(CSR_STIMECMP, cval);
+}
+
+static inline uint64_t timer_get_cmp(void)
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
+static inline void timer_set_next_cmp_ms(uint32_t msec)
+{
+	uint64_t now_ct = timer_get_cycles();
+	uint64_t next_ct = now_ct + msec_to_cycles(msec);
+
+	timer_set_cmp(next_ct);
+}
+
+static inline void __delay(uint64_t cycles)
+{
+	uint64_t start = timer_get_cycles();
+
+	while ((timer_get_cycles() - start) < cycles)
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
index bd27e1c67579..3e7f6b369a5e 100644
--- a/tools/testing/selftests/kvm/include/riscv/processor.h
+++ b/tools/testing/selftests/kvm/include/riscv/processor.h
@@ -158,4 +158,14 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
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
index 256e2d2137cf..9b6edaafe6d4 100644
--- a/tools/testing/selftests/kvm/include/timer_test.h
+++ b/tools/testing/selftests/kvm/include/timer_test.h
@@ -23,8 +23,9 @@ struct test_args {
 	uint32_t timer_period_ms;
 	uint32_t migration_freq_ms;
 	uint32_t timer_err_margin_us;
-	/* TODO: Change arm specific type to a common one */
-	struct kvm_arm_counter_offset offset;
+	/* Members of struct kvm_arm_counter_offset */
+	uint64_t counter_offset;
+	uint64_t reserved;
 };
 
 /* Shared variables between host and guest */
diff --git a/tools/testing/selftests/kvm/riscv/arch_timer.c b/tools/testing/selftests/kvm/riscv/arch_timer.c
new file mode 100644
index 000000000000..1bbd0ce2923c
--- /dev/null
+++ b/tools/testing/selftests/kvm/riscv/arch_timer.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * arch_timer.c - Tests the riscv64 sstc timer IRQ functionality
+ *
+ * The test validates the sstc timer IRQs using vstimecmp registers.
+ * It's ported from the aarch64 arch_timer test.
+ *
+ * Copyright (c) 2024, Intel Corporation.
+ */
+
+#define _GNU_SOURCE
+
+#include "arch_timer.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "timer_test.h"
+
+static int timer_irq = IRQ_S_TIMER;
+
+static void guest_irq_handler(struct ex_regs *regs)
+{
+	uint64_t xcnt, xcnt_diff_us, cmp;
+	unsigned int intid = regs->cause & ~CAUSE_IRQ_FLAG;
+	uint32_t cpu = guest_get_vcpuid();
+	struct test_vcpu_shared_data *shared_data = &vcpu_shared_data[cpu];
+
+	timer_irq_disable();
+
+	xcnt = timer_get_cycles();
+	cmp = timer_get_cmp();
+	xcnt_diff_us = cycles_to_usec(xcnt - shared_data->xcnt);
+
+	/* Make sure we are dealing with the correct timer IRQ */
+	GUEST_ASSERT_EQ(intid, timer_irq);
+
+	__GUEST_ASSERT(xcnt >= cmp,
+			"xcnt = 0x%llx, cmp = 0x%llx, xcnt_diff_us = 0x%llx",
+			xcnt, cmp, xcnt_diff_us);
+
+	WRITE_ONCE(shared_data->nr_iter, shared_data->nr_iter + 1);
+}
+
+static void guest_run(struct test_vcpu_shared_data *shared_data)
+{
+	uint32_t irq_iter, config_iter;
+
+	shared_data->nr_iter = 0;
+	shared_data->guest_stage = 0;
+
+	for (config_iter = 0; config_iter < test_args.nr_iter; config_iter++) {
+		/* Setup the next interrupt */
+		timer_set_next_cmp_ms(test_args.timer_period_ms);
+		shared_data->xcnt = timer_get_cycles();
+		timer_irq_enable();
+
+		/* Setup a timeout for the interrupt to arrive */
+		udelay(msecs_to_usecs(test_args.timer_period_ms) +
+			test_args.timer_err_margin_us);
+
+		irq_iter = READ_ONCE(shared_data->nr_iter);
+		__GUEST_ASSERT(config_iter + 1 == irq_iter,
+				"config_iter + 1 = 0x%lx, irq_iter = 0x%lx.\n"
+				"  Guest timer interrupt was not trigged within the specified\n"
+				"  interval, try to increase the error margin by [-e] option.\n",
+				config_iter + 1, irq_iter);
+	}
+}
+
+static void guest_code(void)
+{
+	uint32_t cpu = guest_get_vcpuid();
+	struct test_vcpu_shared_data *shared_data = &vcpu_shared_data[cpu];
+
+	timer_irq_disable();
+	local_irq_enable();
+
+	guest_run(shared_data);
+
+	GUEST_DONE();
+}
+
+struct kvm_vm *test_vm_create(void)
+{
+	struct kvm_vm *vm;
+	int nr_vcpus = test_args.nr_vcpus;
+
+	vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
+	__TEST_REQUIRE(__vcpu_has_ext(vcpus[0], KVM_RISCV_ISA_EXT_SSTC),
+				   "SSTC not available, skipping test\n");
+
+	vm_init_vector_tables(vm);
+	vm_install_interrupt_handler(vm, guest_irq_handler);
+
+	for (int i = 0; i < nr_vcpus; i++)
+		vcpu_init_vector_tables(vcpus[i]);
+
+	/* Initialize guest timer frequency. */
+	vcpu_get_reg(vcpus[0], RISCV_TIMER_REG(frequency), &timer_freq);
+	sync_global_to_guest(vm, timer_freq);
+	pr_debug("timer_freq: %lu\n", timer_freq);
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


