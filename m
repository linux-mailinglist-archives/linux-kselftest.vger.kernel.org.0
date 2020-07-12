Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED83F21C761
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Jul 2020 06:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgGLEpl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 12 Jul 2020 00:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgGLEpk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 12 Jul 2020 00:45:40 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497B1C08C5DD;
        Sat, 11 Jul 2020 21:45:40 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id DBE492A503E
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        willy@infradead.org, luto@kernel.org, gofmanp@gmail.com,
        keescook@chromium.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v3 2/2] selftests: Add kselftest for syscall user dispatch
Date:   Sun, 12 Jul 2020 00:45:16 -0400
Message-Id: <20200712044516.2347844-3-krisman@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200712044516.2347844-1-krisman@collabora.com>
References: <20200712044516.2347844-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Implement functionality tests for syscall user dispatch.  In order to
make the test portable, refrain from open coding syscall dispatchers and
calculating glibc memory ranges.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 tools/testing/selftests/Makefile              |   1 +
 .../syscall_user_dispatch/.gitignore          |   1 +
 .../selftests/syscall_user_dispatch/Makefile  |   5 +
 .../selftests/syscall_user_dispatch/config    |   1 +
 .../syscall_user_dispatch.c                   | 259 ++++++++++++++++++
 5 files changed, 267 insertions(+)
 create mode 100644 tools/testing/selftests/syscall_user_dispatch/.gitignore
 create mode 100644 tools/testing/selftests/syscall_user_dispatch/Makefile
 create mode 100644 tools/testing/selftests/syscall_user_dispatch/config
 create mode 100644 tools/testing/selftests/syscall_user_dispatch/syscall_user_dispatch.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 1195bd85af38..31b07dd774a6 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -47,6 +47,7 @@ TARGETS += openat2
 TARGETS += rseq
 TARGETS += rtc
 TARGETS += seccomp
+TARGETS += syscall_user_dispatch
 TARGETS += sigaltstack
 TARGETS += size
 TARGETS += sparc64
