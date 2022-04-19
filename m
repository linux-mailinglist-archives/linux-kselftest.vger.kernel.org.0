Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA99506A30
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Apr 2022 13:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351028AbiDSL1P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Apr 2022 07:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351266AbiDSL1O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Apr 2022 07:27:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E535F98
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 04:24:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D019FB81851
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 11:24:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5FDC385B0;
        Tue, 19 Apr 2022 11:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650367469;
        bh=CRnYi1+F25vZYgWfMuYOtP8LUDjfuI23zBU5rgdKUa8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h9+tqkFQ/I9pMBxvUq+zvvG+OUeSzPgSnNQlGpy/fNRqxgk82Vd9sfEXegb1/h74v
         j5+rU/KhUPuVR0ZxS5U7c1kisNFspdACx9remaxbCyH8Nn8koxXYAVZn0tfR1+eZuR
         ui+Lj9VsIvWcCWe7wy5CR5TWQKV+nm219GaBqNSA6FnFe/G7pNib/2b879ZsIgbIbr
         DRm4WJ8bHsR5YEV7Jl9ITPKn6szPQ2pD6q3+DHke0F7n/bJ6sao73C28mjYvOMMdcX
         8bNEWD2Dzt8Jcf+wuVi+ewN+DjnYN8XhPrG+o107LlxZMoXxn+EJFs1pcEIUEiawYD
         U/4djfWW4wNDw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Luca Salabrino <luca.scalabrino@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v14 15/39] arm64/sme: Implement ZA context switching
Date:   Tue, 19 Apr 2022 12:22:23 +0100
Message-Id: <20220419112247.711548-16-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419112247.711548-1-broonie@kernel.org>
References: <20220419112247.711548-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7706; h=from:subject; bh=CRnYi1+F25vZYgWfMuYOtP8LUDjfuI23zBU5rgdKUa8=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiXptzNp57synQSyC0Ge0DquiGpZ1fi07+j4b2bw5j i0nbb4KJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYl6bcwAKCRAk1otyXVSH0I6nB/ 93SBFXyfWIdbNbz7vkc9kTvthTU5Z/sP7NlFzMAX5t2PrxhTl5zH/Qbz4+w2Wigv1p8zpcn+9unaav h6ChzAqROQzYxdVI4ZRkaaBx8ibA7D0PUv0EkNp6KGGzamnw2dPTwTY9+LFl10LhOmrl3MpvYb+OXM fLUhD2FYbXQAHky4EAIh4zcAR7O0hiomSwlrGWJDUjRcbOLMGcEJBkJCc3HBy0D40Sn6hsRG981qAj JzKPVlxaiKNLWw3UPTuQc+REyBJOFiDM+dxUkM/hUSSIO5vdt4uwKaWZPmlVjSSJb8kEN9753dh14R oSnQG9ebq2BxEy3dsjRPAr4GYe64Vb
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/fpsimd.h       |  5 ++++-
 arch/arm64/include/asm/fpsimdmacros.h | 22 ++++++++++++++++++++++
 arch/arm64/include/asm/kvm_host.h     |  3 +++
 arch/arm64/include/asm/processor.h    |  1 +
 arch/arm64/kernel/entry-fpsimd.S      | 22 ++++++++++++++++++++++
 arch/arm64/kernel/fpsimd.c            | 20 +++++++++++++-------
 arch/arm64/kvm/fpsimd.c               |  2 +-
 7 files changed, 66 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index cd94f5c5b516..1a709c03bb6c 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -47,7 +47,8 @@ extern void fpsimd_update_current_state(struct user_fpsimd_state const *state);
 
 extern void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *state,
 				     void *sve_state, unsigned int sve_vl,
-				     unsigned int sme_vl, u64 *svcr);
+				     void *za_state, unsigned int sme_vl,
+				     u64 *svcr);
 
 extern void fpsimd_flush_task_state(struct task_struct *target);
 extern void fpsimd_save_and_flush_cpu_state(void);
@@ -90,6 +91,8 @@ extern void sve_flush_live(bool flush_ffr, unsigned long vq_minus_1);
 extern unsigned int sve_get_vl(void);
 extern void sve_set_vq(unsigned long vq_minus_1);
 extern void sme_set_vq(unsigned long vq_minus_1);
+extern void za_save_state(void *state);
+extern void za_load_state(void const *state);
 
 struct arm64_cpu_capabilities;
 extern void sve_kernel_enable(const struct arm64_cpu_capabilities *__unused);
