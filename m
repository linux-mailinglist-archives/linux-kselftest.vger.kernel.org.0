Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E70AD0E3E
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2019 14:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731075AbfJIMFU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Oct 2019 08:05:20 -0400
Received: from foss.arm.com ([217.140.110.172]:32814 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729883AbfJIMFU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Oct 2019 08:05:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 640FC15BE;
        Wed,  9 Oct 2019 05:05:19 -0700 (PDT)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C3013F703;
        Wed,  9 Oct 2019 05:05:18 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org
Cc:     andreyknvl@google.com, dave.martin@arm.com, amit.kachhap@arm.com
Subject: [PATCH v9 09/12] kselftest: arm64: fake_sigreturn_missing_fpsimd
Date:   Wed,  9 Oct 2019 13:04:56 +0100
Message-Id: <20191009120459.21805-10-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191009120459.21805-1-cristian.marussi@arm.com>
References: <20191009120459.21805-1-cristian.marussi@arm.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a simple fake_sigreturn testcase which builds a ucontext_t without
the required fpsimd_context and place it onto the stack.
Expects a SIGSEGV on test PASS.

Reviewed-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v3 --> v4
- fix commit
- added signal.h
- added test description
---
 .../testcases/fake_sigreturn_missing_fpsimd.c | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_missing_fpsimd.c

diff --git a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_missing_fpsimd.c b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_missing_fpsimd.c
new file mode 100644
index 000000000000..08ecd8073a1a
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_missing_fpsimd.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 ARM Limited
+ *
+ * Place a fake sigframe on the stack missing the mandatory FPSIMD
+ * record: on sigreturn Kernel must spot this attempt and the test
+ * case is expected to be terminated via SEGV.
+ */
+
+#include <stdio.h>
+#include <signal.h>
+#include <ucontext.h>
+
+#include "test_signals_utils.h"
+#include "testcases.h"
+
+struct fake_sigframe sf;
+
+static int fake_sigreturn_missing_fpsimd_run(struct tdescr *td,
+					     siginfo_t *si, ucontext_t *uc)
+{
+	size_t resv_sz, offset;
+	struct _aarch64_ctx *head = GET_SF_RESV_HEAD(sf);
+
+	/* just to fill the ucontext_t with something real */
+	if (!get_current_context(td, &sf.uc))
+		return 1;
+
+	resv_sz = GET_SF_RESV_SIZE(sf);
+	head = get_header(head, FPSIMD_MAGIC, resv_sz, &offset);
+	if (head && resv_sz - offset >= HDR_SZ) {
+		fprintf(stderr, "Mangling template header. Spare space:%zd\n",
+			resv_sz - offset);
+		/* Just overwrite fpsmid_context */
+		write_terminator_record(head);
+
+		ASSERT_BAD_CONTEXT(&sf.uc);
+		fake_sigreturn(&sf, sizeof(sf), 0);
+	}
+
+	return 1;
+}
+
+struct tdescr tde = {
+		.name = "FAKE_SIGRETURN_MISSING_FPSIMD",
+		.descr = "Triggers a sigreturn with a missing fpsimd_context",
+		.sig_ok = SIGSEGV,
+		.timeout = 3,
+		.run = fake_sigreturn_missing_fpsimd_run,
+};
-- 
2.17.1

