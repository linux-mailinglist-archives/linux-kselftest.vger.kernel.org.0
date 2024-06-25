Return-Path: <linux-kselftest+bounces-12638-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAEE9167BF
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 14:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76AE1B22ADD
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 12:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAC5156899;
	Tue, 25 Jun 2024 12:24:50 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EC4156674;
	Tue, 25 Jun 2024 12:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318290; cv=none; b=n/1SxZEJ5ECJ4LCVbtRUcMbVyCw8q8dMKTMGYI1b/E5SvcvlM2NakWUhZbXKFJF3Wjg9uoeaIjHU5pBRIe1kP2NOGmave3qOhILzBL4l4uFUecHaJMhqeYzUzsz0h+cwi8BKWixvF89NRB2zdPV8IxGOUvJmTjBK9Ch74zBxD+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318290; c=relaxed/simple;
	bh=1jBivvCaS2aU21W9Z49uC3SHEXnYWT3rd4jUkaDa2w8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uOVhlTUJfpKyV8ohAJys+UiGT60Bj60sfT0O6vwbMsHz4rD20PE8/+dNi9coUkqbVTns+uMk7ttLxlF1aTvlNkIzRHshBwsyF2g7lhZixi1OiF9fQlbTewJ5cSvNZ5eMjup3nvXCy4/G1Zji0z9+Vpdicq91HsTjMIMUwHIFRgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3553D339;
	Tue, 25 Jun 2024 05:25:13 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.41.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D0FA13F766;
	Tue, 25 Jun 2024 05:24:43 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Catalin.Marinas@arm.com,
	will@kernel.org
Cc: broonie@kernel.org,
	ryan.roberts@arm.com,
	rob.herring@arm.com,
	mark.rutland@arm.com,
	linux@armlinux.org.uk,
	suzuki.poulose@arm.com,
	Anshuman.Khandual@arm.com,
	aneesh.kumar@kernel.org,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v3 3/9] selftests: arm, arm64: Use ifdeffery to pull signal infrastructure
Date: Tue, 25 Jun 2024 17:54:02 +0530
Message-Id: <20240625122408.1439097-4-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625122408.1439097-1-dev.jain@arm.com>
References: <20240625122408.1439097-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use ifdeffery to guard code chunks meant specifically for arm64, in
preparation for putting signal tests in selftests/arm.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 .../selftests/arm/signal/test_signals.c       |  2 +
 .../selftests/arm/signal/test_signals.h       |  2 +
 .../selftests/arm/signal/test_signals_utils.c |  2 +
 .../selftests/arm/signal/test_signals_utils.h |  2 +
 .../selftests/arm64/signal/test_signals.h     | 12 +++++
 .../arm64/signal/test_signals_utils.c         | 51 +++++++++++++++----
 .../arm64/signal/test_signals_utils.h         |  3 ++
 7 files changed, 65 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/arm/signal/test_signals.c
 create mode 100644 tools/testing/selftests/arm/signal/test_signals.h
 create mode 100644 tools/testing/selftests/arm/signal/test_signals_utils.c
 create mode 100644 tools/testing/selftests/arm/signal/test_signals_utils.h

diff --git a/tools/testing/selftests/arm/signal/test_signals.c b/tools/testing/selftests/arm/signal/test_signals.c
new file mode 100644
index 000000000000..6b47c26ee218
--- /dev/null
+++ b/tools/testing/selftests/arm/signal/test_signals.c
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "../../arm64/signal/test_signals.c"
diff --git a/tools/testing/selftests/arm/signal/test_signals.h b/tools/testing/selftests/arm/signal/test_signals.h
new file mode 100644
index 000000000000..946913d29636
--- /dev/null
+++ b/tools/testing/selftests/arm/signal/test_signals.h
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "../../arm64/signal/test_signals.h"
diff --git a/tools/testing/selftests/arm/signal/test_signals_utils.c b/tools/testing/selftests/arm/signal/test_signals_utils.c
new file mode 100644
index 000000000000..2b16d53545be
--- /dev/null
+++ b/tools/testing/selftests/arm/signal/test_signals_utils.c
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "../../arm64/signal/test_signals_utils.c"
diff --git a/tools/testing/selftests/arm/signal/test_signals_utils.h b/tools/testing/selftests/arm/signal/test_signals_utils.h
new file mode 100644
index 000000000000..a4d61697a8dd
--- /dev/null
+++ b/tools/testing/selftests/arm/signal/test_signals_utils.h
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "../../arm64/signal/test_signals_utils.h"
diff --git a/tools/testing/selftests/arm64/signal/test_signals.h b/tools/testing/selftests/arm64/signal/test_signals.h
index 1e6273d81575..9c1bd6560501 100644
--- a/tools/testing/selftests/arm64/signal/test_signals.h
+++ b/tools/testing/selftests/arm64/signal/test_signals.h
@@ -14,6 +14,8 @@
 #include <asm/ptrace.h>
 #include <asm/hwcap.h>
 
