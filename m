Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD2549CE81
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 16:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbiAZPcq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 10:32:46 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51852 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242885AbiAZPcn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 10:32:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE730618D9
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 15:32:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC3CC340E8;
        Wed, 26 Jan 2022 15:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643211162;
        bh=68+DVrIDwed146AFp7Wb4F5SkAk7GsLeX/otWxDBYJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YfOSLA65AKPUuH2gH7Y2KqGoqeU3egV1uEktY4VEqHOMz0tawdPLZguhVpIQij5rm
         6NOo2LmZOXpTxJuyGePh1zaVMigknf9XtHvymFW/Lz5EdLIrvagAI27Un5OEh6QntD
         hZZL2Mhsize2xiVqrPz2SGGnsIWD1VGVC9bZ3hE0HnM5oDaSHdkRzRyNC71PcN0pzU
         mx9tQSJMOAQtaz1XNK7xgZu188vLipgDbK/SKUUBT59bTiEjVwlt2/RUzeG6yvfybU
         Kh3p6E/wz/bz7eCXHUvDfyQw1b6F4ueLU8nQRm7oWKobNYAqZiQSIEq6xAZEHjjTJZ
         ++bL2KU3/Q4pw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v10 36/39] kselftest/arm64: signal: Add SME signal handling tests
Date:   Wed, 26 Jan 2022 15:27:46 +0000
Message-Id: <20220126152749.233712-37-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126152749.233712-1-broonie@kernel.org>
References: <20220126152749.233712-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14953; h=from:subject; bh=68+DVrIDwed146AFp7Wb4F5SkAk7GsLeX/otWxDBYJM=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh8WhxKeiwgPH3+W7T7snJgn2+mDYP8UWkWAcUN9rz /+F1YsGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYfFocQAKCRAk1otyXVSH0Ic+B/ 9l+Y+zXs+P6gco8/ttdFPW5qW3J76UED14lomQy/Jj/QVaxBlQdPC49fSZUzRCSLuU3bKb37Ef5cVj TZK2d2KY+9ESkA99THWlac99U3kLApdGFzQIgA546c/L790GJF4Z4MuOpwrkLJe1ARAUTy6vcLm8R0 ISkJDI7CSSsnQtOYYTv0gXcVIT3boUWJ0bBd7aOifqnJoG56/r0TH3Qn7YCiPbb2K1cirj6cz9OqYd UkifDaImTuYVDRDUv7HFRm+kDRQhqBjjS+XBP52lZBgWGSBFUeTPAojD36XTPkbSxPqKKCS5+dzuAc U8oJ2O67H460w+G8w+u0Oby+AgUsUn
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
 .../selftests/arm64/signal/test_signals.h     |   4 +
 .../arm64/signal/test_signals_utils.c         |   6 +
 .../testcases/fake_sigreturn_sme_change_vl.c  |  92 +++++++++++++
 .../arm64/signal/testcases/sme_trap_no_sm.c   |  38 ++++++
 .../signal/testcases/sme_trap_non_streaming.c |  45 ++++++
 .../arm64/signal/testcases/sme_trap_za.c      |  36 +++++
 .../selftests/arm64/signal/testcases/sme_vl.c |  68 +++++++++
 .../arm64/signal/testcases/ssve_regs.c        | 129 ++++++++++++++++++
 9 files changed, 420 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sme_change_vl.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/sme_trap_no_sm.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/sme_trap_non_streaming.c
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
index f909b70d9e98..c70fdec7d7c4 100644
--- a/tools/testing/selftests/arm64/signal/test_signals.h
+++ b/tools/testing/selftests/arm64/signal/test_signals.h
@@ -34,11 +34,15 @@
 enum {
 	FSSBS_BIT,
 	FSVE_BIT,
+	FSME_BIT,
+	FSME_FA64_BIT,
 	FMAX_END
 };
 
 #define FEAT_SSBS		(1UL << FSSBS_BIT)
 #define FEAT_SVE		(1UL << FSVE_BIT)
