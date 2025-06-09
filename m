Return-Path: <linux-kselftest+bounces-34449-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9FBAD19F5
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 10:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F4155188C003
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 08:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473F924DD04;
	Mon,  9 Jun 2025 08:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="AbzWx8Fv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB0D1E832A;
	Mon,  9 Jun 2025 08:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749458687; cv=none; b=kyL1kaXSy/ewiuCDRPMwstPVz0IFzzCtHD9jVIfMHuNo6VLhQhDEGcdOeFGxASDCW/iKW8qtvo5mcD5iGzNX84cJbkoR2H77SZS8saFubeOpzwXOFAoQ/RgJp8kTGf0mYVfNbgHUJ32Iou7UjnPotuUnN7BE8H1uBDAMOCNGAAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749458687; c=relaxed/simple;
	bh=CByUBOS0MBmmNMegB/+6lX7pJRvkfT954wBkluc+45o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X1epkVEDsLpnZ/rzbAd3qF9GNOLEemsIItTSP7YzkLSLixcPIcms+y7X3F9LUbUqK65l7VLaj1Wt8qgu9SzT/6O4qbw8dCH4sGgog78lfGUwrBEnjZj78ZPoCQQBQ2ssOSg7QZOnWk5DUeoAIIJro8As7s0J6mNmpCZgcEzoRC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=AbzWx8Fv; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5598etjY2083203
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 9 Jun 2025 01:41:00 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5598etjY2083203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025052101; t=1749458461;
	bh=6/ZBNndjXX8DFqqBm4MVFtkldgTvHA01dVD0CKp8O6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AbzWx8FvOp8tj7jZxacME/ujTLvaMAf8hpft+jbUjQh+FjSUsziLpf/ds7KBnf1FG
	 Mc8xahmuus64jiuJ+CPIyyqAAKPfc5V7HjSYtPxYgXH0SQoRn4F4hYkvRVbMpGy59o
	 qLdyhtEC1QZ2UAEHv7mpauqgaE41Cf/XQ3s3Mbb9/T488d1T4ytcLmynF7j2EQDpRv
	 qKipgUnx8EraMr+2paPYXIu0fkfYeK9RKZlqAyV54oET1RBInGNWdyu1lafq57/Kyz
	 SDisfqGYv9J8VaqVOTnCUB3moQdg7u7yfHNbvMMniowqdtqqQtmZABzfgdKkz10KT4
	 JANRLWOiOyGog==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        shuah@kernel.org, andrew.cooper3@citrix.com, sohil.mehta@intel.com,
        stable@vger.kernel.org
Subject: [PATCH v6 2/2] selftests/x86: Add a test to detect infinite SIGTRAP handler loop
Date: Mon,  9 Jun 2025 01:40:54 -0700
Message-ID: <20250609084054.2083189-3-xin@zytor.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609084054.2083189-1-xin@zytor.com>
References: <20250609084054.2083189-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When FRED is enabled, if the Trap Flag (TF) is set without an external
debugger attached, it can lead to an infinite loop in the SIGTRAP
handler.  To avoid this, the software event flag in the augmented SS
must be cleared, ensuring that no single-step trap remains pending when
ERETU completes.

This test checks for that specific scenario—verifying whether the kernel
correctly prevents an infinite SIGTRAP loop in this edge case when FRED
is enabled.

The test should _always_ pass with IDT event delivery, thus no need to
disable the test even when FRED is not enabled.

Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Cc: stable@vger.kernel.org
---

Changes in v6:
*) Replace a "sub $128, %rsp" with "add $-128, %rsp" (hpa).
*) Declared loop_count_on_same_ip inside sigtrap() (Sohil).
*) s/sigtrap/SIGTRAP (Sohil).

Changes in v5:
*) Do "sub $-128, %rsp" rather than "add $128, %rsp", which is more
   efficient in code size (hpa).
*) Add TB from Sohil.
*) Add Cc: stable@vger.kernel.org.

