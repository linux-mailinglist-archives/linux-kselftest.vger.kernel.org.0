Return-Path: <linux-kselftest+bounces-25915-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 066CFA2A7AF
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 12:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4952188706B
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 11:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A97622DFAB;
	Thu,  6 Feb 2025 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGTIayha"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A9E22B8AA;
	Thu,  6 Feb 2025 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738842030; cv=none; b=FQCFKyG+lTnjA9qjFvciv1LLzuu5+fQjy4B2s3BMdaFE8d4pGWc/NuIHBzkUhiEy6jnw75Mkh7Bt2+dGOovtKS95btLkQcxedf0VYRDV/lbR+0JtdecV6CuEWhRpBM40pi2eEdHJv7AclFssJCQcxnfpynLdAK+LPQMwoulvFEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738842030; c=relaxed/simple;
	bh=fQK5XH8C8GoDpDyxe5Zvny2D7xuRYfaorJvH/8wiZ5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r260TdGMu9Q84EgUszc64IOkwutznf3V9DZroO6geRC2zKGWUiP42oRLTgReHGLLLpEWF6Lynjt/s44c8r2cLifCIAQZ/p6H010P3AooAKxmi8xFobNKPl7BiAFwG604OUK4ZlQGNO7Pf0r75OpWx/E4842YojEjXDTY+uCezvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGTIayha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C65C4CEE4;
	Thu,  6 Feb 2025 11:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738842029;
	bh=fQK5XH8C8GoDpDyxe5Zvny2D7xuRYfaorJvH/8wiZ5g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fGTIayhao0+pUbBJdwS0p7TJ6r8RHZzKLUUynu9KhQ4DuuXgR14mpBIvA4rF0aQ3+
	 /7X8J9Ga/BCsAIJ6ZnBte4uvu4Tc1MivvlZkqwDQGMYL3QDgoQY4uyg1Bh3rE+i968
	 bMR1fQ+oj08xY6zzJJPEnAXbyQQqIgZqv7Ec0YL7b9CIId41tDAokuKdb/RI7+BVoX
	 Xqd7th5vJiJJxFffwYIeymMa/46ekb0aSHt15gRbL481R9Gd+/K+SyJdPEVgnJKAXW
	 AGfCDiSq940HPXmeGsQYlZlFMJc7RL02KlElWJHRU4mvyvQY+L2pJ+s7rKUkjFjYf7
	 afopt4ODP5YWQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 06 Feb 2025 11:38:05 +0000
Subject: [PATCH RFT v14 3/8] selftests: Provide helper header for shadow
 stack testing
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-clone3-shadow-stack-v14-3-805b53af73b9@kernel.org>
References: <20250206-clone3-shadow-stack-v14-0-805b53af73b9@kernel.org>
In-Reply-To: <20250206-clone3-shadow-stack-v14-0-805b53af73b9@kernel.org>
To: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, 
 "H.J. Lu" <hjl.tools@gmail.com>, Florian Weimer <fweimer@redhat.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, jannh@google.com, bsegall@google.com, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Kees Cook <kees@kernel.org>, Kees Cook <kees@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=4385; i=broonie@kernel.org;
 h=from:subject:message-id; bh=fQK5XH8C8GoDpDyxe5Zvny2D7xuRYfaorJvH/8wiZ5g=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnpJ+QqLzkhMk9wJVDSdypTpZJiYNDyxZAPD2Vu5qu
 AwrqWl6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ6SfkAAKCRAk1otyXVSH0Hr0B/
 sFYerhT/fkohPBpkFRsLBB6nxSmT55jUny8/5FrB1EobVG42lsu/+69aDl9feDQ24pEiorfMvdT5tD
 NGnc2iFYCmLyiE/pSQ9kshZCmePKi7s1dYxA1JghItymqNfIhmMrFLhVp2CGj12aXqH14Fipmh8tKS
 4dgrdK/u9Axa3WpecRbXWDW1oTg7ZWK6fQJIYL7ycrwy9B6akgLUS8rzbZsRv1WkouGD5hhApBdViQ
 zogQDGC9RrNydH2WOVjBxi6Otl/pAl4fXfxpk5AlVpfbMydUCE3W1vJt8mJMNqcpuTe+60S7AEMjH4
 2tTIssmDuyzKMKmsayTmvbp1MvKMdO
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

