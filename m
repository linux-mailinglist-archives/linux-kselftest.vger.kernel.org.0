Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D098043B97
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2019 17:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfFMPa2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jun 2019 11:30:28 -0400
Received: from foss.arm.com ([217.140.110.172]:38192 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728797AbfFMLOs (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jun 2019 07:14:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 683FF3EF;
        Thu, 13 Jun 2019 04:14:47 -0700 (PDT)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED7583F694;
        Thu, 13 Jun 2019 04:16:29 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org
Cc:     dave.martin@arm.com, andreyknvl@google.com
Subject: [PATCH 13/13] kselftest: arm64: fake_sigreturn_overflow_reserved
Date:   Thu, 13 Jun 2019 12:13:35 +0100
Message-Id: <20190613111335.7645-14-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190613111335.7645-1-cristian.marussi@arm.com>
References: <20190613111335.7645-1-cristian.marussi@arm.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Added a simple fake_sigreturn testcase which builds a ucontext_t
with the whole __reserved area overflowed with ESR_MAGIC headers
and place it onto the stack.
Expects a SIGSEGV on test PASS.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 .../arm64/signal/testcases/.gitignore         |  1 +
 .../fake_sigreturn_overflow_reserved.c        | 48 +++++++++++++++++++
 2 files changed, 49 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_overflow_reserved.c

diff --git a/tools/testing/selftests/arm64/signal/testcases/.gitignore b/tools/testing/selftests/arm64/signal/testcases/.gitignore
index 66ba865b3b7e..69a18391c220 100644
--- a/tools/testing/selftests/arm64/signal/testcases/.gitignore
+++ b/tools/testing/selftests/arm64/signal/testcases/.gitignore
@@ -10,3 +10,4 @@ fake_sigreturn_misaligned
 fake_sigreturn_bad_magic
 fake_sigreturn_bad_size
 fake_sigreturn_bad_size_for_magic0
+fake_sigreturn_overflow_reserved
diff --git a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_overflow_reserved.c b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_overflow_reserved.c
new file mode 100644
index 000000000000..eba109453a65
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_overflow_reserved.c
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2019 ARM Limited */
+
+#include <asm/sigcontext.h>
+#include <ucontext.h>
+#include <stdio.h>
+
+#include "test_signals_utils.h"
+#include "testcases.h"
+
+struct a_sigframe sf;
+
+static int fake_sigreturn_overflow_reserved_run(struct tdescr *td,
+						siginfo_t *si,
+						ucontext_t *uc)
+{
+	size_t offset = 0;
+	struct _aarch64_ctx *head = GET_SF_RESV_HEAD(sf);
+
+	/* just to fill the ucontext_t with something real */
+	if (!get_current_context(td, &sf.uc))
+		return 1;
+
+	/* find the terminator, preserving existig headers */
+	head = get_terminator(head, GET_SF_RESV_SIZE(sf), &offset);
+	if (head) {
+		/* fill the __reserved area till the end */
+		do {
+			head->magic = ESR_MAGIC;
+			head->size = sizeof(struct esr_context);
+			offset += head->size;
+			head = GET_RESV_NEXT_HEAD(head);
+		} while (offset < GET_SF_RESV_SIZE(sf));
+
+		ASSERT_BAD_CONTEXT(&sf.uc);
+		fake_sigreturn(&sf, sizeof(sf), 16);
+	}
+
+	return 1;
+}
+
+struct tdescr tde = {
+		.name = "FAKE_SIGRETURN_OVERFLOW_RESERVED",
+		.descr = "Triggers a fake sigreturn with an overflowed sigframe",
+		.sig_ok = SIGSEGV,
+		.timeout = 3,
+		.run = fake_sigreturn_overflow_reserved_run,
+};
-- 
2.17.1

