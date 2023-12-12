Return-Path: <linux-kselftest+bounces-1662-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A5380E76D
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 10:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A6F2B20AAC
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 09:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7514F584E3;
	Tue, 12 Dec 2023 09:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JgNiL7xy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BFD115;
	Tue, 12 Dec 2023 01:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702372929; x=1733908929;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X1Re0rpen3+bPCj3ZhqAM9xIObnQKsPUQRo4nXCFHEA=;
  b=JgNiL7xyIOCB1wAdU+Lb5Tln00GaDaUEAha+cHEGTbZ4iGXvyEYy6G9f
   00Q/yOS64rkKgqZWezcTwj0gB+WFwGha7jHZanRfo/uiJS02B+kqVphQ3
   UTPO6+P8g2OtQJ+5zEMmxntf1CY3oI88QtJsOVs+xlsLn0AV2zahuNhdn
   gK4h3LbkEk/moVYYKAHmKG6i8WUY3xLtjiq+LBer0rFCdvNJ907dpJOqD
   t0BVNT7SR7BRDwjTU48+801LpjkR6CSQPh9IVCHauntgPAoLFmQeHSl1Q
   BCrlEH+AJ7/F/FBpRhW7Q6w/qU9+hpUd/RiMhQ5sv5TzncetQ5fz03eLu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="480974533"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="480974533"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 01:22:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="917213639"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="917213639"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 01:21:55 -0800
From: Haibo Xu <haibo1.xu@intel.com>
To: 
Cc: xiaobo55x@gmail.com,
	haibo1.xu@intel.com,
	ajones@ventanamicro.com,
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
	Greentime Hu <greentime.hu@sifive.com>,
	wchen <waylingii@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Minda Chen <minda.chen@starfivetech.com>,
	Samuel Holland <samuel@sholland.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Peter Xu <peterx@redhat.com>,
	Like Xu <likexu@tencent.com>,
	Vipin Sharma <vipinsh@google.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Aaron Lewis <aaronlewis@google.com>,
	Thomas Huth <thuth@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	kvm-riscv@lists.infradead.org
Subject: [PATCH v4 11/11] KVM: selftests: Enable tunning of err_margin_us in arch timer test
Date: Tue, 12 Dec 2023 17:31:20 +0800
Message-Id: <0343a9e4bfa8011fbb6bca0286cee7eab1f17d5d.1702371136.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1702371136.git.haibo1.xu@intel.com>
References: <cover.1702371136.git.haibo1.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are intermittent failures occured when stressing the
arch-timer test in a Qemu VM:

 Guest assert failed,  vcpu 0; stage; 4; iter: 3
 ==== Test Assertion Failure ====
   aarch64/arch_timer.c:196: config_iter + 1 == irq_iter
   pid=4048 tid=4049 errno=4 - Interrupted system call
      1  0x000000000040253b: test_vcpu_run at arch_timer.c:248
      2  0x0000ffffb60dd5c7: ?? ??:0
      3  0x0000ffffb6145d1b: ?? ??:0
   0x3 != 0x2 (config_iter + 1 != irq_iter)e

Further test and debug show that the timeout for an interrupt
to arrive do have random high fluctuation, espectially when
testing in an virtual environment.

To alleviate this issue, just expose the timeout value as user
configurable and print some hint message to increase the value
when hitting the failure..

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 .../selftests/kvm/aarch64/arch_timer.c        |  8 +++++--
 tools/testing/selftests/kvm/arch_timer.c      | 22 +++++++++++++------
 .../selftests/kvm/include/timer_test.h        |  1 +
 .../testing/selftests/kvm/riscv/arch_timer.c  |  8 +++++--
 4 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/testing/selftests/kvm/aarch64/arch_timer.c
index 4b421d421c3f..139eecbf77e7 100644
--- a/tools/testing/selftests/kvm/aarch64/arch_timer.c
+++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
@@ -131,10 +131,14 @@ static void guest_run_stage(struct test_vcpu_shared_data *shared_data,
 
 		/* Setup a timeout for the interrupt to arrive */
 		udelay(msecs_to_usecs(test_args.timer_period_ms) +
-			TIMER_TEST_ERR_MARGIN_US);
+			test_args.timer_err_margin_us);
 
 		irq_iter = READ_ONCE(shared_data->nr_iter);
-		GUEST_ASSERT_EQ(config_iter + 1, irq_iter);
+		__GUEST_ASSERT(config_iter + 1 == irq_iter,
+			"config_iter + 1 = 0x%lx, irq_iter = 0x%lx.\n"
+			"  Guest timer interrupt was not trigged within the specified\n"
+			"  interval, try to increase the error margin by [-e] option.\n",
+			config_iter + 1, irq_iter);
 	}
 }
 
diff --git a/tools/testing/selftests/kvm/arch_timer.c b/tools/testing/selftests/kvm/arch_timer.c
index 60963fce16f2..5050022fd345 100644
--- a/tools/testing/selftests/kvm/arch_timer.c
+++ b/tools/testing/selftests/kvm/arch_timer.c
@@ -5,16 +5,17 @@
  * The guest's main thread configures the timer interrupt and waits
  * for it to fire, with a timeout equal to the timer period.
  * It asserts that the timeout doesn't exceed the timer period plus
