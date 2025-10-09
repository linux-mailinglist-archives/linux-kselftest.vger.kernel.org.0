Return-Path: <linux-kselftest+bounces-42934-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E542BC95AC
	for <lists+linux-kselftest@lfdr.de>; Thu, 09 Oct 2025 15:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 814B6481BE2
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Oct 2025 13:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3859A2E92B2;
	Thu,  9 Oct 2025 13:44:39 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6362E8E1F;
	Thu,  9 Oct 2025 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760017479; cv=none; b=Da+3OCcKUBAcCPLO8ucJhJ010U+oJR1BdJ77mottWjqkgrYtJUi4yMNI7PpSeunQi7FiHq91f589/orz5OqfLhN2Sgm0bBmGZcxEtMrV0ZWCzewpKIxSZ1ujir70A+utC2qumGNToCommLSvtzVqMP47qaSNusF81HNg2F2EnGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760017479; c=relaxed/simple;
	bh=xpyO27wStAAmGxSSMjaSNXERYYHjXfNJ7MohxZUHNU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eY3Oi7OUj7wv9AVYU3BlvIBZPeonEF66URSXWMMX3GqUyfSuWYEHqDKGJMFjld4UQtYlASagFCCKaKutGi8uN9CjJb28E6GXmVX3ooFT9ukfO87Z1JAtXQkCGIZvrZFx6ML56OYTZl9LtGHX+njzUQMnRO4Xvasb9yySD5ilkzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from Mobilestation.localdomain (unknown [183.6.60.79])
	by APP-01 (Coremail) with SMTP id qwCowACX76EEvOdoFFc_DQ--.1956S6;
	Thu, 09 Oct 2025 21:44:23 +0800 (CST)
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
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH v2 4/4] selftests/riscv: Add Zicbop prefetch test
Date: Thu,  9 Oct 2025 21:41:54 +0800
Message-ID: <20251009134318.23040-5-zihong.plct@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251009134318.23040-1-zihong.plct@isrc.iscas.ac.cn>
References: <20251009134318.23040-1-zihong.plct@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACX76EEvOdoFFc_DQ--.1956S6
X-Coremail-Antispam: 1UD129KBjvJXoW3JFWkGw43AF48uw17CFyDWrg_yoW3WFyfpa
	95ur4YqF48AF47KayxJF4DGFsYgr1vq3yUArWru3s8Z347Xas3JF97Ka9rAFWkGry8Zry5
	uF13tFWruFW7JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQq14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
	1UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4U
	JwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUUMKZtUUUUU==
X-CM-SenderInfo: p2lk00vjoszunw6l223fol2u1dvotugofq/

Add a new selftest under hwprobe/ to verify Zicbop extension behavior.

The test checks:
- That hwprobe correctly reports Zicbop presence and block size.
- That prefetch instructions execute without exception on valid and NULL
  addresses when Zicbop is present.
- That prefetch.{i,r,w} do not trigger SIGILL even when Zicbop is absent,
  since Zicbop instructions are defined as hints.

The test is based on cbo.c but adapted for Zicbop prefetch instructions.

Signed-off-by: Yao Zihong <zihong.plct@isrc.iscas.ac.cn>
---
 .../testing/selftests/riscv/hwprobe/Makefile  |   5 +-
 .../selftests/riscv/hwprobe/prefetch.c        | 236 ++++++++++++++++++
 2 files changed, 240 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/riscv/hwprobe/prefetch.c

diff --git a/tools/testing/selftests/riscv/hwprobe/Makefile b/tools/testing/selftests/riscv/hwprobe/Makefile
index cec81610a5f2..3c8b8ba7629c 100644
--- a/tools/testing/selftests/riscv/hwprobe/Makefile
+++ b/tools/testing/selftests/riscv/hwprobe/Makefile
@@ -4,7 +4,7 @@
 
 CFLAGS += -I$(top_srcdir)/tools/include
 
-TEST_GEN_PROGS := hwprobe cbo which-cpus
+TEST_GEN_PROGS := hwprobe cbo which-cpus prefetch
 
 include ../../lib.mk
 
@@ -16,3 +16,6 @@ $(OUTPUT)/cbo: cbo.c sys_hwprobe.S
 
 $(OUTPUT)/which-cpus: which-cpus.c sys_hwprobe.S
 	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
