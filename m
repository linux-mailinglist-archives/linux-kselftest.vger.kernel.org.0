Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A94E7FF21
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2019 19:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391203AbfHBRDg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Aug 2019 13:03:36 -0400
Received: from foss.arm.com ([217.140.110.172]:55058 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388317AbfHBRDg (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Aug 2019 13:03:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4F9E1688;
        Fri,  2 Aug 2019 10:03:35 -0700 (PDT)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 249B03F575;
        Fri,  2 Aug 2019 10:03:35 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org
Cc:     andreyknvl@google.com, dave.martin@arm.com
Subject: [PATCH v3 05/11] kselftest: arm64: mangle_pstate_ssbs_regs
Date:   Fri,  2 Aug 2019 18:02:54 +0100
Message-Id: <20190802170300.20662-6-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190802170300.20662-1-cristian.marussi@arm.com>
References: <20190802170300.20662-1-cristian.marussi@arm.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Added a simple mangle testcase which messes with the ucontext_t
from within the sig_handler, trying to toggle PSTATE SSBS bit.
Expect SIGILL if SSBS feature unsupported or that the value set in
PSTATE.SSBS is preserved on test PASS.

This commit also introduces a new common utility function:
get_current_context() which can be used to grab a ucontext without
the help of libc, and detect if such ucontext has been actively used
to jump back into it.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 .../selftests/arm64/signal/test_signals.h     |  4 +
 .../arm64/signal/test_signals_utils.c         | 93 +++++++++++++++++++
 .../arm64/signal/test_signals_utils.h         |  2 +
 .../arm64/signal/testcases/.gitignore         |  1 +
 .../testcases/mangle_pstate_ssbs_regs.c       | 56 +++++++++++
 5 files changed, 156 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_ssbs_regs.c

diff --git a/tools/testing/selftests/arm64/signal/test_signals.h b/tools/testing/selftests/arm64/signal/test_signals.h
index 85db3ac44b32..37bed0590226 100644
--- a/tools/testing/selftests/arm64/signal/test_signals.h
+++ b/tools/testing/selftests/arm64/signal/test_signals.h
@@ -116,6 +116,10 @@ struct tdescr {
 	/* optional sa_flags for the installed handler */
 	int		sa_flags;
 	ucontext_t	saved_uc;
+	/* used by get_current_ctx() */
+	size_t		live_sz;
+	ucontext_t	*live_uc;
+	volatile bool	live_uc_valid;
 
 	/* a setup function to be called before test starts */
 	int (*setup)(struct tdescr *td);
diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.c b/tools/testing/selftests/arm64/signal/test_signals_utils.c
index ac0055f6340b..faf55ba99d58 100644
--- a/tools/testing/selftests/arm64/signal/test_signals_utils.c
+++ b/tools/testing/selftests/arm64/signal/test_signals_utils.c
@@ -11,12 +11,16 @@
 #include <linux/auxvec.h>
 #include <ucontext.h>
 
+#include <asm/unistd.h>
+
 #include "test_signals.h"
 #include "test_signals_utils.h"
 #include "testcases/testcases.h"
 
 extern struct tdescr *current;
 
+static int sig_copyctx = SIGUSR2;
+
 static char *feats_store[FMAX_END] = {
 	"SSBS",
 	"PAN",
@@ -37,6 +41,85 @@ static inline char *feats_to_string(unsigned long feats)
 	return feats_string;
 }
 
+/*
+ * Obtaining a valid and full-blown ucontext_t from userspace is tricky:
+ * libc getcontext does() not save all the regs and messes with some of
+ * them (pstate value in particular is not reliable).
+ * Here we use a service signal to grab the ucontext_t from inside a
+ * dedicated signal handler, since there, it is populated by Kernel
+ * itself in setup_sigframe(). The grabbed context is then stored and
+ * made available in td->live_uc.
+ *
+ * Anyway this function really serves a dual purpose:
+ *
+ * 1. grab a valid sigcontext into td->live_uc for result analysis: in
+ * such case it returns 1.
+ *
+ * 2. detect if somehow a previously grabbed live_uc context has been
+ * used actively with a sigreturn: in such a case the execution would have
+ * magically resumed in the middle of the function itself (seen_already==1):
+ * in such a case return 0, since in fact we have not just simply grabbed
+ * the context.
+ *
+ * This latter case is useful to detect when a fake_sigreturn test-case has
+ * unexpectedly survived without hittig a SEGV.
+ */
+bool get_current_context(struct tdescr *td, ucontext_t *dest_uc)
+{
+	static volatile sig_atomic_t seen_already;
+
+	if (!td || !dest_uc) {
+		fprintf(stdout, "Signal-based Context dumping NOT available\n");
+		return 0;
+	}
+
+	/* it's a genuine invokation..reinit */
+	seen_already = 0;
+	td->live_uc_valid = 0;
+	td->live_sz = sizeof(*dest_uc);
+	memset(dest_uc, 0x00, td->live_sz);
+	td->live_uc = dest_uc;
+	/*
+	 * Grab ucontext_t triggering a signal...
+	 * ASM equivalent of raise(sig_copyctx);
+	 *
+	 * Note that:
+	 * - live_uc_valid is declared volatile in struct tdescr
+	 *   since it will be changed inside the sig_copyctx handler.
+	 * - the kill() syscall invocation returns only after any possible
+	 *   registered sig_handler for the invoked signal has returned,
+	 *   so that live_uc_valid flag is surely up to date when this
+	 *   function return it.
+	 * - the additional 'memory' clobber is there to avoid possible
+	 *   compiler's assumption on the content pointed by dest_uc, which
+	 *   is changed inside the handler, but not referenced here anyway.
+	 */
+	asm volatile ("mov x8, %0\n\t"
+		      "svc #0\n\t"
+		      "mov x1, %1\n\t"
+		      "mov x8, %2\n\t"
+		      "svc #0"
+		      :
+		      : "i" (__NR_getpid),
+		        "r" (sig_copyctx),
+			"i" (__NR_kill)
+		      : "x1","x8","x0","memory");
+	/*
+	 * If we get here with seen_already==1 it implies the td->live_uc
+	 * context has been used to get back here....this probably means
+	 * a test has failed to cause a SEGV...anyway the live_uc has not
+	 * just been acquired...so return 0
+	 */
+	if (seen_already) {
+		fprintf(stdout,
+			"Successful sigreturn detected: live_uc is stale !\n");
+		return 0;
+	}
+	seen_already = 1;
+
+	return td->live_uc_valid;
+}
+
 static void unblock_signal(int signum)
 {
 	sigset_t sset;
@@ -112,6 +195,12 @@ static void default_handler(int signum, siginfo_t *si, void *uc)
 		 * to terminate immediately exiting straight away
 		 */
 		default_result(current, 1);
+	} else if (signum == sig_copyctx && current->live_uc) {
+		memcpy(current->live_uc, uc, current->live_sz);
+		ASSERT_GOOD_CONTEXT(current->live_uc);
+		current->live_uc_valid = 1;
+		fprintf(stderr,
+			"GOOD CONTEXT grabbed from sig_copyctx handler\n");
 	} else {
 		if (signum == current->sig_unsupp && !are_feats_ok(current)) {
 			fprintf(stderr, "-- RX SIG_UNSUPP on unsupported feature...OK\n");
@@ -214,6 +303,10 @@ static int test_init(struct tdescr *td)
 			!feats_ok ? "NOT " : "");
 	}
 
+	if (td->sig_trig == sig_copyctx)
+		sig_copyctx = SIGUSR1;
+	unblock_signal(sig_copyctx);
+
 	td->initialized = 1;
 	return 1;
 }
diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.h b/tools/testing/selftests/arm64/signal/test_signals_utils.h
index 8658d1a7d4b9..ce35be8ebc8e 100644
--- a/tools/testing/selftests/arm64/signal/test_signals_utils.h
+++ b/tools/testing/selftests/arm64/signal/test_signals_utils.h
@@ -10,4 +10,6 @@ int test_setup(struct tdescr *td);
 void test_cleanup(struct tdescr *td);
 int test_run(struct tdescr *td);
 void test_result(struct tdescr *td);
+
+bool get_current_context(struct tdescr *td, ucontext_t *dest_uc);
 #endif
diff --git a/tools/testing/selftests/arm64/signal/testcases/.gitignore b/tools/testing/selftests/arm64/signal/testcases/.gitignore
index 226bb179b673..a48a118b1a1a 100644
--- a/tools/testing/selftests/arm64/signal/testcases/.gitignore
+++ b/tools/testing/selftests/arm64/signal/testcases/.gitignore
@@ -3,3 +3,4 @@ mangle_pstate_invalid_daif_bits
 mangle_pstate_invalid_mode_el1
 mangle_pstate_invalid_mode_el2
 mangle_pstate_invalid_mode_el3
+mangle_pstate_ssbs_regs
diff --git a/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_ssbs_regs.c b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_ssbs_regs.c
new file mode 100644
index 000000000000..a399d9aa40d5
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_ssbs_regs.c
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2019 ARM Limited */
+
+#include <stdio.h>
+#include <ucontext.h>
+
+#include "test_signals_utils.h"
+#include "testcases.h"
+
+static int mangle_invalid_pstate_ssbs_run(struct tdescr *td,
+					  siginfo_t *si, ucontext_t *uc)
+{
+	ASSERT_GOOD_CONTEXT(uc);
+
+	/* set bit value */
+	uc->uc_mcontext.pstate |= PSR_SSBS_BIT;
+	fprintf(stderr, "SSBS set to 1 -- PSTATE: 0x%016lX\n",
+		uc->uc_mcontext.pstate);
+	/* Save after mangling...it should be preserved */
+	td->saved_uc = *uc;
+
+	return 1;
+}
+
+static void pstate_ssbs_bit_checks(struct tdescr *td)
+{
+	uint64_t val = 0;
+	ucontext_t uc;
+
+	/* This check reports some result even if MRS SSBS unsupported */
+	if (get_current_context(td, &uc))
+		fprintf(stderr,
+			"INFO: live_uc - got PSTATE: 0x%016lX -> SSBS %s\n",
+			uc.uc_mcontext.pstate,
+			(td->saved_uc.uc_mcontext.pstate & PSR_SSBS_BIT) ==
+			(uc.uc_mcontext.pstate & PSR_SSBS_BIT) ?
+			"PRESERVED" : "CLEARED");
+
+	fprintf(stderr, "Checking with MRS SSBS...\n");
+	get_regval(S3_MRS_SSBS_SYSREG, val);
+	fprintf(stderr, "INFO: MRS SSBS - got: 0x%016lX\n", val);
+	/* pass when preserved */
+	td->pass = (val & PSR_SSBS_BIT) ==
+		   (td->saved_uc.uc_mcontext.pstate & PSR_SSBS_BIT);
+}
+
+struct tdescr tde = {
+		.sanity_disabled = true,
+		.name = "MANGLE_PSTATE_SSBS_REGS",
+		.descr = "Mangling uc_mcontext changing SSBS.(PRESERVE)",
+		.feats_required = FEAT_SSBS,
+		.sig_trig = SIGUSR1,
+		.sig_unsupp = SIGILL,
+		.run = mangle_invalid_pstate_ssbs_run,
+		.check_result = pstate_ssbs_bit_checks,
+};
-- 
2.17.1

