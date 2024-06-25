Return-Path: <linux-kselftest+bounces-12639-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2A09167C1
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 14:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E8B72818A5
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 12:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBCE157497;
	Tue, 25 Jun 2024 12:24:56 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE640156679;
	Tue, 25 Jun 2024 12:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318296; cv=none; b=FMB9mMklRTOjojBkf/TBfYH02N15nPa1k35mo8cDWg1TL/2q9PUhlFjwi5wirfr4oc8JSJSJaxZcraYeQlM+al+5ItyIw40yQ58AWbFyprisjluv/6CH1y9oP2e35CIhVGFu4Km5aR/wmZLSqLcEaIDGc4hG3jWKThE3BmCmYQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318296; c=relaxed/simple;
	bh=Tm8cM8AhVmCOmUWGzLCuc4tp8hTRTQMFMct6WXa0saM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hRbFCjFvs4s7zZdHRQ8FWrqtdHy4njHRtQhfw1oTXiyJ5rFfTghDPD4C/GAC1Zj/PGDFWVHglnQA329HcAMbrTSJIkTGy9HR3oWitwlnNGZNoakPLO3TG8tmdfd+YwfnPmhXo8/QUiEM6p7pVsk4P8VgUyec0l4FwArZbYS+9aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F011D339;
	Tue, 25 Jun 2024 05:25:18 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.41.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 06D743F766;
	Tue, 25 Jun 2024 05:24:48 -0700 (PDT)
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
Subject: [PATCH v3 4/9] selftests/arm: Add signal tests
Date: Tue, 25 Jun 2024 17:54:03 +0530
Message-Id: <20240625122408.1439097-5-dev.jain@arm.com>
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

This patch introduces two signal tests, and generic test wrappers similar
to selftests/arm64/signal directory, along with the mangling testcases
found therein. arm_cpsr, dumped by the kernel to user space in the ucontext
structure to the signal handler, is mangled with. The kernel must spot this
illegal attempt and the testcases are expected to terminate via SEGV.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 .../testcases/mangle_cpsr_invalid_aif_bits.c  | 33 +++++++++++++++++++
 .../mangle_cpsr_invalid_compat_toggle.c       | 29 ++++++++++++++++
 2 files changed, 62 insertions(+)
 create mode 100644 tools/testing/selftests/arm/signal/testcases/mangle_cpsr_invalid_aif_bits.c
 create mode 100644 tools/testing/selftests/arm/signal/testcases/mangle_cpsr_invalid_compat_toggle.c

diff --git a/tools/testing/selftests/arm/signal/testcases/mangle_cpsr_invalid_aif_bits.c b/tools/testing/selftests/arm/signal/testcases/mangle_cpsr_invalid_aif_bits.c
new file mode 100644
index 000000000000..ea73a96fb229
--- /dev/null
+++ b/tools/testing/selftests/arm/signal/testcases/mangle_cpsr_invalid_aif_bits.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 ARM Limited
+ *
+ * Try to mangle the ucontext from inside a signal handler, mangling the
+ * AIF bits in an illegal manner: this attempt must be spotted by Kernel
+ * and the test case is expected to be terminated via SEGV.
+ *
+ */
+
+#include "test_signals_utils.h"
+
+static int mangle_invalid_cpsr_run(struct tdescr *td, siginfo_t *si,
+				   ucontext_t *uc)
+{
+
+	/*
+	 * This config should trigger a SIGSEGV by Kernel when it checks
+	 * the sigframe consistency in valid_user_regs() routine.
+	 */
+	uc->uc_mcontext.arm_cpsr |= PSR_A_BIT | PSR_I_BIT | PSR_F_BIT;
+
+	return 1;
+}
+
+struct tdescr tde = {
+		.sanity_disabled = true,
+		.name = "MANGLE_CPSR_INVALID_AIF_BITS",
+		.descr = "Mangling uc_mcontext with INVALID AIF_BITS",
+		.sig_trig = SIGUSR1,
+		.sig_ok = SIGSEGV,
+		.run = mangle_invalid_cpsr_run,
+};
diff --git a/tools/testing/selftests/arm/signal/testcases/mangle_cpsr_invalid_compat_toggle.c b/tools/testing/selftests/arm/signal/testcases/mangle_cpsr_invalid_compat_toggle.c
new file mode 100644
index 000000000000..f7ccbccb24e5
--- /dev/null
+++ b/tools/testing/selftests/arm/signal/testcases/mangle_cpsr_invalid_compat_toggle.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 ARM Limited
+ *
+ * Try to mangle the ucontext from inside a signal handler, toggling
+ * the execution state bit: this attempt must be spotted by Kernel and
+ * the test case is expected to be terminated via SEGV.
+ */
+
+#include "test_signals_utils.h"
+
+static int mangle_invalid_cpsr_run(struct tdescr *td, siginfo_t *si,
+				   ucontext_t *uc)
+{
+
+	/* This config should trigger a SIGSEGV by Kernel */
+	uc->uc_mcontext.arm_cpsr ^= MODE32_BIT;
+
+	return 1;
+}
+
+struct tdescr tde = {
+		.sanity_disabled = true,
+		.name = "MANGLE_CPSR_INVALID_STATE_TOGGLE",
+		.descr = "Mangling uc_mcontext with INVALID STATE_TOGGLE",
+		.sig_trig = SIGUSR1,
+		.sig_ok = SIGSEGV,
+		.run = mangle_invalid_cpsr_run,
+};
-- 
2.39.2


