Return-Path: <linux-kselftest+bounces-15814-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1767959470
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 08:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 266E21F2460E
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 06:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2061516E873;
	Wed, 21 Aug 2024 06:16:31 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C6F16DC2D;
	Wed, 21 Aug 2024 06:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724220991; cv=none; b=YOjewnBzrFLmH6HvcnUVWZ2LlNGhw7Qffpt4qHpH2kuCNKjqocKA7o2fr2ega10IOO7wXyp81+brXAy3lnlJv4f5kPBsOELgbf++eZeCOlqa8dFIAgNQCVLWiamweAbJ0SW0ElHpAmJb4TvQqAKsIp8f3FPPSUD7OB8BrHJEpa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724220991; c=relaxed/simple;
	bh=fRaD8gtI2ufEZ6lXVirJrzDPcmhSFHhWvy7wuLZf3Oo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PpHxFY6IEFMe6pk53I6/oiLEbHpbJTXewGqkOnBDYH5eeQ/6Plx8XQYx8/NCkea049/dECJ0/nBvaYETbqLNfJ6ejOQ83uiR7ZbFUNpBvP+dP6dom6njVTxXH9V+BcBbJDnnrnWrU3Qom8cLYV9iqw+szjCPNaS4C/X1ILEK9Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DD8CDA7;
	Tue, 20 Aug 2024 23:16:54 -0700 (PDT)
