Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E25E41E0D1
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Sep 2021 20:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhI3SSQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Sep 2021 14:18:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353361AbhI3SSP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Sep 2021 14:18:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72F616140F;
        Thu, 30 Sep 2021 18:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633025793;
        bh=nfAJWZv+ED6y1asaUGPDLLG2938gN2Uv07Rrkgodn98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pQikDpNEKl6YCy3TOiGcyFPzgrmuTcBJc6Hh1HsrkQZIYZ1q9Yrew72/4k5icAksP
         bL3BJIkD7dIQmLp0L6O/OJfVqZaswqrqpEVZDj03he5zVuflIIZuDND40MKxazkacs
         z/RnbpM2PeUrKguqS9oJv2G8oCsaulUYF+bzAc1QCiuseIZpeWiuITGRdYFULQ+xb6
         yaxemq2+45wzPU4ME+YzRoBrqWq7XD8YRCswI/po1L4WfSr1bMg6DBR/drkddXm604
         FCBIYQMUd5tC69KIYgGrXm8X+ZE9UL18fWvYKKeNSIO5kQGsK5ombLg1BWxsfuzqtm
         /TO2eRPRyT+Bg==
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
Subject: [PATCH v1 20/38] arm64/sme: Implement support for TPIDR2
Date:   Thu, 30 Sep 2021 19:11:26 +0100
Message-Id: <20210930181144.10029-21-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210930181144.10029-1-broonie@kernel.org>
References: <20210930181144.10029-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3380; h=from:subject; bh=nfAJWZv+ED6y1asaUGPDLLG2938gN2Uv07Rrkgodn98=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhVf3Rq6qj1PNBDY25YjwHmd4oHk1maUPwMw527RoX xEvpsQ2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYVX90QAKCRAk1otyXVSH0FKVB/ 48xsbYJuO7FxaMU5ICGOfBG+rFWAnwwdKzaTtSZaYkRFtLo5NVrEvMBXDsAkXjOa7oDA7MeQcbOuwu y4tA4muDnT23sZnNcdV/ZQ/B7NjRoPnXFY8eXg/Zo4DM+ScRh4QfoEL5lBohHJCsP3iEIrDn1krHEN 7+o71WS32DgfpljfT0tE6N3P6vnl2ntL2C6r2BoM8xQORPEgXsK6AIwdb9Jhvp8c1/hsFxrdl1NujQ Odxx0W10B30lUl+3yzFixXyuMUm59tbCiX4h11GOhiWrNjWxTeYQX/2iAFRftvpFy2zorYpSUfJbtB zQct+YhUA1sCwgLo8YaQ93zB5GInzo
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
 arch/arm64/include/asm/cpufeature.h | 5 +++++
 arch/arm64/include/asm/processor.h  | 1 +
 arch/arm64/kernel/fpsimd.c          | 4 ++++
 arch/arm64/kernel/process.c         | 5 +++++
 4 files changed, 15 insertions(+)

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
index 9511428c2e81..e673a1d6a618 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1099,6 +1099,10 @@ void sme_kernel_enable(const struct arm64_cpu_capabilities *__always_unused p)
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
index 40adb8cdbf5a..0640b51d4289 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -377,6 +377,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 	 * as the final frame for the new task.
 	 */
 	p->thread.cpu_context.fp = (unsigned long)childregs->stackframe;
+	p->thread.tpidr2_el0 = 0;
 
 	ptrace_hw_copy_thread(p);
 
@@ -386,6 +387,8 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 void tls_preserve_current_state(void)
 {
 	*task_user_tls(current) = read_sysreg(tpidr_el0);
+	if (system_supports_tpidr2())
+		current->thread.tpidr2_el0 = read_sysreg_s(SYS_TPIDR2_EL0);
 }
 
 static void tls_thread_switch(struct task_struct *next)
@@ -398,6 +401,8 @@ static void tls_thread_switch(struct task_struct *next)
 		write_sysreg(0, tpidrro_el0);
 
 	write_sysreg(*task_user_tls(next), tpidr_el0);
+	if (system_supports_tpidr2())
+		write_sysreg_s(next->thread.tpidr2_el0, SYS_TPIDR2_EL0);
 }
 
 /*
-- 
2.20.1

