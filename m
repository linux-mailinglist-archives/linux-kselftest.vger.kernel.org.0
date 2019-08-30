Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09EDCA3C5B
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2019 18:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfH3Qnm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Aug 2019 12:43:42 -0400
Received: from foss.arm.com ([217.140.110.172]:35000 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728378AbfH3Qnm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Aug 2019 12:43:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09BD11576;
        Fri, 30 Aug 2019 09:43:42 -0700 (PDT)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 223823F718;
        Fri, 30 Aug 2019 09:43:41 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org
Cc:     andreyknvl@google.com, dave.martin@arm.com, amit.kachhap@arm.com
Subject: [PATCH v4 07/11] kselftest: arm64: fake_sigreturn_bad_size_for_magic0
Date:   Fri, 30 Aug 2019 17:42:44 +0100
Message-Id: <20190830164248.16238-8-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830164248.16238-1-cristian.marussi@arm.com>
References: <20190830164248.16238-1-cristian.marussi@arm.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a simple fake_sigreturn testcase which builds a ucontext_t with a
badly sized terminator record and place it onto the stack.
Expects a SIGSEGV on test PASS.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v3 --> v4
- fix commit
- add signal.h include
- using new get_starting_head() helper
- added test description
---
 .../fake_sigreturn_bad_size_for_magic0.c      | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size_for_magic0.c

diff --git a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size_for_magic0.c b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size_for_magic0.c
new file mode 100644
index 000000000000..25017fe18214
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size_for_magic0.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 ARM Limited
+ *
+ * Place a fake sigframe on the stack including a badly sized terminator
+ * record: on sigreturn Kernel must spot this attempt and the test case
+ * is expected to be terminated via SEGV.
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
+static int fake_sigreturn_bad_size_for_magic0_run(struct tdescr *td,
+						  siginfo_t *si, ucontext_t *uc)
+{
+	size_t resv_sz, need_sz;
+	struct _aarch64_ctx *shead = GET_SF_RESV_HEAD(sf), *head;
+
+	/* just to fill the ucontext_t with something real */
+	if (!get_current_context(td, &sf.uc))
+		return 1;
+
+	resv_sz = GET_SF_RESV_SIZE(sf);
+	/* at least HDR_SZ for the badly sized terminator. */
+	need_sz = HDR_SZ;
+	head = get_starting_head(shead, need_sz, resv_sz, NULL);
+	if (head) {
+		head->magic = 0;
+		head->size = HDR_SZ;
+
+		ASSERT_BAD_CONTEXT(&sf.uc);
+		fake_sigreturn(&sf, sizeof(sf), 0);
+	}
+
+	return 1;
+}
+
+struct tdescr tde = {
+		.name = "FAKE_SIGRETURN_BAD_SIZE_FOR_TERMINATOR",
+		.descr = "Trigger a sigreturn using non-zero size terminator",
+		.sig_ok = SIGSEGV,
+		.timeout = 3,
+		.run = fake_sigreturn_bad_size_for_magic0_run,
+};
-- 
2.17.1

