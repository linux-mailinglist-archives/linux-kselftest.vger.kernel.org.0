Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FD56263DB
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 22:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbiKKVvd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Nov 2022 16:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbiKKVvZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Nov 2022 16:51:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B946B203
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 13:51:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C97C962103
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 21:51:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9DEC43470;
        Fri, 11 Nov 2022 21:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668203483;
        bh=gqqU9mq6qOVcKT2rPaWnupV2Z7inErUAfg5WJJ3Pu+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d2LOHxgFkE9erPxaIf0m/0NMQVXjqv4UNDJEppVBJVCUlyULJ5HwGyxKdr4wCaz7h
         IkWb8pxz9Ncb1s9g8pNN1NxjyAO1shvMdqKPbImyzjURM9inee+j/iDGtK9tJaYDL8
         vRnNJM6jKUQDXrJhaj6zoAc+y4IFil74IJn3tUsEfjqESbAu+ldVOZXR6bcdaayAff
         wn48ABP1wcdCNpzAteZLqbUAbKf0IxvDYOAYu8E5HFpSyjJvW3J2ZCcPSRLFbZz4Ma
         26Xs8bQHEaC5Je6SSgbTtEbV8VWV+Hpwr1mfxlckhUuzTZ1zLKeAvVam82OnvznezE
         MSY3zxpnoDfzQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 11/21] arm64/sme: Implement signal handling for ZT
Date:   Fri, 11 Nov 2022 21:50:16 +0000
Message-Id: <20221111215026.813348-12-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221111215026.813348-1-broonie@kernel.org>
References: <20221111215026.813348-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7263; i=broonie@kernel.org; h=from:subject; bh=gqqU9mq6qOVcKT2rPaWnupV2Z7inErUAfg5WJJ3Pu+o=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjbsOXBawn7KIyMoylCz7Pt9d+wpnURM7Al75/pdUm ZnSrM+iJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY27DlwAKCRAk1otyXVSH0BbOB/ 94QtAoPR4hPoi/GSQq3CtHV4JggrT62jeoAdQgeUA48fWgDuI7AnCg5y+bRY9F/TEb4pyG4LGTyrqe 6GwRGv8lY8BCNJPwH2fuM86vUS7f2SsxI2M2+Vknbd2nFdgoIcOQvV4NueTfmO11t7+kJyyhNFoKDl 38N/Z7Uf1QJGQRO4/ZobR0qHvAiuMkC/0sZXh8zh2eILDlGsZQZDqo4GqQAjqEJhSVYMu3Gg/jkU+3 YSHPecwjCB44eWVU2vRdyg+H3Kmk5daBEexabhiDadR3OMfc7zOzRg/RPMAGdakLiQLS0p4p1M0ubs y3MMsACnnWiEnw+Y1jW5v2JTYBenha
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a new signal context type for ZT which is present in the signal frame
when ZA is enabled and ZT is supported by the system. In order to account
for the possible addition of further ZT registers in the future we make the
number of registers variable in the ABI, though currently the only possible
number is 1. We could just use a bare list head for the context since the
number of registers can be inferred from the size of the context but for
usability and future extensibility we define a header with the number of
registers and some reserved fields in it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/fpsimd.h          |   3 -
 arch/arm64/include/uapi/asm/sigcontext.h |  19 ++++
 arch/arm64/kernel/signal.c               | 105 +++++++++++++++++++++++
 3 files changed, 124 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 42c019936dfd..5c93cb5337c9 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -352,9 +352,6 @@ extern unsigned int sme_get_vl(void);
 extern int sme_set_current_vl(unsigned long arg);
 extern int sme_get_current_vl(void);
 
-/* Will move with signal support */
-#define ZT_SIG_REG_SIZE 512
-
 /*
  * Return how many bytes of memory are required to store the full SME
  * specific state for task, given task's currently configured vector
diff --git a/arch/arm64/include/uapi/asm/sigcontext.h b/arch/arm64/include/uapi/asm/sigcontext.h
index 4aaf31e3bf16..177f16cc96b8 100644
--- a/arch/arm64/include/uapi/asm/sigcontext.h
+++ b/arch/arm64/include/uapi/asm/sigcontext.h
@@ -148,6 +148,14 @@ struct za_context {
 	__u16 __reserved[3];
 };
 
+#define ZT_MAGIC	0x5a544e01
+
+struct zt_context {
+	struct _aarch64_ctx head;
+	__u16 nregs;
+	__u16 __reserved[3];
+};
+
 #endif /* !__ASSEMBLY__ */
 
 #include <asm/sve_context.h>
@@ -300,4 +308,15 @@ struct za_context {
 #define ZA_SIG_CONTEXT_SIZE(vq) \
 		(ZA_SIG_REGS_OFFSET + ZA_SIG_REGS_SIZE(vq))
 
+#define ZT_SIG_REG_SIZE 512
+
+#define ZT_SIG_REG_BYTES (ZT_SIG_REG_SIZE / 8)
+
+#define ZT_SIG_REGS_OFFSET sizeof(struct zt_context)
+
+#define ZT_SIG_REGS_SIZE(n) (ZT_SIG_REG_BYTES * n)
+
+#define ZT_SIG_CONTEXT_SIZE(n) \
+	(sizeof(struct zt_context) + ZT_SIG_REGS_SIZE(n))
+
 #endif /* _UAPI__ASM_SIGCONTEXT_H */
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 335bc7294b3c..6e20f0b23d73 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -57,6 +57,7 @@ struct rt_sigframe_user_layout {
 	unsigned long esr_offset;
 	unsigned long sve_offset;
 	unsigned long za_offset;
+	unsigned long zt_offset;
 	unsigned long extra_offset;
 	unsigned long end_offset;
 };
@@ -220,6 +221,7 @@ struct user_ctxs {
 	struct fpsimd_context __user *fpsimd;
 	struct sve_context __user *sve;
 	struct za_context __user *za;
+	struct zt_context __user *zt;
 };
 
 #ifdef CONFIG_ARM64_SVE
@@ -444,11 +446,81 @@ static int restore_za_context(struct user_ctxs *user)
 
 	return 0;
 }
