Return-Path: <linux-kselftest+bounces-15912-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 598EB95A571
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 21:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 029231F22E72
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 19:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F196C16F0EF;
	Wed, 21 Aug 2024 19:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldLXIqEf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C542916F0DD;
	Wed, 21 Aug 2024 19:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724269838; cv=none; b=bdoYS6EujNU0XQj6FnA1xlriXwYM7RbPOJv29m+Rlwet7wJIuvTQ4P1azbmL1ec0PUVRXi2jUV3ixzuCAOY4DY6o3y09XeMML/uic+CaZoX6wRt0M6EkXIX8CaU8/9zFooV2XXUPXwKxHVl6gaLqNVD3hTQGizOGjfvxHFGVw90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724269838; c=relaxed/simple;
	bh=CV2+00DiKA+Ule1vDQG713YKkv7EqZ8uZ0vdFPGcS/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mc34pUEEfG7DwJ5e7BLAn/s6aL+/IdNZqdN9bo2QOUQcb7wdmzDWR6e7axU64wxHQ5LV5eyoyFDyeC58JD8/xJaWDzlPfF6Vr8AKhGlZN8l9vxvXZOPVqHJUJ1q6Lpc3B6JkvvF06HecqM4PyWqapXSghKEealSl3cRJVgPMGSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldLXIqEf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37B7C32781;
	Wed, 21 Aug 2024 19:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724269838;
	bh=CV2+00DiKA+Ule1vDQG713YKkv7EqZ8uZ0vdFPGcS/o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ldLXIqEfiKw4EQx7ZdZC48wt1Ginlpxv8vijM39iyjOuTaGCOUHd14h8w4f7ulrzE
	 86LB2+gycMyfoNR56uOUDAB1gtNzjbobqz8XIi4TXJEBOs/NZU0ZMHTRqMpPLx4+1P
	 jOEMQvIkq3TNZfckMG466biZJyCqZKX+kdU92q8EN8p/1EKpFCAADOehyngNDy475/
	 LN39u/jk7NbwAImgJYRzfQtyfia0vLtksAYplSrzq6qTD5GBJWE2LaUUWt0+jmM6/n
	 LY/2Xe2fl4E5FZLHuFopvfim/D+QxV9FYJXX9/7ngO4gH1Zng7a2h8Z8LHrQj069m0
	 FQ7rU47hsmLtw==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 21 Aug 2024 20:49:48 +0100
Subject: [PATCH RFT v10 2/8] selftests: Provide helper header for shadow
 stack testing
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240821-clone3-shadow-stack-v10-2-06e8797b9445@kernel.org>
References: <20240821-clone3-shadow-stack-v10-0-06e8797b9445@kernel.org>
In-Reply-To: <20240821-clone3-shadow-stack-v10-0-06e8797b9445@kernel.org>
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
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=2716; i=broonie@kernel.org;
 h=from:subject:message-id; bh=CV2+00DiKA+Ule1vDQG713YKkv7EqZ8uZ0vdFPGcS/o=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmxkT0pYB9su/KXi9puOsHeeGTRutBYq8powu/m0SH
 3B9996SJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZsZE9AAKCRAk1otyXVSH0LzrB/
 9xo8T67P5tfCTZ4/CrB7b8Otm4J98+sOlwDD9pQnVdymc8sPnMKSwft0M+axn8J5Z+rFSvJiI0Lixc
 MhFarbIgTCItA9SZHgcpAochhUGPpBQl2utbtw5nZlaL8aM4/t7fjiRcd1GtA/ihP0Xp49OozGzLPR
 /0r12IZ/Ip3zWA1fmCHXCamd3VpbFrdMQDXtcm999FGi3e6wAbOQauRplvlM2mmnBx95KyzhQmdc7W
 /k0SRHGb5Dw1bKjzh6FNwyy0sU5r0PKQQwaNzuJSUE8z6U5gxewftmmLbgm5TAFSNKmgsxC+C3oiK9
 8EEGcMxYyfaJOf4eLN9KMqAkL9UhBz
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
 tools/testing/selftests/ksft_shstk.h | 61 ++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/tools/testing/selftests/ksft_shstk.h b/tools/testing/selftests/ksft_shstk.h
new file mode 100644
index 000000000000..09f822b976e1
--- /dev/null
+++ b/tools/testing/selftests/ksft_shstk.h
@@ -0,0 +1,61 @@
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

-- 
2.39.2


