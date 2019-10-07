Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA419CEBE0
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2019 20:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbfJGSa1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Oct 2019 14:30:27 -0400
Received: from foss.arm.com ([217.140.110.172]:44126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729433AbfJGSa1 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Oct 2019 14:30:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B6A319BF;
        Mon,  7 Oct 2019 11:30:26 -0700 (PDT)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B25403F68E;
        Mon,  7 Oct 2019 11:30:25 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org
Cc:     andreyknvl@google.com, dave.martin@arm.com, amit.kachhap@arm.com
Subject: [PATCH v7 11/11] kselftest: arm64: fake_sigreturn_misaligned_sp
Date:   Mon,  7 Oct 2019 19:29:54 +0100
Message-Id: <20191007182954.25730-12-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191007182954.25730-1-cristian.marussi@arm.com>
References: <20191007182954.25730-1-cristian.marussi@arm.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a simple fake_sigreturn testcase which places a valid sigframe on a
non-16 bytes aligned SP. Expects a SIGSEGV on test PASS.

Reviewed-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v3 --> v4
- fix commit
- use new fake_sigreturn misalig_bytes params
- removed TODO
- added test description
---
 .../testcases/fake_sigreturn_misaligned_sp.c  | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_misaligned_sp.c

diff --git a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_misaligned_sp.c b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_misaligned_sp.c
new file mode 100644
index 000000000000..1e089e66f9f3
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_misaligned_sp.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 ARM Limited
+ *
+ * Place a fake sigframe on the stack at a misaligned SP: on sigreturn
+ * Kernel must spot this attempt and the test case is expected to be
+ * terminated via SEGV.
+ */
+
+#include <signal.h>
+#include <ucontext.h>
+
+#include "test_signals_utils.h"
+#include "testcases.h"
+
+struct fake_sigframe sf;
+
+static int fake_sigreturn_misaligned_run(struct tdescr *td,
+					 siginfo_t *si, ucontext_t *uc)
+{
+	/* just to fill the ucontext_t with something real */
+	if (!get_current_context(td, &sf.uc))
+		return 1;
+
+	/* Forcing sigframe on misaligned SP (16 + 3) */
+	fake_sigreturn(&sf, sizeof(sf), 3);
+
+	return 1;
+}
+
+struct tdescr tde = {
+		.name = "FAKE_SIGRETURN_MISALIGNED_SP",
+		.descr = "Triggers a sigreturn with a misaligned sigframe",
+		.sig_ok = SIGSEGV,
+		.timeout = 3,
+		.run = fake_sigreturn_misaligned_run,
+};
-- 
2.17.1

