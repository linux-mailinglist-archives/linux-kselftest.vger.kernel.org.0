Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B5379F64F
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 03:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbjINB3B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Sep 2023 21:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbjINB3B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Sep 2023 21:29:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0803A1BD0;
        Wed, 13 Sep 2023 18:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694654937; x=1726190937;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5UfZoKGBq/7/L2LJ952Ru+6rkK0Om5Ix7dA2Fgs+OGg=;
  b=eMb1SORDVa5tTKD/ul+Ugu27vEViDP5Zk0E3QM73TpxOe5pCj4jGwdnC
   CeDgEEN9YP7GwonNp2gQpkXmaBO2wa+DSoOozp86NOZHhI3LGseiGDA4N
   DxEY5HSFOnKgkI9YBWVZ6YbK5fNuoF6vP+QSPrdWjHiAQ4lyTGSROSyfC
   cJpAK8MQU8D5JdYNamkwmzylHaQn9jDo1ReLdkfBxSBmQP50BEQeAGud4
   /M+VMq+fg7BYmAu9/r7Uasg5aX/laLSDEBpNMJHBMQcrfWI+5W78fmhky
   0lR7/YMU8TfhVxwI3+yd0REkMjqA42fN9Y+3CBCjWhs8ska6RQkKxR1Lb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="377734095"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="377734095"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 18:28:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="694049232"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="694049232"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 18:28:33 -0700
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
Subject: [PATCH v3 3/9] KVM: arm64: selftests: Split arch_timer test code
Date:   Thu, 14 Sep 2023 09:36:57 +0800
Message-Id: <66f81991b15de608c43c96c911387cf0ee0a49b1.1694421911.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694421911.git.haibo1.xu@intel.com>
References: <cover.1694421911.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 tools/testing/selftests/kvm/Makefile          |   3 +-
 .../selftests/kvm/aarch64/arch_timer.c        | 275 +-----------------
 tools/testing/selftests/kvm/arch_timer.c      | 248 ++++++++++++++++
 .../testing/selftests/kvm/include/test_util.h |   2 +
 .../selftests/kvm/include/timer_test.h        |  42 +++
 5 files changed, 300 insertions(+), 270 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/arch_timer.c
 create mode 100644 tools/testing/selftests/kvm/include/timer_test.h

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 7972269e8c5f..0102a0297b84 100644
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
@@ -188,6 +188,7 @@ TEST_GEN_PROGS_riscv += kvm_page_table_test
 TEST_GEN_PROGS_riscv += set_memory_region_test
 TEST_GEN_PROGS_riscv += kvm_binary_stats_test
 
+SPLIT_TESTS += arch_timer
 SPLIT_TESTS += get-reg-list
 
 TEST_PROGS += $(TEST_PROGS_$(ARCH_DIR))
diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/testing/selftests/kvm/aarch64/arch_timer.c
index b63859829a96..4688b258247c 100644
--- a/tools/testing/selftests/kvm/aarch64/arch_timer.c
+++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
@@ -1,64 +1,19 @@
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
 #define GICD_BASE_GPA			0x8000000ULL
 #define GICR_BASE_GPA			0x80A0000ULL
 
@@ -70,22 +25,8 @@ enum guest_stage {
 	GUEST_STAGE_MAX,
 };
 
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
-
 static int vtimer_irq, ptimer_irq;
 
-static unsigned long *vcpu_done_map;
-static pthread_mutex_t vcpu_done_map_lock;
-
 static void
 guest_configure_timer_action(struct test_vcpu_shared_data *shared_data)
 {
@@ -222,137 +163,6 @@ static void guest_code(void)
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
@@ -369,7 +179,7 @@ static void test_init_timer_irq(struct kvm_vm *vm)
 
 static int gic_fd;
 
-static struct kvm_vm *test_vm_create(void)
+struct kvm_vm *test_vm_create(void)
 {
 	struct kvm_vm *vm;
 	unsigned int i;
@@ -400,81 +210,8 @@ static struct kvm_vm *test_vm_create(void)
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
index 000000000000..ea3dd1a772b0
--- /dev/null
+++ b/tools/testing/selftests/kvm/arch_timer.c
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * arch_timer.c - Tests the arch timer IRQ functionality
+ *
+ * The guest's main thread configures the timer interrupt and waits
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
+	.nr_vcpus = NR_VCPUS_DEF,
+	.nr_iter = NR_TEST_ITERS_DEF,
+	.timer_period_ms = TIMER_TEST_PERIOD_MS_DEF,
+	.migration_freq_ms = TIMER_TEST_MIGRATION_FREQ_MS,
+	.offset = { .reserved = 1 },
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
+			vcpu_idx, shared_data->guest_stage, shared_data->nr_iter);
+		REPORT_GUEST_ASSERT(uc);
+		break;
+	default:
+		TEST_FAIL("Unexpected guest exit\n");
+	}
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
diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index 7e614adc6cf4..c019675f6259 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -20,6 +20,8 @@
 #include <sys/mman.h>
 #include "kselftest.h"
 
+#define msecs_to_usecs(msec)    ((msec) * 1000LL)
+
 static inline int _no_printf(const char *format, ...) { return 0; }
 
 #ifdef DEBUG
diff --git a/tools/testing/selftests/kvm/include/timer_test.h b/tools/testing/selftests/kvm/include/timer_test.h
new file mode 100644
index 000000000000..04e8aff2dc22
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/timer_test.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * timer test specific header
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
+/* Timer test cmdline parameters */
+struct test_args {
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
+	int guest_stage;
+	uint64_t xcnt;
+};
+
+extern struct test_args test_args;
+extern struct kvm_vcpu *vcpus[];
+extern struct test_vcpu_shared_data vcpu_shared_data[];
+
+struct kvm_vm *test_vm_create(void);
+void test_vm_cleanup(struct kvm_vm *vm);
+
+#endif /* SELFTEST_KVM_TIMER_TEST_H */
-- 
2.34.1

