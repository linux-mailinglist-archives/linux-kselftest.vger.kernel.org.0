Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2986433D60
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Oct 2021 19:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbhJSR1G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Oct 2021 13:27:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233580AbhJSR1G (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Oct 2021 13:27:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3BB4610E5;
        Tue, 19 Oct 2021 17:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634664293;
        bh=6ezrNyY6X7TMhSUddPomE1q3fqf6OJIG2WyGCj0Ttb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JuTJXRmVMgVbSiB5zAFq12XDzjgDcSqhcvey6Lcp1yZMirv/3qOHmFbZw3SSkEtYy
         UAUCdXF4UixNQYP2R0kJiLqNfvqZ4qZPz1Til3j2LNw1tK6PVQ3PXA4Pn5ok9Vc3gL
         IuDtfmd1GriCfZ3MwseZs1GDOtr+YPBfJQwzGA+enur6ks7uNdA6mFLkniqKNuXW28
         ZL52PKR/Y/R8SNsvToxUuF8STYvi6VIUnsNrl6zKe/GTvK8pNIiT21wm8W53Tdeimu
         iUFratdZ5JVFRJlHgehCQFrODpNhf6hqbZMemKmXsNTbBAUV3dEPfz7FbWl22+8q4s
         0DEA5a8NhSeeg==
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
Subject: [PATCH v3 28/42] arm64/sme: Implement streaming SVE signal handling
Date:   Tue, 19 Oct 2021 18:22:33 +0100
Message-Id: <20211019172247.3045838-29-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211019172247.3045838-1-broonie@kernel.org>
References: <20211019172247.3045838-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6926; h=from:subject; bh=6ezrNyY6X7TMhSUddPomE1q3fqf6OJIG2WyGCj0Ttb4=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhbv7ZpnmtzABZ+ZVMLsQMlaiils4F/nlvjdVNowEZ GmNR2hqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYW7+2QAKCRAk1otyXVSH0HWGCA CCjwtNj1o8XuXdhw3qkcGAfLn6dAqP388DlHmjCeThQh/NKD1dhsRVIv2tiDlvXzpYpFoTE6cyu6MP QXDzb4Ue2jXZM+P78eCggCeo9WBrZoxXWndpwT9vYUbquepgQ+c/kruHizcItiDwUapW9gL79p8Fds vbw1FPXr5lvgIhsD/Ul8pF3VLo4XbjtDr2nPFjp5XaXQGm+2KdYujejcFp8ksnG0e3a8KIMsRoPa0Z kwIitaUvN/uQzHYaQxEVAfMfJdATdstt9zAY0t1bEO3T9WotNiQnkUZSvfILhTL4LabdRLWobJy8Cb hpDf7h3/nRvKSVCbwMH1qI/LV4k8PE
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When in streaming mode we have the same set of SVE registers as we do in
regular SVE mode with the exception of FFR and the use of the SME vector
length. Provide signal handling for these registers by taking one of the
reserved words in the SVE signal context as a flags field and defining a
flag with a flag which is set for streaming mode. When the flag is set the
vector length is set to the streaming mode vector length and we save and
restore streaming mode data. We support entering or leaving streaming mode
based on the value of the flag but do not support changing the vector
length, this is not currently supported SVE signal handling.

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
 arch/arm64/include/uapi/asm/sigcontext.h | 16 ++++++--
 arch/arm64/kernel/signal.c               | 48 ++++++++++++++++++------
 2 files changed, 50 insertions(+), 14 deletions(-)

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
index 8f6372b44b65..fea0e1d30449 100644
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
@@ -593,11 +613,16 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
 	if (system_supports_sve()) {
 		unsigned int vq = 0;
 
-		if (add_all || test_thread_flag(TIF_SVE)) {
-			int vl = sve_max_vl();
+		if (add_all || test_thread_flag(TIF_SVE) ||
+		    thread_sm_enabled(&current->thread)) {
+			int vl = max(sve_max_vl(), sme_max_vl());
 
-			if (!add_all)
-				vl = task_get_sve_vl(current);
+			if (!add_all) {
+				if (thread_sm_enabled(&current->thread))
+					vl = task_get_sme_vl(current);
+				else
+					vl = task_get_sve_vl(current);
+			}
 
 			vq = sve_vq_from_vl(vl);
 		}
@@ -648,8 +673,9 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
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

