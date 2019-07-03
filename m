Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD565E949
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2019 18:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfGCQgV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Jul 2019 12:36:21 -0400
Received: from foss.arm.com ([217.140.110.172]:52470 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727119AbfGCQgV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Jul 2019 12:36:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8730114FF;
        Wed,  3 Jul 2019 09:36:20 -0700 (PDT)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA0743F718;
        Wed,  3 Jul 2019 09:36:19 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org
Cc:     dave.martin@arm.com, andreyknvl@google.com
Subject: [PATCH v2 07/10] kselftest: arm64: fake_sigreturn_bad_size_for_magic0
Date:   Wed,  3 Jul 2019 17:35:29 +0100
Message-Id: <20190703163532.7485-8-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190703163532.7485-1-cristian.marussi@arm.com>
References: <20190703163532.7485-1-cristian.marussi@arm.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Added a simple fake_sigreturn testcase which builds a ucontext_t
with a badly sized magic0 header and place it onto the stack.
Expects a SIGSEGV on test PASS.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 .../arm64/signal/testcases/.gitignore         |  1 +
 .../fake_sigreturn_bad_size_for_magic0.c      | 57 +++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size_for_magic0.c

diff --git a/tools/testing/selftests/arm64/signal/testcases/.gitignore b/tools/testing/selftests/arm64/signal/testcases/.gitignore
index 0ea6fdc3765c..cf2a73599818 100644
--- a/tools/testing/selftests/arm64/signal/testcases/.gitignore
+++ b/tools/testing/selftests/arm64/signal/testcases/.gitignore
@@ -5,3 +5,4 @@ mangle_pstate_invalid_mode_el2
 mangle_pstate_invalid_mode_el3
 mangle_pstate_ssbs_regs
 fake_sigreturn_bad_magic
+fake_sigreturn_bad_size_for_magic0
diff --git a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size_for_magic0.c b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size_for_magic0.c
new file mode 100644
index 000000000000..2f53c4740c85
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size_for_magic0.c
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2019 ARM Limited */
+
+#include <stdio.h>
+#include <ucontext.h>
+
+#include "test_signals_utils.h"
+#include "testcases.h"
+
+struct fake_sigframe sf;
+
+#define MIN_SZ_ALIGN	16
+
+static int fake_sigreturn_bad_size_for_magic0_run(struct tdescr *td,
+						  siginfo_t *si, ucontext_t *uc)
+{
+	size_t resv_sz, offset;
+	struct _aarch64_ctx *shead = GET_SF_RESV_HEAD(sf), *head;
+
+	/* just to fill the ucontext_t with something real */
+	if (!get_current_context(td, &sf.uc))
+		return 1;
+
+	resv_sz = GET_SF_RESV_SIZE(sf);
+	/*
+	 * find the terminator, preserving existing headers
+	 * and verify amount of spare room in __reserved area.
+	 */
+	head = get_terminator(shead, resv_sz, &offset);
+	/*
+	 * try stripping extra_context header when low on space:
+	 * we need at least HDR_SZ + 16 space for the bad sized terminator.
+	 */
+	if (head && resv_sz - offset < HDR_SZ + MIN_SZ_ALIGN) {
+		fprintf(stderr, "Low on space:%zd. Discarding extra_context.\n",
+			resv_sz - offset);
+		head = get_header(shead, EXTRA_MAGIC, resv_sz, &offset);
+	}
+	/* just give up and timeout if still not enough space */
+	if (head && resv_sz - offset >= HDR_SZ + MIN_SZ_ALIGN) {
+		head->magic = 0;
+		head->size = MIN_SZ_ALIGN;
+
+		ASSERT_BAD_CONTEXT(&sf.uc);
+		fake_sigreturn(&sf, sizeof(sf), 16);
+	}
+
+	return 1;
+}
+
+struct tdescr tde = {
+		.name = "FAKE_SIGRETURN_BAD_SIZE_FOR_MAGIC0",
+		.descr = "Triggers a fake sigreturn with a sigframe including a bad non-zero size magic0",
+		.sig_ok = SIGSEGV,
+		.timeout = 3,
+		.run = fake_sigreturn_bad_size_for_magic0_run,
+};
-- 
2.17.1

