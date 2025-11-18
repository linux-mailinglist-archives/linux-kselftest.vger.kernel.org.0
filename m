Return-Path: <linux-kselftest+bounces-45870-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 044E3C6AA53
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 17:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3EDAF4F4107
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 16:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079D430DECD;
	Tue, 18 Nov 2025 16:26:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0335530F957;
	Tue, 18 Nov 2025 16:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763483170; cv=none; b=h1uG25eSSml7rs3OvQCGfTGPV2nUBgn+hF4a0qBsHcCQprd9g4j8AzVlfJu5AdGd18GOUJ/UUQNDldg86Dxks7FzEB+0ANS5InEZILFexAUt1nOQ7hSlOr0apObkulYg6Uf6OzGBHp/y30nlanUvtb0djh6Ao3T2a8c9tUwUt7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763483170; c=relaxed/simple;
	bh=kszdK9f3rX0QfEk9jTjm2WfJ4J3/3rSkrUaLWu8E1gU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QKpIiOSdI/7/FIG6zgZUgCzSgLJ7KM64VNYDAylk0ugRf0mYnmIb7iC5r9XkXiNerzXZ5gz1iMN2ONkQO6ZnkuUbEusn2pnAW+/uvNUaXj/A/fgikJzxTdTT3UvThkfy6C7Q3vSDq78j+FiD0EtsHXkkY2OdAr/goVONbxSZbbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from Mobilestation.localdomain (unknown [183.6.59.216])
	by APP-03 (Coremail) with SMTP id rQCowAAXpdffnRxpmMQ0AQ--.31198S4;
	Wed, 19 Nov 2025 00:25:47 +0800 (CST)
From: Yao Zihong <zihong.plct@isrc.iscas.ac.cn>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ajones@ventanamicro.com,
	alexghiti@rivosinc.com,
	shuah@kernel.org,
	samuel.holland@sifive.com,
	evan@rivosinc.com,
	cleger@rivosinc.com,
	zihong.plct@isrc.iscas.ac.cn,
	zihongyao@outlook.com,
	zhangyin2018@iscas.ac.cn,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH v5 2/2] selftests/riscv: Add Zicbop prefetch test
Date: Wed, 19 Nov 2025 00:23:25 +0800
Message-ID: <20251118162436.15485-3-zihong.plct@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251118162436.15485-1-zihong.plct@isrc.iscas.ac.cn>
References: <20251118162436.15485-1-zihong.plct@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAXpdffnRxpmMQ0AQ--.31198S4
X-Coremail-Antispam: 1UD129KBjvJXoW3JFWkZr47tFyUKry5uw4UArb_yoWfAFW8pF
	Zxur4IvF45ZF40qrWkJF1kCF1Fgrn2q3yUCrWrC345Zay7X3s8GFWkKay7AFyvkr97Zr1F
	vFn8AFWUCa1xGaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHab7Iv0xC_tr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
	02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE
	4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4
	IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkF7I0Ew4C26cxK6c8I
	j28IcwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTR89NsUU
	UUU
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
 tools/testing/selftests/riscv/hwprobe/cbo.c | 165 ++++++++++++++++----
 1 file changed, 136 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/riscv/hwprobe/cbo.c b/tools/testing/selftests/riscv/hwprobe/cbo.c
index 5e96ef785d0d..6d99726aceac 100644
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
@@ -85,6 +104,51 @@ static bool is_power_of_2(__u64 n)
 	return n != 0 && (n & (n - 1)) == 0;
 }
 
+static void test_zicbop(void *arg)
+{
+	struct riscv_hwprobe pair = {
+		.key = RISCV_HWPROBE_KEY_ZICBOP_BLOCK_SIZE,
+	};
+	struct sigaction act = {
+		.sa_sigaction = &fault_handler,
+		.sa_flags = SA_SIGINFO
+	};
+	struct sigaction dfl = {
+		.sa_handler = SIG_DFL
+	};
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
@@ -100,13 +164,13 @@ static void test_zicbom(void *arg)
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
@@ -125,11 +189,11 @@ static void test_zicboz(void *arg)
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
@@ -177,7 +241,19 @@ static void check_no_zicbo_cpus(cpu_set_t *cpus, __u64 cbo)
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
@@ -194,6 +270,7 @@ enum {
 	TEST_ZICBOM,
 	TEST_NO_ZICBOM,
 	TEST_NO_CBO_INVAL,
+	TEST_ZICBOP,
 };
 
 static struct test_info {
@@ -206,26 +283,51 @@ static struct test_info {
 	[TEST_ZICBOM]		= { .nr_tests = 3, test_zicbom },
 	[TEST_NO_ZICBOM]	= { .nr_tests = 2, test_no_zicbom },
 	[TEST_NO_CBO_INVAL]	= { .nr_tests = 1, test_no_cbo_inval },
+	[TEST_ZICBOP]		= { .nr_tests = 3, test_zicbop },
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
+			tests[TEST_NO_CBO_INVAL].enabled = true;
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
@@ -253,6 +355,11 @@ int main(int argc, char **argv)
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


