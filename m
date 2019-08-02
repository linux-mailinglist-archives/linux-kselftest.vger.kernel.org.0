Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 781647FF22
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2019 19:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391301AbfHBRDi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Aug 2019 13:03:38 -0400
Received: from foss.arm.com ([217.140.110.172]:55064 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388317AbfHBRDi (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Aug 2019 13:03:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E561E344;
        Fri,  2 Aug 2019 10:03:36 -0700 (PDT)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24F533F575;
        Fri,  2 Aug 2019 10:03:36 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org
Cc:     andreyknvl@google.com, dave.martin@arm.com
Subject: [PATCH v3 06/11] kselftest: arm64: fake_sigreturn_bad_magic
Date:   Fri,  2 Aug 2019 18:02:55 +0100
Message-Id: <20190802170300.20662-7-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190802170300.20662-1-cristian.marussi@arm.com>
References: <20190802170300.20662-1-cristian.marussi@arm.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Added a simple fake_sigreturn testcase which builds a ucontext_t
with a bad magic header and place it onto the stack.
Expects a SIGSEGV on test PASS.
This commit also introduces a common utility assembly function to
invoke a sigreturn using a fake provided sigframe.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 tools/testing/selftests/arm64/signal/Makefile |  2 +-
 .../testing/selftests/arm64/signal/signals.S  | 64 +++++++++++++++++++
 .../arm64/signal/test_signals_utils.h         |  1 +
 .../arm64/signal/testcases/.gitignore         |  1 +
 .../testcases/fake_sigreturn_bad_magic.c      | 63 ++++++++++++++++++
 5 files changed, 130 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/arm64/signal/signals.S
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_magic.c

diff --git a/tools/testing/selftests/arm64/signal/Makefile b/tools/testing/selftests/arm64/signal/Makefile
index 8c8d08be4b0d..b3dcf315b5a4 100644
--- a/tools/testing/selftests/arm64/signal/Makefile
+++ b/tools/testing/selftests/arm64/signal/Makefile
@@ -80,7 +80,7 @@ endif
 # Common test-unit targets to build common-layout test-cases executables
 # Needs secondary expansion to properly include the testcase c-file in pre-reqs
 .SECONDEXPANSION:
-$(PROGS): test_signals.c test_signals_utils.c testcases/testcases.c $$@.c test_signals.h test_signals_utils.h testcases/testcases.h
+$(PROGS): test_signals.c test_signals_utils.c testcases/testcases.c signals.S $$@.c test_signals.h test_signals_utils.h testcases/testcases.h
 	@if [ ! -d $(khdr_dir) ]; then \
 		echo -n "\n!!! WARNING: $(khdr_dir) NOT FOUND."; \
 		echo "===>  Are you sure Kernel Headers have been installed properly ?\n"; \
diff --git a/tools/testing/selftests/arm64/signal/signals.S b/tools/testing/selftests/arm64/signal/signals.S
new file mode 100644
index 000000000000..6262b877400b
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/signals.S
@@ -0,0 +1,64 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright (C) 2019 ARM Limited
+ */
+
+#include <asm/unistd.h>
+
+.section        ".rodata", "a"
+call_fmt:
+	.asciz "Calling sigreturn with fake sigframe sized:%zd at calculated SP @%08lX\n"
+
+.text
+
+.globl fake_sigreturn
+
+/*	fake_sigreturn	x0:&sigframe,  x1:sigframe_size,  x2:alignment_SP */
+fake_sigreturn:
+	mov x20, x0
+	mov x21, x1
+	mov x22, x2
+	mov x23, sp
+
+	/* create space on the stack for fake sigframe..."x22"-aligned */
+	mov x0, #0
+	add x0, x21, x22
+	sub x22, x22, #1
+	bic x0, x0, x22
+	sub x23, x23, x0
+
+	ldr x0, =call_fmt
+	mov x1, x21
+	mov x2, x23
+	bl printf
+
+	mov sp, x23
+
+	/* now fill it with the provided content... */
+	mov x0, sp
+	mov x1, x20
+	mov x2, x21
+	bl memcpy
+
+	/*
+	 * Here saving a last minute SP to current->token acts as a marker:
+	 * if we got here, we are successfully faking a sigreturn; in other
+	 * words we are sure no bad fatal signal has been raised till now
+	 * for unrelated reasons, so we should consider the possibl observed
+	 * fatal signal like SEGV coming from Kernel restore_sigframe() and
+	 * triggered as expected from our test-case.
+	 * For simplicity this assumes that current field 'token' is laid out
+	 * as first in struct tdescr
+	 */
+	ldr x0, current
+	str x23, [x0]
+	/* SP is already pointing back to the just built fake sigframe here */
+	mov x8, #__NR_rt_sigreturn
+	svc #0
+
+	/*
+	 * Above sigreturn should not return...looping here leads to a timeout
+	 * and ensure proper and clean test failure, instead of jumping around
+	 * on a potentially corrupted stack.
+	 */
+	b .
diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.h b/tools/testing/selftests/arm64/signal/test_signals_utils.h
index ce35be8ebc8e..2a71da7e6695 100644
--- a/tools/testing/selftests/arm64/signal/test_signals_utils.h
+++ b/tools/testing/selftests/arm64/signal/test_signals_utils.h
@@ -12,4 +12,5 @@ int test_run(struct tdescr *td);
 void test_result(struct tdescr *td);
 
 bool get_current_context(struct tdescr *td, ucontext_t *dest_uc);
+int fake_sigreturn(void *sigframe, size_t sz, int alignment);
 #endif
diff --git a/tools/testing/selftests/arm64/signal/testcases/.gitignore b/tools/testing/selftests/arm64/signal/testcases/.gitignore
index a48a118b1a1a..0ea6fdc3765c 100644
--- a/tools/testing/selftests/arm64/signal/testcases/.gitignore
+++ b/tools/testing/selftests/arm64/signal/testcases/.gitignore
@@ -4,3 +4,4 @@ mangle_pstate_invalid_mode_el1
 mangle_pstate_invalid_mode_el2
 mangle_pstate_invalid_mode_el3
 mangle_pstate_ssbs_regs
+fake_sigreturn_bad_magic
diff --git a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_magic.c b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_magic.c
new file mode 100644
index 000000000000..b4c063e02a7a
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_magic.c
@@ -0,0 +1,63 @@
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
+static int fake_sigreturn_bad_magic_run(struct tdescr *td,
+					siginfo_t *si, ucontext_t *uc)
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
+	 * we need at least 2*HDR_SZ space ... one for the KSFT_BAD_MAGIC
+	 * and the other for the usual terminator.
+	 */
+	if (head && resv_sz - offset < HDR_SZ * 2) {
+		fprintf(stderr, "Low on space:%zd. Discarding extra_context.\n",
+			resv_sz - offset);
+		head = get_header(shead, EXTRA_MAGIC, resv_sz, &offset);
+	}
+	/* just give up and timeout if still not enough space */
+	if (head && resv_sz - offset >= HDR_SZ) {
+		fprintf(stderr, "Mangling template header. Spare space:%zd\n",
+			resv_sz - offset);
+		/*
+		 * use a well known NON existent bad magic...something
+		 * we should pretty sure won't be ever defined in Kernel
+		 */
+		head->magic = KSFT_BAD_MAGIC;
+		head->size = HDR_SZ;
+		write_terminator_record(GET_RESV_NEXT_HEAD(head));
+
+		ASSERT_BAD_CONTEXT(&sf.uc);
+		fake_sigreturn(&sf, sizeof(sf), 16);
+	}
+
+	return 1;
+}
+
+struct tdescr tde = {
+		.name = "FAKE_SIGRETURN_BAD_MAGIC",
+		.descr = "Triggers a fake sigreturn with a sigframe including a bad non-existent magic",
+		.sig_ok = SIGSEGV,
+		.timeout = 3,
+		.run = fake_sigreturn_bad_magic_run,
+};
-- 
2.17.1

