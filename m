Return-Path: <linux-kselftest+bounces-45769-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7195CC6537E
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 17:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3715236640E
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 16:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8521F2D6E6C;
	Mon, 17 Nov 2025 16:34:19 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14D22D238A;
	Mon, 17 Nov 2025 16:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763397259; cv=none; b=A1sWzHBJAOx23DgkGZbVQTQHWwE81pGe5bXR0MIExGkSapiqWogKGRbNNoa2HSpaABzrudqcileX/cfSI3r3g64JONXba5azaPl6n/cfv1HrC1gO9TRqxOnNJKtbSPzHtccze35bb0xrwoWNwD6G/gM71nyldY7CtNNfpWLKf9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763397259; c=relaxed/simple;
	bh=5mq28XZ8tJ8LAy0ujVHdtfgjBlh0FYvFOBWyBDHi5UU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qzq0WRA2qZ1zMW3RprU4rU7CUTcT99TmbZLSWNbWL4nHbXIEmubHRlR9ZMqPLxcR7q8MqZJScExuMgibuP6oy13xGhqUJsRmQRzSQVE04VRU7AkvKeq6g12M2osTfje1B4GKr7dKtWKZtHyp/ksXIEg8n60fwEI4p+os7L3j3Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from Mobilestation.localdomain (unknown [183.6.59.216])
	by APP-05 (Coremail) with SMTP id zQCowABXT2BiThtpY5sTAQ--.27246S4;
	Tue, 18 Nov 2025 00:34:00 +0800 (CST)
From: Yao Zihong <zihong.plct@isrc.iscas.ac.cn>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ajones@ventanamicro.com,
	zihong.plct@isrc.iscas.ac.cn,
	zihongyao@outlook.com,
	zhangyin2018@iscas.ac.cn,
	Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH v4 2/2] selftests/riscv: Add Zicbop prefetch test
Date: Tue, 18 Nov 2025 00:32:40 +0800
Message-ID: <20251117163333.31182-3-zihong.plct@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251117163333.31182-1-zihong.plct@isrc.iscas.ac.cn>
References: <20251117163333.31182-1-zihong.plct@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXT2BiThtpY5sTAQ--.27246S4
X-Coremail-Antispam: 1UD129KBjvJXoW3JFWkGFy5KF17JryUGFWfKrg_yoWfArW7pF
	Zxur4IvFs8ZF40qrWkJ3WkCr1Fgrn2q3yUCrWrC345ZayUX3s8GFWkKa9rAFyvkr97Zr1F
	vFn8AFWUCa1xGaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26r1q6r43MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUzyxiUUUUU=
X-CM-SenderInfo: p2lk00vjoszunw6l223fol2u1dvotugofq/

Add selftests to cbo.c to verify Zicbop extension behavior, and split
the previous `--sigill` mode into two options so they can be tested
independently.

The test checks:
- That hwprobe correctly reports Zicbop presence and block size.
- That prefetch instructions execute without exception on valid and NULL
  addresses when Zicbop is present.

Signed-off-by: Yao Zihong <zihong.plct@isrc.iscas.ac.cn>
---
 tools/testing/selftests/riscv/hwprobe/cbo.c | 168 ++++++++++++++++----
 1 file changed, 139 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/riscv/hwprobe/cbo.c b/tools/testing/selftests/riscv/hwprobe/cbo.c
index 5e96ef785d0d..281ab440e696 100644
--- a/tools/testing/selftests/riscv/hwprobe/cbo.c
+++ b/tools/testing/selftests/riscv/hwprobe/cbo.c
@@ -15,24 +15,31 @@
 #include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <asm/ucontext.h>
+#include <getopt.h>
 
 #include "hwprobe.h"
 #include "../../kselftest.h"
 
 #define MK_CBO(fn) le32_bswap((uint32_t)(fn) << 20 | 10 << 15 | 2 << 12 | 0 << 7 | 15)
