Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2058F656BAB
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Dec 2022 15:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiL0OVa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Dec 2022 09:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbiL0OVK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Dec 2022 09:21:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5478465E8
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Dec 2022 06:21:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 064B6B80D67
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Dec 2022 14:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F00C433EF;
        Tue, 27 Dec 2022 14:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672150866;
        bh=ZCmjdtkfWzd3Gw1dWUOPCH2EpSFE/2OVt1eBFKH6lg0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=PdzYL9p4aAY4ZLT8FmsGuJBLnI2A/MafXbjT1uNxOP0FW859Faq3j55Vt6ieSIngD
         cTh9ZmWkk6MuAMvrtJrNz7V+u2tciuCsaf+AsPwnl9aJCzn9BXP8gT4zDE0KM9QCkP
         t9ep+Q3gjqbckMmPut/hadDHFZIAZus9IFXm9sJPq8PigMs0ah3guPwD5ZnJIz+FGP
         oy/yctyaL1ewBq3h1wEZE8JIgINF8ps2/KxS3iF0Vj3Xdm/lHBf2Y/kJAMozaVWOCm
         2f/z76Tsgmz9i3T6/oM10K9R2aeMizDoNquICY0DZV3qtOH9sgb2qJ5IKGR9Fndlgt
         IAttqoKP3kcbA==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 27 Dec 2022 14:20:41 +0000
Subject: [PATCH v3 2/4] arm64/signal: Include TPIDR2 in the signal context
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221208-arm64-tpidr2-sig-v3-2-c77c6c8775f4@kernel.org>
References: <20221208-arm64-tpidr2-sig-v3-0-c77c6c8775f4@kernel.org>
In-Reply-To: <20221208-arm64-tpidr2-sig-v3-0-c77c6c8775f4@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-7ab1d
X-Developer-Signature: v=1; a=openpgp-sha256; l=4944; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ZCmjdtkfWzd3Gw1dWUOPCH2EpSFE/2OVt1eBFKH6lg0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjqv9K94Knp+yBtHOZkhdbQK5Z7xR78O43gzkmR06o
 Q4v9z2eJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY6r/SgAKCRAk1otyXVSH0JheB/
 sEbsWhR2elDImp2T/Vst0jIlYeXM6GhHwTORarD5ropQoPR7p06osC0ej1IJUNRBXphC+qrIq0fdz8
 Lncl1QRqlBqWTjfdR9fWgoM3kZ9gXPCz+dVz8TiIGKSiB5HRRIt+OZz9f1zzDpTmnBqcGLuhHTbsyx
 4L0H7SABigNpLKSYe36hapuAIx7M8BT/MJAOWNtnXyGRJ9FeWXR3Q02uEoZV96I4Fu4ln5QfVkYXMl
 Ym2uKHXZYrJcoFRKbz5U25uX6F3d4einNNicHLWgW07ey5HcgGomDdBb3Y8samK7gWJURAwLlGav00
 TK25BA2dJw11xz/Mbinxp67T4ULBdd
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

Add a new signal frame record for TPIDR2 using the same format as we
already use for ESR with different magic, a header with the value from the
register appended as the only data. If SME is supported then this record is
always included.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Szabolcs Nagy <szabolcs.nagy@arm.com>
---
 arch/arm64/include/uapi/asm/sigcontext.h |  8 +++++
 arch/arm64/kernel/signal.c               | 59 ++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/arch/arm64/include/uapi/asm/sigcontext.h b/arch/arm64/include/uapi/asm/sigcontext.h
