Return-Path: <linux-kselftest+bounces-15641-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B65E956B58
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 14:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEC481F23495
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 12:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839CB16BE3C;
	Mon, 19 Aug 2024 12:57:32 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771A91487FE
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Aug 2024 12:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724072252; cv=none; b=c/Nh34hvGiwll5HLsMn+08i6poIiWMFQpfoqbt4X1Q9ISmQVjycqoTRJfrQ8sEVjOugOyJmban6rUYh8gC9gtTvmQ0shsgoCSyY1D2yujCAp7GzBwcEoJcXtk7ZjS2ey1ykGvMmzD7IIk+F14OCrUdizJcCLz18SjlSxgf67flk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724072252; c=relaxed/simple;
	bh=/v+ehT+ePU1fP7SOgNalXPD4nuNBruA3PTvUZmPk8iA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YC7zDJIg8cs+5PFVCtbXVu8hZPomIITHdnfoCcxP63cK0jD1renKQsRvoqGz8PQHAK+RJ++1u9+s/mBmz/+P+ioeLnZLGUYHLXB4kNxWx6ZbZuwOglCZ/vEpAyzE9MWuWIRQ+RovcCdIEl9osxR5yMlFqWBry/2rinJJXtcLpfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9D651063;
	Mon, 19 Aug 2024 05:57:55 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4687C3F73B;
	Mon, 19 Aug 2024 05:57:28 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH v2] kselftest/arm64: signal: fix/refactor SVE vector length enumeration
Date: Mon, 19 Aug 2024 13:57:21 +0100
Message-Id: <20240819125721.2918606-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently a number of SVE/SME related tests have almost identical
functions to enumerate all supported vector lengths. However over time
the copy&pasted code has diverged, allowing some bugs to creep in:
- fake_sigreturn_sme_change_vl reports a failure, not a SKIP if only
  one vector length is supported (but the SVE version is fine)
- fake_sigreturn_sme_change_vl tries to set the SVE vector length, not
  the SME one (but the other SME tests are fine)
- za_no_regs keeps iterating forever if only one vector length is
  supported (but za_regs is correct)

Since those bugs seem to be mostly copy&paste ones, let's consolidate
the enumeration loop into one shared function, and just call that from
each test. That should fix the above bugs, and prevent similar issues
from happening again.

Fixes: 4963aeb35a9e ("kselftest/arm64: signal: Add SME signal handling tests")
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
Hi,

a small update, making the SME VL loop check more generic, and adding a
comment about the reason we have that in the first place.

Cheers,
Andre

 tools/testing/selftests/arm64/signal/Makefile |  2 +-
 .../selftests/arm64/signal/sve_helpers.c      | 56 +++++++++++++++++++
 .../selftests/arm64/signal/sve_helpers.h      | 21 +++++++
 .../testcases/fake_sigreturn_sme_change_vl.c  | 31 +++-------
 .../testcases/fake_sigreturn_sve_change_vl.c  | 30 ++--------
 .../arm64/signal/testcases/ssve_regs.c        | 36 +++---------
 .../arm64/signal/testcases/ssve_za_regs.c     | 36 +++---------
 .../arm64/signal/testcases/sve_regs.c         | 32 +++--------
 .../arm64/signal/testcases/za_no_regs.c       | 32 +++--------
 .../arm64/signal/testcases/za_regs.c          | 36 +++---------
 10 files changed, 131 insertions(+), 181 deletions(-)
 create mode 100644 tools/testing/selftests/arm64/signal/sve_helpers.c
 create mode 100644 tools/testing/selftests/arm64/signal/sve_helpers.h

diff --git a/tools/testing/selftests/arm64/signal/Makefile b/tools/testing/selftests/arm64/signal/Makefile
index 37c8207b99cfc..1381039fb36f9 100644
--- a/tools/testing/selftests/arm64/signal/Makefile
+++ b/tools/testing/selftests/arm64/signal/Makefile
@@ -23,7 +23,7 @@ $(TEST_GEN_PROGS): $(PROGS)
 # Common test-unit targets to build common-layout test-cases executables
 # Needs secondary expansion to properly include the testcase c-file in pre-reqs
 COMMON_SOURCES := test_signals.c test_signals_utils.c testcases/testcases.c \
