Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4288764897
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 09:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbjG0H1B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 03:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbjG0HZo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 03:25:44 -0400
Received: from mgamail.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5506235AC;
        Thu, 27 Jul 2023 00:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690442152; x=1721978152;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LRiVvkYU4onaM07z5HsamlgLNdVrZnGNOTlAoQGUR0I=;
  b=MtDWPsF7RdCZxU6sgowgOVmLKgncKoFD7J/Aqnow9fp/esR8fH01/I0P
   qGMdvAotlf2nXtlNmeeNdaLrrVclSGED0VvsFpwEgy+7j0lfcp9uublKs
   pwTmWWCG9RbzXCLP+5wcYxlJXIu6bkkPopPE2MRieH4hyA52rIYAjeSSZ
   dRoxewjHFpSPHAkvnpQAwZz9fD0sTLCngnKE5Re9XA6NMxN9W/MT73JrD
   qi3b/gv4TSa1lVKQvUKOZSI/xD+AGmt3mxN99qD5KC3LEk9SVNTnA5QaR
   NF2qRDOjTxxi+wGRELla6/R052/UbN2TyuPFhNR/A7jvhCIV4/m6XQ279
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="367102609"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="367102609"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 00:14:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="720785852"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="720785852"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 00:14:54 -0700
From:   Haibo Xu <haibo1.xu@intel.com>
Cc:     xiaobo55x@gmail.com, haibo1.xu@intel.com, ajones@ventanamicro.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Sean Christopherson <seanjc@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Colton Lewis <coltonlewis@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Andrew Jones <andrew.jones@linux.dev>,
        Vishal Annapurve <vannapurve@google.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kvm-riscv@lists.infradead.org
Subject: [PATCH 4/4] KVM: riscv: selftests: Add sstc_timer test
Date:   Thu, 27 Jul 2023 15:20:08 +0800
Message-Id: <b7b1b42f753094c1a0ce9d2307aa3fb7978995af.1690364259.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1690364259.git.haibo1.xu@intel.com>
References: <cover.1690364259.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a KVM selftest to validate the Sstc timer functionality.
The test was ported from arm64 arch_timer test.

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/include/riscv/processor.h   |  25 ++
 .../selftests/kvm/include/riscv/sstc_timer.h  |  70 ++++
 .../selftests/kvm/lib/riscv/processor.c       |   9 +
 .../testing/selftests/kvm/riscv/sstc_timer.c  | 382 ++++++++++++++++++
 5 files changed, 487 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/riscv/sstc_timer.h
 create mode 100644 tools/testing/selftests/kvm/riscv/sstc_timer.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 70f3a5ba991e..92b9a26b515d 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -175,6 +175,7 @@ TEST_GEN_PROGS_s390x += rseq_test
 TEST_GEN_PROGS_s390x += set_memory_region_test
 TEST_GEN_PROGS_s390x += kvm_binary_stats_test
 
+TEST_GEN_PROGS_riscv += riscv/sstc_timer
 TEST_GEN_PROGS_riscv += demand_paging_test
 TEST_GEN_PROGS_riscv += dirty_log_test
 TEST_GEN_PROGS_riscv += kvm_create_max_vcpus
diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
index ca53570ce6de..4846b4598bd9 100644
--- a/tools/testing/selftests/kvm/include/riscv/processor.h
+++ b/tools/testing/selftests/kvm/include/riscv/processor.h
@@ -39,6 +39,11 @@ static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t idx,
 					     KVM_REG_RISCV_TIMER_REG(name), \
 					     KVM_REG_SIZE_U64)
 
