Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6F24F94BC
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 13:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbiDHL6P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 07:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbiDHL6O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 07:58:14 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AC97DE39
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 04:56:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3CAF9CE2AD6
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 11:56:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC4FC385A8;
        Fri,  8 Apr 2022 11:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649418967;
        bh=zMK4+X/E8BiKU4OsP0bbTb6MKZU31enkNKmJz2lyrBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rcVokrFlVCVcna1tkL4J1McojqBl7cvD+O1vkt6czjgk9ypzO1GIAlt9TQu3vPG3l
         63xbLoSwMuDpVlo81+2dUD4S89txR+Kk8GEF/J2dJymlHEXrm2iwYPW4CwqftiNuWd
         4KSeSn/gpXcQS1Ks2q1RD82sMTgGAArb4sHpfUXCQOE2wekL3th5dD+OpaYYsdfdc/
         rjQ01fC7e+MBy89nLtBPw7xqEgaEV4FrgVND35dUkp4qYPhbPZe+bZbXSNAdU45pN2
         CrAcnfvZow3cAOP0MD5K0+nhVMD5nuIcrSS04qscKzHgC/NaCZCwlzYg6Nc3rVnebC
         45rKVhMdVM9ew==
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
Subject: [PATCH v13 13/39] arm64/sme: Implement SVCR context switching
Date:   Fri,  8 Apr 2022 12:43:02 +0100
Message-Id: <20220408114328.1401034-14-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220408114328.1401034-1-broonie@kernel.org>
References: <20220408114328.1401034-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6347; h=from:subject; bh=zMK4+X/E8BiKU4OsP0bbTb6MKZU31enkNKmJz2lyrBA=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiUB/JHfURw3wtglacxOiM9F73uun0WEztOKcfuau2 UCpeqbmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYlAfyQAKCRAk1otyXVSH0AtWB/ 4nfyU4olQWpcawSNznZObyUbRDakmcHbRIXZio26uUs2rRsPPnIWx+1GcaH939/8ROIObV2c72EDXv 4o7K2IAmRVk8/rToWA/tjzOe1yZmKNNOVG2n/WmE4HJDDw1mCXPKm8ci7NHxUyKNiDSGTJnkzYwgQn haXT5roLBBBQdONLu3uijoTI58/2z8vlgBUB4eeWGHvxqdFmMEOfFzXPC1mbJ3BoQ/nIQp6S/suIsm 76z9Z87XrkC7D5XEC9WjOf+XoAiFgrFzMQ42e8Jgc3VLRv3XKdP5F2agVj8dErPBPgvmSavEub3lGN /Kr3W0vsYqzyO8qXaeJtZOEr5urTht
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/fpsimd.h      |  3 ++-
 arch/arm64/include/asm/processor.h   |  1 +
 arch/arm64/include/asm/thread_info.h |  1 +
 arch/arm64/kernel/fpsimd.c           | 18 +++++++++++++++++-
 arch/arm64/kernel/process.c          |  2 ++
 arch/arm64/kvm/fpsimd.c              |  7 ++++++-
 6 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 38fd6aab7feb..821d270980da 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -46,7 +46,8 @@ extern void fpsimd_restore_current_state(void);
 extern void fpsimd_update_current_state(struct user_fpsimd_state const *state);
 
 extern void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *state,
