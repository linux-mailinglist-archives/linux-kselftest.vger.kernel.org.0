Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74C5DCEBDA
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2019 20:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbfJGSaV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Oct 2019 14:30:21 -0400
Received: from foss.arm.com ([217.140.110.172]:44082 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728187AbfJGSaV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Oct 2019 14:30:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DED4216A3;
        Mon,  7 Oct 2019 11:30:19 -0700 (PDT)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 022333F68E;
        Mon,  7 Oct 2019 11:30:18 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org
Cc:     andreyknvl@google.com, dave.martin@arm.com, amit.kachhap@arm.com
Subject: [PATCH v7 05/11] kselftest: arm64: mangle_pstate_ssbs_regs
Date:   Mon,  7 Oct 2019 19:29:48 +0100
Message-Id: <20191007182954.25730-6-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191007182954.25730-1-cristian.marussi@arm.com>
References: <20191007182954.25730-1-cristian.marussi@arm.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a simple mangle testcase which messes with the ucontext_t from within
the signal handler, trying to set the PSTATE SSBS bit and verify that
SSBS bit set is preserved across sigreturn.
Lookup PSTATE.SSBS directly using dedicated helper to grab PSTATE from a
live sigframe.

Additionally, in order to support this test specific needs:
- extend signal testing framework to allow the definition of a custom
  per test initialization function to be run at the end of test setup
  and before test run routine. This will support also test SKIP.
- introduce also a new common utility function: get_current_context()
  which can be used to grab a ucontext without the help of libc, and
  detect if such ucontext has been actively used to jump back.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v6 --> v7
- fixed missing header for memcpy
- fixed misleading comment in get_current_context()
- fixed retvalue checks on get_current_context() invocation
- extend test_init()/test_result() and .init to report KSFT_SKIP
- SKIP mangle_pstate_ssbs_regs if SSBS not supported at all
- check SSBS support looking up ID_AA64PFR1_EL1.SSBS in test_init()
  instead of using MRS/MSR
v5 --> v6
- using SIGTRAP as sig_copyctx for get_current_context()
- get_current_context() is now __always_inline
- last minute check for SSBS cleared
- restore volatile usage, dropping useless DSB
- output clobber on *dest_uc
- no abort() on SSSB not cleared
- refactored/relocated test_init() call to be after test_setup()
  [to catch early SIGILL while initializing]
- avoid MRS SSBS when !feats_ok()...use instead PSTATE.SSBS
- refactored SIG_COPYCTX usage to fit new splitted-by-signal layout
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
 .../selftests/arm64/signal/test_signals.c     |  6 +-
 .../selftests/arm64/signal/test_signals.h     | 25 ++++-
 .../arm64/signal/test_signals_utils.c         | 73 ++++++++++++--
 .../arm64/signal/test_signals_utils.h         | 99 +++++++++++++++++++
 .../testcases/mangle_pstate_ssbs_regs.c       | 92 +++++++++++++++++
 5 files changed, 279 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_ssbs_regs.c

diff --git a/tools/testing/selftests/arm64/signal/test_signals.c b/tools/testing/selftests/arm64/signal/test_signals.c
index cb970346b280..416b1ff43199 100644
--- a/tools/testing/selftests/arm64/signal/test_signals.c
+++ b/tools/testing/selftests/arm64/signal/test_signals.c
@@ -19,11 +19,11 @@ int main(int argc, char *argv[])
 	current = &tde;
 
 	ksft_print_msg("%s :: %s\n", current->name, current->descr);
-	if (test_setup(current)) {
+	if (test_setup(current) && test_init(current)) {
 		test_run(current);
-		test_result(current);
 		test_cleanup(current);
 	}
+	test_result(current);
 
-	return current->pass ? KSFT_PASS : KSFT_FAIL;
+	return current->result;
 }
diff --git a/tools/testing/selftests/arm64/signal/test_signals.h b/tools/testing/selftests/arm64/signal/test_signals.h
index f712b5daa10b..ad8175806034 100644
--- a/tools/testing/selftests/arm64/signal/test_signals.h
+++ b/tools/testing/selftests/arm64/signal/test_signals.h
@@ -27,13 +27,25 @@
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
+#define SYS_ID_AA64PFR1_EL1	S3_0_C0_C4_1	/* MRS Emulated */
+#define ID_AA64PFR1_SSBS_SHIFT	4
 #define ID_AA64MMFR1_PAN_SHIFT	20
 #define ID_AA64MMFR2_UAO_SHIFT	4
 
 /* Local Helpers */
+#define ID_AA64PFR1_EL1_SSBS_SUPPORTED(val) \
+	(!!((val) & (0xfUL << ID_AA64PFR1_SSBS_SHIFT)))
 #define ID_AA64MMFR1_EL1_PAN_SUPPORTED(val) \
 	(!!((val) & (0xfUL << ID_AA64MMFR1_PAN_SHIFT)))
 #define ID_AA64MMFR2_EL1_UAO_SUPPORTED(val) \
@@ -86,17 +98,24 @@ struct tdescr {
 	unsigned int		timeout;
 	bool			triggered;
 	bool			pass;
+	unsigned int		result;
 	/* optional sa_flags for the installed handler */
 	int			sa_flags;
 	ucontext_t		saved_uc;
+	/* used by get_current_ctx() */
+	size_t			live_sz;
+	ucontext_t		*live_uc;
+	volatile sig_atomic_t	live_uc_valid;
 	/* optional test private data */
-	void                    *priv;
+	void			*priv;
 
-	/* a custom setup function to be called before test starts */
+	/* a custom setup: called alternatively to default_setup */
 	int (*setup)(struct tdescr *td);
+	/* a custom init: called by default test init after test_setup */
+	bool (*init)(struct tdescr *td);
 	/* a custom cleanup function called before test exits */
 	void (*cleanup)(struct tdescr *td);
-	/* an optional function to be used as a trigger for test starting */
+	/* an optional function to be used as a trigger for starting test */
 	int (*trigger)(struct tdescr *td);
 	/*
 	 * the actual test-core: invoked differently depending on the
diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.c b/tools/testing/selftests/arm64/signal/test_signals_utils.c
index ff24db6f9d06..41ab2711d3b9 100644
--- a/tools/testing/selftests/arm64/signal/test_signals_utils.c
+++ b/tools/testing/selftests/arm64/signal/test_signals_utils.c
@@ -11,12 +11,19 @@
 #include <linux/auxvec.h>
 #include <ucontext.h>
 
+#include <asm/unistd.h>
+
+#include <kselftest.h>
+
 #include "test_signals.h"
 #include "test_signals_utils.h"
 #include "testcases/testcases.h"
 
+
 extern struct tdescr *current;
 
+static int sig_copyctx = SIGTRAP;
+
 static char const *const feats_names[FMAX_END] = {
 	" SSBS ",
 	" PAN ",
@@ -54,12 +61,18 @@ static void unblock_signal(int signum)
 
 static void default_result(struct tdescr *td, bool force_exit)
 {
-	if (td->pass)
+	if (td->result == KSFT_SKIP) {
+		fprintf(stderr, "==>> completed. SKIP.\n");
+	} else if (td->pass) {
 		fprintf(stderr, "==>> completed. PASS(1)\n");
-	else
+		td->result = KSFT_PASS;
+	} else {
 		fprintf(stdout, "==>> completed. FAIL(0)\n");
+		td->result = KSFT_FAIL;
+	}
+
 	if (force_exit)
-		exit(td->pass ? EXIT_SUCCESS : EXIT_FAILURE);
+		exit(td->result);
 }
 
 /*
@@ -148,6 +161,20 @@ static bool handle_signal_ok(struct tdescr *td,
 	return true;
 }
 
+static bool handle_signal_copyctx(struct tdescr *td,
+				  siginfo_t *si, void *uc)
+{
+	/* Mangling PC to avoid loops on original BRK instr */
+	((ucontext_t *)uc)->uc_mcontext.pc += 4;
+	memcpy(td->live_uc, uc, td->live_sz);
+	ASSERT_GOOD_CONTEXT(td->live_uc);
+	td->live_uc_valid = 1;
+	fprintf(stderr,
+		"GOOD CONTEXT grabbed from sig_copyctx handler\n");
+
+	return true;
+}
+
 static void default_handler(int signum, siginfo_t *si, void *uc)
 {
 	if (current->sig_unsupp && signum == current->sig_unsupp &&
@@ -159,6 +186,9 @@ static void default_handler(int signum, siginfo_t *si, void *uc)
 	} else if (current->sig_ok && signum == current->sig_ok &&
 		   handle_signal_ok(current, si, uc)) {
 		fprintf(stderr, "Handled SIG_OK\n");
+	} else if (signum == sig_copyctx && current->live_uc &&
+		   handle_signal_copyctx(current, si, uc)) {
+		fprintf(stderr, "Handled SIG_COPYCTX\n");
 	} else {
 		if (signum == SIGALRM && current->timeout) {
 			fprintf(stderr, "-- Timeout !\n");
@@ -211,8 +241,17 @@ static inline int default_trigger(struct tdescr *td)
 	return !raise(td->sig_trig);
 }
 
-static int test_init(struct tdescr *td)
+int test_init(struct tdescr *td)
 {
+	if (td->sig_trig == sig_copyctx) {
+		fprintf(stdout,
+			"Signal %d is RESERVED, cannot be used as a trigger. Aborting\n",
+			sig_copyctx);
+		return 0;
+	}
+	/* just in case */
+	unblock_signal(sig_copyctx);
+
 	td->minsigstksz = getauxval(AT_MINSIGSTKSZ);
 	if (!td->minsigstksz)
 		td->minsigstksz = MINSIGSTKSZ;
@@ -224,11 +263,19 @@ static int test_init(struct tdescr *td)
 		 * Checking for CPU required features using both the
 		 * auxval and the arm64 MRS Emulation to read sysregs.
 		 */
-		if (getauxval(AT_HWCAP) & HWCAP_SSBS)
-			td->feats_supported |= FEAT_SSBS;
 		if (getauxval(AT_HWCAP) & HWCAP_CPUID) {
 			uint64_t val = 0;
 
+			/*
+			 * Uses MRS emulation to check capability and classify
+			 * as supported if SSBS bits are set to:
+			 *
+			 * 0b01 - PSTATE.SSBS supported, MRS/MSR NOT supported
+			 * 0b10 - PSTATE.SSBS supported, MRS/MSR supported
+			 */
+			get_regval(SYS_ID_AA64PFR1_EL1, val);
+			if (ID_AA64PFR1_EL1_SSBS_SUPPORTED(val))
+				td->feats_supported |= FEAT_SSBS;
 			/* Uses MRS emulation to check capability */
 			get_regval(SYS_ID_AA64MMFR1_EL1, val);
 			if (ID_AA64MMFR1_EL1_PAN_SUPPORTED(val))
@@ -250,7 +297,14 @@ static int test_init(struct tdescr *td)
 						~td->feats_supported));
 	}
 
+	/* Perform test specific additional initialization */
+	if (td->init && !td->init(td)) {
+		fprintf(stderr, "FAILED Testcase initialization.\n");
+		return 0;
+	}
 	td->initialized = 1;
+	fprintf(stderr, "Testcase initialized.\n");
+
 	return 1;
 }
 
@@ -262,9 +316,8 @@ int test_setup(struct tdescr *td)
 	assert(td->name);
 	assert(td->run);
 
-	if (!test_init(td))
-		return 0;
-
+	/* Default result is FAIL if test setup fails */
+	td->result = KSFT_FAIL;
 	if (td->setup)
 		return td->setup(td);
 	else
@@ -285,7 +338,7 @@ int test_run(struct tdescr *td)
 
 void test_result(struct tdescr *td)
 {
-	if (td->check_result)
+	if (td->initialized && td->result != KSFT_SKIP && td->check_result)
 		td->check_result(td);
 	default_result(td, 0);
 }
diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.h b/tools/testing/selftests/arm64/signal/test_signals_utils.h
index 47a7592b7c53..fd67b1f23c41 100644
--- a/tools/testing/selftests/arm64/signal/test_signals_utils.h
+++ b/tools/testing/selftests/arm64/signal/test_signals_utils.h
@@ -4,8 +4,13 @@
 #ifndef __TEST_SIGNALS_UTILS_H__
 #define __TEST_SIGNALS_UTILS_H__
 
+#include <assert.h>
+#include <stdio.h>
+#include <string.h>
+
 #include "test_signals.h"
 
+int test_init(struct tdescr *td);
 int test_setup(struct tdescr *td);
 void test_cleanup(struct tdescr *td);
 int test_run(struct tdescr *td);
@@ -16,4 +21,98 @@ static inline bool feats_ok(struct tdescr *td)
 	return (td->feats_required & td->feats_supported) == td->feats_required;
 }
 
