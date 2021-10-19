Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6535433D5B
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Oct 2021 19:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbhJSR0z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Oct 2021 13:26:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:54928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234625AbhJSR0z (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Oct 2021 13:26:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19A13610FC;
        Tue, 19 Oct 2021 17:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634664282;
        bh=MsTED/mKGInbKff7tMbBmrASFeZ5+Ym+qIYJfb6ihGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iQkQjtCQzddfjCwH4pehl9W2akqEDNzewRJalei+exLmM55NZwA60lCf0iQeCkNLc
         0HW77SsZNYqlZz6G+Q8uu3p3c6BOyhtvG2yAyGyzqOay4Az8CDFdiYXbLeGhLFSI6Z
         8PJUD+mPN0nTWLS0S9GaQxxOJgg8L2kEkwukqFsGwBLFxb3HmEWP2wzTNei2v4hq2E
         vxg1QKON/2ZFr7FLRwPoCcDskXtQ9ZFllYYLhtP1D7CpdYzAPXRQHAzbPRXruO2WPo
         q2AgxPjb3yG2ryQuyU4PHogOIBQ97+04m7Mm2ow4cjq1PfFSkrdf+iWSSdhoI1qceQ
         KiLW83D5oRLEA==
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
Subject: [PATCH v3 24/42] arm64/sme: Implement SVCR context switching
Date:   Tue, 19 Oct 2021 18:22:29 +0100
Message-Id: <20211019172247.3045838-25-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211019172247.3045838-1-broonie@kernel.org>
References: <20211019172247.3045838-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3708; h=from:subject; bh=MsTED/mKGInbKff7tMbBmrASFeZ5+Ym+qIYJfb6ihGM=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhbv7WMFf7qQRz+Zh0BYQYI6GeroeSFuZtmbcSyqvA a8KIYw6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYW7+1gAKCRAk1otyXVSH0DaBB/ 9QhQl0BhI5bHnmG6TRJCKVhxNwB5w6TpnEfOXyjBXTS206gPc5YrSTdqaDiawjI7ZI5amU8MEBdDOK xBVnQ/fHQGefx37We2x/fyHLOJt5Mc/QfFiJTmTjUHZ+ZpBPJU6gltImkq/sOpnUawRy8IQEWmgY7x v8djX3USTVPZZsp3mXqh6bprNBr12rRcKP5PeJ5lyZyssk/rLgfGC6avTso6fP5MyxJbGoqdCFZWco qyWR+AIIAG0oevV0MFXCqsPdVTcJT1xcGoWdYtpJEyCrbu/pcK97tyMpCvpaFy/U8Qbgddi05UTCsz YXMxtUqOGR6pio4MGHsBDlnKkRY2kP
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
index 51eca2513cb5..3c235e165725 100644
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
index 5c4355204f4a..03cb88f63317 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -81,6 +81,7 @@ int arch_dup_task_struct(struct task_struct *dst,
 #define TIF_SVE_VL_INHERIT	24	/* Inherit SVE vl_onexec across exec */
 #define TIF_SSBD		25	/* Wants SSB mitigation */
 #define TIF_TAGGED_ADDR		26	/* Allow tagged user addresses */
+#define TIF_SME			27	/* SME in use */
 #define TIF_SME_VL_INHERIT	28	/* Inherit SME vl_onexec across exec */
 
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index a619ce38eddc..c43bf252482f 100644
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
@@ -734,6 +741,10 @@ int vec_set_vector_length(struct task_struct *task, enum vec_type type,
 	if (test_and_clear_tsk_thread_flag(task, TIF_SVE))
 		sve_to_fpsimd(task);
 
+	if (system_supports_sme() && type == ARM64_VEC_SME)
+		task->thread.svcr &= ~(SYS_SVCR_EL0_SM_MASK |
+				       SYS_SVCR_EL0_ZA_MASK);
+
 	if (task == current)
 		put_cpu_fpsimd_context();
 
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 3f4279ad68bc..4dd35619ece6 100644
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

