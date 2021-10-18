Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7E2432740
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Oct 2021 21:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhJRTNa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Oct 2021 15:13:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231811AbhJRTN2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Oct 2021 15:13:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1480C6128A;
        Mon, 18 Oct 2021 19:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634584276;
        bh=b84GxJU5K6WULQZFbosFn4u6CfmSTashaNa5eHIIHqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LElTG1kR5CNaxaqY8VVSeMkoqse1GVuqcC97ANmEwtHcnGOveRR20ing6hfKkHzGG
         y60Sq49v8YG7JTYwSgY0ZxHJ0OeVUh3WHZrt4q5C7q9dTG2I/THwzr9O+JIEc3BLT5
         lhk6knNGRZGV2Km90pygkUhzkq7sWCqMjPgWGPzGHD223BQ1dEsLDYcSYSVRmz0rkf
         sbwg/p5sKJPmziRZ1p6Q5cj59h4HWNqlQvV6CGaW8NiAJ/mfXQRkLj0nHVG7nSP89b
         hR91fcZ7sRVMfrByz4Xx2pxdHvwi4BfJ/WK5/0v5Yavk9qXjCb4F1jUvULIIjDVI3B
         sqrznk0XRL8pQ==
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
Subject: [PATCH v2 26/42] arm64/sme: Implement ZA context switching
Date:   Mon, 18 Oct 2021 20:08:42 +0100
Message-Id: <20211018190858.2119209-27-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018190858.2119209-1-broonie@kernel.org>
References: <20211018190858.2119209-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6999; h=from:subject; bh=b84GxJU5K6WULQZFbosFn4u6CfmSTashaNa5eHIIHqU=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhbcY78Hf7dXlgnfiSWfw9aXwDolIO7sSTpRxpR+MS PIrcy+iJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYW3GOwAKCRAk1otyXVSH0JeiB/ 90DQrk/Qa4OSknz8nVLA1HQCI7kOoXsiigAi5e/BDrS3FDGIjBGW5cwJkWFRpTDTYsLbdYMvYM4Lkx r5USktQ6uzHbBmNeklK8C2sYVCfSGh7eX3F66RhlbxJHpPLtrlKz41u8qlnyVcF7TTWKDaVFscalqS ksW8H/dZnFAgb44yCsvWPOxDsQ/8UYs4KshgHYHZrXV3Z6nn251nwWOtJcQ9IabtmbMR21cEoA8Vny yN66tVwhVtbN2QpQn4tTerOv3Mekzai20drdilG2MSOUHjTss8hqyVWMpZ01WzKrmEBILGjVhwsm07 CrP5TrDdW2klP2gdCtYjrd1koP4huz
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
index 391db07566aa..c9cefb17d534 100644
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
index 07a6990066af..b1e5017d1d46 100644
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
 			restore_ffr = false;
@@ -434,11 +439,8 @@ static void fpsimd_save(void)
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
@@ -1478,6 +1480,7 @@ static void fpsimd_bind_task_to_cpu(void)
 	WARN_ON(!system_supports_fpsimd());
 	last->st = &current->thread.uw.fpsimd_state;
 	last->sve_state = current->thread.sve_state;
+	last->za_state = current->thread.za_state;
 	last->sve_vl = task_get_sve_vl(current);
 	last->sme_vl = task_get_sme_vl(current);
 	current->thread.fpsimd_cpu = smp_processor_id();
@@ -1494,7 +1497,8 @@ static void fpsimd_bind_task_to_cpu(void)
 }
 
 void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st, void *sve_state,
-			      unsigned int sve_vl, unsigned int sme_vl)
+			      unsigned int sve_vl, void *za_state,
+			      unsigned int sme_vl)
 {
 	struct fpsimd_last_state_struct *last =
 		this_cpu_ptr(&fpsimd_last_state);
@@ -1504,6 +1508,7 @@ void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st, void *sve_state,
 
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

