Return-Path: <linux-kselftest+bounces-40550-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1D0B3FC37
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 12:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FCE82C3AD0
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 10:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5881C2F4A1A;
	Tue,  2 Sep 2025 10:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mu7jvmED"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29762283C8E;
	Tue,  2 Sep 2025 10:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756808561; cv=none; b=AfZfx4YVtcW7a748102FSNN+jsgfHRNOREQXLGPIgagzs77sSMj4nni49L0QbakFKqK+kdsam7v1Bu1NVxd68oDj56KAopVKWip5MFn5no0RGIW4w8mMi15st2T56QmCSsZOf0YgY47pK8/mARcK/sOHAV+DkPqiQovaYH7PYCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756808561; c=relaxed/simple;
	bh=CpY1ufLEWWNH3kGc/B+gDx5FfDuMHKHnHbWU0IDFJ7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QK7EnSsnReKi4KF2sV0R++JisV7UHgUmtun0LKmSE9EE9QxIHQ7OX13EN59gdJVEt/vhd5x5YaQeWUqqzS/v8IM38mCtl3rbjCYqBQ/YCxzSO1Nu1vGtBf9cmf3f7aDAbtebvxinLg6VT8/DK2UOBjUNRm/bhh2KpLT56aqHu14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mu7jvmED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F01C4CEF7;
	Tue,  2 Sep 2025 10:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756808560;
	bh=CpY1ufLEWWNH3kGc/B+gDx5FfDuMHKHnHbWU0IDFJ7U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mu7jvmEDAqUVNraGKOGKFf24OR0gvQtSe0fGuRX5j9Ey4ODF6FbTp9GmMC9Y2kNDM
	 RlVpLbDXUE37X83PtUTlGcShzegQsLo4b/fvSSTsBOPSaNqP91srzOAbT/yA2cXVq+
	 gG1JR7j7i3hGa2HrmPCkasU68mtasoaSVAWj2pZICT9n8+9ahabSgp9OIGTu4HvdHk
	 C+gluTv9fgr0fGvegiQsFzPZvHF6jWxphIYCZudcPPSVXim+zSckcLtAx6K2CFA/O1
	 DssX9vRM7OoEINgVWMW5tLYSU7M5oD5Fa7OIPBeGez4C1MJmBSzvIFjnuZGRdODQrb
	 AHiFChs8wOFng==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 02 Sep 2025 11:21:47 +0100
Subject: [PATCH v20 3/8] selftests: Provide helper header for shadow stack
 testing
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-clone3-shadow-stack-v20-3-4d9fff1c53e7@kernel.org>
References: <20250902-clone3-shadow-stack-v20-0-4d9fff1c53e7@kernel.org>
In-Reply-To: <20250902-clone3-shadow-stack-v20-0-4d9fff1c53e7@kernel.org>
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
 Andrew Morton <akpm@linux-foundation.org>, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Kees Cook <kees@kernel.org>, Kees Cook <kees@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=4438; i=broonie@kernel.org;
 h=from:subject:message-id; bh=CpY1ufLEWWNH3kGc/B+gDx5FfDuMHKHnHbWU0IDFJ7U=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBotsVVZT2WD/y3IfCbmqY92OOrwgvqXCu6iEUJq
 zOJeqgYzPWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaLbFVQAKCRAk1otyXVSH
 0ABlB/9zV9xiQUCdYYNkXE8DKdutIO1IkB1Wbm3nE+o6FG1JATl4bIwD30ZyYIP5K0XNL1+Kv7O
 AeqOYPBFeVJZYkEGsQnOp3DcVIdvbbahb47tum/yGDwgvLlinFpnSUOnN9hlayFohi/PaWSLBR4
 M288uXKFt9e2wzyAoXQk0Cysu4r6fNI+pDfvoTNWSqHX+zApOLkC6TnGSG3Qn9mtdRi+mEvgT7o
 xXW9f0GejdfdForjYppkT72VJOVgjRNZhmcCZTcIQn6x9wZNCFPv7UsB2w4J+4NjT8osalm5nrv
 Ku7IspQFG12iU8YWoZx8A9TZdprKAqsnH2Q06o1WOTGzWdEw
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
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
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


