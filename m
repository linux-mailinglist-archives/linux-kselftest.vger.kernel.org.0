Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48E84C4C71
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 18:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243789AbiBYRgU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 12:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240739AbiBYRgU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 12:36:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151901D5293
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 09:35:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93282B832D3
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 17:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4BD1C340F0;
        Fri, 25 Feb 2022 17:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645810544;
        bh=joXtS2ShvIa2t7/hoE/cLAtRhER2+ANdV4mS02y5uRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ys6SvAJFMa640SrXdJkW6g8QdpdvmAPFGvi9gC5fK2ORDiL/EGHhZJVgW1PkPw8gY
         /pMvO4RqAzuqR7kgAV04Qv5Q6g+Tc0fyxr+Vs2Jw0qX8GZrKO77O4ULQode/NvIeNF
         jjzSGunSve8dPvNZ/NJQHyK+BQyOZlt2bo58l26dI9Jb0PTGsaiv+KAkzWQUZ8ZgCd
         aIlDyZ3nXdmGWqMD2slMzttwtrq6uGAzymOX5CdWcAKywIg35hUsnCeGKrtqVn/Ak0
         Q0x2DbspNGoJh4iBMbR5/RbiofPsh6gEyLW0v0MA6nUyXQjIMed8F6jtfO/2RT7WJb
         FYdhHrL+cPflQ==
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
Subject: [PATCH v12 21/40] arm64/sme: Implement ZA signal handling
Date:   Fri, 25 Feb 2022 16:59:04 +0000
Message-Id: <20220225165923.1474372-22-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220225165923.1474372-1-broonie@kernel.org>
References: <20220225165923.1474372-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8960; h=from:subject; bh=joXtS2ShvIa2t7/hoE/cLAtRhER2+ANdV4mS02y5uRE=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiGQratR8nhMRpLgdLCOdCWeCMEuOQVwvKx++O1f6e kkiHy/+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYhkK2gAKCRAk1otyXVSH0I6aB/ 48wuarxf0GPuPo/enxDQHPvheWQiAhvQoEhSAqSh9E/9YwhtyTWp6+5s50NP3Pv+ePDXAEmawaEGef qH5MTEvGMDmA1F4uDJrPHcWLD/YeOjFD/Qnwuxp/2L3ExAddhJwr1BFJ2KM6RP/vXh//UhkFFhfgAi t7Baw9WftJoeNs/sGpeLI+Pn9ZSS+JB/U4olkQsBgLIek0Kxl5oFNENtEsLhPglL2eRgIXp/PKR9VG K7nv5zocN93R8X0VWAeTZnatt8rVs3Jc3iBbkdL9cecKBBYtAqyS2vqw8m7Yd7OM3+ui23iQOMZ2JL vPUTGSM7brITYJMMNxuXw4v2oOgeys
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

Implement support for ZA in signal handling in a very similar way to how
we implement support for SVE registers, using a signal context structure
with optional register state after it. Where present this register state
stores the ZA matrix as a series of horizontal vectors numbered from 0 to
VL/8 in the endinanness independent format used for vectors.

As with SVE we do not allow changes in the vector length during signal
return but we do allow ZA to be enabled or disabled.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/uapi/asm/sigcontext.h |  41 +++++++
 arch/arm64/kernel/fpsimd.c               |   3 -
 arch/arm64/kernel/signal.c               | 139 +++++++++++++++++++++++
 3 files changed, 180 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/uapi/asm/sigcontext.h b/arch/arm64/include/uapi/asm/sigcontext.h