- * an error margin of 100us.
+ * an user configurable error margin(default to 100us).
  *
  * On the other hand, upon receipt of an interrupt, the guest's interrupt
  * handler validates the interrupt by checking if the architectural state
  * is in compliance with the specifications.
  *
  * The test provides command-line options to configure the timer's
- * period (-p), number of vCPUs (-n), and iterations per stage (-i).
- * To stress-test the timer stack even more, an option to migrate the
- * vCPUs across pCPUs (-m), at a particular rate, is also provided.
+ * period (-p), number of vCPUs (-n), iterations per stage (-i), and timer
+ * interrupt arrival error margin (-e). To stress-test the timer stack even
+ * more, an option to migrate the vCPUs across pCPUs (-m), at a particular
+ * rate, is also provided.
  *
  * Copyright (c) 2021, Google LLC.
  */
@@ -34,6 +35,7 @@ struct test_args test_args = {
 	.nr_iter = NR_TEST_ITERS_DEF,
 	.timer_period_ms = TIMER_TEST_PERIOD_MS_DEF,
 	.migration_freq_ms = TIMER_TEST_MIGRATION_FREQ_MS,
+	.timer_err_margin_us = TIMER_TEST_ERR_MARGIN_US,
 	.reserved = 1,
 };
 
@@ -179,8 +181,9 @@ static void test_run(struct kvm_vm *vm)
 
 static void test_print_help(char *name)
 {
-	pr_info("Usage: %s [-h] [-n nr_vcpus] [-i iterations] [-p timer_period_ms]\n",
-		name);
+	pr_info("Usage: %s [-h] [-n nr_vcpus] [-i iterations] [-p timer_period_ms]\n"
+	        "\t\t    [-m migration_freq_ms] [-o counter_offset]\n"
+	        "\t\t    [-e timer_err_margin_us]\n", name);
 	pr_info("\t-n: Number of vCPUs to configure (default: %u; max: %u)\n",
 		NR_VCPUS_DEF, KVM_MAX_VCPUS);
 	pr_info("\t-i: Number of iterations per stage (default: %u)\n",
@@ -190,6 +193,8 @@ static void test_print_help(char *name)
 	pr_info("\t-m: Frequency (in ms) of vCPUs to migrate to different pCPU. 0 to turn off (default: %u)\n",
 		TIMER_TEST_MIGRATION_FREQ_MS);
 	pr_info("\t-o: Counter offset (in counter cycles, default: 0) [aarch64-only]\n");
+	pr_info("\t-e: Interrupt arrival error margin(in us) of the guest timer (default: %u)\n",
+		TIMER_TEST_ERR_MARGIN_US);
 	pr_info("\t-h: print this help screen\n");
 }
 
@@ -197,7 +202,7 @@ static bool parse_args(int argc, char *argv[])
 {
 	int opt;
 
-	while ((opt = getopt(argc, argv, "hn:i:p:m:o:")) != -1) {
+	while ((opt = getopt(argc, argv, "hn:i:p:m:o:e:")) != -1) {
 		switch (opt) {
 		case 'n':
 			test_args.nr_vcpus = atoi_positive("Number of vCPUs", optarg);
@@ -216,6 +221,9 @@ static bool parse_args(int argc, char *argv[])
 		case 'm':
 			test_args.migration_freq_ms = atoi_non_negative("Frequency", optarg);
 			break;
+		case 'e':
+			test_args.timer_err_margin_us = atoi_non_negative("Error Margin", optarg);
+			break;
 		case 'o':
 			test_args.counter_offset = strtol(optarg, NULL, 0);
 			test_args.reserved = 0;
diff --git a/tools/testing/selftests/kvm/include/timer_test.h b/tools/testing/selftests/kvm/include/timer_test.h
index 968257b893a7..b1d405e7157d 100644
--- a/tools/testing/selftests/kvm/include/timer_test.h
+++ b/tools/testing/selftests/kvm/include/timer_test.h
@@ -22,6 +22,7 @@ struct test_args {
 	int nr_iter;
 	int timer_period_ms;
 	int migration_freq_ms;
+	int timer_err_margin_us;
 	/* Members of struct kvm_arm_counter_offset */
 	uint64_t counter_offset;
 	uint64_t reserved;
diff --git a/tools/testing/selftests/kvm/riscv/arch_timer.c b/tools/testing/selftests/kvm/riscv/arch_timer.c
index 13bf184d1ff5..45a139dc7ce3 100644
--- a/tools/testing/selftests/kvm/riscv/arch_timer.c
+++ b/tools/testing/selftests/kvm/riscv/arch_timer.c
@@ -55,10 +55,14 @@ static void guest_run(struct test_vcpu_shared_data *shared_data)
 
 		/* Setup a timeout for the interrupt to arrive */
 		udelay(msecs_to_usecs(test_args.timer_period_ms) +
-			TIMER_TEST_ERR_MARGIN_US);
+			test_args.timer_err_margin_us);
 
 		irq_iter = READ_ONCE(shared_data->nr_iter);
-		GUEST_ASSERT_EQ(config_iter + 1, irq_iter);
+		__GUEST_ASSERT(config_iter + 1 == irq_iter,
+			"config_iter + 1 = 0x%lx, irq_iter = 0x%lx.\n"
+			"  Guest timer interrupt was not trigged within the specified\n"
+			"  interval, try to increase the error margin by [-e] option.\n",
+			config_iter + 1, irq_iter);
 	}
 }
 
-- 
2.34.1


