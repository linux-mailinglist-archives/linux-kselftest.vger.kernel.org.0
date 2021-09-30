Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE6241E0DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Sep 2021 20:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353374AbhI3SSy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Sep 2021 14:18:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353361AbhI3SSx (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Sep 2021 14:18:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A93361994;
        Thu, 30 Sep 2021 18:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633025830;
        bh=oBfjfm6fWRey1fGVyLifJwGo1gue4a9652bF+UkSnPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zy/q28KpbWPKHPxTtkn8mU9h3P08FFJT9lwGbDP60g4Wue9tlHm3gFtps+KnxwJF+
         jsP3Wa8oONJBuXW8WqZGKNc3pfgAeDQGUnBuIqjRVn/3u9XAE2Q3c2HpRdrADo4xPk
         vAmvAfCRg/1kKXALHgbLEGuhm/7hQaWR1bLLYTRxvCFrjmR5xd9Hdmj+83Ss+VDzh3
         iBHOvWrX0/svNlENt2JHD1XgozlY7s9xPRdzw1ZwNUaIuqOnnPx1E5PnMd4bX5bkpR
         efYa3M5GxAm7Wjb/UNaovifzSGNRHNLM9QMUWIdCwRuZyUv9rYDgn8zUv7IGAIUpNW
         xbNjfrwbvG+aw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 32/38] kselftest/arm64: Add tests for TPIDR2
Date:   Thu, 30 Sep 2021 19:11:38 +0100
Message-Id: <20210930181144.10029-33-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210930181144.10029-1-broonie@kernel.org>
References: <20210930181144.10029-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7345; h=from:subject; bh=oBfjfm6fWRey1fGVyLifJwGo1gue4a9652bF+UkSnPw=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhVf3aj7s9BmuSZZFjqMqltDf1l9tenxndJWYmyW3j WicUbqKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYVX92gAKCRAk1otyXVSH0AR4B/ 9ylh2mRoHOqeyCOOt96QCxqohm7vPLs9HeM2aCwWpKuMBjqWTmbRWR4DgsQw4FHLk7GvZo1yGyerS1 aTWk2naHzvqzhr8kjnSYzmLawMhORwhIVwx4P/oDxIx2IG6f5HmNeu00CRWP7YuOTczHmihBu5124R Boda2OsaoaF/n9ZbQx8WZv64zF3uEAQzPdkTphzuP/DqwUNv+sx7zCn+mbWy6OuIBlaxuqwLXUio9P 5loFnG/ljac29N6r/AtASBJBoNj2/zl5XSWxdJCJp9ymj+fw8SeZN4mhGZPPhE2b4dMcr46oX86yKY v85wN5tdBc2FDO0BtdVbFZ/g1k6fbw
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The Scalable Matrix Extension adds a new system register TPIDR2 intended to
be used by libc for its own thread specific use, add some kselftests which
exercise the ABI for it.

Since this test should with some adjustment work for TPIDR and any other
similar registers added in future add tests for it in a separate
directory rather than placing it with the other floating point tests,
nothing existing looked suitable so I created a new test directory
called "abi".

Since this feature is intended to be used by libc the test is built as
freestanding code using nolibc so we don't end up with the test program
and libc both trying to manage the register simultaneously and
distrupting each other. As a result of being written using nolibc rather
than using hwcaps to identify if SME is available in the system we check
for the default SME vector length configuration in proc, adding hwcap
support to nolibc seems like disproportionate effort and didn't feel
entirely idiomatic for what nolibc is trying to do.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/Makefile       |   2 +-
 tools/testing/selftests/arm64/abi/.gitignore |   1 +
 tools/testing/selftests/arm64/abi/Makefile   |  13 ++
 tools/testing/selftests/arm64/abi/tpidr2.c   | 204 +++++++++++++++++++
 4 files changed, 219 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/arm64/abi/.gitignore
 create mode 100644 tools/testing/selftests/arm64/abi/Makefile
 create mode 100644 tools/testing/selftests/arm64/abi/tpidr2.c

diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selftests/arm64/Makefile
index ced910fb4019..1e8d9a8f59df 100644
--- a/tools/testing/selftests/arm64/Makefile
+++ b/tools/testing/selftests/arm64/Makefile
@@ -4,7 +4,7 @@
 ARCH ?= $(shell uname -m 2>/dev/null || echo not)
 
 ifneq (,$(filter $(ARCH),aarch64 arm64))
