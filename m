Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE5A8A3C60
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2019 18:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbfH3Qnq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Aug 2019 12:43:46 -0400
Received: from foss.arm.com ([217.140.110.172]:35024 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728428AbfH3Qnp (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Aug 2019 12:43:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CA631576;
        Fri, 30 Aug 2019 09:43:45 -0700 (PDT)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 750A13F718;
        Fri, 30 Aug 2019 09:43:44 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org
Cc:     andreyknvl@google.com, dave.martin@arm.com, amit.kachhap@arm.com
Subject: [PATCH v4 10/11] kselftest: arm64: fake_sigreturn_bad_size
Date:   Fri, 30 Aug 2019 17:42:47 +0100
Message-Id: <20190830164248.16238-11-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830164248.16238-1-cristian.marussi@arm.com>
References: <20190830164248.16238-1-cristian.marussi@arm.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a simple fake_sigreturn testcase which builds a ucontext_t with a
badly sized header that causes a overrun in the __reserved area and
place it onto the stack. Expects a SIGSEGV on test PASS.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v3 --> v4
- fix commit
- missing include
- using new get_starting_head() helper
- added test description
---
 .../testcases/fake_sigreturn_bad_size.c       | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size.c

diff --git a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size.c b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size.c
new file mode 100644
index 000000000000..b1156afdb691
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 ARM Limited
+ *
+ * Place a fake sigframe on the stack including a bad record overflowing
+ * the __reserved space: on sigreturn Kernel must spot this attempt and
+ * the test case is expected to be terminated via SEGV.
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
+#define MIN_SZ_ALIGN	16
+
+static int fake_sigreturn_bad_size_run(struct tdescr *td,
+				       siginfo_t *si, ucontext_t *uc)
+{
+	size_t resv_sz, need_sz, offset;
+	struct _aarch64_ctx *shead = GET_SF_RESV_HEAD(sf), *head;
+
+	/* just to fill the ucontext_t with something real */
+	if (!get_current_context(td, &sf.uc))
+		return 1;
+
+	resv_sz = GET_SF_RESV_SIZE(sf);
+	/* at least HDR_SZ + bad sized esr_context needed */
+	need_sz = HDR_SZ + sizeof(struct esr_context);
+	head = get_starting_head(shead, need_sz, resv_sz, &offset);
+	if (head) {
+		/*
+		 * Use an esr_context to build a fake header with a
+		 * size greater then the free __reserved area minus HDR_SZ;
+		 * using ESR_MAGIC here since it is not checked for size nor
+		 * is limited to one instance.
+		 *
+		 * At first inject an additional normal esr_context
+		 */
+		head->magic = ESR_MAGIC;
+		head->size = sizeof(struct esr_context);
+		/* and terminate properly */
+		write_terminator_record(GET_RESV_NEXT_HEAD(head));
+		ASSERT_GOOD_CONTEXT(&sf.uc);
+
+		/*
+		 * now mess with fake esr_context size: leaving less space than
+		 * needed while keeping size value 16-aligned
+		 *
+		 * It must trigger a SEGV from Kernel on:
+		 *
+		 *	resv_sz - offset < sizeof(*head)
+		 */
+		/* at first set the maximum good 16-aligned size */
+		head->size =
+			(resv_sz - offset - need_sz + MIN_SZ_ALIGN) & ~0xfUL;
+		/* plus a bit more of 16-aligned sized stuff */
+		head->size += MIN_SZ_ALIGN;
+		/* and terminate properly */
+		write_terminator_record(GET_RESV_NEXT_HEAD(head));
+		ASSERT_BAD_CONTEXT(&sf.uc);
+		fake_sigreturn(&sf, sizeof(sf), 0);
+	}
+
+	return 1;
+}
+
+struct tdescr tde = {
+		.name = "FAKE_SIGRETURN_BAD_SIZE",
+		.descr = "Triggers a sigreturn with a overrun __reserved area",
+		.sig_ok = SIGSEGV,
+		.timeout = 3,
+		.run = fake_sigreturn_bad_size_run,
+};
-- 
2.17.1

