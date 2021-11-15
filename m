Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D95450864
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Nov 2021 16:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236650AbhKOPdy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Nov 2021 10:33:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:52480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236598AbhKOPck (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Nov 2021 10:32:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A49DA63222;
        Mon, 15 Nov 2021 15:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636990185;
        bh=Iz1TB8HTnr7e9Ekco1erA6sCTxhOFwnd1nCY4980Kgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ujuR9ZSLVCwIr/aVvKR/Y9njzF+NNiNHcm8cxrHwLutGrJTh2iUInbtB1ah+JH+g4
         Grp9q+2knyzb0qLTGzYUP0strJtkT1XvSp6wWw+YUdFpqEjC6zcNPuk4xUQEqOfTRd
         uy1rQdd+lmPY9QY0nHBmuupsXRpgSIBKcz9tF2z3M7GJpCrV8i1MeT4N03U8LOb6Z7
         lVfowO/Rejo4P/3MmCzmTGX6OUJ138lRyyGOu4CKfEpGSHcvy6ntIkuMN4my07rzYX
         zB5ZJXi8TU/x2Z0RlLQvgmBKy1G9Mla5TcqK7lS6Q714Ku1efuQ9AofJF3WKJjQZYH
         pC+I6RXAg6s4A==
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
Subject: [PATCH v6 18/37] arm64/sme: Implement SVCR context switching
Date:   Mon, 15 Nov 2021 15:28:16 +0000
Message-Id: <20211115152835.3212149-19-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211115152835.3212149-1-broonie@kernel.org>
References: <20211115152835.3212149-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3708; h=from:subject; bh=Iz1TB8HTnr7e9Ekco1erA6sCTxhOFwnd1nCY4980Kgc=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhknyTlraut7rom3l+pQGzMjle5o9o8GsYbmgcTDV7 lQfMBxWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYZJ8kwAKCRAk1otyXVSH0GTvB/ 46DSpdXeXOknA1PW0ilULj1WFXURJfNqaEXZaIB6eG9QD1yMYzcONf7e2EW7kY62FZWnL/2qHlXLXk AomqvTOKct2FYbSqW2Y4T26k/BKJBfqLRXcXX8EMweRvd3lHpobzzIH1oIjDU/cm7Iv64inygpy93p VE0FKd8tZbU9HrldlHpa5KhUOX0otZa3dEI1FAvvRcFfOwqkt6Wu3iBnKgLGLQjmVoEwP22t1zZHfw d575+pqEGSXGP9U4T1KTH+dsJUv1aECMlM664FwBv8qunGlsRQAJUOJIX4DwQhyaV59zY1pTrgn5jH ihrfBoTc5llxgpwZ3EndebC6qodrJ4
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In SME the use of both streaming SVE mode and ZA are tracked through
PSTATE.SM and PSTATE.ZA, visible through the system register SVCR.  In
order to context switch the floating point state for SME we need to
context switch the contents of this register as part of context
switching the floating point state.

Since changing the vector length exits streaming SVE mode and disables
ZA we also make sure we update SVCR appropriately when setting vector
length, and similarly ensure that new threads have streaming SVE mode
and ZA disabled.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/processor.h   |  1 +
 arch/arm64/include/asm/thread_info.h |  1 +
 arch/arm64/kernel/fpsimd.c           | 11 +++++++++++
 arch/arm64/kernel/process.c          |  2 ++
 4 files changed, 15 insertions(+)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 008a1767ebff..7e08a4d48c24 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -168,6 +168,7 @@ struct thread_struct {
 	u64			mte_ctrl;
 #endif
 	u64			sctlr_user;
+	u64			svcr;
 	u64			tpidr2_el0;
 };
 
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 4e6b58dcd6f9..848739c15de8 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -82,6 +82,7 @@ int arch_dup_task_struct(struct task_struct *dst,
 #define TIF_SVE_VL_INHERIT	24	/* Inherit SVE vl_onexec across exec */
 #define TIF_SSBD		25	/* Wants SSB mitigation */
 #define TIF_TAGGED_ADDR		26	/* Allow tagged user addresses */
+#define TIF_SME			27	/* SME in use */
 #define TIF_SME_VL_INHERIT	28	/* Inherit SME vl_onexec across exec */
 
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 0af82c518979..d6e6bec6b490 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -355,6 +355,9 @@ static void task_fpsimd_load(void)
 	WARN_ON(!system_supports_fpsimd());
 	WARN_ON(!have_cpu_fpsimd_context());
 
+	if (IS_ENABLED(CONFIG_ARM64_SME) && test_thread_flag(TIF_SME))
+		write_sysreg_s(current->thread.svcr, SYS_SVCR_EL0);
+
 	if (IS_ENABLED(CONFIG_ARM64_SVE) && test_thread_flag(TIF_SVE)) {
 		sve_set_vq(sve_vq_from_vl(task_get_sve_vl(current)) - 1);
 		sve_load_state(sve_pffr(&current->thread),
@@ -380,6 +383,10 @@ static void fpsimd_save(void)
 	if (test_thread_flag(TIF_FOREIGN_FPSTATE))
 		return;
 
+	if (IS_ENABLED(CONFIG_ARM64_SME) &&
+	    test_thread_flag(TIF_SME))
+		current->thread.svcr = read_sysreg_s(SYS_SVCR_EL0);
+
 	if (IS_ENABLED(CONFIG_ARM64_SVE) &&
 	    test_thread_flag(TIF_SVE)) {
 		if (WARN_ON(sve_get_vl() != last->sve_vl)) {
@@ -731,6 +738,10 @@ int vec_set_vector_length(struct task_struct *task, enum vec_type type,
 	if (test_and_clear_tsk_thread_flag(task, TIF_SVE))
 		sve_to_fpsimd(task);
 
+	if (system_supports_sme() && type == ARM64_VEC_SME)
+		task->thread.svcr &= ~(SYS_SVCR_EL0_SM_MASK |
+				       SYS_SVCR_EL0_ZA_MASK);
+
 	if (task == current)
 		put_cpu_fpsimd_context();
 
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 3adca0123943..eff50e02b4e2 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -309,6 +309,8 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	dst->thread.sve_state = NULL;
 	clear_tsk_thread_flag(dst, TIF_SVE);
 
+	dst->thread.svcr = 0;
+
 	/* clear any pending asynchronous tag fault raised by the parent */
 	clear_tsk_thread_flag(dst, TIF_MTE_ASYNC_FAULT);
 
-- 
2.30.2

