Return-Path: <linux-kselftest+bounces-3301-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2D4835E7D
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 10:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D00031C23300
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 09:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2364A39FC4;
	Mon, 22 Jan 2024 09:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hz8/mil2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D3A3A1A8;
	Mon, 22 Jan 2024 09:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705916773; cv=none; b=KYHDlcgR/EU2ZQtVuNUfWyc9+6m8XeLaGNZJw9/fRLlqk7RjCxsntGRyafbLPxgRq/Q0aDFTYZ9g8BrDSNiA2mpWbzEE9OJgQf8oRuSMzkXdBj6HGgRu8z8nYDnDUzFqZT/SjAnfLie2hCTIlGNJoZIXgiR62OHvbpvst/98CcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705916773; c=relaxed/simple;
	bh=tuNfZyFQJOjO6b1GgUsPV7L2A+l9MVUTgPfPqK04Sw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oBe5w53IDH31BUKh8etQkTzLArgB3+bdCE4YIXCrA0eB/IH8wTZP4Ykg0W74g3lM1lSjc3TxYW2TEvNVQcFsG9av+qgmTrsk0UlbvEz6QGsxDATKyqLlFdKx5Utjlz6KfhZNH5WrfNQ4JjyUPivAW+60nwLfu/x2S1Ojr9D5Veo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hz8/mil2; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705916771; x=1737452771;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tuNfZyFQJOjO6b1GgUsPV7L2A+l9MVUTgPfPqK04Sw4=;
  b=Hz8/mil2Qaa118W+e+QykOyQW2CMs8wuDFwEf/wqh0+rbGWthCK24deE
   HpYefTbb6NyN0A2b5rX7C2RuaQCn685Nz9svu7mqkpT6QUaMcwq51XkBJ
   qDXMCbwUD3az/ar02JQBz3kcTZ5ICbiX5K3ztU6z3qPZAUDpjljg1ZV5y
   nwSe7ltQfRhtimByruld9s6yafHcYGC6kXt1wEqs2b6AmZKm/S2DspKvv
   DMzLvGnVSj0M1xwDSrN22VVQboPbEaeYYXO5cboGAbDIPegZN4vaiTcki
   OdBDEZZF+3VVi+AwixpUkTCyVd2dpKg7qNT7magUGqzXehKqVdmBcsQBC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="22641682"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="22641682"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 01:46:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="778535386"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="778535386"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 01:45:59 -0800
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
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Minda Chen <minda.chen@starfivetech.com>,
	Sean Christopherson <seanjc@google.com>,
	Peter Xu <peterx@redhat.com>,
	Like Xu <likexu@tencent.com>,
	Vipin Sharma <vipinsh@google.com>,
	Thomas Huth <thuth@redhat.com>,
	Aaron Lewis <aaronlewis@google.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	kvm-riscv@lists.infradead.org
Subject: [PATCH v5 04/12] KVM: arm64: selftests: Split arch_timer test code
Date: Mon, 22 Jan 2024 17:58:34 +0800
Message-Id: <7c4a2c6ac0e90c123ddf521dd2951110a791daff.1705916069.git.haibo1.xu@intel.com>
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

Split the arch-neutral test code out of aarch64/arch_timer.c
and put them into a common arch_timer.c. This is a preparation
to share timer test codes in riscv.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 tools/testing/selftests/kvm/Makefile          |   3 +-
 .../selftests/kvm/aarch64/arch_timer.c        | 285 +-----------------
 tools/testing/selftests/kvm/arch_timer.c      | 257 ++++++++++++++++
 .../testing/selftests/kvm/include/test_util.h |   2 +
 .../selftests/kvm/include/timer_test.h        |  44 +++
 5 files changed, 311 insertions(+), 280 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/arch_timer.c
 create mode 100644 tools/testing/selftests/kvm/include/timer_test.h

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index c5e9abb185b6..87f0f76ea639 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -141,7 +141,6 @@ TEST_GEN_PROGS_x86_64 += system_counter_offset_test
 TEST_GEN_PROGS_EXTENDED_x86_64 += x86_64/nx_huge_pages_test
 
 TEST_GEN_PROGS_aarch64 += aarch64/aarch32_id_regs
-TEST_GEN_PROGS_aarch64 += aarch64/arch_timer
 TEST_GEN_PROGS_aarch64 += aarch64/debug-exceptions
 TEST_GEN_PROGS_aarch64 += aarch64/hypercalls
 TEST_GEN_PROGS_aarch64 += aarch64/page_fault_test
