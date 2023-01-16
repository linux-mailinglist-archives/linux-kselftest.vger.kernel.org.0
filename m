Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF4B66C5D1
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jan 2023 17:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbjAPQKr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Jan 2023 11:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbjAPQKE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Jan 2023 11:10:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CF62887D;
        Mon, 16 Jan 2023 08:06:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2440B60C1B;
        Mon, 16 Jan 2023 16:06:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036BBC433D2;
        Mon, 16 Jan 2023 16:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673885198;
        bh=x0bSxu+lZv8qbOgqYhBHqtr/EurSW0q/gqximsMuzRI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Rsr5PrVlZscIDY/wk7IKOGwiHanIDhAidYalUMgTf2BY9YvAsY7cj5Qt33VReKr+G
         k6OaykLotpEQumz95PGqUjQRI8qeyLGqPR5pNg1bWMx6cFwnmXE73CDBa8N+lfpD6Z
         hmPMR/TbhxrFI7jUDtIreh508y9K4SgUJcUuu2BjMa0xAwJNk/5w4vhpUUO12rc9Kk
         3KJ765Ktu0lC/Hq7/3BTwijj+usfWDdoEVYy8pZxDs67zMEDIqRZ/WEjYUMBhwEWta
         o5zdCHCCWXjPwWhxgjr3VJMYYTv4t5UkTwB6KDyIl/LCc2tgxfRV6bfRTFsCEjIMEl
         XGcuXZW96HDgA==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 16 Jan 2023 16:04:46 +0000
Subject: [PATCH v4 11/21] arm64/sme: Implement signal handling for ZT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221208-arm64-sme2-v4-11-f2fa0aef982f@kernel.org>
References: <20221208-arm64-sme2-v4-0-f2fa0aef982f@kernel.org>
In-Reply-To: <20221208-arm64-sme2-v4-0-f2fa0aef982f@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-77e06
X-Developer-Signature: v=1; a=openpgp-sha256; l=7275; i=broonie@kernel.org;
 h=from:subject:message-id; bh=x0bSxu+lZv8qbOgqYhBHqtr/EurSW0q/gqximsMuzRI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjxXWqxTGKCsn9QKUN4Kwo1+LgY+0UJw69558dR5/P
 281LPdeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY8V1qgAKCRAk1otyXVSH0KCTB/
 90bHGXsuKv8kcbWM4F3IizFY/rsn3KSOQgOWAHkOy9JjqVyXJG7frPzn2RxfH8jCHCRNxdUOB+x+HC
 jzpgunDpkgJLteoYYkeU7gsos8UKVWMROSfUwAh7h+vxQ627cXFTJMFARFoDGrLUCCzpTypHJmRUuJ
 9zo8pgF/935M9HWd7KMI+yYsqfP+znnif9rdToUfu8hSYSuwwChe0Oxrf6885YsHSb+G/J05khK+0I
 ehOmS/4YcB3NZF4UqYB6pqeoShcKOwdKT4vJGqZCgOTeIUk/rO6YSXUYCqCTMyjVHXPpUqINYof9j2
 Ld9RLF1yVAiic5QeEzVPhyWzhphXVJ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
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
 arch/arm64/include/uapi/asm/sigcontext.h |  19 ++++++
 arch/arm64/kernel/signal.c               | 105 +++++++++++++++++++++++++++++++
 3 files changed, 124 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 0ce4465644fc..67f2fb781f59 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -361,9 +361,6 @@ extern unsigned int sme_get_vl(void);
 extern int sme_set_current_vl(unsigned long arg);
 extern int sme_get_current_vl(void);
 
-/* Will move with signal support */
-#define ZT_SIG_REG_SIZE 512
-
 /*
  * Return how many bytes of memory are required to store the full SME
  * specific state for task, given task's currently configured vector
diff --git a/arch/arm64/include/uapi/asm/sigcontext.h b/arch/arm64/include/uapi/asm/sigcontext.h
index 9525041e4a14..46e9072985a5 100644
--- a/arch/arm64/include/uapi/asm/sigcontext.h
+++ b/arch/arm64/include/uapi/asm/sigcontext.h
@@ -152,6 +152,14 @@ struct za_context {
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
@@ -304,4 +312,15 @@ struct za_context {
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
index 27768809dd3e..1c5e557a3617 100644
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
@@ -221,6 +222,7 @@ struct user_ctxs {
 	struct fpsimd_context __user *fpsimd;
 	struct sve_context __user *sve;
 	struct za_context __user *za;
+	struct zt_context __user *zt;
 };
 
 #ifdef CONFIG_ARM64_SVE
@@ -447,11 +449,81 @@ static int restore_za_context(struct user_ctxs *user)
 
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
 
@@ -469,6 +541,7 @@ static int parse_user_sigframe(struct user_ctxs *user,
 	user->fpsimd = NULL;
 	user->sve = NULL;
 	user->za = NULL;
+	user->zt = NULL;
 
 	if (!IS_ALIGNED((unsigned long)base, 16))
 		goto invalid;
@@ -547,6 +620,19 @@ static int parse_user_sigframe(struct user_ctxs *user,
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
@@ -669,6 +755,9 @@ static int restore_sigframe(struct pt_regs *regs,
 	if (err == 0 && system_supports_sme() && user.za)
 		err = restore_za_context(&user);
 
+	if (err == 0 && system_supports_sme2() && user.zt)
+		err = restore_zt_context(&user);
+
 	return err;
 }
 
@@ -769,6 +858,15 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
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
 
@@ -824,6 +922,13 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
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
2.34.1

