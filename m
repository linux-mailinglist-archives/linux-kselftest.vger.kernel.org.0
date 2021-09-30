Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF34F41E0D4
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Sep 2021 20:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353365AbhI3SSY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Sep 2021 14:18:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353361AbhI3SSX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Sep 2021 14:18:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8836461994;
        Thu, 30 Sep 2021 18:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633025801;
        bh=OTk6dS0eSqLUg0S3fXS1hYcLcuwtQJgzxiEPV2cUKpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O/iZYWY0Ee/J0tyGoTOYIsU0BQGlA8E9/sISR0p8tcQWTpg1TQhP2820jXiRER3/4
         Q/6tuaat+AdWNJ5Rt/sIDqryMng7zE/qxl0N+/LowVDe78yFhbHb/BDMjVqEUDRAuc
         iTGbWKHTyAHNwG8Cdudemp/oJK0+BWe1m3DmaEoioldag3KR627+Kjcrd/UbLFx/HH
         o4P2IpU3zK/rbQpvlzm5K7Rit7B7R7niZJVcTw14IEJ8daO37jTO0AYd3itY+MujTw
         sf837mUsesbgpFDBzqWFpmbSwr1XqSV8S96LmYMDuVf+5+XEhvnJ9t8nwfZ7R9CooZ
         3D/SSKxOYkjCA==
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
Subject: [PATCH v1 23/38] arm64/sme: Implement ZA context switching
Date:   Thu, 30 Sep 2021 19:11:29 +0100
Message-Id: <20210930181144.10029-24-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210930181144.10029-1-broonie@kernel.org>
References: <20210930181144.10029-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7208; h=from:subject; bh=OTk6dS0eSqLUg0S3fXS1hYcLcuwtQJgzxiEPV2cUKpI=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhVf3T+D6FU8pClcpe3XrnL9HTqnu74NhLc5RnpzRd sGchvOWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYVX90wAKCRAk1otyXVSH0FtGB/ 9ukTUF4yynKtXClTtandDsHaTu+5PcLR5lGFr2cfasYtF8LbAoYfwwGxSr1MVU0kal6r7xRaBOItH0 0EBStHWfnhZZjrCryyDGSy+bDmZCbKvNqqHdK9pDiJdIpwKcVtn8ivCUu+CEMSoXN3gTqV2HAoZeC0 bFGoPrgNTkOJHD8t5KRA2vo9xQ8ar468EOy5buDsKEQAQ0LT+OD6OUGtYcw1NDGpZL3Co0rI1k/dnO GNH46TW+qyI3gNxgFKzBqs1GFDDCJStxD0Zh0Qm15MDHj0gL5vI4yYUadty9gsY/UXM8NIT2RNPDyC re1MPS+2WgiHstm0wY5IR8lF8cYV0M
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Allocate space for storing ZA on first access to SME and use that to save
and restore ZA state when context switching. We do this by using the vector
form of the LDR and STR ZA instructions, these do not require streaming
mode and have implementation recommendations that they avoid contention
issues in shared SMCU implementations.

Since ZA is architecturally guaranteed to be zeroed when enabled we do not
need to explicitly zero ZA, either we will be restoring from a saved copy
or trapping on first use of SME so we know that ZA must be disabled.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/fpsimd.h       |  5 ++++-
 arch/arm64/include/asm/fpsimdmacros.h | 22 ++++++++++++++++++++++
 arch/arm64/include/asm/processor.h    |  1 +
 arch/arm64/kernel/entry-fpsimd.S      | 22 ++++++++++++++++++++++
 arch/arm64/kernel/fpsimd.c            | 16 ++++++++++------
 arch/arm64/kvm/fpsimd.c               |  2 +-
 6 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 43737ca91f1a..45f7153067bb 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -47,7 +47,7 @@ extern void fpsimd_update_current_state(struct user_fpsimd_state const *state);
 
 extern void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *state,
 				     void *sve_state, unsigned int sve_vl,
-				     unsigned int sme_vl);
+				     void *za_state, unsigned int sme_vl);
 
 extern void fpsimd_flush_task_state(struct task_struct *target);
 extern void fpsimd_save_and_flush_cpu_state(void);
@@ -90,6 +90,8 @@ extern void sve_flush_live(bool flush_ffr, unsigned long vq_minus_1);
 extern unsigned int sve_get_vl(void);
 extern void sve_set_vq(unsigned long vq_minus_1);
 extern void sme_set_vq(unsigned long vq_minus_1);
+extern void sme_save_state(void *state, unsigned int vq_minus_1);
+extern void sme_load_state(void const *state, unsigned int vq_minus_1);
 
 struct arm64_cpu_capabilities;
 extern void sve_kernel_enable(const struct arm64_cpu_capabilities *__unused);
@@ -119,6 +121,7 @@ static inline unsigned int __bit_to_vq(unsigned int bit)
 extern size_t sve_state_size(struct task_struct const *task);
 
 extern void sve_alloc(struct task_struct *task);
+extern void sme_alloc(struct task_struct *task);
 extern void fpsimd_release_task(struct task_struct *task);
 extern void fpsimd_sync_to_sve(struct task_struct *task);
 extern void sve_sync_to_fpsimd(struct task_struct *task);