@@ -153,6 +152,7 @@ TEST_GEN_PROGS_aarch64 += aarch64/vgic_init
 TEST_GEN_PROGS_aarch64 += aarch64/vgic_irq
 TEST_GEN_PROGS_aarch64 += aarch64/vpmu_counter_access
 TEST_GEN_PROGS_aarch64 += access_tracking_perf_test
+TEST_GEN_PROGS_aarch64 += arch_timer
 TEST_GEN_PROGS_aarch64 += demand_paging_test
 TEST_GEN_PROGS_aarch64 += dirty_log_test
 TEST_GEN_PROGS_aarch64 += dirty_log_perf_test
@@ -191,6 +191,7 @@ TEST_GEN_PROGS_riscv += kvm_page_table_test
 TEST_GEN_PROGS_riscv += set_memory_region_test
 TEST_GEN_PROGS_riscv += kvm_binary_stats_test
 
+SPLIT_TESTS += arch_timer
 SPLIT_TESTS += get-reg-list
 
 TEST_PROGS += $(TEST_PROGS_$(ARCH_DIR))
diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/testing/selftests/kvm/aarch64/arch_timer.c
index 9b9a119bdd61..a4732ec9f761 100644
--- a/tools/testing/selftests/kvm/aarch64/arch_timer.c
+++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
@@ -1,68 +1,19 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * arch_timer.c - Tests the aarch64 timer IRQ functionality
- *
  * The test validates both the virtual and physical timer IRQs using
- * CVAL and TVAL registers. This consitutes the four stages in the test.
- * The guest's main thread configures the timer interrupt for a stage
- * and waits for it to fire, with a timeout equal to the timer period.
- * It asserts that the timeout doesn't exceed the timer period plus
- * a user configurable error margin(default to 100us).
- *
- * On the other hand, upon receipt of an interrupt, the guest's interrupt
- * handler validates the interrupt by checking if the architectural state
- * is in compliance with the specifications.
- *
- * The test provides command-line options to configure the timer's
- * period (-p), number of vCPUs (-n), iterations per stage (-i) and timer
- * interrupt arrival error margin (-e). To stress-test the timer stack
- * even more, an option to migrate the vCPUs across pCPUs (-m), at a
- * particular rate, is also provided.
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
-	uint32_t nr_vcpus;
-	uint32_t nr_iter;
-	uint32_t timer_period_ms;
-	uint32_t migration_freq_ms;
-	uint32_t timer_err_margin_us;
-	struct kvm_arm_counter_offset offset;
-};
-
-static struct test_args test_args = {
-	.nr_vcpus = NR_VCPUS_DEF,
-	.nr_iter = NR_TEST_ITERS_DEF,
-	.timer_period_ms = TIMER_TEST_PERIOD_MS_DEF,
-	.migration_freq_ms = TIMER_TEST_MIGRATION_FREQ_MS,
-	.timer_err_margin_us = TIMER_TEST_ERR_MARGIN_US,
-	.offset = { .reserved = 1 },
-};
-
-#define msecs_to_usecs(msec)		((msec) * 1000ULL)
-
 #define GICD_BASE_GPA			0x8000000ULL
 #define GICR_BASE_GPA			0x80A0000ULL
 
@@ -74,22 +25,8 @@ enum guest_stage {
 	GUEST_STAGE_MAX,
 };
 
