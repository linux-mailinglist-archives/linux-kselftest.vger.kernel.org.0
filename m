Return-Path: <linux-kselftest+bounces-12513-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCAB913A00
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jun 2024 13:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05541B20A75
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jun 2024 11:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A8112FB09;
	Sun, 23 Jun 2024 11:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SS73007s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6B112F5A0;
	Sun, 23 Jun 2024 11:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719141975; cv=none; b=UO3aQd8QDog4E+YyydbZIOcfTJxKG+hStkCWIUiXUP7WBT4G0C0aMkBSJwSQ9BhWTqLjK+LVl9Gk9tP1L/I1VOBIEEmMzWX19R85X01zr2sXWHIw6YvhtfsWEWYnkbWop/nTHgqa1BTiEbw4QHySAK08+M7bSrugmUYMD4r2BJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719141975; c=relaxed/simple;
	bh=vdpMp/+tnPvEc9LtWm/ZG/N3nxsEXfR9pkA/QLvguxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dMz3FmXyndalEqewVhhPL6JFYJDf6XhDnI0pEn6rqC4orksercEctdQKHzNlJgrByXNTuXV/nDHLCl5HQr4YLpXBa21nQ7vVN68QfhrPCShSK3oyLZ1BGzXx8Tl3lArcb9cJeiy3FncW8QHgqEbGV8SA7KsXyO8f7Gz11rhflQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SS73007s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E84AC2BD10;
	Sun, 23 Jun 2024 11:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719141975;
	bh=vdpMp/+tnPvEc9LtWm/ZG/N3nxsEXfR9pkA/QLvguxA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SS73007sXpGrFYgeeVqYMkqLQRsjqSpp+E5s13Nb4eFA3vCYoTVVAOe0zfZJXWorv
	 0IHFQs38qF5UHgj7aguVjZak4VrPElWXGuDEBJI0ljvYRvUvSMVMNG3B6N2JRO61l8
	 6HgadLv0NKBnmbQ7fGu/CEmSEW4jKC83nm/KQdH6SrPkbr5H9tNRIfSOuQfdTcZ4Sq
	 Lydmf7HnxosKUmSahC3qJCT+W1YcmNXPOFnZiYsg+7EzJNiWX/1woZb3KXLHO5Ykav
	 RU/RO9rFaivtRJnXYcAw+J8v+5462OgXvFtdE353abrFqUtjLy2kg40SxP+mphS7p1
	 Io+Fae55I3Vig==
From: Mark Brown <broonie@kernel.org>
Date: Sun, 23 Jun 2024 12:23:44 +0100
Subject: [PATCH RFT v6 2/9] selftests: Provide helper header for shadow
 stack testing
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240623-clone3-shadow-stack-v6-2-9ee7783b1fb9@kernel.org>
References: <20240623-clone3-shadow-stack-v6-0-9ee7783b1fb9@kernel.org>
In-Reply-To: <20240623-clone3-shadow-stack-v6-0-9ee7783b1fb9@kernel.org>
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
 Mel Gorman <mgorman@suse.de>, 
 Daniel Bristot de Oliveira <bristot@redhat.com>, 
 Valentin Schneider <vschneid@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, jannh@google.com, bsegall@google.com, 
 linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>
X-Mailer: b4 0.14-dev-d4707
X-Developer-Signature: v=1; a=openpgp-sha256; l=2590; i=broonie@kernel.org;
 h=from:subject:message-id; bh=vdpMp/+tnPvEc9LtWm/ZG/N3nxsEXfR9pkA/QLvguxA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmeAY/iyJ36oAkQ+01RwmYOsHL/R0DgvRMZuhj+hnp
 V5Y7qEeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZngGPwAKCRAk1otyXVSH0OnlB/
 9jHwEVByCzimHbnZtHu5Egj3RWJ/+NSl/rryKln0lQhh4oRNQo6KoalkNXkkg//lbRWS8oiccA2t5S
 6kFDwzI0WOHpoYLsx1NnP8DuyzvcWLCZQAbyy5Pgh6UTwE0yDCni/4thIbm6GpaVvOdey70t/qtC4f
 z9/14xn10BE4S278lOv+wEJmk7oQrrWOE3UdVf+ZUjk+fierSxM04vr3pYfne682+RkNyMNYGLFwbz
 Y4GqrGlkE96jm0pYLelp8jj7JL/9sL4Xdto7uyuM6itGUcC/iU8Z0so2UuzdExLlu/gTlw7EIdATdj
 y76x/CrpDWIhswQy/OBwnVLowAvKfp
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


