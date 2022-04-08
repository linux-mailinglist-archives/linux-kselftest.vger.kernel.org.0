Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9FD34F94C6
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 13:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiDHL6e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 07:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbiDHL6c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 07:58:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8A1710D2
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 04:56:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37E2762068
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 11:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6CBC385A8;
        Fri,  8 Apr 2022 11:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649418987;
        bh=7rd0IC4Ut/B7DF5U1uRzfVQPLjdhlp+a3aJxoGx5LFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K50wjveX68I+mC11FwlFo8znshJsa++Tc1d1w2//1ZF3XMB7R1tb2X0MVG1+4PlW6
         81voSMb18Xzb1ITb1UXv7xeOE0N1KXfRsfdROd2KkU1bh0W0Goy0wd5EsYSr0fX2/V
         y5kz1H5WcC+JN5447kM0p+La6vaw/2uX0JlOun+gkYqtrGEKttIHUPvZFwnqAb3/1K
         Iw6LaYjzHrnupsNtli9Hr0gXZyTOBCBs6nJ+dHjFKLPko21jequvNgTm4y4YuMuqDj
         GmhO94fAThzCCeJkQrAB3ZPWGO8ksRVFFxoSF4uCKsQuTUp/C7rCVHzFEnyItlOInl
         fq43O7uzUz3XQ==
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
Subject: [PATCH v13 18/39] arm64/sme: Implement streaming SVE signal handling
Date:   Fri,  8 Apr 2022 12:43:07 +0100
Message-Id: <20220408114328.1401034-19-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220408114328.1401034-1-broonie@kernel.org>
References: <20220408114328.1401034-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7686; h=from:subject; bh=7rd0IC4Ut/B7DF5U1uRzfVQPLjdhlp+a3aJxoGx5LFQ=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiUB/N/hw36P/erH17vQWZOAlA7af1bG850QdO+7uB JFSVdaaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYlAfzQAKCRAk1otyXVSH0BEZB/ 9GdbHr4wR5njs0aHYAIGMg0QnHtOiUPe4JxboWGcHTvd4vKZvxMY19Zh4tNvkjFjtobv4VAdJSVHoy W3HsmcLjcxi6XpCuGO2McuVSExX4Kk3MSyopOJeetQ9gGhOGWN6BtYLM3K990QkyUgHIY6oLcfCyS+ 29BYG6TALJl83TjNkNcHi9v75TavfzzmAXDZQ0FYoRMkkSJOksEabgxdWswZQUI+JE5GJ1JClU0f+m HypO/YqI7qJvJS6d3wG+O/g0rHnJmN2POPjGM8v6SaMCDai2L0r+GmPTolQVHWKK4sTdnAyOFNym0e K2mluI42EIU3R3Tgaq7/zKjpF6IFwP
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When in streaming mode we have the same set of SVE registers as we do in
regular SVE mode with the exception of FFR and the use of the SME vector
length. Provide signal handling for these registers by taking one of the
reserved words in the SVE signal context as a flags field and defining a
flag which is set for streaming mode. When the flag is set the vector
length is set to the streaming mode vector length and we save and
restore streaming mode data. We support entering or leaving streaming
mode based on the value of the flag but do not support changing the
vector length, this is not currently supported SVE signal handling.

We could instead allocate a separate record in the signal frame for the
streaming mode SVE context but this inflates the size of the maximal signal
frame required and adds complication when validating signal frames from
userspace, especially given the current structure of the code.

Any implementation of support for streaming mode vectors in signals will
have some potential for causing issues for applications that attempt to
handle SVE vectors in signals, use streaming mode but do not understand
streaming mode in their signal handling code, it is hard to identify a
case that is clearly better than any other - they all have cases where
they could cause unexpected register corruption or faults.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/processor.h       |  8 +++++
 arch/arm64/include/uapi/asm/sigcontext.h | 16 +++++++--
 arch/arm64/kernel/signal.c               | 42 ++++++++++++++++++------
 3 files changed, 53 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 6a3a6c3dec90..1d2ca4870b84 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -190,6 +190,14 @@ static inline unsigned int thread_get_sme_vl(struct thread_struct *thread)
 	return thread_get_vl(thread, ARM64_VEC_SME);
 }
 
+static inline unsigned int thread_get_cur_vl(struct thread_struct *thread)
+{
+	if (system_supports_sme() && (thread->svcr & SYS_SVCR_EL0_SM_MASK))
+		return thread_get_sme_vl(thread);
+	else
+		return thread_get_sve_vl(thread);
+}
+
 unsigned int task_get_vl(const struct task_struct *task, enum vec_type type);
 void task_set_vl(struct task_struct *task, enum vec_type type,
 		 unsigned long vl);
