Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1149432753
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Oct 2021 21:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbhJRTOG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Oct 2021 15:14:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231739AbhJRTOG (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Oct 2021 15:14:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B7876128B;
        Mon, 18 Oct 2021 19:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634584314;
        bh=Sgok6UhtF0T7hgehfAxYt2HdlrzsmWPZqEF3mfkA2Do=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C5/YP4TZZxXKvu6B7KDtJhA7roeqUKR21Z6kNDod4VPH0MDco86RZJZ709TqKwh8F
         Aa5IOddG3MgSUA7uVU7EqRfX9G193hXVp7S9dKabthgK3wfzJiFmb3uh4u5Ocj3izW
         6lrlxxN3s2AHRkHiriuWaclq0rAhIyo11O/jCDjknjUWTLOuZB9u2CAe7yBRBDVtdK
         KWG90LUM6Gjtc2jU/IusxvTWzak9qw9PXbArZiaC1pxhbO+TM93y9mjWqWtrSgy6l8
         tYVzq5/QDcS9fVkjrpN0OIdytv0agcpCngPgCz57+Fsq/Clj00+kbFL72mkssnlWfS
         Ut98r90NjNhPg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 40/42] kselftest/arm64: signal: Add SME signal handling tests
Date:   Mon, 18 Oct 2021 20:08:56 +0100
Message-Id: <20211018190858.2119209-41-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018190858.2119209-1-broonie@kernel.org>
References: <20211018190858.2119209-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11674; h=from:subject; bh=Sgok6UhtF0T7hgehfAxYt2HdlrzsmWPZqEF3mfkA2Do=; b=owGbwMvMwMWocq27KDak/QLjabUkhsTcY27f2P4IhYmr/btS2fjGZL1E74TVQuF7JBuNviwp9qjI fH+jk9GYhYGRi0FWTJFl7bOMVenhElvnP5r/CmYQKxPIFAYuTgGYyLFA9v/Rpp0s/Ase5Vf9fXR4/a xMzp5XPw+1F2dUZix0usf9+nzmnq5TYlIeQp2SqbPvugfx6yWntTMcFAo23sUTzmynHs6k8I5nvgTn sVcewQJmi6sOROq8v8wnGxirJrNnk4bg1nXrxZeeb3nI9LROTkpDy+LwlbUhIf8LZ7Znnm48KKm8JH /pWcVuCTFLTsX/qX15m0OFL2Q+vZGu5LWKhetEu8CuXQLJJ2V+LZ999+Xr9Ykz9+s2bi3ULDrvwCHy weCR1DXzR/EWHz93vjq/9mLz16MtiVIrkqomh218y+TwO0pO7uqi39ZdKVZmUhzZP62sHbMWin3Tcu s2YtST/mD1b0uIU1pbkNk6TqFjAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add test cases for the SME signal handing ABI patterned off the SVE tests.
Due to the small size of the tests and the differences in ABI (especially
around needing to account for both streaming SVE and ZA) there is some code
duplication here.

We currently cover:
 - Reporting of the vector length.
 - Lack of support for changing vector length.
 - Presence and size of register state for streaming SVE and ZA.

As with the SVE tests we do not yet have any validation of register
contents.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../testing/selftests/arm64/signal/.gitignore |   2 +
 .../selftests/arm64/signal/test_signals.h     |   2 +
 .../arm64/signal/test_signals_utils.c         |   3 +
 .../testcases/fake_sigreturn_sme_change_vl.c  |  92 +++++++++++++
 .../arm64/signal/testcases/sme_trap_za.c      |  36 +++++
 .../selftests/arm64/signal/testcases/sme_vl.c |  70 ++++++++++
 .../arm64/signal/testcases/ssve_regs.c        | 129 ++++++++++++++++++
 7 files changed, 334 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sme_change_vl.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/sme_trap_za.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/sme_vl.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/ssve_regs.c

diff --git a/tools/testing/selftests/arm64/signal/.gitignore b/tools/testing/selftests/arm64/signal/.gitignore
index c1742755abb9..4de8eb26d4de 100644
--- a/tools/testing/selftests/arm64/signal/.gitignore
+++ b/tools/testing/selftests/arm64/signal/.gitignore
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 mangle_*
 fake_sigreturn_*