+
+$(OUTPUT)/prefetch: prefetch.c sys_hwprobe.S
+	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
diff --git a/tools/testing/selftests/riscv/hwprobe/prefetch.c b/tools/testing/selftests/riscv/hwprobe/prefetch.c
new file mode 100644
index 000000000000..d9ea048325fb
--- /dev/null
+++ b/tools/testing/selftests/riscv/hwprobe/prefetch.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023 Ventana Micro Systems Inc.
+ * Copyright (c) 2025 PLCT Lab, ISCAS
+ *
+ * Based on tools/testing/selftests/riscv/hwprobe/cbo.c with modifications
+ * for Zicbop prefetch testing.
+ *
+ * Run with 'taskset -c <cpu-list> prefetch' to only execute hwprobe on a
+ * subset of cpus, as well as only executing the tests on those cpus.
+ */
+#define _GNU_SOURCE
+#include <stdbool.h>
+#include <stdint.h>
+#include <string.h>
+#include <sched.h>
+#include <signal.h>
+#include <assert.h>
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <asm/ucontext.h>
+
+#include "hwprobe.h"
+#include "../../kselftest.h"
+
+#define MK_PREFETCH(fn) \
+	le32_bswap(0 << 25 | (uint32_t)(fn) << 20 | 10 << 15 | 6 << 12 | 0 << 7 | 19)
+
+static char mem[4096] __aligned(4096) = { [0 ... 4095] = 0xa5 };
+
+static bool illegal;
+
+static void sigill_handler(int sig, siginfo_t *info, void *context)
+{
+	unsigned long *regs = (unsigned long *)&((ucontext_t *)context)->uc_mcontext;
+	uint32_t insn = *(uint32_t *)regs[0];
+
+	assert(insn == MK_PREFETCH(regs[11]));
+
+	illegal = true;
+	regs[0] += 4;
+}
+
+#define prefetch_insn(base, fn)							\
+({										\
+	asm volatile(								\
+	"mv	a0, %0\n"							\
+	"li	a1, %1\n"							\
+	".4byte	%2\n"								\
+	: : "r" (base), "i" (fn), "i" (MK_PREFETCH(fn)) : "a0", "a1", "memory");\
+})
+
+static void prefetch_i(char *base) { prefetch_insn(base, 0); }
+
+static void prefetch_r(char *base) { prefetch_insn(base, 1); }
+
+static void prefetch_w(char *base) { prefetch_insn(base, 3); }
+
+static bool is_power_of_2(__u64 n)
+{
+	return n != 0 && (n & (n - 1)) == 0;
+}
+
+static void test_no_zicbop(void *arg)
+{
+	// Zicbop prefetch.* are HINT instructions.
+	ksft_print_msg("Testing Zicbop instructions\n");
+
+	illegal = false;
+	prefetch_i(&mem[0]);
+	ksft_test_result(!illegal, "No prefetch.i\n");
+
+	illegal = false;
+	prefetch_r(&mem[0]);
+	ksft_test_result(!illegal, "No prefetch.r\n");
+
+	illegal = false;
+	prefetch_w(&mem[0]);
+	ksft_test_result(!illegal, "No prefetch.w\n");
+}
+
+static void test_zicbop(void *arg)
+{
+	struct riscv_hwprobe pair = {
+		.key = RISCV_HWPROBE_KEY_ZICBOP_BLOCK_SIZE,
+	};
+	cpu_set_t *cpus = (cpu_set_t *)arg;
+	__u64 block_size;
+	long rc;
+
+	rc = riscv_hwprobe(&pair, 1, sizeof(cpu_set_t), (unsigned long *)cpus, 0);
+	block_size = pair.value;
+	ksft_test_result(rc == 0 && pair.key == RISCV_HWPROBE_KEY_ZICBOP_BLOCK_SIZE &&
+			 is_power_of_2(block_size), "Zicbop block size\n");
+	ksft_print_msg("Zicbop block size: %llu\n", block_size);
+
+	illegal = false;
+	prefetch_i(&mem[0]);
+	prefetch_r(&mem[0]);
+	prefetch_w(&mem[0]);
+	ksft_test_result(!illegal, "Zicbop prefetch.* on valid address\n");
+
+	illegal = false;
+	prefetch_i(NULL);
+	prefetch_r(NULL);
+	prefetch_w(NULL);
+	ksft_test_result(!illegal, "Zicbop prefetch.* on NULL\n");
+}
+
+static void check_no_zicbop_cpus(cpu_set_t *cpus)
+{
+	struct riscv_hwprobe pair = {
+		.key = RISCV_HWPROBE_KEY_IMA_EXT_0,
+	};
+	cpu_set_t one_cpu;
+	int i = 0, c = 0;
+	long rc;
+
+	while (i++ < CPU_COUNT(cpus)) {
+		while (!CPU_ISSET(c, cpus))
+			++c;
+
+		CPU_ZERO(&one_cpu);
+		CPU_SET(c, &one_cpu);
+
+		rc = riscv_hwprobe(&pair, 1, sizeof(cpu_set_t), (unsigned long *)&one_cpu, 0);
+		assert(rc == 0 && pair.key == RISCV_HWPROBE_KEY_IMA_EXT_0);
+
+		if (pair.value & RISCV_HWPROBE_EXT_ZICBOP)
+			ksft_exit_fail_msg("zicbop is only present on a subset of harts.\n"
+					   "Use taskset to select a set of harts where zicbop\n"
+					   "presence (present or not) is consistent for each hart\n");
+		++c;
+	}
+}
+
+enum {
+	TEST_ZICBOP,
+	TEST_NO_ZICBOP,
+};
+
+enum {
+	HANDLER_SIGILL,
+	HANDLER_SIGSEGV,
+	HANDLER_SIGBUS,
+};
+
+static struct test_info {
+	bool enabled;
+	unsigned int nr_tests;
+	void (*test_fn)(void *arg);
+} tests[] = {
+	[TEST_ZICBOP]		= { .nr_tests = 3, test_zicbop },
+	[TEST_NO_ZICBOP]	= { .nr_tests = 3, test_no_zicbop },
+};
+
+static struct sighandler_info {
+	const char *flag;
+	int sig;
+} handlers[] = {
+	[HANDLER_SIGILL] = { .flag = "--sigill", .sig = SIGILL },
+	[HANDLER_SIGSEGV] = { .flag = "--sigsegv", .sig = SIGSEGV },
+	[HANDLER_SIGBUS] = { .flag = "--sigbus", .sig = SIGBUS },
+};
+
+static bool search_flag(int argc, char **argv, const char *flag)
+{
+	int i;
+
+	for (i = 1; i < argc; i++) {
+		if (!strcmp(argv[i], flag))
+			return true;
+	}
+	return false;
+}
+
+static void install_sigaction(int argc, char **argv)
+{
+	int i, rc;
+	struct sigaction act = {
+		.sa_sigaction = &sigill_handler,
+		.sa_flags = SA_SIGINFO,
+	};
+
+	for (i = 0; i < ARRAY_SIZE(handlers); ++i) {
+		if (search_flag(argc, argv, handlers[i].flag)) {
+			rc = sigaction(handlers[i].sig, &act, NULL);
+			assert(rc == 0);
+		}
+	}
+
+	if (search_flag(argc, argv, handlers[HANDLER_SIGILL].flag))
+		tests[TEST_NO_ZICBOP].enabled = true;
+}
+
+int main(int argc, char **argv)
+{
+	struct riscv_hwprobe pair;
+	unsigned int plan = 0;
+	cpu_set_t cpus;
+	long rc;
+	int i;
+
+	install_sigaction(argc, argv);
+
+	rc = sched_getaffinity(0, sizeof(cpu_set_t), &cpus);
+	assert(rc == 0);
+
+	ksft_print_header();
+
+	pair.key = RISCV_HWPROBE_KEY_IMA_EXT_0;
+	rc = riscv_hwprobe(&pair, 1, sizeof(cpu_set_t), (unsigned long *)&cpus, 0);
+	if (rc < 0)
+		ksft_exit_fail_msg("hwprobe() failed with %ld\n", rc);
+	assert(rc == 0 && pair.key == RISCV_HWPROBE_KEY_IMA_EXT_0);
+
+	if (pair.value & RISCV_HWPROBE_EXT_ZICBOP)
+		tests[TEST_ZICBOP].enabled = true;
+	else
+		check_no_zicbop_cpus(&cpus);
+
+	for (i = 0; i < ARRAY_SIZE(tests); ++i)
+		plan += tests[i].enabled ? tests[i].nr_tests : 0;
+
+	if (plan == 0)
+		ksft_print_msg("No tests enabled.\n");
+	else
+		ksft_set_plan(plan);
+
+	for (i = 0; i < ARRAY_SIZE(tests); ++i) {
+		if (tests[i].enabled)
+			tests[i].test_fn(&cpus);
+	}
+
+	ksft_finished();
+}
-- 
2.47.2


