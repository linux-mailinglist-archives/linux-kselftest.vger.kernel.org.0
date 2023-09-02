Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2587907E3
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Sep 2023 14:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352187AbjIBMvn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Sep 2023 08:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjIBMvm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Sep 2023 08:51:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A268510F9;
        Sat,  2 Sep 2023 05:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693659097; x=1725195097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eQHGwpq/BgRDtD59gSM0IBvE6jqNy56udksu6EID5DE=;
  b=lbhzWnPcaQEGDaGyxyIxoQwA237riBUZxK9kJVqWywadbmPMu3pOuAVU
   Kr5CJ0UH0z4NhG7eh23DkRCXD82y7kIFLXkPKWW0iAT2huK2GTK0IM7kb
   dCOqTeZbExDMbv51rn6l9Apil+aqNcV1qEuSfUZNJ1RgL0QuQMWFw1Jjv
   2HP/dPAXfBu33Mn351p4mhNsVktLgYmJbItXOzNeKDRdj8sOvrAUl0ae0
   L0tbefoRiK2MXQ7YdkjxmdyI+pbh51PMvxTcJpaozivR3/6Ex2DHdYyGT
   VUrsZkKeEXCiK4tUcuOrE7V74yfqec3fTmRVMKhLsqjHDjdGVFYQEz7eo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10821"; a="366599208"
X-IronPort-AV: E=Sophos;i="6.02,222,1688454000"; 
   d="scan'208";a="366599208"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2023 05:51:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10821"; a="855022005"
X-IronPort-AV: E=Sophos;i="6.02,222,1688454000"; 
   d="scan'208";a="855022005"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2023 05:51:27 -0700
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
        Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Sean Christopherson <seanjc@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Lei Wang <lei4.wang@intel.com>, Like Xu <likexu@tencent.com>,
        Peter Gonda <pgonda@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Thomas Huth <thuth@redhat.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Michal Luczaj <mhal@rbox.co>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Subject: [PATCH v2 2/8] KVM: arm64: selftest: Split arch_timer test code
Date:   Sat,  2 Sep 2023 20:59:24 +0800
Message-Id: <c87337cfd7fb135e2efed589360a78c26a402eac.1693659382.git.haibo1.xu@intel.com>
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

Split the arch-neutral test code out of aarch64/arch_timer.c
and put them into a common arch_timer.c. This is a preparation
to share timer test codes in riscv.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 tools/testing/selftests/kvm/Makefile          |   9 +-
 .../selftests/kvm/aarch64/arch_timer.c        | 288 +-----------------
 tools/testing/selftests/kvm/arch_timer.c      | 252 +++++++++++++++
 .../selftests/kvm/include/timer_test.h        |  52 ++++
 4 files changed, 317 insertions(+), 284 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/arch_timer.c
 create mode 100644 tools/testing/selftests/kvm/include/timer_test.h

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 0b9c42fbce8c..fb8904e2c06a 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -140,7 +140,6 @@ TEST_GEN_PROGS_x86_64 += system_counter_offset_test
 TEST_GEN_PROGS_EXTENDED_x86_64 += x86_64/nx_huge_pages_test
 
 TEST_GEN_PROGS_aarch64 += aarch64/aarch32_id_regs
-TEST_GEN_PROGS_aarch64 += aarch64/arch_timer
 TEST_GEN_PROGS_aarch64 += aarch64/debug-exceptions
 TEST_GEN_PROGS_aarch64 += aarch64/hypercalls
 TEST_GEN_PROGS_aarch64 += aarch64/page_fault_test
@@ -150,6 +149,7 @@ TEST_GEN_PROGS_aarch64 += aarch64/vcpu_width_config
 TEST_GEN_PROGS_aarch64 += aarch64/vgic_init
 TEST_GEN_PROGS_aarch64 += aarch64/vgic_irq
 TEST_GEN_PROGS_aarch64 += access_tracking_perf_test
+TEST_GEN_PROGS_aarch64 += arch_timer
 TEST_GEN_PROGS_aarch64 += demand_paging_test
 TEST_GEN_PROGS_aarch64 += dirty_log_test
 TEST_GEN_PROGS_aarch64 += dirty_log_perf_test
@@ -188,6 +188,7 @@ TEST_GEN_PROGS_riscv += set_memory_region_test
 TEST_GEN_PROGS_riscv += kvm_binary_stats_test
 
 SPLIT_TESTS += get-reg-list
+SPLIT_TESTS += arch_timer
 
 TEST_PROGS += $(TEST_PROGS_$(ARCH_DIR))
 TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(ARCH_DIR))
