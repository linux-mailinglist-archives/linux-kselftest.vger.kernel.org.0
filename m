Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F280E52C9
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2019 19:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730947AbfJYR6X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Oct 2019 13:58:23 -0400
Received: from foss.arm.com ([217.140.110.172]:43970 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730835AbfJYR6X (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Oct 2019 13:58:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A269492;
        Fri, 25 Oct 2019 10:58:22 -0700 (PDT)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 878123F6C4;
        Fri, 25 Oct 2019 10:58:21 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org
Cc:     andreyknvl@google.com, dave.martin@arm.com, amit.kachhap@arm.com,
        suzuki.poulose@arm.com
Subject: [PATCH v10 10/12] kselftest: arm64: fake_sigreturn_duplicated_fpsimd
Date:   Fri, 25 Oct 2019 18:57:15 +0100
Message-Id: <20191025175717.15154-11-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025175717.15154-1-cristian.marussi@arm.com>
References: <20191025175717.15154-1-cristian.marussi@arm.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a simple fake_sigreturn testcase which builds a ucontext_t with
an anomalous additional fpsimd_context and place it onto the stack.
Expects a SIGSEGV on test PASS.

Reviewed-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v6 --> v7
- fixed typo
v5 --> v6
- removed unneeded locals
- avoid timeout on failure
v3 --> v4
- fix commit
- missing include
- using new get_starting_head() helper
- added test description
---
 .../fake_sigreturn_duplicated_fpsimd.c        | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_duplicated_fpsimd.c

diff --git a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_duplicated_fpsimd.c b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_duplicated_fpsimd.c
new file mode 100644
index 000000000000..afe8915f0998
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_duplicated_fpsimd.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 ARM Limited
+ *
+ * Place a fake sigframe on the stack including an additional FPSIMD
+ * record: on sigreturn Kernel must spot this attempt and the test
+ * case is expected to be terminated via SEGV.
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
+static int fake_sigreturn_duplicated_fpsimd_run(struct tdescr *td,
+						siginfo_t *si, ucontext_t *uc)
+{
+	struct _aarch64_ctx *shead = GET_SF_RESV_HEAD(sf), *head;
+
+	/* just to fill the ucontext_t with something real */
+	if (!get_current_context(td, &sf.uc))
+		return 1;
+
+	head = get_starting_head(shead, sizeof(struct fpsimd_context) + HDR_SZ,
+				 GET_SF_RESV_SIZE(sf), NULL);
+	if (!head)
+		return 0;
+
+	/* Add a spurious fpsimd_context */
+	head->magic = FPSIMD_MAGIC;
+	head->size = sizeof(struct fpsimd_context);
+	/* and terminate */
+	write_terminator_record(GET_RESV_NEXT_HEAD(head));
+
+	ASSERT_BAD_CONTEXT(&sf.uc);
+	fake_sigreturn(&sf, sizeof(sf), 0);
+
+	return 1;
+}
+
+struct tdescr tde = {
+		.name = "FAKE_SIGRETURN_DUPLICATED_FPSIMD",
+		.descr = "Triggers a sigreturn including two fpsimd_context",
+		.sig_ok = SIGSEGV,
+		.timeout = 3,
+		.run = fake_sigreturn_duplicated_fpsimd_run,
+};
-- 
2.17.1

