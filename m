Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD63CEBDB
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2019 20:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbfJGSaW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Oct 2019 14:30:22 -0400
Received: from foss.arm.com ([217.140.110.172]:44094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729365AbfJGSaV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Oct 2019 14:30:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05A121576;
        Mon,  7 Oct 2019 11:30:21 -0700 (PDT)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E3AE3F68E;
        Mon,  7 Oct 2019 11:30:20 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org
Cc:     andreyknvl@google.com, dave.martin@arm.com, amit.kachhap@arm.com
Subject: [PATCH v7 06/11] kselftest: arm64: fake_sigreturn_bad_magic
Date:   Mon,  7 Oct 2019 19:29:49 +0100
Message-Id: <20191007182954.25730-7-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191007182954.25730-1-cristian.marussi@arm.com>
References: <20191007182954.25730-1-cristian.marussi@arm.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a simple fake_sigreturn testcase which builds a ucontext_t with a bad
magic header and place it onto the stack. Expects a SIGSEGV on test PASS.

Introduce a common utility assembly trampoline function to invoke a
sigreturn while placing the provided sigframe at wanted alignment and
also an helper to make space when needed inside the sigframe reserved
area.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v6 --> v7
- fix fake_sigreturn alignment routines (+15)
v5 --> v6
- fake_sigreturn: cleaned up, avoiding excessive SP misalignments
- fake_sigreturn: better formatting and prologue
- get_starting_header: cleand up and commented
- avoid timeout on failure
v3 --> v4
- fix commit
- fix signal.S, handle misalign requests too
- remove unneeded comments
- add signal.h include
- added get_starting_head() helper
- added test description
---
 tools/testing/selftests/arm64/signal/Makefile |  2 +-
 .../testing/selftests/arm64/signal/signals.S  | 64 +++++++++++++++++++
 .../arm64/signal/test_signals_utils.h         |  2 +
 .../testcases/fake_sigreturn_bad_magic.c      | 52 +++++++++++++++
 .../arm64/signal/testcases/testcases.c        | 46 +++++++++++++
 .../arm64/signal/testcases/testcases.h        |  4 ++
 6 files changed, 169 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/arm64/signal/signals.S
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_magic.c

diff --git a/tools/testing/selftests/arm64/signal/Makefile b/tools/testing/selftests/arm64/signal/Makefile
index f78f5190e3d4..b497cfea4643 100644
--- a/tools/testing/selftests/arm64/signal/Makefile
+++ b/tools/testing/selftests/arm64/signal/Makefile
@@ -28,5 +28,5 @@ clean:
 # Common test-unit targets to build common-layout test-cases executables
 # Needs secondary expansion to properly include the testcase c-file in pre-reqs
 .SECONDEXPANSION:
-$(PROGS): test_signals.c test_signals_utils.c testcases/testcases.c $$@.c test_signals.h test_signals_utils.h testcases/testcases.h
+$(PROGS): test_signals.c test_signals_utils.c testcases/testcases.c signals.S $$@.c test_signals.h test_signals_utils.h testcases/testcases.h
 	$(CC) $(CFLAGS) $^ -o $@
diff --git a/tools/testing/selftests/arm64/signal/signals.S b/tools/testing/selftests/arm64/signal/signals.S
new file mode 100644
index 000000000000..9f8c1aefc3b9
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/signals.S
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2019 ARM Limited */
+
+#include <asm/unistd.h>
+
+.section        .rodata, "a"
+call_fmt:
+	.asciz "Calling sigreturn with fake sigframe sized:%zd at SP @%08lX\n"
+
+.text
+
+.globl fake_sigreturn
+
+/*	fake_sigreturn	x0:&sigframe,  x1:sigframe_size,  x2:misalign_bytes */
+fake_sigreturn:
+	stp	x29, x30, [sp, #-16]!
+	mov	x29, sp
+
+	mov	x20, x0
+	mov	x21, x1
+	mov	x22, x2
+
+	/* create space on the stack for fake sigframe 16 bytes-aligned */
+	add	x0, x21, x22
+	add	x0, x0, #15
+	bic	x0, x0, #15 /* round_up(sigframe_size + misalign_bytes, 16) */
+	sub	sp, sp, x0
+	add	x23, sp, x22 /* new sigframe base with misaligment if any */
+
+	ldr	x0, =call_fmt
+	mov	x1, x21
+	mov	x2, x23
+	bl	printf
+
+	/* memcpy the provided content, while still keeping SP aligned */
+	mov	x0, x23
+	mov	x1, x20
+	mov	x2, x21
+	bl	memcpy
+
+	/*
+	 * Here saving a last minute SP to current->token acts as a marker:
+	 * if we got here, we are successfully faking a sigreturn; in other
+	 * words we are sure no bad fatal signal has been raised till now
+	 * for unrelated reasons, so we should consider the possibly observed
+	 * fatal signal like SEGV coming from Kernel restore_sigframe() and
+	 * triggered as expected from our test-case.
+	 * For simplicity this assumes that current field 'token' is laid out
+	 * as first in struct tdescr
+	 */
+	ldr	x0, current
+	str	x23, [x0]
+	/* finally move SP to misaligned address...if any requested */
+	mov	sp, x23
+
+	mov	x8, #__NR_rt_sigreturn
+	svc	#0
+
+	/*
+	 * Above sigreturn should not return...looping here leads to a timeout
+	 * and ensure proper and clean test failure, instead of jumping around
+	 * on a potentially corrupted stack.
+	 */
+	b	.
diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.h b/tools/testing/selftests/arm64/signal/test_signals_utils.h
index fd67b1f23c41..6772b5c8d274 100644
--- a/tools/testing/selftests/arm64/signal/test_signals_utils.h
+++ b/tools/testing/selftests/arm64/signal/test_signals_utils.h
@@ -115,4 +115,6 @@ static __always_inline bool get_current_context(struct tdescr *td,
 
 	return td->live_uc_valid;
 }
+
+int fake_sigreturn(void *sigframe, size_t sz, int misalign_bytes);
 #endif
diff --git a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_magic.c b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_magic.c
new file mode 100644
index 000000000000..8dc600a7d4fd
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_magic.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 ARM Limited
+ *
+ * Place a fake sigframe on the stack including a BAD Unknown magic
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
+static int fake_sigreturn_bad_magic_run(struct tdescr *td,
+					siginfo_t *si, ucontext_t *uc)
+{
+	struct _aarch64_ctx *shead = GET_SF_RESV_HEAD(sf), *head;
+
+	/* just to fill the ucontext_t with something real */
+	if (!get_current_context(td, &sf.uc))
+		return 1;
+
+	/* need at least 2*HDR_SZ space: KSFT_BAD_MAGIC + terminator. */
+	head = get_starting_head(shead, HDR_SZ * 2, GET_SF_RESV_SIZE(sf), NULL);
+	if (!head)
+		return 0;
+
+	/*
+	 * use a well known NON existent bad magic...something
+	 * we should pretty sure won't be ever defined in Kernel
+	 */
+	head->magic = KSFT_BAD_MAGIC;
+	head->size = HDR_SZ;
+	write_terminator_record(GET_RESV_NEXT_HEAD(head));
+
+	ASSERT_BAD_CONTEXT(&sf.uc);
+	fake_sigreturn(&sf, sizeof(sf), 0);
+
+	return 1;
+}
+
+struct tdescr tde = {
+		.name = "FAKE_SIGRETURN_BAD_MAGIC",
+		.descr = "Trigger a sigreturn with a sigframe with a bad magic",
+		.sig_ok = SIGSEGV,
+		.timeout = 3,
+		.run = fake_sigreturn_bad_magic_run,
+};
diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.c b/tools/testing/selftests/arm64/signal/testcases/testcases.c
index 1914a01222a1..e3521949b800 100644
--- a/tools/testing/selftests/arm64/signal/testcases/testcases.c
+++ b/tools/testing/selftests/arm64/signal/testcases/testcases.c
@@ -148,3 +148,49 @@ bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
 
 	return true;
 }
+
+/*
+ * This function walks through the records inside the provided reserved area
+ * trying to find enough space to fit @need_sz bytes: if not enough space is
+ * available and an extra_context record is present, it throws away the
+ * extra_context record.
+ *
+ * It returns a pointer to a new header where it is possible to start storing
+ * our need_sz bytes.
+ *
+ * @shead: points to the start of reserved area
+ * @need_sz: needed bytes
+ * @resv_sz: reserved area size in bytes
+ * @offset: if not null, this will be filled with the offset of the return
+ *	    head pointer from @shead
+ *
+ * @return: pointer to a new head where to start storing need_sz bytes, or
+ *	    NULL if space could not be made available.
+ */
+struct _aarch64_ctx *get_starting_head(struct _aarch64_ctx *shead,
+				       size_t need_sz, size_t resv_sz,
+				       size_t *offset)
+{
+	size_t offs = 0;
+	struct _aarch64_ctx *head;
+
+	head = get_terminator(shead, resv_sz, &offs);
+	/* not found a terminator...no need to update offset if any */
+	if (!head)
+		return head;
+	if (resv_sz - offs < need_sz) {
+		fprintf(stderr, "Low on space:%zd. Discarding extra_context.\n",
+			resv_sz - offs);
+		head = get_header(shead, EXTRA_MAGIC, resv_sz, &offs);
+		if (!head || resv_sz - offs < need_sz) {
+			fprintf(stderr,
+				"Failed to reclaim space on sigframe.\n");
+			return NULL;
+		}
+	}
+
+	fprintf(stderr, "Available space:%zd\n", resv_sz - offs);
+	if (offset)
+		*offset = offs;
+	return head;
+}
diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.h b/tools/testing/selftests/arm64/signal/testcases/testcases.h
index 04987f7870bc..ad884c135314 100644
--- a/tools/testing/selftests/arm64/signal/testcases/testcases.h
+++ b/tools/testing/selftests/arm64/signal/testcases/testcases.h
@@ -97,4 +97,8 @@ static inline void write_terminator_record(struct _aarch64_ctx *tail)
 		tail->size = 0;
 	}
 }
+
+struct _aarch64_ctx *get_starting_head(struct _aarch64_ctx *shead,
+				       size_t need_sz, size_t resv_sz,
+				       size_t *offset);
 #endif
-- 
2.17.1