+/* Not used by selftests/arm */
+#ifdef __aarch64__
 #define __stringify_1(x...)	#x
 #define __stringify(x...)	__stringify_1(x)
 
@@ -43,6 +45,7 @@ enum {
 #define FEAT_SME		(1UL << FSME_BIT)
 #define FEAT_SME_FA64		(1UL << FSME_FA64_BIT)
 #define FEAT_SME2		(1UL << FSME2_BIT)
+#endif
 
 /*
  * A descriptor used to describe and configure a test case.
@@ -56,10 +59,13 @@ struct tdescr {
 	/* just a name for the test-case; manadatory field */
 	char			*name;
 	char			*descr;
+/* Not used by selftests/arm */
+#ifdef __aarch64__
 	unsigned long		feats_required;
 	unsigned long		feats_incompatible;
 	/* bitmask of effectively supported feats: populated at run-time */
 	unsigned long		feats_supported;
+#endif
 	bool			initialized;
 	unsigned int		minsigstksz;
 	/* signum used as a test trigger. Zero if no trigger-signal is used */
@@ -69,8 +75,11 @@ struct tdescr {
 	 * Zero when no signal is expected on success
 	 */
 	int			sig_ok;
+/* Not used by selftests/arm */
+#ifdef __aarch64__
 	/* signum expected on unsupported CPU features. */
 	int			sig_unsupp;
+#endif
 	/* a timeout in second for test completion */
 	unsigned int		timeout;
 	bool			triggered;
@@ -79,10 +88,13 @@ struct tdescr {
 	/* optional sa_flags for the installed handler */
 	int			sa_flags;
 	ucontext_t		saved_uc;
+/* Not used by selftests/arm */
+#ifdef __aarch64__
 	/* used by get_current_ctx() */
 	size_t			live_sz;
 	ucontext_t		*live_uc;
 	volatile sig_atomic_t	live_uc_valid;
+#endif
 	/* optional test private data */
 	void			*priv;
 
diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.c b/tools/testing/selftests/arm64/signal/test_signals_utils.c
index 0dc948db3a4a..8396d9748b48 100644
--- a/tools/testing/selftests/arm64/signal/test_signals_utils.c
+++ b/tools/testing/selftests/arm64/signal/test_signals_utils.c
@@ -17,11 +17,16 @@
 
 #include "test_signals.h"
 #include "test_signals_utils.h"
+
+#ifdef __aarch64__
 #include "testcases/testcases.h"
+#endif
 
 
 extern struct tdescr *current;
 
+/* Not used by selftests/arm */
+#ifdef __aarch64__
 static int sig_copyctx = SIGTRAP;
 
 static char const *const feats_names[FMAX_END] = {
@@ -53,6 +58,7 @@ static inline char *feats_to_string(unsigned long feats)
 
 	return feats_string;
 }
+#endif
 
 static void unblock_signal(int signum)
 {
@@ -87,6 +93,7 @@ static void default_result(struct tdescr *td, bool force_exit)
  * take care of such unexpected situations.
  */
 
+#ifdef __aarch64__
 static bool handle_signal_unsupported(struct tdescr *td,
 				      siginfo_t *si, void *uc)
 {
@@ -108,6 +115,7 @@ static bool handle_signal_unsupported(struct tdescr *td,
 
 	return true;
 }
+#endif
 
 static bool handle_signal_trigger(struct tdescr *td,
 				  siginfo_t *si, void *uc)
@@ -127,10 +135,21 @@ static bool handle_signal_ok(struct tdescr *td,
 	 * if sig_trig was defined, it must have been used before getting here.
 	 */
 	assert(!td->sig_trig || td->triggered);
+
+#ifdef __aarch64__
 	fprintf(stderr,
 		"SIG_OK -- SP:0x%llX  si_addr@:%p  si_code:%d  token@:%p  offset:%ld\n",
 		((ucontext_t *)uc)->uc_mcontext.sp,
 		si->si_addr, si->si_code, td->token, td->token - si->si_addr);
+#else
+	fprintf(stderr,
+		"SIG_OK -- SP:0x%lX  si_addr@:%p  si_code:%d  token@:%p  offset:%d\n",
+		((ucontext_t *)uc)->uc_mcontext.arm_sp,
+		si->si_addr, si->si_code, td->token, td->token - si->si_addr);
+#endif
+
+#ifdef __aarch64__
+
 	/*
 	 * fake_sigreturn tests, which have sanity_enabled=1, set, at the very
 	 * last time, the token field to the SP address used to place the fake
@@ -153,6 +172,7 @@ static bool handle_signal_ok(struct tdescr *td,
 			"si_code != SEGV_ACCERR...test is probably broken!\n");
 		abort();
 	}
+#endif
 	td->pass = 1;
 	/*
 	 * Some tests can lead to SEGV loops: in such a case we want to
@@ -165,6 +185,7 @@ static bool handle_signal_ok(struct tdescr *td,
 	return true;
 }
 
+#ifdef __aarch64__
 static bool handle_signal_copyctx(struct tdescr *td,
 				  siginfo_t *si, void *uc_in)
 {
@@ -229,22 +250,31 @@ static bool handle_signal_copyctx(struct tdescr *td,
 
 	return true;
 }
+#endif
 
 static void default_handler(int signum, siginfo_t *si, void *uc)
 {
+#ifdef __aarch64__
 	if (current->sig_unsupp && signum == current->sig_unsupp &&
 	    handle_signal_unsupported(current, si, uc)) {
 		fprintf(stderr, "Handled SIG_UNSUPP\n");
-	} else if (current->sig_trig && signum == current->sig_trig &&
+	}
+#endif
+
+	if (current->sig_trig && signum == current->sig_trig &&
 		   handle_signal_trigger(current, si, uc)) {
 		fprintf(stderr, "Handled SIG_TRIG\n");
 	} else if (current->sig_ok && signum == current->sig_ok &&
 		   handle_signal_ok(current, si, uc)) {
 		fprintf(stderr, "Handled SIG_OK\n");
-	} else if (signum == sig_copyctx && current->live_uc &&
+	}
+#ifdef __aarch64__
+	else if (signum == sig_copyctx && current->live_uc &&
 		   handle_signal_copyctx(current, si, uc)) {
 		fprintf(stderr, "Handled SIG_COPYCTX\n");
-	} else {
+	}
+#endif
+	else {
 		if (signum == SIGALRM && current->timeout) {
 			fprintf(stderr, "-- Timeout !\n");
 		} else {
@@ -280,9 +310,10 @@ static int default_setup(struct tdescr *td)
 		unblock_signal(td->sig_trig);
 	if (td->sig_ok)
 		unblock_signal(td->sig_ok);
+#ifdef __aarch64__
 	if (td->sig_unsupp)
 		unblock_signal(td->sig_unsupp);
-
+#endif
 	if (td->timeout) {
 		unblock_signal(SIGALRM);
 		alarm(td->timeout);
@@ -299,6 +330,12 @@ static inline int default_trigger(struct tdescr *td)
 
 int test_init(struct tdescr *td)
 {
+	td->minsigstksz = getauxval(AT_MINSIGSTKSZ);
+	if (!td->minsigstksz)
+		td->minsigstksz = MINSIGSTKSZ;
+	fprintf(stderr, "Detected MINSTKSIGSZ:%d\n", td->minsigstksz);
+
+#ifdef __aarch64__
 	if (td->sig_trig == sig_copyctx) {
 		fprintf(stdout,
 			"Signal %d is RESERVED, cannot be used as a trigger. Aborting\n",
@@ -308,11 +345,6 @@ int test_init(struct tdescr *td)
 	/* just in case */
 	unblock_signal(sig_copyctx);
 
-	td->minsigstksz = getauxval(AT_MINSIGSTKSZ);
-	if (!td->minsigstksz)
-		td->minsigstksz = MINSIGSTKSZ;
-	fprintf(stderr, "Detected MINSTKSIGSZ:%d\n", td->minsigstksz);
-
 	if (td->feats_required || td->feats_incompatible) {
 		td->feats_supported = 0;
 		/*
@@ -357,6 +389,7 @@ int test_init(struct tdescr *td)
 			return 0;
 		}
 	}
+#endif
 
 	/* Perform test specific additional initialization */
 	if (td->init && !td->init(td)) {
diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.h b/tools/testing/selftests/arm64/signal/test_signals_utils.h
index 762c8fe9c54a..50acfc1a1692 100644
--- a/tools/testing/selftests/arm64/signal/test_signals_utils.h
+++ b/tools/testing/selftests/arm64/signal/test_signals_utils.h
@@ -18,6 +18,8 @@ void test_cleanup(struct tdescr *td);
 int test_run(struct tdescr *td);
 void test_result(struct tdescr *td);
 
+/* Not used by selftests/arm */
+#ifdef __aarch64__
 static inline bool feats_ok(struct tdescr *td)
 {
 	if (td->feats_incompatible & td->feats_supported)
@@ -146,3 +148,4 @@ static __always_inline bool get_current_context(struct tdescr *td,
 
 int fake_sigreturn(void *sigframe, size_t sz, int misalign_bytes);
 #endif
+#endif
-- 
2.39.2