+#define MK_PREFETCH(fn) \
+	le32_bswap(0 << 25 | (uint32_t)(fn) << 20 | 10 << 15 | 6 << 12 | 0 << 7 | 19)
 
 static char mem[4096] __aligned(4096) = { [0 ... 4095] = 0xa5 };
 
-static bool illegal_insn;
+static bool got_fault;
 
-static void sigill_handler(int sig, siginfo_t *info, void *context)
+static void fault_handler(int sig, siginfo_t *info, void *context)
 {
 	unsigned long *regs = (unsigned long *)&((ucontext_t *)context)->uc_mcontext;
 	uint32_t insn = *(uint32_t *)regs[0];
 
-	assert(insn == MK_CBO(regs[11]));
+	if (sig == SIGILL)
+		assert(insn == MK_CBO(regs[11]));
 
-	illegal_insn = true;
+	if (sig == SIGSEGV || sig == SIGBUS)
+		assert(insn == MK_PREFETCH(regs[11]));
+
+	got_fault = true;
 	regs[0] += 4;
 }
 
@@ -45,39 +52,51 @@ static void sigill_handler(int sig, siginfo_t *info, void *context)
 	: : "r" (base), "i" (fn), "i" (MK_CBO(fn)) : "a0", "a1", "memory");	\
 })
 
+#define prefetch_insn(base, fn)							\
+({										\
+	asm volatile(								\
+	"mv	a0, %0\n"							\
+	"li	a1, %1\n"							\
+	".4byte	%2\n"								\
+	: : "r" (base), "i" (fn), "i" (MK_PREFETCH(fn)) : "a0", "a1");		\
+})
+
 static void cbo_inval(char *base) { cbo_insn(base, 0); }
 static void cbo_clean(char *base) { cbo_insn(base, 1); }
 static void cbo_flush(char *base) { cbo_insn(base, 2); }
 static void cbo_zero(char *base)  { cbo_insn(base, 4); }
+static void prefetch_i(char *base) { prefetch_insn(base, 0); }
+static void prefetch_r(char *base) { prefetch_insn(base, 1); }
+static void prefetch_w(char *base) { prefetch_insn(base, 3); }
 
 static void test_no_cbo_inval(void *arg)
 {
 	ksft_print_msg("Testing cbo.inval instruction remain privileged\n");
-	illegal_insn = false;
+	got_fault = false;
 	cbo_inval(&mem[0]);
-	ksft_test_result(illegal_insn, "No cbo.inval\n");
+	ksft_test_result(got_fault, "No cbo.inval\n");
 }
 
 static void test_no_zicbom(void *arg)
 {
 	ksft_print_msg("Testing Zicbom instructions remain privileged\n");
 
-	illegal_insn = false;
+	got_fault = false;
 	cbo_clean(&mem[0]);
-	ksft_test_result(illegal_insn, "No cbo.clean\n");
+	ksft_test_result(got_fault, "No cbo.clean\n");
 
-	illegal_insn = false;
+	got_fault = false;
 	cbo_flush(&mem[0]);
-	ksft_test_result(illegal_insn, "No cbo.flush\n");
+	ksft_test_result(got_fault, "No cbo.flush\n");
 }
 
 static void test_no_zicboz(void *arg)
 {
 	ksft_print_msg("No Zicboz, testing cbo.zero remains privileged\n");
 
-	illegal_insn = false;
+	got_fault = false;
 	cbo_zero(&mem[0]);
-	ksft_test_result(illegal_insn, "No cbo.zero\n");
+	ksft_test_result(got_fault, "No cbo.zero\n");
 }
 
 static bool is_power_of_2(__u64 n)
@@ -85,6 +104,54 @@ static bool is_power_of_2(__u64 n)
 	return n != 0 && (n & (n - 1)) == 0;
 }
 
