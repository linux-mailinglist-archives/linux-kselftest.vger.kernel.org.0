Return-Path: <linux-kselftest+bounces-46070-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7294DC7280F
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 08:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0F5BE34E9D4
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 07:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B9D307AD5;
	Thu, 20 Nov 2025 06:58:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2029301499;
	Thu, 20 Nov 2025 06:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763621909; cv=none; b=XqVQSa0gzCKqk88UOFtwUWN+ylEUMYM//dpCis4W5mNMc0J+kYb2/pIpzxWV2zgWoKSUrO0EXN/4HzYtTli7CwNmeEs+IGJOnv7YeN+0sPA2eZ1tQLWIchjy80tUD5Ti6Fj60T/5fWsq2MZ1nuemd9PHrpv0RZqRo+2419tk5xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763621909; c=relaxed/simple;
	bh=LzEYPGrwEsvWg7PVY1wbvvpTvdbCLE6ye72OqOrIf0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VsQWeV12Xx4Wtii+P7R7FS22XIeDUvMRnMJHP/WhAZkcOiWXy3OSHSElk1TJwHjhwunA/sr3XAzQ/wB6R0MGBi9B8JiuBlYrnSr2ztjZxNVCFrLvxg//JolzYfWwDQewvo2b+ct84e0XbPnUI5IHF3R0dRhCCJ8WLDBOeOUCs9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Cxf9MOvB5pCf8lAA--.15813S3;
	Thu, 20 Nov 2025 14:58:22 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJBxicD3ux5pSkU5AQ--.5850S6;
	Thu, 20 Nov 2025 14:58:21 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Tianrui Zhao <zhaotianrui@loongson.cn>
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: [PATCH v3 4/6] KVM: LoongArch: selftests: Add timer interrupt test case
Date: Thu, 20 Nov 2025 14:57:56 +0800
Message-Id: <20251120065758.3064368-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20251120065758.3064368-1-maobibo@loongson.cn>
References: <20251120065758.3064368-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxicD3ux5pSkU5AQ--.5850S6
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Add timer test case based on common arch_timer code, timer interrupt
with one-shot and period mode is tested.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../kvm/include/loongarch/arch_timer.h        |  84 ++++++++++++
 .../kvm/include/loongarch/processor.h         |  10 ++
 .../selftests/kvm/lib/loongarch/processor.c   |   4 +-
 .../selftests/kvm/loongarch/arch_timer.c      | 125 ++++++++++++++++++
 5 files changed, 222 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/loongarch/arch_timer.h
 create mode 100644 tools/testing/selftests/kvm/loongarch/arch_timer.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 148d427ff24b..9d01f4d0e3f9 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -210,6 +210,7 @@ TEST_GEN_PROGS_riscv += mmu_stress_test
 TEST_GEN_PROGS_riscv += rseq_test
 TEST_GEN_PROGS_riscv += steal_time
 
+TEST_GEN_PROGS_loongarch = arch_timer
 TEST_GEN_PROGS_loongarch += coalesced_io_test
 TEST_GEN_PROGS_loongarch += demand_paging_test
 TEST_GEN_PROGS_loongarch += dirty_log_perf_test
