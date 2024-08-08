Return-Path: <linux-kselftest+bounces-15011-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C95C694B8C3
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 10:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 820D0280A6A
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 08:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9487F18953B;
	Thu,  8 Aug 2024 08:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDQIY0VC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652A414430E;
	Thu,  8 Aug 2024 08:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723105006; cv=none; b=mbedpxhxj4tp1DrAHRQ+KTUUV7KaBEedCdgv1YVXTwue4y8xy1Yc1bamkC80TX+ao6iTPMc4KNVQKSZSyrRjUn1MaO79c/k1TffD4hA58bsoAKggiGGtascdjnF2lNGgLmAPRlF2FOt+dyrc4q0RAVJzrm1E7PnTsdSBi3fLvr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723105006; c=relaxed/simple;
	bh=vdpMp/+tnPvEc9LtWm/ZG/N3nxsEXfR9pkA/QLvguxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n+Scvn16xeWwS+h1z2m3wQNbMWTdEpnZ2aShRVbaS0H9y1cALm/1ghumiAQFWf8awyVpBNyZrnWpTZIdO6oWLJMvDO57Mpb/FF/1JNCP5Ub/fnDTmxXIxuF8nVzHbny7fLgfybnLQthSX8wt/racCnL7B26D6UYUxQOla/E7/Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDQIY0VC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3F0C32782;
	Thu,  8 Aug 2024 08:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723105006;
	bh=vdpMp/+tnPvEc9LtWm/ZG/N3nxsEXfR9pkA/QLvguxA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dDQIY0VClHUq8XtnbsNGmSdwpxzM9Qk8R5bmNDmSNBzyiJZpv+LYk7ADjBciqtgxv
	 xTE7xMXTnEUkwFODvBVhLhCbzfrB0CoaBvO9zdf6e36LQKgxZ8/DV9hdiFVC/hMPwu
	 u06AGru/QxRpXPCePmdDcyV3AGLvmQOgi+K+nPGEtpFK04jl2Y9u6qz0LAero3dHeZ
	 hOAIPdhreh4h4Xuf551W+Yt310xWABnDMoXcimlv+kJpId30sb95KqpXYd6MMGOcP1
	 5W1ZiGVJb8eCFyYs7lL0q3Ob7ENzfrqp75m9DEfGn75PvU1aJExgWVNvxN0gk19fhk
	 SMCC8S+jlpebA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 08 Aug 2024 09:15:23 +0100
Subject: [PATCH RFT v8 2/9] selftests: Provide helper header for shadow
 stack testing
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-clone3-shadow-stack-v8-2-0acf37caf14c@kernel.org>
References: <20240808-clone3-shadow-stack-v8-0-0acf37caf14c@kernel.org>
In-Reply-To: <20240808-clone3-shadow-stack-v8-0-0acf37caf14c@kernel.org>
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
 linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=2590; i=broonie@kernel.org;
 h=from:subject:message-id; bh=vdpMp/+tnPvEc9LtWm/ZG/N3nxsEXfR9pkA/QLvguxA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmtH7I20NyIlGU3wtphj3HE7SlF3ffRGlOk8RvT
 ON2TtJPxGGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZrR+yAAKCRAk1otyXVSH
 0CIwB/9uuSLGMZ8zaQT0kRE+2R3E1sTZIcPsdg98kHVxLAHhuhghaSL6bKqz/kIw08kNMIMCs1K
 mJ7ly8vfEeLle7yQitttGbSm9/vZfUjXQJ5DKsPp1my/wy3in42tzD3PfjymI7fkTEE16DU7XWb
 hpf9SOyz0G758YunBvxgYAUD8UK0OnKuBaJ/b564khO6frRT+EhhubsTnWg9qbEjSWnsHJMUTyG
 v7cuqEBbTvzEMMdoZuP+2n4sMsiQq01zLys3ToKHGa8uMqqQSlCqTsqsSRF9vZz2yU/mCsjBie2
 vAQdoo2nfNua7CouxR0hHh6pVxREg2UGSzcxC3S3fzSiTFBP
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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/ksft_shstk.h | 63 ++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/tools/testing/selftests/ksft_shstk.h b/tools/testing/selftests/ksft_shstk.h
new file mode 100644
index 000000000000..85d0747c1802
--- /dev/null
+++ b/tools/testing/selftests/ksft_shstk.h
@@ -0,0 +1,63 @@
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
+#ifndef __NR_map_shadow_stack
+#define __NR_map_shadow_stack 453
+#endif
+
+#ifndef ENABLE_SHADOW_STACK
+static inline void enable_shadow_stack(void) { }
+#endif
+
+#endif
+
+

-- 
2.39.2


