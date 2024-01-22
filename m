Return-Path: <linux-kselftest+bounces-3300-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30529835E7A
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 10:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FC8E1F254E6
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 09:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC3F39AE4;
	Mon, 22 Jan 2024 09:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dveQgTE0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBC23A1BF;
	Mon, 22 Jan 2024 09:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705916754; cv=none; b=ggSzCkFsah7eCOPupwqJU1PlxzoNheH6gjVD0/NXp803uTwDxgmj6F8a3Ha7WeVJZD3ovIyJsADIlnObJRtzu08aoPNWkPAlsDnho++kPDOWBFy3o+vSkTYJF0zk4ZrULWkcbPWEv44SYItypHSSIMxz6XqsC2qLWwNVIW+TqMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705916754; c=relaxed/simple;
	bh=fzBcM62Pjhw6BIUME9G7wIpQ86AqUsEaiGEj2rJwCME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u0Rr+Efg82/F33geRaHlj4/Ff5pYFTiemFjEmiJ1xEODL1pLyQ3vwt0FlOnZwmQhMuPAMSupkGs9eFxfujl14iDG0HZO3TmbCshMDquAF5d6K4PmbJQkd6Z//2/a8wpZDA1FIz34BL3j6UptGOPS9yOVLF0vIzL2hHdnN7j3VBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dveQgTE0; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705916753; x=1737452753;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fzBcM62Pjhw6BIUME9G7wIpQ86AqUsEaiGEj2rJwCME=;
  b=dveQgTE0VJURLa02h67A14W1AKdQ/opJtFuCXE6oyHOI/YVAPLGSeBfO
   oSpo66MOs8+sGZLgINYSLcTNblz3ehEqKfOLyLNCvs2WaOomspsikfHMy
   0bRrZMbibiae/UhiO03zC98VLHWkKDPZU18bjgchcgC+Etr2gAVdsugZu
   b/F5upT/qTuj7mk7iolk+wGBq80aAt6JPiYg3zx4XuMaRB4V+Ak9mq/zu
   butGF8Ou6H+CwZ/BvhSOPMDuhU0npkuMnyXN039dsFY4COPTIMI5D6V7i
   PX4ReufY3ymI7BzlqeFo+s+xJcBj+1lEEN3wxz9hVBZSS7Djo5qZvRVLX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="22641644"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="22641644"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 01:45:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="778535368"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="778535368"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 01:45:42 -0800
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
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
	wchen <waylingii@gmail.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
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
Subject: [PATCH v5 03/12] KVM: arm64: selftests: Enable tuning of error margin in arch_timer test
Date: Mon, 22 Jan 2024 17:58:33 +0800
Message-Id: <e75f59a1957aa782807b6d361655bde83fce483c.1705916069.git.haibo1.xu@intel.com>
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

There are intermittent failures occurred when stressing the
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
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 .../selftests/kvm/aarch64/arch_timer.c        | 32 +++++++++++++------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/testing/selftests/kvm/aarch64/arch_timer.c
index 3260fefcc1b3..9b9a119bdd61 100644
--- a/tools/testing/selftests/kvm/aarch64/arch_timer.c
+++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
@@ -6,16 +6,18 @@
  * CVAL and TVAL registers. This consitutes the four stages in the test.
  * The guest's main thread configures the timer interrupt for a stage
  * and waits for it to fire, with a timeout equal to the timer period.
- * It asserts that the timeout doesn't exceed the timer period.
+ * It asserts that the timeout doesn't exceed the timer period plus
+ * a user configurable error margin(default to 100us).
  *
  * On the other hand, upon receipt of an interrupt, the guest's interrupt
  * handler validates the interrupt by checking if the architectural state
  * is in compliance with the specifications.
  *
  * The test provides command-line options to configure the timer's
- * period (-p), number of vCPUs (-n), and iterations per stage (-i).
- * To stress-test the timer stack even more, an option to migrate the
- * vCPUs across pCPUs (-m), at a particular rate, is also provided.
+ * period (-p), number of vCPUs (-n), iterations per stage (-i) and timer
+ * interrupt arrival error margin (-e). To stress-test the timer stack
+ * even more, an option to migrate the vCPUs across pCPUs (-m), at a
+ * particular rate, is also provided.
  *
  * Copyright (c) 2021, Google LLC.
  */
