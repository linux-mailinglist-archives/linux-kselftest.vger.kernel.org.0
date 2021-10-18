Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41CD43273C
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Oct 2021 21:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbhJRTNU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Oct 2021 15:13:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:38476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231739AbhJRTNT (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Oct 2021 15:13:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFFF26128E;
        Mon, 18 Oct 2021 19:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634584268;
        bh=aFev8ngRFDGz/ANUtgXv2zURTXzgE+Ln7KKbpbHpIaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fKfTSs2izd54SWdcv5UBPAKPDaWA6tPlY5njAP18CP9q0jHWxIEXZLywra9jKMME1
         SOAI417s2SPI9yCLk3DqozbidKSdEjWkJbKVevkiDbxV2+Chd7W1HGVy54OaE+RZGC
         g2xUV8JRabv9hVN9+uMWhx19SY5NjfjVffxO4MPUrkCR/BbOqKxbfg6/svn9P0TeWG
         /fBORp53T4wQssD/4HviB8+V8vaTV/TgLPi+oqHt/dZGam4VKa/dj7A+160fa65RQe
         aPuB+3KF+V4PRIZKEaIinvmbxM5S8vTPY2WJNTHNiCwLD/efgUYWuVfu8AWr3nPw7k
         qF3IttBCdAGKg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 23/42] arm64/sme: Implement support for TPIDR2
Date:   Mon, 18 Oct 2021 20:08:39 +0100
Message-Id: <20211018190858.2119209-24-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018190858.2119209-1-broonie@kernel.org>
References: <20211018190858.2119209-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4252; h=from:subject; bh=aFev8ngRFDGz/ANUtgXv2zURTXzgE+Ln7KKbpbHpIaY=; b=owGbwMvMwMWocq27KDak/QLjabUkhsTcY5YLX2+a1MCdcVw99+75Z+LsytLXkh2+2tRUtgs2fHUv d07vZDRmYWDkYpAVU2RZ+yxjVXq4xNb5j+a/ghnEygQyhYGLUwAmMukW+1+Rv+sbm64tELcSW7ZtN9 OPvdHMy7UTUy13W9nGtK8VFj1Ukr/m3dyNRd32qw5HKN6eukDftnB7xS/X4P0hAt0JXMIMykJ225f/ LxOa/EON8UR5TCbvLjfVTvd1jyb2dhdJrlssZ+PS8v5zMrdc/pc/9teVMt+nFkREBhxRa+3s2Xlunm rrLLtnav8c3VTfbkyfp6ff8KXOfnqpuoKkciznZA12/rdSnEuOJh3N+7SkOmY1k+p8xxinJat+P9vM q870nv29d/q2e8+WbvRmyXJl1FLZ9iHGyYrvhXXesbusd4UNWtzeVVr4zVpXemDb0Zsx1a7ZNtcMFf xPdoiJiB6Y6ar1iWd2h83LmbnlAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The Scalable Matrix Extension introduces support for a new thread specific
data register TPIDR2 intended for use by libc. The kernel must save the
value of TPIDR2 on context switch and should ensure that all new threads
start off with a default value of 0. Add a field to the thread_struct to
store TPIDR2 and context switch it with the other thread specific data.

In case there are future extensions which also use TPIDR2 we introduce
system_supports_tpidr2() and use that rather than system_supports_sme()
for TPIDR2 handling.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/cpufeature.h |  5 +++++
 arch/arm64/include/asm/processor.h  |  1 +
 arch/arm64/kernel/fpsimd.c          |  4 ++++
 arch/arm64/kernel/process.c         | 14 ++++++++++++--
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 9a183267b341..8d0cff410b40 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -740,6 +740,11 @@ static __always_inline bool system_supports_sme(void)
 		cpus_have_const_cap(ARM64_SME);
 }
 
+static __always_inline bool system_supports_tpidr2(void)
+{
+	return system_supports_sme();
+}
+
 static __always_inline bool system_supports_cnp(void)
 {
 	return IS_ENABLED(CONFIG_ARM64_CNP) &&
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index a62d2f8045bf..51eca2513cb5 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -168,6 +168,7 @@ struct thread_struct {
 	u64			mte_ctrl;
 #endif
 	u64			sctlr_user;
+	u64			tpidr2_el0;
 };
 
 static inline unsigned int thread_get_vl(struct thread_struct *thread,
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 96780b6821b6..a619ce38eddc 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1101,6 +1101,10 @@ void sme_kernel_enable(const struct arm64_cpu_capabilities *__always_unused p)
 	/* Allow SME in kernel */
 	write_sysreg(read_sysreg(CPACR_EL1) | CPACR_EL1_SMEN_EL1EN, CPACR_EL1);
 	isb();
+
+	/* Allow EL0 to access TPIDR2 */
+	write_sysreg(read_sysreg(SCTLR_EL1) | SCTLR_ELx_ENTP2, SCTLR_EL1);
+	isb();
 }
 
 /*
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 40adb8cdbf5a..3f4279ad68bc 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -249,6 +249,8 @@ void show_regs(struct pt_regs *regs)
 static void tls_thread_flush(void)
 {
 	write_sysreg(0, tpidr_el0);
+	if (system_supports_tpidr2())
+		write_sysreg_s(0, SYS_TPIDR2_EL0);
 
 	if (is_compat_task()) {
 		current->thread.uw.tp_value = 0;
@@ -342,6 +344,8 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 		 * out-of-sync with the saved value.
 		 */
 		*task_user_tls(p) = read_sysreg(tpidr_el0);
+		if (system_supports_tpidr2())
+			p->thread.tpidr2_el0 = read_sysreg_s(SYS_TPIDR2_EL0);
 
 		if (stack_start) {
 			if (is_compat_thread(task_thread_info(p)))
@@ -352,10 +356,12 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 
 		/*
 		 * If a TLS pointer was passed to clone, use it for the new
-		 * thread.
+		 * thread.  We also reset TPIDR2 if it's in use.
 		 */
-		if (clone_flags & CLONE_SETTLS)
+		if (clone_flags & CLONE_SETTLS) {
 			p->thread.uw.tp_value = tls;
+			p->thread.tpidr2_el0 = 0;
+		}
 	} else {
 		/*
 		 * A kthread has no context to ERET to, so ensure any buggy
@@ -386,6 +392,8 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 void tls_preserve_current_state(void)
 {
 	*task_user_tls(current) = read_sysreg(tpidr_el0);
+	if (system_supports_tpidr2() && !is_compat_task())
+		current->thread.tpidr2_el0 = read_sysreg_s(SYS_TPIDR2_EL0);
 }
 
 static void tls_thread_switch(struct task_struct *next)
@@ -398,6 +406,8 @@ static void tls_thread_switch(struct task_struct *next)
 		write_sysreg(0, tpidrro_el0);
 
 	write_sysreg(*task_user_tls(next), tpidr_el0);
+	if (system_supports_tpidr2())
+		write_sysreg_s(next->thread.tpidr2_el0, SYS_TPIDR2_EL0);
 }
 
 /*
-- 
2.30.2

