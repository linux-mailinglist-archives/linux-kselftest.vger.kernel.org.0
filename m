Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDB0436A23
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Oct 2021 20:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbhJUSLC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Oct 2021 14:11:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232326AbhJUSLC (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Oct 2021 14:11:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8450861AFC;
        Thu, 21 Oct 2021 18:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634839726;
        bh=QqgxzIbwZj8Z9tKoxDJDBWpIZe8Al30Rkx+LSy264EY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JP/+/Po7JV+7aST2gmhNvdmSfn2scz0cQd4vPDkxTk/Wb4dLR+Nd/aMRcOxHKJRQ4
         xbNEozSGtRH4VpA6nMV4DyTpISZIN64po9fIPYQBlt9Y4Z47J5OVUFneid4+LewFM4
         xqZAeo5Rud2rpbkIRrDuTfbHbsJdAYMkYAMFwxxO0Q8O/xEzV+/2tb3lL/ni/ntDnn
         UByzKwdYXZjpfMN87Az1oowvMsijMWvbktEslGj2I2ygyfo73+iRJCV6P5JavMZ6gj
         pPe2xjMowvH3zeh0YaA/9mHOwhQM8T6IPspBRnTx5nbpEFfhKg+TEW2nZANu0niCTr
         zoG+AWgOWVrxw==
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
Subject: [PATCH v4 15/33] arm64/sme: Implement SVCR context switching
Date:   Thu, 21 Oct 2021 19:07:04 +0100
Message-Id: <20211021180722.3699248-16-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021180722.3699248-1-broonie@kernel.org>
References: <20211021180722.3699248-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3708; h=from:subject; bh=QqgxzIbwZj8Z9tKoxDJDBWpIZe8Al30Rkx+LSy264EY=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhcaxKzK3OwGLDO1/gIok0Wm6eYEd+ubpIQJ+W96Mf mTW6LZ6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYXGsSgAKCRAk1otyXVSH0Np2B/ 966FphO8djjRm+1zCA/jX74CFi/Xe42tq5AC8jlzum5ScUVKg56Sy6sxCXgeqDEKrYXmVqqsv1sklx R7bGk754vRexYb3j25iVgUXzmmcJsXcyO/cObo8A9ztdido+nQy9et4iEyKM+OizMA7P8LWAYEMv2R n0sc6iaSOFoPHaBOxmmsFo8S53Nx1TXYU9q5m5AoRnQK69qfaNsN05+oS6wWvMP4+7vyOLFmjs2X8e DuxvT+oSp16pXFoObmGZW2VNNBhQvQM1u+yzolrT4x3bH+rJJgG6OBVnVIP/iNS9a8W7zON73o9Rvz pGCq8xYZT46afx3/yZKl66zjaxrEK3
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
index cb246ba4ca98..0064fa45ef38 100644
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

