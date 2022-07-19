Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A6D57A936
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 23:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240165AbiGSVpn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 17:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240074AbiGSVpi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 17:45:38 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4F2B10FF7;
        Tue, 19 Jul 2022 14:45:27 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 26JLj5YI002593;
        Tue, 19 Jul 2022 23:45:05 +0200
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
Subject: [PATCH 12/17] selftests/nolibc: support glibc as well
Date:   Tue, 19 Jul 2022 23:44:44 +0200
Message-Id: <20220719214449.2520-14-w@1wt.eu>
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

Adding support for glibc can be useful to distinguish between bugs in
nolibc and bugs in the kernel when a syscall reports an unusual value.

It's not that much work and should not affect the long term
maintainability of the tests. The necessary changes can essentially be
summed up like this:
  - set _GNU_SOURCE a the top to access some definitions
  - many includes added when we know we don't come from nolibc (missing
    the stdio include guard)
  - disable gettid() which is not exposed by glibc
  - disable gettimeofday's support of bad pointers since these  crash
    in glibc
  - add a simple itoa() for errorname(); strerror() is too verbose (no
    way to get short messages). strerrorname_np() was added in modern
    glibc (2.32) to do exactly this but that 's too recent to be usable
    as the default fallback.
  - use the standard ioperm() definition. May be we need to implement
    ioperm() in nolibc if that's useful.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 47 +++++++++++++++++++-
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 26d61ec910c1..88ee5d0828ec 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1,17 +1,41 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#define _GNU_SOURCE
+
 /* platform-specific include files coming from the compiler */
 #include <limits.h>
 
 /* libc-specific include files
- * The program may be built in 2 ways:
+ * The program may be built in 3 ways:
  *   $(CC) -nostdlib -include /path/to/nolibc.h => NOLIBC already defined
- *   $(CC) -nostdlib -I/path/to/nolibc/sysroot
+ *   $(CC) -nostdlib -I/path/to/nolibc/sysroot  => _NOLIBC_* guards are present
+ *   $(CC) with default libc                    => NOLIBC* never defined
  */
 #ifndef NOLIBC
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#ifndef _NOLIBC_STDIO_H
+/* standard libcs need more includes */
+#include <linux/reboot.h>
+#include <sys/io.h>
+#include <sys/ioctl.h>
+#include <sys/mount.h>
+#include <sys/reboot.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/sysmacros.h>
+#include <sys/time.h>
+#include <sys/wait.h>
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <poll.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdarg.h>
+#include <unistd.h>
+#endif
 #endif
 
 /* will be used by nolibc by getenv() */
@@ -23,6 +47,17 @@ struct test {
 	int (*func)(int min, int max); // handler
 };
 
+#ifndef _NOLIBC_STDLIB_H
+char *itoa(int i)
+{
+	static char buf[12];
+	int ret;
+
+	ret = snprintf(buf, sizeof(buf), "%d", i);
+	return (ret >= 0 && ret < sizeof(buf)) ? buf : "#err";
+}
+#endif
+
 #define CASE_ERR(err) \
 	case err: return #err
 
@@ -431,7 +466,9 @@ int run_syscall(int min, int max)
 		switch (test + __LINE__ + 1) {
 		CASE_TEST(getpid);            EXPECT_SYSNE(1, getpid(), -1); break;
 		CASE_TEST(getppid);           EXPECT_SYSNE(1, getppid(), -1); break;
+#ifdef NOLIBC
 		CASE_TEST(gettid);            EXPECT_SYSNE(1, gettid(), -1); break;
+#endif
 		CASE_TEST(getpgid_self);      EXPECT_SYSNE(1, getpgid(0), -1); break;
 		CASE_TEST(getpgid_bad);       EXPECT_SYSER(1, getpgid(-1), -1, ESRCH); break;
 		CASE_TEST(kill_0);            EXPECT_SYSZR(1, kill(getpid(), 0)); break;
@@ -460,9 +497,11 @@ int run_syscall(int min, int max)
 		CASE_TEST(getdents64_root);   EXPECT_SYSNE(1, test_getdents64("/"), -1); break;
 		CASE_TEST(getdents64_null);   EXPECT_SYSER(1, test_getdents64("/dev/null"), -1, ENOTDIR); break;
 		CASE_TEST(gettimeofday_null); EXPECT_SYSZR(1, gettimeofday(NULL, NULL)); break;
+#ifdef NOLIBC
 		CASE_TEST(gettimeofday_bad1); EXPECT_SYSER(1, gettimeofday((void *)1, NULL), -1, EFAULT); break;
 		CASE_TEST(gettimeofday_bad2); EXPECT_SYSER(1, gettimeofday(NULL, (void *)1), -1, EFAULT); break;
 		CASE_TEST(gettimeofday_bad2); EXPECT_SYSER(1, gettimeofday(NULL, (void *)1), -1, EFAULT); break;
+#endif
 		CASE_TEST(ioctl_tiocinq);     EXPECT_SYSZR(1, ioctl(0, TIOCINQ, &tmp)); break;
 		CASE_TEST(ioctl_tiocinq);     EXPECT_SYSZR(1, ioctl(0, TIOCINQ, &tmp)); break;
 		CASE_TEST(link_root1);        EXPECT_SYSER(1, link("/", "/"), -1, EEXIST); break;
@@ -703,7 +742,11 @@ int main(int argc, char **argv, char **envp)
 		 * exit with status code 2N+1 when N is written to 0x501. We
 		 * hard-code the syscall here as it's arch-dependent.
 		 */
+#if defined(_NOLIBC_SYS_H)
 		else if (my_syscall3(__NR_ioperm, 0x501, 1, 1) == 0)
+#else
+		else if (ioperm(0x501, 1, 1) == 0)
+#endif
 			asm volatile ("outb %%al, %%dx" :: "d"(0x501), "a"(0));
 		/* if it does nothing, fall back to the regular panic */
 #endif
-- 
2.17.5

