Return-Path: <linux-kselftest+bounces-22770-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E50F69E2B3A
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 19:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56BF284EB1
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 18:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841501FECDC;
	Tue,  3 Dec 2024 18:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kx9/k09S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E9B1FDE14;
	Tue,  3 Dec 2024 18:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733251454; cv=none; b=olYPqkTUh9lPs347unmgfW12aMNR1Z1YjQbEp2OG0K7H+g2tPebq65ulG7ODmbopHPsiUF339MUAzuwHnGE8c7PpY/If6o4+xvWmtgyP9/uGWau3Tv+iIbPoV4T4Ce9zcs9eQnE7fA1cik9MIXd/1j56xVGkrRdxbIhl2CSSpgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733251454; c=relaxed/simple;
	bh=ZPECVt2iZI6cgmwzVsOfP4QoLnc65CaYS1gJJRUNbtE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SC2aAFtrpY2YKNaOoZFM7lf5fnteRMdjKdMg+9c0akpdvhN1fqG+GkEGoYkW1s7KkfSLqh71YRNXzTGCztUyE0s8PlhzkHvmPFB+e83kvxRf1dRo1msZl02MAFOsBrIw+kCD+mG9DUI/7CRbvuakdN8frK4Q3f/QsBmXCP4/pl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kx9/k09S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2850BC4CED9;
	Tue,  3 Dec 2024 18:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733251453;
	bh=ZPECVt2iZI6cgmwzVsOfP4QoLnc65CaYS1gJJRUNbtE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Kx9/k09SidkndvuTVwbQU2b+cKaPjXyzNTWHrgaELxKPLjmy3UVnNq2Otby9FLsn+
	 aTK07vtZ7Haeh6zRYrVFVW4xWmzEbEU1pYl7bj+9bYbTO/E1eknjex47vcYPyeTurl
	 o2lB7IlEe59VodSvzJlzmcIPvXEDhMuPIJnZhlEPNhUygZJMo1201s/1VpPHg/2N4U
	 WyoY0rzmPb6pf1LSMX0Fl25waR/mCfVWDaonRYj/scwbKMV4CV7rSHt34EoStJ3GKy
	 NRiBldOKwGbtsV85IuwWIH2i/miOHMm1tcjJHeu177YurtpwNF2zHvMxNYPCZ5Kcif
	 B2dcHEhzAhmMw==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 03 Dec 2024 18:43:37 +0000
Subject: [PATCH RFT v13 3/8] selftests: Provide helper header for shadow
 stack testing
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-clone3-shadow-stack-v13-3-93b89a81a5ed@kernel.org>
References: <20241203-clone3-shadow-stack-v13-0-93b89a81a5ed@kernel.org>
In-Reply-To: <20241203-clone3-shadow-stack-v13-0-93b89a81a5ed@kernel.org>
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
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=4486; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ZPECVt2iZI6cgmwzVsOfP4QoLnc65CaYS1gJJRUNbtE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnT1FgGcROajf3eQG6tXQixIhMspbNP2c3rMnLSxWL
 xsTbJ1mJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ09RYAAKCRAk1otyXVSH0FDZB/
 4lvH9otzinBbbGrm6Vl/BKTfBDIrO94WhDfO51ncpghBjiCJIy/aJ9gPsH8w+k+m3v4T/k+5cTAD8X
 U/Sg7nFNcmv9O9p51slKiOiIf1q9QYCuVwwSL7nODXyjc5UhatCx/UDqZQMkHXIgLn3PQuSmraWjlN
 chGP2TQhBvPoGAgS7f9Vli4iEtR0lQDRvStu3Pl68cgURwUeAlSA6lifOZK4duSCpwFNkwWnm5z23D
 yxvpewjyJt0CGUzhjZnp6NjZc0PC+w04JswHHx7F9DoBBc+w6MHiUFF16x9MK9gimLbJrol91odJxl
 2DeHDVJ9TmlQ9W/3sjdCQxslIzkwLg
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
index 0000000000000000000000000000000000000000..869ecea2bf3ea3d30cead9819d2b3a75f5397754
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
+static inline __attribute__((always_inline)) void enable_shadow_stack(void)
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
+	                                                                      \
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
+static inline __attribute__((always_inline))  void enable_shadow_stack(void)
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


