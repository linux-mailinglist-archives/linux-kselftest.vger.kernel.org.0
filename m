Return-Path: <linux-kselftest+bounces-30920-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A322A8AC29
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 01:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507CC443ADF
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 23:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0B02D8DC7;
	Tue, 15 Apr 2025 23:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXiqJekN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F492291153;
	Tue, 15 Apr 2025 23:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744759923; cv=none; b=S5EisZ6XULyo8s+PEJqQeXnHYF6fQD8d5w+XCw+JR/gvRjooP+kMYwOQ5aWcmxx3UfVVcR5f8tSmdUKoCbgHxJsfiRZwmbD4QcP2qsuJi5DwHVYyjy91CITDx8AYdFd+RyI8TFjMwiHVxVCMynwLeFBqzRjtwB8pLBiaEQfWgHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744759923; c=relaxed/simple;
	bh=8PwV5sD24lytiIg6Et3XNYcReWmnPu0HQVBivsfh4Ks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jgfrhJykR04AuPdruJh3Z9fEPBMN0L21EYIf698elX98z1SsxGVJ1Z22RnwmMeeoxh6/qeiivdDiAxbaq3HdCSIXN+IWMc623wooxp8r5hLEqCMVgb1wgm9keLp3zjbjdMpDFRWx7XUScove40DTI2F3L8E5Lsqyk1GXo6bfxTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXiqJekN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC1EC4CEEE;
	Tue, 15 Apr 2025 23:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744759922;
	bh=8PwV5sD24lytiIg6Et3XNYcReWmnPu0HQVBivsfh4Ks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OXiqJekNkSGcdXpOGmWEALg+RuvExMoB/vV+UeyYYKqP37Wfz1CUfVFdVMUQnYikd
	 PMiQss8ChhvuAsncQZT3Ctrc6UnOj5R3FDS4XD3Qa1ZIEPRSVN51U6NEtP1yl/IrZ3
	 5/9QNmwghLIfNl+p845KMuYFN4P7rC2zPrX7ZFsChJsiedd0zo6HgkK4wVMU7eocUO
	 m+DHbDYZc231rXi+QaKJFvmO4+naZtjKVyaWkcvdA9n6R55X1LZx2KQqUYgQFzrRYu
	 xR0avWaAgxEds0ZIdYNzz2QxkZCuicNxLtCFsttQY3xIgdrF0/MxXw2/3QTrfqUG9C
	 iX6UHOX+fgvDw==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 16 Apr 2025 00:31:10 +0100
Subject: [PATCH RFT v16 3/8] selftests: Provide helper header for shadow
 stack testing
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-clone3-shadow-stack-v16-3-2ffc9ca3917b@kernel.org>
References: <20250416-clone3-shadow-stack-v16-0-2ffc9ca3917b@kernel.org>
In-Reply-To: <20250416-clone3-shadow-stack-v16-0-2ffc9ca3917b@kernel.org>
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
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4329; i=broonie@kernel.org;
 h=from:subject:message-id; bh=8PwV5sD24lytiIg6Et3XNYcReWmnPu0HQVBivsfh4Ks=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBn/uxWtJwRP7IGOkbGqGHk+rcmXUdvmFAu7j7ZTlDK
 1f+Bb0mJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ/7sVgAKCRAk1otyXVSH0K0CB/
 9orpp8hxzkiuk8iqPtByll0OjDkgwzbs3v1yDZ8hmRMeaFEtrGNW8JLPCVNgLZ/UEf62Vej1PRzqvd
 yRPOzJNLyzOFdTAoC3tNd4TrdytBN7zhK+jmQaNWib6y/KL5/yM644nIg7F66p7MU8j1Ce5c3vg+nb
 KImeiVhwL1cP4E/FbJsfpwMzMwwDKaj82usmqQpHCZAX9qEA/A3KH3F59R5MIBgiJI9+uex7qn0Jq9
 Xy3qlYdG04cHWaKtyvMQ/lo9Ro7+zEValwTs27xbmM8BtrUzN0ReX4hj/WwPjmj4KXJ02Ca/z8hT/h
 jkiw59IR+JJgp5o8hphRP5VOCxhiBN
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
index 000000000000..fecf91218ea5
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


