Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1701E43BA0
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2019 17:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbfFMPaf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jun 2019 11:30:35 -0400
Received: from foss.arm.com ([217.140.110.172]:38142 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728752AbfFMLOe (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jun 2019 07:14:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 928993EF;
        Thu, 13 Jun 2019 04:14:33 -0700 (PDT)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 247093F694;
        Thu, 13 Jun 2019 04:16:16 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org
Cc:     dave.martin@arm.com, andreyknvl@google.com
Subject: [PATCH 07/13] kselftest: arm64: mangle_pstate_invalid_mode_el?
Date:   Thu, 13 Jun 2019 12:13:29 +0100
Message-Id: <20190613111335.7645-8-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190613111335.7645-1-cristian.marussi@arm.com>
References: <20190613111335.7645-1-cristian.marussi@arm.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Added 3 simple mangle testcases that mess with the ucontext_t
from within the sig_handler, trying to toggle PSTATE mode bits to
trick the system into switching to EL1/EL2/EL3.
Expects SIGSEGV on test PASS.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 .../arm64/signal/testcases/.gitignore         |  3 +++
 .../mangle_pstate_invalid_mode_el1.c          | 25 +++++++++++++++++++
 .../mangle_pstate_invalid_mode_el2.c          | 25 +++++++++++++++++++
 .../mangle_pstate_invalid_mode_el3.c          | 25 +++++++++++++++++++
 4 files changed, 78 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el1.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el2.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el3.c

diff --git a/tools/testing/selftests/arm64/signal/testcases/.gitignore b/tools/testing/selftests/arm64/signal/testcases/.gitignore
index 91f7aee4b666..e7a1d998b650 100644
--- a/tools/testing/selftests/arm64/signal/testcases/.gitignore
+++ b/tools/testing/selftests/arm64/signal/testcases/.gitignore
@@ -2,3 +2,6 @@ mangle_sp_misaligned
 mangle_pc_invalid
 mangle_pstate_invalid_daif_bits
 mangle_pstate_invalid_state_toggle
+mangle_pstate_invalid_mode_el1
+mangle_pstate_invalid_mode_el2
+mangle_pstate_invalid_mode_el3
diff --git a/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el1.c b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el1.c
new file mode 100644
index 000000000000..9f5bde2e287f
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el1.c
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2019 ARM Limited */
+
+#include "test_signals_utils.h"
+#include "testcases.h"
+
+static int mangle_invalid_pstate_run(struct tdescr *td, siginfo_t *si,
+				     ucontext_t *uc)
+{
+	ASSERT_GOOD_CONTEXT(uc);
+
+	/* This config should trigger a SIGSEGV by Kernel */
+	uc->uc_mcontext.pstate |= PSR_MODE_EL1t;
+
+	return 1;
+}
+
+struct tdescr tde = {
+		.sanity_disabled = true,
+		.name = "MANGLE_PSTATE_INVALID_MODE_EL1t",
+		.descr = "Mangling uc_mcontext with INVALID MODE EL1t",
+		.sig_trig = SIGUSR1,
+		.sig_ok = SIGSEGV,
+		.run = mangle_invalid_pstate_run,
+};
diff --git a/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el2.c b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el2.c
new file mode 100644
index 000000000000..667e04fadf7b
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el2.c
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2019 ARM Limited */
+
+#include "test_signals_utils.h"
+#include "testcases.h"
+
+static int mangle_invalid_pstate_run(struct tdescr *td, siginfo_t *si,
+				     ucontext_t *uc)
+{
+	ASSERT_GOOD_CONTEXT(uc);
+
+	/* This config should trigger a SIGSEGV by Kernel */
+	uc->uc_mcontext.pstate |= PSR_MODE_EL2t;
+
+	return 1;
+}
+
+struct tdescr tde = {
+		.sanity_disabled = true,
+		.name = "MANGLE_PSTATE_INVALID_MODE_EL2t",
+		.descr = "Mangling uc_mcontext with INVALID MODE EL2t",
+		.sig_trig = SIGUSR1,
+		.sig_ok = SIGSEGV,
+		.run = mangle_invalid_pstate_run,
+};
diff --git a/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el3.c b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el3.c
new file mode 100644
index 000000000000..17abde0c6883
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el3.c
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2019 ARM Limited */
+
+#include "test_signals_utils.h"
+#include "testcases.h"
+
+static int mangle_invalid_pstate_run(struct tdescr *td, siginfo_t *si,
+				     ucontext_t *uc)
+{
+	ASSERT_GOOD_CONTEXT(uc);
+
+	/* This config should trigger a SIGSEGV by Kernel */
+	uc->uc_mcontext.pstate |= PSR_MODE_EL3t;
+
+	return 1;
+}
+
+struct tdescr tde = {
+		.sanity_disabled = true,
+		.name = "MANGLE_PSTATE_INVALID_MODE_EL3t",
+		.descr = "Mangling uc_mcontext with INVALID MODE EL3t",
+		.sig_trig = SIGUSR1,
+		.sig_ok = SIGSEGV,
+		.run = mangle_invalid_pstate_run,
+};
-- 
2.17.1