-				     void *sve_state, unsigned int sve_vl);
+				     void *sve_state, unsigned int sve_vl,
+				     u64 *svcr);
 
 extern void fpsimd_flush_task_state(struct task_struct *target);
 extern void fpsimd_save_and_flush_cpu_state(void);
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 849e97d418a8..22cd11e86854 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -169,6 +169,7 @@ struct thread_struct {
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
index 231f2d85b65e..1c113349f6cc 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -121,6 +121,7 @@
 struct fpsimd_last_state_struct {
 	struct user_fpsimd_state *st;
 	void *sve_state;
+	u64 *svcr;
 	unsigned int sve_vl;
 };
 
@@ -359,6 +360,9 @@ static void task_fpsimd_load(void)
 	WARN_ON(!system_supports_fpsimd());
 	WARN_ON(!have_cpu_fpsimd_context());
 
+	if (IS_ENABLED(CONFIG_ARM64_SME) && test_thread_flag(TIF_SME))
+		write_sysreg_s(current->thread.svcr, SYS_SVCR_EL0);
+
 	if (IS_ENABLED(CONFIG_ARM64_SVE) && test_thread_flag(TIF_SVE)) {
 		sve_set_vq(sve_vq_from_vl(task_get_sve_vl(current)) - 1);
 		sve_load_state(sve_pffr(&current->thread),
@@ -390,6 +394,12 @@ static void fpsimd_save(void)
 	if (test_thread_flag(TIF_FOREIGN_FPSTATE))
 		return;
 
+	if (IS_ENABLED(CONFIG_ARM64_SME) &&
+	    test_thread_flag(TIF_SME)) {
+		u64 *svcr = last->svcr;
+		*svcr = read_sysreg_s(SYS_SVCR_EL0);
+	}
+
 	if (IS_ENABLED(CONFIG_ARM64_SVE) &&
 	    test_thread_flag(TIF_SVE)) {
 		if (WARN_ON(sve_get_vl() != last->sve_vl)) {
@@ -741,6 +751,10 @@ int vec_set_vector_length(struct task_struct *task, enum vec_type type,
 	if (test_and_clear_tsk_thread_flag(task, TIF_SVE))
 		sve_to_fpsimd(task);
 
+	if (system_supports_sme() && type == ARM64_VEC_SME)
+		task->thread.svcr &= ~(SYS_SVCR_EL0_SM_MASK |
+				       SYS_SVCR_EL0_ZA_MASK);
+
 	if (task == current)
 		put_cpu_fpsimd_context();
 
@@ -1404,6 +1418,7 @@ static void fpsimd_bind_task_to_cpu(void)
 	last->st = &current->thread.uw.fpsimd_state;
 	last->sve_state = current->thread.sve_state;
 	last->sve_vl = task_get_sve_vl(current);
+	last->svcr = &current->thread.svcr;
 	current->thread.fpsimd_cpu = smp_processor_id();
 
 	if (system_supports_sve()) {
@@ -1418,7 +1433,7 @@ static void fpsimd_bind_task_to_cpu(void)
 }
 
 void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st, void *sve_state,
-			      unsigned int sve_vl)
+			      unsigned int sve_vl, u64 *svcr)
 {
 	struct fpsimd_last_state_struct *last =
 		this_cpu_ptr(&fpsimd_last_state);
@@ -1427,6 +1442,7 @@ void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st, void *sve_state,
 	WARN_ON(!in_softirq() && !irqs_disabled());
 
 	last->st = st;
+	last->svcr = svcr;
 	last->sve_state = sve_state;
 	last->sve_vl = sve_vl;
 }
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index e20571f19718..07f235b46cf5 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -310,6 +310,8 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	dst->thread.sve_state = NULL;
 	clear_tsk_thread_flag(dst, TIF_SVE);
 
+	dst->thread.svcr = 0;
+
 	/* clear any pending asynchronous tag fault raised by the parent */
 	clear_tsk_thread_flag(dst, TIF_MTE_ASYNC_FAULT);
 
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 397fdac75cb1..ac09f1f682ff 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -109,9 +109,14 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
 	WARN_ON_ONCE(!irqs_disabled());
 
 	if (vcpu->arch.flags & KVM_ARM64_FP_ENABLED) {
+		/*
+		 * Currently we do not support SME guests so SVCR is
+		 * always 0 and we just need a variable to point to.
+		 */
 		fpsimd_bind_state_to_cpu(&vcpu->arch.ctxt.fp_regs,
 					 vcpu->arch.sve_state,
-					 vcpu->arch.sve_max_vl);
+					 vcpu->arch.sve_max_vl,
+					 NULL);
 
 		clear_thread_flag(TIF_FOREIGN_FPSTATE);
 		update_thread_flag(TIF_SVE, vcpu_has_sve(vcpu));
-- 
2.30.2

