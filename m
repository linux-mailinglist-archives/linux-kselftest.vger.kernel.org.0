Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97468450885
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Nov 2021 16:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236388AbhKOPfS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Nov 2021 10:35:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:52694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236610AbhKOPdD (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Nov 2021 10:33:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D5976322A;
        Mon, 15 Nov 2021 15:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636990190;
        bh=QQL7fE8fUqwEna0Yuurf4F0iRHsTWydnTTz1BarHZYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cec+/8e8CfS3i9f07UUFl0xD9IU16ANIAlHa8kH6XwHil13r5+lbWSHLtDWoXqbOU
         byBp0tCkLLPUyUsyJF096YlSSAjlXlaF8sFI/Fwud49h5AiFxNloFnmxmVZwVh0oxX
         AJZ8iamQDxAmwSievK9SMWcT3ALkyBaLmVWwjNeC21AqCs7OoqKy0KIfI5ZupGTStf
         F/0BpZ5qWvbXAy2GFNp7NTr1dNfnaWMPKncc23sZS16llCMSpHBBRyfg1uTjqlpXtk
         g7O1TBEKa0ADNazkzEJSe1RGH37BeKx6UX+6OplDHNyiz2upXSmvk4dJfsAjPePVXE
         2C0tO17m+5FPA==
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
Subject: [PATCH v6 20/37] arm64/sme: Implement ZA context switching
Date:   Mon, 15 Nov 2021 15:28:18 +0000
Message-Id: <20211115152835.3212149-21-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211115152835.3212149-1-broonie@kernel.org>
References: <20211115152835.3212149-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7034; h=from:subject; bh=QQL7fE8fUqwEna0Yuurf4F0iRHsTWydnTTz1BarHZYE=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhknyUOhVKykUUol+AT6pwiwo/82xP8XkXgeqetjvk GXfGofmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYZJ8lAAKCRAk1otyXVSH0JA0CA CDCN980VF46xf++lhVyOmI2uXuK/CLAHQU/P94Ala2kOFJ2OB56/jb0ItgePGlsPyHhUm237fqQWsw QaEhAZ3b2lxUxvNo9ouGxusg+sGkeTmL/CDHc+KE0JurXUuUJx8+Z0d/9Lhi7Fse+zZ6UgzqfbPwX1 otLiIbf8IURCu5ai92GW1pBk8kUe6aQS03ibFlsM9mCBjL1x0v/SqhJGAJzhKrQCUkNsV2VFfNkom2 WsTgXbKKxOiwVllOyhizG0wq6gEObls3910BrIPe7JcinRB5W1hWQdwsmUbegQhcacmK8oIRP8R/kT WFFI/ZRkMwL3GGFOqUmkXK1v310IuX
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
 arch/arm64/include/asm/fpsimd.h       |  4 +++-
 arch/arm64/include/asm/fpsimdmacros.h | 22 ++++++++++++++++++++++
 arch/arm64/include/asm/processor.h    |  1 +
 arch/arm64/kernel/entry-fpsimd.S      | 22 ++++++++++++++++++++++
 arch/arm64/kernel/fpsimd.c            | 17 +++++++++++------
 arch/arm64/kvm/fpsimd.c               |  2 +-
 6 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 2f7b64797736..de7947a71618 100644
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
diff --git a/arch/arm64/include/asm/fpsimdmacros.h b/arch/arm64/include/asm/fpsimdmacros.h
index 57bcd9ec4cb9..113c37b1a8e9 100644
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
index 6e2af9de153c..5a5c5edd76df 100644
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
index b06bf42e7856..6a224cfcfd50 100644
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
index 39a4dd0a6257..2582374b7e48 100644
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
@@ -382,11 +383,15 @@ static void task_fpsimd_load(void)
 	if (system_supports_sme()) {
 		unsigned long sme_vl = task_get_sme_vl(current);
 
+		/* Ensure VL is set up for restoring data */
 		if (test_thread_flag(TIF_SME))
 			sme_set_vq(sve_vq_from_vl(sme_vl) - 1);
 
 		write_sysreg_s(current->thread.svcr, SYS_SVCR_EL0);
 
+		if (thread_za_enabled(&current->thread))
+			sme_load_state(current->thread.za_state, sme_vl);
+
 		if (thread_sm_enabled(&current->thread)) {
 			restore_sve_regs = true;
 			restore_ffr = system_supports_fa64();
@@ -429,11 +434,8 @@ static void fpsimd_save(void)
 	if (system_supports_sme()) {
 		current->thread.svcr = read_sysreg_s(SYS_SVCR_EL0);
 
-		if (thread_za_enabled(&current->thread)) {
-			/* ZA state managment is not implemented yet */
-			force_signal_inject(SIGKILL, SI_KERNEL, 0, 0);
-			return;
-		}
+		if (thread_za_enabled(&current->thread))
+			sme_save_state(last->za_state, last->sme_vl);
 
 		/* If we are in streaming mode override regular SVE. */
 		if (thread_sm_enabled(&current->thread)) {
@@ -1481,6 +1483,7 @@ static void fpsimd_bind_task_to_cpu(void)
 	WARN_ON(!system_supports_fpsimd());
 	last->st = &current->thread.uw.fpsimd_state;
 	last->sve_state = current->thread.sve_state;
+	last->za_state = current->thread.za_state;
 	last->sve_vl = task_get_sve_vl(current);
 	last->sme_vl = task_get_sme_vl(current);
 	current->thread.fpsimd_cpu = smp_processor_id();
@@ -1497,7 +1500,8 @@ static void fpsimd_bind_task_to_cpu(void)
 }
 
 void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st, void *sve_state,
-			      unsigned int sve_vl, unsigned int sme_vl)
+			      unsigned int sve_vl, void *za_state,
+			      unsigned int sme_vl)
 {
 	struct fpsimd_last_state_struct *last =
 		this_cpu_ptr(&fpsimd_last_state);
@@ -1507,6 +1511,7 @@ void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st, void *sve_state,
 
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
2.30.2

