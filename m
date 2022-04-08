Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01BC4F94F6
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 13:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbiDHMAB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 08:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235344AbiDHMAA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 08:00:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C998930A
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 04:57:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73103B82A8B
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 11:57:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF22C385A1;
        Fri,  8 Apr 2022 11:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649419073;
        bh=btI/e7eBvCT+/IcphkBDHYpeKxpTwpCQkqMo25n9Ma8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tb2LwMSeUCkAb/euw3pTplT//ugWPezmVJDkwJU3VJvSGpI1P9zRfH4nsq+FtEht1
         wDJacqn5P0ROdBmOL9Va5vTlo1j9bjeXN+i4rWlUrfN/rPfBXTzrzsJcj79BfiNaLg
         /IRiJHAt0lps+dh3oGqkDw/M+1C2/PaNPRrGKd3qS5lLMzS1dhYPHiqK2sVCkcWRRm
         FMBz4Z51q6Uoh2OGqspLt90UT6ux03BBKCZFOL7BQdUh4W7oibLQOsmlTX4wBhNJaK
         U2QmytRTqB5egaxurih8hih6KzwfXeFzo/I5yUhtkPdAUE2uxtAEtdlVBA2bl5wxaF
         n3lVn7/IoxUIg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Luca Salabrino <luca.scalabrino@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v13 39/39] selftests/arm64: Add a testcase for handling of ZA on clone()
Date:   Fri,  8 Apr 2022 12:43:28 +0100
Message-Id: <20220408114328.1401034-40-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220408114328.1401034-1-broonie@kernel.org>
References: <20220408114328.1401034-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7450; h=from:subject; bh=btI/e7eBvCT+/IcphkBDHYpeKxpTwpCQkqMo25n9Ma8=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiUB/dE62ndVOXKtzWfdUc9iFN8nIyp2Ggizqn4A4F tGhah2WJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYlAf3QAKCRAk1otyXVSH0JD1B/ 9eCu9xc12h3P32xNLTgsLYfEqvcj10aF9BNY7sXE8ia4w/l6Qoj9I285dHdGBwnvKtWz77lW795o6B wKIpSqbe1nthNL02tD+Y2INE3DviQdJiE+CLz6xEhT0vqheAusRAJhsw5PAZRgERFXWNipCE0a9Ctw WKFcCj8x0Iy/YnA9GbYuUoWZzBO5fWuOa5DbPjhQxPGabpiGqAU3kvuto38NMDpnLcu/cgkbUt3DbS 3vKyHSlbTtBMIrfLTepi2b9OKgx4Ze4dPRDJyQgrpwFoWRnH+LvUxwmA8OqzJaBUepnoRoVf+zy3nc /lLx+nqIy9XPe2sUZrEEl2Kf74bShQ
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a small testcase that attempts to do a clone() with ZA enabled and
verifies that it remains enabled with the same contents. We only check
one word in one horizontal vector of ZA since there's already other tests
that check for data corruption more broadly, we're just looking to make
sure that ZA is still enabled and it looks like the data got copied.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/.gitignore   |   1 +
 tools/testing/selftests/arm64/fp/Makefile     |   9 +-
 .../testing/selftests/arm64/fp/za-fork-asm.S  |  61 +++++++
 tools/testing/selftests/arm64/fp/za-fork.c    | 156 ++++++++++++++++++
 4 files changed, 226 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/arm64/fp/za-fork-asm.S
 create mode 100644 tools/testing/selftests/arm64/fp/za-fork.c

diff --git a/tools/testing/selftests/arm64/fp/.gitignore b/tools/testing/selftests/arm64/fp/.gitignore
index d98d3d48b504..ea947af63882 100644
--- a/tools/testing/selftests/arm64/fp/.gitignore
+++ b/tools/testing/selftests/arm64/fp/.gitignore
@@ -8,5 +8,6 @@ sve-test
 ssve-test
 vec-syscfg
 vlset
+za-fork
 za-ptrace
 za-test
diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
index 807a8faf8d57..95e707e32247 100644
--- a/tools/testing/selftests/arm64/fp/Makefile
+++ b/tools/testing/selftests/arm64/fp/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 CFLAGS += -I../../../../../usr/include/
-TEST_GEN_PROGS := sve-ptrace sve-probe-vls vec-syscfg za-ptrace
+TEST_GEN_PROGS := sve-ptrace sve-probe-vls vec-syscfg za-fork za-ptrace
 TEST_PROGS_EXTENDED := fp-pidbench fpsimd-test fpsimd-stress \
 	rdvl-sme rdvl-sve \
 	sve-test sve-stress \
@@ -11,6 +11,7 @@ TEST_PROGS_EXTENDED := fp-pidbench fpsimd-test fpsimd-stress \
 
 all: $(TEST_GEN_PROGS) $(TEST_PROGS_EXTENDED)
 
+# Build with nolibc to avoid effects due to libc's clone() support
 fp-pidbench: fp-pidbench.S asm-utils.o
 	$(CC) -nostdlib $^ -o $@
 fpsimd-test: fpsimd-test.o asm-utils.o
@@ -25,6 +26,12 @@ ssve-test: sve-test.S asm-utils.o
 	$(CC) -DSSVE -nostdlib $^ -o $@
 vec-syscfg: vec-syscfg.o rdvl.o
 vlset: vlset.o
+za-fork: za-fork.o za-fork-asm.o
+	$(CC) -nostdlib -static $^ -o $@ -lgcc
+za-fork.o: za-fork.c
+	$(CC) -c -fno-asynchronous-unwind-tables -fno-ident -s -Os -nostdlib \
+		-include ../../../../include/nolibc/nolibc.h \
+		-ffreestanding -Wall $^ -o $@
 za-test: za-test.o asm-utils.o
 	$(CC) -nostdlib $^ -o $@
 za-ptrace: za-ptrace.o
