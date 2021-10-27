Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE0943D128
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 20:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243637AbhJ0Sy1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Oct 2021 14:54:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:33868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240388AbhJ0Sy0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Oct 2021 14:54:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91DBE610CB;
        Wed, 27 Oct 2021 18:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635360720;
        bh=ypMtkBodQoWB2wRkZNNCwhkatjEGMXYQqfzZPQr5N8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TdV4ycUTPZNci9Uamy6HYqG9UIICjodnIHhrSaAZ1AI1XRL7rGtcVGAjLAnUnlTEu
         w8CSi17jCLGJr7sSkHYAXg9fs6KFurrV+vs23hRax+xw/k8wRWs0YW/TvJxEzpa20r
         7LNMgeAFXT5SKGQVJMQkWczwdZmYKiOSHUDMnwHjc9HSgpBVgjD5KDhQqmvELBzsNN
         iw7qUPv8SimxFU1R0rFoQooJpr5bX0JdflNW63TvNtoNQJ+OtAebfh69ZhwM0+KxC+
         F9szc8++nw9ENN58TEtBkIw/5cbDG6Ac0ydzDCJDA8iT9QjZEwH22xPZLRDZ+Xfxej
         KcU77QMh109BQ==
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
Subject: [PATCH v5 24/38] arm64/sme: Implement ZA signal handling
Date:   Wed, 27 Oct 2021 19:44:10 +0100
Message-Id: <20211027184424.166237-25-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211027184424.166237-1-broonie@kernel.org>
References: <20211027184424.166237-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8969; h=from:subject; bh=ypMtkBodQoWB2wRkZNNCwhkatjEGMXYQqfzZPQr5N8g=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBheZ35XpPJIL4bG8baCRzBzj2qDZnUgszNeqyFgSYx rLlFSZGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYXmd+QAKCRAk1otyXVSH0A1HB/ 9Jn87NTKvNh7LSsJQ+PMjNJYgahHMp7aZTu6hBrxKJTjJrDS64D5DnKC9uGSkDsEkAspPe3coQT/cM XnKnfpZHW5Uabsu+zObRfJiXIQ43EkdCvbWJLPRDaTLV0FBHSpk+KS3TDwTU/TzHhtBIXPtdwz01ay ZukyV8RegzPCyVrcwOeHROl0x5LJsbwicnnzzqkzJuf4cSs8ABouLFA/b9fEJDcTgPIcvGZCjkuBMV LdjKdhf7+pAA2YFUDSYYxKx/4sXLb1kUg4s4NmSqXAPIvDR4EQIxmu2GtfMaiRabsBbefMwo5U5zYf sj0FIQTsp80rzLDXHGSCZf94kj0H/+
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
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
index e2b254752f5f..31d11dce0289 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1177,9 +1177,6 @@ void fpsimd_release_task(struct task_struct *dead_task)
 
 #ifdef CONFIG_ARM64_SME
 
-/* This will move to uapi/asm/sigcontext.h when signals are implemented */
-#define ZA_SIG_REGS_SIZE(vq) ((vq * __SVE_VQ_BYTES) * (vq * __SVE_VQ_BYTES))
-
 /*
  * Return how many bytes of memory are required to store the full SME
  * specific state (currently just ZA) for task, given task's currently
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index fea0e1d30449..c0007ddf0c06 100644
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
+	__put_user_error(round_up(SVE_SIG_CONTEXT_SIZE(vq), 16),
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
 
@@ -633,6 +747,24 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
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
 
@@ -681,6 +813,13 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
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