@@ -46,6 +48,7 @@ struct test_args {
 	uint32_t nr_iter;
 	uint32_t timer_period_ms;
 	uint32_t migration_freq_ms;
+	uint32_t timer_err_margin_us;
 	struct kvm_arm_counter_offset offset;
 };
 
@@ -54,6 +57,7 @@ static struct test_args test_args = {
 	.nr_iter = NR_TEST_ITERS_DEF,
 	.timer_period_ms = TIMER_TEST_PERIOD_MS_DEF,
 	.migration_freq_ms = TIMER_TEST_MIGRATION_FREQ_MS,
+	.timer_err_margin_us = TIMER_TEST_ERR_MARGIN_US,
 	.offset = { .reserved = 1 },
 };
 
@@ -190,10 +194,14 @@ static void guest_run_stage(struct test_vcpu_shared_data *shared_data,
 
 		/* Setup a timeout for the interrupt to arrive */
 		udelay(msecs_to_usecs(test_args.timer_period_ms) +
-			TIMER_TEST_ERR_MARGIN_US);
+			test_args.timer_err_margin_us);
 
 		irq_iter = READ_ONCE(shared_data->nr_iter);
-		GUEST_ASSERT_EQ(config_iter + 1, irq_iter);
+		__GUEST_ASSERT(config_iter + 1 == irq_iter,
+				"config_iter + 1 = 0x%lx, irq_iter = 0x%lx.\n"
+				"  Guest timer interrupt was not trigged within the specified\n"
+				"  interval, try to increase the error margin by [-e] option.\n",
+				config_iter + 1, irq_iter);
 	}
 }
 
@@ -408,8 +416,9 @@ static void test_vm_cleanup(struct kvm_vm *vm)
 
 static void test_print_help(char *name)
 {
-	pr_info("Usage: %s [-h] [-n nr_vcpus] [-i iterations] [-p timer_period_ms]\n",
-		name);
+	pr_info("Usage: %s [-h] [-n nr_vcpus] [-i iterations] [-p timer_period_ms]\n"
+		"\t\t    [-m migration_freq_ms] [-o counter_offset]\n"
+		"\t\t    [-e timer_err_margin_us]\n", name);
 	pr_info("\t-n: Number of vCPUs to configure (default: %u; max: %u)\n",
 		NR_VCPUS_DEF, KVM_MAX_VCPUS);
 	pr_info("\t-i: Number of iterations per stage (default: %u)\n",
@@ -419,6 +428,8 @@ static void test_print_help(char *name)
 	pr_info("\t-m: Frequency (in ms) of vCPUs to migrate to different pCPU. 0 to turn off (default: %u)\n",
 		TIMER_TEST_MIGRATION_FREQ_MS);
 	pr_info("\t-o: Counter offset (in counter cycles, default: 0)\n");
+	pr_info("\t-e: Interrupt arrival error margin (in us) of the guest timer (default: %u)\n",
+		TIMER_TEST_ERR_MARGIN_US);
 	pr_info("\t-h: print this help screen\n");
 }
 
@@ -426,7 +437,7 @@ static bool parse_args(int argc, char *argv[])
 {
 	int opt;
 
-	while ((opt = getopt(argc, argv, "hn:i:p:m:o:")) != -1) {
+	while ((opt = getopt(argc, argv, "hn:i:p:m:o:e:")) != -1) {
 		switch (opt) {
 		case 'n':
 			test_args.nr_vcpus = atoi_positive("Number of vCPUs", optarg);
@@ -445,6 +456,9 @@ static bool parse_args(int argc, char *argv[])
 		case 'm':
 			test_args.migration_freq_ms = atoi_non_negative("Frequency", optarg);
 			break;
+		case 'e':
+			test_args.timer_err_margin_us = atoi_non_negative("Error Margin", optarg);
+			break;
 		case 'o':
 			test_args.offset.counter_offset = strtol(optarg, NULL, 0);
 			test_args.offset.reserved = 0;
-- 
2.34.1


