Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E640B4E4CC
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2019 11:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfFUJxt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jun 2019 05:53:49 -0400
Received: from foss.arm.com ([217.140.110.172]:55574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726972AbfFUJxr (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jun 2019 05:53:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 466981478;
        Fri, 21 Jun 2019 02:53:46 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0C973F246;
        Fri, 21 Jun 2019 02:53:43 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v7 14/25] arm64: compat: Get sigreturn trampolines from vDSO
Date:   Fri, 21 Jun 2019 10:52:41 +0100
Message-Id: <20190621095252.32307-15-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190621095252.32307-1-vincenzo.frascino@arm.com>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When the compat vDSO is enabled, the sigreturn trampolines are not
anymore available through [sigpage] but through [vdso].

Add the relevant code the enable the feature.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Tested-by: Shijith Thotton <sthotton@marvell.com>
Tested-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/include/asm/vdso.h |  3 +++
 arch/arm64/kernel/signal32.c  | 26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm64/include/asm/vdso.h b/arch/arm64/include/asm/vdso.h
index 839ce0031bd5..9b197e5ea759 100644
--- a/arch/arm64/include/asm/vdso.h
+++ b/arch/arm64/include/asm/vdso.h
@@ -28,6 +28,9 @@
 #ifndef __ASSEMBLY__
 
 #include <generated/vdso-offsets.h>
+#ifdef CONFIG_COMPAT_VDSO
+#include <generated/vdso32-offsets.h>
+#endif
 
 #define VDSO_SYMBOL(base, name)						   \
 ({									   \
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index 74e06d8c7c2b..4fca2e1937b2 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -29,6 +29,7 @@
 #include <asm/traps.h>
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
+#include <asm/vdso.h>
 
 struct compat_vfp_sigframe {
 	compat_ulong_t	magic;
@@ -352,6 +353,30 @@ static void compat_setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 		retcode = ptr_to_compat(ka->sa.sa_restorer);
 	} else {
 		/* Set up sigreturn pointer */
+#ifdef CONFIG_COMPAT_VDSO
+		void *vdso_base = current->mm->context.vdso;
+		void *vdso_trampoline;
+
+		if (ka->sa.sa_flags & SA_SIGINFO) {
+			if (thumb) {
+				vdso_trampoline = VDSO_SYMBOL(vdso_base,
+							compat_rt_sigreturn_thumb);
+			} else {
+				vdso_trampoline = VDSO_SYMBOL(vdso_base,
+							compat_rt_sigreturn_arm);
+			}
+		} else {
+			if (thumb) {
+				vdso_trampoline = VDSO_SYMBOL(vdso_base,
+							compat_sigreturn_thumb);
+			} else {
+				vdso_trampoline = VDSO_SYMBOL(vdso_base,
+							compat_sigreturn_arm);
+			}
+		}
+
+		retcode = ptr_to_compat(vdso_trampoline) + thumb;
+#else
 		unsigned int idx = thumb << 1;
 
 		if (ka->sa.sa_flags & SA_SIGINFO)
@@ -359,6 +384,7 @@ static void compat_setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 
 		retcode = (unsigned long)current->mm->context.vdso +
 			  (idx << 2) + thumb;
+#endif
 	}
 
 	regs->regs[0]	= usig;
-- 
2.21.0