diff --git a/tools/testing/selftests/kvm/include/loongarch/arch_timer.h b/tools/testing/selftests/kvm/include/loongarch/arch_timer.h
new file mode 100644
index 000000000000..b6399e748f72
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/loongarch/arch_timer.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * LoongArch Constant Timer specific interface
+ */
+#ifndef SELFTEST_KVM_ARCH_TIMER_H
+#define SELFTEST_KVM_ARCH_TIMER_H
+
+#include "processor.h"
+/* LoongArch timer frequency is constant 100MHZ */
+#define	TIMER_FREQ		(100UL << 20)
+#define msec_to_cycles(msec)    (TIMER_FREQ * (unsigned long)(msec) / 1000)
+#define usec_to_cycles(usec)	(TIMER_FREQ * (unsigned long)(usec) / 1000000)
+#define cycles_to_usec(cycles)	((unsigned long)(cycles) * 1000000 / TIMER_FREQ)
+
+static inline unsigned long timer_get_cycles(void)
+{
+	unsigned long val = 0;
+
+	__asm__ __volatile__(
+		"rdtime.d %0, $zero\n\t"
+		: "=r"(val)
+		:
+	);
+
+	return val;
+}
+
+static inline void timer_set_next_cmp_ms(unsigned int msec, bool period)
+{
+	unsigned long val;
+
+	val = msec_to_cycles(msec) & CSR_TCFG_VAL;
+	val |= CSR_TCFG_EN;
+	if (period)
+		val |= CSR_TCFG_PERIOD;
+	csr_write(val, LOONGARCH_CSR_TCFG);
+}
+
+static inline void disable_timer(void)
+{
+	csr_write(0, LOONGARCH_CSR_TCFG);
+}
+
+static inline unsigned long timer_get_val(void)
+{
+	return csr_read(LOONGARCH_CSR_TVAL);
+}
+
+static inline unsigned long timer_get_cfg(void)
+{
+	return csr_read(LOONGARCH_CSR_TCFG);
+}
+
+static inline void timer_irq_enable(void)
+{
+	unsigned long val;
+
+	val = csr_read(LOONGARCH_CSR_ECFG);
+	val |= ECFGF_TIMER;
+	csr_write(val, LOONGARCH_CSR_ECFG);
+}
+
+static inline void timer_irq_disable(void)
+{
+	unsigned long val;
+
+	val = csr_read(LOONGARCH_CSR_ECFG);
+	val &= ~ECFGF_TIMER;
+	csr_write(val, LOONGARCH_CSR_ECFG);
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
+#endif /* SELFTEST_KVM_ARCH_TIMER_H */
diff --git a/tools/testing/selftests/kvm/include/loongarch/processor.h b/tools/testing/selftests/kvm/include/loongarch/processor.h
index b027f8f4dac7..61f6e215046b 100644
--- a/tools/testing/selftests/kvm/include/loongarch/processor.h
+++ b/tools/testing/selftests/kvm/include/loongarch/processor.h
@@ -83,6 +83,8 @@
 #define LOONGARCH_CSR_PRMD		0x1
 #define LOONGARCH_CSR_EUEN		0x2
 #define LOONGARCH_CSR_ECFG		0x4
+#define  ECFGB_TIMER			11
+#define  ECFGF_TIMER			(BIT_ULL(ECFGB_TIMER))
 #define LOONGARCH_CSR_ESTAT		0x5  /* Exception status */
 #define  CSR_ESTAT_EXC_SHIFT		16
 #define  CSR_ESTAT_EXC_WIDTH		6
@@ -111,6 +113,14 @@
 #define LOONGARCH_CSR_KS1		0x31
 #define LOONGARCH_CSR_TMID		0x40
 #define LOONGARCH_CSR_TCFG		0x41
+#define  CSR_TCFG_VAL			(BIT_ULL(48) - BIT_ULL(2))
+#define  CSR_TCFG_PERIOD_SHIFT		1
+#define  CSR_TCFG_PERIOD		(0x1UL << CSR_TCFG_PERIOD_SHIFT)
+#define  CSR_TCFG_EN			(0x1UL)
+#define LOONGARCH_CSR_TVAL		0x42
+#define LOONGARCH_CSR_TINTCLR		0x44 /* Timer interrupt clear */
+#define  CSR_TINTCLR_TI_SHIFT		0
+#define  CSR_TINTCLR_TI			(1 << CSR_TINTCLR_TI_SHIFT)
 /* TLB refill exception entry */
 #define LOONGARCH_CSR_TLBRENTRY		0x88
 #define LOONGARCH_CSR_TLBRSAVE		0x8b
diff --git a/tools/testing/selftests/kvm/lib/loongarch/processor.c b/tools/testing/selftests/kvm/lib/loongarch/processor.c
index 20ba476ccb72..436990258068 100644
--- a/tools/testing/selftests/kvm/lib/loongarch/processor.c
+++ b/tools/testing/selftests/kvm/lib/loongarch/processor.c
@@ -271,8 +271,8 @@ static void loongarch_vcpu_setup(struct kvm_vcpu *vcpu)
 		TEST_FAIL("Unknown guest mode, mode: 0x%x", vm->mode);
 	}
 
-	/* user mode and page enable mode */
-	val = PLV_USER | CSR_CRMD_PG;
+	/* kernel mode and page enable mode */
+	val = PLV_KERN | CSR_CRMD_PG;
 	loongarch_set_csr(vcpu, LOONGARCH_CSR_CRMD, val);
 	loongarch_set_csr(vcpu, LOONGARCH_CSR_PRMD, val);
 	loongarch_set_csr(vcpu, LOONGARCH_CSR_EUEN, 1);
