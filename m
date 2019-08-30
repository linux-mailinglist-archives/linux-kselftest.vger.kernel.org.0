Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 690F4A3C59
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2019 18:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbfH3Qnl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Aug 2019 12:43:41 -0400
Received: from foss.arm.com ([217.140.110.172]:34988 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728373AbfH3Qnl (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Aug 2019 12:43:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C56911596;
        Fri, 30 Aug 2019 09:43:39 -0700 (PDT)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDD163F718;
        Fri, 30 Aug 2019 09:43:38 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org
Cc:     andreyknvl@google.com, dave.martin@arm.com, amit.kachhap@arm.com
Subject: [PATCH v4 05/11] kselftest: arm64: mangle_pstate_ssbs_regs
Date:   Fri, 30 Aug 2019 17:42:42 +0100
Message-Id: <20190830164248.16238-6-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830164248.16238-1-cristian.marussi@arm.com>
References: <20190830164248.16238-1-cristian.marussi@arm.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a simple mangle testcase which messes with the ucontext_t from within
the signal handler, trying to set the PSTATE SSBS bit.
Expect SIGILL if SSBS feature is unsupported or that, on test PASS, the
value set in PSTATE.SSBS in the signal frame is preserved by sigreturn.

Additionally, in order to support this test specific needs:
- extend signal testing framework to allow the definition of a custom per
  test initialization function to be run at the end of test setup.
- introduced a set_regval() helper to set system register values in a
  toolchain independent way.
- introduce also a new common utility function: get_current_context()
  which can be used to grab a ucontext without the help of libc, and
  detect if such ucontext has been actively used to jump back into it.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v3 --> v4
- fix commit message
- missing include signal.h
- added .init per-test init-func
- added set_regval() helper
- added SSBS clear to 0 custom .init function
- removed volatile qualifier associated with sig_atomic_t data
- added dsb inside handler to ensure the writes related to the
  grabbed ucontext have completed
- added test description
---
 .../selftests/arm64/signal/test_signals.h     | 20 +++-
 .../arm64/signal/test_signals_utils.c         | 98 +++++++++++++++++++
 .../arm64/signal/test_signals_utils.h         |  2 +
 .../testcases/mangle_pstate_ssbs_regs.c       | 69 +++++++++++++
 4 files changed, 184 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_ssbs_regs.c

diff --git a/tools/testing/selftests/arm64/signal/test_signals.h b/tools/testing/selftests/arm64/signal/test_signals.h
index a1cf69997604..0767e27fbe78 100644
--- a/tools/testing/selftests/arm64/signal/test_signals.h
+++ b/tools/testing/selftests/arm64/signal/test_signals.h
@@ -27,6 +27,14 @@
 	: "memory");					\
 }
 
+#define set_regval(regname, in)				\
+{							\
+	asm volatile("msr " __stringify(regname) ", %0" \
+	:						\
+	: "r" (in)					\
+	: "memory");					\
+}
+
 /* Regs encoding and masks naming copied in from sysreg.h */
 #define SYS_ID_AA64MMFR1_EL1	S3_0_C0_C7_1	/* MRS Emulated */
 #define SYS_ID_AA64MMFR2_EL1	S3_0_C0_C7_2	/* MRS Emulated */
@@ -89,12 +97,16 @@ struct tdescr {
 	/* optional sa_flags for the installed handler */
 	int		sa_flags;
 	ucontext_t	saved_uc;
-
-	/* a custom setup function to be called before test starts */
+	/* used by get_current_ctx() */
+	size_t		live_sz;
+	ucontext_t	*live_uc;
+	sig_atomic_t	live_uc_valid;
+	/* a custom setup: called alternatively to default_setup */
 	int (*setup)(struct tdescr *td);
+	/* a custom init: called by default test initialization */
+	void (*init)(struct tdescr *td);
 	/* a custom cleanup function called before test exits */
 	void (*cleanup)(struct tdescr *td);
-
 	/* an optional function to be used as a trigger for test starting */
 	int (*trigger)(struct tdescr *td);
 	/*
@@ -102,10 +114,8 @@ struct tdescr {
 	 * presence of the trigger function above; this is mandatory
 	 */
 	int (*run)(struct tdescr *td, siginfo_t *si, ucontext_t *uc);
-
 	/* an optional function for custom results' processing */
 	void (*check_result)(struct tdescr *td);
-
 	void *priv;
 };
 
diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.c b/tools/testing/selftests/arm64/signal/test_signals_utils.c
index e2a5f37e6ad3..c6fdcb23f246 100644
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
 	" SSBS ",
 	" PAN ",
@@ -43,6 +47,81 @@ static inline char *feats_to_string(unsigned long feats)
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
+	static sig_atomic_t seen_already;
+
+	assert(td && dest_uc);
+	/* it's a genuine invocation..reinit */
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
+	 * - live_uc_valid is declared sig_atomic_t in struct tdescr
+	 *   since it will be changed inside the sig_copyctx handler
+	 * - the kill() syscall invocation returns only after any possible
+	 *   registered signal handler for the invoked signal has returned,
+	 *   so that live_uc_valid flag is surely up to date when this
+	 *   function return it.
+	 * - the additional 'memory' clobber is there to avoid possible
+	 *   compiler's assumption on live_uc_valid, seen-already and
+	 *   the content pointed by dest_uc, which are all changed inside
+	 *   the signal handler, without resorting to the volatile qualifier
+	 *   (and keeping quiet checkpatch.pl)
+	 */
+	asm volatile ("mov x8, %0\n\t"
+		      "svc #0\n\t"
+		      "mov x1, %1\n\t"
+		      "mov x8, %2\n\t"
+		      "svc #0"
+		      :
+		      : "i" (__NR_getpid), "r" (sig_copyctx), "i" (__NR_kill)
+		      : "x1", "x8", "x0", "memory");
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
@@ -124,6 +203,17 @@ static void default_handler(int signum, siginfo_t *si, void *uc)
 		 * to terminate immediately exiting straight away
 		 */
 		default_result(current, 1);
+	} else if (signum == sig_copyctx && current->live_uc) {
+		memcpy(current->live_uc, uc, current->live_sz);
+		ASSERT_GOOD_CONTEXT(current->live_uc);
+		current->live_uc_valid = 1;
+		/*
+		 * Ensure above writes have completed before signal
+		 * handler terminates
+		 */
+		asm volatile ("dsb sy" ::: "memory");
+		fprintf(stderr,
+			"GOOD CONTEXT grabbed from sig_copyctx handler\n");
 	} else {
 		if (signum == current->sig_unsupp && !are_feats_ok(current)) {
 			fprintf(stderr,
@@ -222,7 +312,15 @@ static int test_init(struct tdescr *td)
 			!feats_ok ? "NOT " : "");
 	}
 
+	if (td->sig_trig == sig_copyctx)
+		sig_copyctx = SIGUSR1;
+	unblock_signal(sig_copyctx);
+
+	/* Perform test specific additional initialization */
+	if (td->init)
+		td->init(td);
 	td->initialized = 1;
+
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
diff --git a/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_ssbs_regs.c b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_ssbs_regs.c
new file mode 100644
index 000000000000..15e6f62512d5
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_ssbs_regs.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 ARM Limited
+ *
+ * Try to mangle the ucontext from inside a signal handler, setting the
+ * SSBS bit to 1 and veryfing that such modification is preserved.
+ */
+
+#include <stdio.h>
+#include <signal.h>
+#include <ucontext.h>
+
+#include "test_signals_utils.h"
+#include "testcases.h"
+
+static void mangle_invalid_pstate_ssbs_init(struct tdescr *td)
+{
+	fprintf(stderr, "Clearing SSBS to 0\n");
+	set_regval(SSBS_SYSREG, 0);
+}
+
+static int mangle_invalid_pstate_ssbs_run(struct tdescr *td,
+					  siginfo_t *si, ucontext_t *uc)
+{
+	ASSERT_GOOD_CONTEXT(uc);
+
+	/* set bit value */
+	uc->uc_mcontext.pstate |= PSR_SSBS_BIT;
+	fprintf(stderr, "SSBS set to 1 -- PSTATE: 0x%016llX\n",
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
+			"INFO: live_uc - got PSTATE: 0x%016llX -> SSBS %s\n",
+			uc.uc_mcontext.pstate,
+			(td->saved_uc.uc_mcontext.pstate & PSR_SSBS_BIT) ==
+			(uc.uc_mcontext.pstate & PSR_SSBS_BIT) ?
+			"PRESERVED" : "CLEARED");
+
+	fprintf(stderr, "Checking with MRS SSBS...\n");
+	get_regval(SSBS_SYSREG, val);
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
+		.init = mangle_invalid_pstate_ssbs_init,
+		.run = mangle_invalid_pstate_ssbs_run,
+		.check_result = pstate_ssbs_bit_checks,
+};
-- 
2.17.1