+#define RISCV_ISA_EXT_REG(idx) __kvm_reg_id(KVM_REG_RISCV_ISA_EXT, \
+					     idx, KVM_REG_SIZE_ULONG)
+
+bool vcpu_has_ext(struct kvm_vcpu *vcpu, int ext);
+
 struct ex_regs {
 	unsigned long ra;
 	unsigned long sp;
@@ -87,6 +92,16 @@ typedef void(*handler_fn)(struct ex_regs *);
 void vm_install_exception_handler(struct kvm_vm *vm, int ec, handler_fn handler);
 void vm_install_interrupt_handler(struct kvm_vm *vm, handler_fn handler);
 
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
 /* L3 index Bit[47:39] */
 #define PGTBL_L3_INDEX_MASK			0x0000FF8000000000ULL
 #define PGTBL_L3_INDEX_SHIFT			39
@@ -165,6 +180,16 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
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
 uint32_t guest_get_vcpuid(void);
 
 #endif /* SELFTEST_KVM_PROCESSOR_H */
diff --git a/tools/testing/selftests/kvm/include/riscv/sstc_timer.h b/tools/testing/selftests/kvm/include/riscv/sstc_timer.h
new file mode 100644
index 000000000000..7c4a4b26faa0
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/riscv/sstc_timer.h
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0 */
+/*
+ * RISC-V SSTC Timer specific interface
+ *
+ * Copyright (c) 2023 Intel Corporation
+ */
+
+#ifndef SELFTEST_KVM_SSTC_TIMER_H
+#define SELFTEST_KVM_SSTC_TIMER_H
+
+#include "processor.h"
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
+#endif /* SELFTEST_KVM_SSTC_TIMER_H */
diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index b8ad3e69a697..f6ce3d61738f 100644
--- a/tools/testing/selftests/kvm/lib/riscv/processor.c
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -15,6 +15,15 @@
 
 static vm_vaddr_t exception_handlers;
 
+bool vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
+{
+	unsigned long value = 0;
+
+	vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);
+
+	return !!value;
+}
+
 static uint64_t page_align(struct kvm_vm *vm, uint64_t v)
 {
 	return (v + vm->page_size) & ~(vm->page_size - 1);
diff --git a/tools/testing/selftests/kvm/riscv/sstc_timer.c b/tools/testing/selftests/kvm/riscv/sstc_timer.c
new file mode 100644
index 000000000000..867bd686a9c5
--- /dev/null
+++ b/tools/testing/selftests/kvm/riscv/sstc_timer.c
@@ -0,0 +1,382 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * sstc_timer.c - Tests the riscv64 sstc timer IRQ functionality
+ *
+ * The test validates the sstc timer IRQs using vstimecmp registers.
+ * This consitutes the four stages in the test. The guest's main thread
+ * configures the timer interrupt for a stage and waits for it to fire,
+ * with a timeout equal to the timer period. It asserts that the timeout
+ * doesn't exceed the timer period.
+ *
+ * On the other hand, upon receipt of an interrupt, the guest's interrupt
+ * handler validates the interrupt by checking if the architectural state
+ * is in compliance with the specifications.
+ *
+ * The test provides command-line options to configure the timer's
+ * period (-p), number of vCPUs (-n), and iterations per stage (-i).
+ * To stress-test the timer stack even more, an option to migrate the
+ * vCPUs across pCPUs (-m), at a particular rate, is also provided.
+ *
+ * Copyright (c) 2021, Google LLC.
+ * Copyright (c) 2023, Intel Corporation.
+ */
+
+#define _GNU_SOURCE
+
+#include <stdlib.h>
+#include <pthread.h>
+#include <linux/kvm.h>
+#include <linux/sizes.h>
+#include <linux/bitmap.h>
+#include <sys/sysinfo.h>
+
+#include "kvm_util.h"
+#include "processor.h"
+#include "sstc_timer.h"
+
+#define NR_VCPUS_DEF			4
+#define NR_TEST_ITERS_DEF		5
+#define TIMER_TEST_PERIOD_MS_DEF	10
+#define TIMER_TEST_ERR_MARGIN_US	100
+#define TIMER_TEST_MIGRATION_FREQ_MS	2
+
+struct test_args {
+	int nr_vcpus;
+	int nr_iter;
+	int timer_period_ms;
+	int migration_freq_ms;
+};
+
+static struct test_args test_args = {
+	.nr_vcpus = NR_VCPUS_DEF,
+	.nr_iter = NR_TEST_ITERS_DEF,
+	.timer_period_ms = TIMER_TEST_PERIOD_MS_DEF,
+	.migration_freq_ms = TIMER_TEST_MIGRATION_FREQ_MS,
+};
+
+#define msecs_to_usecs(msec)		((msec) * 1000LL)
+
+/* Shared variables between host and guest */
+struct test_vcpu_shared_data {
+	int nr_iter;
+	uint64_t xcnt;
+};
+
+static struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
+static pthread_t pt_vcpu_run[KVM_MAX_VCPUS];
+static struct test_vcpu_shared_data vcpu_shared_data[KVM_MAX_VCPUS];
+
+static int timer_irq = IRQ_S_TIMER;
+
+static unsigned long *vcpu_done_map;
+static pthread_mutex_t vcpu_done_map_lock;
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
+	GUEST_ASSERT_2(intid == timer_irq, intid, timer_irq);
+
+	GUEST_ASSERT_3(xcnt >= cval, xcnt, cval, xcnt_diff_us);
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
+		GUEST_ASSERT_2(config_iter + 1 == irq_iter,
+				config_iter + 1, irq_iter);
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
+static void *test_vcpu_run(void *arg)
+{
+	unsigned int vcpu_idx = (unsigned long)arg;
+	struct ucall uc;
+	struct kvm_vcpu *vcpu = vcpus[vcpu_idx];
+	struct kvm_vm *vm = vcpu->vm;
+	struct test_vcpu_shared_data *shared_data = &vcpu_shared_data[vcpu_idx];
+
+	vcpu_run(vcpu);
+
+	/* Currently, any exit from guest is an indication of completion */
+	pthread_mutex_lock(&vcpu_done_map_lock);
+	__set_bit(vcpu_idx, vcpu_done_map);
+	pthread_mutex_unlock(&vcpu_done_map_lock);
+
+	switch (get_ucall(vcpu, &uc)) {
+	case UCALL_SYNC:
+	case UCALL_DONE:
+		break;
+	case UCALL_ABORT:
+		sync_global_from_guest(vm, *shared_data);
+		REPORT_GUEST_ASSERT_N(uc, "values: %lu, %lu, %lu; vcpu: %u; iter: %u",
+				      GUEST_ASSERT_ARG(uc, 0),
+				      GUEST_ASSERT_ARG(uc, 1),
+				      GUEST_ASSERT_ARG(uc, 2),
+				      vcpu_idx,
+				      shared_data->nr_iter);
+		break;
+	default:
+		TEST_FAIL("Unexpected guest exit\n");
+	}
+
+	pr_info("PASS(vCPU-%d).\n", vcpu_idx);
+
+	return NULL;
+}
+
+static uint32_t test_get_pcpu(void)
+{
+	uint32_t pcpu;
+	unsigned int nproc_conf;
+	cpu_set_t online_cpuset;
+
+	nproc_conf = get_nprocs_conf();
+	sched_getaffinity(0, sizeof(cpu_set_t), &online_cpuset);
+
+	/* Randomly find an available pCPU to place a vCPU on */
+	do {
+		pcpu = rand() % nproc_conf;
+	} while (!CPU_ISSET(pcpu, &online_cpuset));
+
+	return pcpu;
+}
+
+static int test_migrate_vcpu(unsigned int vcpu_idx)
+{
+	int ret;
+	cpu_set_t cpuset;
+	uint32_t new_pcpu = test_get_pcpu();
+
+	CPU_ZERO(&cpuset);
+	CPU_SET(new_pcpu, &cpuset);
+
+	pr_debug("Migrating vCPU: %u to pCPU: %u\n", vcpu_idx, new_pcpu);
+
+	ret = pthread_setaffinity_np(pt_vcpu_run[vcpu_idx],
+				     sizeof(cpuset), &cpuset);
+
+	/* Allow the error where the vCPU thread is already finished */
+	TEST_ASSERT(ret == 0 || ret == ESRCH,
+		    "Failed to migrate the vCPU:%u to pCPU: %u; ret: %d\n",
+		    vcpu_idx, new_pcpu, ret);
+
+	return ret;
+}
+
+static void *test_vcpu_migration(void *arg)
+{
+	unsigned int i, n_done;
+	bool vcpu_done;
+
+	do {
+		usleep(msecs_to_usecs(test_args.migration_freq_ms));
+
+		for (n_done = 0, i = 0; i < test_args.nr_vcpus; i++) {
+			pthread_mutex_lock(&vcpu_done_map_lock);
+			vcpu_done = test_bit(i, vcpu_done_map);
+			pthread_mutex_unlock(&vcpu_done_map_lock);
+
+			if (vcpu_done) {
+				n_done++;
+				continue;
+			}
+
+			test_migrate_vcpu(i);
+		}
+	} while (test_args.nr_vcpus != n_done);
+
+	return NULL;
+}
+
+static void test_run(struct kvm_vm *vm)
+{
+	pthread_t pt_vcpu_migration;
+	unsigned int i;
+	int ret;
+
+	pthread_mutex_init(&vcpu_done_map_lock, NULL);
+	vcpu_done_map = bitmap_zalloc(test_args.nr_vcpus);
+	TEST_ASSERT(vcpu_done_map, "Failed to allocate vcpu done bitmap\n");
+
+	for (i = 0; i < (unsigned long)test_args.nr_vcpus; i++) {
+		ret = pthread_create(&pt_vcpu_run[i], NULL, test_vcpu_run,
+				     (void *)(unsigned long)i);
+		TEST_ASSERT(!ret, "Failed to create vCPU-%d pthread\n", i);
+	}
+
+	/* Spawn a thread to control the vCPU migrations */
+	if (test_args.migration_freq_ms) {
+		srand(time(NULL));
+
+		ret = pthread_create(&pt_vcpu_migration, NULL,
+					test_vcpu_migration, NULL);
+		TEST_ASSERT(!ret, "Failed to create the migration pthread\n");
+	}
+
+	for (i = 0; i < test_args.nr_vcpus; i++)
+		pthread_join(pt_vcpu_run[i], NULL);
+
+	if (test_args.migration_freq_ms)
+		pthread_join(pt_vcpu_migration, NULL);
+
+	bitmap_free(vcpu_done_map);
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
+static struct kvm_vm *test_vm_create(void)
+{
+	struct kvm_vm *vm;
+	int nr_vcpus = test_args.nr_vcpus;
+
+	vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
+	__TEST_REQUIRE(vcpu_has_ext(vcpus[0], KVM_RISCV_ISA_EXT_SSTC),
+				   "SSTC not available, skipping test\n");
+
+	vm_init_trap_vector_tables(vm);
+	vm_install_interrupt_handler(vm, guest_irq_handler);
+
+	for (int i = 0; i < nr_vcpus; i++)
+		vcpu_init_trap_vector_tables(vcpus[i]);
+
+	test_init_timer_freq(vm);
+
+	/* Make all the test's cmdline args visible to the guest */
+	sync_global_to_guest(vm, test_args);
+
+	return vm;
+}
+
+static void test_vm_cleanup(struct kvm_vm *vm)
+{
+	kvm_vm_free(vm);
+}
+
+static void test_print_help(char *name)
+{
+	pr_info("Usage: %s [-h] [-n nr_vcpus] [-i iterations] [-p timer_period_ms]\n",
+		name);
+	pr_info("\t-n: Number of vCPUs to configure (default: %u; max: %u)\n",
+		NR_VCPUS_DEF, KVM_MAX_VCPUS);
+	pr_info("\t-i: Number of iterations per stage (default: %u)\n",
+		NR_TEST_ITERS_DEF);
+	pr_info("\t-p: Periodicity (in ms) of the guest timer (default: %u)\n",
+		TIMER_TEST_PERIOD_MS_DEF);
+	pr_info("\t-m: Frequency (in ms) of vCPUs to migrate to different pCPU. 0 to turn off (default: %u)\n",
+		TIMER_TEST_MIGRATION_FREQ_MS);
+	pr_info("\t-h: print this help screen\n");
+}
+
+static bool parse_args(int argc, char *argv[])
+{
+	int opt;
+
+	while ((opt = getopt(argc, argv, "hn:i:p:m:o:")) != -1) {
+		switch (opt) {
+		case 'n':
+			test_args.nr_vcpus = atoi_positive("Number of vCPUs", optarg);
+			if (test_args.nr_vcpus > KVM_MAX_VCPUS) {
+				pr_info("Max allowed vCPUs: %u\n",
+					KVM_MAX_VCPUS);
+				goto err;
+			}
+			break;
+		case 'i':
+			test_args.nr_iter = atoi_positive("Number of iterations", optarg);
+			break;
+		case 'p':
+			test_args.timer_period_ms = atoi_positive("Periodicity", optarg);
+			break;
+		case 'm':
+			test_args.migration_freq_ms = atoi_non_negative("Frequency", optarg);
+			break;
+		case 'h':
+		default:
+			goto err;
+		}
+	}
+
+	return true;
+
+err:
+	test_print_help(argv[0]);
+	return false;
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vm *vm;
+
+	if (!parse_args(argc, argv))
+		exit(KSFT_SKIP);
+
+	__TEST_REQUIRE(!test_args.migration_freq_ms || get_nprocs() >= 2,
+		       "At least two physical CPUs needed for vCPU migration");
+
+	vm = test_vm_create();
+	test_run(vm);
+	test_vm_cleanup(vm);
+
+	return 0;
+}
-- 
2.34.1