+/*
+ * Obtaining a valid and full-blown ucontext_t from userspace is tricky:
+ * libc getcontext does() not save all the regs and messes with some of
+ * them (pstate value in particular is not reliable).
+ *
+ * Here we use a service signal to grab the ucontext_t from inside a
+ * dedicated signal handler, since there, it is populated by Kernel
+ * itself in setup_sigframe(). The grabbed context is then stored and
+ * made available in td->live_uc.
+ *
+ * As service-signal is used a SIGTRAP induced by a 'brk' instruction,
+ * because here we have to avoid syscalls to trigger the signal since
+ * they would cause any SVE sigframe content (if any) to be removed.
+ *
+ * Anyway this function really serves a dual purpose:
+ *
+ * 1. grab a valid sigcontext into td->live_uc for result analysis: in
+ * such case it returns 1.
+ *
+ * 2. detect if, somehow, a previously grabbed live_uc context has been
+ * used actively with a sigreturn: in such a case the execution would have
+ * magically resumed in the middle of this function itself (seen_already==1):
+ * in such a case return 0, since in fact we have not just simply grabbed
+ * the context.
+ *
+ * This latter case is useful to detect when a fake_sigreturn test-case has
+ * unexpectedly survived without hitting a SEGV.
+ *
+ * Note that the case of runtime dynamically sized sigframes (like in SVE
+ * context) is still NOT addressed: sigframe size is supposed to be fixed
+ * at sizeof(ucontext_t).
+ */
+static __always_inline bool get_current_context(struct tdescr *td,
+						ucontext_t *dest_uc)
+{
+	static volatile bool seen_already;
+
+	assert(td && dest_uc);
+	/* it's a genuine invocation..reinit */
+	seen_already = 0;
+	td->live_uc_valid = 0;
+	td->live_sz = sizeof(*dest_uc);
+	memset(dest_uc, 0x00, td->live_sz);
+	td->live_uc = dest_uc;
+	/*
+	 * Grab ucontext_t triggering a SIGTRAP.
+	 *
+	 * Note that:
+	 * - live_uc_valid is declared volatile sig_atomic_t in
+	 *   struct tdescr since it will be changed inside the
+	 *   sig_copyctx handler
+	 * - the additional 'memory' clobber is there to avoid possible
+	 *   compiler's assumption on live_uc_valid and the content
+	 *   pointed by dest_uc, which are all changed inside the signal
+	 *   handler
+	 * - BRK causes a debug exception which is handled by the Kernel
+	 *   and finally causes the SIGTRAP signal to be delivered to this
+	 *   test thread. Since such delivery happens on the ret_to_user()
+	 *   /do_notify_resume() debug exception return-path, we are sure
+	 *   that the registered SIGTRAP handler has been run to completion
+	 *   before the execution path is restored here: as a consequence
+	 *   we can be sure that the volatile sig_atomic_t live_uc_valid
+	 *   carries a meaningful result. Being in a single thread context
+	 *   we'll also be sure that any access to memory modified by the
+	 *   handler (namely ucontext_t) will be visible once returned.
+	 * - note that since we are using a breakpoint instruction here
+	 *   to cause a SIGTRAP, the ucontext_t grabbed from the signal
+	 *   handler would naturally contain a PC pointing exactly to this
+	 *   BRK line, which means that, on return from the signal handler,
+	 *   or if we place the ucontext_t on the stack to fake a sigreturn,
+	 *   we'll end up in an infinite loop of BRK-SIGTRAP-handler.
+	 *   For this reason we take care to artificially move forward the
+	 *   PC to the next instruction while inside the signal handler.
+	 */
+	asm volatile ("brk #666"
+		      : "+m" (*dest_uc)
+		      :
+		      : "memory");
+
+	/*
+	 * If we get here with seen_already==1 it implies the td->live_uc
+	 * context has been used to get back here....this probably means
+	 * a test has failed to cause a SEGV...anyway live_uc does not
+	 * point to a just acquired copy of ucontext_t...so return 0
+	 */
+	if (seen_already) {
+		fprintf(stdout,
+			"Unexpected successful sigreturn detected: live_uc is stale !\n");
+		return 0;
+	}
+	seen_already = 1;
+
+	return td->live_uc_valid;
+}
 #endif