+#define FEAT_SME		(1UL << FSME_BIT)
+#define FEAT_SME_FA64		(1UL << FSME_FA64_BIT)
 
 /*
  * A descriptor used to describe and configure a test case.
diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.c b/tools/testing/selftests/arm64/signal/test_signals_utils.c
index 5743897984b0..b588d10afd5b 100644
--- a/tools/testing/selftests/arm64/signal/test_signals_utils.c
+++ b/tools/testing/selftests/arm64/signal/test_signals_utils.c
@@ -27,6 +27,8 @@ static int sig_copyctx = SIGTRAP;
 static char const *const feats_names[FMAX_END] = {
 	" SSBS ",
 	" SVE ",
+	" SME ",
+	" FA64 ",
 };
 
 #define MAX_FEATS_SZ	128
@@ -268,6 +270,10 @@ int test_init(struct tdescr *td)
 			td->feats_supported |= FEAT_SSBS;
 		if (getauxval(AT_HWCAP) & HWCAP_SVE)
 			td->feats_supported |= FEAT_SVE;
+		if (getauxval(AT_HWCAP2) & HWCAP2_SME)
+			td->feats_supported |= FEAT_SME;
+		if (getauxval(AT_HWCAP2) & HWCAP2_SME_FA64)
+			td->feats_supported |= FEAT_SME_FA64;
 		if (feats_ok(td)) {
 			if (td->feats_required & td->feats_supported)
 				fprintf(stderr,
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
diff --git a/tools/testing/selftests/arm64/signal/testcases/sme_trap_no_sm.c b/tools/testing/selftests/arm64/signal/testcases/sme_trap_no_sm.c
new file mode 100644
index 000000000000..f9d76ae32bba
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/sme_trap_no_sm.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 ARM Limited
+ *
+ * Verify that using a streaming mode instruction without enabling it
+ * generates a SIGILL.
+ */
+
+#include <signal.h>
+#include <ucontext.h>
+#include <sys/prctl.h>
+
+#include "test_signals_utils.h"
+#include "testcases.h"
+
+int sme_trap_no_sm_trigger(struct tdescr *td)
+{
+	/* SMSTART ZA ; ADDHA ZA0.S, P0/M, P0/M, Z0.S */
+	asm volatile(".inst 0xd503457f ; .inst 0xc0900000");
+
+	return 0;
+}
+
+int sme_trap_no_sm_run(struct tdescr *td, siginfo_t *si, ucontext_t *uc)
+{
+	return 1;
+}
+
+struct tdescr tde = {
+	.name = "SME trap without SM",
+	.descr = "Check that we get a SIGILL if we use streaming mode without enabling it",
+	.timeout = 3,
+	.feats_required = FEAT_SME,   /* We need a SMSTART ZA */
+	.sanity_disabled = true,
+	.trigger = sme_trap_no_sm_trigger,
+	.run = sme_trap_no_sm_run,
+	.sig_ok = SIGILL,
+};
diff --git a/tools/testing/selftests/arm64/signal/testcases/sme_trap_non_streaming.c b/tools/testing/selftests/arm64/signal/testcases/sme_trap_non_streaming.c
new file mode 100644
index 000000000000..e469ae5348e3
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/sme_trap_non_streaming.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 ARM Limited
+ *
+ * Verify that using an instruction not supported in streaming mode
+ * traps when in streaming mode.
+ */
+
+#include <signal.h>
+#include <ucontext.h>
+#include <sys/prctl.h>
+
+#include "test_signals_utils.h"
+#include "testcases.h"
+
+int sme_trap_non_streaming_trigger(struct tdescr *td)
+{
+	/*
+	 * The framework will handle SIGILL so we need to exit SM to
+	 * stop any other code triggering a further SIGILL down the
+	 * line from using a streaming-illegal instruction.
+	 */
+	asm volatile(".inst 0xd503437f; /* SMSTART ZA */ \
+		      cnt v0.16b, v0.16b; \
+                      .inst 0xd503447f  /* SMSTOP ZA */");
+
+	return 0;
+}
+
+int sme_trap_non_streaming_run(struct tdescr *td, siginfo_t *si, ucontext_t *uc)
+{
+	return 1;
+}
+
+struct tdescr tde = {
+	.name = "SME SM trap unsupported instruction",
+	.descr = "Check that we get a SIGILL if we use an unsupported instruction in streaming mode",
+	.feats_required = FEAT_SME,
+	.feats_incompatible = FEAT_SME_FA64,
+	.timeout = 3,
+	.sanity_disabled = true,
+	.trigger = sme_trap_non_streaming_trigger,
+	.run = sme_trap_non_streaming_run,
+	.sig_ok = SIGILL,
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
index 000000000000..13ff3b35cbaf
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/sme_vl.c
@@ -0,0 +1,68 @@
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
+	struct za_context *za;
+
+	/* Get a signal context which should have a ZA frame in it */
+	if (!get_current_context(td, &sf.uc))
+		return 1;
+
+	resv_sz = GET_SF_RESV_SIZE(sf);
+	head = get_header(head, ZA_MAGIC, resv_sz, &offset);
+	if (!head) {
+		fprintf(stderr, "No ZA context\n");
+		return 1;
+	}
+	za = (struct za_context *)head;
+
+	if (za->vl != vl) {
+		fprintf(stderr, "ZA sigframe VL %u, expected %u\n",
+			za->vl, vl);
+		return 1;
+	} else {
+		fprintf(stderr, "got expected VL %u\n", vl);
+	}
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

