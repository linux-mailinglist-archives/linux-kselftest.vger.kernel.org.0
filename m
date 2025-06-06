Return-Path: <linux-kselftest+bounces-34424-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07364AD07B0
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Jun 2025 19:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A1D13A68F3
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Jun 2025 17:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15621C8621;
	Fri,  6 Jun 2025 17:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="wL/RJ5Du"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213C22CA6;
	Fri,  6 Jun 2025 17:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749231965; cv=none; b=GV4NH9AfB7o6pCWMm5DH/nO8YyGC/UVJQzZHQ/+aGyUkdZ7BblzOe/ukT21lOXC3/1ljsdd4MqAPcsrVL6Mo52J8casLvGWRAohr+wVt1deMS6NV9AjvX2iFeYNtZQUlbBd7ds75RvMh9G37/d0DsoOS/9Qsvy7jHC5/Z+3s2j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749231965; c=relaxed/simple;
	bh=Xpw4mWSOO7kejGU+gJhqwieNSFJdgh8TBFqeDX3BoWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oLXWydqCOJ7c0Pos9m4wjZybwhGXaGZGcf0MMzbrakJsLLckFpentBV9AC3MLr8JYevVicWg7Zgec0gcP3gIX1rm98eIswUfI1lCgDXOOKe5Uu7OnkobZ+g/bNAxH/CLznsq6KK0wr0DcIPPr8MTa4oep9FbLA01zVEQj8AD6EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=wL/RJ5Du; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 556HjTFr1004770
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 6 Jun 2025 10:45:34 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 556HjTFr1004770
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025052101; t=1749231935;
	bh=kCy/xiNsp62Fz2xwI9lC/MHqUS8hAxK1tf4Y5NVC7uE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wL/RJ5DuMB5upfqEbHEcxEzoFaisK14ElcReYKSwVKh0t3jOcM8ATdrNBNM/Wqhgc
	 B/jNbFRiaUrMSedwNcjQwqbgSt5DYVO7ffXMeCm65/0rtuJXgyU4Z34L+m/4/qvsBB
	 G1SV2oPwO3D/cbZ+wO1GRpy2+PmuIctz+CzhXXw0YpgHnp5wXv6A/YxSrzmgW+BFlC
	 6vSYV3bD7Jfgd0xlQiXuqM5m3DhS5awm2CFeZShtHhOZUUCPRqnIyaQGmDeIvlZugP
	 zCwjiStk1hRlVWGVm+tFUf9i+kpLO4O/bD7ZSc//T0h6WZIIXa8Y5/OYqEJcUhdX+p
	 ujSTxPRS7iCcA==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        shuah@kernel.org, andrew.cooper3@citrix.com, sohil.mehta@intel.com,
        stable@vger.kernel.org
Subject: [PATCH v5 2/2] selftests/x86: Add a test to detect infinite sigtrap handler loop
Date: Fri,  6 Jun 2025 10:45:28 -0700
Message-ID: <20250606174528.1004756-3-xin@zytor.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606174528.1004756-1-xin@zytor.com>
References: <20250606174528.1004756-1-xin@zytor.com>
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

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Cc: stable@vger.kernel.org
---

Changes in v5:
*) Do "sub $-128, %rsp" rather than "add $128, %rsp", which is more
   efficient in code size (hpa).
*) Add TB from Sohil.
*) Add Cc: stable@vger.kernel.org.

Changes in v4:
*) merge this selftest with its bug fix patch set (Dave Hansen).
*) Address review comments from Sohil.
---
 tools/testing/selftests/x86/Makefile       |  2 +-
 tools/testing/selftests/x86/sigtrap_loop.c | 98 ++++++++++++++++++++++
 2 files changed, 99 insertions(+), 1 deletion(-)
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
index 000000000000..9eecf32c79c2
--- /dev/null
+++ b/tools/testing/selftests/x86/sigtrap_loop.c
@@ -0,0 +1,98 @@
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
+static unsigned int loop_count_on_same_ip;
+
+static void sigtrap(int sig, siginfo_t *info, void *ctx_void)
+{
+	ucontext_t *ctx = (ucontext_t *)ctx_void;
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
+			printf("[FAIL]\tDetected sigtrap infinite loop\n");
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
+	printf("[RUN]\tsigtrap infinite loop detection\n");
+	asm volatile(
+#ifdef __x86_64__
+		/* Avoid clobbering the redzone */
+		"sub $128, %rsp\n\t"
+#endif
+		"push $0x302\n\t"
+		"popf\n\t"
+		"nop\n\t"
+		"nop\n\t"
+		"push $0x202\n\t"
+		"popf\n\t"
+#ifdef __x86_64__
+		/* Equivalent to "add $128, %rsp" with 3 fewer bytes in encoding */
+		"sub $-128, %rsp\n\t"
+#endif
+	);
+
+	printf("[OK]\tNo sigtrap infinite loop detected\n");
+	return 0;
+}
-- 
2.49.0


