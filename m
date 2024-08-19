Return-Path: <linux-kselftest+bounces-15691-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF05D95745C
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 21:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7249D1F23C8F
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 19:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C420B1DC464;
	Mon, 19 Aug 2024 19:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obVteLeR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933541DC460;
	Mon, 19 Aug 2024 19:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724095580; cv=none; b=Deo5XHeB1u3p4Gw5Jzy9nmJKaukAKKqpAig1SHeqZsM5zfdd3EZnZ1xhiUyVuVuQqU65IAueJAH1lwJMlDVLs5b6gy3uvqo+uHgu2fn2ZSSUP69MzbCRL59vLKeENDt7G5LmfoerRgVvqn1lQGFdVM8TexJqTojLioIqM4B2Yhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724095580; c=relaxed/simple;
	bh=Lqc0aeXK2Sje7x0iWLcH10niGKrB2vEXzwnzDeVxcmI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K2IpSlZzeuOSEc8gC7+tQI3VWmb8HZldmfnYhvM59Ct01Kow3RvLcLlZYPKDGkPpLvqqgWYSRFPtTxm2Akcttcgftx+1GKpbVA9gUINNCvi6+TjuH4EK6vZqMFklbdr4UWwWmkD5msE8yPurFL39qc93O07ralMK3R6afo6Pw6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obVteLeR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED8DC4AF11;
	Mon, 19 Aug 2024 19:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724095580;
	bh=Lqc0aeXK2Sje7x0iWLcH10niGKrB2vEXzwnzDeVxcmI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=obVteLeR82Cbh93xRjPXJ/xQ7Pyy3moJcsPKo34kRZMYbC7llmgU2M2oHW0a4Nscj
	 moWrXHTn2xyQhPtDlW+zvu4p36aIhR15MGoMsXahVBU9RXkn8QlUE9juZoKygZoGkL
	 Yq13FSMFIuYj4le+EYleCkB7r1plNaZvc1VSYmgKXxcDfVJnc+u26gyN98fH4OCtPF
	 n0Krt3sWt9DUui9IbnYQtduTscWJNW48RKqZK9ljU863RVcuWdfUjHoxhOuxuF8kpW
	 dbkXcUBiKCoH9WSa337mOpsvYyhM1MtMARmNwmbzQrdd/H5lcWQB0XJtQunsqfQHCA
	 x9iA2/pXor6uA==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 19 Aug 2024 20:24:23 +0100
Subject: [PATCH RFT v9 2/8] selftests: Provide helper header for shadow
 stack testing
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-clone3-shadow-stack-v9-2-962d74f99464@kernel.org>
References: <20240819-clone3-shadow-stack-v9-0-962d74f99464@kernel.org>
In-Reply-To: <20240819-clone3-shadow-stack-v9-0-962d74f99464@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2722; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Lqc0aeXK2Sje7x0iWLcH10niGKrB2vEXzwnzDeVxcmI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmw5xDXYN5rGkvlse/fXHMaeqJyBQjQ2OzR+hrZDva
 j9xAwvaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZsOcQwAKCRAk1otyXVSH0FW5B/
 sEdb+/3/C6mVHojOK22Umc+jVhiURJrDocmcsxvafRk+YK7TJ6ZbUzPsibtL+/ToD8Swc+fRF15aXS
 4Ku2BQn/eeMVF7YBVGA3ce4tTCNXx+meX0wTE/FrlIhk0mF3XpglJFsNUyhPnbNW5F2Vi29b+/NWpK
 t0DT07vlmlSc5qjM9UX0uVHTrwCom62NmeWK1ajzKUgiEjgwzh3E9IYri5ZM9NBh7xjrytCxyDrgeC
 iR3e+JX4W+cTpzK4M+L20dA1hSrPxV2M7CWAhQXD4UmPx/djYMSx3wCNlvoaCsLjpGjBfuy4PQSSiK
 VzgXFCVqlwpg6Ju1bWINMc42Z/Me29
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