-	signals.S
+	signals.S sve_helpers.c
 COMMON_HEADERS := test_signals.h test_signals_utils.h testcases/testcases.h
 
 .SECONDEXPANSION:
diff --git a/tools/testing/selftests/arm64/signal/sve_helpers.c b/tools/testing/selftests/arm64/signal/sve_helpers.c
new file mode 100644
index 0000000000000..f57265354eaed
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/sve_helpers.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 ARM Limited
+ *
+ * Common helper functions for SVE and SME functionality.
+ */
+
+#include <stdbool.h>
+#include <kselftest.h>
+#include <asm/sigcontext.h>
+#include <sys/prctl.h>
+
+unsigned int vls[SVE_VQ_MAX];
+unsigned int nvls;
+
+int sve_fill_vls(bool use_sme, int min_vls)
+{
+	int vq, vl;
+	int pr_set_vl = use_sme ? PR_SME_SET_VL : PR_SVE_SET_VL;
+	int len_mask = use_sme ? PR_SME_VL_LEN_MASK : PR_SVE_VL_LEN_MASK;
+
+	/*
+	 * Enumerate up to SVE_VQ_MAX vector lengths
+	 */
+	for (vq = SVE_VQ_MAX; vq > 0; --vq) {
+		vl = prctl(pr_set_vl, vq * 16);
+		if (vl == -1)
+			return KSFT_FAIL;
+
+		vl &= len_mask;
+
+		/*
+		 * Unlike SVE, SME does not require the minimum vector length
+		 * to be implemented, or the VLs to be consecutive, so any call
+		 * to the prctl might return the single implemented VL, which
+		 * might be larger than 16. So to avoid this loop never
+		 * terminating,  bail out here when we find a higher VL than
+		 * we asked for.
+		 * See the ARM ARM, DDI 0487K.a, B1.4.2: I_QQRNR and I_NWYBP.
+		 */
+		if (vq < sve_vq_from_vl(vl))
+			break;
+
+		/* Skip missing VLs */
+		vq = sve_vq_from_vl(vl);
+
+		vls[nvls++] = vl;
+	}
+
+	if (nvls < min_vls) {
+		fprintf(stderr, "Only %d VL supported\n", nvls);
+		return KSFT_SKIP;
+	}
+
+	return KSFT_PASS;
+}
diff --git a/tools/testing/selftests/arm64/signal/sve_helpers.h b/tools/testing/selftests/arm64/signal/sve_helpers.h
new file mode 100644
index 0000000000000..50948ce471cc6
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/sve_helpers.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 ARM Limited
+ *
+ * Common helper functions for SVE and SME functionality.
+ */
+
+#ifndef __SVE_HELPERS_H__
+#define __SVE_HELPERS_H__
+
+#include <stdbool.h>
+
+#define VLS_USE_SVE	false
+#define VLS_USE_SME	true
+
+extern unsigned int vls[];
+extern unsigned int nvls;
+
+int sve_fill_vls(bool use_sme, int min_vls);
+
+#endif
diff --git a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sme_change_vl.c b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sme_change_vl.c
index ebd5815b54bba..bc10585062d57 100644
--- a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sme_change_vl.c
+++ b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sme_change_vl.c
@@ -11,39 +11,22 @@
 #include <sys/prctl.h>
 
 #include "test_signals_utils.h"
+#include "sve_helpers.h"
 #include "testcases.h"
 
 struct fake_sigframe sf;