+
+static int preserve_zt_context(struct zt_context __user *ctx)
+{
+	int err = 0;
+	u16 reserved[ARRAY_SIZE(ctx->__reserved)];
+
+	if (WARN_ON(!thread_za_enabled(&current->thread)))
+		return -EINVAL;
+
+	memset(reserved, 0, sizeof(reserved));
+
+	__put_user_error(ZT_MAGIC, &ctx->head.magic, err);
+	__put_user_error(round_up(ZT_SIG_CONTEXT_SIZE(1), 16),
+			 &ctx->head.size, err);
+	__put_user_error(1, &ctx->nregs, err);
+	BUILD_BUG_ON(sizeof(ctx->__reserved) != sizeof(reserved));
+	err |= __copy_to_user(&ctx->__reserved, reserved, sizeof(reserved));
+
+	/*
+	 * This assumes that the ZT state has already been saved to
+	 * the task struct by calling the function
+	 * fpsimd_signal_preserve_current_state().
+	 */
+	err |= __copy_to_user((char __user *)ctx + ZT_SIG_REGS_OFFSET,
+			      thread_zt_state(&current->thread),
+			      ZT_SIG_REGS_SIZE(1));
+
+	return err ? -EFAULT : 0;
+}
+
+static int restore_zt_context(struct user_ctxs *user)
+{
+	int err;
+	struct zt_context zt;
+
+	/* ZA must be restored first for this check to be valid */
+	if (!thread_za_enabled(&current->thread))
+		return -EINVAL;
+
+	if (__copy_from_user(&zt, user->zt, sizeof(zt)))
+		return -EFAULT;
+
+	if (zt.nregs != 1)
+		return -EINVAL;
+
+	if (zt.head.size != ZT_SIG_CONTEXT_SIZE(zt.nregs))
+		return -EINVAL;
+
+	/*
+	 * Careful: we are about __copy_from_user() directly into
+	 * thread.zt_state with preemption enabled, so protection is
+	 * needed to prevent a racing context switch from writing stale
+	 * registers back over the new data.
+	 */
+
+	fpsimd_flush_task_state(current);
+	/* From now, fpsimd_thread_switch() won't touch ZT in thread state */
+
+	err = __copy_from_user(thread_zt_state(&current->thread),
+			       (char __user const *)user->zt +
+					ZT_SIG_REGS_OFFSET,
+			       ZT_SIG_REGS_SIZE(1));
+	if (err)
+		return -EFAULT;
+
+	return 0;
+}
+
 #else /* ! CONFIG_ARM64_SME */
 
 /* Turn any non-optimised out attempts to use these into a link error: */
 extern int preserve_za_context(void __user *ctx);
 extern int restore_za_context(struct user_ctxs *user);
+extern int preserve_zt_context(void __user *ctx);
+extern int restore_zt_context(struct user_ctxs *user);
 
 #endif /* ! CONFIG_ARM64_SME */
 
@@ -466,6 +538,7 @@ static int parse_user_sigframe(struct user_ctxs *user,
 	user->fpsimd = NULL;
 	user->sve = NULL;
 	user->za = NULL;
+	user->zt = NULL;
 
 	if (!IS_ALIGNED((unsigned long)base, 16))
 		goto invalid;
@@ -544,6 +617,19 @@ static int parse_user_sigframe(struct user_ctxs *user,
 			user->za = (struct za_context __user *)head;
 			break;
 
+		case ZT_MAGIC:
+			if (!system_supports_sme2())
+				goto invalid;
+
+			if (user->zt)
+				goto invalid;
+
+			if (size < sizeof(*user->zt))
+				goto invalid;
+
+			user->zt = (struct zt_context __user *)head;
+			break;
+
 		case EXTRA_MAGIC:
 			if (have_extra_context)
 				goto invalid;
@@ -666,6 +752,9 @@ static int restore_sigframe(struct pt_regs *regs,
 	if (err == 0 && system_supports_sme() && user.za)
 		err = restore_za_context(&user);
 
+	if (err == 0 && system_supports_sme2() && user.zt)
+		err = restore_zt_context(&user);
+
 	return err;
 }
 
@@ -766,6 +855,15 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
 			return err;
 	}
 
+	if (system_supports_sme2()) {
+		if (add_all || thread_za_enabled(&current->thread)) {
+			err = sigframe_alloc(user, &user->zt_offset,
+					     ZT_SIG_CONTEXT_SIZE(1));
+			if (err)
+				return err;
+		}
+	}
+
 	return sigframe_alloc_end(user);
 }
 
@@ -821,6 +919,13 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
 		err |= preserve_za_context(za_ctx);
 	}
 
+	/* ZT state if present */
+	if (system_supports_sme2() && err == 0 && user->zt_offset) {
+		struct zt_context __user *zt_ctx =
+			apply_user_offset(user, user->zt_offset);
+		err |= preserve_zt_context(zt_ctx);
+	}
+
 	if (err == 0 && user->extra_offset) {
 		char __user *sfp = (char __user *)user->sigframe;
 		char __user *userp =
-- 
2.30.2

