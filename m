Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF71D57A93D
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 23:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240516AbiGSVqO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 17:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240509AbiGSVp5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 17:45:57 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 783CC11463;
        Tue, 19 Jul 2022 14:45:44 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 26JLj4wP002584;
        Tue, 19 Jul 2022 23:45:04 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Pranith Kumar <bobby.prani@gmail.com>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Mark Brown <broonie@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 04/17] selftests/nolibc: add basic infrastructure to ease creation of nolibc tests
Date:   Tue, 19 Jul 2022 23:44:35 +0200
Message-Id: <20220719214449.2520-5-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20220719214449.2520-1-w@1wt.eu>
References: <20220719214449.2520-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This creates a "nolibc" selftest that intends to test various parts of
the nolibc component, both in terms of build and execution for a given
architecture.

The aim is for it to be as simple to run as a kernel build, by just
passing the compiler (for the build) and the ARCH (for kernel and
execution).

It brings a basic squeleton made of a single C file that will ease testing
and error reporting. The code will be arranged so that it remains easy to
add basic tests for syscalls or library calls that may rely on a condition
to be executed, and whose result is compared to a value or to an error
with a specific errno value.

Tests will just use a relative line number in switch/case statements as
an index, saving the user from having to maintain arrays and complicated
functions which can often just be one-liners.

MAINTAINERS was updated.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 MAINTAINERS                                  |   1 +
 tools/testing/selftests/nolibc/Makefile      |  43 ++
 tools/testing/selftests/nolibc/nolibc-test.c | 395 +++++++++++++++++++
 3 files changed, 439 insertions(+)
 create mode 100644 tools/testing/selftests/nolibc/Makefile
 create mode 100644 tools/testing/selftests/nolibc/nolibc-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4e38d7533cbe..6ab10b235ed0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14114,6 +14114,7 @@ M:	Willy Tarreau <w@1wt.eu>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git
 F:	tools/include/nolibc/
+F:	tools/testing/selftests/nolibc/
 
 NSDEPS
 M:	Matthias Maennich <maennich@google.com>
diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
new file mode 100644
index 000000000000..fd0a67082334
--- /dev/null
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for nolibc tests
+include ../../../scripts/Makefile.include
+
+# we're in ".../tools/testing/selftests/nolibc"
+ifeq ($(srctree),)
+srctree := $(patsubst %/tools/testing/selftests/,%,$(dir $(CURDIR)))
+endif
+
+ifeq ($(ARCH),)
+include $(srctree)/scripts/subarch.include
+ARCH = $(SUBARCH)
+endif
+
+# OUTPUT is only set when run from the main makefile, otherwise
+# it defaults to this nolibc directory.
+OUTPUT ?= $(CURDIR)/
+
+ifeq ($(V),1)
+Q=
+else
+Q=@
+endif
+
+CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables
+LDFLAGS := -s
+
+all: nolibc-test
+
+nolibc-test: nolibc-test.c
+	$(QUIET_CC)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
+	  -nostdlib -static -include ../../../include/nolibc/nolibc.h $^ -lgcc
+
+initramfs: nolibc-test
+	$(QUIET_MKDIR)mkdir -p initramfs
+	$(call QUIET_INSTALL, initramfs/init)
+	$(Q)cp nolibc-test initramfs/init
+
+clean:
+	$(call QUIET_CLEAN, nolibc-test)
+	$(Q)rm -f nolibc-test
+	$(call QUIET_CLEAN, initramfs)
+	$(Q)rm -rf initramfs
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
new file mode 100644
index 000000000000..6c050d4381fe
--- /dev/null
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -0,0 +1,395 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* platform-specific include files coming from the compiler */
+#include <limits.h>
+
+/* libc-specific include files
+ * The program may be built in 2 ways:
+ *   $(CC) -nostdlib -include /path/to/nolibc.h => NOLIBC already defined
+ *   $(CC) -nostdlib -I/path/to/nolibc/sysroot
+ */
+#ifndef NOLIBC
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#endif
+
+/* will be used by nolibc by getenv() */
+char **environ;
+
+#define CASE_ERR(err) \
+	case err: return #err
+
+/* returns the error name (e.g. "ENOENT") for common errors, "SUCCESS" for 0,
+ * or the decimal value for less common ones.
+ */
+const char *errorname(int err)
+{
+	switch (err) {
+	case 0: return "SUCCESS";
+	CASE_ERR(EPERM);
+	CASE_ERR(ENOENT);
+	CASE_ERR(ESRCH);
+	CASE_ERR(EINTR);
+	CASE_ERR(EIO);
+	CASE_ERR(ENXIO);
+	CASE_ERR(E2BIG);
+	CASE_ERR(ENOEXEC);
+	CASE_ERR(EBADF);
+	CASE_ERR(ECHILD);
+	CASE_ERR(EAGAIN);
+	CASE_ERR(ENOMEM);
+	CASE_ERR(EACCES);
+	CASE_ERR(EFAULT);
+	CASE_ERR(ENOTBLK);
+	CASE_ERR(EBUSY);
+	CASE_ERR(EEXIST);
+	CASE_ERR(EXDEV);
+	CASE_ERR(ENODEV);
+	CASE_ERR(ENOTDIR);
+	CASE_ERR(EISDIR);
+	CASE_ERR(EINVAL);
+	CASE_ERR(ENFILE);
+	CASE_ERR(EMFILE);
+	CASE_ERR(ENOTTY);
+	CASE_ERR(ETXTBSY);
+	CASE_ERR(EFBIG);
+	CASE_ERR(ENOSPC);
+	CASE_ERR(ESPIPE);
+	CASE_ERR(EROFS);
+	CASE_ERR(EMLINK);
+	CASE_ERR(EPIPE);
+	CASE_ERR(EDOM);
+	CASE_ERR(ERANGE);
+	CASE_ERR(ENOSYS);
+	default:
+		return itoa(err);
+	}
+}
+
+static int pad_spc(int llen, int cnt, const char *fmt, ...)
+{
+	va_list args;
+	int len;
+	int ret;
+
+	for (len = 0; len < cnt - llen; len++)
+		putchar(' ');
+
+	va_start(args, fmt);
+	ret = vfprintf(stdout, fmt, args);
+	va_end(args);
+	return ret < 0 ? ret : ret + len;
+}
+
+/* The tests below are intended to be used by the macroes, which evaluate
+ * expression <expr>, print the status to stdout, and update the "ret"
+ * variable to count failures. The functions themselves return the number
+ * of failures, thus either 0 or 1.
+ */
+
+#define EXPECT_ZR(cond, expr)				\
+	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_zr(expr, llen); } while (0)
+
+static int expect_zr(int expr, int llen)
+{
+	int ret = !(expr == 0);
+
+	llen += printf(" = %d ", expr);
+	pad_spc(llen, 40, ret ? "[FAIL]\n" : " [OK]\n");
+	return ret;
+}
+
+
+#define EXPECT_NZ(cond, expr, val)			\
+	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_nz(expr, llen; } while (0)
+
+static int expect_nz(int expr, int llen)
+{
+	int ret = !(expr != 0);
+
+	llen += printf(" = %d ", expr);
+	pad_spc(llen, 40, ret ? "[FAIL]\n" : " [OK]\n");
+	return ret;
+}
+
+
+#define EXPECT_EQ(cond, expr, val)				\
+	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_eq(expr, llen, val); } while (0)
+
+static int expect_eq(int expr, int llen, int val)
+{
+	int ret = !(expr == val);
+
+	llen += printf(" = %d ", expr);
+	pad_spc(llen, 40, ret ? "[FAIL]\n" : " [OK]\n");
+	return ret;
+}
+
+
+#define EXPECT_NE(cond, expr, val)				\
+	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_ne(expr, llen, val); } while (0)
+
+static int expect_ne(int expr, int llen, int val)
+{
+	int ret = !(expr != val);
+
+	llen += printf(" = %d ", expr);
+	pad_spc(llen, 40, ret ? "[FAIL]\n" : " [OK]\n");
+	return ret;
+}
+
+
+#define EXPECT_GE(cond, expr, val)				\
+	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_ge(expr, llen, val); } while (0)
+
+static int expect_ge(int expr, int llen, int val)
+{
+	int ret = !(expr >= val);
+
+	llen += printf(" = %d ", expr);
+	pad_spc(llen, 40, ret ? "[FAIL]\n" : " [OK]\n");
+	return ret;
+}
+
+
+#define EXPECT_GT(cond, expr, val)				\
+	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_gt(expr, llen, val); } while (0)
+
+static int expect_gt(int expr, int llen, int val)
+{
+	int ret = !(expr > val);
+
+	llen += printf(" = %d ", expr);
+	pad_spc(llen, 40, ret ? "[FAIL]\n" : " [OK]\n");
+	return ret;
+}
+
+
+#define EXPECT_LE(cond, expr, val)				\
+	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_le(expr, llen, val); } while (0)
+
+static int expect_le(int expr, int llen, int val)
+{
+	int ret = !(expr <= val);
+
+	llen += printf(" = %d ", expr);
+	pad_spc(llen, 40, ret ? "[FAIL]\n" : " [OK]\n");
+	return ret;
+}
+
+
+#define EXPECT_LT(cond, expr, val)				\
+	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_lt(expr, llen, val); } while (0)
+
+static int expect_lt(int expr, int llen, int val)
+{
+	int ret = !(expr < val);
+
+	llen += printf(" = %d ", expr);
+	pad_spc(llen, 40, ret ? "[FAIL]\n" : " [OK]\n");
+	return ret;
+}
+
+
+#define EXPECT_SYSZR(cond, expr)				\
+	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_syszr(expr, llen); } while (0)
+
+static int expect_syszr(int expr, int llen)
+{
+	int ret = 0;
+
+	if (expr) {
+		ret = 1;
+		llen += printf(" = %d %s ", expr, errorname(errno));
+		llen += pad_spc(llen, 40, "[FAIL]\n");
+	} else {
+		llen += printf(" = %d ", expr);
+		llen += pad_spc(llen, 40, " [OK]\n");
+	}
+	return ret;
+}
+
+
+#define EXPECT_SYSEQ(cond, expr, val)				\
+	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_syseq(expr, llen, val); } while (0)
+
+static int expect_syseq(int expr, int llen, int val)
+{
+	int ret = 0;
+
+	if (expr != val) {
+		ret = 1;
+		llen += printf(" = %d %s ", expr, errorname(errno));
+		llen += pad_spc(llen, 40, "[FAIL]\n");
+	} else {
+		llen += printf(" = %d ", expr);
+		llen += pad_spc(llen, 40, " [OK]\n");
+	}
+	return ret;
+}
+
+
+#define EXPECT_SYSNE(cond, expr, val)				\
+	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_sysne(expr, llen, val); } while (0)
+
+static int expect_sysne(int expr, int llen, int val)
+{
+	int ret = 0;
+
+	if (expr == val) {
+		ret = 1;
+		llen += printf(" = %d %s ", expr, errorname(errno));
+		llen += pad_spc(llen, 40, "[FAIL]\n");
+	} else {
+		llen += printf(" = %d ", expr);
+		llen += pad_spc(llen, 40, " [OK]\n");
+	}
+	return ret;
+}
+
+
+#define EXPECT_SYSER(cond, expr, expret, experr)			\
+	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_syserr(expr, expret, experr, llen); } while (0)
+
+static int expect_syserr(int expr, int expret, int experr, int llen)
+{
+	int ret = 0;
+	int _errno = errno;
+
+	llen += printf(" = %d %s ", expr, errorname(_errno));
+	if (expr != expret || _errno != experr) {
+		ret = 1;
+		llen += printf(" != (%d %s) ", expret, errorname(experr));
+		llen += pad_spc(llen, 40, "[FAIL]\n");
+	} else {
+		llen += pad_spc(llen, 40, " [OK]\n");
+	}
+	return ret;
+}
+
+
+#define EXPECT_PTRZR(cond, expr)				\
+	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_ptrzr(expr, llen); } while (0)
+
+static int expect_ptrzr(const void *expr, int llen)
+{
+	int ret = 0;
+
+	llen += printf(" = <%p> ", expr);
+	if (expr) {
+		ret = 1;
+		llen += pad_spc(llen, 40, "[FAIL]\n");
+	} else {
+		llen += pad_spc(llen, 40, " [OK]\n");
+	}
+	return ret;
+}
+
+
+#define EXPECT_PTRNZ(cond, expr)				\
+	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_ptrnz(expr, llen); } while (0)
+
+static int expect_ptrnz(const void *expr, int llen)
+{
+	int ret = 0;
+
+	llen += printf(" = <%p> ", expr);
+	if (!expr) {
+		ret = 1;
+		llen += pad_spc(llen, 40, "[FAIL]\n");
+	} else {
+		llen += pad_spc(llen, 40, " [OK]\n");
+	}
+	return ret;
+}
+
+
+#define EXPECT_STRZR(cond, expr)				\
+	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_strzr(expr, llen); } while (0)
+
+static int expect_strzr(const char *expr, int llen)
+{
+	int ret = 0;
+
+	llen += printf(" = <%s> ", expr);
+	if (expr) {
+		ret = 1;
+		llen += pad_spc(llen, 40, "[FAIL]\n");
+	} else {
+		llen += pad_spc(llen, 40, " [OK]\n");
+	}
+	return ret;
+}
+
+
+#define EXPECT_STRNZ(cond, expr)				\
+	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_strnz(expr, llen); } while (0)
+
+static int expect_strnz(const char *expr, int llen)
+{
+	int ret = 0;
+
+	llen += printf(" = <%s> ", expr);
+	if (!expr) {
+		ret = 1;
+		llen += pad_spc(llen, 40, "[FAIL]\n");
+	} else {
+		llen += pad_spc(llen, 40, " [OK]\n");
+	}
+	return ret;
+}
+
+
+#define EXPECT_STREQ(cond, expr, cmp)				\
+	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_streq(expr, llen, cmp); } while (0)
+
+static int expect_streq(const char *expr, int llen, const char *cmp)
+{
+	int ret = 0;
+
+	llen += printf(" = <%s> ", expr);
+	if (strcmp(expr, cmp) != 0) {
+		ret = 1;
+		llen += pad_spc(llen, 40, "[FAIL]\n");
+	} else {
+		llen += pad_spc(llen, 40, " [OK]\n");
+	}
+	return ret;
+}
+
+
+#define EXPECT_STRNE(cond, expr, cmp)				\
+	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_strne(expr, llen, cmp); } while (0)
+
+static int expect_strne(const char *expr, int llen, const char *cmp)
+{
+	int ret = 0;
+
+	llen += printf(" = <%s> ", expr);
+	if (strcmp(expr, cmp) == 0) {
+		ret = 1;
+		llen += pad_spc(llen, 40, "[FAIL]\n");
+	} else {
+		llen += pad_spc(llen, 40, " [OK]\n");
+	}
+	return ret;
+}
+
+/* declare tests based on line numbers. There must be exactly one test per line. */
+#define CASE_TEST(name) \
+	case __LINE__: llen += printf("%d %s", test, #name);
+
+
+int main(int argc, char **argv, char **envp)
+{
+	int min = 0;
+	int max = __INT_MAX__;
+	int ret = 0;
+
+	environ = envp;
+
+	printf("Total number of errors: %d\n", ret);
+	printf("Exiting with status %d\n", !!ret);
+	return !!ret;
+}
-- 
2.17.5