-static unsigned int vls[SVE_VQ_MAX];
-unsigned int nvls = 0;
 
 static bool sme_get_vls(struct tdescr *td)
 {
-	int vq, vl;
+	int res = sve_fill_vls(VLS_USE_SME, 2);
 
-	/*
-	 * Enumerate up to SVE_VQ_MAX vector lengths
-	 */
-	for (vq = SVE_VQ_MAX; vq > 0; --vq) {
-		vl = prctl(PR_SVE_SET_VL, vq * 16);
-		if (vl == -1)
-			return false;
+	if (!res)
+		return true;
 
-		vl &= PR_SME_VL_LEN_MASK;
+	if (res == KSFT_SKIP)
+		td->result = KSFT_SKIP;
 
-		/* Skip missing VLs */
-		vq = sve_vq_from_vl(vl);
-
-		vls[nvls++] = vl;
-	}
-
-	/* We need at least two VLs */
-	if (nvls < 2) {
-		fprintf(stderr, "Only %d VL supported\n", nvls);
-		return false;
-	}
-
-	return true;
+	return false;
 }
 
 static int fake_sigreturn_ssve_change_vl(struct tdescr *td,
diff --git a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sve_change_vl.c b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sve_change_vl.c
index e2a452190511f..e1ccf8f85a70c 100644
--- a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sve_change_vl.c
+++ b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sve_change_vl.c
@@ -12,40 +12,22 @@
 #include <sys/prctl.h>
 
 #include "test_signals_utils.h"
+#include "sve_helpers.h"
 #include "testcases.h"
 
 struct fake_sigframe sf;
-static unsigned int vls[SVE_VQ_MAX];
-unsigned int nvls = 0;
 
 static bool sve_get_vls(struct tdescr *td)
 {
-	int vq, vl;
+	int res = sve_fill_vls(VLS_USE_SVE, 2);
 
-	/*
-	 * Enumerate up to SVE_VQ_MAX vector lengths
-	 */
-	for (vq = SVE_VQ_MAX; vq > 0; --vq) {
-		vl = prctl(PR_SVE_SET_VL, vq * 16);
-		if (vl == -1)
-			return false;
+	if (!res)
+		return true;
 
-		vl &= PR_SVE_VL_LEN_MASK;
-
-		/* Skip missing VLs */
-		vq = sve_vq_from_vl(vl);
-
-		vls[nvls++] = vl;
-	}
-
-	/* We need at least two VLs */
-	if (nvls < 2) {
-		fprintf(stderr, "Only %d VL supported\n", nvls);
+	if (res == KSFT_SKIP)
 		td->result = KSFT_SKIP;
-		return false;
-	}
 
-	return true;
+	return false;
 }
 
 static int fake_sigreturn_sve_change_vl(struct tdescr *td,
diff --git a/tools/testing/selftests/arm64/signal/testcases/ssve_regs.c b/tools/testing/selftests/arm64/signal/testcases/ssve_regs.c
index 3d37daafcff51..6dbe48cf8b09e 100644
--- a/tools/testing/selftests/arm64/signal/testcases/ssve_regs.c
+++ b/tools/testing/selftests/arm64/signal/testcases/ssve_regs.c
@@ -6,51 +6,31 @@
  * set up as expected.
  */
 
+#include <kselftest.h>
 #include <signal.h>
 #include <ucontext.h>
 #include <sys/prctl.h>
 
 #include "test_signals_utils.h"
+#include "sve_helpers.h"
 #include "testcases.h"
 
 static union {
 	ucontext_t uc;
 	char buf[1024 * 64];
 } context;
-static unsigned int vls[SVE_VQ_MAX];
-unsigned int nvls = 0;
 
 static bool sme_get_vls(struct tdescr *td)
 {
-	int vq, vl;
+	int res = sve_fill_vls(VLS_USE_SME, 1);
 
-	/*
-	 * Enumerate up to SVE_VQ_MAX vector lengths
-	 */
-	for (vq = SVE_VQ_MAX; vq > 0; --vq) {
-		vl = prctl(PR_SME_SET_VL, vq * 16);
-		if (vl == -1)
-			return false;
-
-		vl &= PR_SME_VL_LEN_MASK;
-
-		/* Did we find the lowest supported VL? */
-		if (vq < sve_vq_from_vl(vl))
-			break;
+	if (!res)
+		return true;
 
-		/* Skip missing VLs */
-		vq = sve_vq_from_vl(vl);
-
-		vls[nvls++] = vl;
-	}
-
-	/* We need at least one VL */
-	if (nvls < 1) {
-		fprintf(stderr, "Only %d VL supported\n", nvls);
-		return false;
-	}
+	if (res == KSFT_SKIP)
+		td->result = KSFT_SKIP;
 
-	return true;
+	return false;
 }
 
 static void setup_ssve_regs(void)
diff --git a/tools/testing/selftests/arm64/signal/testcases/ssve_za_regs.c b/tools/testing/selftests/arm64/signal/testcases/ssve_za_regs.c
index 9dc5f128bbc0d..5557e116e9736 100644
--- a/tools/testing/selftests/arm64/signal/testcases/ssve_za_regs.c
+++ b/tools/testing/selftests/arm64/signal/testcases/ssve_za_regs.c
@@ -6,51 +6,31 @@
  * signal frames is set up as expected when enabled simultaneously.
  */
 
+#include <kselftest.h>
 #include <signal.h>
 #include <ucontext.h>
 #include <sys/prctl.h>
 
 #include "test_signals_utils.h"
+#include "sve_helpers.h"
 #include "testcases.h"
 
 static union {
 	ucontext_t uc;
 	char buf[1024 * 128];
 } context;
-static unsigned int vls[SVE_VQ_MAX];
-unsigned int nvls = 0;
 
 static bool sme_get_vls(struct tdescr *td)
 {
-	int vq, vl;
+	int res = sve_fill_vls(VLS_USE_SME, 1);
 
-	/*
-	 * Enumerate up to SVE_VQ_MAX vector lengths
-	 */
-	for (vq = SVE_VQ_MAX; vq > 0; --vq) {
-		vl = prctl(PR_SME_SET_VL, vq * 16);
-		if (vl == -1)
-			return false;
-
-		vl &= PR_SME_VL_LEN_MASK;
-
-		/* Did we find the lowest supported VL? */
-		if (vq < sve_vq_from_vl(vl))
-			break;
+	if (!res)
+		return true;
 
-		/* Skip missing VLs */
-		vq = sve_vq_from_vl(vl);
-
-		vls[nvls++] = vl;
-	}
-
-	/* We need at least one VL */
-	if (nvls < 1) {
-		fprintf(stderr, "Only %d VL supported\n", nvls);
-		return false;
-	}
+	if (res == KSFT_SKIP)
+		td->result = KSFT_SKIP;
 
-	return true;
+	return false;
 }
 
 static void setup_regs(void)
diff --git a/tools/testing/selftests/arm64/signal/testcases/sve_regs.c b/tools/testing/selftests/arm64/signal/testcases/sve_regs.c
index 8b16eabbb7697..8143eb1c58c18 100644
--- a/tools/testing/selftests/arm64/signal/testcases/sve_regs.c
+++ b/tools/testing/selftests/arm64/signal/testcases/sve_regs.c
@@ -6,47 +6,31 @@
  * expected.
  */
 
+#include <kselftest.h>
 #include <signal.h>
 #include <ucontext.h>
 #include <sys/prctl.h>
 
 #include "test_signals_utils.h"
+#include "sve_helpers.h"
 #include "testcases.h"
 
 static union {
 	ucontext_t uc;
 	char buf[1024 * 64];
 } context;
-static unsigned int vls[SVE_VQ_MAX];
-unsigned int nvls = 0;
 
 static bool sve_get_vls(struct tdescr *td)
 {
-	int vq, vl;
+	int res = sve_fill_vls(VLS_USE_SVE, 1);
 
-	/*
-	 * Enumerate up to SVE_VQ_MAX vector lengths
-	 */
-	for (vq = SVE_VQ_MAX; vq > 0; --vq) {
-		vl = prctl(PR_SVE_SET_VL, vq * 16);
-		if (vl == -1)
-			return false;
-
-		vl &= PR_SVE_VL_LEN_MASK;
-
-		/* Skip missing VLs */
-		vq = sve_vq_from_vl(vl);
+	if (!res)
+		return true;
 
-		vls[nvls++] = vl;
-	}
-
-	/* We need at least one VL */
-	if (nvls < 1) {
-		fprintf(stderr, "Only %d VL supported\n", nvls);
-		return false;
-	}
+	if (res == KSFT_SKIP)
+		td->result = KSFT_SKIP;
 
-	return true;
+	return false;
 }
 
 static void setup_sve_regs(void)
diff --git a/tools/testing/selftests/arm64/signal/testcases/za_no_regs.c b/tools/testing/selftests/arm64/signal/testcases/za_no_regs.c
index 4d6f94b6178f3..ce26e9c2fa5e3 100644
--- a/tools/testing/selftests/arm64/signal/testcases/za_no_regs.c
+++ b/tools/testing/selftests/arm64/signal/testcases/za_no_regs.c
@@ -6,47 +6,31 @@
  * expected.
  */
 
+#include <kselftest.h>
 #include <signal.h>
 #include <ucontext.h>
 #include <sys/prctl.h>
 
 #include "test_signals_utils.h"
+#include "sve_helpers.h"
 #include "testcases.h"
 
 static union {
 	ucontext_t uc;
 	char buf[1024 * 128];
 } context;
-static unsigned int vls[SVE_VQ_MAX];
-unsigned int nvls = 0;
 
 static bool sme_get_vls(struct tdescr *td)
 {
-	int vq, vl;
+	int res = sve_fill_vls(VLS_USE_SME, 1);
 
-	/*
-	 * Enumerate up to SME_VQ_MAX vector lengths
-	 */
-	for (vq = SVE_VQ_MAX; vq > 0; --vq) {
-		vl = prctl(PR_SME_SET_VL, vq * 16);
-		if (vl == -1)
-			return false;
-
-		vl &= PR_SME_VL_LEN_MASK;
-
-		/* Skip missing VLs */
-		vq = sve_vq_from_vl(vl);
+	if (!res)
+		return true;
 
-		vls[nvls++] = vl;
-	}
-
-	/* We need at least one VL */
-	if (nvls < 1) {
-		fprintf(stderr, "Only %d VL supported\n", nvls);
-		return false;
-	}
+	if (res == KSFT_SKIP)
+		td->result = KSFT_SKIP;
 
-	return true;
+	return false;
 }
 
 static int do_one_sme_vl(struct tdescr *td, siginfo_t *si, ucontext_t *uc,
diff --git a/tools/testing/selftests/arm64/signal/testcases/za_regs.c b/tools/testing/selftests/arm64/signal/testcases/za_regs.c
index 174ad66566964..b9e13f27f1f9a 100644
--- a/tools/testing/selftests/arm64/signal/testcases/za_regs.c
+++ b/tools/testing/selftests/arm64/signal/testcases/za_regs.c
@@ -6,51 +6,31 @@
  * expected.
  */
 
+#include <kselftest.h>
 #include <signal.h>
 #include <ucontext.h>
 #include <sys/prctl.h>
 
 #include "test_signals_utils.h"
+#include "sve_helpers.h"
 #include "testcases.h"
 
 static union {
 	ucontext_t uc;
 	char buf[1024 * 128];
 } context;
-static unsigned int vls[SVE_VQ_MAX];
-unsigned int nvls = 0;
 
 static bool sme_get_vls(struct tdescr *td)
 {
-	int vq, vl;
+	int res = sve_fill_vls(VLS_USE_SME, 1);
 
-	/*
-	 * Enumerate up to SME_VQ_MAX vector lengths
-	 */
-	for (vq = SVE_VQ_MAX; vq > 0; --vq) {
-		vl = prctl(PR_SME_SET_VL, vq * 16);
-		if (vl == -1)
-			return false;
-
-		vl &= PR_SME_VL_LEN_MASK;
-
-		/* Did we find the lowest supported VL? */
-		if (vq < sve_vq_from_vl(vl))
-			break;
+	if (!res)
+		return true;
 
-		/* Skip missing VLs */
-		vq = sve_vq_from_vl(vl);
-
-		vls[nvls++] = vl;
-	}
-
-	/* We need at least one VL */
-	if (nvls < 1) {
-		fprintf(stderr, "Only %d VL supported\n", nvls);
-		return false;
-	}
+	if (res == KSFT_SKIP)
+		td->result = KSFT_SKIP;
 
-	return true;
+	return false;
 }
 
 static void setup_za_regs(void)
-- 
2.25.1