-/* Shared variables between host and guest */
-struct test_vcpu_shared_data {
-	uint32_t nr_iter;
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
@@ -230,137 +167,6 @@ static void guest_code(void)
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
@@ -377,7 +183,7 @@ static void test_init_timer_irq(struct kvm_vm *vm)
 
 static int gic_fd;
 
-static struct kvm_vm *test_vm_create(void)
+struct kvm_vm *test_vm_create(void)
 {
 	struct kvm_vm *vm;
 	unsigned int i;
@@ -408,87 +214,8 @@ static struct kvm_vm *test_vm_create(void)
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
-	pr_info("Usage: %s [-h] [-n nr_vcpus] [-i iterations] [-p timer_period_ms]\n"
-		"\t\t    [-m migration_freq_ms] [-o counter_offset]\n"
-		"\t\t    [-e timer_err_margin_us]\n", name);
-	pr_info("\t-n: Number of vCPUs to configure (default: %u; max: %u)\n",
-		NR_VCPUS_DEF, KVM_MAX_VCPUS);
-	pr_info("\t-i: Number of iterations per stage (default: %u)\n",
-		NR_TEST_ITERS_DEF);
-	pr_info("\t-p: Periodicity (in ms) of the guest timer (default: %u)\n",
-		TIMER_TEST_PERIOD_MS_DEF);
-	pr_info("\t-m: Frequency (in ms) of vCPUs to migrate to different pCPU. 0 to turn off (default: %u)\n",
-		TIMER_TEST_MIGRATION_FREQ_MS);
-	pr_info("\t-o: Counter offset (in counter cycles, default: 0)\n");
-	pr_info("\t-e: Interrupt arrival error margin (in us) of the guest timer (default: %u)\n",
-		TIMER_TEST_ERR_MARGIN_US);
-	pr_info("\t-h: print this help screen\n");
-}
-
-static bool parse_args(int argc, char *argv[])
-{
-	int opt;
-
-	while ((opt = getopt(argc, argv, "hn:i:p:m:o:e:")) != -1) {
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
-		case 'e':
-			test_args.timer_err_margin_us = atoi_non_negative("Error Margin", optarg);
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
index 000000000000..113d40f7bb14
--- /dev/null
+++ b/tools/testing/selftests/kvm/arch_timer.c
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * arch_timer.c - Tests the arch timer IRQ functionality
+ *
+ * The guest's main thread configures the timer interrupt and waits
+ * for it to fire, with a timeout equal to the timer period.
+ * It asserts that the timeout doesn't exceed the timer period plus
+ * a user configurable error margin(default to 100us)
+ *
+ * On the other hand, upon receipt of an interrupt, the guest's interrupt
+ * handler validates the interrupt by checking if the architectural state
+ * is in compliance with the specifications.
+ *
+ * The test provides command-line options to configure the timer's
+ * period (-p), number of vCPUs (-n), iterations per stage (-i) and timer
+ * interrupt arrival error margin (-e). To stress-test the timer stack
+ * even more, an option to migrate the vCPUs across pCPUs (-m), at a
+ * particular rate, is also provided.
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
+	.timer_err_margin_us = TIMER_TEST_ERR_MARGIN_US,
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
+	pr_info("Usage: %s [-h] [-n nr_vcpus] [-i iterations] [-p timer_period_ms]\n"
+		"\t\t    [-m migration_freq_ms] [-o counter_offset]\n"
+		"\t\t    [-e timer_err_margin_us]\n", name);
+	pr_info("\t-n: Number of vCPUs to configure (default: %u; max: %u)\n",
+		NR_VCPUS_DEF, KVM_MAX_VCPUS);
+	pr_info("\t-i: Number of iterations per stage (default: %u)\n",
+		NR_TEST_ITERS_DEF);
+	pr_info("\t-p: Periodicity (in ms) of the guest timer (default: %u)\n",
+		TIMER_TEST_PERIOD_MS_DEF);
+	pr_info("\t-m: Frequency (in ms) of vCPUs to migrate to different pCPU. 0 to turn off (default: %u)\n",
+		TIMER_TEST_MIGRATION_FREQ_MS);
+	pr_info("\t-o: Counter offset (in counter cycles, default: 0)\n");
+	pr_info("\t-e: Interrupt arrival error margin (in us) of the guest timer (default: %u)\n",
+		TIMER_TEST_ERR_MARGIN_US);
+	pr_info("\t-h: print this help screen\n");
+}
+
+static bool parse_args(int argc, char *argv[])
+{
+	int opt;
+
+	while ((opt = getopt(argc, argv, "hn:i:p:m:o:e:")) != -1) {
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
+		case 'e':
+			test_args.timer_err_margin_us = atoi_non_negative("Error Margin", optarg);
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
index 8e5f413a593d..7671b9d804d6 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -20,6 +20,8 @@
 #include <sys/mman.h>
 #include "kselftest.h"
 
+#define msecs_to_usecs(msec)    ((msec) * 1000ULL)
+
 static inline int _no_printf(const char *format, ...) { return 0; }
 
 #ifdef DEBUG
diff --git a/tools/testing/selftests/kvm/include/timer_test.h b/tools/testing/selftests/kvm/include/timer_test.h
new file mode 100644
index 000000000000..256e2d2137cf
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/timer_test.h
@@ -0,0 +1,44 @@
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
+	uint32_t nr_vcpus;
+	uint32_t nr_iter;
+	uint32_t timer_period_ms;
+	uint32_t migration_freq_ms;
+	uint32_t timer_err_margin_us;
+	/* TODO: Change arm specific type to a common one */
+	struct kvm_arm_counter_offset offset;
+};
+
+/* Shared variables between host and guest */
+struct test_vcpu_shared_data {
+	uint32_t nr_iter;
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