Received: from e116581.arm.com (unknown [10.163.88.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 857A53F73B;
	Tue, 20 Aug 2024 23:16:23 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: shuah@kernel.org,
	oleg@redhat.com
Cc: mingo@kernel.org,
	tglx@linutronix.de,
	mark.rutland@arm.com,
	ryan.roberts@arm.com,
	broonie@kernel.org,
	suzuki.poulose@arm.com,
	Anshuman.Khandual@arm.com,
	DeepakKumar.Mishra@arm.com,
	aneesh.kumar@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v5 2/2] selftests: Add a test mangling with uc_sigmask
Date: Wed, 21 Aug 2024 11:45:23 +0530
Message-Id: <20240821061523.2650568-3-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821061523.2650568-1-dev.jain@arm.com>
References: <20240821061523.2650568-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test asserts the relation between blocked signal, delivered signal,
and ucontext. The ucontext is mangled with, by adding a signal mask to
it; on return from the handler, the thread must block the corresponding
signal.

In the test description, I have also described signal delivery and blockage,
for ease of understanding what the test does.

Signed-off-by: Dev Jain <dev.jain@arm.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/signal/.gitignore     |   1 +
 tools/testing/selftests/signal/Makefile       |   3 +-
 .../selftests/signal/mangle_uc_sigmask.c      | 184 ++++++++++++++++++
 3 files changed, 187 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/signal/mangle_uc_sigmask.c

diff --git a/tools/testing/selftests/signal/.gitignore b/tools/testing/selftests/signal/.gitignore
index 98a7bbc4f325..397fef11c89f 100644
--- a/tools/testing/selftests/signal/.gitignore
+++ b/tools/testing/selftests/signal/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
+mangle_uc_sigmask
 sigaltstack
diff --git a/tools/testing/selftests/signal/Makefile b/tools/testing/selftests/signal/Makefile
index dd6be992fd81..735387a53114 100644
--- a/tools/testing/selftests/signal/Makefile
+++ b/tools/testing/selftests/signal/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS = -Wall
-TEST_GEN_PROGS = sigaltstack
+TEST_GEN_PROGS = mangle_uc_sigmask
+TEST_GEN_PROGS += sigaltstack
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/signal/mangle_uc_sigmask.c b/tools/testing/selftests/signal/mangle_uc_sigmask.c
new file mode 100644
index 000000000000..b79ab92178a8
--- /dev/null
+++ b/tools/testing/selftests/signal/mangle_uc_sigmask.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 ARM Ltd.
+ *
+ * Author: Dev Jain <dev.jain@arm.com>
+ *
+ * Test describing a clear distinction between signal states - delivered and
+ * blocked, and their relation with ucontext.
+ *
+ * A process can request blocking of a signal by masking it into its set of
+ * blocked signals; such a signal, when sent to the process by the kernel,
+ * will get blocked by the process and it may later unblock it and take an
+ * action. At that point, the signal will be delivered.
+ *
+ * We test the following functionalities of the kernel:
+ *
+ * ucontext_t describes the interrupted context of the thread; this implies
+ * that, in case of registering a handler and catching the corresponding
+ * signal, that state is before what was jumping into the handler.
+ *
+ * The thread's mask of blocked signals can be permanently changed, i.e, not
+ * just during the execution of the handler, by mangling with uc_sigmask
+ * from inside the handler.
+ *
+ * Assume that we block the set of signals, S1, by sigaction(), and say, the
+ * signal for which the handler was installed, is S2. When S2 is sent to the
+ * program, it will be considered "delivered", since we will act on the
+ * signal and jump to the handler. Any instances of S1 or S2 raised, while the
+ * program is executing inside the handler, will be blocked; they will be
+ * delivered immediately upon termination of the handler.
+ *
+ * For standard signals (also see real-time signals in the man page), multiple
+ * blocked instances of the same signal are not queued; such a signal will
+ * be delivered just once.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <ucontext.h>
+
+#include "../kselftest.h"
+
+void handler_verify_ucontext(int signo, siginfo_t *info, void *uc)
+{
+	int ret;
+
+	/* Kernel dumps ucontext with USR2 blocked */
+	ret = sigismember(&(((ucontext_t *)uc)->uc_sigmask), SIGUSR2);
+	ksft_test_result(ret == 1, "USR2 blocked in ucontext\n");
+
+	/*
+	 * USR2 is blocked; can be delivered neither here, nor after
+	 * exit from handler
+	 */
+	if (raise(SIGUSR2))
+		ksft_exit_fail_perror("raise");
+}
+
+void handler_segv(int signo, siginfo_t *info, void *uc)
+{
+	/*
+	 * Three cases possible:
+	 * 1. Program already terminated due to segmentation fault.
+	 * 2. SEGV was blocked even after returning from handler_usr.
+	 * 3. SEGV was delivered on returning from handler_usr.
+	 * The last option must happen.
+	 */
+	ksft_test_result_pass("SEGV delivered\n");
+}
+
+static int cnt;
+
+void handler_usr(int signo, siginfo_t *info, void *uc)
+{
+	int ret;
+
+	/*
+	 * Break out of infinite recursion caused by raise(SIGUSR1) invoked
+	 * from inside the handler
+	 */
+	++cnt;
+	if (cnt > 1)
+		return;
+
+	/* SEGV blocked during handler execution, delivered on return */
+	if (raise(SIGSEGV))
+		ksft_exit_fail_perror("raise");
+
+	ksft_print_msg("SEGV bypassed successfully\n");
+
+	/*
+	 * Signal responsible for handler invocation is blocked by default;
+	 * delivered on return, leading to recursion
+	 */
+	if (raise(SIGUSR1))
+		ksft_exit_fail_perror("raise");
+
+	ksft_test_result(cnt == 1,
+			 "USR1 is blocked, cannot invoke handler right now\n");
+
+	/* Raise USR1 again; only one instance must be delivered upon exit */
+	if (raise(SIGUSR1))
+		ksft_exit_fail_perror("raise");
+
+	/* SEGV has been blocked in sa_mask, but ucontext is empty */
+	ret = sigismember(&(((ucontext_t *)uc)->uc_sigmask), SIGSEGV);
+	ksft_test_result(ret == 0, "SEGV not blocked in ucontext\n");
+
+	/* USR1 has been blocked, but ucontext is empty */
+	ret = sigismember(&(((ucontext_t *)uc)->uc_sigmask), SIGUSR1);
+	ksft_test_result(ret == 0, "USR1 not blocked in ucontext\n");
+
+	/*
+	 * Mangle ucontext; this will be copied back into &current->blocked
+	 * on return from the handler.
+	 */
+	if (sigaddset(&((ucontext_t *)uc)->uc_sigmask, SIGUSR2))
+		ksft_exit_fail_perror("sigaddset");
+}
+
+int main(int argc, char *argv[])
+{
+	struct sigaction act, act2;
+	sigset_t set, oldset;
+
+	ksft_print_header();
+	ksft_set_plan(7);
+
+	act.sa_flags = SA_SIGINFO;
+	act.sa_sigaction = &handler_usr;
+
+	/* Add SEGV to blocked mask */
+	if (sigemptyset(&act.sa_mask) || sigaddset(&act.sa_mask, SIGSEGV)
+	    || (sigismember(&act.sa_mask, SIGSEGV) != 1))
+		ksft_exit_fail_msg("Cannot add SEGV to blocked mask\n");
+
+	if (sigaction(SIGUSR1, &act, NULL))
+		ksft_exit_fail_perror("Cannot install handler");
+
+	act2.sa_flags = SA_SIGINFO;
+	act2.sa_sigaction = &handler_segv;
+
+	if (sigaction(SIGSEGV, &act2, NULL))
+		ksft_exit_fail_perror("Cannot install handler");
+
+	/* Invoke handler */
+	if (raise(SIGUSR1))
+		ksft_exit_fail_perror("raise");
+
+	/* USR1 must not be queued */
+	ksft_test_result(cnt == 2, "handler invoked only twice\n");
+
+	/* Mangled ucontext implies USR2 is blocked for current thread */
+	if (raise(SIGUSR2))
+		ksft_exit_fail_perror("raise");
+
+	ksft_print_msg("USR2 bypassed successfully\n");
+
+	act.sa_sigaction = &handler_verify_ucontext;
+	if (sigaction(SIGUSR1, &act, NULL))
+		ksft_exit_fail_perror("Cannot install handler");
+
+	if (raise(SIGUSR1))
+		ksft_exit_fail_perror("raise");
+
+	/*
+	 * Raising USR2 in handler_verify_ucontext is redundant since it
+	 * is blocked
+	 */
+	ksft_print_msg("USR2 still blocked on return from handler\n");
+
+	/* Confirm USR2 blockage by sigprocmask() too */
+	if (sigemptyset(&set))
+		ksft_exit_fail_perror("sigemptyset");
+
+	if (sigprocmask(SIG_BLOCK, &set, &oldset))
+		ksft_exit_fail_perror("sigprocmask");
+
+	ksft_test_result(sigismember(&oldset, SIGUSR2) == 1,
+			 "USR2 present in &current->blocked\n");
+
+	ksft_finished();
+}
-- 
2.30.2


