Return-Path: <linux-kselftest+bounces-4059-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E880847D76
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Feb 2024 01:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 681611F218F9
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Feb 2024 00:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B491388;
	Sat,  3 Feb 2024 00:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rc8YHIgG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14460538D;
	Sat,  3 Feb 2024 00:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706918737; cv=none; b=Yt0PBukC9WFGvLRKsS2v6oZIXFtI3iEulvNBdELlIJD9/jgcLh4pyzeei3bc5XgXWtKJcsFZOHi6RL9D0odjLIYdbk2KT1xaoPoviyiOTuqtnaLZob0knH+0yh8a4zKB/6PzHXAyrKwz3sd+BTQjEwj8J7iRkaRZWX4LsKZwvK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706918737; c=relaxed/simple;
	bh=CucuMui4D2UywYMkY4QvFT3PXHDtuX4p82gJW7uHGUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZcRzjMYJgri78UX5H8nq9I6rsYg84KvadjdvVbU2It8MWfpc+VMBZdl8I36rb9KlpjhwC13r+DdlMT2zXQhfoW1aDQjg2xWThdiUdNXoDe3d+yeH8VlXyUgnrDfkXckvILY0zMfecSfVDZiLRBkjArG7tTP/vwU+PBA9lA5kynQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rc8YHIgG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4717C433B2;
	Sat,  3 Feb 2024 00:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706918736;
	bh=CucuMui4D2UywYMkY4QvFT3PXHDtuX4p82gJW7uHGUw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rc8YHIgGmt3wOb/Joq6gRhlKp+Wmv3UhiJJKB6CMYX6xon6hoPtksJ6gHmhJIF3v/
	 0i+yP2irL0QWfD/KhjdpFfyzQ/AZRR3UOLMLN3t5ranMSazDmRnHK7ecYEZpLXSU6M
	 R3AuGfNWkMw1Bguiwbuz/QYzGlmoFLYVdVp9MCAiODwLPKcRz9465tiZv3pLDIiDf4
	 zAOEkQSmIdfM6Kd/kIkt6t9WEdbnEZ5Pco3Q8/CWLoAH0w+ZlO5rrtIftA1RRtC8Pg
	 kJJnw0c04imrYu8ZyabBUAnox+vJJMJqZJohXy8JmjHbhNuUFicAqOMSzXlUcD2otB
	 83tegOSPLZMPQ==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 03 Feb 2024 00:04:58 +0000
Subject: [PATCH RFT v5 2/7] selftests: Provide helper header for shadow
 stack testing
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-clone3-shadow-stack-v5-2-322c69598e4b@kernel.org>
References: <20240203-clone3-shadow-stack-v5-0-322c69598e4b@kernel.org>
In-Reply-To: <20240203-clone3-shadow-stack-v5-0-322c69598e4b@kernel.org>
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
 Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>, 
 jannh@google.com, bsegall@google.com, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2532; i=broonie@kernel.org;
 h=from:subject:message-id; bh=CucuMui4D2UywYMkY4QvFT3PXHDtuX4p82gJW7uHGUw=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhtS9zZYPtCb2voqeGvNkGePn0nauE0o6L+o6O+Z9teqMZJGa
 t9Gtk9GYhYGRi0FWTJFl7bOMVenhElvnP5r/CmYQKxPIFAYuTgGYyPML7P9UbzaHdov8EHj+u7o3sE
 KttXrrdV6LNKOuGKOiuVEvVlQWeV5f7O22g7/jDfeKG39YFK82ZC2K8n1leTCvfbvWw+DJeuzyMxlT
 QrQ0DQ9VnjebujWixHVmmDw3v3rC0vcuEws+701IPNR+/97TcC9l1gn14pcDpMwnX9a9OKe0PJ+h4o
 WjtcZCmQqnQ3E/twc5fX9VEPrUSH7KJ5n5PmarVnNaBfy991ze4uPi5W4WrArSr7csEUjODzywSDyU
 e0JHTs6m59PL2otCVbhNlD/tTPxza3aj6qHnyyeYe3UV3ztWWF+TsZtD0bP3Rvm5tBP+IjP4hNZ562
 lOVbddahG2sCvgQqmLoecnu5+WAA==
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
2.30.2