diff --git a/tools/testing/selftests/arm64/fp/za-fork-asm.S b/tools/testing/selftests/arm64/fp/za-fork-asm.S
new file mode 100644
index 000000000000..947c0962ee1b
--- /dev/null
+++ b/tools/testing/selftests/arm64/fp/za-fork-asm.S
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2021 ARM Limited.
+
+#include "sme-inst.h"
+
+.arch_extension sve
+
+#define MAGIC     42
+
+#define MAXVL     2048
+#define MAXVL_B   (MAXVL / 8)
+
+.pushsection .text
+.data
+.align 4
+scratch:
+	.space	MAXVL_B
+.popsection
+
+.globl fork_test
+fork_test:
+	smstart_za
+
+	// For simplicity just set one word in one vector, other tests
+	// cover general data corruption issues.
+	ldr	x0, =scratch
+	mov	x1, #MAGIC
+	str	x1, [x0]
+	mov	w12, wzr
+	_ldr_za 12, 0			// ZA.H[w12] loaded from [x0]
+
+	// Tail call into the C portion that does the fork & verify
+	b	fork_test_c
+
+.globl verify_fork
+verify_fork:
+	// SVCR should have ZA=1, SM=0
+	mrs	x0, S3_3_C4_C2_2
+	and	x1, x0, #3
+	cmp	x1, #2
+	beq	1f
+	mov	x0, xzr
+	b	100f
+1:
+
+	// ZA should still have the value we loaded
+	ldr	x0, =scratch
+	mov	w12, wzr
+	_str_za 12, 0			// ZA.H[w12] stored to [x0]
+	ldr	x1, [x0]
+	cmp	x1, #MAGIC
+	beq	2f
+	mov	x0, xzr
+	b	100f
+
+2:
+	// All tests passed
+	mov	x0, #1
+100:
+	ret
+
diff --git a/tools/testing/selftests/arm64/fp/za-fork.c b/tools/testing/selftests/arm64/fp/za-fork.c
new file mode 100644
index 000000000000..ff475c649e96
--- /dev/null
+++ b/tools/testing/selftests/arm64/fp/za-fork.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 ARM Limited.
+ * Original author: Mark Brown <broonie@kernel.org>
+ */
+
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/sched.h>
+#include <linux/wait.h>
+
+#define EXPECTED_TESTS 1
+
+static void putstr(const char *str)
+{
+	write(1, str, strlen(str));
+}
+
+static void putnum(unsigned int num)
+{
+	char c;
+
+	if (num / 10)
+		putnum(num / 10);
+
+	c = '0' + (num % 10);
+	write(1, &c, 1);
+}
+
+static int tests_run;
+static int tests_passed;
+static int tests_failed;
+static int tests_skipped;
+
+static void print_summary(void)
+{
+	if (tests_passed + tests_failed + tests_skipped != EXPECTED_TESTS)
+		putstr("# UNEXPECTED TEST COUNT: ");
+
+	putstr("# Totals: pass:");
+	putnum(tests_passed);
+	putstr(" fail:");
+	putnum(tests_failed);
+	putstr(" xfail:0 xpass:0 skip:");
+	putnum(tests_skipped);
+	putstr(" error:0\n");
+}
+
+int fork_test(void);
+int verify_fork(void);
+
+/*
+ * If we fork the value in the parent should be unchanged and the
+ * child should start with the same value.  This is called from the
+ * fork_test() asm function.
+ */
+int fork_test_c(void)
+{
+	pid_t newpid, waiting;
+	int child_status, parent_result;
+
+	newpid = fork();
+	if (newpid == 0) {
+		/* In child */
+		if (!verify_fork()) {
+			putstr("# ZA state invalid in child\n");
+			exit(0);
+		} else {
+			exit(1);
+		}
+	}
+	if (newpid < 0) {
+		putstr("# fork() failed: -");
+		putnum(-newpid);
+		putstr("\n");
+		return 0;
+	}
+
+	parent_result = verify_fork();
+	if (!parent_result)
+		putstr("# ZA state invalid in parent\n");
+
+	for (;;) {
+		waiting = waitpid(newpid, &child_status, 0);
+
+		if (waiting < 0) {
+			if (errno == EINTR)
+				continue;
+			putstr("# waitpid() failed: ");
+			putnum(errno);
+			putstr("\n");
+			return 0;
+		}
+		if (waiting != newpid) {
+			putstr("# waitpid() returned wrong PID\n");
+			return 0;
+		}
+
+		if (!WIFEXITED(child_status)) {
+			putstr("# child did not exit\n");
+			return 0;
+		}
+
+		return WEXITSTATUS(child_status) && parent_result;
+	}
+}
+
+#define run_test(name)			     \
+	if (name()) {			     \
+		tests_passed++;		     \
+	} else {			     \
+		tests_failed++;		     \
+		putstr("not ");		     \
+	}				     \
+	putstr("ok ");			     \
+	putnum(++tests_run);		     \
+	putstr(" " #name "\n");
+
+int main(int argc, char **argv)
+{
+	int ret, i;
+
+	putstr("TAP version 13\n");
+	putstr("1..");
+	putnum(EXPECTED_TESTS);
+	putstr("\n");
+
+	putstr("# PID: ");
+	putnum(getpid());
+	putstr("\n");
+
+	/*
+	 * This test is run with nolibc which doesn't support hwcap and
+	 * it's probably disproportionate to implement so instead check
+	 * for the default vector length configuration in /proc.
+	 */
+	ret = open("/proc/sys/abi/sme_default_vector_length", O_RDONLY, 0);
+	if (ret >= 0) {
+		run_test(fork_test);
+
+	} else {
+		putstr("# SME support not present\n");
+
+		for (i = 0; i < EXPECTED_TESTS; i++) {
+			putstr("ok ");
+			putnum(i);
+			putstr(" skipped\n");
+		}
+
+		tests_skipped += EXPECTED_TESTS;
+	}
+
+	print_summary();
+
+	return 0;
+}
-- 
2.30.2