diff --git a/arch/arm64/include/asm/fpsimdmacros.h b/arch/arm64/include/asm/fpsimdmacros.h
index c86fc2fc72e9..146f906e9a86 100644
--- a/arch/arm64/include/asm/fpsimdmacros.h
+++ b/arch/arm64/include/asm/fpsimdmacros.h
@@ -309,3 +309,25 @@
 		ldr		w\nxtmp, [\xpfpsr, #4]
 		msr		fpcr, x\nxtmp
 .endm
+
+.macro sme_save_za nxbase, xvl, nw
+	mov	w\nw, #0
+
+423:
+	_sme_str_zav \nw, \nxbase
+	add	x\nxbase, x\nxbase, \xvl
+	add	x\nw, x\nw, #1
+	cmp	\xvl, x\nw
+	bne	423b
+.endm
+
+.macro sme_load_za nxbase, xvl, nw
+	mov	w\nw, #0
+
+423:
+	_sme_ldr_zav \nw, \nxbase
+	add	x\nxbase, x\nxbase, \xvl
+	add	x\nw, x\nw, #1
+	cmp	\xvl, x\nw
+	bne	423b
+.endm
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 338cb03811bd..e4688a58f365 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -153,6 +153,7 @@ struct thread_struct {
 
 	unsigned int		fpsimd_cpu;
 	void			*sve_state;	/* SVE registers, if any */
+	void			*za_state;	/* ZA register, if any */
 	unsigned int		vl[ARM64_VEC_MAX];	/* vector length */
 	unsigned int		vl_onexec[ARM64_VEC_MAX]; /* vl after next exec */
 	unsigned long		fault_address;	/* fault info */
diff --git a/arch/arm64/kernel/entry-fpsimd.S b/arch/arm64/kernel/entry-fpsimd.S
index 55eb45b3faa9..8ee5f32a81fd 100644
--- a/arch/arm64/kernel/entry-fpsimd.S
+++ b/arch/arm64/kernel/entry-fpsimd.S
@@ -94,4 +94,26 @@ SYM_FUNC_START(sme_set_vq)
 	ret
 SYM_FUNC_END(sme_set_vq)
 
+/*
+ * Save the SME state
+ *
+ * x0 - pointer to buffer for state
+ * x1 - Bytes per vector
+ */
+SYM_FUNC_START(sme_save_state)
+	sme_save_za 0, x1, 12
+	ret
+SYM_FUNC_END(sme_save_state)
+
+/*
+ * Load the SME state
+ *
+ * x0 - pointer to buffer for state
+ * x1 - bytes per vector
+ */
+SYM_FUNC_START(sme_load_state)
+	sme_load_za 0, x1, 12
+	ret
+SYM_FUNC_END(sme_load_state)
+
 #endif /* CONFIG_ARM64_SME */
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 89b94e8c81fd..4ef95690b30e 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -117,6 +117,7 @@
 struct fpsimd_last_state_struct {
 	struct user_fpsimd_state *st;
 	void *sve_state;
+	void *za_state;
 	unsigned int sve_vl;
 	unsigned int sme_vl;
 };
@@ -387,6 +388,9 @@ static void task_fpsimd_load(void)
 
 		write_sysreg_s(current->thread.svcr, SYS_SVCR_EL0);
 
+		if (thread_za_enabled(&current->thread))
+			sme_load_state(current->thread.za_state, sme_vl);
+
 		if (thread_sm_enabled(&current->thread)) {
 			restore_sve_regs = true;
 			restore_ffr = false;
@@ -434,11 +438,8 @@ static void fpsimd_save(void)
 					      SYS_SVCR_EL0_SM_MASK)))
 			clear_thread_flag(TIF_SME);
 
-		if (thread_za_enabled(&current->thread)) {
-			/* ZA state managment is not implemented yet */
-			force_signal_inject(SIGKILL, SI_KERNEL, 0, 0);
-			return;
-		}
+		if (thread_za_enabled(&current->thread))
+			sme_save_state(last->za_state, last->sme_vl);
 
 		/* If we are in streaming mode override regular SVE. */
 		if (thread_sm_enabled(&current->thread)) {
@@ -1476,6 +1477,7 @@ static void fpsimd_bind_task_to_cpu(void)
 	WARN_ON(!system_supports_fpsimd());
 	last->st = &current->thread.uw.fpsimd_state;
 	last->sve_state = current->thread.sve_state;
+	last->za_state = current->thread.za_state;
 	last->sve_vl = task_get_sve_vl(current);
 	last->sme_vl = task_get_sme_vl(current);
 	current->thread.fpsimd_cpu = smp_processor_id();
@@ -1492,7 +1494,8 @@ static void fpsimd_bind_task_to_cpu(void)
 }
 
 void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st, void *sve_state,
-			      unsigned int sve_vl, unsigned int sme_vl)
+			      unsigned int sve_vl, void *za_state,
+			      unsigned int sme_vl)
 {
 	struct fpsimd_last_state_struct *last =
 		this_cpu_ptr(&fpsimd_last_state);
@@ -1502,6 +1505,7 @@ void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st, void *sve_state,
 
 	last->st = st;
 	last->sve_state = sve_state;
+	last->za_state = za_state;
 	last->sve_vl = sve_vl;
 	last->sme_vl = sme_vl;
 }
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index d96871002081..007b2e8b9ae9 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -100,7 +100,7 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
 		fpsimd_bind_state_to_cpu(&vcpu->arch.ctxt.fp_regs,
 					 vcpu->arch.sve_state,
 					 vcpu->arch.sve_max_vl,
-					 0);
+					 NULL, 0);
 
 		clear_thread_flag(TIF_FOREIGN_FPSTATE);
 		update_thread_flag(TIF_SVE, vcpu_has_sve(vcpu));
-- 
2.20.1