diff --git a/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_ssbs_regs.c b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_ssbs_regs.c
new file mode 100644
index 000000000000..780161dbd7c0
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_ssbs_regs.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 ARM Limited
+ *
+ * Try to mangle the ucontext from inside a signal handler, setting the
+ * SSBS bit to 1 and veryfing that such modification is preserved.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <ucontext.h>
+
+#include <kselftest.h>
+
+#include "test_signals_utils.h"
+#include "testcases.h"
+
+static bool mangle_invalid_pstate_ssbs_init(struct tdescr *td)
+{
+	bool ret;
+
+	ret = feats_ok(td);
+	if (!ret) {
+		fprintf(stderr, "%s: unsupported feature - SKIP.\n", td->name);
+		td->result = KSFT_SKIP;
+	}
+
+	return ret;
+}
+
+static int mangle_invalid_pstate_ssbs_run(struct tdescr *td,
+					  siginfo_t *si, ucontext_t *uc)
+{
+	ASSERT_GOOD_CONTEXT(uc);
+
+	/* set bit value ... should NOT be cleared by Kernel on sigreturn */
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
+	if (!get_current_context(td, &uc)) {
+		fprintf(stderr, "Failed to grab a valid context. Abort\n");
+		abort();
+	}
+
+	fprintf(stderr,
+		"INFO: live_uc - got PSTATE: 0x%016llX -> SSBS %s\n",
+		uc.uc_mcontext.pstate,
+		(td->saved_uc.uc_mcontext.pstate & PSR_SSBS_BIT) ==
+		(uc.uc_mcontext.pstate & PSR_SSBS_BIT) ?
+		"PRESERVED" : "CLEARED");
+
+	/*
+	 * Here conditional on feats_ok() to stay on the safe side...
+	 * ...this test is skipped anyway as KSFT_SKIP when !feats_ok()
+	 */
+	if (!feats_ok(td)) {
+		fprintf(stderr,
+			"SSBS NOT supported but NOT SKIPPED. Something's wrong. Abort\n");
+		abort();
+	}
+
+	fprintf(stderr, "Checking with PSTATE.SSBS...\n");
+	val = uc.uc_mcontext.pstate;
+	/* pass when preserved */
+	td->pass = (val & PSR_SSBS_BIT) ==
+		   (td->saved_uc.uc_mcontext.pstate & PSR_SSBS_BIT);
+}
+
+struct tdescr tde = {
+		.sanity_disabled = true,
+		.name = "MANGLE_PSTATE_SSBS_REGS",
+		.descr = "Mangle uc_mcontext setting SSBS bit.(MUST PRESERVE)",
+		.feats_required = FEAT_SSBS,
+		.sig_trig = SIGUSR1,
+		.sig_unsupp = SIGILL,
+		.init = mangle_invalid_pstate_ssbs_init,
+		.run = mangle_invalid_pstate_ssbs_run,
+		.check_result = pstate_ssbs_bit_checks,
+};
-- 
2.17.1

