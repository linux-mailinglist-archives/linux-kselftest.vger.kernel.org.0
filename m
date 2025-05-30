Return-Path: <linux-kselftest+bounces-34095-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0BAAC97FF
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 May 2025 01:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6081117FED1
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 23:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43ACA28C2CE;
	Fri, 30 May 2025 23:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Pzlztozu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9961D63D8;
	Fri, 30 May 2025 23:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748646486; cv=none; b=EB9jP1fEVXxK4n6f2NhgtwLjGguA8LtK05yAHggiAO1sVNvog/9+PKjwmfnjIOX/VY7hNAKYpZx/LYEokt6Uel6ztZu7Yn23XUMisFaL0TtlbWaBusdyWzI9e3rFUFMoJOQo7UZBnjHCcP5FIMoXSyIElRNkrlbQSTwO+nw9ZiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748646486; c=relaxed/simple;
	bh=9HPEh+Br1rzEf9lU6sCptTm9+D/VZfrB2D8TQBsTKUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F/PNii94LwwtAAHDhy0539ItF3Sfirp0uvnBBpOMcis+mLVPLPa1u1LJjN+gh2V9wEp0085ORRV1S+87f4BEAeGRhNKhKAXJP0m0Dt2KSneGqyHghM7cw+oM+rm5IqCKviNNJ5i1oVJIqgDaDr31DbVm4av4d2nLrsBc1QXhV38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Pzlztozu; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 54UN77JC2528926
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 30 May 2025 16:07:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 54UN77JC2528926
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025052101; t=1748646431;
	bh=HfZD7U9L2RUtUR5Z5tSj8MTtW/oWribwJyC+zC4yD4M=;
	h=From:To:Cc:Subject:Date:From;
	b=Pzlztozu2JYvdVdyR8bDgrTaTQ3bHFjq1fh0FRoU9qYcMaXT/k+REtSVI6jWRtDN2
	 WWXBYbyBiZnH1RU0ARtC8E/woDei8fQ4g28b9uTwVxJo5W9viAhLv5vLx1g9lkbd9m
	 uVMD5J+FAyJtRPqQCfkPzH3qALTuceb1sZpKxFSMUAIMkVbU0+/i3YQ5PPuCsTJRkf
	 pN0mlrxxvzhzJS04zhVhDpv3YoksWk6DhnpYDkH7XSZ5OtTqTghYhXp2kZbIjAUbvm
	 uCa5LmXcygNw0NYCNt8Arls/LY/dBfPE7fGCW+U1a8YeExNbL834AtptwzatoW9kPr
	 lXU7P6gLqBVzA==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        shuah@kernel.org, andrew.cooper3@citrix.com
Subject: [PATCH v1 1/1] selftests/x86: Add a test to detect infinite sigtrap handler loop
Date: Fri, 30 May 2025 16:07:07 -0700
Message-ID: <20250530230707.2528916-1-xin@zytor.com>
X-Mailer: git-send-email 2.49.0
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
correctly prevents an infinite SIGTRAP loop in this edge case.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 tools/testing/selftests/x86/Makefile          |  2 +-
 .../selftests/x86/test_sigtrap_handler.c      | 80 +++++++++++++++++++
 2 files changed, 81 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/x86/test_sigtrap_handler.c

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index f703fcfe9f7c..c486fd88ebb1 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -12,7 +12,7 @@ CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh "$(CC)" trivial_program.c -no-pie)
 
 TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
 			check_initial_reg_state sigreturn iopl ioperm \
-			test_vsyscall mov_ss_trap \
+			test_vsyscall mov_ss_trap test_sigtrap_handler \
 			syscall_arg_fault fsgsbase_restore sigaltstack
 TARGETS_C_BOTHBITS += nx_stack
 TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
diff --git a/tools/testing/selftests/x86/test_sigtrap_handler.c b/tools/testing/selftests/x86/test_sigtrap_handler.c
new file mode 100644
index 000000000000..9c5c2cf0cf88
--- /dev/null
+++ b/tools/testing/selftests/x86/test_sigtrap_handler.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  Copyright (C) 2025 Intel Corporation
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
+		printf("trapped on %016lx\n", last_trap_ip);
+
+		if (++loop_count_on_same_ip > 10) {
+			printf("trap loop detected, test failed\n");
+			exit(2);
+		}
+
+		return;
+	}
+
+	loop_count_on_same_ip = 0;
+	last_trap_ip = ctx->uc_mcontext.gregs[REG_IP];
+	printf("trapped on %016lx\n", last_trap_ip);
+}
+
+int main(int argc, char *argv[])
+{
+	sethandler(SIGTRAP, sigtrap, 0);
+
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
+		"add $128, %rsp\n\t"
+#endif
+	);
+
+	printf("test passed\n");
+	return 0;
+}

base-commit: 485d11d84a2452ac16466cc7ae041c93d38929bc
-- 
2.49.0