While almost all users of shadow stacks should be relying on the dynamic
linker and libc to enable the feature there are several low level test
programs where it is useful to enable without any libc support, allowing
testing without full system enablement. This low level testing is helpful
during bringup of the support itself, and also in enabling coverage by
automated testing without needing all system components in the target root
filesystems to have enablement.

Provide a header with helpers for this purpose, intended for use only by
test programs directly exercising shadow stack interfaces.

Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Kees Cook <kees@kernel.org>
Tested-by: Kees Cook <kees@kernel.org>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/ksft_shstk.h | 98 ++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/tools/testing/selftests/ksft_shstk.h b/tools/testing/selftests/ksft_shstk.h
new file mode 100644
index 0000000000000000000000000000000000000000..fecf91218ea51edd30c220d4d94e5814e2d69c9e
--- /dev/null
+++ b/tools/testing/selftests/ksft_shstk.h
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Helpers for shadow stack enablement, this is intended to only be
+ * used by low level test programs directly exercising interfaces for
+ * working with shadow stacks.
+ *
+ * Copyright (C) 2024 ARM Ltd.
+ */
+
+#ifndef __KSFT_SHSTK_H
+#define __KSFT_SHSTK_H
+
+#include <asm/mman.h>
+
+/* This is currently only defined for x86 */
+#ifndef SHADOW_STACK_SET_TOKEN
+#define SHADOW_STACK_SET_TOKEN (1ULL << 0)
+#endif
+
+static bool shadow_stack_enabled;
+
+#ifdef __x86_64__
+#define ARCH_SHSTK_ENABLE	0x5001
+#define ARCH_SHSTK_SHSTK	(1ULL <<  0)
+
+#define ARCH_PRCTL(arg1, arg2)					\
+({								\
+	long _ret;						\
+	register long _num  asm("eax") = __NR_arch_prctl;	\
+	register long _arg1 asm("rdi") = (long)(arg1);		\
+	register long _arg2 asm("rsi") = (long)(arg2);		\
+								\
+	asm volatile (						\
+		"syscall\n"					\
+		: "=a"(_ret)					\
+		: "r"(_arg1), "r"(_arg2),			\
+		  "0"(_num)					\
+		: "rcx", "r11", "memory", "cc"			\
+	);							\
+	_ret;							\
+})
+
+#define ENABLE_SHADOW_STACK
+static __always_inline void enable_shadow_stack(void)
+{
+	int ret = ARCH_PRCTL(ARCH_SHSTK_ENABLE, ARCH_SHSTK_SHSTK);
+	if (ret == 0)
+		shadow_stack_enabled = true;
+}
+
+#endif
+
+#ifdef __aarch64__
+#define PR_SET_SHADOW_STACK_STATUS      75
+# define PR_SHADOW_STACK_ENABLE         (1UL << 0)
+
+#define my_syscall2(num, arg1, arg2)                                          \
+({                                                                            \
+	register long _num  __asm__ ("x8") = (num);                           \
+	register long _arg1 __asm__ ("x0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("x1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("x2") = 0;                               \
+	register long _arg4 __asm__ ("x3") = 0;                               \
+	register long _arg5 __asm__ ("x4") = 0;                               \
+									      \
+	__asm__  volatile (                                                   \
+		"svc #0\n"                                                    \
+		: "=r"(_arg1)                                                 \
+		: "r"(_arg1), "r"(_arg2),                                     \
+		  "r"(_arg3), "r"(_arg4),                                     \
+		  "r"(_arg5), "r"(_num)					      \
+		: "memory", "cc"                                              \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+#define ENABLE_SHADOW_STACK
+static __always_inline void enable_shadow_stack(void)
+{
+	int ret;
+
+	ret = my_syscall2(__NR_prctl, PR_SET_SHADOW_STACK_STATUS,
+			  PR_SHADOW_STACK_ENABLE);
+	if (ret == 0)
+		shadow_stack_enabled = true;
+}
+
+#endif
+
+#ifndef __NR_map_shadow_stack
+#define __NR_map_shadow_stack 453
+#endif
+
+#ifndef ENABLE_SHADOW_STACK
+static inline void enable_shadow_stack(void) { }
+#endif
+
+#endif

-- 
2.39.5