Changes in v4:
*) merge this selftest with its bug fix patch set (Dave Hansen).
*) Address review comments from Sohil.
---
 tools/testing/selftests/x86/Makefile       |   2 +-
 tools/testing/selftests/x86/sigtrap_loop.c | 101 +++++++++++++++++++++
 2 files changed, 102 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/x86/sigtrap_loop.c

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index f703fcfe9f7c..83148875a12c 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -12,7 +12,7 @@ CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh "$(CC)" trivial_program.c -no-pie)
 
 TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
 			check_initial_reg_state sigreturn iopl ioperm \
-			test_vsyscall mov_ss_trap \
+			test_vsyscall mov_ss_trap sigtrap_loop \
 			syscall_arg_fault fsgsbase_restore sigaltstack
 TARGETS_C_BOTHBITS += nx_stack
 TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
diff --git a/tools/testing/selftests/x86/sigtrap_loop.c b/tools/testing/selftests/x86/sigtrap_loop.c
new file mode 100644
index 000000000000..9d065479e89f
--- /dev/null
+++ b/tools/testing/selftests/x86/sigtrap_loop.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Intel Corporation
+ */
+#define _GNU_SOURCE
+
+#include <err.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ucontext.h>
+
+#ifdef __x86_64__
+# define REG_IP REG_RIP
+#else
+# define REG_IP REG_EIP
+#endif
+
+static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *), int flags)
+{
+	struct sigaction sa;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_sigaction = handler;
+	sa.sa_flags = SA_SIGINFO | flags;
+	sigemptyset(&sa.sa_mask);
+
+	if (sigaction(sig, &sa, 0))
+		err(1, "sigaction");
+
+	return;
+}
+
+static void sigtrap(int sig, siginfo_t *info, void *ctx_void)
+{
+	ucontext_t *ctx = (ucontext_t *)ctx_void;
+	static unsigned int loop_count_on_same_ip;
+	static unsigned long last_trap_ip;
+
+	if (last_trap_ip == ctx->uc_mcontext.gregs[REG_IP]) {
+		printf("\tTrapped at %016lx\n", last_trap_ip);
+
+		/*
+		 * If the same IP is hit more than 10 times in a row, it is
+		 * _considered_ an infinite loop.
+		 */
+		if (++loop_count_on_same_ip > 10) {
+			printf("[FAIL]\tDetected SIGTRAP infinite loop\n");
+			exit(1);
+		}
+
+		return;
+	}
+
+	loop_count_on_same_ip = 0;
+	last_trap_ip = ctx->uc_mcontext.gregs[REG_IP];
+	printf("\tTrapped at %016lx\n", last_trap_ip);
+}
+
+int main(int argc, char *argv[])
+{
+	sethandler(SIGTRAP, sigtrap, 0);
+
+	/*
+	 * Set the Trap Flag (TF) to single-step the test code, therefore to
+	 * trigger a SIGTRAP signal after each instruction until the TF is
+	 * cleared.
+	 *
+	 * Because the arithmetic flags are not significant here, the TF is
+	 * set by pushing 0x302 onto the stack and then popping it into the
+	 * flags register.
+	 *
+	 * Four instructions in the following asm code are executed with the
+	 * TF set, thus the SIGTRAP handler is expected to run four times.
+	 */
+	printf("[RUN]\tSIGTRAP infinite loop detection\n");
+	asm volatile(
+#ifdef __x86_64__
+		/*
+		 * Avoid clobbering the redzone
+		 *
+		 * Equivalent to "sub $128, %rsp", however -128 can be encoded
+		 * in a single byte immediate while 128 uses 4 bytes.
+		 */
+		"add $-128, %rsp\n\t"
+#endif
+		"push $0x302\n\t"
+		"popf\n\t"
+		"nop\n\t"
+		"nop\n\t"
+		"push $0x202\n\t"
+		"popf\n\t"
+#ifdef __x86_64__
+		"sub $-128, %rsp\n\t"
+#endif
+	);
+
+	printf("[OK]\tNo SIGTRAP infinite loop detected\n");
+	return 0;
+}
-- 
2.49.0