index 3a3366d4fbc2..d45bdf2c8b26 100644
--- a/arch/arm64/include/uapi/asm/sigcontext.h
+++ b/arch/arm64/include/uapi/asm/sigcontext.h
@@ -140,6 +140,14 @@ struct sve_context {
 
 #define SVE_SIG_FLAG_SM	0x1	/* Context describes streaming mode */
 
+#define ZA_MAGIC	0x54366345
+
+struct za_context {
+	struct _aarch64_ctx head;
+	__u16 vl;
+	__u16 __reserved[3];
+};
+
 #endif /* !__ASSEMBLY__ */
 
 #include <asm/sve_context.h>
@@ -259,4 +267,37 @@ struct sve_context {
 #define SVE_SIG_CONTEXT_SIZE(vq) \
 		(SVE_SIG_REGS_OFFSET + SVE_SIG_REGS_SIZE(vq))
 
+/*
+ * If the ZA register is enabled for the thread at signal delivery then,
+ * za_context.head.size >= ZA_SIG_CONTEXT_SIZE(sve_vq_from_vl(za_context.vl))
+ * and the register data may be accessed using the ZA_SIG_*() macros.
+ *
+ * If za_context.head.size < ZA_SIG_CONTEXT_SIZE(sve_vq_from_vl(za_context.vl))
+ * then ZA was not enabled and no register data was included in which case
+ * ZA register was not enabled for the thread and no register data
+ * the ZA_SIG_*() macros should not be used except for this check.
+ *
+ * The same convention applies when returning from a signal: a caller
+ * will need to remove or resize the za_context block if it wants to
+ * enable the ZA register when it was previously non-live or vice-versa.
+ * This may require the caller to allocate fresh memory and/or move other
+ * context blocks in the signal frame.
+ *
+ * Changing the vector length during signal return is not permitted:
+ * za_context.vl must equal the thread's current SME vector length when
+ * doing a sigreturn.
+ */
+
+#define ZA_SIG_REGS_OFFSET					\
+	((sizeof(struct za_context) + (__SVE_VQ_BYTES - 1))	\
+		/ __SVE_VQ_BYTES * __SVE_VQ_BYTES)
+
+#define ZA_SIG_REGS_SIZE(vq) ((vq * __SVE_VQ_BYTES) * (vq * __SVE_VQ_BYTES))
+
+#define ZA_SIG_ZAV_OFFSET(vq, n) (ZA_SIG_REGS_OFFSET + \
+				  (SVE_SIG_ZREG_SIZE(vq) * n))
+
+#define ZA_SIG_CONTEXT_SIZE(vq) \
+		(ZA_SIG_REGS_OFFSET + ZA_SIG_REGS_SIZE(vq))
+
 #endif /* _UAPI__ASM_SIGCONTEXT_H */
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index fb6a7d97156f..487b616ce380 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1175,9 +1175,6 @@ void fpsimd_release_task(struct task_struct *dead_task)
 
 #ifdef CONFIG_ARM64_SME
 
-/* This will move to uapi/asm/sigcontext.h when signals are implemented */
-#define ZA_SIG_REGS_SIZE(vq) ((vq * __SVE_VQ_BYTES) * (vq * __SVE_VQ_BYTES))
-
 /*
  * Ensure that task->thread.za_state is allocated and sufficiently large.
  *
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 8931954e7b39..38f4ce3040dc 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -57,6 +57,7 @@ struct rt_sigframe_user_layout {
 	unsigned long fpsimd_offset;
 	unsigned long esr_offset;
 	unsigned long sve_offset;
+	unsigned long za_offset;
 	unsigned long extra_offset;
 	unsigned long end_offset;
 };
@@ -219,6 +220,7 @@ static int restore_fpsimd_context(struct fpsimd_context __user *ctx)
 struct user_ctxs {
 	struct fpsimd_context __user *fpsimd;
 	struct sve_context __user *sve;
+	struct za_context __user *za;
 };
 
 #ifdef CONFIG_ARM64_SVE
@@ -347,6 +349,101 @@ extern int restore_sve_fpsimd_context(struct user_ctxs *user);
 
 #endif /* ! CONFIG_ARM64_SVE */
 
+#ifdef CONFIG_ARM64_SME
+
+static int preserve_za_context(struct za_context __user *ctx)
+{
+	int err = 0;
+	u16 reserved[ARRAY_SIZE(ctx->__reserved)];
+	unsigned int vl = task_get_sme_vl(current);
+	unsigned int vq;
+
+	if (thread_za_enabled(&current->thread))
+		vq = sve_vq_from_vl(vl);
+	else
+		vq = 0;
+
+	memset(reserved, 0, sizeof(reserved));
+
+	__put_user_error(ZA_MAGIC, &ctx->head.magic, err);
+	__put_user_error(round_up(ZA_SIG_CONTEXT_SIZE(vq), 16),
+			 &ctx->head.size, err);
+	__put_user_error(vl, &ctx->vl, err);
+	BUILD_BUG_ON(sizeof(ctx->__reserved) != sizeof(reserved));
+	err |= __copy_to_user(&ctx->__reserved, reserved, sizeof(reserved));
+
+	if (vq) {
+		/*
+		 * This assumes that the ZA state has already been saved to
+		 * the task struct by calling the function
+		 * fpsimd_signal_preserve_current_state().
+		 */
+		err |= __copy_to_user((char __user *)ctx + ZA_SIG_REGS_OFFSET,
+				      current->thread.za_state,
+				      ZA_SIG_REGS_SIZE(vq));
+	}
+
+	return err ? -EFAULT : 0;
+}
+
+static int restore_za_context(struct user_ctxs __user *user)
+{
+	int err;
+	unsigned int vq;
+	struct za_context za;
+
+	if (__copy_from_user(&za, user->za, sizeof(za)))
+		return -EFAULT;
+
+	if (za.vl != task_get_sme_vl(current))
+		return -EINVAL;
+
+	if (za.head.size <= sizeof(*user->za)) {
+		current->thread.svcr &= ~SYS_SVCR_EL0_ZA_MASK;
+		return 0;
+	}
+
+	vq = sve_vq_from_vl(za.vl);
+
+	if (za.head.size < ZA_SIG_CONTEXT_SIZE(vq))
+		return -EINVAL;
+
+	/*
+	 * Careful: we are about __copy_from_user() directly into
+	 * thread.za_state with preemption enabled, so protection is
+	 * needed to prevent a racing context switch from writing stale
+	 * registers back over the new data.
+	 */
+
+	fpsimd_flush_task_state(current);
+	/* From now, fpsimd_thread_switch() won't touch thread.sve_state */
+
+	sme_alloc(current);
+	if (!current->thread.za_state) {
+		current->thread.svcr &= ~SYS_SVCR_EL0_ZA_MASK;
+		clear_thread_flag(TIF_SME);
+		return -ENOMEM;
+	}
+
+	err = __copy_from_user(current->thread.za_state,
+			       (char __user const *)user->za +
+					ZA_SIG_REGS_OFFSET,
+			       ZA_SIG_REGS_SIZE(vq));
+	if (err)
+		return -EFAULT;
+
+	set_thread_flag(TIF_SME);
+	current->thread.svcr |= SYS_SVCR_EL0_ZA_MASK;
+
+	return 0;
+}
+#else /* ! CONFIG_ARM64_SME */
+
+/* Turn any non-optimised out attempts to use these into a link error: */
+extern int preserve_za_context(void __user *ctx);
+extern int restore_za_context(struct user_ctxs *user);
+
+#endif /* ! CONFIG_ARM64_SME */
 
 static int parse_user_sigframe(struct user_ctxs *user,
 			       struct rt_sigframe __user *sf)
@@ -361,6 +458,7 @@ static int parse_user_sigframe(struct user_ctxs *user,
 
 	user->fpsimd = NULL;
 	user->sve = NULL;
+	user->za = NULL;
 
 	if (!IS_ALIGNED((unsigned long)base, 16))
 		goto invalid;
@@ -426,6 +524,19 @@ static int parse_user_sigframe(struct user_ctxs *user,
 			user->sve = (struct sve_context __user *)head;
 			break;
 
+		case ZA_MAGIC:
+			if (!system_supports_sme())
+				goto invalid;
+
+			if (user->za)
+				goto invalid;
+
+			if (size < sizeof(*user->za))
+				goto invalid;
+
+			user->za = (struct za_context __user *)head;
+			break;
+
 		case EXTRA_MAGIC:
 			if (have_extra_context)
 				goto invalid;
@@ -549,6 +660,9 @@ static int restore_sigframe(struct pt_regs *regs,
 		}
 	}
 
+	if (err == 0 && system_supports_sme() && user.za)
+		err = restore_za_context(&user);
+
 	return err;
 }
 
@@ -629,6 +743,24 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
 			return err;
 	}
 
+	if (system_supports_sme()) {
+		unsigned int vl;
+		unsigned int vq = 0;
+
+		if (add_all)
+			vl = sme_max_vl();
+		else
+			vl = task_get_sme_vl(current);
+
+		if (thread_za_enabled(&current->thread))
+			vq = sve_vq_from_vl(vl);
+
+		err = sigframe_alloc(user, &user->za_offset,
+				     ZA_SIG_CONTEXT_SIZE(vq));
+		if (err)
+			return err;
+	}
+
 	return sigframe_alloc_end(user);
 }
 
@@ -677,6 +809,13 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
 		err |= preserve_sve_context(sve_ctx);
 	}
 
+	/* ZA state if present */
+	if (system_supports_sme() && err == 0 && user->za_offset) {
+		struct za_context __user *za_ctx =
+			apply_user_offset(user, user->za_offset);
+		err |= preserve_za_context(za_ctx);
+	}
+
 	if (err == 0 && user->extra_offset) {
 		char __user *sfp = (char __user *)user->sigframe;
 		char __user *userp =
-- 
2.30.2