+static void test_zicbop(void *arg)
+{
+	struct riscv_hwprobe pair = {
+		.key = RISCV_HWPROBE_KEY_ZICBOP_BLOCK_SIZE,
+	};
+
+	struct sigaction act = {
+		.sa_sigaction = &fault_handler,
+		.sa_flags = SA_SIGINFO
+	};
+
+	struct sigaction dfl = {
+		.sa_handler = SIG_DFL
+	};
+
+	cpu_set_t *cpus = (cpu_set_t *)arg;
+	__u64 block_size;
+	long rc;
+
+	rc = sigaction(SIGSEGV, &act, NULL);
+	assert(rc == 0);
+	rc = sigaction(SIGBUS, &act, NULL);
+	assert(rc == 0);
+
+	rc = riscv_hwprobe(&pair, 1, sizeof(cpu_set_t), (unsigned long *)cpus, 0);
+	block_size = pair.value;
+	ksft_test_result(rc == 0 && pair.key == RISCV_HWPROBE_KEY_ZICBOP_BLOCK_SIZE &&
+			 is_power_of_2(block_size), "Zicbop block size\n");
+	ksft_print_msg("Zicbop block size: %llu\n", block_size);
+
+	got_fault = false;
+	prefetch_i(&mem[0]);
+	prefetch_r(&mem[0]);
+	prefetch_w(&mem[0]);
+	ksft_test_result(!got_fault, "Zicbop prefetch.* on valid address\n");
+
+	got_fault = false;
+	prefetch_i(NULL);
+	prefetch_r(NULL);
+	prefetch_w(NULL);
+	ksft_test_result(!got_fault, "Zicbop prefetch.* on NULL\n");
+
+	rc = sigaction(SIGBUS, &dfl, NULL);
+	assert(rc == 0);
+	rc = sigaction(SIGSEGV, &dfl, NULL);
+	assert(rc == 0);
+}
+
 static void test_zicbom(void *arg)
 {
 	struct riscv_hwprobe pair = {
@@ -100,13 +167,13 @@ static void test_zicbom(void *arg)
 			 is_power_of_2(block_size), "Zicbom block size\n");
 	ksft_print_msg("Zicbom block size: %llu\n", block_size);
 
-	illegal_insn = false;
+	got_fault = false;
 	cbo_clean(&mem[block_size]);
-	ksft_test_result(!illegal_insn, "cbo.clean\n");
+	ksft_test_result(!got_fault, "cbo.clean\n");
 
-	illegal_insn = false;
+	got_fault = false;
 	cbo_flush(&mem[block_size]);
-	ksft_test_result(!illegal_insn, "cbo.flush\n");
+	ksft_test_result(!got_fault, "cbo.flush\n");
 }
 
 static void test_zicboz(void *arg)
@@ -125,11 +192,11 @@ static void test_zicboz(void *arg)
 			 is_power_of_2(block_size), "Zicboz block size\n");
 	ksft_print_msg("Zicboz block size: %llu\n", block_size);
 
-	illegal_insn = false;
+	got_fault = false;
 	cbo_zero(&mem[block_size]);
-	ksft_test_result(!illegal_insn, "cbo.zero\n");
+	ksft_test_result(!got_fault, "cbo.zero\n");
 
