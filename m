Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA714C4C6F
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 18:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243791AbiBYRgR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 12:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243792AbiBYRgP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 12:36:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EFC1CD9E4
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 09:35:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD284B832D7
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 17:35:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28F3C36AE5;
        Fri, 25 Feb 2022 17:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645810540;
        bh=bKRlABz3u84G2UNUD2G8e+8fvJXMj9EZ13cqxpGW3EU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fiXALh/s7lHWI5l2jspG68R3WXvmwGr2ZQXHEITFnsJdc1/bc3Iyc7GUn0vLojpXv
         AwkM8SDUqN28MAlKAsJx1445TZRJetCj54EJBfcEkkqv+S8IK5zJBrsYhabu3m2Nk/
         2h+A4lNnM3eRjqWPHvaoPhznEGK56tibNryi8LRANdiKmTsfoywEhGXisthwcRu0iB
         5ke6mNcg0wfoxUQwIreuz5pPfsKIiE9ckoSuIKoV0Uyr95d7zLxJk+B/vpZ+kq3iGc
         QrG815O/EhclZg9IC3Fk6KDDtgrKc3n6C9KcCbrNNmAuvvVkvh+0Wc8/F4z6DNSPso
         xep80c0vgVQKA==
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
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v12 20/40] arm64/sme: Implement streaming SVE signal handling
Date:   Fri, 25 Feb 2022 16:59:03 +0000
Message-Id: <20220225165923.1474372-21-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220225165923.1474372-1-broonie@kernel.org>
References: <20220225165923.1474372-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7630; h=from:subject; bh=bKRlABz3u84G2UNUD2G8e+8fvJXMj9EZ13cqxpGW3EU=; b=owGbwMvMwMWocq27KDak/QLjabUkhiRJrlsSZWJZctm5bzn/pjfyxNn1eC/u9tEuN5LfdW/72y8V O7o6GY1ZGBi5GGTFFFnWPstYlR4usXX+o/mvYAaxMoFMYeDiFICJTGRj/2f8aPPbHLMM9ZJ+LXY357 cJgiomH/myzJaKpymFMWt3y8eu2nPmd037w4fWgSa8s/fJe+j6SVWK6W92awtKLOC1WLzV1abiytWp X6tUz1llc7OHMs3MsJYv0lqx+Pm5wANfm/O/TveVVDA1XMHb8+u9/rxp7yVn3b7dJHFir3lcWNMF6x /bt+m+XLbcbvOB7RVOX5ZxTO4tqrV25Cw+cmH3HTnu/Wk11nf3zb6cobP/EDf7/M0Mk8yfHn63c29q eLgo66fuUz8nie1JDs6zdpildIf1xUQD83JW2RzZhV3K94+KakZslfveXObM98FF10kso80m6fKaK8 cEK8/+qQkU5kz357GfavkpnHMDAA==
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
---
 arch/arm64/include/asm/processor.h       |  8 +++++
 arch/arm64/include/uapi/asm/sigcontext.h | 16 +++++++--
 arch/arm64/kernel/signal.c               | 42 ++++++++++++++++++------
 3 files changed, 53 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 5a5c5edd76df..29e0f87b5dd5 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -189,6 +189,14 @@ static inline unsigned int thread_get_sme_vl(struct thread_struct *thread)
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
index 0c796c795dbe..3a3366d4fbc2 100644
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
+ * in vector length between the two modes is handled, including any resixing
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
index cda04fd73333..8931954e7b39 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -227,11 +227,17 @@ static int preserve_sve_context(struct sve_context __user *ctx)
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
 
@@ -239,6 +245,7 @@ static int preserve_sve_context(struct sve_context __user *ctx)
 	__put_user_error(round_up(SVE_SIG_CONTEXT_SIZE(vq), 16),
 			 &ctx->head.size, err);
 	__put_user_error(vl, &ctx->vl, err);
+	__put_user_error(flags, &ctx->flags, err);
 	BUILD_BUG_ON(sizeof(ctx->__reserved) != sizeof(reserved));
 	err |= __copy_to_user(&ctx->__reserved, reserved, sizeof(reserved));
 
@@ -259,18 +266,28 @@ static int preserve_sve_context(struct sve_context __user *ctx)
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
 
@@ -302,7 +319,10 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 	if (err)
 		return -EFAULT;
 
-	set_thread_flag(TIF_SVE);
+	if (sve.flags & SVE_SIG_FLAG_SM)
+		current->thread.svcr |= SYS_SVCR_EL0_SM_MASK;
+	else
+		set_thread_flag(TIF_SVE);
 
 fpsimd_only:
 	/* copy the FP and status/control registers */
@@ -394,7 +414,7 @@ static int parse_user_sigframe(struct user_ctxs *user,
 			break;
 
 		case SVE_MAGIC:
-			if (!system_supports_sve())
+			if (!system_supports_sve() && !system_supports_sme())
 				goto invalid;
 
 			if (user->sve)
@@ -593,11 +613,12 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
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
@@ -648,8 +669,9 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
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

