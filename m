Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2439D09B1
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2019 10:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbfJII0d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Oct 2019 04:26:33 -0400
Received: from foss.arm.com ([217.140.110.172]:56262 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729592AbfJII0d (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Oct 2019 04:26:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A14A015BE;
        Wed,  9 Oct 2019 01:26:32 -0700 (PDT)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B88B53F68E;
        Wed,  9 Oct 2019 01:26:31 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org
Cc:     andreyknvl@google.com, dave.martin@arm.com, amit.kachhap@arm.com
Subject: [PATCH v8 06/12] kselftest: arm64: add helper get_current_context
Date:   Wed,  9 Oct 2019 09:26:05 +0100
Message-Id: <20191009082611.9441-7-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191009082611.9441-1-cristian.marussi@arm.com>
References: <20191009082611.9441-1-cristian.marussi@arm.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce a new common utility function get_current_context() which can be
used to grab a ucontext without the help of libc, and also to detect if
such ucontext has been successfully used by placing it on the stack as a
fake sigframe.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v7 --> v8
- added new in v8 (splitted out from v7 05/11)
---
 .../selftests/arm64/signal/test_signals.h     |  6 +-
 .../arm64/signal/test_signals_utils.c         | 31 ++++++
 .../arm64/signal/test_signals_utils.h         | 98 +++++++++++++++++++
 3 files changed, 134 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/signal/test_signals.h b/tools/testing/selftests/arm64/signal/test_signals.h
index 901521188202..4fd3ba01e3b1 100644
--- a/tools/testing/selftests/arm64/signal/test_signals.h
+++ b/tools/testing/selftests/arm64/signal/test_signals.h
@@ -88,8 +88,12 @@ struct tdescr {
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
 
 	/* a custom setup: called alternatively to default_setup */
 	int (*setup)(struct tdescr *td);
diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.c b/tools/testing/selftests/arm64/signal/test_signals_utils.c
index e8bbe36c2660..222148568adf 100644
--- a/tools/testing/selftests/arm64/signal/test_signals_utils.c
+++ b/tools/testing/selftests/arm64/signal/test_signals_utils.c
@@ -11,14 +11,19 @@
 #include <linux/auxvec.h>
 #include <ucontext.h>
 
+#include <asm/unistd.h>
+
 #include <kselftest.h>
 
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
@@ -156,6 +161,20 @@ static bool handle_signal_ok(struct tdescr *td,
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
@@ -167,6 +186,9 @@ static void default_handler(int signum, siginfo_t *si, void *uc)
 	} else if (current->sig_ok && signum == current->sig_ok &&
 		   handle_signal_ok(current, si, uc)) {
 		fprintf(stderr, "Handled SIG_OK\n");
+	} else if (signum == sig_copyctx && current->live_uc &&
+		   handle_signal_copyctx(current, si, uc)) {
+		fprintf(stderr, "Handled SIG_COPYCTX\n");
 	} else {
 		if (signum == SIGALRM && current->timeout) {
 			fprintf(stderr, "-- Timeout !\n");
@@ -221,6 +243,15 @@ static inline int default_trigger(struct tdescr *td)
 
 int test_init(struct tdescr *td)
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
diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.h b/tools/testing/selftests/arm64/signal/test_signals_utils.h
index 5e3a2b7aaa8b..fd67b1f23c41 100644
--- a/tools/testing/selftests/arm64/signal/test_signals_utils.h
+++ b/tools/testing/selftests/arm64/signal/test_signals_utils.h
@@ -4,6 +4,10 @@
 #ifndef __TEST_SIGNALS_UTILS_H__
 #define __TEST_SIGNALS_UTILS_H__
 
+#include <assert.h>
+#include <stdio.h>
+#include <string.h>
+
 #include "test_signals.h"
 
 int test_init(struct tdescr *td);
@@ -17,4 +21,98 @@ static inline bool feats_ok(struct tdescr *td)
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
-- 
2.17.1