-	if (illegal_insn || !is_power_of_2(block_size)) {
+	if (got_fault || !is_power_of_2(block_size)) {
 		ksft_test_result_skip("cbo.zero check\n");
 		return;
 	}
@@ -177,7 +244,19 @@ static void check_no_zicbo_cpus(cpu_set_t *cpus, __u64 cbo)
 		rc = riscv_hwprobe(&pair, 1, sizeof(cpu_set_t), (unsigned long *)&one_cpu, 0);
 		assert(rc == 0 && pair.key == RISCV_HWPROBE_KEY_IMA_EXT_0);
 
-		cbostr = cbo == RISCV_HWPROBE_EXT_ZICBOZ ? "Zicboz" : "Zicbom";
+		switch (cbo) {
+		case RISCV_HWPROBE_EXT_ZICBOZ:
+			cbostr = "Zicboz";
+			break;
+		case RISCV_HWPROBE_EXT_ZICBOM:
+			cbostr = "Zicbom";
+			break;
+		case RISCV_HWPROBE_EXT_ZICBOP:
+			cbostr = "Zicbop";
+			break;
+		default:
+			ksft_exit_fail_msg("Internal error: invalid cbo %llu\n", cbo);
+		}
 
 		if (pair.value & cbo)
 			ksft_exit_fail_msg("%s is only present on a subset of harts.\n"
@@ -194,6 +273,7 @@ enum {
 	TEST_ZICBOM,
 	TEST_NO_ZICBOM,
 	TEST_NO_CBO_INVAL,
+	TEST_ZICBOP
 };
 
 static struct test_info {
@@ -206,26 +286,51 @@ static struct test_info {
 	[TEST_ZICBOM]		= { .nr_tests = 3, test_zicbom },
 	[TEST_NO_ZICBOM]	= { .nr_tests = 2, test_no_zicbom },
 	[TEST_NO_CBO_INVAL]	= { .nr_tests = 1, test_no_cbo_inval },
+	[TEST_ZICBOP]		= { .nr_tests = 3, test_zicbop }
+};
+
+static const struct option long_opts[] = {
+	{"zicbom-raises-sigill", no_argument, 0, 'm'},
+	{"zicboz-raises-sigill", no_argument, 0, 'z'},
+	{0, 0, 0, 0}
 };
 
 int main(int argc, char **argv)
 {
 	struct sigaction act = {
-		.sa_sigaction = &sigill_handler,
+		.sa_sigaction = &fault_handler,
 		.sa_flags = SA_SIGINFO,
 	};
+
 	struct riscv_hwprobe pair;
 	unsigned int plan = 0;
 	cpu_set_t cpus;
 	long rc;
-	int i;
-
-	if (argc > 1 && !strcmp(argv[1], "--sigill")) {
-		rc = sigaction(SIGILL, &act, NULL);
-		assert(rc == 0);
-		tests[TEST_NO_ZICBOZ].enabled = true;
-		tests[TEST_NO_ZICBOM].enabled = true;
-		tests[TEST_NO_CBO_INVAL].enabled = true;
+	int i, opt, long_index;
+
+	long_index = 0;
+
+	while ((opt = getopt_long(argc, argv, "mz", long_opts, &long_index)) != -1) {
+		switch (opt) {
+		case 'm':
+			tests[TEST_NO_ZICBOM].enabled = true;
+			tests[TEST_NO_CBO_INVAL].enabled = true;
+			rc = sigaction(SIGILL, &act, NULL);
+			assert(rc == 0);
+			break;
+		case 'z':
+			tests[TEST_NO_ZICBOZ].enabled = true;
+			rc = sigaction(SIGILL, &act, NULL);
+			assert(rc == 0);
+			break;
+		case '?':
+			fprintf(stderr,
+				"Usage: %s [--zicbom-raises-sigill|-m] [--zicboz-raises-sigill|-z]\n",
+				argv[0]);
+			exit(1);
+		default:
+			break;
+		}
 	}
 
 	rc = sched_getaffinity(0, sizeof(cpu_set_t), &cpus);
@@ -253,6 +358,11 @@ int main(int argc, char **argv)
 		check_no_zicbo_cpus(&cpus, RISCV_HWPROBE_EXT_ZICBOM);
 	}
 
+	if (pair.value & RISCV_HWPROBE_EXT_ZICBOP)
+		tests[TEST_ZICBOP].enabled = true;
+	else
+		check_no_zicbo_cpus(&cpus, RISCV_HWPROBE_EXT_ZICBOP);
+
 	for (i = 0; i < ARRAY_SIZE(tests); ++i)
 		plan += tests[i].enabled ? tests[i].nr_tests : 0;
 
-- 
2.47.2