@@ -248,13 +249,10 @@ TEST_DEP_FILES += $(patsubst %.o, %.d, $(SPLIT_TESTS_OBJS))
 -include $(TEST_DEP_FILES)
 
 $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): %: %.o
-	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $< $(LIBKVM_OBJS) $(LDLIBS) -o $@
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $^ $(LDLIBS) -o $@
 $(TEST_GEN_OBJ): $(OUTPUT)/%.o: %.c
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
 
-$(SPLIT_TESTS_TARGETS): %: %.o $(SPLIT_TESTS_OBJS)
-	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $^ $(LDLIBS) -o $@
-
 EXTRA_CLEAN += $(LIBKVM_OBJS) $(TEST_DEP_FILES) $(TEST_GEN_OBJ) $(SPLIT_TESTS_OBJS) cscope.*
 
 x := $(shell mkdir -p $(sort $(dir $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ))))
@@ -273,6 +271,7 @@ $(LIBKVM_STRING_OBJ): $(OUTPUT)/%.o: %.c
 x := $(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
 $(TEST_GEN_PROGS): $(LIBKVM_OBJS)
 $(TEST_GEN_PROGS_EXTENDED): $(LIBKVM_OBJS)
+$(SPLIT_TESTS_TARGETS): $(OUTPUT)/%: $(ARCH_DIR)/%.o
 
 cscope: include_paths = $(LINUX_TOOL_INCLUDE) $(LINUX_HDR_PATH) include lib ..
 cscope:
diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/testing/selftests/kvm/aarch64/arch_timer.c
index b63859829a96..ceb649548751 100644
--- a/tools/testing/selftests/kvm/aarch64/arch_timer.c
+++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
@@ -1,91 +1,25 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * arch_timer.c - Tests the aarch64 timer IRQ functionality
- *
  * The test validates both the virtual and physical timer IRQs using
- * CVAL and TVAL registers. This consitutes the four stages in the test.
- * The guest's main thread configures the timer interrupt for a stage
- * and waits for it to fire, with a timeout equal to the timer period.
- * It asserts that the timeout doesn't exceed the timer period.
- *
- * On the other hand, upon receipt of an interrupt, the guest's interrupt
- * handler validates the interrupt by checking if the architectural state
- * is in compliance with the specifications.
- *
- * The test provides command-line options to configure the timer's
- * period (-p), number of vCPUs (-n), and iterations per stage (-i).
- * To stress-test the timer stack even more, an option to migrate the
- * vCPUs across pCPUs (-m), at a particular rate, is also provided.
+ * CVAL and TVAL registers.
  *
  * Copyright (c) 2021, Google LLC.
  */
 #define _GNU_SOURCE
 
-#include <stdlib.h>
-#include <pthread.h>
-#include <linux/kvm.h>
-#include <linux/sizes.h>
-#include <linux/bitmap.h>
-#include <sys/sysinfo.h>
-
-#include "kvm_util.h"
-#include "processor.h"
-#include "delay.h"
 #include "arch_timer.h"
+#include "delay.h"
 #include "gic.h"
+#include "processor.h"
+#include "timer_test.h"
 #include "vgic.h"
 
-#define NR_VCPUS_DEF			4
-#define NR_TEST_ITERS_DEF		5
-#define TIMER_TEST_PERIOD_MS_DEF	10
-#define TIMER_TEST_ERR_MARGIN_US	100
-#define TIMER_TEST_MIGRATION_FREQ_MS	2
-
-struct test_args {
-	int nr_vcpus;
-	int nr_iter;
-	int timer_period_ms;
-	int migration_freq_ms;
-	struct kvm_arm_counter_offset offset;
-};
-
-static struct test_args test_args = {
-	.nr_vcpus = NR_VCPUS_DEF,
-	.nr_iter = NR_TEST_ITERS_DEF,
-	.timer_period_ms = TIMER_TEST_PERIOD_MS_DEF,
-	.migration_freq_ms = TIMER_TEST_MIGRATION_FREQ_MS,
-	.offset = { .reserved = 1 },
-};
-
-#define msecs_to_usecs(msec)		((msec) * 1000LL)
-
-#define GICD_BASE_GPA			0x8000000ULL
-#define GICR_BASE_GPA			0x80A0000ULL
-
-enum guest_stage {
-	GUEST_STAGE_VTIMER_CVAL = 1,
-	GUEST_STAGE_VTIMER_TVAL,
-	GUEST_STAGE_PTIMER_CVAL,
-	GUEST_STAGE_PTIMER_TVAL,
-	GUEST_STAGE_MAX,
-};
-
-/* Shared variables between host and guest */
-struct test_vcpu_shared_data {
-	int nr_iter;
-	enum guest_stage guest_stage;
-	uint64_t xcnt;
-};
-
-static struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
-static pthread_t pt_vcpu_run[KVM_MAX_VCPUS];
-static struct test_vcpu_shared_data vcpu_shared_data[KVM_MAX_VCPUS];
+extern struct test_args test_args;
+extern struct kvm_vcpu *vcpus[];
+extern struct test_vcpu_shared_data vcpu_shared_data[];
 
 static int vtimer_irq, ptimer_irq;
 
-static unsigned long *vcpu_done_map;
-static pthread_mutex_t vcpu_done_map_lock;
-
 static void
 guest_configure_timer_action(struct test_vcpu_shared_data *shared_data)
 {
@@ -222,137 +156,6 @@ static void guest_code(void)
 	GUEST_DONE();
 }
 
-static void *test_vcpu_run(void *arg)
-{
-	unsigned int vcpu_idx = (unsigned long)arg;
-	struct ucall uc;
-	struct kvm_vcpu *vcpu = vcpus[vcpu_idx];
-	struct kvm_vm *vm = vcpu->vm;
-	struct test_vcpu_shared_data *shared_data = &vcpu_shared_data[vcpu_idx];
-
-	vcpu_run(vcpu);
-
-	/* Currently, any exit from guest is an indication of completion */
-	pthread_mutex_lock(&vcpu_done_map_lock);
-	__set_bit(vcpu_idx, vcpu_done_map);
-	pthread_mutex_unlock(&vcpu_done_map_lock);
-
-	switch (get_ucall(vcpu, &uc)) {
-	case UCALL_SYNC:
-	case UCALL_DONE:
-		break;
-	case UCALL_ABORT:
-		sync_global_from_guest(vm, *shared_data);
-		fprintf(stderr, "Guest assert failed,  vcpu %u; stage; %u; iter: %u\n",
-			vcpu_idx, shared_data->guest_stage, shared_data->nr_iter);
-		REPORT_GUEST_ASSERT(uc);
-		break;
-	default:
-		TEST_FAIL("Unexpected guest exit\n");
-	}
-
-	return NULL;
-}
-
-static uint32_t test_get_pcpu(void)
-{
-	uint32_t pcpu;
-	unsigned int nproc_conf;
-	cpu_set_t online_cpuset;
-
-	nproc_conf = get_nprocs_conf();
-	sched_getaffinity(0, sizeof(cpu_set_t), &online_cpuset);
-
-	/* Randomly find an available pCPU to place a vCPU on */
-	do {
-		pcpu = rand() % nproc_conf;
-	} while (!CPU_ISSET(pcpu, &online_cpuset));
-
-	return pcpu;
-}
-
-static int test_migrate_vcpu(unsigned int vcpu_idx)
-{
-	int ret;
-	cpu_set_t cpuset;
-	uint32_t new_pcpu = test_get_pcpu();
-
-	CPU_ZERO(&cpuset);
-	CPU_SET(new_pcpu, &cpuset);
-
-	pr_debug("Migrating vCPU: %u to pCPU: %u\n", vcpu_idx, new_pcpu);
-
-	ret = pthread_setaffinity_np(pt_vcpu_run[vcpu_idx],
-				     sizeof(cpuset), &cpuset);
-
-	/* Allow the error where the vCPU thread is already finished */
-	TEST_ASSERT(ret == 0 || ret == ESRCH,
-		    "Failed to migrate the vCPU:%u to pCPU: %u; ret: %d\n",
-		    vcpu_idx, new_pcpu, ret);
-
-	return ret;
-}
-
-static void *test_vcpu_migration(void *arg)
-{
-	unsigned int i, n_done;
-	bool vcpu_done;
-
-	do {
-		usleep(msecs_to_usecs(test_args.migration_freq_ms));
-
-		for (n_done = 0, i = 0; i < test_args.nr_vcpus; i++) {
-			pthread_mutex_lock(&vcpu_done_map_lock);
-			vcpu_done = test_bit(i, vcpu_done_map);
-			pthread_mutex_unlock(&vcpu_done_map_lock);
-
-			if (vcpu_done) {
-				n_done++;
-				continue;
-			}
-
-			test_migrate_vcpu(i);
-		}
-	} while (test_args.nr_vcpus != n_done);
-
-	return NULL;
-}
-
-static void test_run(struct kvm_vm *vm)
-{
-	pthread_t pt_vcpu_migration;
-	unsigned int i;
-	int ret;
-
-	pthread_mutex_init(&vcpu_done_map_lock, NULL);
-	vcpu_done_map = bitmap_zalloc(test_args.nr_vcpus);
-	TEST_ASSERT(vcpu_done_map, "Failed to allocate vcpu done bitmap\n");
-
-	for (i = 0; i < (unsigned long)test_args.nr_vcpus; i++) {
-		ret = pthread_create(&pt_vcpu_run[i], NULL, test_vcpu_run,
-				     (void *)(unsigned long)i);
-		TEST_ASSERT(!ret, "Failed to create vCPU-%d pthread\n", i);
-	}
-
-	/* Spawn a thread to control the vCPU migrations */
-	if (test_args.migration_freq_ms) {
-		srand(time(NULL));
-
-		ret = pthread_create(&pt_vcpu_migration, NULL,
-					test_vcpu_migration, NULL);
-		TEST_ASSERT(!ret, "Failed to create the migration pthread\n");
-	}
-
-
-	for (i = 0; i < test_args.nr_vcpus; i++)
-		pthread_join(pt_vcpu_run[i], NULL);
-
-	if (test_args.migration_freq_ms)
-		pthread_join(pt_vcpu_migration, NULL);
-
-	bitmap_free(vcpu_done_map);
-}
-
 static void test_init_timer_irq(struct kvm_vm *vm)
 {
 	/* Timer initid should be same for all the vCPUs, so query only vCPU-0 */
@@ -369,7 +172,7 @@ static void test_init_timer_irq(struct kvm_vm *vm)
 
 static int gic_fd;
 
-static struct kvm_vm *test_vm_create(void)
+struct kvm_vm *test_vm_create(void)
 {
 	struct kvm_vm *vm;
 	unsigned int i;
@@ -400,81 +203,8 @@ static struct kvm_vm *test_vm_create(void)
 	return vm;
 }
 
-static void test_vm_cleanup(struct kvm_vm *vm)
+void test_vm_cleanup(struct kvm_vm *vm)
 {
 	close(gic_fd);
 	kvm_vm_free(vm);
 }
-
-static void test_print_help(char *name)
-{
-	pr_info("Usage: %s [-h] [-n nr_vcpus] [-i iterations] [-p timer_period_ms]\n",
-		name);
-	pr_info("\t-n: Number of vCPUs to configure (default: %u; max: %u)\n",
-		NR_VCPUS_DEF, KVM_MAX_VCPUS);
-	pr_info("\t-i: Number of iterations per stage (default: %u)\n",
-		NR_TEST_ITERS_DEF);
-	pr_info("\t-p: Periodicity (in ms) of the guest timer (default: %u)\n",
-		TIMER_TEST_PERIOD_MS_DEF);
-	pr_info("\t-m: Frequency (in ms) of vCPUs to migrate to different pCPU. 0 to turn off (default: %u)\n",
-		TIMER_TEST_MIGRATION_FREQ_MS);
-	pr_info("\t-o: Counter offset (in counter cycles, default: 0)\n");
-	pr_info("\t-h: print this help screen\n");
-}
-
-static bool parse_args(int argc, char *argv[])
-{
-	int opt;
-
-	while ((opt = getopt(argc, argv, "hn:i:p:m:o:")) != -1) {
-		switch (opt) {
-		case 'n':
-			test_args.nr_vcpus = atoi_positive("Number of vCPUs", optarg);
-			if (test_args.nr_vcpus > KVM_MAX_VCPUS) {
-				pr_info("Max allowed vCPUs: %u\n",
-					KVM_MAX_VCPUS);
-				goto err;
-			}
-			break;
-		case 'i':
-			test_args.nr_iter = atoi_positive("Number of iterations", optarg);
-			break;
-		case 'p':
-			test_args.timer_period_ms = atoi_positive("Periodicity", optarg);
-			break;
-		case 'm':
-			test_args.migration_freq_ms = atoi_non_negative("Frequency", optarg);
-			break;
-		case 'o':
-			test_args.offset.counter_offset = strtol(optarg, NULL, 0);
-			test_args.offset.reserved = 0;
-			break;
-		case 'h':
-		default:
-			goto err;
-		}
-	}
-
-	return true;
-
-err:
-	test_print_help(argv[0]);
-	return false;
-}
-
-int main(int argc, char *argv[])
-{
-	struct kvm_vm *vm;
-
-	if (!parse_args(argc, argv))
-		exit(KSFT_SKIP);
-
-	__TEST_REQUIRE(!test_args.migration_freq_ms || get_nprocs() >= 2,
-		       "At least two physical CPUs needed for vCPU migration");
-
-	vm = test_vm_create();
-	test_run(vm);
-	test_vm_cleanup(vm);
-
-	return 0;
-}
diff --git a/tools/testing/selftests/kvm/arch_timer.c b/tools/testing/selftests/kvm/arch_timer.c
new file mode 100644
index 000000000000..529024f58c98
--- /dev/null
+++ b/tools/testing/selftests/kvm/arch_timer.c
@@ -0,0 +1,252 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * arch_timer.c - Tests the arch timer IRQ functionality
+ *
+ * The guest's main thread configures the timer interrupt for and waits
+ * for it to fire, with a timeout equal to the timer period.
+ * It asserts that the timeout doesn't exceed the timer period.
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
+ */
+
+#define _GNU_SOURCE
+
+#include <stdlib.h>
+#include <pthread.h>
+#include <linux/sizes.h>
+#include <linux/bitmap.h>
+#include <sys/sysinfo.h>
+
+#include "timer_test.h"
+
+struct test_args test_args = {
+    .nr_vcpus = NR_VCPUS_DEF,
+    .nr_iter = NR_TEST_ITERS_DEF,
+    .timer_period_ms = TIMER_TEST_PERIOD_MS_DEF,
+    .migration_freq_ms = TIMER_TEST_MIGRATION_FREQ_MS,
+#ifdef __aarch64__
+    .offset = { .reserved = 1 },
+#endif
+};
+
+struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
+struct test_vcpu_shared_data vcpu_shared_data[KVM_MAX_VCPUS];
+
+static pthread_t pt_vcpu_run[KVM_MAX_VCPUS];
+static unsigned long *vcpu_done_map;
+static pthread_mutex_t vcpu_done_map_lock;
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
+		fprintf(stderr, "Guest assert failed,  vcpu %u; stage; %u; iter: %u\n",
+		        vcpu_idx, shared_data->guest_stage, shared_data->nr_iter);
+		REPORT_GUEST_ASSERT(uc);
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
+	pr_info("\t-o: Counter offset (in counter cycles, default: 0)\n");
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
+		case 'o':
+			test_args.offset.counter_offset = strtol(optarg, NULL, 0);
+			test_args.offset.reserved = 0;
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
diff --git a/tools/testing/selftests/kvm/include/timer_test.h b/tools/testing/selftests/kvm/include/timer_test.h
new file mode 100644
index 000000000000..109e4d635627
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/timer_test.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * tools/testing/selftests/kvm/include/timer_test.h
+ *
+ * Copyright (C) 2018, Google LLC
+ */
+
+#ifndef SELFTEST_KVM_TIMER_TEST_H
+#define SELFTEST_KVM_TIMER_TEST_H
+
+#include "kvm_util.h"
+
+#define NR_VCPUS_DEF            4
+#define NR_TEST_ITERS_DEF       5
+#define TIMER_TEST_PERIOD_MS_DEF    10
+#define TIMER_TEST_ERR_MARGIN_US    100
+#define TIMER_TEST_MIGRATION_FREQ_MS    2
+
+#define msecs_to_usecs(msec)    ((msec) * 1000LL)
+
+#define GICD_BASE_GPA    0x8000000ULL
+#define GICR_BASE_GPA    0x80A0000ULL
+
+enum guest_stage {
+	GUEST_STAGE_VTIMER_CVAL=1,
+	GUEST_STAGE_VTIMER_TVAL,
+	GUEST_STAGE_PTIMER_CVAL,
+	GUEST_STAGE_PTIMER_TVAL,
+	GUEST_STAGE_MAX,
+};
+
+/* Timer test cmdline parameters */
+struct test_args
+{
+	int nr_vcpus;
+	int nr_iter;
+	int timer_period_ms;
+	int migration_freq_ms;
+	struct kvm_arm_counter_offset offset;
+};
+
+/* Shared variables between host and guest */
+struct test_vcpu_shared_data {
+	int nr_iter;
+	enum guest_stage guest_stage;
+	uint64_t xcnt;
+};
+
+struct kvm_vm* test_vm_create(void);
+void test_vm_cleanup(struct kvm_vm *vm);
+
+#endif /* SELFTEST_KVM_TIMER_TEST_H */
-- 
2.34.1