diff --git a/arch/arm64/include/asm/fpsimdmacros.h b/arch/arm64/include/asm/fpsimdmacros.h
index f6ab36e0cd8d..5e0910cf4832 100644
--- a/arch/arm64/include/asm/fpsimdmacros.h
+++ b/arch/arm64/include/asm/fpsimdmacros.h
@@ -319,3 +319,25 @@
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
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 94a27a7520f4..8a7c442d5b57 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -295,8 +295,11 @@ struct vcpu_reset_state {
 
 struct kvm_vcpu_arch {
 	struct kvm_cpu_context ctxt;
+
+	/* Guest floating point state */
 	void *sve_state;
 	unsigned int sve_max_vl;
+	u64 svcr;
 
 	/* Stage 2 paging state used by the hardware on next switch */
 	struct kvm_s2_mmu *hw_mmu;
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 7542310b4e6b..6a3a6c3dec90 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -154,6 +154,7 @@ struct thread_struct {
 
 	unsigned int		fpsimd_cpu;
 	void			*sve_state;	/* SVE registers, if any */
+	void			*za_state;	/* ZA register, if any */
 	unsigned int		vl[ARM64_VEC_MAX];	/* vector length */
 	unsigned int		vl_onexec[ARM64_VEC_MAX]; /* vl after next exec */
 	unsigned long		fault_address;	/* fault info */
diff --git a/arch/arm64/kernel/entry-fpsimd.S b/arch/arm64/kernel/entry-fpsimd.S
index 6f88c0f86d50..229436f33df5 100644
--- a/arch/arm64/kernel/entry-fpsimd.S
+++ b/arch/arm64/kernel/entry-fpsimd.S
@@ -99,4 +99,26 @@ SYM_FUNC_START(sme_set_vq)
 	ret
 SYM_FUNC_END(sme_set_vq)
 
+/*
+ * Save the SME state
+ *
+ * x0 - pointer to buffer for state
+ */
+SYM_FUNC_START(za_save_state)
+	_sme_rdsvl	1, 1		// x1 = VL/8
+	sme_save_za 0, x1, 12
+	ret
+SYM_FUNC_END(za_save_state)
+
+/*
+ * Load the SME state
+ *
+ * x0 - pointer to buffer for state
+ */
+SYM_FUNC_START(za_load_state)
+	_sme_rdsvl	1, 1		// x1 = VL/8
+	sme_load_za 0, x1, 12
+	ret
+SYM_FUNC_END(za_load_state)
+
 #endif /* CONFIG_ARM64_SME */
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index f8506a875eb2..dc38f3f2a28a 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -121,6 +121,7 @@
 struct fpsimd_last_state_struct {
 	struct user_fpsimd_state *st;
 	void *sve_state;
+	void *za_state;
 	u64 *svcr;
 	unsigned int sve_vl;
 	unsigned int sme_vl;
@@ -387,11 +388,15 @@ static void task_fpsimd_load(void)
 	if (system_supports_sme()) {
 		unsigned long sme_vl = task_get_sme_vl(current);
 
+		/* Ensure VL is set up for restoring data */
 		if (test_thread_flag(TIF_SME))
 			sme_set_vq(sve_vq_from_vl(sme_vl) - 1);
 
 		write_sysreg_s(current->thread.svcr, SYS_SVCR_EL0);
 
+		if (thread_za_enabled(&current->thread))
+			za_load_state(current->thread.za_state);
+
 		if (thread_sm_enabled(&current->thread)) {
 			restore_sve_regs = true;
 			restore_ffr = system_supports_fa64();
@@ -441,11 +446,10 @@ static void fpsimd_save(void)
 		u64 *svcr = last->svcr;
 		*svcr = read_sysreg_s(SYS_SVCR_EL0);
 
-		if (thread_za_enabled(&current->thread)) {
-			/* ZA state managment is not implemented yet */
-			force_signal_inject(SIGKILL, SI_KERNEL, 0, 0);
-			return;
-		}
+		*svcr = read_sysreg_s(SYS_SVCR_EL0);
+
+		if (*svcr & SYS_SVCR_EL0_ZA_MASK)
+			za_save_state(last->za_state);
 
 		/* If we are in streaming mode override regular SVE. */
 		if (*svcr & SYS_SVCR_EL0_SM_MASK) {
@@ -1483,6 +1487,7 @@ static void fpsimd_bind_task_to_cpu(void)
 	WARN_ON(!system_supports_fpsimd());
 	last->st = &current->thread.uw.fpsimd_state;
 	last->sve_state = current->thread.sve_state;
+	last->za_state = current->thread.za_state;
 	last->sve_vl = task_get_sve_vl(current);
 	last->sme_vl = task_get_sme_vl(current);
 	last->svcr = &current->thread.svcr;
@@ -1500,8 +1505,8 @@ static void fpsimd_bind_task_to_cpu(void)
 }
 
 void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st, void *sve_state,
-			      unsigned int sve_vl, unsigned int sme_vl,
-			      u64 *svcr)
+			      unsigned int sve_vl, void *za_state,
+			      unsigned int sme_vl, u64 *svcr)
 {
 	struct fpsimd_last_state_struct *last =
 		this_cpu_ptr(&fpsimd_last_state);
@@ -1512,6 +1517,7 @@ void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st, void *sve_state,
 	last->st = st;
 	last->svcr = svcr;
 	last->sve_state = sve_state;
+	last->za_state = za_state;
 	last->sve_vl = sve_vl;
 	last->sme_vl = sme_vl;
 }
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 394e583bb73e..57d7ac3cfa0c 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -116,7 +116,7 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
 		fpsimd_bind_state_to_cpu(&vcpu->arch.ctxt.fp_regs,
 					 vcpu->arch.sve_state,
 					 vcpu->arch.sve_max_vl,
-					 0, NULL);
+					 NULL, 0, &vcpu->arch.svcr);
 
 		clear_thread_flag(TIF_FOREIGN_FPSTATE);
 		update_thread_flag(TIF_SVE, vcpu_has_sve(vcpu));
-- 
2.30.2