+sme_*
+ssve_*
 sve_*
 !*.[ch]
diff --git a/tools/testing/selftests/arm64/signal/test_signals.h b/tools/testing/selftests/arm64/signal/test_signals.h
index ebe8694dbef0..d0523a50ee78 100644
--- a/tools/testing/selftests/arm64/signal/test_signals.h
+++ b/tools/testing/selftests/arm64/signal/test_signals.h
@@ -34,11 +34,13 @@
 enum {
 	FSSBS_BIT,
 	FSVE_BIT,
+	FSME_BIT,
 	FMAX_END
 };
 
 #define FEAT_SSBS		(1UL << FSSBS_BIT)
 #define FEAT_SVE		(1UL << FSVE_BIT)
+#define FEAT_SME		(1UL << FSME_BIT)
 
 /*
  * A descriptor used to describe and configure a test case.
diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.c b/tools/testing/selftests/arm64/signal/test_signals_utils.c
index 8bb12be87a51..cfb95010791a 100644
--- a/tools/testing/selftests/arm64/signal/test_signals_utils.c
+++ b/tools/testing/selftests/arm64/signal/test_signals_utils.c
@@ -27,6 +27,7 @@ static int sig_copyctx = SIGTRAP;
 static char const *const feats_names[FMAX_END] = {
 	" SSBS ",
 	" SVE ",
+	" SME ",
 };
 
 #define MAX_FEATS_SZ	128
@@ -266,6 +267,8 @@ int test_init(struct tdescr *td)
 			td->feats_supported |= FEAT_SSBS;
 		if (getauxval(AT_HWCAP) & HWCAP_SVE)
 			td->feats_supported |= FEAT_SVE;
+		if (getauxval(AT_HWCAP2) & HWCAP2_SME)
+			td->feats_supported |= FEAT_SME;
 		if (feats_ok(td)) {
 			fprintf(stderr,
 				"Required Features: [%s] supported\n",
diff --git a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sme_change_vl.c b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sme_change_vl.c
new file mode 100644
index 000000000000..7ed762b7202f
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sme_change_vl.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 ARM Limited
+ *
+ * Attempt to change the streaming SVE vector length in a signal
+ * handler, this is not supported and is expected to segfault.
+ */
+
+#include <signal.h>
+#include <ucontext.h>
+#include <sys/prctl.h>
+
+#include "test_signals_utils.h"
+#include "testcases.h"
+
+struct fake_sigframe sf;
+static unsigned int vls[SVE_VQ_MAX];
+unsigned int nvls = 0;
+
+static bool sme_get_vls(struct tdescr *td)
+{
+	int vq, vl;
+
+	/*
+	 * Enumerate up to SVE_VQ_MAX vector lengths
+	 */
+	for (vq = SVE_VQ_MAX; vq > 0; --vq) {
+		vl = prctl(PR_SVE_SET_VL, vq * 16);
+		if (vl == -1)
+			return false;
+
+		vl &= PR_SME_VL_LEN_MASK;
+
+		/* Skip missing VLs */
+		vq = sve_vq_from_vl(vl);
+
+		vls[nvls++] = vl;
+	}
+
+	/* We need at least two VLs */
+	if (nvls < 2) {
+		fprintf(stderr, "Only %d VL supported\n", nvls);
+		return false;
+	}
+
+	return true;
+}
+
+static int fake_sigreturn_ssve_change_vl(struct tdescr *td,
+					 siginfo_t *si, ucontext_t *uc)
+{
+	size_t resv_sz, offset;
+	struct _aarch64_ctx *head = GET_SF_RESV_HEAD(sf);
+	struct sve_context *sve;
+
+	/* Get a signal context with a SME ZA frame in it */
+	if (!get_current_context(td, &sf.uc))
+		return 1;
+
+	resv_sz = GET_SF_RESV_SIZE(sf);
+	head = get_header(head, SVE_MAGIC, resv_sz, &offset);
+	if (!head) {
+		fprintf(stderr, "No SVE context\n");
+		return 1;
+	}
+
+	if (head->size != sizeof(struct sve_context)) {
+		fprintf(stderr, "Register data present, aborting\n");
+		return 1;
+	}
+
+	sve = (struct sve_context *)head;
+
+	/* No changes are supported; init left us at minimum VL so go to max */
+	fprintf(stderr, "Attempting to change VL from %d to %d\n",
+		sve->vl, vls[0]);
+	sve->vl = vls[0];
+
+	fake_sigreturn(&sf, sizeof(sf), 0);
+
+	return 1;
+}
+
+struct tdescr tde = {
+	.name = "FAKE_SIGRETURN_SSVE_CHANGE",
+	.descr = "Attempt to change Streaming SVE VL",
+	.feats_required = FEAT_SME,
+	.sig_ok = SIGSEGV,
+	.timeout = 3,
+	.init = sme_get_vls,
+	.run = fake_sigreturn_ssve_change_vl,
+};
diff --git a/tools/testing/selftests/arm64/signal/testcases/sme_trap_za.c b/tools/testing/selftests/arm64/signal/testcases/sme_trap_za.c
new file mode 100644
index 000000000000..3a7747af4715
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/sme_trap_za.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 ARM Limited
+ *
+ * Verify that accessing ZA without enabling it generates a SIGILL.
+ */
+
+#include <signal.h>
+#include <ucontext.h>
+#include <sys/prctl.h>
+
+#include "test_signals_utils.h"
+#include "testcases.h"
+
+int sme_trap_za_trigger(struct tdescr *td)
+{
+	/* ZERO ZA */
+	asm volatile(".inst 0xc00800ff");
+
+	return 0;
+}
+
+int sme_trap_za_run(struct tdescr *td, siginfo_t *si, ucontext_t *uc)
+{
+	return 1;
+}
+
+struct tdescr tde = {
+	.name = "SME ZA trap",
+	.descr = "Check that we get a SIGILL if we access ZA without enabling",
+	.timeout = 3,
+	.sanity_disabled = true,
+	.trigger = sme_trap_za_trigger,
+	.run = sme_trap_za_run,
+	.sig_ok = SIGILL,
+};
diff --git a/tools/testing/selftests/arm64/signal/testcases/sme_vl.c b/tools/testing/selftests/arm64/signal/testcases/sme_vl.c
new file mode 100644
index 000000000000..c40e339a1bc3
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/sme_vl.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 ARM Limited
+ *
+ * Check that the SME vector length reported in signal contexts is the
+ * expected one.
+ */
+
+#include <signal.h>
+#include <ucontext.h>
+#include <sys/prctl.h>
+
+#include "test_signals_utils.h"
+#include "testcases.h"
+
+struct fake_sigframe sf;
+unsigned int vl;
+
+static bool get_sme_vl(struct tdescr *td)
+{
+	int ret = prctl(PR_SME_GET_VL);
+	if (ret == -1)
+		return false;
+
+	vl = ret;
+
+	return true;
+}
+
+static int sme_vl(struct tdescr *td, siginfo_t *si, ucontext_t *uc)
+{
+	size_t resv_sz, offset;
+	struct _aarch64_ctx *head = GET_SF_RESV_HEAD(sf);
+	struct sve_context *sve;
+
+	/* Get a signal context which should have a SVE frame in it */
+	if (!get_current_context(td, &sf.uc))
+		return 1;
+
+	resv_sz = GET_SF_RESV_SIZE(sf);
+	head = get_header(head, SVE_MAGIC, resv_sz, &offset);
+	if (!head) {
+		fprintf(stderr, "No SVE context\n");
+		return 1;
+	}
+	sve = (struct sve_context *)head;
+
+	if (sve->vl != vl) {
+		fprintf(stderr, "SSVE sigframe VL %u, expected %u\n",
+			sve->vl, vl);
+		return 1;
+	} else {
+		fprintf(stderr, "got SSVE expected VL %u\n", vl);
+	}
+
+	/* Also check ZA VL */
+
+	td->pass = 1;
+
+	return 0;
+}
+
+struct tdescr tde = {
+	.name = "SME VL",
+	.descr = "Check that we get the right SME VL reported",
+	.feats_required = FEAT_SME,
+	.timeout = 3,
+	.init = get_sme_vl,
+	.run = sme_vl,
+};
diff --git a/tools/testing/selftests/arm64/signal/testcases/ssve_regs.c b/tools/testing/selftests/arm64/signal/testcases/ssve_regs.c
new file mode 100644
index 000000000000..44a08d43cd50
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/ssve_regs.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 ARM Limited
+ *
+ * Verify that the streaming SVE register context in signal frames is
+ * set up as expected.
+ */
+
+#include <signal.h>
+#include <ucontext.h>
+#include <sys/prctl.h>
+
+#include "test_signals_utils.h"
+#include "testcases.h"
+
+struct fake_sigframe sf;
+static unsigned int vls[SVE_VQ_MAX];
+unsigned int nvls = 0;
+
+static bool sme_get_vls(struct tdescr *td)
+{
+	int vq, vl;
+
+	/*
+	 * Enumerate up to SVE_VQ_MAX vector lengths
+	 */
+	for (vq = SVE_VQ_MAX; vq > 0; --vq) {
+		vl = prctl(PR_SVE_SET_VL, vq * 16);
+		if (vl == -1)
+			return false;
+
+		vl &= PR_SME_VL_LEN_MASK;
+
+		/* Skip missing VLs */
+		vq = sve_vq_from_vl(vl);
+
+		vls[nvls++] = vl;
+	}
+
+	/* We need at least one VL */
+	if (nvls < 1) {
+		fprintf(stderr, "Only %d VL supported\n", nvls);
+		return false;
+	}
+
+	return true;
+}
+
+static void setup_ssve_regs(void)
+{
+	/* SMSTART SM */
+	asm volatile(".inst 0x7f4303d5");
+
+	/* RDVL x16, #1 so we should have SVE regs; real data is TODO */
+	asm volatile(".inst 0x04bf5030" : : : "x16" );
+}
+
+static int do_one_sme_vl(struct tdescr *td, siginfo_t *si, ucontext_t *uc,
+			 unsigned int vl)
+{
+	size_t resv_sz, offset;
+	struct _aarch64_ctx *head = GET_SF_RESV_HEAD(sf);
+	struct sve_context *ssve;
+
+	fprintf(stderr, "Testing VL %d\n", vl);
+
+	if (prctl(PR_SME_SET_VL, vl) == -1) {
+		fprintf(stderr, "Failed to set VL\n");
+		return 1;
+	}
+
+	/* 
+	 * Get a signal context which should have a SVE frame and registers
+	 * in it.
+	 */
+	setup_ssve_regs();
+	if (!get_current_context(td, &sf.uc))
+		return 1;
+
+	resv_sz = GET_SF_RESV_SIZE(sf);
+	head = get_header(head, SVE_MAGIC, resv_sz, &offset);
+	if (!head) {
+		fprintf(stderr, "No SVE context\n");
+		return 1;
+	}
+
+	ssve = (struct sve_context *)head;
+	if (ssve->vl != vl) {
+		fprintf(stderr, "Got VL %d, expected %d\n", ssve->vl, vl);
+		return 1;
+	}
+
+	/* The actual size validation is done in get_current_context() */
+	fprintf(stderr, "Got expected size %u and VL %d\n",
+		head->size, ssve->vl);
+
+	return 0;
+}
+
+static int sme_regs(struct tdescr *td, siginfo_t *si, ucontext_t *uc)
+{
+	int i;
+
+	for (i = 0; i < nvls; i++) {
+		/*
+		 * TODO: the signal test helpers can't currently cope
+		 * with signal frames bigger than struct sigcontext,
+		 * skip VLs that will trigger that.
+		 */
+		if (vls[i] > 64)
+			continue;
+
+		if (do_one_sme_vl(td, si, uc, vls[i]))
+			return 1;
+	}
+
+	td->pass = 1;
+
+	return 0;
+}
+
+struct tdescr tde = {
+	.name = "Streaming SVE registers",
+	.descr = "Check that we get the right Streaming SVE registers reported",
+	.feats_required = FEAT_SME,
+	.timeout = 3,
+	.init = sme_get_vls,
+	.run = sme_regs,
+};
-- 
2.30.2

