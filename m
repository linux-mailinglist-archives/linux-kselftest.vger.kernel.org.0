Return-Path: <linux-kselftest+bounces-16052-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA6295B4B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 14:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B90982850A5
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 12:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA63C1C9432;
	Thu, 22 Aug 2024 12:09:59 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684B3170A2B;
	Thu, 22 Aug 2024 12:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724328599; cv=none; b=UD4EGlH6h/sb4an0qJ8srIxP7DIqGdiA2w5kzNmjcg/DNtor1TRmBNI9vzEtoU6JWWEwXKZR9wZzdtTiEPCw4k5pT7wucBnJk60A+DSdm1bfy4WC+XXuGUVR0q21hMqKS/LDiDon0PoXR4YAc3MFJ+F2yTomlGfBtOH+NJA9sYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724328599; c=relaxed/simple;
	bh=seFO9TIQA80Rk3vfTWOTemUdTrJGdSJnXUw8WYFJSEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R37/LWsLvTPWBSo0g1OuqdFMpjD4ZwMYDrs/M2Jna77KMHHIL+/hX1PIxc0N6o0j6HBKUY59+8eS2fbtyX2k6tTpkxoQCBrVlVd+jfWOxqGx3+u3CcqTQriZtqZYWX0LLxO+GXRLBqy8qkGOvujxlPWkOSTGlck0rPc+JcwAlKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B301BDA7;
	Thu, 22 Aug 2024 05:10:22 -0700 (PDT)
Received: from e116581.arm.com (unknown [10.163.87.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7E82C3F66E;
	Thu, 22 Aug 2024 05:09:50 -0700 (PDT)
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
Subject: [PATCH v6 2/2] selftests: Add a test mangling with uc_sigmask
Date: Thu, 22 Aug 2024 17:39:15 +0530
Message-Id: <20240822120915.3584731-3-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822120915.3584731-1-dev.jain@arm.com>
References: <20240822120915.3584731-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test is motivated by the following observation:

Raise a signal, jump to signal handler. The ucontext_t structure dumped
by kernel to userspace has a uc_sigmask field having the mask of blocked
signals. If you run a fresh minimalistic program doing this, this field
is empty, even if you block some signals while registering the handler
with sigaction().

Here is what the man-pages have to say:

sigaction(2): "sa_mask specifies a mask of signals which should be blocked
(i.e., added to the signal mask of the thread in which the signal handler
is invoked) during execution of the signal handler. In addition, the
signal which triggered the handler will be blocked, unless the SA_NODEFER
flag is used."

signal(7): Under "Execution of signal handlers", (1.3) implies:

"The thread's current signal mask is accessible via the ucontext_t
object that is pointed to by the third argument of the signal handler."

But, (1.4) states:

"Any signals specified in act->sa_mask when registering the handler with
sigprocmask(2) are added to the thread's signal mask.  The signal being
delivered is also added to the signal mask, unless SA_NODEFER was
specified when registering the handler.  These signals are thus blocked
while the handler executes."

There clearly is no distinction being made in the man pages between
"Thread's signal mask" and ucontext_t; this logically should imply
that a signal blocked by populating struct sigaction should be visible
in ucontext_t.

Here is what the kernel code does (for Aarch64):

do_signal() -> handle_signal() -> sigmask_to_save(), which returns
&current->blocked, is passed to setup_rt_frame() -> setup_sigframe() ->
__copy_to_user(). Hence, &current->blocked is copied to ucontext_t
exposed to userspace. Returning back to handle_signal(),
signal_setup_done() -> signal_delivered() -> sigorsets() and
set_current_blocked() are responsible for using information from
struct ksignal ksig, which was populated through the sigaction()
system call in kernel/signal.c:
copy_from_user(&new_sa.sa, act, sizeof(new_sa.sa)),
to update &current->blocked; hence, the set of blocked signals for the
current thread is updated AFTER the kernel dumps ucontext_t to
userspace.

Assuming that the above is indeed the intended behaviour, because it
semantically makes sense, since the signals blocked using sigaction()
remain blocked only till the execution of the handler, and not in the
context present before jumping to the handler (but nothing can be
confirmed from the man-pages), this patch introduces a test for
mangling with uc_sigmask.

The test asserts the relation between blocked signal, delivered signal,
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
index 50a19a8888ce..3f339865a3b6 100644
--- a/tools/testing/selftests/signal/.gitignore
+++ b/tools/testing/selftests/signal/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
+mangle_uc_sigmask
 sas
diff --git a/tools/testing/selftests/signal/Makefile b/tools/testing/selftests/signal/Makefile
index 3e96d5d47036..e0bf7058d19c 100644
--- a/tools/testing/selftests/signal/Makefile
+++ b/tools/testing/selftests/signal/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS = -Wall
-TEST_GEN_PROGS = sas
+TEST_GEN_PROGS = mangle_uc_sigmask
+TEST_GEN_PROGS += sas
 
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