diff --git a/arch/arm64/include/uapi/asm/sigcontext.h b/arch/arm64/include/uapi/asm/sigcontext.h
index 0c796c795dbe..57e9f8c3ee9e 100644
--- a/arch/arm64/include/uapi/asm/sigcontext.h
+++ b/arch/arm64/include/uapi/asm/sigcontext.h
@@ -134,9 +134,12 @@ struct extra_context {
 struct sve_context {
 	struct _aarch64_ctx head;
 	__u16 vl;
-	__u16 __reserved[3];
+	__u16 flags;
+	__u16 __reserved[2];
 };
 
+#define SVE_SIG_FLAG_SM	0x1	/* Context describes streaming mode */
+
 #endif /* !__ASSEMBLY__ */
 
 #include <asm/sve_context.h>
@@ -186,9 +189,16 @@ struct sve_context {
  * sve_context.vl must equal the thread's current vector length when
  * doing a sigreturn.
  *
+ * On systems with support for SME the SVE register state may reflect either
+ * streaming or non-streaming mode.  In streaming mode the streaming mode
+ * vector length will be used and the flag SVE_SIG_FLAG_SM will be set in
+ * the flags field. It is permitted to enter or leave streaming mode in
+ * a signal return, applications should take care to ensure that any difference
+ * in vector length between the two modes is handled, including any resizing
+ * and movement of context blocks.
  *
- * Note: for all these macros, the "vq" argument denotes the SVE
- * vector length in quadwords (i.e., units of 128 bits).
+ * Note: for all these macros, the "vq" argument denotes the vector length
+ * in quadwords (i.e., units of 128 bits).
  *
  * The correct way to obtain vq is to use sve_vq_from_vl(vl).  The
  * result is valid if and only if sve_vl_valid(vl) is true.  This is
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 42efa464e46e..0ddce6afd2a3 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -226,11 +226,17 @@ static int preserve_sve_context(struct sve_context __user *ctx)
 {
 	int err = 0;
 	u16 reserved[ARRAY_SIZE(ctx->__reserved)];
+	u16 flags = 0;
 	unsigned int vl = task_get_sve_vl(current);
 	unsigned int vq = 0;
 
-	if (test_thread_flag(TIF_SVE))
+	if (thread_sm_enabled(&current->thread)) {
+		vl = task_get_sme_vl(current);
 		vq = sve_vq_from_vl(vl);
+		flags |= SVE_SIG_FLAG_SM;
+	} else if (test_thread_flag(TIF_SVE)) {
+		vq = sve_vq_from_vl(vl);
+	}
 
 	memset(reserved, 0, sizeof(reserved));
 
@@ -238,6 +244,7 @@ static int preserve_sve_context(struct sve_context __user *ctx)
 	__put_user_error(round_up(SVE_SIG_CONTEXT_SIZE(vq), 16),
 			 &ctx->head.size, err);
 	__put_user_error(vl, &ctx->vl, err);
+	__put_user_error(flags, &ctx->flags, err);
 	BUILD_BUG_ON(sizeof(ctx->__reserved) != sizeof(reserved));
 	err |= __copy_to_user(&ctx->__reserved, reserved, sizeof(reserved));
 
@@ -258,18 +265,28 @@ static int preserve_sve_context(struct sve_context __user *ctx)
 static int restore_sve_fpsimd_context(struct user_ctxs *user)
 {
 	int err;
-	unsigned int vq;
+	unsigned int vl, vq;
 	struct user_fpsimd_state fpsimd;
 	struct sve_context sve;
 
 	if (__copy_from_user(&sve, user->sve, sizeof(sve)))
 		return -EFAULT;
 
-	if (sve.vl != task_get_sve_vl(current))
+	if (sve.flags & SVE_SIG_FLAG_SM) {
+		if (!system_supports_sme())
+			return -EINVAL;
+
+		vl = task_get_sme_vl(current);
+	} else {
+		vl = task_get_sve_vl(current);
+	}
+
+	if (sve.vl != vl)
 		return -EINVAL;
 
 	if (sve.head.size <= sizeof(*user->sve)) {
 		clear_thread_flag(TIF_SVE);
+		current->thread.svcr &= ~SYS_SVCR_EL0_SM_MASK;
 		goto fpsimd_only;
 	}
 
@@ -301,7 +318,10 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 	if (err)
 		return -EFAULT;
 
-	set_thread_flag(TIF_SVE);
+	if (sve.flags & SVE_SIG_FLAG_SM)
+		current->thread.svcr |= SYS_SVCR_EL0_SM_MASK;
+	else
+		set_thread_flag(TIF_SVE);
 
 fpsimd_only:
 	/* copy the FP and status/control registers */
@@ -393,7 +413,7 @@ static int parse_user_sigframe(struct user_ctxs *user,
 			break;
 
 		case SVE_MAGIC:
-			if (!system_supports_sve())
+			if (!system_supports_sve() && !system_supports_sme())
 				goto invalid;
 
 			if (user->sve)
@@ -594,11 +614,12 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
 	if (system_supports_sve()) {
 		unsigned int vq = 0;
 
-		if (add_all || test_thread_flag(TIF_SVE)) {
-			int vl = sve_max_vl();
+		if (add_all || test_thread_flag(TIF_SVE) ||
+		    thread_sm_enabled(&current->thread)) {
+			int vl = max(sve_max_vl(), sme_max_vl());
 
 			if (!add_all)
-				vl = task_get_sve_vl(current);
+				vl = thread_get_cur_vl(&current->thread);
 
 			vq = sve_vq_from_vl(vl);
 		}
@@ -649,8 +670,9 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
 		__put_user_error(current->thread.fault_code, &esr_ctx->esr, err);
 	}
 
-	/* Scalable Vector Extension state, if present */
-	if (system_supports_sve() && err == 0 && user->sve_offset) {
+	/* Scalable Vector Extension state (including streaming), if present */
+	if ((system_supports_sve() || system_supports_sme()) &&
+	    err == 0 && user->sve_offset) {
 		struct sve_context __user *sve_ctx =
 			apply_user_offset(user, user->sve_offset);
 		err |= preserve_sve_context(sve_ctx);
-- 
2.30.2