-ARM64_SUBTARGETS ?= tags signal pauth fp mte bti
+ARM64_SUBTARGETS ?= tags signal pauth fp mte bti abi
 else
 ARM64_SUBTARGETS :=
 endif
diff --git a/tools/testing/selftests/arm64/abi/.gitignore b/tools/testing/selftests/arm64/abi/.gitignore
new file mode 100644
index 000000000000..4b04670993ea
--- /dev/null
+++ b/tools/testing/selftests/arm64/abi/.gitignore
@@ -0,0 +1 @@
+tpidr2
diff --git a/tools/testing/selftests/arm64/abi/Makefile b/tools/testing/selftests/arm64/abi/Makefile
new file mode 100644
index 000000000000..c32fe00ee67f
--- /dev/null
+++ b/tools/testing/selftests/arm64/abi/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 ARM Limited
+
+TEST_GEN_PROGS := tpidr2
+
+include ../../lib.mk
+
+# Build with nolibc since TPIDR2 is intended to be actively managed by
+# libc and we're trying to test the functionality that it depends on here.
+$(OUTPUT)/tpidr2: tpidr2.c
+	$(CC) -fno-asynchronous-unwind-tables -fno-ident -s -Os -nostdlib \
+		-static -include ../../../../include/nolibc/nolibc.h \
+		 -Wall $^ -o $@ -lgcc
diff --git a/tools/testing/selftests/arm64/abi/tpidr2.c b/tools/testing/selftests/arm64/abi/tpidr2.c
new file mode 100644
index 000000000000..917962913257
--- /dev/null
+++ b/tools/testing/selftests/arm64/abi/tpidr2.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#define SYS_TPIDR2 "S3_3_C13_C0_5"
+
+#define EXPECTED_TESTS 4
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
+static void set_tpidr2(uint64_t val)
+{
+	asm volatile (
+		"msr	" SYS_TPIDR2 ", %0\n"
+		:
+		: "r"(val)
+		: "cc");
+}
+
+static uint64_t get_tpidr2(void)
+{
+	uint64_t val;
+
+	asm volatile (
+		"mrs	%0, " SYS_TPIDR2 "\n"
+		: "=r"(val)
+		:
+		: "cc");
+
+	return val;
+}
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
+/* Processes should start with TPIDR2 == 0 */
+static int default_value(void)
+{
+	return get_tpidr2() == 0;
+}
+
+/* If we set TPIDR2 we should read that value */
+static int write_read(void)
+{
+	set_tpidr2(getpid());
+
+	return getpid() == get_tpidr2();
+}
+
+/* If we set a value we should read the same value after scheduling out */
+static int write_sleep_read(void)
+{
+	set_tpidr2(getpid());
+
+	msleep(100);
+
+	return getpid() == get_tpidr2();
+}
+
+/*
+ * If we fork the value in the parent should be unchanged and the
+ * child should start with 0 and be able to set its own value.
+ */
+static int write_fork_read(void)
+{
+	pid_t newpid, waiting;
+	int status;
+
+	set_tpidr2(getpid());
+
+	newpid = fork();
+	if (newpid == 0) {
+		/* In child */
+		if (get_tpidr2() != 0) {
+			putstr("# TPIDR2 non-zero in child: ");
+			putnum(get_tpidr2());
+			putstr("\n");
+			exit(0);
+		}
+
+		set_tpidr2(getpid());
+		if (get_tpidr2() == getpid()) {
+			exit(1);
+		} else {
+			putstr("# Failed to set TPIDR2 in child\n");
+			exit(0);
+		}
+	}
+	if (newpid < 0) {
+		putstr("# fork() failed: -");
+		putnum(-newpid);
+		putstr("\n");
+		return 0;
+	}
+
+	for (;;) {
+		waiting = waitpid(newpid, &status, 0);
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
+		if (!WIFEXITED(status)) {
+			putstr("# child did not exit\n");
+			return 0;
+		}
+
+		if (getpid() != get_tpidr2()) {
+			putstr("# TPIDR2 corrupted in parent\n");
+			return 0;
+		}
+
+		return WEXITSTATUS(status);
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
+		run_test(default_value);
+		run_test(write_read);
+		run_test(write_sleep_read);
+		run_test(write_fork_read);
+	} else {
+		putstr("# SME support not present\n");
+
+		for (i = 0; i < EXPECTED_TESTS; i++) {
+			putstr("ok ");
+			putnum(i);
+			putstr(" skipped, TPIDR2 not supported\n");
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
2.20.1

