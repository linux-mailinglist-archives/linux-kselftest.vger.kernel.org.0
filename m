Return-Path: <linux-kselftest+bounces-11355-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F57090037D
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 14:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 278451F2503D
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 12:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD28193090;
	Fri,  7 Jun 2024 12:24:26 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E5F19308B;
	Fri,  7 Jun 2024 12:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717763066; cv=none; b=p/NHRX1hDGdAbC9EI/nVFji2k9ttEFywtHHHr4XWLtlc0R0WBrYViWzD1rFxWlohY4ei8egxKJG34qDMwJoao0YMYUzQnSFnSrdWl6OqYrtNlYjdyRh8/rmTJE6gPtNG8TTCb49r2dfo2a1pcJeXltLwhgKN3/WnbsC/3a/GvYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717763066; c=relaxed/simple;
	bh=8mATx8ljEnNckwsyZDussvV/iVh+BnTFcanWppCv5+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ddvNy43m4Z9sFu6LCSm8GOzOk5Ma0OQpe56FSQ41Z7+FsPGy47X33G0sXDFwCXEy5xqdW+KXiXP5Kdt+sXGqW3ErVzjGdAu/yLi9C/XxZDeLs31umc8RdUB21c8DKAcMcwLNzCc3IQxhk3G9BiPZtpjWiX9nlC1cFjCVTxmiKqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4877DA7;
	Fri,  7 Jun 2024 05:24:47 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.42.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8BC473F64C;
	Fri,  7 Jun 2024 05:24:18 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: shuah@kernel.org,
	oleg@redhat.com,
	stsp2@yandex.ru
Cc: mingo@kernel.org,
	tglx@linutronix.de,
	mark.rutland@arm.com,
	ryan.roberts@arm.com,
	broonie@kernel.org,
	suzuki.poulose@arm.com,
	Anshuman.Khandual@arm.com,
	DeepakKumar.Mishra@arm.com,
	AneeshKumar.KizhakeVeetil@arm.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH 2/2] selftests: Add a test mangling with uc_sigmask
Date: Fri,  7 Jun 2024 17:53:19 +0530
Message-Id: <20240607122319.768640-3-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607122319.768640-1-dev.jain@arm.com>
References: <20240607122319.768640-1-dev.jain@arm.com>
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

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 tools/testing/selftests/signal/.gitignore     |   1 +
 tools/testing/selftests/signal/Makefile       |   1 +
 .../selftests/signal/mangle_uc_sigmask.c      | 141 ++++++++++++++++++
 3 files changed, 143 insertions(+)
 create mode 100644 tools/testing/selftests/signal/mangle_uc_sigmask.c

diff --git a/tools/testing/selftests/signal/.gitignore b/tools/testing/selftests/signal/.gitignore
index 98a7bbc4f325..ccba56247942 100644
--- a/tools/testing/selftests/signal/.gitignore
+++ b/tools/testing/selftests/signal/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 sigaltstack
+mangle_uc_sigmask
diff --git a/tools/testing/selftests/signal/Makefile b/tools/testing/selftests/signal/Makefile
index dd6be992fd81..4ebf6ac2e303 100644
--- a/tools/testing/selftests/signal/Makefile
+++ b/tools/testing/selftests/signal/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS = -Wall
 TEST_GEN_PROGS = sigaltstack