diff --git a/tools/testing/selftests/kvm/loongarch/arch_timer.c b/tools/testing/selftests/kvm/loongarch/arch_timer.c
new file mode 100644
index 000000000000..a8b7ff05faf6
--- /dev/null
+++ b/tools/testing/selftests/kvm/loongarch/arch_timer.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * The test validates one-shot constant timer IRQ using CSR_TCFG and
+ * CSR_TVAL registers.
+ */
+#include "arch_timer.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "timer_test.h"
+#include "ucall_common.h"
+
+static void guest_irq_handler(struct ex_regs *regs)
+{
+	uint64_t xcnt, val, cfg, xcnt_diff_us;
+	unsigned int intid;
+	uint32_t cpu = guest_get_vcpuid();
+	struct test_vcpu_shared_data *shared_data = &vcpu_shared_data[cpu];
+
+	intid = !!(regs->estat & BIT(INT_TI));
+
+	/* Make sure we are dealing with the correct timer IRQ */
+	GUEST_ASSERT_EQ(intid, 1);
+
+	cfg = timer_get_cfg();
+	if (cfg & CSR_TCFG_PERIOD) {
+		WRITE_ONCE(shared_data->nr_iter, shared_data->nr_iter - 1);
+		if (shared_data->nr_iter == 0)
+			disable_timer();
+		csr_write(CSR_TINTCLR_TI, LOONGARCH_CSR_TINTCLR);
+		return;
+	}
+
+	/*
+	 * On physical machine, value of LOONGARCH_CSR_TVAL is BIT_ULL(48) - 1
+	 * On virtual machine, its value counts down from BIT_ULL(48) - 1
+	 */
+	val = timer_get_val();
+	xcnt = timer_get_cycles();
+	xcnt_diff_us = cycles_to_usec(xcnt - shared_data->xcnt);
+
+	/* Basic 'timer condition met' check */
+	__GUEST_ASSERT(val > cfg,
+			"val = 0x%lx, cfg = 0x%lx, xcnt_diff_us = 0x%lx",
+			val, cfg, xcnt_diff_us);
+
+	csr_write(CSR_TINTCLR_TI, LOONGARCH_CSR_TINTCLR);
+	WRITE_ONCE(shared_data->nr_iter, shared_data->nr_iter + 1);
+}
+
+static void guest_test_oneshot_timer(uint32_t cpu)
+{
+	uint32_t irq_iter, config_iter;
+	uint64_t us;
+	struct test_vcpu_shared_data *shared_data = &vcpu_shared_data[cpu];
+
+	shared_data->nr_iter = 0;
+	shared_data->guest_stage = 0;
+	us = msecs_to_usecs(test_args.timer_period_ms) + test_args.timer_err_margin_us;
+	for (config_iter = 0; config_iter < test_args.nr_iter; config_iter++) {
+		shared_data->xcnt = timer_get_cycles();
+
+		/* Setup the next interrupt */
+		timer_set_next_cmp_ms(test_args.timer_period_ms, false);
+		/* Setup a timeout for the interrupt to arrive */
+		udelay(us);
+
+		irq_iter = READ_ONCE(shared_data->nr_iter);
+		__GUEST_ASSERT(config_iter + 1 == irq_iter,
+				"config_iter + 1 = 0x%x, irq_iter = 0x%x.\n"
+				"  Guest timer interrupt was not triggered within the specified\n"
+				"  interval, try to increase the error margin by [-e] option.\n",
+				config_iter + 1, irq_iter);
+	}
+}
+
+static void guest_test_period_timer(uint32_t cpu)
+{
+	uint32_t irq_iter;
+	uint64_t us;
+	struct test_vcpu_shared_data *shared_data = &vcpu_shared_data[cpu];
+
+	shared_data->nr_iter = test_args.nr_iter;
+	shared_data->xcnt = timer_get_cycles();
+	us = msecs_to_usecs(test_args.timer_period_ms) + test_args.timer_err_margin_us;
+	timer_set_next_cmp_ms(test_args.timer_period_ms, true);
+	/* Setup a timeout for the interrupt to arrive */
+	udelay(us * test_args.nr_iter);
+	irq_iter = READ_ONCE(shared_data->nr_iter);
+	__GUEST_ASSERT(irq_iter == 0,
+			"irq_iter = 0x%x.\n"
+			"  Guest period timer interrupt was not triggered within the specified\n"
+			"  interval, try to increase the error margin by [-e] option.\n",
+			irq_iter);
+}
+
+static void guest_code(void)
+{
+	uint32_t cpu = guest_get_vcpuid();
+
+	timer_irq_enable();
+	local_irq_enable();
+	guest_test_oneshot_timer(cpu);
+	guest_test_period_timer(cpu);
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
+	vm_init_descriptor_tables(vm);
+	vm_install_exception_handler(vm, EXCCODE_INT, guest_irq_handler);
+
+	/* Make all the test's cmdline args visible to the guest */
+	sync_global_to_guest(vm, test_args);
+	return vm;
+}
+
+void test_vm_cleanup(struct kvm_vm *vm)
+{
+	kvm_vm_free(vm);
+}
-- 
2.39.3