diff --git a/tools/testing/selftests/syscall_user_dispatch/.gitignore b/tools/testing/selftests/syscall_user_dispatch/.gitignore
new file mode 100644
index 000000000000..fadfb304c539
--- /dev/null
+++ b/tools/testing/selftests/syscall_user_dispatch/.gitignore
@@ -0,0 +1 @@
+syscall_user_dispatch
diff --git a/tools/testing/selftests/syscall_user_dispatch/Makefile b/tools/testing/selftests/syscall_user_dispatch/Makefile
new file mode 100644
index 000000000000..4785c98d4714
--- /dev/null
+++ b/tools/testing/selftests/syscall_user_dispatch/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+CFLAGS += -Wall
+
+TEST_GEN_PROGS := syscall_user_dispatch
+include ../lib.mk
diff --git a/tools/testing/selftests/syscall_user_dispatch/config b/tools/testing/selftests/syscall_user_dispatch/config
new file mode 100644
index 000000000000..22c4dfe167ca
--- /dev/null
+++ b/tools/testing/selftests/syscall_user_dispatch/config
@@ -0,0 +1 @@
+CONFIG_SYSCALL_USER_DISPATCH=y
diff --git a/tools/testing/selftests/syscall_user_dispatch/syscall_user_dispatch.c b/tools/testing/selftests/syscall_user_dispatch/syscall_user_dispatch.c
new file mode 100644
index 000000000000..d713147863ef
--- /dev/null
+++ b/tools/testing/selftests/syscall_user_dispatch/syscall_user_dispatch.c
@@ -0,0 +1,259 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Copyright (c) 2020 Collabora Ltd.
+ *
+ * Test code for syscall user dispatch
+ */
+
+#define _GNU_SOURCE
+#include <sys/types.h>
+#include <sys/prctl.h>
+#include <sys/syscall.h>
+#include <sys/sysinfo.h>
+#include <signal.h>
+#include <errno.h>
+
+#include "../kselftest_harness.h"
+
+#ifndef PR_SET_SYSCALL_USER_DISPATCH
+# define PR_SET_SYSCALL_USER_DISPATCH	59
+#endif
+
+#ifndef PR_SYS_DISPATCH_OFF
+# define PR_SYS_DISPATCH_OFF	0
+#endif
+
+#ifndef PR_SYS_DISPATCH_ON
+# define PR_SYS_DISPATCH_ON	1
+#endif
+
+#ifndef SYS_USER_DISPATCH
+# define SYS_USER_DISPATCH	2
+#endif
+
+#define SYSCALL_DISPATCH_ON(x) ((x) = 1)
+#define SYSCALL_DISPATCH_OFF(x) ((x) = 0)
+
+/* Test Summary:
+ *
+ * - dispatch_trigger_sigsys: Verify if PR_SET_SYSCALL_USER_DISPATCH is
+ *   able to trigger SIGSYS on a syscall.
+ *
+ * - bad_selector: Test that a bad selector value triggers SIGSEGV.
+ *
+ * - bad_prctl_param: Test that the API correctly rejects invalid
+ *   parameters on prctl
+ *
+ * - dispatch_and_return: Test that a syscall is selectively dispatched
+ *   to userspace depending on the value of selector.
+ *
+ * - disable_dispatch: Test that the PR_SYS_DISPATCH_OFF correctly
+ *   disables the dispatcher
+ *
+ * - direct_dispatch_range: Test that a syscall within the allowed range
+ *   can bypass the dispatcher.
+ */
+
+TEST_SIGNAL(dispatch_trigger_sigsys, SIGSYS)
+{
+	char sel = 0;
+	struct sysinfo info;
+	int ret;
+
+	ret = sysinfo(&info);
+	ASSERT_EQ(0, ret);
+
+	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 0, 0, &sel);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support CONFIG_SYSCALL_USER_DISPATCH");
+	}
+
+	SYSCALL_DISPATCH_ON(sel);
+
+	sysinfo(&info);
+
+	EXPECT_FALSE(true) {
+		TH_LOG("Unreachable!");
+	}
+}
+
+TEST_SIGNAL(bad_selector, SIGSEGV)
+{
+	char sel = -1;
+	long ret;
+
+	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 0, 0, &sel);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support CONFIG_SYSCALL_USER_DISPATCH");
+	}
+	EXPECT_FALSE(true) {
+		TH_LOG("Unreachable!");
+	}
+}
+
+TEST(bad_prctl_param)
+{
+	char sel = 0;
+	int op;
+
+	/* Invalid op */
+	op = -1;
+	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0, 0, &sel);
+	ASSERT_EQ(EINVAL, errno);
+
+	/* PR_SYS_DISPATCH_OFF */
+	op = PR_SYS_DISPATCH_OFF;
+
+	/* start_addr != 0 */
+	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x1, 0xff, 0);
+	EXPECT_EQ(EINVAL, errno);
+
+	/* end_addr != 0 */
+	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0xff, 0);
+	EXPECT_EQ(EINVAL, errno);
+
+	/* sel != NULL */
+	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0x0, &sel);
+	EXPECT_EQ(EINVAL, errno);
+
+	/* Valid parameter */
+	errno = 0;
+	syscall(SYS_prctl, PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0x0, 0x0);
+	EXPECT_EQ(0, errno);
+
+	/* PR_SYS_DISPATCH_ON */
+	op = PR_SYS_DISPATCH_ON;
+
+	/* start_addr > end_addr */
+	syscall(SYS_prctl, PR_SET_SYSCALL_USER_DISPATCH, op, 0x1, 0x0, &sel);
+	EXPECT_EQ(EINVAL, errno);
+
+	/* Invalid selector */
+	syscall(SYS_prctl, PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0x1, (void *) -1);
+	ASSERT_EQ(EFAULT, errno);
+}
+
+#define MAGIC_SYSCALL_1 0xff00  /* Bad Linux syscall number */
+
+/*
+ * Use global selector for handle_sigsys tests, to avoid passing
+ * selector to signal handler
+ */
+char glob_sel;
+int nr_syscalls_emulated;
+int si_code;
+
+static void handle_sigsys(int sig, siginfo_t *info, void *ucontext)
+{
+	si_code = info->si_code;
+
+	if (info->si_syscall == MAGIC_SYSCALL_1)
+		nr_syscalls_emulated++;
+
+	/* In preparation for sigreturn. */
+	SYSCALL_DISPATCH_OFF(glob_sel);
+}
+
+TEST(dispatch_and_return)
+{
+	long ret;
+	struct sigaction act;
+	sigset_t mask;
+
+	glob_sel = 0;
+	nr_syscalls_emulated = 0;
+	si_code = 0;
+
+	memset(&act, 0, sizeof(act));
+	sigemptyset(&mask);
+
+	act.sa_sigaction = handle_sigsys;
+	act.sa_flags = SA_SIGINFO;
+	act.sa_mask = mask;
+
+	ret = sigaction(SIGSYS, &act, NULL);
+	ASSERT_EQ(0, ret);
+
+	/* Make sure selector is good prior to prctl. */
+	SYSCALL_DISPATCH_OFF(glob_sel);
+
+	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 0, 0, &glob_sel);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support CONFIG_SYSCALL_USER_DISPATCH");
+	}
+
+	/* MAGIC_SYSCALL_1 doesn't exist. */
+	SYSCALL_DISPATCH_OFF(glob_sel);
+	ret = syscall(MAGIC_SYSCALL_1);
+	EXPECT_EQ(-1, ret) {
+		TH_LOG("Dispatch triggered unexpectedly");
+	}
+
+	/* MAGIC_SYSCALL_1 should be emulated. */
+	nr_syscalls_emulated = 0;
+	SYSCALL_DISPATCH_ON(glob_sel);
+
+	ret = syscall(MAGIC_SYSCALL_1);
+	EXPECT_EQ(MAGIC_SYSCALL_1, ret) {
+		TH_LOG("Failed to intercept syscall");
+	}
+	EXPECT_EQ(1, nr_syscalls_emulated) {
+		TH_LOG("Failed to emulate syscall");
+	}
+	ASSERT_EQ(SYS_USER_DISPATCH, si_code) {
+		TH_LOG("Bad si_code in SIGSYS");
+	}
+}
+
+TEST(disable_dispatch)
+{
+	int ret;
+	struct sysinfo info;
+	char sel = 0;
+
+	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 0, 0, &sel);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support CONFIG_SYSCALL_USER_DISPATCH");
+	}
+
+	/* MAGIC_SYSCALL_1 doesn't exist. */
+	SYSCALL_DISPATCH_OFF(glob_sel);
+
+	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_OFF, 0, 0, 0);
+	EXPECT_EQ(0, ret) {
+		TH_LOG("Failed to unset syscall user dispatch");
+	}
+
+	/* Shouldn't have any effect... */
+	SYSCALL_DISPATCH_ON(glob_sel);
+
+	ret = syscall(SYS_sysinfo, &info);
+	EXPECT_EQ(0, ret) {
+		TH_LOG("Dispatch triggered unexpectedly");
+	}
+}
+
+TEST(direct_dispatch_range)
+{
+	int ret = 0;
+	struct sysinfo info;
+	char sel = 0;
+
+	/*
+	 * Instead of calculating libc addresses; allow the entire
+	 * memory map and lock the selector.
+	 */
+	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 0, -1L, &sel);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support CONFIG_SYSCALL_USER_DISPATCH");
+	}
+
+	SYSCALL_DISPATCH_ON(sel);
+
+	ret = syscall(SYS_sysinfo, &info);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Dispatch triggered unexpectedly");
+	}
+}
+
+TEST_HARNESS_MAIN
-- 
2.27.0