+TEST_GEN_PROGS += mangle_uc_sigmask
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/signal/mangle_uc_sigmask.c b/tools/testing/selftests/signal/mangle_uc_sigmask.c
new file mode 100644
index 000000000000..0803aeb248a0
--- /dev/null
+++ b/tools/testing/selftests/signal/mangle_uc_sigmask.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 ARM Ltd.
+ *
+ * Author: Dev Jain <dev.jain@arm.com>
+ *
+ * Test describing a clear distinction between signal states - delivered and
+ * blocked, and their relation with ucontext.
+ */
+
+#include <signal.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <ucontext.h>
+#include <assert.h>
+
+#include "../kselftest.h"
+
+void handler_verify_ucontext(int signo, siginfo_t *info, void *uc)
+{
+	int ret;
+
+	/* Kernel dumps ucontext with USR2 blocked */
+	ret = sigismember(&(((ucontext_t *)uc)->uc_sigmask), SIGUSR2);
+	ksft_test_result(ret == 1, "USR2 in ucontext\n");
+
+	raise(SIGUSR2);
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
+	ksft_print_msg("In handler_usr\n");
+
+	/* SEGV blocked during handler execution, delivered on return */
+	raise(SIGPIPE);
+	ksft_print_msg("SEGV bypassed successfully\n");
+
+	/*
+	 * Signal responsible for handler invocation is blocked by default;
+	 * delivered on return, leading to an infinite recursion
+	 */
+	raise(SIGUSR1);
+	ksft_test_result(cnt == 1,
+			 "USR1 is blocked, cannot invoke handler again\n");
+
+	/* SIGPIPE has been blocked in sa_mask, but ucontext is invariant */
+	ret = sigismember(&(((ucontext_t *)uc)->uc_sigmask), SIGPIPE);
+	ksft_test_result(ret == 0, "USR1 not in ucontext\n");
+
+	/* SIGUSR1 has been blocked, but ucontext is invariant */
+	ret = sigismember(&(((ucontext_t *)uc)->uc_sigmask), SIGUSR1);
+	ksft_test_result(ret == 0, "SEGV not in ucontext\n");
+
+	/*
+	 * Mangle ucontext; this will be copied back into &current->blocked
+	 * on return from the handler.
+	 */
+	if (sigaddset(&((ucontext_t *)uc)->uc_sigmask, SIGUSR2))
+		ksft_exit_fail_perror("Cannot add into uc_sigmask");
+}
+
+int main(int argc, char *argv[])
+{
+	struct sigaction act, act2;
+	sigset_t *set, *oldset;
+
+	ksft_print_header();
+	ksft_set_plan(6);
+
+	act.sa_flags = SA_SIGINFO;
+	act.sa_sigaction = &handler_usr;
+
+	/* add SEGV to blocked mask */
+	if (sigemptyset(&act.sa_mask) || sigaddset(&act.sa_mask, SIGPIPE)
+	    || (sigismember(&act.sa_mask, SIGPIPE) != 1))
+		ksft_exit_fail_msg("Cannot add SEGV to blocked mask\n");
+
+	if (sigaction(SIGUSR1, &act, NULL))
+		ksft_exit_fail_perror("Cannot install handler");
+
+	act2.sa_flags = SA_SIGINFO;
+	act2.sa_sigaction = &handler_segv;
+
+	if (sigaction(SIGPIPE, &act2, NULL))
+		ksft_exit_fail_perror("Cannot install handler");
+
+	/* invoke handler */
+	raise(SIGUSR1);
+
+	/* Mangled ucontext implies USR2 is blocked for current thread */
+	raise(SIGUSR2);
+	ksft_print_msg("USR2 bypassed successfully\n");
+
+	act.sa_sigaction = &handler_verify_ucontext;
+	if (sigaction(SIGUSR1, &act, NULL))
+		ksft_exit_fail_perror("Cannot install handler");
+
+	raise(SIGUSR1);
+
+	ksft_print_msg("USR2 still blocked on return from handler\n");
+
+	/* Confirm USR2 blockage by sigprocmask() too */
+	set = malloc(sizeof(sigset_t *));
+	oldset = malloc(sizeof(sigset_t *));
+
+	if (sigemptyset(set))
+		ksft_exit_fail_perror("Cannot empty set");
+
+	if (sigprocmask(SIG_BLOCK, set, oldset))
+		ksft_exit_fail_perror("sigprocmask()");
+
+	ksft_test_result(sigismember(oldset, SIGUSR2) == 1,
+			 "USR2 present in &current->blocked\n");
+
+	ksft_finished();
+}
-- 
2.34.1