index 9525041e4a14..4b4398d7fb2d 100644
--- a/arch/arm64/include/uapi/asm/sigcontext.h
+++ b/arch/arm64/include/uapi/asm/sigcontext.h
@@ -144,6 +144,14 @@ struct sve_context {
 
 #define SVE_SIG_FLAG_SM	0x1	/* Context describes streaming mode */
 
+/* TPIDR2_EL0 context */
+#define TPIDR2_MAGIC	0x54504902
+
+struct tpidr2_context {
+	struct _aarch64_ctx head;
+	__u64 tpidr2;
+};
+
 #define ZA_MAGIC	0x54366345
 
 struct za_context {
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index e0d09bf5b01b..5fe45c7c5e4f 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -56,6 +56,7 @@ struct rt_sigframe_user_layout {
 	unsigned long fpsimd_offset;
 	unsigned long esr_offset;
 	unsigned long sve_offset;
+	unsigned long tpidr2_offset;
 	unsigned long za_offset;
 	unsigned long extra_offset;
 	unsigned long end_offset;
@@ -220,6 +221,7 @@ static int restore_fpsimd_context(struct fpsimd_context __user *ctx)
 struct user_ctxs {
 	struct fpsimd_context __user *fpsimd;
 	struct sve_context __user *sve;
+	struct tpidr2_context __user *tpidr2;
 	struct za_context __user *za;
 };
 
@@ -361,6 +363,32 @@ extern int preserve_sve_context(void __user *ctx);
 
 #ifdef CONFIG_ARM64_SME
 
+static int preserve_tpidr2_context(struct tpidr2_context __user *ctx)
+{
+	int err = 0;
+
+	current->thread.tpidr2_el0 = read_sysreg_s(SYS_TPIDR2_EL0);
+
+	__put_user_error(TPIDR2_MAGIC, &ctx->head.magic, err);
+	__put_user_error(sizeof(*ctx), &ctx->head.size, err);
+	__put_user_error(current->thread.tpidr2_el0, &ctx->tpidr2, err);
+
+	return err;
+}
+
+static int restore_tpidr2_context(struct user_ctxs *user)
+{
+	u64 tpidr2_el0;
+	int err = 0;
+
+	/* Magic and size were validated deciding to call this function */
+	__get_user_error(tpidr2_el0, &user->tpidr2->tpidr2, err);
+	if (!err)
+		current->thread.tpidr2_el0 = tpidr2_el0;
+
+	return err;
+}
+
 static int preserve_za_context(struct za_context __user *ctx)
 {
 	int err = 0;
@@ -450,6 +478,8 @@ static int restore_za_context(struct user_ctxs *user)
 #else /* ! CONFIG_ARM64_SME */
 
 /* Turn any non-optimised out attempts to use these into a link error: */
+extern int preserve_tpidr2_context(void __user *ctx);
+extern int restore_tpidr2_context(struct user_ctxs *user);
 extern int preserve_za_context(void __user *ctx);
 extern int restore_za_context(struct user_ctxs *user);
 
@@ -468,6 +498,7 @@ static int parse_user_sigframe(struct user_ctxs *user,
 
 	user->fpsimd = NULL;
 	user->sve = NULL;
+	user->tpidr2 = NULL;
 	user->za = NULL;
 
 	if (!IS_ALIGNED((unsigned long)base, 16))
@@ -534,6 +565,19 @@ static int parse_user_sigframe(struct user_ctxs *user,
 			user->sve = (struct sve_context __user *)head;
 			break;
 
+		case TPIDR2_MAGIC:
+			if (!system_supports_sme())
+				goto invalid;
+
+			if (user->tpidr2)
+				goto invalid;
+
+			if (size != sizeof(*user->tpidr2))
+				goto invalid;
+
+			user->tpidr2 = (struct tpidr2_context __user *)head;
+			break;
+
 		case ZA_MAGIC:
 			if (!system_supports_sme())
 				goto invalid;
@@ -666,6 +710,9 @@ static int restore_sigframe(struct pt_regs *regs,
 			err = restore_fpsimd_context(user.fpsimd);
 	}
 
+	if (err == 0 && system_supports_sme() && user.tpidr2)
+		err = restore_tpidr2_context(&user);
+
 	if (err == 0 && system_supports_sme() && user.za)
 		err = restore_za_context(&user);
 
@@ -760,6 +807,11 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
 		else
 			vl = task_get_sme_vl(current);
 
+		err = sigframe_alloc(user, &user->tpidr2_offset,
+				     sizeof(struct tpidr2_context));
+		if (err)
+			return err;
+
 		if (thread_za_enabled(&current->thread))
 			vq = sve_vq_from_vl(vl);
 
@@ -817,6 +869,13 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
 		err |= preserve_sve_context(sve_ctx);
 	}
 
+	/* TPIDR2 if supported */
+	if (system_supports_sme() && err == 0) {
+		struct tpidr2_context __user *tpidr2_ctx =
+			apply_user_offset(user, user->tpidr2_offset);
+		err |= preserve_tpidr2_context(tpidr2_ctx);
+	}
+
 	/* ZA state if present */
 	if (system_supports_sme() && err == 0 && user->za_offset) {
 		struct za_context __user *za_ctx =

-- 
2.30.2
